/*
 * @Author       : Outsider
 * @Date         : 2022-07-24 11:03:29
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-07-31 11:40:50
 * @Description  :
 * ***********************************
 *         初始化时钟中断参数
 * 1.每个核心都维护自己的时钟参数
 *   将参数保存到数组中，在中断处理函数中
 *   通过地址取出参数做配置
 * 2.设置时钟中断处理函数
 * 3.开启 M-mode 下的时钟中断
 * ***********************************
 * @FilePath     : /los/kernel/timer.c
 */
#include "defs.h"
#include "proc.h"
#include "clint.h"
#include "riscv.h"

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

uint64 clock_tick; // 系统时钟
struct spinlock clock_lock;

void timerinit()
{
    uint hart = r_tp();
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0] = (uint64)CLINT_MTIMECMP(hart);
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1] = (uint64)CLINT_INTERVAL;

    w_mtvec((uint32)tvec); // 设置 M-mode time trap处理函数

    // w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断

    clintinit(); // 初始化 CLINT

    w_mie(r_mie() | MTIE); // 开启 M-mode 时钟中断

    /** note
     * 这里暂不开启 M-mode 下的全局中断
     * 因为如果开启全局中断，时钟中断则有可能在 mret 前触发
     * 触发时钟中断会修改 mstatus寄存器，设置的 S-mode将被覆盖
     *
     * 在 M-mode 下不开启全局中断，在 RISCV 中低级模式下
     * 更高级的中断默认是使能的，则在跳转到 S-mode 下 M-mode
     * 全局中断默认使能
     **/
    // s_mstatus_intr(INTR_MIE); // 开启 M-mode 全局中断
    initspinlock(&clock_lock, "clock_lock");
}

// 时钟中断 -- 增加 clock_tick
void updateclock()
{
    acquirespinlock(&clock_lock);
    clock_tick++;
    wakeup(&clock_tick);
    releasespinlock(&clock_lock);
}