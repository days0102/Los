.equ harts,8        # hart 数量
.equ ssize,4096    # 每个 hart 的栈大小

.global _start
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
    addi t0,t0,1
    # bnez t0,empty       # 不为0则空转，只使用一个hart

    # 初始化栈
    li t1,ssize
    mul t1,t1,t0
    la sp,stacks+ssize # 栈指针指向栈底
    
    # 跳转到start()
    j start

empty:
    wfi       # 休眠指令 wait for interrupt 直至收到中断
    j empty

.global stacks
stacks:
    .skip ssize*harts  # 分配栈空间
    .end