/*
 * @Author: Outsider
 * @Date: 2022-07-23 07:49:10
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-20 08:21:17
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/clint.h
 */
#define CLINT_BASE 0x2000000

// msip 寄存器高 31 位为 0，低位反映 mip 寄存器
#define CLINT_MSIP(hart) (CLINT_BASE + 4 * (hart))

// mtime 大于等于 mtimecmp 会触发时钟中断
// mtime 上电会重置, mtimecmp 不会重置
#define CLINT_MTIMECMP(hart) (CLINT_BASE + 0x4000 + 8 * (hart)) // 每个寄存器8

// mtime 寄存器
#define CLINT_MTIME (CLINT_BASE + 0xbff8)

// 中断间隔
#define CLINT_INTERVAL 1000000