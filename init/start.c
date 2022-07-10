/*
 * @Author: Outsider
 * @Date: 2022-07-08 10:52:32
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-10 19:26:01
 * @Description: In User Settings Edit
 * @FilePath: /los/init/start.c
 */
#include "kernel/uart.h"
#include "kernel/riscv.h"
#include "kernel/swtch.h"

extern uint32* heapstart[]; 
extern uint32* heapend[]; 
extern void swtch(struct context*,struct context*);

void start(){
    uartinit();
    uartputs("Hello Los!\n");

    struct context old;
    struct context new;
    swtch(&old,&new);

    uint32 x=r_mstatus();   // 读取mstatus 寄存器
    s_mstatus_xpp(RISCV_S); // 设置特权模式为 S-mode
    x=r_mstatus();          
    asm volatile("mret");
    while(1);
}