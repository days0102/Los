/*
 * @Author: Outsider
 * @Date: 2022-07-14 15:33:00
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-01 18:38:30
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/plic.c
 */
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit()
{
    *(uint32 *)PLIC_PRIORITY(UART_IRQ) = 1;   // uart 设置优先级(1~7)，0为关中断
    *(uint32 *)PLIC_PRIORITY(VIRTIO_IRQ) = 1; // virtio 设置优先级(1~7)，0为关中断

    *(uint32 *)PLIC_SENABLE(r_tp()) = (1 << UART_IRQ) | (1 << VIRTIO_IRQ); // uart, virtio 开中断
    // *(uint32 *)PLIC_MENABLE(r_tp()) = (1 << UART_IRQ) | (1 << VIRTIO_IRQ); // uart, virtio d开中断

    // 设置优先级阈值(忽略小于阈值的中断)
    // *(uint32 *)PLIC_MPRIORITY(r_tp()) = 0;
    *(uint32 *)PLIC_SPRIORITY(r_tp()) = 0;

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开S-mode中断
}

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim()
{
    return *(uint32 *)PLIC_SCLAIM(r_tp());
}
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq)
{
    // *(uint32 *)PLIC_MCOMPLETE(r_tp()) = irq;
    *(uint32 *)PLIC_SCOMPLETE(r_tp()) = irq;
}