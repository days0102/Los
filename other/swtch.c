/*
 * @Author: Outsider
 * @Date: 2022-07-10 20:54:23
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-13 18:48:00
 * @Description: 上下文切换
 * @FilePath: /los/kernel/swtch.c
 */

#include "defs.h"

void swtch(struct context* old,struct context* new){
    // 将当前context 保存到 old context 中
    asm volatile("addi	sp,sp,32");
    asm volatile("sw ra,0(a0)");
    asm volatile("sw sp,4(a0)");
    asm volatile("sw gp,8(a0)");
    asm volatile("sw tp,12(a0)");
    asm volatile("sw a0,16(a0)");
    asm volatile("sw a1,20(a0)");
    asm volatile("sw a2,24(a0)");
    asm volatile("sw a3,28(a0)");
    asm volatile("sw a4,32(a0)");
    asm volatile("sw a5,36(a0)");
    asm volatile("sw a6,40(a0)");
    asm volatile("sw a7,44(a0)");
    asm volatile("sw s0,48(a0)");
    asm volatile("sw s1,52(a0)");
    asm volatile("sw s2,56(a0)");
    asm volatile("sw s3,60(a0)");
    asm volatile("sw s4,64(a0)");
    asm volatile("sw s5,68(a0)");
    asm volatile("sw s6,72(a0)");
    asm volatile("sw s7,76(a0)");
    asm volatile("sw s8,80(a0)");
    asm volatile("sw s9,84(a0)");
    asm volatile("sw s10,88(a0)");
    asm volatile("sw s11,92(a0)");
    asm volatile("sw t0,96(a0)");
    asm volatile("sw t1,100(a0)");
    asm volatile("sw t2,104(a0)");
    asm volatile("sw t3,108(a0)");
    asm volatile("sw t4,112(a0)");
    asm volatile("sw t5,116(a0)");
    asm volatile("sw t6,120(a0)");

    // 将 new context 加载到寄存器中
    // asm volatile("lw ra,0(a1)");
    // asm volatile("lw sp,4(a1)");
    asm volatile("lw gp,8(a1)");
    asm volatile("lw tp,12(a1)");
    asm volatile("lw a0,16(a1)");
    // asm volatile("lw a1,20(a1)");
    asm volatile("lw a2,24(a1)");
    asm volatile("lw a3,28(a1)");
    asm volatile("lw a4,32(a1)");
    asm volatile("lw a5,36(a1)");
    asm volatile("lw a6,40(a1)");
    asm volatile("lw a7,44(a1)");
    asm volatile("lw s0,48(a1)");
    asm volatile("lw s1,52(a1)");
    asm volatile("lw s2,56(a1)");
    asm volatile("lw s3,60(a1)");
    asm volatile("lw s4,64(a1)");
    asm volatile("lw s5,68(a1)");
    asm volatile("lw s6,72(a1)");
    asm volatile("lw s7,76(a1)");
    asm volatile("lw s8,80(a1)");
    asm volatile("lw s9,84(a1)");
    asm volatile("lw s10,88(a1)");
    asm volatile("lw s11,92(a1)");
    asm volatile("lw t0,96(a1)");
    asm volatile("lw t1,100(a1)");
    asm volatile("lw t2,104(a1)");
    asm volatile("lw t3,108(a1)");
    asm volatile("lw t4,112(a1)");
    asm volatile("lw t5,116(a1)");
    asm volatile("lw t6,120(a1)");
    
}