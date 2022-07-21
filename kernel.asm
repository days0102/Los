
kernel.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <_start>:

    # csrrs 读取并设置 CSR 寄存器 csrrs rd,csr,rs;
    # 伪指令 csrr rd,csr ;

    # mhartid 寄存器存放hart的id(只读寄存器)
    csrr t0,mhartid     # 读 mhartid 寄存器
80000000:	f14022f3          	csrr	t0,mhartid
    mv tp,t0            # 保存为线程id
80000004:	00028213          	mv	tp,t0
    # bnez t0,empty       # 不为0则空转，只使用一个hart

    # 初始化栈
    addi t0,t0,1
80000008:	00128293          	addi	t0,t0,1
    la sp,stacks
8000000c:	00003117          	auipc	sp,0x3
80000010:	ff810113          	addi	sp,sp,-8 # 80003004 <stacks>
    li t1,sz
80000014:	00001337          	lui	t1,0x1
    mul t1,t1,t0
80000018:	02530333          	mul	t1,t1,t0
    add sp,sp,t1 # 栈指针指向栈顶
8000001c:	00610133          	add	sp,sp,t1
    
    # 跳转到start()
    j start
80000020:	5080006f          	j	80000528 <start>

80000024 <empty>:

empty:
    wfi       # 休眠指令 wait for interrupt 直至收到中断
80000024:	10500073          	wfi
    j empty
80000028:	ffdff06f          	j	80000024 <empty>

8000002c <kvec>:
.global kvec
kvec:
    addi sp,sp,-128
8000002c:	f8010113          	addi	sp,sp,-128
    sw ra,0(sp)
80000030:	00112023          	sw	ra,0(sp)
    sw sp,4(sp)
80000034:	00212223          	sw	sp,4(sp)
    sw gp,8(sp)
80000038:	00312423          	sw	gp,8(sp)
    sw tp,12(sp)
8000003c:	00412623          	sw	tp,12(sp)
    sw a0,16(sp)
80000040:	00a12823          	sw	a0,16(sp)
    sw a1,20(sp)
80000044:	00b12a23          	sw	a1,20(sp)
    sw a2,24(sp)
80000048:	00c12c23          	sw	a2,24(sp)
    sw a3,28(sp)
8000004c:	00d12e23          	sw	a3,28(sp)
    sw a4,32(sp)
80000050:	02e12023          	sw	a4,32(sp)
    sw a5,36(sp)
80000054:	02f12223          	sw	a5,36(sp)
    sw a6,40(sp)
80000058:	03012423          	sw	a6,40(sp)
    sw a7,44(sp)
8000005c:	03112623          	sw	a7,44(sp)
    sw s0,48(sp)
80000060:	02812823          	sw	s0,48(sp)
    sw s1,52(sp)
80000064:	02912a23          	sw	s1,52(sp)
    sw s2,56(sp)
80000068:	03212c23          	sw	s2,56(sp)
    sw s3,60(sp)
8000006c:	03312e23          	sw	s3,60(sp)
    sw s4,64(sp)
80000070:	05412023          	sw	s4,64(sp)
    sw s5,68(sp)
80000074:	05512223          	sw	s5,68(sp)
    sw s6,72(sp)
80000078:	05612423          	sw	s6,72(sp)
    sw s7,76(sp)
8000007c:	05712623          	sw	s7,76(sp)
    sw s8,80(sp)
80000080:	05812823          	sw	s8,80(sp)
    sw s9,84(sp)
80000084:	05912a23          	sw	s9,84(sp)
    sw s10,88(sp)
80000088:	05a12c23          	sw	s10,88(sp)
    sw s11,92(sp)
8000008c:	05b12e23          	sw	s11,92(sp)
    sw t0,96(sp)
80000090:	06512023          	sw	t0,96(sp)
    sw t1,100(sp)
80000094:	06612223          	sw	t1,100(sp)
    sw t2,104(sp)
80000098:	06712423          	sw	t2,104(sp)
    sw t3,108(sp)
8000009c:	07c12623          	sw	t3,108(sp)
    sw t4,112(sp)
800000a0:	07d12823          	sw	t4,112(sp)
    sw t5,116(sp)
800000a4:	07e12a23          	sw	t5,116(sp)
    sw t6,120(sp)
800000a8:	07f12c23          	sw	t6,120(sp)

    call trapvec
800000ac:	7fc000ef          	jal	ra,800008a8 <trapvec>

    lw ra,0(sp)
800000b0:	00012083          	lw	ra,0(sp)
    lw sp,4(sp)
800000b4:	00412103          	lw	sp,4(sp)
    lw gp,8(sp)
800000b8:	00812183          	lw	gp,8(sp)
    lw tp,12(sp)
800000bc:	00c12203          	lw	tp,12(sp)
    lw a0,16(sp)
800000c0:	01012503          	lw	a0,16(sp)
    lw a1,20(sp)
800000c4:	01412583          	lw	a1,20(sp)
    lw a2,24(sp)
800000c8:	01812603          	lw	a2,24(sp)
    lw a3,28(sp)
800000cc:	01c12683          	lw	a3,28(sp)
    lw a4,32(sp)
800000d0:	02012703          	lw	a4,32(sp)
    lw a5,36(sp)
800000d4:	02412783          	lw	a5,36(sp)
    lw a6,40(sp)
800000d8:	02812803          	lw	a6,40(sp)
    lw a7,44(sp)
800000dc:	02c12883          	lw	a7,44(sp)
    lw s0,48(sp)
800000e0:	03012403          	lw	s0,48(sp)
    lw s1,52(sp)
800000e4:	03412483          	lw	s1,52(sp)
    lw s2,56(sp)
800000e8:	03812903          	lw	s2,56(sp)
    lw s3,60(sp)
800000ec:	03c12983          	lw	s3,60(sp)
    lw s4,64(sp)
800000f0:	04012a03          	lw	s4,64(sp)
    lw s5,68(sp)
800000f4:	04412a83          	lw	s5,68(sp)
    lw s6,72(sp)
800000f8:	04812b03          	lw	s6,72(sp)
    lw s7,76(sp)
800000fc:	04c12b83          	lw	s7,76(sp)
    lw s8,80(sp)
80000100:	05012c03          	lw	s8,80(sp)
    lw s9,84(sp)
80000104:	05412c83          	lw	s9,84(sp)
    lw s10,88(sp)
80000108:	05812d03          	lw	s10,88(sp)
    lw s11,92(sp)
8000010c:	05c12d83          	lw	s11,92(sp)
    lw t0,96(sp)
80000110:	06012283          	lw	t0,96(sp)
    lw t1,100(sp)
80000114:	06412303          	lw	t1,100(sp)
    lw t2,104(sp)
80000118:	06812383          	lw	t2,104(sp)
    lw t3,108(sp)
8000011c:	06c12e03          	lw	t3,108(sp)
    lw t4,112(sp)
80000120:	07012e83          	lw	t4,112(sp)
    lw t5,116(sp)
80000124:	07412f03          	lw	t5,116(sp)
    lw t6,120(sp)
80000128:	07812f83          	lw	t6,120(sp)

    addi sp,sp,128
8000012c:	08010113          	addi	sp,sp,128
    
80000130:	10200073          	sret

80000134 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80000134:	fe010113          	addi	sp,sp,-32
80000138:	00812e23          	sw	s0,28(sp)
8000013c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80000140:	300027f3          	csrr	a5,mstatus
80000144:	fef42623          	sw	a5,-20(s0)
    return x;
80000148:	fec42783          	lw	a5,-20(s0)
}
8000014c:	00078513          	mv	a0,a5
80000150:	01c12403          	lw	s0,28(sp)
80000154:	02010113          	addi	sp,sp,32
80000158:	00008067          	ret

8000015c <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
8000015c:	fe010113          	addi	sp,sp,-32
80000160:	00812e23          	sw	s0,28(sp)
80000164:	02010413          	addi	s0,sp,32
80000168:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
8000016c:	fec42783          	lw	a5,-20(s0)
80000170:	30079073          	csrw	mstatus,a5
}
80000174:	00000013          	nop
80000178:	01c12403          	lw	s0,28(sp)
8000017c:	02010113          	addi	sp,sp,32
80000180:	00008067          	ret

80000184 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000184:	fd010113          	addi	sp,sp,-48
80000188:	02112623          	sw	ra,44(sp)
8000018c:	02812423          	sw	s0,40(sp)
80000190:	03010413          	addi	s0,sp,48
80000194:	00050793          	mv	a5,a0
80000198:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
8000019c:	f99ff0ef          	jal	ra,80000134 <r_mstatus>
800001a0:	fea42623          	sw	a0,-20(s0)
    switch (m)
800001a4:	fdf44783          	lbu	a5,-33(s0)
800001a8:	00300713          	li	a4,3
800001ac:	06e78063          	beq	a5,a4,8000020c <s_mstatus_xpp+0x88>
800001b0:	00300713          	li	a4,3
800001b4:	08f74263          	blt	a4,a5,80000238 <s_mstatus_xpp+0xb4>
800001b8:	00078863          	beqz	a5,800001c8 <s_mstatus_xpp+0x44>
800001bc:	00100713          	li	a4,1
800001c0:	02e78063          	beq	a5,a4,800001e0 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800001c4:	0740006f          	j	80000238 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800001c8:	fec42703          	lw	a4,-20(s0)
800001cc:	ffffe7b7          	lui	a5,0xffffe
800001d0:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800001d4:	00f777b3          	and	a5,a4,a5
800001d8:	fef42623          	sw	a5,-20(s0)
        break;
800001dc:	0600006f          	j	8000023c <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800001e0:	fec42703          	lw	a4,-20(s0)
800001e4:	ffffe7b7          	lui	a5,0xffffe
800001e8:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800001ec:	00f777b3          	and	a5,a4,a5
800001f0:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
800001f4:	fec42703          	lw	a4,-20(s0)
800001f8:	000017b7          	lui	a5,0x1
800001fc:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
80000200:	00f767b3          	or	a5,a4,a5
80000204:	fef42623          	sw	a5,-20(s0)
        break;
80000208:	0340006f          	j	8000023c <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
8000020c:	fec42703          	lw	a4,-20(s0)
80000210:	ffffe7b7          	lui	a5,0xffffe
80000214:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000218:	00f777b3          	and	a5,a4,a5
8000021c:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
80000220:	fec42703          	lw	a4,-20(s0)
80000224:	000027b7          	lui	a5,0x2
80000228:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
8000022c:	00f767b3          	or	a5,a4,a5
80000230:	fef42623          	sw	a5,-20(s0)
        break;
80000234:	0080006f          	j	8000023c <s_mstatus_xpp+0xb8>
        break;
80000238:	00000013          	nop
    }
    w_mstatus(x);
8000023c:	fec42503          	lw	a0,-20(s0)
80000240:	f1dff0ef          	jal	ra,8000015c <w_mstatus>
}
80000244:	00000013          	nop
80000248:	02c12083          	lw	ra,44(sp)
8000024c:	02812403          	lw	s0,40(sp)
80000250:	03010113          	addi	sp,sp,48
80000254:	00008067          	ret

80000258 <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
80000258:	fe010113          	addi	sp,sp,-32
8000025c:	00812e23          	sw	s0,28(sp)
80000260:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000264:	100027f3          	csrr	a5,sstatus
80000268:	fef42623          	sw	a5,-20(s0)
    return x;
8000026c:	fec42783          	lw	a5,-20(s0)
}
80000270:	00078513          	mv	a0,a5
80000274:	01c12403          	lw	s0,28(sp)
80000278:	02010113          	addi	sp,sp,32
8000027c:	00008067          	ret

80000280 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
80000280:	fe010113          	addi	sp,sp,-32
80000284:	00812e23          	sw	s0,28(sp)
80000288:	02010413          	addi	s0,sp,32
8000028c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
80000290:	fec42783          	lw	a5,-20(s0)
80000294:	10079073          	csrw	sstatus,a5
}
80000298:	00000013          	nop
8000029c:	01c12403          	lw	s0,28(sp)
800002a0:	02010113          	addi	sp,sp,32
800002a4:	00008067          	ret

800002a8 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
800002a8:	fe010113          	addi	sp,sp,-32
800002ac:	00812e23          	sw	s0,28(sp)
800002b0:	02010413          	addi	s0,sp,32
800002b4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
800002b8:	fec42783          	lw	a5,-20(s0)
800002bc:	34179073          	csrw	mepc,a5
}
800002c0:	00000013          	nop
800002c4:	01c12403          	lw	s0,28(sp)
800002c8:	02010113          	addi	sp,sp,32
800002cc:	00008067          	ret

800002d0 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
800002d0:	fe010113          	addi	sp,sp,-32
800002d4:	00812e23          	sw	s0,28(sp)
800002d8:	02010413          	addi	s0,sp,32
800002dc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
800002e0:	fec42783          	lw	a5,-20(s0)
800002e4:	10579073          	csrw	stvec,a5
}
800002e8:	00000013          	nop
800002ec:	01c12403          	lw	s0,28(sp)
800002f0:	02010113          	addi	sp,sp,32
800002f4:	00008067          	ret

800002f8 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
800002f8:	fe010113          	addi	sp,sp,-32
800002fc:	00812e23          	sw	s0,28(sp)
80000300:	02010413          	addi	s0,sp,32
80000304:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
80000308:	fec42783          	lw	a5,-20(s0)
8000030c:	30379073          	csrw	mideleg,a5
}
80000310:	00000013          	nop
80000314:	01c12403          	lw	s0,28(sp)
80000318:	02010113          	addi	sp,sp,32
8000031c:	00008067          	ret

