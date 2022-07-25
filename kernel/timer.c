/*
 * @Author: Outsider
 * @Date: 2022-07-24 11:03:29
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-25 11:34:49
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/timer.c
 */
#include "defs.h"
#include "proc.h"
#include "clint.h"
#include "riscv.h"

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit(){
    uint hart=r_tp();
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断

    w_mie(r_mie() | MTIE );      // 开启 M-mode 时钟中断

    clintinit();                
}