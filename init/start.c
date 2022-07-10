/*
 * @Author: Outsider
 * @Date: 2022-07-08 10:52:32
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-10 23:14:37
 * @Description: In User Settings Edit
 * @FilePath: /los/init/start.c
 */
#include "kernel/uart.h"
#include "kernel/riscv.h"

extern uint32* heapstart[]; 
extern uint32* heapend[]; 
extern void main();

void start(){
    uartinit();

    uartputs("Hello Los!\n");

    uint32 x=r_mstatus();   // 读取mstatus 寄存器
    s_mstatus_xpp(RISCV_S); // 设置特权模式为 S-mode

    w_mepc((uint32)main);    
    asm volatile("mret");   // 改变特权级，跳转至 mepc 寄存器地址处
}