80000320 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
80000320:	fe010113          	addi	sp,sp,-32
80000324:	00812e23          	sw	s0,28(sp)
80000328:	02010413          	addi	s0,sp,32
8000032c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
80000330:	fec42783          	lw	a5,-20(s0)
80000334:	30279073          	csrw	medeleg,a5
}
80000338:	00000013          	nop
8000033c:	01c12403          	lw	s0,28(sp)
80000340:	02010113          	addi	sp,sp,32
80000344:	00008067          	ret

80000348 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
80000348:	fe010113          	addi	sp,sp,-32
8000034c:	00812e23          	sw	s0,28(sp)
80000350:	02010413          	addi	s0,sp,32
80000354:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80000358:	fec42783          	lw	a5,-20(s0)
8000035c:	18079073          	csrw	satp,a5
}
80000360:	00000013          	nop
80000364:	01c12403          	lw	s0,28(sp)
80000368:	02010113          	addi	sp,sp,32
8000036c:	00008067          	ret

80000370 <s_mstatus_intr>:
        break;
    }
    return x;
}

static inline void s_mstatus_intr(uint32 m){
80000370:	fd010113          	addi	sp,sp,-48
80000374:	02112623          	sw	ra,44(sp)
80000378:	02812423          	sw	s0,40(sp)
8000037c:	03010413          	addi	s0,sp,48
80000380:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80000384:	db1ff0ef          	jal	ra,80000134 <r_mstatus>
80000388:	fea42623          	sw	a0,-20(s0)
    switch (m)
8000038c:	fdc42703          	lw	a4,-36(s0)
80000390:	08000793          	li	a5,128
80000394:	04f70263          	beq	a4,a5,800003d8 <s_mstatus_intr+0x68>
80000398:	fdc42703          	lw	a4,-36(s0)
8000039c:	08000793          	li	a5,128
800003a0:	0ae7e463          	bltu	a5,a4,80000448 <s_mstatus_intr+0xd8>
800003a4:	fdc42703          	lw	a4,-36(s0)
800003a8:	02000793          	li	a5,32
800003ac:	04f70463          	beq	a4,a5,800003f4 <s_mstatus_intr+0x84>
800003b0:	fdc42703          	lw	a4,-36(s0)
800003b4:	02000793          	li	a5,32
800003b8:	08e7e863          	bltu	a5,a4,80000448 <s_mstatus_intr+0xd8>
800003bc:	fdc42703          	lw	a4,-36(s0)
800003c0:	00200793          	li	a5,2
800003c4:	06f70463          	beq	a4,a5,8000042c <s_mstatus_intr+0xbc>
800003c8:	fdc42703          	lw	a4,-36(s0)
800003cc:	00800793          	li	a5,8
800003d0:	04f70063          	beq	a4,a5,80000410 <s_mstatus_intr+0xa0>
    case INTR_SIE:
        x &= ~INTR_SIE;
        x |= INTR_SIE;
        break;
    default:
        break;
800003d4:	0740006f          	j	80000448 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
800003d8:	fec42783          	lw	a5,-20(s0)
800003dc:	f7f7f793          	andi	a5,a5,-129
800003e0:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
800003e4:	fec42783          	lw	a5,-20(s0)
800003e8:	0807e793          	ori	a5,a5,128
800003ec:	fef42623          	sw	a5,-20(s0)
        break;
800003f0:	05c0006f          	j	8000044c <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800003f4:	fec42783          	lw	a5,-20(s0)
800003f8:	fdf7f793          	andi	a5,a5,-33
800003fc:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
80000400:	fec42783          	lw	a5,-20(s0)
80000404:	0207e793          	ori	a5,a5,32
80000408:	fef42623          	sw	a5,-20(s0)
        break;
8000040c:	0400006f          	j	8000044c <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
80000410:	fec42783          	lw	a5,-20(s0)
80000414:	ff77f793          	andi	a5,a5,-9
80000418:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
8000041c:	fec42783          	lw	a5,-20(s0)
80000420:	0087e793          	ori	a5,a5,8
80000424:	fef42623          	sw	a5,-20(s0)
        break;
80000428:	0240006f          	j	8000044c <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
8000042c:	fec42783          	lw	a5,-20(s0)
80000430:	ffd7f793          	andi	a5,a5,-3
80000434:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80000438:	fec42783          	lw	a5,-20(s0)
8000043c:	0027e793          	ori	a5,a5,2
80000440:	fef42623          	sw	a5,-20(s0)
        break;
80000444:	0080006f          	j	8000044c <s_mstatus_intr+0xdc>
        break;
80000448:	00000013          	nop
    }
    w_mstatus(x);
8000044c:	fec42503          	lw	a0,-20(s0)
80000450:	d0dff0ef          	jal	ra,8000015c <w_mstatus>
}
80000454:	00000013          	nop
80000458:	02c12083          	lw	ra,44(sp)
8000045c:	02812403          	lw	s0,40(sp)
80000460:	03010113          	addi	sp,sp,48
80000464:	00008067          	ret

80000468 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
80000468:	fd010113          	addi	sp,sp,-48
8000046c:	02112623          	sw	ra,44(sp)
80000470:	02812423          	sw	s0,40(sp)
80000474:	03010413          	addi	s0,sp,48
80000478:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
8000047c:	dddff0ef          	jal	ra,80000258 <r_sstatus>
80000480:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000484:	fdc42703          	lw	a4,-36(s0)
80000488:	ffd00793          	li	a5,-3
8000048c:	06f70863          	beq	a4,a5,800004fc <s_sstatus_intr+0x94>
80000490:	fdc42703          	lw	a4,-36(s0)
80000494:	ffd00793          	li	a5,-3
80000498:	06e7e863          	bltu	a5,a4,80000508 <s_sstatus_intr+0xa0>
8000049c:	fdc42703          	lw	a4,-36(s0)
800004a0:	fdf00793          	li	a5,-33
800004a4:	02f70c63          	beq	a4,a5,800004dc <s_sstatus_intr+0x74>
800004a8:	fdc42703          	lw	a4,-36(s0)
800004ac:	fdf00793          	li	a5,-33
800004b0:	04e7ec63          	bltu	a5,a4,80000508 <s_sstatus_intr+0xa0>
800004b4:	fdc42703          	lw	a4,-36(s0)
800004b8:	00200793          	li	a5,2
800004bc:	02f70863          	beq	a4,a5,800004ec <s_sstatus_intr+0x84>
800004c0:	fdc42703          	lw	a4,-36(s0)
800004c4:	02000793          	li	a5,32
800004c8:	04f71063          	bne	a4,a5,80000508 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
800004cc:	fec42783          	lw	a5,-20(s0)
800004d0:	0207e793          	ori	a5,a5,32
800004d4:	fef42623          	sw	a5,-20(s0)
        break;
800004d8:	0340006f          	j	8000050c <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
800004dc:	fec42783          	lw	a5,-20(s0)
800004e0:	fdf7f793          	andi	a5,a5,-33
800004e4:	fef42623          	sw	a5,-20(s0)
        break;
800004e8:	0240006f          	j	8000050c <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
800004ec:	fec42783          	lw	a5,-20(s0)
800004f0:	0027e793          	ori	a5,a5,2
800004f4:	fef42623          	sw	a5,-20(s0)
        break;
800004f8:	0140006f          	j	8000050c <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
800004fc:	fec42783          	lw	a5,-20(s0)
80000500:	0027f793          	andi	a5,a5,2
80000504:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
80000508:	00000013          	nop
    }
    w_sstatus(x);
8000050c:	fec42503          	lw	a0,-20(s0)
80000510:	d71ff0ef          	jal	ra,80000280 <w_sstatus>
}
80000514:	00000013          	nop
80000518:	02c12083          	lw	ra,44(sp)
8000051c:	02812403          	lw	s0,40(sp)
80000520:	03010113          	addi	sp,sp,48
80000524:	00008067          	ret

80000528 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();     // 定义在main.c

void start(){
80000528:	ff010113          	addi	sp,sp,-16
8000052c:	00112623          	sw	ra,12(sp)
80000530:	00812423          	sw	s0,8(sp)
80000534:	01010413          	addi	s0,sp,16
    uartinit();
80000538:	080000ef          	jal	ra,800005b8 <uartinit>
    uartputs("Hello Los!\n");
8000053c:	800027b7          	lui	a5,0x80002
80000540:	00078513          	mv	a0,a5
80000544:	168000ef          	jal	ra,800006ac <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
80000548:	00100513          	li	a0,1
8000054c:	c39ff0ef          	jal	ra,80000184 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
80000550:	00000513          	li	a0,0
80000554:	df5ff0ef          	jal	ra,80000348 <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
80000558:	000107b7          	lui	a5,0x10
8000055c:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000560:	d99ff0ef          	jal	ra,800002f8 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80000564:	000107b7          	lui	a5,0x10
80000568:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
8000056c:	db5ff0ef          	jal	ra,80000320 <w_medeleg>

    s_mstatus_intr(INTR_MPIE);  // S-mode 开全局中断
80000570:	08000513          	li	a0,128
80000574:	dfdff0ef          	jal	ra,80000370 <s_mstatus_intr>
    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
80000578:	00200513          	li	a0,2
8000057c:	eedff0ef          	jal	ra,80000468 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
80000580:	800007b7          	lui	a5,0x80000
80000584:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000588:	00078513          	mv	a0,a5
8000058c:	d45ff0ef          	jal	ra,800002d0 <w_stvec>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
80000590:	800007b7          	lui	a5,0x80000
80000594:	77878793          	addi	a5,a5,1912 # 80000778 <memend+0xf8000778>
80000598:	00078513          	mv	a0,a5
8000059c:	d0dff0ef          	jal	ra,800002a8 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
800005a0:	30200073          	mret
800005a4:	00000013          	nop
800005a8:	00c12083          	lw	ra,12(sp)
800005ac:	00812403          	lw	s0,8(sp)
800005b0:	01010113          	addi	sp,sp,16
800005b4:	00008067          	ret

800005b8 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
800005b8:	fe010113          	addi	sp,sp,-32
800005bc:	00812e23          	sw	s0,28(sp)
800005c0:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800005c4:	100007b7          	lui	a5,0x10000
800005c8:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800005cc:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800005d0:	100007b7          	lui	a5,0x10000
800005d4:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800005d8:	0007c783          	lbu	a5,0(a5)
800005dc:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800005e0:	100007b7          	lui	a5,0x10000
800005e4:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800005e8:	fef44703          	lbu	a4,-17(s0)
800005ec:	f8076713          	ori	a4,a4,-128
800005f0:	0ff77713          	andi	a4,a4,255
800005f4:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
800005f8:	100007b7          	lui	a5,0x10000
800005fc:	00300713          	li	a4,3
80000600:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
80000604:	100007b7          	lui	a5,0x10000
80000608:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
8000060c:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
80000610:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80000614:	100007b7          	lui	a5,0x10000
80000618:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
8000061c:	fef44703          	lbu	a4,-17(s0)
80000620:	00376713          	ori	a4,a4,3
80000624:	0ff77713          	andi	a4,a4,255
80000628:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
8000062c:	100007b7          	lui	a5,0x10000
80000630:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000634:	0007c783          	lbu	a5,0(a5)
80000638:	0ff7f713          	andi	a4,a5,255
8000063c:	100007b7          	lui	a5,0x10000
80000640:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000644:	00176713          	ori	a4,a4,1
80000648:	0ff77713          	andi	a4,a4,255
8000064c:	00e78023          	sb	a4,0(a5)
}
80000650:	00000013          	nop
80000654:	01c12403          	lw	s0,28(sp)
80000658:	02010113          	addi	sp,sp,32
8000065c:	00008067          	ret

80000660 <uartputc>:

// 轮询处理数据
char uartputc(char c){
80000660:	fe010113          	addi	sp,sp,-32
80000664:	00812e23          	sw	s0,28(sp)
80000668:	02010413          	addi	s0,sp,32
8000066c:	00050793          	mv	a5,a0
80000670:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80000674:	00000013          	nop
80000678:	100007b7          	lui	a5,0x10000
8000067c:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000680:	0007c783          	lbu	a5,0(a5)
80000684:	0ff7f793          	andi	a5,a5,255
80000688:	0207f793          	andi	a5,a5,32
8000068c:	fe0786e3          	beqz	a5,80000678 <uartputc+0x18>
    return uart_write(UART_THR,c);
80000690:	10000737          	lui	a4,0x10000
80000694:	fef44783          	lbu	a5,-17(s0)
80000698:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
8000069c:	00078513          	mv	a0,a5
800006a0:	01c12403          	lw	s0,28(sp)
800006a4:	02010113          	addi	sp,sp,32
800006a8:	00008067          	ret

800006ac <uartputs>:

// 发送字符串
void uartputs(char* s){
800006ac:	fe010113          	addi	sp,sp,-32
800006b0:	00112e23          	sw	ra,28(sp)
800006b4:	00812c23          	sw	s0,24(sp)
800006b8:	02010413          	addi	s0,sp,32
800006bc:	fea42623          	sw	a0,-20(s0)
    while (*s)
800006c0:	01c0006f          	j	800006dc <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
800006c4:	fec42783          	lw	a5,-20(s0)
800006c8:	00178713          	addi	a4,a5,1
800006cc:	fee42623          	sw	a4,-20(s0)
800006d0:	0007c783          	lbu	a5,0(a5)
800006d4:	00078513          	mv	a0,a5
800006d8:	f89ff0ef          	jal	ra,80000660 <uartputc>
    while (*s)
800006dc:	fec42783          	lw	a5,-20(s0)
800006e0:	0007c783          	lbu	a5,0(a5)
800006e4:	fe0790e3          	bnez	a5,800006c4 <uartputs+0x18>
    }
    
}
800006e8:	00000013          	nop
800006ec:	00000013          	nop
800006f0:	01c12083          	lw	ra,28(sp)
800006f4:	01812403          	lw	s0,24(sp)
800006f8:	02010113          	addi	sp,sp,32
800006fc:	00008067          	ret

