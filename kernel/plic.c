/*
 * @Author: Outsider
 * @Date: 2022-07-14 15:33:00
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-14 16:18:02
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/plic.c
 */
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断

    *(uint32*)PLIC_SENABLE(r_tp())= (1<<UART_IRQ);  // uart 开中断

    w_sie(r_sie()|SSIE|STIE|SEIE);
}