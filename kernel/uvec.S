
# .section traptext

.global uservec
uservec:

.global usertrap
usertrap:
    // sscratch 指向 trapframe
    csrrw a0,sscratch,a0

    // 保存用户态寄存器
    sw ra,16(a0)
    sw sp,20(a0)
    sw gp,24(a0)
    sw tp,28(a0)
    sw a0,32(a0)
    sw a1,36(a0)
    sw a2,40(a0)
    sw a3,44(a0)
    sw a4,48(a0)
    sw a5,52(a0)
    sw a6,56(a0)
    sw a5,52(a0)
    sw a7,60(a0)
    sw s0,64(a0)
    sw s1,68(a0)
    sw s2,72(a0)
    sw s3,76(a0)
    sw s4,80(a0)
    sw s5,84(a0)
    sw s6,88(a0)
    sw s7,92(a0)
    sw s8,96(a0)
    sw s9,100(a0)
    sw s10,104(a0)
    sw s11,108(a0)
    sw t0,112(a0)
    sw t1,116(a0)
    sw t2,120(a0)
    sw t3,124(a0)
    sw t4,128(a0)
    sw t5,132(a0)
    sw t6,136(a0)

    lw sp,8(a0)    // 内核栈

    lw t6,0(a0)    // 内核页表
    csrw satp,t6
    sfence.vma zero,zero

    call trapvec    // 处理 trap 

.global userret
// userret( trapframe,satp )
userret:
    // 修改页表
    csrw satp,a1
    sfence.vma zero, zero

    lw t0,32(a0)        // sscratch 暂存用户态 a0
    csrrw t0,sscratch,t0

    // 加载用户态寄存器
    lw ra,16(a0)
    lw sp,20(a0)
    lw gp,24(a0)
    lw tp,28(a0)

    lw a1,36(a0)
    lw a2,40(a0)
    lw a3,44(a0)
    lw a4,48(a0)
    lw a5,52(a0)
    lw a6,56(a0)
    lw a5,52(a0)
    lw a7,60(a0)
    
    lw s0,64(a0)
    lw s1,68(a0)
    lw s2,72(a0)
    lw s3,76(a0)
    lw s4,80(a0)
    lw s5,84(a0)
    lw s6,88(a0)
    lw s7,92(a0)
    lw s8,96(a0)
    lw s9,100(a0)
    lw s10,104(a0)
    lw s11,108(a0)

    lw t0,112(a0)
    lw t1,116(a0)
    lw t2,120(a0)
    lw t3,124(a0)
    lw t4,128(a0)
    lw t5,132(a0)
    lw t6,136(a0)

    csrrw a0,sscratch,a0

    // 返回用户态
    sret