/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:39:43
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-06 18:37:22
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
    printf("irq : %d\n", irq);
    switch (irq)
    {
    case UART_IRQ: // uart 中断(键盘输入)
        printf("recived : %c\n", uartintr());
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
    w_stvec((uint32)usertrap);
    addr_t satp = (SATP_SV32 | (addr_t)(p->pagetable) >> 12);
    // ptf(p->trapframe);

    // printf("%p\n",p->trapframe);
    // printf("sepc: %p\n",r_sepc());

    w_sepc((addr_t)p->trapframe->epc);

    p->trapframe->kernel_satp = r_satp();
    p->trapframe->kernel_tvec = (addr_t)trapvec;
    p->trapframe->kernel_sp = (addr_t)p->kernelstack;

    // printf("%p\n",p->kernelstack);
    userret((addr_t *)TRAPFRAME, satp);
}

static int first = 0;
void startproc()
{
    first = 1;
    usertrapret();
}

void timerintr()
{
    w_sip(r_sip() & ~2); // 清除中断
    yield();
}

void trapvec()
{
    int where = r_sstatus() & S_SPP_SET;
    w_stvec((reg_t)kvec);

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
            printf("Supervisor external interrupt\n");
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
        printf("Exception : ");
        switch (code)
        {
        case 0:
            printf("Instruction address misaligned\n");
            break;
        case 1:
            printf("Instruction access fault\n");
            break;
        case 2:
            printf("Illegal instruction\n");
            break;
        case 3:
            printf("Breakpoint\n");
            break;
        case 4:
            printf("Load address misaligned\n");
            break;
        case 5:
            printf("Load access fault\n");
            // ex : int a = *(int *)0x00000000;
            printf("stval va: %p\n", r_stval());
            break;
        case 6:
            printf("Store/AMO address misaligned\n");
            break;
        case 7:
            printf("Store/AMO access fault\n");
            // ex : *(int *)0x00000000 = 100;
            printf("stval va: %p\n", r_stval());
            break;
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
            syscall();
            usertrapret();
            break;
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
            first ? usertrapret() : startproc();
            break;
        case 12:
            printf("Instruction page fault\n");
            printf("stval va: %p\n", r_stval());
            break;
        case 13:
            printf("Load page fault\n");
            break;
        case 15:
            printf("Store/AMO page fault\n");
            break;
        default:
            printf("Other\n");
            break;
        }
        panic("Trap Exception");
    }
}
