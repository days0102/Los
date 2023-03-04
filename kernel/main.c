/*
 * @Author       : Outsider
 * @Date         : 2022-07-10 22:25:45
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-03-03 16:06:59
 * @Description  : In User Settings Edit
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
        cpuinit();
        uartinit();
        printinit();
        // r_sstatus();
        uartputs("Hello Los!\n");

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
        kvmstart();
        plicinit();
    }
    printf("start %d hart\n", r_tp());

    schedule();
}
