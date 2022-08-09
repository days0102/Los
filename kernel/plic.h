/*
 * @Author: Outsider
 * @Date: 2022-07-14 14:49:02
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-09 14:46:41
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/plic.h
 */

#define PLIC_BASE 0xc000000

// 设置某一路中断源的优先级,中断源 id = [1:53]
#define PLIC_PRIORITY(id) (PLIC_BASE + (id)*4)

// 包含 2 个 32 位的 Pending 寄存器，每一个 bit 对应
// 一个中断源，如果为 1 表示该中断源上发生了中断 0xc001000~0xc001008
#define PLIC_PENDING (PLIC_BASE + 0x1000)

// M-mode 和 S-mode 2 个 Enable 寄存器
// 用于针对该 Hart 启动或者关闭某路中断源。
#define PLIC_MENABLE(hart) (PLIC_BASE + 0x2000 + (hart)*0x100)
#define PLIC_SENABLE(hart) (PLIC_BASE + 0x2080 + (hart)*0x100)

// 每个 Hart 的寄存器用于设置中断优先级的阈值。
// 所有小于或者等于（<=）该阈值的中断源即使发生了也会
// 被 PLIC 丢弃。特别地，当阈值为 0 时允许所有中断源上发
// 生的中断；当阈值为 7 时丢弃所有中断源上发生的中断。
#define PLIC_MPRIORITY(hart) (PLIC_BASE + 0x200000 + (hart)*0x2000)
#define PLIC_SPRIORITY(hart) (PLIC_BASE + 0x201000 + (hart)*0x2000)

// 读(CLAIM)：获取当前发生的最高优先级的中断源 ID。Claim 成功后会清除对应的 Pending 位。
// 写(COMPLETE)：通知 PLIC 对该路中断的处理已经结束。
#define PLIC_MCLAIM(hart) (PLIC_BASE + 0x200004 + (hart)*0x2000)
#define PLIC_SCLAIM(hart) (PLIC_BASE + 0x201004 + (hart)*0x2000)
#define PLIC_MCOMPLETE(hart) (PLIC_BASE + 0x200004 + (hart)*0x2000)
#define PLIC_SCOMPLETE(hart) (PLIC_BASE + 0x201004 + (hart)*0x2000)

#define UART_IRQ 10 // uart中断源