/*
 * @Author: Outsider
 * @Date: 2022-07-10 11:52:16
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-10 16:29:07
 * @Description: RISCV 汇编指令内联汇编
 * @FilePath: /los/kernel/riscv.h
 */
#include "types.h"

#define RISCV_U  0    // 用户模式
#define RISCV_S  1    // 管理模式
#define RISCV_M  3    // 机器模式

/** 
 * @description:RV32 mstatus 寄存器 Machine Status Registers
 * 31 30~23 22 21 20  19  18  17   16~15   14~13   12~11
 * SD WPRI TSR TW TVM MXR SUM MPRV XS[1:0] FS[1:0] MPP[1:0]
 * 10~9    8   7    6   5    4    3   2    1   0
 * VS[1:0] SPP MPIE UBE SPIE WPRI MIE WPRI SIE WPRI 
 * 
 * SIE/MIE 中断使能
 * MPIE/SPIE 嵌套 trap, 保存上级SIE/MIE
 * MPP/SPP 保存 trap 前的 特权模式
 */

/**
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
    return x;
}

// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
    asm volatile("csrw mstatus, %0" : : "r" (x) );
}

/**
 * @description: 获取 mstatus 寄存器[12:11]bit
 * mstatus [12:11] 描述当前的特权模式
 * 00  -- 用户模式 U-mode
 * 01  -- 管理模式 S-mode
 * 10  -- Hypervisor H-mode
 * 11  -- 机器模式 M-mode
 */
#define XPP_MASK (3L<<11)   // 用于设置11~12bit
#define MPP_SET (3<<11)  // 11~12bit为11
#define SPP_SET (1<<11)  // 11~12bit为01

static inline uint8 a_mstatus_xpp(){
    uint32 x=r_mstatus();
    x &= XPP_MASK;
    switch (x)
    {
    case 0x1800:
        x=RISCV_M;
        break;
    case 0x0800:
        x=RISCV_S;
        break;
    case 0x0000:
        x=RISCV_U;
        break;
    default:
        break;
    }
    return x;
}

// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
    uint32 x=r_mstatus();
    switch (m)
    {
    case RISCV_U:
        x &= ~XPP_MASK;
        break;
    case RISCV_S:
        x &= ~XPP_MASK;
        x |= SPP_SET;
        break;
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
    }
    w_mstatus(x);
}