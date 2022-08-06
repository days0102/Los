.equ harts,8        # hart 数量
.equ sz,4096        # 每个 hart 的栈大小

.global _start      # 入口地址
.section .text
_start:
    # CSR 指令

    # csrrw 读写 CSR 寄存器 csrrw rd,csr,rs; 将csr值(0扩展)写入rd,再将rs写入csr
    # 例：csrrw t6,mscratch,t6
    # 伪指令 csrw csr,rd ;

    # csrrs 读取并设置 CSR 寄存器 csrrs rd,csr,rs;
    # 伪指令 csrr rd,csr ;

    # mhartid 寄存器存放hart的id(只读寄存器)
    csrr t0,mhartid     # 读 mhartid 寄存器
    mv tp,t0            # 保存为线程id
    # bnez t0,empty       # 不为0则空转，只使用一个hart

    # 初始化栈
    addi t0,t0,1
    la sp,stacks
    li t1,sz
    mul t1,t1,t0
    add sp,sp,t1 # 栈指针指向栈顶
    
    # 跳转到start()
    j start

empty:
    wfi       # 休眠指令 wait for interrupt 直至收到中断
    j empty

.section .data  // 将栈放到可读写数据区
.global stacks
# .balign 4096 # n字节对齐
stacks:
    .skip sz*harts  # 分配栈空间 (.space)
    .end