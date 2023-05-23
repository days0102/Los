/*
 * @Author       : Outsider
 * @Date         : 2022-07-08 10:52:32
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-05-23 20:05:58
 * @Description  : In User Settings Edit
 * @FilePath     : /los/initos/start.c
 */
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main(); // 定义在main.c

void start()
{
    // uartinit();
    // uartputs("Hello Los!\n");
    w_satp((uint32)0); // 暂时禁用分页

    w_mideleg((uint32)0xffff); // 16项中断委托给S-mode
    w_medeleg((uint32)0xffff); // 16项异常委托给S-mode
    w_sie(r_sie() | SEIE | STIE | SSIE);

    // s_sstatus_intr(~INTR_SIE); // S-mode 开全局中断

    w_stvec((uint32)kvec); // 设置 S-mode trap处理函数

    w_pmpaddr0(0xffffffff); // 物理内存保护
    w_pmpcfg0(0xf);

    w_mepc((uint32)main); // 设置 mepc 为 main 地址

    timerinit(); // 时钟定时器

    s_mstatus_xpp(RISCV_S); // 设置特权模式为 S-mode
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret"); // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
}