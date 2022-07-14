/*
 * @Author: Outsider
 * @Date: 2022-07-08 10:52:32
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-14 14:46:48
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

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
    s_mstatus_intr(INTR_MPIE);  // S-mode 开全局中断
    s_sstatus_intr(INTR_SIE);   // S-mode
    w_stvec((uint32)kvec);      // 设置S-mode trap处理函数

    w_mepc((uint32)main);   // 设置 mepc 为 main 地址
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");   // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
}