80000700 <uartgetc>:

// 接收输入
int uartgetc(){
80000700:	ff010113          	addi	sp,sp,-16
80000704:	00812623          	sw	s0,12(sp)
80000708:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
8000070c:	100007b7          	lui	a5,0x10000
80000710:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000714:	0007c783          	lbu	a5,0(a5)
80000718:	0ff7f793          	andi	a5,a5,255
8000071c:	0017f793          	andi	a5,a5,1
80000720:	00078a63          	beqz	a5,80000734 <uartgetc+0x34>
        return uart_read(UART_RHR);
80000724:	100007b7          	lui	a5,0x10000
80000728:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
8000072c:	0ff7f793          	andi	a5,a5,255
80000730:	0080006f          	j	80000738 <uartgetc+0x38>
    }else{
        return -1;
80000734:	fff00793          	li	a5,-1
    }
}
80000738:	00078513          	mv	a0,a5
8000073c:	00c12403          	lw	s0,12(sp)
80000740:	01010113          	addi	sp,sp,16
80000744:	00008067          	ret

80000748 <uartintr>:

// 键盘输入中断
char uartintr(){
80000748:	ff010113          	addi	sp,sp,-16
8000074c:	00112623          	sw	ra,12(sp)
80000750:	00812423          	sw	s0,8(sp)
80000754:	01010413          	addi	s0,sp,16
    return uartgetc();
80000758:	fa9ff0ef          	jal	ra,80000700 <uartgetc>
8000075c:	00050793          	mv	a5,a0
80000760:	0ff7f793          	andi	a5,a5,255
80000764:	00078513          	mv	a0,a5
80000768:	00c12083          	lw	ra,12(sp)
8000076c:	00812403          	lw	s0,8(sp)
80000770:	01010113          	addi	sp,sp,16
80000774:	00008067          	ret

80000778 <main>:
 */
#include "riscv.h"
#include "defs.h"
#include "proc.h"

void main(){
80000778:	fe010113          	addi	sp,sp,-32
8000077c:	00112e23          	sw	ra,28(sp)
80000780:	00812c23          	sw	s0,24(sp)
80000784:	02010413          	addi	s0,sp,32
    printf("start run main()\n");
80000788:	800027b7          	lui	a5,0x80002
8000078c:	00c78513          	addi	a0,a5,12 # 8000200c <memend+0xf800200c>
80000790:	324000ef          	jal	ra,80000ab4 <printf>

    minit();        // 物理内存管理
80000794:	72c000ef          	jal	ra,80000ec0 <minit>
    plicinit();     // PLIC 中断处理
80000798:	0c9000ef          	jal	ra,80001060 <plicinit>
    vminit();       // 启动虚拟内存
8000079c:	57d000ef          	jal	ra,80001518 <vminit>

    procinit();
800007a0:	77d000ef          	jal	ra,8000171c <procinit>
    
    // char* va=(char*)0xc0002000;
    // printf("%c\n",*va);
    // *va=10;
    // *(int *)0x00000000 = 100;
    for(int i=0;i<NPROC;i++){
800007a4:	fe042623          	sw	zero,-20(s0)
800007a8:	0440006f          	j	800007ec <main+0x74>
        struct pcb* p=&proc[i];
800007ac:	fec42703          	lw	a4,-20(s0)
800007b0:	08c00793          	li	a5,140
800007b4:	02f70733          	mul	a4,a4,a5
800007b8:	8000c7b7          	lui	a5,0x8000c
800007bc:	40478793          	addi	a5,a5,1028 # 8000c404 <memend+0xf800c404>
800007c0:	00f707b3          	add	a5,a4,a5
800007c4:	fef42423          	sw	a5,-24(s0)
        printf("%p ",p->kernelstack);
800007c8:	fe842783          	lw	a5,-24(s0)
800007cc:	0887a783          	lw	a5,136(a5)
800007d0:	00078593          	mv	a1,a5
800007d4:	800027b7          	lui	a5,0x80002
800007d8:	02078513          	addi	a0,a5,32 # 80002020 <memend+0xf8002020>
800007dc:	2d8000ef          	jal	ra,80000ab4 <printf>
    for(int i=0;i<NPROC;i++){
800007e0:	fec42783          	lw	a5,-20(s0)
800007e4:	00178793          	addi	a5,a5,1
800007e8:	fef42623          	sw	a5,-20(s0)
800007ec:	fec42703          	lw	a4,-20(s0)
800007f0:	00300793          	li	a5,3
800007f4:	fae7dce3          	bge	a5,a4,800007ac <main+0x34>
    }
    printf("----------------------\n");
800007f8:	800027b7          	lui	a5,0x80002
800007fc:	02478513          	addi	a0,a5,36 # 80002024 <memend+0xf8002024>
80000800:	2b4000ef          	jal	ra,80000ab4 <printf>
    asm volatile("ecall");
80000804:	00000073          	ecall
    asm volatile("ecall");
80000808:	00000073          	ecall
    while(1);
8000080c:	0000006f          	j	8000080c <main+0x94>

80000810 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
80000810:	fe010113          	addi	sp,sp,-32
80000814:	00812e23          	sw	s0,28(sp)
80000818:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
8000081c:	142027f3          	csrr	a5,scause
80000820:	fef42623          	sw	a5,-20(s0)
    return x;
80000824:	fec42783          	lw	a5,-20(s0)
}
80000828:	00078513          	mv	a0,a5
8000082c:	01c12403          	lw	s0,28(sp)
80000830:	02010113          	addi	sp,sp,32
80000834:	00008067          	ret

80000838 <externinterrupt>:
#include "plic.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
80000838:	fe010113          	addi	sp,sp,-32
8000083c:	00112e23          	sw	ra,28(sp)
80000840:	00812c23          	sw	s0,24(sp)
80000844:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000848:	0dd000ef          	jal	ra,80001124 <r_plicclaim>
8000084c:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000850:	fec42583          	lw	a1,-20(s0)
80000854:	800027b7          	lui	a5,0x80002
80000858:	03c78513          	addi	a0,a5,60 # 8000203c <memend+0xf800203c>
8000085c:	258000ef          	jal	ra,80000ab4 <printf>
    switch (irq)
80000860:	fec42703          	lw	a4,-20(s0)
80000864:	00a00793          	li	a5,10
80000868:	02f71063          	bne	a4,a5,80000888 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
8000086c:	eddff0ef          	jal	ra,80000748 <uartintr>
80000870:	00050793          	mv	a5,a0
80000874:	00078593          	mv	a1,a5
80000878:	800027b7          	lui	a5,0x80002
8000087c:	04878513          	addi	a0,a5,72 # 80002048 <memend+0xf8002048>
80000880:	234000ef          	jal	ra,80000ab4 <printf>
        break;
80000884:	0080006f          	j	8000088c <externinterrupt+0x54>
    default:
        break;
80000888:	00000013          	nop
    }
    w_pliccomplete(irq);
8000088c:	fec42503          	lw	a0,-20(s0)
80000890:	0d5000ef          	jal	ra,80001164 <w_pliccomplete>
}
80000894:	00000013          	nop
80000898:	01c12083          	lw	ra,28(sp)
8000089c:	01812403          	lw	s0,24(sp)
800008a0:	02010113          	addi	sp,sp,32
800008a4:	00008067          	ret

800008a8 <trapvec>:

void trapvec(){
800008a8:	fe010113          	addi	sp,sp,-32
800008ac:	00112e23          	sw	ra,28(sp)
800008b0:	00812c23          	sw	s0,24(sp)
800008b4:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
800008b8:	f59ff0ef          	jal	ra,80000810 <r_scause>
800008bc:	fea42623          	sw	a0,-20(s0)

    uint16 code= scause & 0xffff;
800008c0:	fec42783          	lw	a5,-20(s0)
800008c4:	fef41523          	sh	a5,-22(s0)

    if(scause & (1<<31)){
800008c8:	fec42783          	lw	a5,-20(s0)
800008cc:	0607de63          	bgez	a5,80000948 <trapvec+0xa0>
        printf("Interrupt : ");
800008d0:	800027b7          	lui	a5,0x80002
800008d4:	05878513          	addi	a0,a5,88 # 80002058 <memend+0xf8002058>
800008d8:	1dc000ef          	jal	ra,80000ab4 <printf>
        switch (code)
800008dc:	fea45783          	lhu	a5,-22(s0)
800008e0:	00900713          	li	a4,9
800008e4:	04e78063          	beq	a5,a4,80000924 <trapvec+0x7c>
800008e8:	00900713          	li	a4,9
800008ec:	04f74663          	blt	a4,a5,80000938 <trapvec+0x90>
800008f0:	00100713          	li	a4,1
800008f4:	00e78863          	beq	a5,a4,80000904 <trapvec+0x5c>
800008f8:	00500713          	li	a4,5
800008fc:	00e78c63          	beq	a5,a4,80000914 <trapvec+0x6c>
80000900:	0380006f          	j	80000938 <trapvec+0x90>
        {
        case 1:
            printf("Supervisor software interrupt\n");
80000904:	800027b7          	lui	a5,0x80002
80000908:	06878513          	addi	a0,a5,104 # 80002068 <memend+0xf8002068>
8000090c:	1a8000ef          	jal	ra,80000ab4 <printf>
            break;
80000910:	1580006f          	j	80000a68 <trapvec+0x1c0>
        case 5:
            printf("Supervisor timer interrupt\n");
80000914:	800027b7          	lui	a5,0x80002
80000918:	08878513          	addi	a0,a5,136 # 80002088 <memend+0xf8002088>
8000091c:	198000ef          	jal	ra,80000ab4 <printf>
            break;
80000920:	1480006f          	j	80000a68 <trapvec+0x1c0>
        case 9:
            printf("Supervisor external interrupt\n");
80000924:	800027b7          	lui	a5,0x80002
80000928:	0a478513          	addi	a0,a5,164 # 800020a4 <memend+0xf80020a4>
8000092c:	188000ef          	jal	ra,80000ab4 <printf>
            externinterrupt();
80000930:	f09ff0ef          	jal	ra,80000838 <externinterrupt>
            break;
80000934:	1340006f          	j	80000a68 <trapvec+0x1c0>
        default:
            printf("Other interrupt\n");
80000938:	800027b7          	lui	a5,0x80002
8000093c:	0c478513          	addi	a0,a5,196 # 800020c4 <memend+0xf80020c4>
80000940:	174000ef          	jal	ra,80000ab4 <printf>
            break;
80000944:	1240006f          	j	80000a68 <trapvec+0x1c0>
        }
    }else{
        printf("Exception : ");
80000948:	800027b7          	lui	a5,0x80002
8000094c:	0d878513          	addi	a0,a5,216 # 800020d8 <memend+0xf80020d8>
80000950:	164000ef          	jal	ra,80000ab4 <printf>
        switch (code)
80000954:	fea45783          	lhu	a5,-22(s0)
80000958:	00f00713          	li	a4,15
8000095c:	0ef76663          	bltu	a4,a5,80000a48 <trapvec+0x1a0>
80000960:	00279713          	slli	a4,a5,0x2
80000964:	800027b7          	lui	a5,0x80002
80000968:	24c78793          	addi	a5,a5,588 # 8000224c <memend+0xf800224c>
8000096c:	00f707b3          	add	a5,a4,a5
80000970:	0007a783          	lw	a5,0(a5)
80000974:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000978:	800027b7          	lui	a5,0x80002
8000097c:	0e878513          	addi	a0,a5,232 # 800020e8 <memend+0xf80020e8>
80000980:	134000ef          	jal	ra,80000ab4 <printf>
            break;
80000984:	0d40006f          	j	80000a58 <trapvec+0x1b0>
        case 1:
            printf("Instruction access fault\n");
80000988:	800027b7          	lui	a5,0x80002
8000098c:	10878513          	addi	a0,a5,264 # 80002108 <memend+0xf8002108>
80000990:	124000ef          	jal	ra,80000ab4 <printf>
            break;
80000994:	0c40006f          	j	80000a58 <trapvec+0x1b0>
        case 2:
            printf("Illegal instruction\n");
80000998:	800027b7          	lui	a5,0x80002
8000099c:	12478513          	addi	a0,a5,292 # 80002124 <memend+0xf8002124>
800009a0:	114000ef          	jal	ra,80000ab4 <printf>
            break;
800009a4:	0b40006f          	j	80000a58 <trapvec+0x1b0>
        case 3:
            printf("Breakpoint\n");
800009a8:	800027b7          	lui	a5,0x80002
800009ac:	13c78513          	addi	a0,a5,316 # 8000213c <memend+0xf800213c>
800009b0:	104000ef          	jal	ra,80000ab4 <printf>
            break;
800009b4:	0a40006f          	j	80000a58 <trapvec+0x1b0>
        case 4:
            printf("Load address misaligned\n");
800009b8:	800027b7          	lui	a5,0x80002
800009bc:	14878513          	addi	a0,a5,328 # 80002148 <memend+0xf8002148>
800009c0:	0f4000ef          	jal	ra,80000ab4 <printf>
            break;
800009c4:	0940006f          	j	80000a58 <trapvec+0x1b0>
        case 5:
            printf("Load access fault\n");
800009c8:	800027b7          	lui	a5,0x80002
800009cc:	16478513          	addi	a0,a5,356 # 80002164 <memend+0xf8002164>
800009d0:	0e4000ef          	jal	ra,80000ab4 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
800009d4:	0840006f          	j	80000a58 <trapvec+0x1b0>
        case 6:
            printf("Store/AMO address misaligned\n");
800009d8:	800027b7          	lui	a5,0x80002
800009dc:	17878513          	addi	a0,a5,376 # 80002178 <memend+0xf8002178>
800009e0:	0d4000ef          	jal	ra,80000ab4 <printf>
            break;
800009e4:	0740006f          	j	80000a58 <trapvec+0x1b0>
        case 7:
            printf("Store/AMO access fault\n");
800009e8:	800027b7          	lui	a5,0x80002
800009ec:	19878513          	addi	a0,a5,408 # 80002198 <memend+0xf8002198>
800009f0:	0c4000ef          	jal	ra,80000ab4 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
800009f4:	0640006f          	j	80000a58 <trapvec+0x1b0>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
800009f8:	800027b7          	lui	a5,0x80002
800009fc:	1b078513          	addi	a0,a5,432 # 800021b0 <memend+0xf80021b0>
80000a00:	0b4000ef          	jal	ra,80000ab4 <printf>
            break;
80000a04:	0540006f          	j	80000a58 <trapvec+0x1b0>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000a08:	800027b7          	lui	a5,0x80002
80000a0c:	1d078513          	addi	a0,a5,464 # 800021d0 <memend+0xf80021d0>
80000a10:	0a4000ef          	jal	ra,80000ab4 <printf>
            break;
80000a14:	0440006f          	j	80000a58 <trapvec+0x1b0>
        case 12:
            printf("Instruction page fault\n");
80000a18:	800027b7          	lui	a5,0x80002
80000a1c:	1f078513          	addi	a0,a5,496 # 800021f0 <memend+0xf80021f0>
80000a20:	094000ef          	jal	ra,80000ab4 <printf>
            break;
80000a24:	0340006f          	j	80000a58 <trapvec+0x1b0>
        case 13:
            printf("Load page fault\n");
80000a28:	800027b7          	lui	a5,0x80002
80000a2c:	20878513          	addi	a0,a5,520 # 80002208 <memend+0xf8002208>
80000a30:	084000ef          	jal	ra,80000ab4 <printf>
            break;
80000a34:	0240006f          	j	80000a58 <trapvec+0x1b0>
        case 15:
            printf("Store/AMO page fault\n");
80000a38:	800027b7          	lui	a5,0x80002
80000a3c:	21c78513          	addi	a0,a5,540 # 8000221c <memend+0xf800221c>
80000a40:	074000ef          	jal	ra,80000ab4 <printf>
            break;
80000a44:	0140006f          	j	80000a58 <trapvec+0x1b0>
        default:
            printf("Other\n");
80000a48:	800027b7          	lui	a5,0x80002
80000a4c:	23478513          	addi	a0,a5,564 # 80002234 <memend+0xf8002234>
80000a50:	064000ef          	jal	ra,80000ab4 <printf>
            break;
80000a54:	00000013          	nop
        }
        panic("Trap Exception");
80000a58:	800027b7          	lui	a5,0x80002
80000a5c:	23c78513          	addi	a0,a5,572 # 8000223c <memend+0xf800223c>
80000a60:	01c000ef          	jal	ra,80000a7c <panic>
    }
}
80000a64:	00000013          	nop
80000a68:	00000013          	nop
80000a6c:	01c12083          	lw	ra,28(sp)
80000a70:	01812403          	lw	s0,24(sp)
80000a74:	02010113          	addi	sp,sp,32
80000a78:	00008067          	ret

