/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:39:43
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-06 16:39:48
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

void ptf(struct trapframe *tf, int hart)
{
    if (r_tp() != hart)
        return;
    printf("kernel_sp: %p \n", tf->kernel_sp);
    printf("kernel_satp: %p \n", tf->kernel_satp);
    printf("kernel_tvec: %p \n", tf->kernel_tvec);

    printf("ra: %p \n", tf->ra);
    printf("sp: %p \n", tf->sp);
    printf("tp: %p \n", tf->tp);
    printf("t0: %p \n", tf->t0);
    printf("t1: %p \n", tf->t1);
    printf("t2: %p \n", tf->t2);
    printf("t3: %p \n", tf->t3);
    printf("t4: %p \n", tf->t4);
    printf("t5: %p \n", tf->t5);
    printf("t6: %p \n", tf->t6);
    printf("a0: %p \n", tf->a0);
    printf("a1: %p \n", tf->a1);
    printf("a2: %p \n", tf->a2);
    printf("a3: %p \n", tf->a3);
    printf("a4: %p \n", tf->a4);
    printf("a5: %p \n", tf->a5);
    printf("a6: %p \n", tf->a6);
    printf("a7: %p \n", tf->a7);
}

// 返回用户空间
void usertrapret()
{
    struct pcb *p = nowproc();
    /* 关闭中断, 保证顺利返回用户态
       U模式下S模式默认中断使能
    */
    s_sstatus_intr(~INTR_SIE);
    s_sstatus_xpp(RISCV_U);
    s_sstatus_intr(INTR_SPIE); // 用户态中断使能，sret->SIE=SPIE
    w_stvec((uint32)usertrap);
    addr_t satp = (SATP_SV32 | (addr_t)(p->pagetable) >> 12);
    // ptf(p->trapframe, 1);

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
void forkret()
{
    struct pcb *p = nowproc();
    releasespinlock(&p->spinlock);
    if (initfirst == 0)
        initfirst = 1;
    // fsinit();
    usertrapret();
}

void timerintr()
{
    w_sip(r_sip() & ~2); // 清除中断
    if (r_tp() == 0)
    {
        updateclock(); // 更新时钟
    }
    struct pcb *p = nowproc();
    if (p != 0 && p->status == RUNNING)
    {
        yield();
    }
}

void trapvec()
{
    int where = r_sstatus() & S_SPP_SET;
    struct pcb *p = nowproc();
    /** 记录 sepc 和 sstatus
     *  如果 trap 来自内核态处理 trap 时可能会改变 sepc 和 sstatus (yield)
     * */
    uint sepc = r_sepc();
    uint status = r_sstatus();
    /**
     *  Only traps from user mode save the sepc.
     *  Otherwise, the sepc of the process will be
     *  set to the pc of the kernel, resulting in an error.
     **/
    if (!where && p)
        p->trapframe->epc = r_sepc();
    w_stvec((reg_t)kvec);

#ifdef DEBUG
    printf("trap intrrupt enable: %d\n", a_sstatus_intr(INTR_SIE));
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
        where ? w_sepc(sepc), w_sstatus(status) : usertrapret();
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
            printf("sepc: %p, hart:%d\n", r_sepc(), r_tp());
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
            printf("stval va: %p, sepc: %p, hart:%d\n", r_stval(), r_sepc(), r_tp());
            break;
        case 6:
            printf("Exception : Store/AMO address misaligned\n");
            break;
        case 7:
            printf("Exception : Store/AMO access fault\n");
            // ex : *(int *)0x00000000 = 100;
            printf("stval va: %p, sepc: %p, hart:%d\n", r_stval(), r_sepc(), r_tp());
            break;
        case 8: // 来自 U-mode 的系统调用
            // printf("Environment call from U-mode\n");
            syscall();
            usertrapret();
            break;
        case 9: // 来自 S-mode 的系统调用
            printf("Exception : Environment call from S-mode\n");
            initfirst ? usertrapret() : forkret();
            break;
        case 12:
            printf("Exception : Instruction page fault\n");
            printf("stval va: %p, sepc: %p, hart:%d\n", r_stval(), r_sepc(), r_tp());
            break;
        case 13:
            printf("Exception : Load page fault\n");
            printf("stval va: %p, sepc: %p, hart:%d\n", r_stval(), r_sepc(), r_tp());
            break;
        case 15:
            printf("Exception : Store/AMO page fault\n");
            printf("stval va: %p, sepc: %p, hart:%d\n", r_stval(), r_sepc(), r_tp());
            break;
        default:
            printf("Exception : Other\n");
            break;
        }
        panic("Trap Exception");
    }
}
