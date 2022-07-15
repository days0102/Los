/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:39:43
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-15 11:12:40
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/trap.c
 */
#include "defs.h"
#include "riscv.h"
#include "plic.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
    uint32 irq=r_plicclaim();
    printf("irq : %d\n",irq);
    switch (irq)
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
        break;
    default:
        break;
    }
    w_pliccomplete(irq);
}

void trapvec(){
    uint32 scause=r_scause();

    uint16 code= scause & 0xffff;

    if(scause & (1<<31)){
        printf("Interrupt : ");
        switch (code)
        {
        case 1:
            printf("Supervisor software interrupt\n");
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
    }else{
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
            break;
        case 6:
            printf("Store/AMO address misaligned\n");
            break;
        case 7:
            printf("Store/AMO access fault\n");
            // ex : *(int *)0x00000000 = 100;
            break;
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
            break;
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
            break;
        case 12:
            printf("Instruction page fault\n");
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