80000a7c <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000a7c:	fe010113          	addi	sp,sp,-32
80000a80:	00112e23          	sw	ra,28(sp)
80000a84:	00812c23          	sw	s0,24(sp)
80000a88:	02010413          	addi	s0,sp,32
80000a8c:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000a90:	800027b7          	lui	a5,0x80002
80000a94:	28c78513          	addi	a0,a5,652 # 8000228c <memend+0xf800228c>
80000a98:	c15ff0ef          	jal	ra,800006ac <uartputs>
    uartputs(s);
80000a9c:	fec42503          	lw	a0,-20(s0)
80000aa0:	c0dff0ef          	jal	ra,800006ac <uartputs>
	uartputs("\n");
80000aa4:	800027b7          	lui	a5,0x80002
80000aa8:	29478513          	addi	a0,a5,660 # 80002294 <memend+0xf8002294>
80000aac:	c01ff0ef          	jal	ra,800006ac <uartputs>
    while(1);
80000ab0:	0000006f          	j	80000ab0 <panic+0x34>

80000ab4 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000ab4:	f8010113          	addi	sp,sp,-128
80000ab8:	04112e23          	sw	ra,92(sp)
80000abc:	04812c23          	sw	s0,88(sp)
80000ac0:	06010413          	addi	s0,sp,96
80000ac4:	faa42623          	sw	a0,-84(s0)
80000ac8:	00b42223          	sw	a1,4(s0)
80000acc:	00c42423          	sw	a2,8(s0)
80000ad0:	00d42623          	sw	a3,12(s0)
80000ad4:	00e42823          	sw	a4,16(s0)
80000ad8:	00f42a23          	sw	a5,20(s0)
80000adc:	01042c23          	sw	a6,24(s0)
80000ae0:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000ae4:	02040793          	addi	a5,s0,32
80000ae8:	faf42423          	sw	a5,-88(s0)
80000aec:	fa842783          	lw	a5,-88(s0)
80000af0:	fe478793          	addi	a5,a5,-28
80000af4:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000af8:	fac42783          	lw	a5,-84(s0)
80000afc:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000b00:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000b04:	fe042223          	sw	zero,-28(s0)
	while(ch=*(s)){
80000b08:	36c0006f          	j	80000e74 <printf+0x3c0>
		if(ch=='%'){
80000b0c:	fbf44703          	lbu	a4,-65(s0)
80000b10:	02500793          	li	a5,37
80000b14:	04f71863          	bne	a4,a5,80000b64 <printf+0xb0>
			if(tt==1){
80000b18:	fe842703          	lw	a4,-24(s0)
80000b1c:	00100793          	li	a5,1
80000b20:	02f71663          	bne	a4,a5,80000b4c <printf+0x98>
				outbuf[idx++]='%';
80000b24:	fe442783          	lw	a5,-28(s0)
80000b28:	00178713          	addi	a4,a5,1
80000b2c:	fee42223          	sw	a4,-28(s0)
80000b30:	8000c737          	lui	a4,0x8000c
80000b34:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000b38:	00f707b3          	add	a5,a4,a5
80000b3c:	02500713          	li	a4,37
80000b40:	00e78023          	sb	a4,0(a5)
				tt=0;
80000b44:	fe042423          	sw	zero,-24(s0)
80000b48:	00c0006f          	j	80000b54 <printf+0xa0>
			}else{
				tt=1;
80000b4c:	00100793          	li	a5,1
80000b50:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000b54:	fec42783          	lw	a5,-20(s0)
80000b58:	00178793          	addi	a5,a5,1
80000b5c:	fef42623          	sw	a5,-20(s0)
80000b60:	3140006f          	j	80000e74 <printf+0x3c0>
		}else{
			if(tt==1){
80000b64:	fe842703          	lw	a4,-24(s0)
80000b68:	00100793          	li	a5,1
80000b6c:	2cf71e63          	bne	a4,a5,80000e48 <printf+0x394>
				switch (ch)
80000b70:	fbf44783          	lbu	a5,-65(s0)
80000b74:	fa878793          	addi	a5,a5,-88
80000b78:	02000713          	li	a4,32
80000b7c:	2af76663          	bltu	a4,a5,80000e28 <printf+0x374>
80000b80:	00279713          	slli	a4,a5,0x2
80000b84:	800027b7          	lui	a5,0x80002
80000b88:	2b078793          	addi	a5,a5,688 # 800022b0 <memend+0xf80022b0>
80000b8c:	00f707b3          	add	a5,a4,a5
80000b90:	0007a783          	lw	a5,0(a5)
80000b94:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000b98:	fb842783          	lw	a5,-72(s0)
80000b9c:	00478713          	addi	a4,a5,4
80000ba0:	fae42c23          	sw	a4,-72(s0)
80000ba4:	0007a783          	lw	a5,0(a5)
80000ba8:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000bac:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000bb0:	fe042783          	lw	a5,-32(s0)
80000bb4:	fcf42c23          	sw	a5,-40(s0)
80000bb8:	0100006f          	j	80000bc8 <printf+0x114>
80000bbc:	fdc42783          	lw	a5,-36(s0)
80000bc0:	00178793          	addi	a5,a5,1
80000bc4:	fcf42e23          	sw	a5,-36(s0)
80000bc8:	fd842703          	lw	a4,-40(s0)
80000bcc:	00a00793          	li	a5,10
80000bd0:	02f747b3          	div	a5,a4,a5
80000bd4:	fcf42c23          	sw	a5,-40(s0)
80000bd8:	fd842783          	lw	a5,-40(s0)
80000bdc:	fe0790e3          	bnez	a5,80000bbc <printf+0x108>
					for(int i=len;i>=0;i--){
80000be0:	fdc42783          	lw	a5,-36(s0)
80000be4:	fcf42a23          	sw	a5,-44(s0)
80000be8:	0540006f          	j	80000c3c <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000bec:	fe042703          	lw	a4,-32(s0)
80000bf0:	00a00793          	li	a5,10
80000bf4:	02f767b3          	rem	a5,a4,a5
80000bf8:	0ff7f713          	andi	a4,a5,255
80000bfc:	fe442683          	lw	a3,-28(s0)
80000c00:	fd442783          	lw	a5,-44(s0)
80000c04:	00f687b3          	add	a5,a3,a5
80000c08:	03070713          	addi	a4,a4,48
80000c0c:	0ff77713          	andi	a4,a4,255
80000c10:	8000c6b7          	lui	a3,0x8000c
80000c14:	00468693          	addi	a3,a3,4 # 8000c004 <memend+0xf800c004>
80000c18:	00f687b3          	add	a5,a3,a5
80000c1c:	00e78023          	sb	a4,0(a5)
						x/=10;
80000c20:	fe042703          	lw	a4,-32(s0)
80000c24:	00a00793          	li	a5,10
80000c28:	02f747b3          	div	a5,a4,a5
80000c2c:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000c30:	fd442783          	lw	a5,-44(s0)
80000c34:	fff78793          	addi	a5,a5,-1
80000c38:	fcf42a23          	sw	a5,-44(s0)
80000c3c:	fd442783          	lw	a5,-44(s0)
80000c40:	fa07d6e3          	bgez	a5,80000bec <printf+0x138>
					}
					idx+=(len+1);
80000c44:	fdc42783          	lw	a5,-36(s0)
80000c48:	00178793          	addi	a5,a5,1
80000c4c:	fe442703          	lw	a4,-28(s0)
80000c50:	00f707b3          	add	a5,a4,a5
80000c54:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000c58:	fe042423          	sw	zero,-24(s0)
					break;
80000c5c:	1dc0006f          	j	80000e38 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000c60:	fe442783          	lw	a5,-28(s0)
80000c64:	00178713          	addi	a4,a5,1
80000c68:	fee42223          	sw	a4,-28(s0)
80000c6c:	8000c737          	lui	a4,0x8000c
80000c70:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000c74:	00f707b3          	add	a5,a4,a5
80000c78:	03000713          	li	a4,48
80000c7c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000c80:	fe442783          	lw	a5,-28(s0)
80000c84:	00178713          	addi	a4,a5,1
80000c88:	fee42223          	sw	a4,-28(s0)
80000c8c:	8000c737          	lui	a4,0x8000c
80000c90:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000c94:	00f707b3          	add	a5,a4,a5
80000c98:	07800713          	li	a4,120
80000c9c:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80000ca0:	fb842783          	lw	a5,-72(s0)
80000ca4:	00478713          	addi	a4,a5,4
80000ca8:	fae42c23          	sw	a4,-72(s0)
80000cac:	0007a783          	lw	a5,0(a5)
80000cb0:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80000cb4:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80000cb8:	fd042783          	lw	a5,-48(s0)
80000cbc:	fcf42423          	sw	a5,-56(s0)
80000cc0:	0100006f          	j	80000cd0 <printf+0x21c>
80000cc4:	fcc42783          	lw	a5,-52(s0)
80000cc8:	00178793          	addi	a5,a5,1
80000ccc:	fcf42623          	sw	a5,-52(s0)
80000cd0:	fc842783          	lw	a5,-56(s0)
80000cd4:	0047d793          	srli	a5,a5,0x4
80000cd8:	fcf42423          	sw	a5,-56(s0)
80000cdc:	fc842783          	lw	a5,-56(s0)
80000ce0:	fe0792e3          	bnez	a5,80000cc4 <printf+0x210>
					for(int i=len;i>=0;i--){
80000ce4:	fcc42783          	lw	a5,-52(s0)
80000ce8:	fcf42223          	sw	a5,-60(s0)
80000cec:	0840006f          	j	80000d70 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80000cf0:	fd042783          	lw	a5,-48(s0)
80000cf4:	00f7f713          	andi	a4,a5,15
80000cf8:	00900793          	li	a5,9
80000cfc:	02e7f063          	bgeu	a5,a4,80000d1c <printf+0x268>
80000d00:	fd042783          	lw	a5,-48(s0)
80000d04:	0ff7f793          	andi	a5,a5,255
80000d08:	00f7f793          	andi	a5,a5,15
80000d0c:	0ff7f793          	andi	a5,a5,255
80000d10:	05778793          	addi	a5,a5,87
80000d14:	0ff7f793          	andi	a5,a5,255
80000d18:	01c0006f          	j	80000d34 <printf+0x280>
80000d1c:	fd042783          	lw	a5,-48(s0)
80000d20:	0ff7f793          	andi	a5,a5,255
80000d24:	00f7f793          	andi	a5,a5,15
80000d28:	0ff7f793          	andi	a5,a5,255
80000d2c:	03078793          	addi	a5,a5,48
80000d30:	0ff7f793          	andi	a5,a5,255
80000d34:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80000d38:	fe442703          	lw	a4,-28(s0)
80000d3c:	fc442783          	lw	a5,-60(s0)
80000d40:	00f707b3          	add	a5,a4,a5
80000d44:	8000c737          	lui	a4,0x8000c
80000d48:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000d4c:	00f707b3          	add	a5,a4,a5
80000d50:	fbe44703          	lbu	a4,-66(s0)
80000d54:	00e78023          	sb	a4,0(a5)
						x/=16;
80000d58:	fd042783          	lw	a5,-48(s0)
80000d5c:	0047d793          	srli	a5,a5,0x4
80000d60:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80000d64:	fc442783          	lw	a5,-60(s0)
80000d68:	fff78793          	addi	a5,a5,-1
80000d6c:	fcf42223          	sw	a5,-60(s0)
80000d70:	fc442783          	lw	a5,-60(s0)
80000d74:	f607dee3          	bgez	a5,80000cf0 <printf+0x23c>
					}
					idx+=(len+1);
80000d78:	fcc42783          	lw	a5,-52(s0)
80000d7c:	00178793          	addi	a5,a5,1
80000d80:	fe442703          	lw	a4,-28(s0)
80000d84:	00f707b3          	add	a5,a4,a5
80000d88:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000d8c:	fe042423          	sw	zero,-24(s0)
					break;
80000d90:	0a80006f          	j	80000e38 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80000d94:	fb842783          	lw	a5,-72(s0)
80000d98:	00478713          	addi	a4,a5,4
80000d9c:	fae42c23          	sw	a4,-72(s0)
80000da0:	0007a783          	lw	a5,0(a5)
80000da4:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80000da8:	fe442783          	lw	a5,-28(s0)
80000dac:	00178713          	addi	a4,a5,1
80000db0:	fee42223          	sw	a4,-28(s0)
80000db4:	8000c737          	lui	a4,0x8000c
80000db8:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000dbc:	00f707b3          	add	a5,a4,a5
80000dc0:	fbf44703          	lbu	a4,-65(s0)
80000dc4:	00e78023          	sb	a4,0(a5)
					tt=0;
80000dc8:	fe042423          	sw	zero,-24(s0)
					break;
80000dcc:	06c0006f          	j	80000e38 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80000dd0:	fb842783          	lw	a5,-72(s0)
80000dd4:	00478713          	addi	a4,a5,4
80000dd8:	fae42c23          	sw	a4,-72(s0)
80000ddc:	0007a783          	lw	a5,0(a5)
80000de0:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80000de4:	0300006f          	j	80000e14 <printf+0x360>
						outbuf[idx++]=*ss++;
80000de8:	fc042703          	lw	a4,-64(s0)
80000dec:	00170793          	addi	a5,a4,1
80000df0:	fcf42023          	sw	a5,-64(s0)
80000df4:	fe442783          	lw	a5,-28(s0)
80000df8:	00178693          	addi	a3,a5,1
80000dfc:	fed42223          	sw	a3,-28(s0)
80000e00:	00074703          	lbu	a4,0(a4)
80000e04:	8000c6b7          	lui	a3,0x8000c
80000e08:	00468693          	addi	a3,a3,4 # 8000c004 <memend+0xf800c004>
80000e0c:	00f687b3          	add	a5,a3,a5
80000e10:	00e78023          	sb	a4,0(a5)
					while(*ss){
80000e14:	fc042783          	lw	a5,-64(s0)
80000e18:	0007c783          	lbu	a5,0(a5)
80000e1c:	fc0796e3          	bnez	a5,80000de8 <printf+0x334>
					}
					tt=0;
80000e20:	fe042423          	sw	zero,-24(s0)
					break;
80000e24:	0140006f          	j	80000e38 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80000e28:	800027b7          	lui	a5,0x80002
80000e2c:	29878513          	addi	a0,a5,664 # 80002298 <memend+0xf8002298>
80000e30:	c4dff0ef          	jal	ra,80000a7c <panic>
					break;
80000e34:	00000013          	nop
				}
				s++;
80000e38:	fec42783          	lw	a5,-20(s0)
80000e3c:	00178793          	addi	a5,a5,1
80000e40:	fef42623          	sw	a5,-20(s0)
80000e44:	0300006f          	j	80000e74 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80000e48:	fe442783          	lw	a5,-28(s0)
80000e4c:	00178713          	addi	a4,a5,1
80000e50:	fee42223          	sw	a4,-28(s0)
80000e54:	8000c737          	lui	a4,0x8000c
80000e58:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000e5c:	00f707b3          	add	a5,a4,a5
80000e60:	fbf44703          	lbu	a4,-65(s0)
80000e64:	00e78023          	sb	a4,0(a5)
				s++;
80000e68:	fec42783          	lw	a5,-20(s0)
80000e6c:	00178793          	addi	a5,a5,1
80000e70:	fef42623          	sw	a5,-20(s0)
	while(ch=*(s)){
80000e74:	fec42783          	lw	a5,-20(s0)
80000e78:	0007c783          	lbu	a5,0(a5)
80000e7c:	faf40fa3          	sb	a5,-65(s0)
80000e80:	fbf44783          	lbu	a5,-65(s0)
80000e84:	c80794e3          	bnez	a5,80000b0c <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80000e88:	8000c7b7          	lui	a5,0x8000c
80000e8c:	00478713          	addi	a4,a5,4 # 8000c004 <memend+0xf800c004>
80000e90:	fe442783          	lw	a5,-28(s0)
80000e94:	00f707b3          	add	a5,a4,a5
80000e98:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
80000e9c:	8000c7b7          	lui	a5,0x8000c
80000ea0:	00478513          	addi	a0,a5,4 # 8000c004 <memend+0xf800c004>
80000ea4:	809ff0ef          	jal	ra,800006ac <uartputs>
80000ea8:	00000013          	nop
80000eac:	00078513          	mv	a0,a5
80000eb0:	05c12083          	lw	ra,92(sp)
80000eb4:	05812403          	lw	s0,88(sp)
80000eb8:	08010113          	addi	sp,sp,128
80000ebc:	00008067          	ret

80000ec0 <minit>:
struct
{
    struct pmp* freelist;
}mem;

void minit(){
80000ec0:	fe010113          	addi	sp,sp,-32
80000ec4:	00812e23          	sw	s0,28(sp)
80000ec8:	02010413          	addi	s0,sp,32
        printf("mstart:%p   ",mstart);
        printf("mend:%p\n",mend);
        printf("stack:%p\n",stacks);
    #endif

    char* p=(char*)mstart;
80000ecc:	8000d7b7          	lui	a5,0x8000d
80000ed0:	00078793          	mv	a5,a5
80000ed4:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80000ed8:	0380006f          	j	80000f10 <minit+0x50>
        m=(struct pmp*)p;
80000edc:	fec42783          	lw	a5,-20(s0)
80000ee0:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
80000ee4:	8000c7b7          	lui	a5,0x8000c
80000ee8:	6347a703          	lw	a4,1588(a5) # 8000c634 <memend+0xf800c634>
80000eec:	fe842783          	lw	a5,-24(s0)
80000ef0:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
80000ef4:	8000c7b7          	lui	a5,0x8000c
80000ef8:	fe842703          	lw	a4,-24(s0)
80000efc:	62e7aa23          	sw	a4,1588(a5) # 8000c634 <memend+0xf800c634>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80000f00:	fec42703          	lw	a4,-20(s0)
80000f04:	000017b7          	lui	a5,0x1
80000f08:	00f707b3          	add	a5,a4,a5
80000f0c:	fef42623          	sw	a5,-20(s0)
80000f10:	fec42703          	lw	a4,-20(s0)
80000f14:	000017b7          	lui	a5,0x1
80000f18:	00f70733          	add	a4,a4,a5
80000f1c:	880007b7          	lui	a5,0x88000
80000f20:	00078793          	mv	a5,a5
80000f24:	fae7fce3          	bgeu	a5,a4,80000edc <minit+0x1c>
    }
}
80000f28:	00000013          	nop
80000f2c:	00000013          	nop
80000f30:	01c12403          	lw	s0,28(sp)
80000f34:	02010113          	addi	sp,sp,32
80000f38:	00008067          	ret

80000f3c <palloc>:

void* palloc(){
80000f3c:	fe010113          	addi	sp,sp,-32
80000f40:	00112e23          	sw	ra,28(sp)
80000f44:	00812c23          	sw	s0,24(sp)
80000f48:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80000f4c:	8000c7b7          	lui	a5,0x8000c
80000f50:	6347a783          	lw	a5,1588(a5) # 8000c634 <memend+0xf800c634>
80000f54:	fef42623          	sw	a5,-20(s0)
    if(p)
80000f58:	fec42783          	lw	a5,-20(s0)
80000f5c:	00078c63          	beqz	a5,80000f74 <palloc+0x38>
        mem.freelist=mem.freelist->next;
80000f60:	8000c7b7          	lui	a5,0x8000c
80000f64:	6347a783          	lw	a5,1588(a5) # 8000c634 <memend+0xf800c634>
80000f68:	0007a703          	lw	a4,0(a5)
80000f6c:	8000c7b7          	lui	a5,0x8000c
80000f70:	62e7aa23          	sw	a4,1588(a5) # 8000c634 <memend+0xf800c634>
    if(p)
80000f74:	fec42783          	lw	a5,-20(s0)
80000f78:	00078a63          	beqz	a5,80000f8c <palloc+0x50>
        memset(p,0,PGSIZE);
80000f7c:	00001637          	lui	a2,0x1
80000f80:	00000593          	li	a1,0
80000f84:	fec42503          	lw	a0,-20(s0)
80000f88:	159000ef          	jal	ra,800018e0 <memset>
    return (void*)p;
80000f8c:	fec42783          	lw	a5,-20(s0)
}
80000f90:	00078513          	mv	a0,a5
80000f94:	01c12083          	lw	ra,28(sp)
80000f98:	01812403          	lw	s0,24(sp)
80000f9c:	02010113          	addi	sp,sp,32
80000fa0:	00008067          	ret

80000fa4 <pfree>:

void pfree(void* addr){
80000fa4:	fd010113          	addi	sp,sp,-48
80000fa8:	02812623          	sw	s0,44(sp)
80000fac:	03010413          	addi	s0,sp,48
80000fb0:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80000fb4:	fdc42783          	lw	a5,-36(s0)
80000fb8:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
80000fbc:	8000c7b7          	lui	a5,0x8000c
80000fc0:	6347a703          	lw	a4,1588(a5) # 8000c634 <memend+0xf800c634>
80000fc4:	fec42783          	lw	a5,-20(s0)
80000fc8:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
80000fcc:	8000c7b7          	lui	a5,0x8000c
80000fd0:	fec42703          	lw	a4,-20(s0)
80000fd4:	62e7aa23          	sw	a4,1588(a5) # 8000c634 <memend+0xf800c634>
80000fd8:	00000013          	nop
80000fdc:	02c12403          	lw	s0,44(sp)
80000fe0:	03010113          	addi	sp,sp,48
80000fe4:	00008067          	ret

80000fe8 <r_tp>:
static inline uint32 r_tp(){
80000fe8:	fe010113          	addi	sp,sp,-32
80000fec:	00812e23          	sw	s0,28(sp)
80000ff0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80000ff4:	00020793          	mv	a5,tp
80000ff8:	fef42623          	sw	a5,-20(s0)
    return x;
80000ffc:	fec42783          	lw	a5,-20(s0)
}
80001000:	00078513          	mv	a0,a5
80001004:	01c12403          	lw	s0,28(sp)
80001008:	02010113          	addi	sp,sp,32
8000100c:	00008067          	ret

80001010 <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
80001010:	fe010113          	addi	sp,sp,-32
80001014:	00812e23          	sw	s0,28(sp)
80001018:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
8000101c:	104027f3          	csrr	a5,sie
80001020:	fef42623          	sw	a5,-20(s0)
    return x;
80001024:	fec42783          	lw	a5,-20(s0)
}
80001028:	00078513          	mv	a0,a5
8000102c:	01c12403          	lw	s0,28(sp)
80001030:	02010113          	addi	sp,sp,32
80001034:	00008067          	ret

80001038 <w_sie>:
static inline void w_sie(uint32 x){
80001038:	fe010113          	addi	sp,sp,-32
8000103c:	00812e23          	sw	s0,28(sp)
80001040:	02010413          	addi	s0,sp,32
80001044:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80001048:	fec42783          	lw	a5,-20(s0)
8000104c:	10479073          	csrw	sie,a5
}
80001050:	00000013          	nop
80001054:	01c12403          	lw	s0,28(sp)
80001058:	02010113          	addi	sp,sp,32
8000105c:	00008067          	ret

80001060 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
80001060:	ff010113          	addi	sp,sp,-16
80001064:	00112623          	sw	ra,12(sp)
80001068:	00812423          	sw	s0,8(sp)
8000106c:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
80001070:	0c0007b7          	lui	a5,0xc000
80001074:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001078:	00100713          	li	a4,1
8000107c:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001080:	f69ff0ef          	jal	ra,80000fe8 <r_tp>
80001084:	00050793          	mv	a5,a0
80001088:	00879713          	slli	a4,a5,0x8
8000108c:	0c0027b7          	lui	a5,0xc002
80001090:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001094:	00f707b3          	add	a5,a4,a5
80001098:	00078713          	mv	a4,a5
8000109c:	40000793          	li	a5,1024
800010a0:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800010a4:	f45ff0ef          	jal	ra,80000fe8 <r_tp>
800010a8:	00050713          	mv	a4,a0
800010ac:	000c07b7          	lui	a5,0xc0
800010b0:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800010b4:	00f707b3          	add	a5,a4,a5
800010b8:	00879793          	slli	a5,a5,0x8
800010bc:	00078713          	mv	a4,a5
800010c0:	40000793          	li	a5,1024
800010c4:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
800010c8:	f21ff0ef          	jal	ra,80000fe8 <r_tp>
800010cc:	00050713          	mv	a4,a0
800010d0:	000067b7          	lui	a5,0x6
800010d4:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800010d8:	00f707b3          	add	a5,a4,a5
800010dc:	00d79793          	slli	a5,a5,0xd
800010e0:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800010e4:	f05ff0ef          	jal	ra,80000fe8 <r_tp>
800010e8:	00050793          	mv	a5,a0
800010ec:	00d79713          	slli	a4,a5,0xd
800010f0:	0c2017b7          	lui	a5,0xc201
800010f4:	00f707b3          	add	a5,a4,a5
800010f8:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800010fc:	f15ff0ef          	jal	ra,80001010 <r_sie>
80001100:	00050793          	mv	a5,a0
80001104:	2227e793          	ori	a5,a5,546
80001108:	00078513          	mv	a0,a5
8000110c:	f2dff0ef          	jal	ra,80001038 <w_sie>
}
80001110:	00000013          	nop
80001114:	00c12083          	lw	ra,12(sp)
80001118:	00812403          	lw	s0,8(sp)
8000111c:	01010113          	addi	sp,sp,16
80001120:	00008067          	ret

80001124 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80001124:	ff010113          	addi	sp,sp,-16
80001128:	00112623          	sw	ra,12(sp)
8000112c:	00812423          	sw	s0,8(sp)
80001130:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001134:	eb5ff0ef          	jal	ra,80000fe8 <r_tp>
80001138:	00050793          	mv	a5,a0
8000113c:	00d79713          	slli	a4,a5,0xd
80001140:	0c2017b7          	lui	a5,0xc201
80001144:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001148:	00f707b3          	add	a5,a4,a5
8000114c:	0007a783          	lw	a5,0(a5)
}
80001150:	00078513          	mv	a0,a5
80001154:	00c12083          	lw	ra,12(sp)
80001158:	00812403          	lw	s0,8(sp)
8000115c:	01010113          	addi	sp,sp,16
80001160:	00008067          	ret

80001164 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001164:	fe010113          	addi	sp,sp,-32
80001168:	00112e23          	sw	ra,28(sp)
8000116c:	00812c23          	sw	s0,24(sp)
80001170:	02010413          	addi	s0,sp,32
80001174:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80001178:	e71ff0ef          	jal	ra,80000fe8 <r_tp>
8000117c:	00050793          	mv	a5,a0
80001180:	00d79713          	slli	a4,a5,0xd
80001184:	0c2007b7          	lui	a5,0xc200
80001188:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
8000118c:	00f707b3          	add	a5,a4,a5
80001190:	00078713          	mv	a4,a5
80001194:	fec42783          	lw	a5,-20(s0)
80001198:	00f72023          	sw	a5,0(a4)
8000119c:	00000013          	nop
800011a0:	01c12083          	lw	ra,28(sp)
800011a4:	01812403          	lw	s0,24(sp)
800011a8:	02010113          	addi	sp,sp,32
800011ac:	00008067          	ret

800011b0 <w_satp>:
static inline void w_satp(uint32 x){
800011b0:	fe010113          	addi	sp,sp,-32
800011b4:	00812e23          	sw	s0,28(sp)
800011b8:	02010413          	addi	s0,sp,32
800011bc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800011c0:	fec42783          	lw	a5,-20(s0)
800011c4:	18079073          	csrw	satp,a5
}
800011c8:	00000013          	nop
800011cc:	01c12403          	lw	s0,28(sp)
800011d0:	02010113          	addi	sp,sp,32
800011d4:	00008067          	ret

800011d8 <sfence_vma>:
static inline void sfence_vma(){
800011d8:	ff010113          	addi	sp,sp,-16
800011dc:	00812623          	sw	s0,12(sp)
800011e0:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800011e4:	12000073          	sfence.vma
}
800011e8:	00000013          	nop
800011ec:	00c12403          	lw	s0,12(sp)
800011f0:	01010113          	addi	sp,sp,16
800011f4:	00008067          	ret

800011f8 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
800011f8:	fd010113          	addi	sp,sp,-48
800011fc:	02112623          	sw	ra,44(sp)
80001200:	02812423          	sw	s0,40(sp)
80001204:	03010413          	addi	s0,sp,48
80001208:	fca42e23          	sw	a0,-36(s0)
8000120c:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
80001210:	fd842783          	lw	a5,-40(s0)
80001214:	0167d793          	srli	a5,a5,0x16
80001218:	00279793          	slli	a5,a5,0x2
8000121c:	fdc42703          	lw	a4,-36(s0)
80001220:	00f707b3          	add	a5,a4,a5
80001224:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001228:	fec42783          	lw	a5,-20(s0)
8000122c:	0007a783          	lw	a5,0(a5)
80001230:	0017f793          	andi	a5,a5,1
80001234:	00078e63          	beqz	a5,80001250 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001238:	fec42783          	lw	a5,-20(s0)
8000123c:	0007a783          	lw	a5,0(a5)
80001240:	00a7d793          	srli	a5,a5,0xa
80001244:	00c79793          	slli	a5,a5,0xc
80001248:	fcf42e23          	sw	a5,-36(s0)
8000124c:	0340006f          	j	80001280 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
80001250:	cedff0ef          	jal	ra,80000f3c <palloc>
80001254:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001258:	00001637          	lui	a2,0x1
8000125c:	00000593          	li	a1,0
80001260:	fdc42503          	lw	a0,-36(s0)
80001264:	67c000ef          	jal	ra,800018e0 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001268:	fdc42783          	lw	a5,-36(s0)
8000126c:	00c7d793          	srli	a5,a5,0xc
80001270:	00a79793          	slli	a5,a5,0xa
80001274:	0017e713          	ori	a4,a5,1
80001278:	fec42783          	lw	a5,-20(s0)
8000127c:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001280:	fd842783          	lw	a5,-40(s0)
80001284:	00c7d793          	srli	a5,a5,0xc
80001288:	3ff7f793          	andi	a5,a5,1023
8000128c:	00279793          	slli	a5,a5,0x2
80001290:	fdc42703          	lw	a4,-36(s0)
80001294:	00f707b3          	add	a5,a4,a5
}
80001298:	00078513          	mv	a0,a5
8000129c:	02c12083          	lw	ra,44(sp)
800012a0:	02812403          	lw	s0,40(sp)
800012a4:	03010113          	addi	sp,sp,48
800012a8:	00008067          	ret

