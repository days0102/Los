/*
 * @Author       : Outsider
 * @Date         : 2022-07-23 07:49:10
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-08-01 10:12:53
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/clint.h
 */
#define CLINT_BASE 0x2000000

// msip 寄存器高 31 位为 0，低位反映 mip 寄存器
#define CLINT_MSIP(hart) (CLINT_BASE + 4 * (hart))

// mtime 大于等于 mtimecmp 会触发时钟中断
// mtime 上电会重置, mtimecmp 不会重置
#define CLINT_MTIMECMP(hart) (CLINT_BASE + 0x4000 + 8 * (hart)) // 每个寄存器8

// mtime 寄存器
#define CLINT_MTIME (CLINT_BASE + 0xbff8)

/** fixed [bug] (too small can't boot)
 *  因为再 timeinit()中初始化时钟中断配置时
 *  开启了全局中断使能，在没有跳转到 main()前
 *  多次触发时钟中断进入 M-mode，会覆盖掉之前
 *  设置的 MPP S-mode，使得跳转到 main()中
 *  的特权模式出错，在设置和访问 csr 时出现
 *  Illegal instruction(非法指令)
 **/
#define CLINT_INTERVAL 1000000 // 中断间隔