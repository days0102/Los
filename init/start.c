/*
 * @Author: Outsider
 * @Date: 2022-07-08 10:52:32
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-13 20:29:37
 * @Description: In User Settings Edit
 * @FilePath: /los/init/start.c
 */
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();

void start(){
    uartinit();
    uartputs("Hello Los!\n");

    s_mstatus_xpp(RISCV_S); // 设置特权模式为 S-mode

    w_satp((uint32)0);      // 暂时禁用分页

    // w_mtvec((uint32)tvec);  // 设置 trap 向量地址
    w_stvec((uint32)kvec);
    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode

    w_mepc((uint32)main);   // 设置 mepc 为 main 地址
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");   // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
}