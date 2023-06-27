/*
 * @Author       : Outsider
 * @Date         : 2022-07-10 22:25:45
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-05-26 14:57:11
 * @Description  : 
 * ***********************************
 *          初始化内核
 * 1.由0号核心初始化共享的设备和资源
 * 2.每个核心初始化后进入调度器
 * ***********************************
 * @FilePath     : /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

static int start = 1;

void main()
{
    if (r_tp() == 0)
    {
        w_stvec((uint32)kvec);               // 设置 S-mode trap处理函数
        s_sstatus_intr(INTR_SIE);
        w_sie(r_sie() | SSIE | STIE | SEIE); // 开S-mode中断

        cpuinit();
        uartinit();
        printinit();
        // r_sstatus();
        // uartputs("!!!!\n");
        // uartputs("Hello Los!\n");
        printf("Hello Los!\n");

        printf("start run main()\n");

        minit();    // 物理内存管理
        plicinit(); // PLIC 中断处理

        kvminit(); // 启动虚拟内存
        kvmstart();

#ifdef DEBUG
        printf("usertrap: %p\n", usertrap);
#endif
        pciinit();

        procinit();

        mmioinit();

        bufinit();

        fsinit();

        userinit();

        __sync_synchronize();
        start = 0;
    }
    else
    {
        while (start)
            ;
        w_stvec((reg_t)kvec);
        s_sstatus_intr(INTR_SIE);
        w_sie(r_sie() | SSIE | STIE | SEIE); // 开S-mode中断
        kvmstart();
        plicinit();
    }
    printf("start %d hart\n", r_tp());

    schedule();
}