800012ac <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
800012ac:	fc010113          	addi	sp,sp,-64
800012b0:	02112e23          	sw	ra,60(sp)
800012b4:	02812c23          	sw	s0,56(sp)
800012b8:	04010413          	addi	s0,sp,64
800012bc:	fca42e23          	sw	a0,-36(s0)
800012c0:	fcb42c23          	sw	a1,-40(s0)
800012c4:	fcc42a23          	sw	a2,-44(s0)
800012c8:	fcd42823          	sw	a3,-48(s0)
800012cc:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
800012d0:	fd842703          	lw	a4,-40(s0)
800012d4:	fffff7b7          	lui	a5,0xfffff
800012d8:	00f777b3          	and	a5,a4,a5
800012dc:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
800012e0:	fd042703          	lw	a4,-48(s0)
800012e4:	fd842783          	lw	a5,-40(s0)
800012e8:	00f707b3          	add	a5,a4,a5
800012ec:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
800012f0:	fffff7b7          	lui	a5,0xfffff
800012f4:	00f777b3          	and	a5,a4,a5
800012f8:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
800012fc:	fec42583          	lw	a1,-20(s0)
80001300:	fdc42503          	lw	a0,-36(s0)
80001304:	ef5ff0ef          	jal	ra,800011f8 <acquriepte>
80001308:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
8000130c:	fe442783          	lw	a5,-28(s0)
80001310:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001314:	0017f793          	andi	a5,a5,1
80001318:	00078863          	beqz	a5,80001328 <vmmap+0x7c>
            panic("repeat map");
