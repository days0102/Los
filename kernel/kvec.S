#include "clint.h"

.global kvec
kvec:
    // 利用栈空间保存寄存器状态
    addi sp,sp,-128
    sw ra,0(sp)
    sw sp,4(sp)
    sw gp,8(sp)
    sw tp,12(sp)
    sw a0,16(sp)
    sw a1,20(sp)
    sw a2,24(sp)
    sw a3,28(sp)
    sw a4,32(sp)
    sw a5,36(sp)
    sw a6,40(sp)
    sw a7,44(sp)
    sw s0,48(sp)
    sw s1,52(sp)
    sw s2,56(sp)
    sw s3,60(sp)
    sw s4,64(sp)
    sw s5,68(sp)
    sw s6,72(sp)
    sw s7,76(sp)
    sw s8,80(sp)
    sw s9,84(sp)
    sw s10,88(sp)
    sw s11,92(sp)
    sw t0,96(sp)
    sw t1,100(sp)
    sw t2,104(sp)
    sw t3,108(sp)
    sw t4,112(sp)
    sw t5,116(sp)
    sw t6,120(sp)

    call trapvec

    // 恢复寄存器状态
    lw ra,0(sp)
    lw sp,4(sp)
    lw gp,8(sp)
    lw tp,12(sp)
    lw a0,16(sp)
    lw a1,20(sp)
    lw a2,24(sp)
    lw a3,28(sp)
    lw a4,32(sp)
    lw a5,36(sp)
    lw a6,40(sp)
    lw a7,44(sp)
    lw s0,48(sp)
    lw s1,52(sp)
    lw s2,56(sp)
    lw s3,60(sp)
    lw s4,64(sp)
    lw s5,68(sp)
    lw s6,72(sp)
    lw s7,76(sp)
    lw s8,80(sp)
    lw s9,84(sp)
    lw s10,88(sp)
    lw s11,92(sp)
    lw t0,96(sp)
    lw t1,100(sp)
    lw t2,104(sp)
    lw t3,108(sp)
    lw t4,112(sp)
    lw t5,116(sp)
    lw t6,120(sp)

    addi sp,sp,128
    
    sret

.global tvec
tvec:     // 时钟中断处理
    // timerinit()将mscratch指向time_scartch
    csrrw a0,mscratch,a0   
    // 后面要使用 t1,t1,t3,t4,t5 ,先保存
    sw t0,4*4(a0)
    sw t1,5*4(a0)
    sw t2,6*4(a0)
    sw t3,7*4(a0)
    sw t4,8*4(a0)
    sw t5,9*4(a0)

    lw t0,0(a0)     // CLINT_MTIMECMP(hart)
    lw t1,8(a0)     // CLINT_INTERVAL 10000000
    // CLINT_MTIMECMP 8byte 用两个寄存器存
    lw t2,0(t0)     // *CLINT_MTIMECMP(hart) 0~3byte
    lw t3,4(t0)     // *CLINT_MTIMECMP(hart) 4~7byte

    add t4,t2,t1    // 低位相加
    sltu t5,t4,t2   // 处理进位，t4小于t2则t5为1
    add t3,t3,t5    // 高位加进位
    mv t2,t4        // t2=t2+t1

    sw t2,0(t0)
    sw t3,4(t0)

    // 产生一个 S-mode 软件中断
    // mret 时触发 S-mode 软件中断
    csrwi sip,2

    // 恢复寄存器状态
    lw t0,4*4(a0)
    lw t1,5*4(a0)
    lw t2,6*4(a0)
    lw t3,7*4(a0)
    lw t4,8*4(a0)
    lw t5,9*4(a0)

    csrrw a0,mscratch,a0

    mret