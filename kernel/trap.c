/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:39:43
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-25 19:45:45
 * @Description: trap handle
 * @FilePath: /los/kernel/trap.c
 */
#include "defs.h"
#include "riscv.h"
#include "plic.h"
#include "proc.h"
#include "clint.h"
#include "vm.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt()
{
    uint32 irq = r_plicclaim();
    // printf("irq : %d\n", irq);
    switch (irq)
    {
    case UART_IRQ: // uart 中断(键盘输入)
        consoleintr(uartintr());
        break;
    case VIRTIO_IRQ:
        // printf("virtio interrupt\n");
        diskintr();
        break;
    default:
        break;
    }
    w_pliccomplete(irq);
}

void ptf(struct trapframe *tf)
{
    printf("kernel_sp: %d \n", tf->kernel_sp);
    printf("kernel_satp: %d \n", tf->kernel_satp);
    printf("kernel_tvec: %d \n", tf->kernel_tvec);

    printf("ra: %d \n", tf->ra);
    printf("sp: %d \n", tf->sp);
    printf("tp: %d \n", tf->tp);
    printf("t0: %d \n", tf->t0);
    printf("t1: %d \n", tf->t1);
    printf("t2: %d \n", tf->t2);
    printf("t3: %d \n", tf->t3);
    printf("t4: %d \n", tf->t4);
    printf("t5: %d \n", tf->t5);
    printf("t6: %d \n", tf->t6);
    printf("a0: %d \n", tf->a0);
    printf("a1: %d \n", tf->a1);
    printf("a2: %d \n", tf->a2);
    printf("a3: %d \n", tf->a3);
    printf("a4: %d \n", tf->a4);
    printf("a5: %d \n", tf->a5);
    printf("a6: %d \n", tf->a6);
    printf("a7: %d \n", tf->a7);
}

// 返回用户空间
void usertrapret()
{
    struct pcb *p = nowproc();
    s_sstatus_xpp(RISCV_U);
    s_sstatus_intr(INTR_SPIE);
    w_stvec((uint32)usertrap);
    addr_t satp = (SATP_SV32 | (addr_t)(p->pagetable) >> 12);
    // ptf(p->trapframe);

    // printf("%p\n",p->trapframe);
    // printf("sepc: %p\n",r_sepc());

    w_sepc((addr_t)p->trapframe->epc);

    p->trapframe->kernel_satp = r_satp();
    p->trapframe->kernel_tvec = (addr_t)trapvec;
    p->trapframe->kernel_sp = (addr_t)p->kernelstack;

    // printpgt(p->pagetable);
    // printf("%p\n",p->kernelstack);
    userret((addr_t *)TRAPFRAME, satp);
}

static int initfirst = 0;
void startproc()
{
    initfirst = 1;
    // fsinit();
    usertrapret();
}

void timerintr()
{
    w_sip(r_sip() & ~2); // 清除中断
    struct pcb *p = nowproc();
    if (p != 0 && p->status == RUNNING)
        yield();
}

void trapvec()
{
    int where = r_sstatus() & S_SPP_SET;
    struct pcb *p = nowproc();
    if (!where && p)
        p->trapframe->epc = r_sepc();
    w_stvec((reg_t)kvec);

#ifdef DEBUG
    printf("trap intr %d\n", a_sstatus_intr(INTR_SIE));
#endif
    // s_sstatus_intr(INTR_SIE);

    uint32 scause = r_scause();

    uint16 code = scause & 0xffff;

    if (scause & (1 << 31))
    {
        //     printf("Interrupt : ");
        switch (code)
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
            break;
        case 5:
            printf("Supervisor timer interrupt\n");
            break;
        case 9:
            // printf("Supervisor external interrupt\n");
            externinterrupt();
            break;
        default:
            printf("Other interrupt\n");
            break;
        }
        where ?: usertrapret();
    }
    else
    {
        // printf("Exception : ");
        switch (code)
        {
        case 0:
            printf("Exception : Instruction address misaligned\n");
            break;
        case 1:
            printf("Exception : Instruction access fault\n");
            break;
        case 2:
            printf("Exception : Illegal instruction\n");
            break;
        case 3:
            printf("Exception : Breakpoint\n");
            break;
        case 4:
            printf("Exception : Load address misaligned\n");
            break;
        case 5:
            printf("Exception : Load access fault\n");
            // ex : int a = *(int *)0x00000000;
            printf("stval va: %p\n", r_stval());
            break;
        case 6:
            printf("Exception : Store/AMO address misaligned\n");
            break;
        case 7:
            printf("Exception : Store/AMO access fault\n");
            // ex : *(int *)0x00000000 = 100;
            printf("stval va: %p\n", r_stval());
            break;
        case 8: // 来自 U-mode 的系统调用
            // printf("Environment call from U-mode\n");
            syscall();
            usertrapret();
            break;
        case 9: // 来自 S-mode 的系统调用
            printf("Exception : Environment call from S-mode\n");
            initfirst ? usertrapret() : startproc();
            break;
        case 12:
            printf("Exception : Instruction page fault\n");
            printf("stval va: %p\n", r_stval());
            break;
        case 13:
            printf("Exception : Load page fault\n");
            printf("stval va: %p\n", r_stval());
            break;
        case 15:
            printf("Exception : Store/AMO page fault\n");
            printf("stval va: %p\n", r_stval());
            break;
        default:
            printf("Exception : Other\n");
            break;
        }
        panic("Trap Exception");
    }
}