8000131c:	800027b7          	lui	a5,0x80002
80001320:	33478513          	addi	a0,a5,820 # 80002334 <memend+0xf8002334>
80001324:	f58ff0ef          	jal	ra,80000a7c <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001328:	fd442783          	lw	a5,-44(s0)
8000132c:	00c7d793          	srli	a5,a5,0xc
80001330:	00a79713          	slli	a4,a5,0xa
80001334:	fcc42783          	lw	a5,-52(s0)
80001338:	00f767b3          	or	a5,a4,a5
8000133c:	0017e713          	ori	a4,a5,1
80001340:	fe442783          	lw	a5,-28(s0)
80001344:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001348:	fec42703          	lw	a4,-20(s0)
8000134c:	fe842783          	lw	a5,-24(s0)
80001350:	02f70463          	beq	a4,a5,80001378 <vmmap+0xcc>
        start += PGSIZE;
80001354:	fec42703          	lw	a4,-20(s0)
80001358:	000017b7          	lui	a5,0x1
8000135c:	00f707b3          	add	a5,a4,a5
80001360:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001364:	fd442703          	lw	a4,-44(s0)
80001368:	000017b7          	lui	a5,0x1
8000136c:	00f707b3          	add	a5,a4,a5
80001370:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001374:	f89ff06f          	j	800012fc <vmmap+0x50>
        if(start==end)  break;
80001378:	00000013          	nop
    }
}
8000137c:	00000013          	nop
80001380:	03c12083          	lw	ra,60(sp)
80001384:	03812403          	lw	s0,56(sp)
80001388:	04010113          	addi	sp,sp,64
8000138c:	00008067          	ret

80001390 <printpgt>:

void printpgt(addr_t* pgt){
80001390:	fc010113          	addi	sp,sp,-64
80001394:	02112e23          	sw	ra,60(sp)
80001398:	02812c23          	sw	s0,56(sp)
8000139c:	04010413          	addi	s0,sp,64
800013a0:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
800013a4:	fe042623          	sw	zero,-20(s0)
800013a8:	0c40006f          	j	8000146c <printpgt+0xdc>
        pte_t pte=pgt[i];
800013ac:	fec42783          	lw	a5,-20(s0)
800013b0:	00279793          	slli	a5,a5,0x2
800013b4:	fcc42703          	lw	a4,-52(s0)
800013b8:	00f707b3          	add	a5,a4,a5
800013bc:	0007a783          	lw	a5,0(a5) # 1000 <sz>
800013c0:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
800013c4:	fe442783          	lw	a5,-28(s0)
800013c8:	0017f793          	andi	a5,a5,1
800013cc:	08078a63          	beqz	a5,80001460 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
800013d0:	fe442783          	lw	a5,-28(s0)
800013d4:	00a7d793          	srli	a5,a5,0xa
800013d8:	00c79793          	slli	a5,a5,0xc
800013dc:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
800013e0:	fe042683          	lw	a3,-32(s0)
800013e4:	fe442603          	lw	a2,-28(s0)
800013e8:	fec42583          	lw	a1,-20(s0)
800013ec:	800027b7          	lui	a5,0x80002
800013f0:	34078513          	addi	a0,a5,832 # 80002340 <memend+0xf8002340>
800013f4:	ec0ff0ef          	jal	ra,80000ab4 <printf>
            for(int j=0;j<1024;j++){
800013f8:	fe042423          	sw	zero,-24(s0)
800013fc:	0580006f          	j	80001454 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001400:	fe842783          	lw	a5,-24(s0)
80001404:	00279793          	slli	a5,a5,0x2
80001408:	fe042703          	lw	a4,-32(s0)
8000140c:	00f707b3          	add	a5,a4,a5
80001410:	0007a783          	lw	a5,0(a5)
80001414:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001418:	fdc42783          	lw	a5,-36(s0)
8000141c:	0017f793          	andi	a5,a5,1
80001420:	02078463          	beqz	a5,80001448 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001424:	fdc42783          	lw	a5,-36(s0)
80001428:	00a7d793          	srli	a5,a5,0xa
8000142c:	00c79793          	slli	a5,a5,0xc
80001430:	00078693          	mv	a3,a5
80001434:	fdc42603          	lw	a2,-36(s0)
80001438:	fe842583          	lw	a1,-24(s0)
8000143c:	800027b7          	lui	a5,0x80002
80001440:	35878513          	addi	a0,a5,856 # 80002358 <memend+0xf8002358>
80001444:	e70ff0ef          	jal	ra,80000ab4 <printf>
            for(int j=0;j<1024;j++){
80001448:	fe842783          	lw	a5,-24(s0)
8000144c:	00178793          	addi	a5,a5,1
80001450:	fef42423          	sw	a5,-24(s0)
80001454:	fe842703          	lw	a4,-24(s0)
80001458:	3ff00793          	li	a5,1023
8000145c:	fae7d2e3          	bge	a5,a4,80001400 <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001460:	fec42783          	lw	a5,-20(s0)
80001464:	00178793          	addi	a5,a5,1
80001468:	fef42623          	sw	a5,-20(s0)
8000146c:	fec42703          	lw	a4,-20(s0)
80001470:	3ff00793          	li	a5,1023
80001474:	f2e7dce3          	bge	a5,a4,800013ac <printpgt+0x1c>
                }
            }
        }
    }
}
80001478:	00000013          	nop
8000147c:	00000013          	nop
80001480:	03c12083          	lw	ra,60(sp)
80001484:	03812403          	lw	s0,56(sp)
80001488:	04010113          	addi	sp,sp,64
8000148c:	00008067          	ret

80001490 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
80001490:	fd010113          	addi	sp,sp,-48
80001494:	02112623          	sw	ra,44(sp)
80001498:	02812423          	sw	s0,40(sp)
8000149c:	03010413          	addi	s0,sp,48
800014a0:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
800014a4:	fe042623          	sw	zero,-20(s0)
800014a8:	04c0006f          	j	800014f4 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
800014ac:	fec42783          	lw	a5,-20(s0)
800014b0:	00d79793          	slli	a5,a5,0xd
800014b4:	00078713          	mv	a4,a5
800014b8:	c00017b7          	lui	a5,0xc0001
800014bc:	00f707b3          	add	a5,a4,a5
800014c0:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
800014c4:	a79ff0ef          	jal	ra,80000f3c <palloc>
800014c8:	00050793          	mv	a5,a0
800014cc:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
800014d0:	00600713          	li	a4,6
800014d4:	000016b7          	lui	a3,0x1
800014d8:	fe442603          	lw	a2,-28(s0)
800014dc:	fe842583          	lw	a1,-24(s0)
800014e0:	fdc42503          	lw	a0,-36(s0)
800014e4:	dc9ff0ef          	jal	ra,800012ac <vmmap>
    for(int i=0;i<NPROC;i++){
800014e8:	fec42783          	lw	a5,-20(s0)
800014ec:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
800014f0:	fef42623          	sw	a5,-20(s0)
800014f4:	fec42703          	lw	a4,-20(s0)
800014f8:	00300793          	li	a5,3
800014fc:	fae7d8e3          	bge	a5,a4,800014ac <mkstack+0x1c>
    }
}
80001500:	00000013          	nop
80001504:	00000013          	nop
80001508:	02c12083          	lw	ra,44(sp)
8000150c:	02812403          	lw	s0,40(sp)
80001510:	03010113          	addi	sp,sp,48
80001514:	00008067          	ret

80001518 <vminit>:

// 初始化虚拟内存
void vminit(){
80001518:	ff010113          	addi	sp,sp,-16
8000151c:	00112623          	sw	ra,12(sp)
80001520:	00812423          	sw	s0,8(sp)
80001524:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001528:	a15ff0ef          	jal	ra,80000f3c <palloc>
8000152c:	00050713          	mv	a4,a0
80001530:	8000c7b7          	lui	a5,0x8000c
80001534:	62e7ac23          	sw	a4,1592(a5) # 8000c638 <memend+0xf800c638>
    memset(kpgt,0,PGSIZE);
80001538:	8000c7b7          	lui	a5,0x8000c
8000153c:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
80001540:	00001637          	lui	a2,0x1
80001544:	00000593          	li	a1,0
80001548:	00078513          	mv	a0,a5
8000154c:	394000ef          	jal	ra,800018e0 <memset>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
80001550:	8000c7b7          	lui	a5,0x8000c
80001554:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
80001558:	00600713          	li	a4,6
8000155c:	004006b7          	lui	a3,0x400
80001560:	0c000637          	lui	a2,0xc000
80001564:	0c0005b7          	lui	a1,0xc000
80001568:	00078513          	mv	a0,a5
8000156c:	d41ff0ef          	jal	ra,800012ac <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
80001570:	8000c7b7          	lui	a5,0x8000c
80001574:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
80001578:	00600713          	li	a4,6
8000157c:	000016b7          	lui	a3,0x1
80001580:	10000637          	lui	a2,0x10000
80001584:	100005b7          	lui	a1,0x10000
80001588:	00078513          	mv	a0,a5
8000158c:	d21ff0ef          	jal	ra,800012ac <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
80001590:	8000c7b7          	lui	a5,0x8000c
80001594:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001598:	800007b7          	lui	a5,0x80000
8000159c:	00078593          	mv	a1,a5
800015a0:	800007b7          	lui	a5,0x80000
800015a4:	00078613          	mv	a2,a5
800015a8:	800027b7          	lui	a5,0x80002
800015ac:	b3078713          	addi	a4,a5,-1232 # 80001b30 <memend+0xf8001b30>
800015b0:	800007b7          	lui	a5,0x80000
800015b4:	00078793          	mv	a5,a5
800015b8:	40f707b3          	sub	a5,a4,a5
800015bc:	00a00713          	li	a4,10
800015c0:	00078693          	mv	a3,a5
800015c4:	ce9ff0ef          	jal	ra,800012ac <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
800015c8:	8000c7b7          	lui	a5,0x8000c
800015cc:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
800015d0:	800027b7          	lui	a5,0x80002
800015d4:	00078593          	mv	a1,a5
800015d8:	800027b7          	lui	a5,0x80002
800015dc:	00078613          	mv	a2,a5
800015e0:	800027b7          	lui	a5,0x80002
800015e4:	36f78713          	addi	a4,a5,879 # 8000236f <memend+0xf800236f>
800015e8:	800027b7          	lui	a5,0x80002
800015ec:	00078793          	mv	a5,a5
800015f0:	40f707b3          	sub	a5,a4,a5
800015f4:	00200713          	li	a4,2
800015f8:	00078693          	mv	a3,a5
800015fc:	cb1ff0ef          	jal	ra,800012ac <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001600:	8000c7b7          	lui	a5,0x8000c
80001604:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001608:	800037b7          	lui	a5,0x80003
8000160c:	00078593          	mv	a1,a5
80001610:	800037b7          	lui	a5,0x80003
80001614:	00078613          	mv	a2,a5
80001618:	8000b7b7          	lui	a5,0x8000b
8000161c:	00478713          	addi	a4,a5,4 # 8000b004 <memend+0xf800b004>
80001620:	800037b7          	lui	a5,0x80003
80001624:	00078793          	mv	a5,a5
80001628:	40f707b3          	sub	a5,a4,a5
8000162c:	00600713          	li	a4,6
80001630:	00078693          	mv	a3,a5
80001634:	c79ff0ef          	jal	ra,800012ac <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001638:	8000c7b7          	lui	a5,0x8000c
8000163c:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001640:	8000c7b7          	lui	a5,0x8000c
80001644:	00078593          	mv	a1,a5
80001648:	8000c7b7          	lui	a5,0x8000c
8000164c:	00078613          	mv	a2,a5
80001650:	8000c7b7          	lui	a5,0x8000c
80001654:	63c78713          	addi	a4,a5,1596 # 8000c63c <memend+0xf800c63c>
80001658:	8000c7b7          	lui	a5,0x8000c
8000165c:	00078793          	mv	a5,a5
80001660:	40f707b3          	sub	a5,a4,a5
80001664:	00600713          	li	a4,6
80001668:	00078693          	mv	a3,a5
8000166c:	c41ff0ef          	jal	ra,800012ac <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001670:	8000c7b7          	lui	a5,0x8000c
80001674:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001678:	8000d7b7          	lui	a5,0x8000d
8000167c:	00078593          	mv	a1,a5
80001680:	8000d7b7          	lui	a5,0x8000d
80001684:	00078613          	mv	a2,a5
80001688:	880007b7          	lui	a5,0x88000
8000168c:	00078713          	mv	a4,a5
80001690:	8000d7b7          	lui	a5,0x8000d
80001694:	00078793          	mv	a5,a5
80001698:	40f707b3          	sub	a5,a4,a5
8000169c:	00600713          	li	a4,6
800016a0:	00078693          	mv	a3,a5
800016a4:	c09ff0ef          	jal	ra,800012ac <vmmap>

    mkstack(kpgt);
800016a8:	8000c7b7          	lui	a5,0x8000c
800016ac:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
800016b0:	00078513          	mv	a0,a5
800016b4:	dddff0ef          	jal	ra,80001490 <mkstack>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
800016b8:	8000c7b7          	lui	a5,0x8000c
800016bc:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
800016c0:	00c7d713          	srli	a4,a5,0xc
800016c4:	800007b7          	lui	a5,0x80000
800016c8:	00f767b3          	or	a5,a4,a5
800016cc:	00078513          	mv	a0,a5
800016d0:	ae1ff0ef          	jal	ra,800011b0 <w_satp>
    sfence_vma();       // 刷新页表
800016d4:	b05ff0ef          	jal	ra,800011d8 <sfence_vma>
}
800016d8:	00000013          	nop
800016dc:	00c12083          	lw	ra,12(sp)
800016e0:	00812403          	lw	s0,8(sp)
800016e4:	01010113          	addi	sp,sp,16
800016e8:	00008067          	ret

800016ec <pgtcreate>:

addr_t* pgtcreate(){
800016ec:	fe010113          	addi	sp,sp,-32
800016f0:	00112e23          	sw	ra,28(sp)
800016f4:	00812c23          	sw	s0,24(sp)
800016f8:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=palloc();
800016fc:	841ff0ef          	jal	ra,80000f3c <palloc>
80001700:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001704:	fec42783          	lw	a5,-20(s0)
}
80001708:	00078513          	mv	a0,a5
8000170c:	01c12083          	lw	ra,28(sp)
80001710:	01812403          	lw	s0,24(sp)
80001714:	02010113          	addi	sp,sp,32
80001718:	00008067          	ret

8000171c <procinit>:
#include "proc.h"
#include "vm.h"

uint nextpid=0;

void procinit(){
8000171c:	fe010113          	addi	sp,sp,-32
80001720:	00812e23          	sw	s0,28(sp)
80001724:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001728:	fe042623          	sw	zero,-20(s0)
8000172c:	0480006f          	j	80001774 <procinit+0x58>
        p=&proc[i];
80001730:	fec42703          	lw	a4,-20(s0)
80001734:	08c00793          	li	a5,140
80001738:	02f70733          	mul	a4,a4,a5
8000173c:	8000c7b7          	lui	a5,0x8000c
80001740:	40478793          	addi	a5,a5,1028 # 8000c404 <memend+0xf800c404>
80001744:	00f707b3          	add	a5,a4,a5
80001748:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
8000174c:	fec42783          	lw	a5,-20(s0)
80001750:	00d79793          	slli	a5,a5,0xd
80001754:	00078713          	mv	a4,a5
80001758:	c00027b7          	lui	a5,0xc0002
8000175c:	00f70733          	add	a4,a4,a5
80001760:	fe842783          	lw	a5,-24(s0)
80001764:	08e7a423          	sw	a4,136(a5) # c0002088 <memend+0x38002088>
    for(int i=0;i<NPROC;i++){
80001768:	fec42783          	lw	a5,-20(s0)
8000176c:	00178793          	addi	a5,a5,1
80001770:	fef42623          	sw	a5,-20(s0)
80001774:	fec42703          	lw	a4,-20(s0)
80001778:	00300793          	li	a5,3
8000177c:	fae7dae3          	bge	a5,a4,80001730 <procinit+0x14>
    }
}
80001780:	00000013          	nop
80001784:	00000013          	nop
80001788:	01c12403          	lw	s0,28(sp)
8000178c:	02010113          	addi	sp,sp,32
80001790:	00008067          	ret

80001794 <pidalloc>:

uint pidalloc(){
80001794:	ff010113          	addi	sp,sp,-16
80001798:	00812623          	sw	s0,12(sp)
8000179c:	01010413          	addi	s0,sp,16
    return nextpid++;
800017a0:	8000c7b7          	lui	a5,0x8000c
800017a4:	0007a783          	lw	a5,0(a5) # 8000c000 <memend+0xf800c000>
800017a8:	00178693          	addi	a3,a5,1
800017ac:	8000c737          	lui	a4,0x8000c
800017b0:	00d72023          	sw	a3,0(a4) # 8000c000 <memend+0xf800c000>
} 
800017b4:	00078513          	mv	a0,a5
800017b8:	00c12403          	lw	s0,12(sp)
800017bc:	01010113          	addi	sp,sp,16
800017c0:	00008067          	ret

800017c4 <procalloc>:

struct pcb* procalloc(){
800017c4:	fe010113          	addi	sp,sp,-32
800017c8:	00112e23          	sw	ra,28(sp)
800017cc:	00812c23          	sw	s0,24(sp)
800017d0:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
800017d4:	8000c7b7          	lui	a5,0x8000c
800017d8:	40478793          	addi	a5,a5,1028 # 8000c404 <memend+0xf800c404>
800017dc:	fef42623          	sw	a5,-20(s0)
800017e0:	0540006f          	j	80001834 <procalloc+0x70>
        if(p->status==UNUSED){
800017e4:	fec42783          	lw	a5,-20(s0)
800017e8:	0047a783          	lw	a5,4(a5)
800017ec:	02079e63          	bnez	a5,80001828 <procalloc+0x64>
            p->pid=pidalloc();
800017f0:	fa5ff0ef          	jal	ra,80001794 <pidalloc>
800017f4:	00050793          	mv	a5,a0
800017f8:	00078713          	mv	a4,a5
800017fc:	fec42783          	lw	a5,-20(s0)
80001800:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80001804:	fec42783          	lw	a5,-20(s0)
80001808:	00100713          	li	a4,1
8000180c:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
80001810:	eddff0ef          	jal	ra,800016ec <pgtcreate>
80001814:	00050713          	mv	a4,a0
80001818:	fec42783          	lw	a5,-20(s0)
8000181c:	08e7a223          	sw	a4,132(a5)
            return p;
80001820:	fec42783          	lw	a5,-20(s0)
80001824:	0240006f          	j	80001848 <procalloc+0x84>
    for(p=proc;p<&proc[NPROC];p++){
80001828:	fec42783          	lw	a5,-20(s0)
8000182c:	08c78793          	addi	a5,a5,140
80001830:	fef42623          	sw	a5,-20(s0)
80001834:	fec42703          	lw	a4,-20(s0)
80001838:	8000c7b7          	lui	a5,0x8000c
8000183c:	63478793          	addi	a5,a5,1588 # 8000c634 <memend+0xf800c634>
80001840:	faf762e3          	bltu	a4,a5,800017e4 <procalloc+0x20>
        }
    }
    return 0;
80001844:	00000793          	li	a5,0
}
80001848:	00078513          	mv	a0,a5
8000184c:	01c12083          	lw	ra,28(sp)
80001850:	01812403          	lw	s0,24(sp)
80001854:	02010113          	addi	sp,sp,32
80001858:	00008067          	ret

8000185c <userinit>:

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
8000185c:	fe010113          	addi	sp,sp,-32
80001860:	00112e23          	sw	ra,28(sp)
80001864:	00812c23          	sw	s0,24(sp)
80001868:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
8000186c:	f59ff0ef          	jal	ra,800017c4 <procalloc>
80001870:	fea42623          	sw	a0,-20(s0)
    
    char* m=palloc();
80001874:	ec8ff0ef          	jal	ra,80000f3c <palloc>
80001878:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
8000187c:	00400613          	li	a2,4
80001880:	00000693          	li	a3,0
80001884:	800037b7          	lui	a5,0x80003
80001888:	00078593          	mv	a1,a5
8000188c:	fe842503          	lw	a0,-24(s0)
80001890:	0bc000ef          	jal	ra,8000194c <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X);
80001894:	fec42783          	lw	a5,-20(s0)
80001898:	0847a783          	lw	a5,132(a5) # 80003084 <memend+0xf8003084>
8000189c:	fe842603          	lw	a2,-24(s0)
800018a0:	00e00713          	li	a4,14
800018a4:	000016b7          	lui	a3,0x1
800018a8:	00000593          	li	a1,0
800018ac:	00078513          	mv	a0,a5
800018b0:	9fdff0ef          	jal	ra,800012ac <vmmap>

    p->context.sp=KSPACE;
800018b4:	fec42783          	lw	a5,-20(s0)
800018b8:	c0000737          	lui	a4,0xc0000
800018bc:	00e7a623          	sw	a4,12(a5)

    p->status=RUNABLE;
800018c0:	fec42783          	lw	a5,-20(s0)
800018c4:	00200713          	li	a4,2
800018c8:	00e7a223          	sw	a4,4(a5)
800018cc:	00000013          	nop
800018d0:	01c12083          	lw	ra,28(sp)
800018d4:	01812403          	lw	s0,24(sp)
800018d8:	02010113          	addi	sp,sp,32
800018dc:	00008067          	ret

800018e0 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
800018e0:	fd010113          	addi	sp,sp,-48
800018e4:	02812623          	sw	s0,44(sp)
800018e8:	03010413          	addi	s0,sp,48
800018ec:	fca42e23          	sw	a0,-36(s0)
800018f0:	fcb42c23          	sw	a1,-40(s0)
800018f4:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
800018f8:	fdc42783          	lw	a5,-36(s0)
800018fc:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001900:	fe042623          	sw	zero,-20(s0)
80001904:	0280006f          	j	8000192c <memset+0x4c>
        maddr[i] = (char)c;
80001908:	fe842703          	lw	a4,-24(s0)
8000190c:	fec42783          	lw	a5,-20(s0)
80001910:	00f707b3          	add	a5,a4,a5
80001914:	fd842703          	lw	a4,-40(s0)
80001918:	0ff77713          	andi	a4,a4,255
8000191c:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001920:	fec42783          	lw	a5,-20(s0)
80001924:	00178793          	addi	a5,a5,1
80001928:	fef42623          	sw	a5,-20(s0)
8000192c:	fec42703          	lw	a4,-20(s0)
80001930:	fd442783          	lw	a5,-44(s0)
80001934:	fcf76ae3          	bltu	a4,a5,80001908 <memset+0x28>
    }
    return addr;
80001938:	fdc42783          	lw	a5,-36(s0)
}
8000193c:	00078513          	mv	a0,a5
80001940:	02c12403          	lw	s0,44(sp)
80001944:	03010113          	addi	sp,sp,48
80001948:	00008067          	ret

8000194c <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
8000194c:	fd010113          	addi	sp,sp,-48
80001950:	02812623          	sw	s0,44(sp)
80001954:	03010413          	addi	s0,sp,48
80001958:	fca42e23          	sw	a0,-36(s0)
8000195c:	fcb42c23          	sw	a1,-40(s0)
80001960:	fcc42823          	sw	a2,-48(s0)
80001964:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001968:	fd042783          	lw	a5,-48(s0)
8000196c:	fd442703          	lw	a4,-44(s0)
80001970:	00e7e7b3          	or	a5,a5,a4
80001974:	00079663          	bnez	a5,80001980 <memmove+0x34>
        return dst;
80001978:	fdc42783          	lw	a5,-36(s0)
8000197c:	1200006f          	j	80001a9c <memmove+0x150>
    }

    s = src;
80001980:	fd842783          	lw	a5,-40(s0)
80001984:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001988:	fdc42783          	lw	a5,-36(s0)
8000198c:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001990:	fec42703          	lw	a4,-20(s0)
80001994:	fe842783          	lw	a5,-24(s0)
80001998:	0cf77263          	bgeu	a4,a5,80001a5c <memmove+0x110>
8000199c:	fd042783          	lw	a5,-48(s0)
800019a0:	fec42703          	lw	a4,-20(s0)
800019a4:	00f707b3          	add	a5,a4,a5
800019a8:	fe842703          	lw	a4,-24(s0)
800019ac:	0af77863          	bgeu	a4,a5,80001a5c <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
800019b0:	fd042783          	lw	a5,-48(s0)
800019b4:	fec42703          	lw	a4,-20(s0)
800019b8:	00f707b3          	add	a5,a4,a5
800019bc:	fef42623          	sw	a5,-20(s0)
        d += n;
800019c0:	fd042783          	lw	a5,-48(s0)
800019c4:	fe842703          	lw	a4,-24(s0)
800019c8:	00f707b3          	add	a5,a4,a5
800019cc:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
800019d0:	02c0006f          	j	800019fc <memmove+0xb0>
            *--d = *--s;
800019d4:	fec42783          	lw	a5,-20(s0)
800019d8:	fff78793          	addi	a5,a5,-1
800019dc:	fef42623          	sw	a5,-20(s0)
800019e0:	fe842783          	lw	a5,-24(s0)
800019e4:	fff78793          	addi	a5,a5,-1
800019e8:	fef42423          	sw	a5,-24(s0)
800019ec:	fec42783          	lw	a5,-20(s0)
800019f0:	0007c703          	lbu	a4,0(a5)
800019f4:	fe842783          	lw	a5,-24(s0)
800019f8:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
800019fc:	fd042703          	lw	a4,-48(s0)
80001a00:	fd442783          	lw	a5,-44(s0)
80001a04:	fff00513          	li	a0,-1
80001a08:	fff00593          	li	a1,-1
80001a0c:	00a70633          	add	a2,a4,a0
80001a10:	00060813          	mv	a6,a2
80001a14:	00e83833          	sltu	a6,a6,a4
80001a18:	00b786b3          	add	a3,a5,a1
80001a1c:	00d805b3          	add	a1,a6,a3
80001a20:	00058693          	mv	a3,a1
80001a24:	fcc42823          	sw	a2,-48(s0)
80001a28:	fcd42a23          	sw	a3,-44(s0)
80001a2c:	00070693          	mv	a3,a4
80001a30:	00f6e6b3          	or	a3,a3,a5
80001a34:	fa0690e3          	bnez	a3,800019d4 <memmove+0x88>
    if(s < d && s + n > d){     
80001a38:	0600006f          	j	80001a98 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80001a3c:	fec42703          	lw	a4,-20(s0)
80001a40:	00170793          	addi	a5,a4,1 # c0000001 <memend+0x38000001>
80001a44:	fef42623          	sw	a5,-20(s0)
80001a48:	fe842783          	lw	a5,-24(s0)
80001a4c:	00178693          	addi	a3,a5,1
80001a50:	fed42423          	sw	a3,-24(s0)
80001a54:	00074703          	lbu	a4,0(a4)
80001a58:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80001a5c:	fd042703          	lw	a4,-48(s0)
80001a60:	fd442783          	lw	a5,-44(s0)
80001a64:	fff00513          	li	a0,-1
80001a68:	fff00593          	li	a1,-1
80001a6c:	00a70633          	add	a2,a4,a0
80001a70:	00060813          	mv	a6,a2
80001a74:	00e83833          	sltu	a6,a6,a4
80001a78:	00b786b3          	add	a3,a5,a1
80001a7c:	00d805b3          	add	a1,a6,a3
80001a80:	00058693          	mv	a3,a1
80001a84:	fcc42823          	sw	a2,-48(s0)
80001a88:	fcd42a23          	sw	a3,-44(s0)
80001a8c:	00070693          	mv	a3,a4
80001a90:	00f6e6b3          	or	a3,a3,a5
80001a94:	fa0694e3          	bnez	a3,80001a3c <memmove+0xf0>
        }
    }
    return dst;
80001a98:	fdc42783          	lw	a5,-36(s0)
}
80001a9c:	00078513          	mv	a0,a5
80001aa0:	02c12403          	lw	s0,44(sp)
80001aa4:	03010113          	addi	sp,sp,48
80001aa8:	00008067          	ret

80001aac <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80001aac:	fd010113          	addi	sp,sp,-48
80001ab0:	02812623          	sw	s0,44(sp)
80001ab4:	03010413          	addi	s0,sp,48
80001ab8:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80001abc:	00000793          	li	a5,0
80001ac0:	00000813          	li	a6,0
80001ac4:	fef42423          	sw	a5,-24(s0)
80001ac8:	ff042623          	sw	a6,-20(s0)
80001acc:	0340006f          	j	80001b00 <strlen+0x54>
80001ad0:	fe842603          	lw	a2,-24(s0)
80001ad4:	fec42683          	lw	a3,-20(s0)
80001ad8:	00100513          	li	a0,1
80001adc:	00000593          	li	a1,0
80001ae0:	00a60733          	add	a4,a2,a0
80001ae4:	00070813          	mv	a6,a4
80001ae8:	00c83833          	sltu	a6,a6,a2
80001aec:	00b687b3          	add	a5,a3,a1
80001af0:	00f806b3          	add	a3,a6,a5
80001af4:	00068793          	mv	a5,a3
80001af8:	fee42423          	sw	a4,-24(s0)
80001afc:	fef42623          	sw	a5,-20(s0)
80001b00:	fe842783          	lw	a5,-24(s0)
80001b04:	fdc42703          	lw	a4,-36(s0)
80001b08:	00f707b3          	add	a5,a4,a5
80001b0c:	0007c783          	lbu	a5,0(a5)
80001b10:	fc0790e3          	bnez	a5,80001ad0 <strlen+0x24>
    
    return n;
80001b14:	fe842703          	lw	a4,-24(s0)
80001b18:	fec42783          	lw	a5,-20(s0)
80001b1c:	00070513          	mv	a0,a4
80001b20:	00078593          	mv	a1,a5
80001b24:	02c12403          	lw	s0,44(sp)
80001b28:	03010113          	addi	sp,sp,48
80001b2c:	00008067          	ret
