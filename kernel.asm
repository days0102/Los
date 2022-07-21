
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
80000020:	5fc0006f          	j	8000061c <start>

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
800000ac:	0a9000ef          	jal	ra,80000954 <trapvec>

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

80000134 <swtch>:
// swtch(struct context* old,struct context* new)
// 保存 old,加载 new ; old->a0,new->a1

.global swtch
swtch:
    sw ra,0(a0)
80000134:	00152023          	sw	ra,0(a0)
    sw sp,4(a0)
80000138:	00252223          	sw	sp,4(a0)
    sw gp,8(a0)
8000013c:	00352423          	sw	gp,8(a0)
    sw tp,12(a0)
80000140:	00452623          	sw	tp,12(a0)
    sw a0,16(a0)
80000144:	00a52823          	sw	a0,16(a0)
    sw a1,20(a0)
80000148:	00b52a23          	sw	a1,20(a0)
    sw a2,24(a0)
8000014c:	00c52c23          	sw	a2,24(a0)
    sw a3,28(a0)
80000150:	00d52e23          	sw	a3,28(a0)
    sw a4,32(a0)
80000154:	02e52023          	sw	a4,32(a0)
    sw a5,36(a0)
80000158:	02f52223          	sw	a5,36(a0)
    sw a6,40(a0)
8000015c:	03052423          	sw	a6,40(a0)
    sw a7,44(a0)
80000160:	03152623          	sw	a7,44(a0)
    sw s0,48(a0)
80000164:	02852823          	sw	s0,48(a0)
    sw s1,52(a0)
80000168:	02952a23          	sw	s1,52(a0)
    sw s2,56(a0)
8000016c:	03252c23          	sw	s2,56(a0)
    sw s3,60(a0)
80000170:	03352e23          	sw	s3,60(a0)
    sw s4,64(a0)
80000174:	05452023          	sw	s4,64(a0)
    sw s5,68(a0)
80000178:	05552223          	sw	s5,68(a0)
    sw s6,72(a0)
8000017c:	05652423          	sw	s6,72(a0)
    sw s7,76(a0)
80000180:	05752623          	sw	s7,76(a0)
    sw s8,80(a0)
80000184:	05852823          	sw	s8,80(a0)
    sw s9,84(a0)
80000188:	05952a23          	sw	s9,84(a0)
    sw s10,88(a0)
8000018c:	05a52c23          	sw	s10,88(a0)
    sw s11,92(a0)
80000190:	05b52e23          	sw	s11,92(a0)
    sw t0,96(a0)
80000194:	06552023          	sw	t0,96(a0)
    sw t1,100(a0)
80000198:	06652223          	sw	t1,100(a0)
    sw t2,104(a0)
8000019c:	06752423          	sw	t2,104(a0)
    sw t3,108(a0)
800001a0:	07c52623          	sw	t3,108(a0)
    sw t4,112(a0)
800001a4:	07d52823          	sw	t4,112(a0)
    sw t5,116(a0)
800001a8:	07e52a23          	sw	t5,116(a0)
    sw t6,120(a0)
800001ac:	07f52c23          	sw	t6,120(a0)


    # lw ra,0(a1)
    # lw sp,4(a1)
    lw gp,8(a1)
800001b0:	0085a183          	lw	gp,8(a1)
    lw tp,12(a1)
800001b4:	00c5a203          	lw	tp,12(a1)
    lw a0,16(a1)
800001b8:	0105a503          	lw	a0,16(a1)
    // a1
    lw a2,24(a1)
800001bc:	0185a603          	lw	a2,24(a1)
    lw a3,28(a1)
800001c0:	01c5a683          	lw	a3,28(a1)
    lw a4,32(a1)
800001c4:	0205a703          	lw	a4,32(a1)
    lw a5,36(a1)
800001c8:	0245a783          	lw	a5,36(a1)
    lw a6,40(a1)
800001cc:	0285a803          	lw	a6,40(a1)
    lw a7,44(a1)
800001d0:	02c5a883          	lw	a7,44(a1)
    lw s0,48(a1)
800001d4:	0305a403          	lw	s0,48(a1)
    lw s1,52(a1)
800001d8:	0345a483          	lw	s1,52(a1)
    lw s2,56(a1)
800001dc:	0385a903          	lw	s2,56(a1)
    lw s3,60(a1)
800001e0:	03c5a983          	lw	s3,60(a1)
    lw s4,64(a1)
800001e4:	0405aa03          	lw	s4,64(a1)
    lw s5,68(a1)
800001e8:	0445aa83          	lw	s5,68(a1)
    lw s6,72(a1)
800001ec:	0485ab03          	lw	s6,72(a1)
    lw s7,76(a1)
800001f0:	04c5ab83          	lw	s7,76(a1)
    lw s8,80(a1)
800001f4:	0505ac03          	lw	s8,80(a1)
    lw s9,84(a1)
800001f8:	0545ac83          	lw	s9,84(a1)
    lw s10,88(a1)
800001fc:	0585ad03          	lw	s10,88(a1)
    lw s11,92(a1)
80000200:	05c5ad83          	lw	s11,92(a1)
    lw t0,96(a1)
80000204:	0605a283          	lw	t0,96(a1)
    lw t1,100(a1)
80000208:	0645a303          	lw	t1,100(a1)
    lw t2,104(a1)
8000020c:	0685a383          	lw	t2,104(a1)
    lw t3,108(a1)
80000210:	06c5ae03          	lw	t3,108(a1)
    lw t4,112(a1)
80000214:	0705ae83          	lw	t4,112(a1)
    lw t5,116(a1)
80000218:	0745af03          	lw	t5,116(a1)
    lw t6,120(a1)
8000021c:	0785af83          	lw	t6,120(a1)

    lw a1,20(a1)
80000220:	0145a583          	lw	a1,20(a1)

80000224:	00008067          	ret

80000228 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80000228:	fe010113          	addi	sp,sp,-32
8000022c:	00812e23          	sw	s0,28(sp)
80000230:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80000234:	300027f3          	csrr	a5,mstatus
80000238:	fef42623          	sw	a5,-20(s0)
    return x;
8000023c:	fec42783          	lw	a5,-20(s0)
}
80000240:	00078513          	mv	a0,a5
80000244:	01c12403          	lw	s0,28(sp)
80000248:	02010113          	addi	sp,sp,32
8000024c:	00008067          	ret

80000250 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
80000250:	fe010113          	addi	sp,sp,-32
80000254:	00812e23          	sw	s0,28(sp)
80000258:	02010413          	addi	s0,sp,32
8000025c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80000260:	fec42783          	lw	a5,-20(s0)
80000264:	30079073          	csrw	mstatus,a5
}
80000268:	00000013          	nop
8000026c:	01c12403          	lw	s0,28(sp)
80000270:	02010113          	addi	sp,sp,32
80000274:	00008067          	ret

80000278 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000278:	fd010113          	addi	sp,sp,-48
8000027c:	02112623          	sw	ra,44(sp)
80000280:	02812423          	sw	s0,40(sp)
80000284:	03010413          	addi	s0,sp,48
80000288:	00050793          	mv	a5,a0
8000028c:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
80000290:	f99ff0ef          	jal	ra,80000228 <r_mstatus>
80000294:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000298:	fdf44783          	lbu	a5,-33(s0)
8000029c:	00300713          	li	a4,3
800002a0:	06e78063          	beq	a5,a4,80000300 <s_mstatus_xpp+0x88>
800002a4:	00300713          	li	a4,3
800002a8:	08f74263          	blt	a4,a5,8000032c <s_mstatus_xpp+0xb4>
800002ac:	00078863          	beqz	a5,800002bc <s_mstatus_xpp+0x44>
800002b0:	00100713          	li	a4,1
800002b4:	02e78063          	beq	a5,a4,800002d4 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800002b8:	0740006f          	j	8000032c <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800002bc:	fec42703          	lw	a4,-20(s0)
800002c0:	ffffe7b7          	lui	a5,0xffffe
800002c4:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800002c8:	00f777b3          	and	a5,a4,a5
800002cc:	fef42623          	sw	a5,-20(s0)
        break;
800002d0:	0600006f          	j	80000330 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800002d4:	fec42703          	lw	a4,-20(s0)
800002d8:	ffffe7b7          	lui	a5,0xffffe
800002dc:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800002e0:	00f777b3          	and	a5,a4,a5
800002e4:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
800002e8:	fec42703          	lw	a4,-20(s0)
800002ec:	000017b7          	lui	a5,0x1
800002f0:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
800002f4:	00f767b3          	or	a5,a4,a5
800002f8:	fef42623          	sw	a5,-20(s0)
        break;
800002fc:	0340006f          	j	80000330 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80000300:	fec42703          	lw	a4,-20(s0)
80000304:	ffffe7b7          	lui	a5,0xffffe
80000308:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
8000030c:	00f777b3          	and	a5,a4,a5
80000310:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
80000314:	fec42703          	lw	a4,-20(s0)
80000318:	000027b7          	lui	a5,0x2
8000031c:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
80000320:	00f767b3          	or	a5,a4,a5
80000324:	fef42623          	sw	a5,-20(s0)
        break;
80000328:	0080006f          	j	80000330 <s_mstatus_xpp+0xb8>
        break;
8000032c:	00000013          	nop
    }
    w_mstatus(x);
80000330:	fec42503          	lw	a0,-20(s0)
80000334:	f1dff0ef          	jal	ra,80000250 <w_mstatus>
}
80000338:	00000013          	nop
8000033c:	02c12083          	lw	ra,44(sp)
80000340:	02812403          	lw	s0,40(sp)
80000344:	03010113          	addi	sp,sp,48
80000348:	00008067          	ret

8000034c <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
8000034c:	fe010113          	addi	sp,sp,-32
80000350:	00812e23          	sw	s0,28(sp)
80000354:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000358:	100027f3          	csrr	a5,sstatus
8000035c:	fef42623          	sw	a5,-20(s0)
    return x;
80000360:	fec42783          	lw	a5,-20(s0)
}
80000364:	00078513          	mv	a0,a5
80000368:	01c12403          	lw	s0,28(sp)
8000036c:	02010113          	addi	sp,sp,32
80000370:	00008067          	ret

80000374 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
80000374:	fe010113          	addi	sp,sp,-32
80000378:	00812e23          	sw	s0,28(sp)
8000037c:	02010413          	addi	s0,sp,32
80000380:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
80000384:	fec42783          	lw	a5,-20(s0)
80000388:	10079073          	csrw	sstatus,a5
}
8000038c:	00000013          	nop
80000390:	01c12403          	lw	s0,28(sp)
80000394:	02010113          	addi	sp,sp,32
80000398:	00008067          	ret

8000039c <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
8000039c:	fe010113          	addi	sp,sp,-32
800003a0:	00812e23          	sw	s0,28(sp)
800003a4:	02010413          	addi	s0,sp,32
800003a8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
800003ac:	fec42783          	lw	a5,-20(s0)
800003b0:	34179073          	csrw	mepc,a5
}
800003b4:	00000013          	nop
800003b8:	01c12403          	lw	s0,28(sp)
800003bc:	02010113          	addi	sp,sp,32
800003c0:	00008067          	ret

800003c4 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
800003c4:	fe010113          	addi	sp,sp,-32
800003c8:	00812e23          	sw	s0,28(sp)
800003cc:	02010413          	addi	s0,sp,32
800003d0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
800003d4:	fec42783          	lw	a5,-20(s0)
800003d8:	10579073          	csrw	stvec,a5
}
800003dc:	00000013          	nop
800003e0:	01c12403          	lw	s0,28(sp)
800003e4:	02010113          	addi	sp,sp,32
800003e8:	00008067          	ret

800003ec <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
800003ec:	fe010113          	addi	sp,sp,-32
800003f0:	00812e23          	sw	s0,28(sp)
800003f4:	02010413          	addi	s0,sp,32
800003f8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
800003fc:	fec42783          	lw	a5,-20(s0)
80000400:	30379073          	csrw	mideleg,a5
}
80000404:	00000013          	nop
80000408:	01c12403          	lw	s0,28(sp)
8000040c:	02010113          	addi	sp,sp,32
80000410:	00008067          	ret

80000414 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
80000414:	fe010113          	addi	sp,sp,-32
80000418:	00812e23          	sw	s0,28(sp)
8000041c:	02010413          	addi	s0,sp,32
80000420:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
80000424:	fec42783          	lw	a5,-20(s0)
80000428:	30279073          	csrw	medeleg,a5
}
8000042c:	00000013          	nop
80000430:	01c12403          	lw	s0,28(sp)
80000434:	02010113          	addi	sp,sp,32
80000438:	00008067          	ret

8000043c <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
8000043c:	fe010113          	addi	sp,sp,-32
80000440:	00812e23          	sw	s0,28(sp)
80000444:	02010413          	addi	s0,sp,32
80000448:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
8000044c:	fec42783          	lw	a5,-20(s0)
80000450:	18079073          	csrw	satp,a5
}
80000454:	00000013          	nop
80000458:	01c12403          	lw	s0,28(sp)
8000045c:	02010113          	addi	sp,sp,32
80000460:	00008067          	ret

80000464 <s_mstatus_intr>:
        break;
    }
    return x;
}

static inline void s_mstatus_intr(uint32 m){
80000464:	fd010113          	addi	sp,sp,-48
80000468:	02112623          	sw	ra,44(sp)
8000046c:	02812423          	sw	s0,40(sp)
80000470:	03010413          	addi	s0,sp,48
80000474:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80000478:	db1ff0ef          	jal	ra,80000228 <r_mstatus>
8000047c:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000480:	fdc42703          	lw	a4,-36(s0)
80000484:	08000793          	li	a5,128
80000488:	04f70263          	beq	a4,a5,800004cc <s_mstatus_intr+0x68>
8000048c:	fdc42703          	lw	a4,-36(s0)
80000490:	08000793          	li	a5,128
80000494:	0ae7e463          	bltu	a5,a4,8000053c <s_mstatus_intr+0xd8>
80000498:	fdc42703          	lw	a4,-36(s0)
8000049c:	02000793          	li	a5,32
800004a0:	04f70463          	beq	a4,a5,800004e8 <s_mstatus_intr+0x84>
800004a4:	fdc42703          	lw	a4,-36(s0)
800004a8:	02000793          	li	a5,32
800004ac:	08e7e863          	bltu	a5,a4,8000053c <s_mstatus_intr+0xd8>
800004b0:	fdc42703          	lw	a4,-36(s0)
800004b4:	00200793          	li	a5,2
800004b8:	06f70463          	beq	a4,a5,80000520 <s_mstatus_intr+0xbc>
800004bc:	fdc42703          	lw	a4,-36(s0)
800004c0:	00800793          	li	a5,8
800004c4:	04f70063          	beq	a4,a5,80000504 <s_mstatus_intr+0xa0>
    case INTR_SIE:
        x &= ~INTR_SIE;
        x |= INTR_SIE;
        break;
    default:
        break;
800004c8:	0740006f          	j	8000053c <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
800004cc:	fec42783          	lw	a5,-20(s0)
800004d0:	f7f7f793          	andi	a5,a5,-129
800004d4:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
800004d8:	fec42783          	lw	a5,-20(s0)
800004dc:	0807e793          	ori	a5,a5,128
800004e0:	fef42623          	sw	a5,-20(s0)
        break;
800004e4:	05c0006f          	j	80000540 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800004e8:	fec42783          	lw	a5,-20(s0)
800004ec:	fdf7f793          	andi	a5,a5,-33
800004f0:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
800004f4:	fec42783          	lw	a5,-20(s0)
800004f8:	0207e793          	ori	a5,a5,32
800004fc:	fef42623          	sw	a5,-20(s0)
        break;
80000500:	0400006f          	j	80000540 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
80000504:	fec42783          	lw	a5,-20(s0)
80000508:	ff77f793          	andi	a5,a5,-9
8000050c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80000510:	fec42783          	lw	a5,-20(s0)
80000514:	0087e793          	ori	a5,a5,8
80000518:	fef42623          	sw	a5,-20(s0)
        break;
8000051c:	0240006f          	j	80000540 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80000520:	fec42783          	lw	a5,-20(s0)
80000524:	ffd7f793          	andi	a5,a5,-3
80000528:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
8000052c:	fec42783          	lw	a5,-20(s0)
80000530:	0027e793          	ori	a5,a5,2
80000534:	fef42623          	sw	a5,-20(s0)
        break;
80000538:	0080006f          	j	80000540 <s_mstatus_intr+0xdc>
        break;
8000053c:	00000013          	nop
    }
    w_mstatus(x);
80000540:	fec42503          	lw	a0,-20(s0)
80000544:	d0dff0ef          	jal	ra,80000250 <w_mstatus>
}
80000548:	00000013          	nop
8000054c:	02c12083          	lw	ra,44(sp)
80000550:	02812403          	lw	s0,40(sp)
80000554:	03010113          	addi	sp,sp,48
80000558:	00008067          	ret

8000055c <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
8000055c:	fd010113          	addi	sp,sp,-48
80000560:	02112623          	sw	ra,44(sp)
80000564:	02812423          	sw	s0,40(sp)
80000568:	03010413          	addi	s0,sp,48
8000056c:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
80000570:	dddff0ef          	jal	ra,8000034c <r_sstatus>
80000574:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000578:	fdc42703          	lw	a4,-36(s0)
8000057c:	ffd00793          	li	a5,-3
80000580:	06f70863          	beq	a4,a5,800005f0 <s_sstatus_intr+0x94>
80000584:	fdc42703          	lw	a4,-36(s0)
80000588:	ffd00793          	li	a5,-3
8000058c:	06e7e863          	bltu	a5,a4,800005fc <s_sstatus_intr+0xa0>
80000590:	fdc42703          	lw	a4,-36(s0)
80000594:	fdf00793          	li	a5,-33
80000598:	02f70c63          	beq	a4,a5,800005d0 <s_sstatus_intr+0x74>
8000059c:	fdc42703          	lw	a4,-36(s0)
800005a0:	fdf00793          	li	a5,-33
800005a4:	04e7ec63          	bltu	a5,a4,800005fc <s_sstatus_intr+0xa0>
800005a8:	fdc42703          	lw	a4,-36(s0)
800005ac:	00200793          	li	a5,2
800005b0:	02f70863          	beq	a4,a5,800005e0 <s_sstatus_intr+0x84>
800005b4:	fdc42703          	lw	a4,-36(s0)
800005b8:	02000793          	li	a5,32
800005bc:	04f71063          	bne	a4,a5,800005fc <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
800005c0:	fec42783          	lw	a5,-20(s0)
800005c4:	0207e793          	ori	a5,a5,32
800005c8:	fef42623          	sw	a5,-20(s0)
        break;
800005cc:	0340006f          	j	80000600 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
800005d0:	fec42783          	lw	a5,-20(s0)
800005d4:	fdf7f793          	andi	a5,a5,-33
800005d8:	fef42623          	sw	a5,-20(s0)
        break;
800005dc:	0240006f          	j	80000600 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
800005e0:	fec42783          	lw	a5,-20(s0)
800005e4:	0027e793          	ori	a5,a5,2
800005e8:	fef42623          	sw	a5,-20(s0)
        break;
800005ec:	0140006f          	j	80000600 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
800005f0:	fec42783          	lw	a5,-20(s0)
800005f4:	0027f793          	andi	a5,a5,2
800005f8:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
800005fc:	00000013          	nop
    }
    w_sstatus(x);
80000600:	fec42503          	lw	a0,-20(s0)
80000604:	d71ff0ef          	jal	ra,80000374 <w_sstatus>
}
80000608:	00000013          	nop
8000060c:	02c12083          	lw	ra,44(sp)
80000610:	02812403          	lw	s0,40(sp)
80000614:	03010113          	addi	sp,sp,48
80000618:	00008067          	ret

8000061c <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();     // 定义在main.c

void start(){
8000061c:	ff010113          	addi	sp,sp,-16
80000620:	00112623          	sw	ra,12(sp)
80000624:	00812423          	sw	s0,8(sp)
80000628:	01010413          	addi	s0,sp,16
    uartinit();
8000062c:	080000ef          	jal	ra,800006ac <uartinit>
    uartputs("Hello Los!\n");
80000630:	800027b7          	lui	a5,0x80002
80000634:	00078513          	mv	a0,a5
80000638:	168000ef          	jal	ra,800007a0 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
8000063c:	00100513          	li	a0,1
80000640:	c39ff0ef          	jal	ra,80000278 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
80000644:	00000513          	li	a0,0
80000648:	df5ff0ef          	jal	ra,8000043c <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
8000064c:	000107b7          	lui	a5,0x10
80000650:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000654:	d99ff0ef          	jal	ra,800003ec <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80000658:	000107b7          	lui	a5,0x10
8000065c:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000660:	db5ff0ef          	jal	ra,80000414 <w_medeleg>

    s_mstatus_intr(INTR_MPIE);  // S-mode 开全局中断
80000664:	08000513          	li	a0,128
80000668:	dfdff0ef          	jal	ra,80000464 <s_mstatus_intr>
    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
8000066c:	00200513          	li	a0,2
80000670:	eedff0ef          	jal	ra,8000055c <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
80000674:	800007b7          	lui	a5,0x80000
80000678:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
8000067c:	00078513          	mv	a0,a5
80000680:	d45ff0ef          	jal	ra,800003c4 <w_stvec>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
80000684:	800017b7          	lui	a5,0x80001
80000688:	86c78793          	addi	a5,a5,-1940 # 8000086c <memend+0xf800086c>
8000068c:	00078513          	mv	a0,a5
80000690:	d0dff0ef          	jal	ra,8000039c <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
80000694:	30200073          	mret
80000698:	00000013          	nop
8000069c:	00c12083          	lw	ra,12(sp)
800006a0:	00812403          	lw	s0,8(sp)
800006a4:	01010113          	addi	sp,sp,16
800006a8:	00008067          	ret

800006ac <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
800006ac:	fe010113          	addi	sp,sp,-32
800006b0:	00812e23          	sw	s0,28(sp)
800006b4:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800006b8:	100007b7          	lui	a5,0x10000
800006bc:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800006c0:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800006c4:	100007b7          	lui	a5,0x10000
800006c8:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006cc:	0007c783          	lbu	a5,0(a5)
800006d0:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800006d4:	100007b7          	lui	a5,0x10000
800006d8:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006dc:	fef44703          	lbu	a4,-17(s0)
800006e0:	f8076713          	ori	a4,a4,-128
800006e4:	0ff77713          	andi	a4,a4,255
800006e8:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
800006ec:	100007b7          	lui	a5,0x10000
800006f0:	00300713          	li	a4,3
800006f4:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
800006f8:	100007b7          	lui	a5,0x10000
800006fc:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000700:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
80000704:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80000708:	100007b7          	lui	a5,0x10000
8000070c:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000710:	fef44703          	lbu	a4,-17(s0)
80000714:	00376713          	ori	a4,a4,3
80000718:	0ff77713          	andi	a4,a4,255
8000071c:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
80000720:	100007b7          	lui	a5,0x10000
80000724:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000728:	0007c783          	lbu	a5,0(a5)
8000072c:	0ff7f713          	andi	a4,a5,255
80000730:	100007b7          	lui	a5,0x10000
80000734:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000738:	00176713          	ori	a4,a4,1
8000073c:	0ff77713          	andi	a4,a4,255
80000740:	00e78023          	sb	a4,0(a5)
}
80000744:	00000013          	nop
80000748:	01c12403          	lw	s0,28(sp)
8000074c:	02010113          	addi	sp,sp,32
80000750:	00008067          	ret

80000754 <uartputc>:

// 轮询处理数据
char uartputc(char c){
80000754:	fe010113          	addi	sp,sp,-32
80000758:	00812e23          	sw	s0,28(sp)
8000075c:	02010413          	addi	s0,sp,32
80000760:	00050793          	mv	a5,a0
80000764:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80000768:	00000013          	nop
8000076c:	100007b7          	lui	a5,0x10000
80000770:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000774:	0007c783          	lbu	a5,0(a5)
80000778:	0ff7f793          	andi	a5,a5,255
8000077c:	0207f793          	andi	a5,a5,32
80000780:	fe0786e3          	beqz	a5,8000076c <uartputc+0x18>
    return uart_write(UART_THR,c);
80000784:	10000737          	lui	a4,0x10000
80000788:	fef44783          	lbu	a5,-17(s0)
8000078c:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
80000790:	00078513          	mv	a0,a5
80000794:	01c12403          	lw	s0,28(sp)
80000798:	02010113          	addi	sp,sp,32
8000079c:	00008067          	ret

800007a0 <uartputs>:

// 发送字符串
void uartputs(char* s){
800007a0:	fe010113          	addi	sp,sp,-32
800007a4:	00112e23          	sw	ra,28(sp)
800007a8:	00812c23          	sw	s0,24(sp)
800007ac:	02010413          	addi	s0,sp,32
800007b0:	fea42623          	sw	a0,-20(s0)
    while (*s)
800007b4:	01c0006f          	j	800007d0 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
800007b8:	fec42783          	lw	a5,-20(s0)
800007bc:	00178713          	addi	a4,a5,1
800007c0:	fee42623          	sw	a4,-20(s0)
800007c4:	0007c783          	lbu	a5,0(a5)
800007c8:	00078513          	mv	a0,a5
800007cc:	f89ff0ef          	jal	ra,80000754 <uartputc>
    while (*s)
800007d0:	fec42783          	lw	a5,-20(s0)
800007d4:	0007c783          	lbu	a5,0(a5)
800007d8:	fe0790e3          	bnez	a5,800007b8 <uartputs+0x18>
    }
    
}
800007dc:	00000013          	nop
800007e0:	00000013          	nop
800007e4:	01c12083          	lw	ra,28(sp)
800007e8:	01812403          	lw	s0,24(sp)
800007ec:	02010113          	addi	sp,sp,32
800007f0:	00008067          	ret

800007f4 <uartgetc>:

// 接收输入
int uartgetc(){
800007f4:	ff010113          	addi	sp,sp,-16
800007f8:	00812623          	sw	s0,12(sp)
800007fc:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
80000800:	100007b7          	lui	a5,0x10000
80000804:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000808:	0007c783          	lbu	a5,0(a5)
8000080c:	0ff7f793          	andi	a5,a5,255
80000810:	0017f793          	andi	a5,a5,1
80000814:	00078a63          	beqz	a5,80000828 <uartgetc+0x34>
        return uart_read(UART_RHR);
80000818:	100007b7          	lui	a5,0x10000
8000081c:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
80000820:	0ff7f793          	andi	a5,a5,255
80000824:	0080006f          	j	8000082c <uartgetc+0x38>
    }else{
        return -1;
80000828:	fff00793          	li	a5,-1
    }
}
8000082c:	00078513          	mv	a0,a5
80000830:	00c12403          	lw	s0,12(sp)
80000834:	01010113          	addi	sp,sp,16
80000838:	00008067          	ret

8000083c <uartintr>:

// 键盘输入中断
char uartintr(){
8000083c:	ff010113          	addi	sp,sp,-16
80000840:	00112623          	sw	ra,12(sp)
80000844:	00812423          	sw	s0,8(sp)
80000848:	01010413          	addi	s0,sp,16
    return uartgetc();
8000084c:	fa9ff0ef          	jal	ra,800007f4 <uartgetc>
80000850:	00050793          	mv	a5,a0
80000854:	0ff7f793          	andi	a5,a5,255
80000858:	00078513          	mv	a0,a5
8000085c:	00c12083          	lw	ra,12(sp)
80000860:	00812403          	lw	s0,8(sp)
80000864:	01010113          	addi	sp,sp,16
80000868:	00008067          	ret

8000086c <main>:
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

void main(){
8000086c:	ef010113          	addi	sp,sp,-272
80000870:	10112623          	sw	ra,268(sp)
80000874:	10812423          	sw	s0,264(sp)
80000878:	11010413          	addi	s0,sp,272
    printf("start run main()\n");
8000087c:	800027b7          	lui	a5,0x80002
80000880:	00c78513          	addi	a0,a5,12 # 8000200c <memend+0xf800200c>
80000884:	2dc000ef          	jal	ra,80000b60 <printf>

    minit();        // 物理内存管理
80000888:	6e4000ef          	jal	ra,80000f6c <minit>
    plicinit();     // PLIC 中断处理
8000088c:	081000ef          	jal	ra,8000110c <plicinit>
    vminit();       // 启动虚拟内存
80000890:	535000ef          	jal	ra,800015c4 <vminit>

    procinit();
80000894:	735000ef          	jal	ra,800017c8 <procinit>
    // *va=10;
    // *(int *)0x00000000 = 100;
   
    struct context old;
    struct context new;
    swtch(&old,&new);
80000898:	ef840713          	addi	a4,s0,-264
8000089c:	f7440793          	addi	a5,s0,-140
800008a0:	00070593          	mv	a1,a4
800008a4:	00078513          	mv	a0,a5
800008a8:	88dff0ef          	jal	ra,80000134 <swtch>

    printf("----------------------\n");
800008ac:	800027b7          	lui	a5,0x80002
800008b0:	02078513          	addi	a0,a5,32 # 80002020 <memend+0xf8002020>
800008b4:	2ac000ef          	jal	ra,80000b60 <printf>

    while(1);
800008b8:	0000006f          	j	800008b8 <main+0x4c>

800008bc <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
800008bc:	fe010113          	addi	sp,sp,-32
800008c0:	00812e23          	sw	s0,28(sp)
800008c4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
800008c8:	142027f3          	csrr	a5,scause
800008cc:	fef42623          	sw	a5,-20(s0)
    return x;
800008d0:	fec42783          	lw	a5,-20(s0)
}
800008d4:	00078513          	mv	a0,a5
800008d8:	01c12403          	lw	s0,28(sp)
800008dc:	02010113          	addi	sp,sp,32
800008e0:	00008067          	ret

800008e4 <externinterrupt>:
#include "plic.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
800008e4:	fe010113          	addi	sp,sp,-32
800008e8:	00112e23          	sw	ra,28(sp)
800008ec:	00812c23          	sw	s0,24(sp)
800008f0:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
800008f4:	0dd000ef          	jal	ra,800011d0 <r_plicclaim>
800008f8:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
800008fc:	fec42583          	lw	a1,-20(s0)
80000900:	800027b7          	lui	a5,0x80002
80000904:	03878513          	addi	a0,a5,56 # 80002038 <memend+0xf8002038>
80000908:	258000ef          	jal	ra,80000b60 <printf>
    switch (irq)
8000090c:	fec42703          	lw	a4,-20(s0)
80000910:	00a00793          	li	a5,10
80000914:	02f71063          	bne	a4,a5,80000934 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80000918:	f25ff0ef          	jal	ra,8000083c <uartintr>
8000091c:	00050793          	mv	a5,a0
80000920:	00078593          	mv	a1,a5
80000924:	800027b7          	lui	a5,0x80002
80000928:	04478513          	addi	a0,a5,68 # 80002044 <memend+0xf8002044>
8000092c:	234000ef          	jal	ra,80000b60 <printf>
        break;
80000930:	0080006f          	j	80000938 <externinterrupt+0x54>
    default:
        break;
80000934:	00000013          	nop
    }
    w_pliccomplete(irq);
80000938:	fec42503          	lw	a0,-20(s0)
8000093c:	0d5000ef          	jal	ra,80001210 <w_pliccomplete>
}
80000940:	00000013          	nop
80000944:	01c12083          	lw	ra,28(sp)
80000948:	01812403          	lw	s0,24(sp)
8000094c:	02010113          	addi	sp,sp,32
80000950:	00008067          	ret

80000954 <trapvec>:

void trapvec(){
80000954:	fe010113          	addi	sp,sp,-32
80000958:	00112e23          	sw	ra,28(sp)
8000095c:	00812c23          	sw	s0,24(sp)
80000960:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000964:	f59ff0ef          	jal	ra,800008bc <r_scause>
80000968:	fea42623          	sw	a0,-20(s0)

    uint16 code= scause & 0xffff;
8000096c:	fec42783          	lw	a5,-20(s0)
80000970:	fef41523          	sh	a5,-22(s0)

    if(scause & (1<<31)){
80000974:	fec42783          	lw	a5,-20(s0)
80000978:	0607de63          	bgez	a5,800009f4 <trapvec+0xa0>
        printf("Interrupt : ");
8000097c:	800027b7          	lui	a5,0x80002
80000980:	05478513          	addi	a0,a5,84 # 80002054 <memend+0xf8002054>
80000984:	1dc000ef          	jal	ra,80000b60 <printf>
        switch (code)
80000988:	fea45783          	lhu	a5,-22(s0)
8000098c:	00900713          	li	a4,9
80000990:	04e78063          	beq	a5,a4,800009d0 <trapvec+0x7c>
80000994:	00900713          	li	a4,9
80000998:	04f74663          	blt	a4,a5,800009e4 <trapvec+0x90>
8000099c:	00100713          	li	a4,1
800009a0:	00e78863          	beq	a5,a4,800009b0 <trapvec+0x5c>
800009a4:	00500713          	li	a4,5
800009a8:	00e78c63          	beq	a5,a4,800009c0 <trapvec+0x6c>
800009ac:	0380006f          	j	800009e4 <trapvec+0x90>
        {
        case 1:
            printf("Supervisor software interrupt\n");
800009b0:	800027b7          	lui	a5,0x80002
800009b4:	06478513          	addi	a0,a5,100 # 80002064 <memend+0xf8002064>
800009b8:	1a8000ef          	jal	ra,80000b60 <printf>
            break;
800009bc:	1580006f          	j	80000b14 <trapvec+0x1c0>
        case 5:
            printf("Supervisor timer interrupt\n");
800009c0:	800027b7          	lui	a5,0x80002
800009c4:	08478513          	addi	a0,a5,132 # 80002084 <memend+0xf8002084>
800009c8:	198000ef          	jal	ra,80000b60 <printf>
            break;
800009cc:	1480006f          	j	80000b14 <trapvec+0x1c0>
        case 9:
            printf("Supervisor external interrupt\n");
800009d0:	800027b7          	lui	a5,0x80002
800009d4:	0a078513          	addi	a0,a5,160 # 800020a0 <memend+0xf80020a0>
800009d8:	188000ef          	jal	ra,80000b60 <printf>
            externinterrupt();
800009dc:	f09ff0ef          	jal	ra,800008e4 <externinterrupt>
            break;
800009e0:	1340006f          	j	80000b14 <trapvec+0x1c0>
        default:
            printf("Other interrupt\n");
800009e4:	800027b7          	lui	a5,0x80002
800009e8:	0c078513          	addi	a0,a5,192 # 800020c0 <memend+0xf80020c0>
800009ec:	174000ef          	jal	ra,80000b60 <printf>
            break;
800009f0:	1240006f          	j	80000b14 <trapvec+0x1c0>
        }
    }else{
        printf("Exception : ");
800009f4:	800027b7          	lui	a5,0x80002
800009f8:	0d478513          	addi	a0,a5,212 # 800020d4 <memend+0xf80020d4>
800009fc:	164000ef          	jal	ra,80000b60 <printf>
        switch (code)
80000a00:	fea45783          	lhu	a5,-22(s0)
80000a04:	00f00713          	li	a4,15
80000a08:	0ef76663          	bltu	a4,a5,80000af4 <trapvec+0x1a0>
80000a0c:	00279713          	slli	a4,a5,0x2
80000a10:	800027b7          	lui	a5,0x80002
80000a14:	24878793          	addi	a5,a5,584 # 80002248 <memend+0xf8002248>
80000a18:	00f707b3          	add	a5,a4,a5
80000a1c:	0007a783          	lw	a5,0(a5)
80000a20:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000a24:	800027b7          	lui	a5,0x80002
80000a28:	0e478513          	addi	a0,a5,228 # 800020e4 <memend+0xf80020e4>
80000a2c:	134000ef          	jal	ra,80000b60 <printf>
            break;
80000a30:	0d40006f          	j	80000b04 <trapvec+0x1b0>
        case 1:
            printf("Instruction access fault\n");
80000a34:	800027b7          	lui	a5,0x80002
80000a38:	10478513          	addi	a0,a5,260 # 80002104 <memend+0xf8002104>
80000a3c:	124000ef          	jal	ra,80000b60 <printf>
            break;
80000a40:	0c40006f          	j	80000b04 <trapvec+0x1b0>
        case 2:
            printf("Illegal instruction\n");
80000a44:	800027b7          	lui	a5,0x80002
80000a48:	12078513          	addi	a0,a5,288 # 80002120 <memend+0xf8002120>
80000a4c:	114000ef          	jal	ra,80000b60 <printf>
            break;
80000a50:	0b40006f          	j	80000b04 <trapvec+0x1b0>
        case 3:
            printf("Breakpoint\n");
80000a54:	800027b7          	lui	a5,0x80002
80000a58:	13878513          	addi	a0,a5,312 # 80002138 <memend+0xf8002138>
80000a5c:	104000ef          	jal	ra,80000b60 <printf>
            break;
80000a60:	0a40006f          	j	80000b04 <trapvec+0x1b0>
        case 4:
            printf("Load address misaligned\n");
80000a64:	800027b7          	lui	a5,0x80002
80000a68:	14478513          	addi	a0,a5,324 # 80002144 <memend+0xf8002144>
80000a6c:	0f4000ef          	jal	ra,80000b60 <printf>
            break;
80000a70:	0940006f          	j	80000b04 <trapvec+0x1b0>
        case 5:
            printf("Load access fault\n");
80000a74:	800027b7          	lui	a5,0x80002
80000a78:	16078513          	addi	a0,a5,352 # 80002160 <memend+0xf8002160>
80000a7c:	0e4000ef          	jal	ra,80000b60 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000a80:	0840006f          	j	80000b04 <trapvec+0x1b0>
        case 6:
            printf("Store/AMO address misaligned\n");
80000a84:	800027b7          	lui	a5,0x80002
80000a88:	17478513          	addi	a0,a5,372 # 80002174 <memend+0xf8002174>
80000a8c:	0d4000ef          	jal	ra,80000b60 <printf>
            break;
80000a90:	0740006f          	j	80000b04 <trapvec+0x1b0>
        case 7:
            printf("Store/AMO access fault\n");
80000a94:	800027b7          	lui	a5,0x80002
80000a98:	19478513          	addi	a0,a5,404 # 80002194 <memend+0xf8002194>
80000a9c:	0c4000ef          	jal	ra,80000b60 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000aa0:	0640006f          	j	80000b04 <trapvec+0x1b0>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000aa4:	800027b7          	lui	a5,0x80002
80000aa8:	1ac78513          	addi	a0,a5,428 # 800021ac <memend+0xf80021ac>
80000aac:	0b4000ef          	jal	ra,80000b60 <printf>
            break;
80000ab0:	0540006f          	j	80000b04 <trapvec+0x1b0>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000ab4:	800027b7          	lui	a5,0x80002
80000ab8:	1cc78513          	addi	a0,a5,460 # 800021cc <memend+0xf80021cc>
80000abc:	0a4000ef          	jal	ra,80000b60 <printf>
            break;
80000ac0:	0440006f          	j	80000b04 <trapvec+0x1b0>
        case 12:
            printf("Instruction page fault\n");
80000ac4:	800027b7          	lui	a5,0x80002
80000ac8:	1ec78513          	addi	a0,a5,492 # 800021ec <memend+0xf80021ec>
80000acc:	094000ef          	jal	ra,80000b60 <printf>
            break;
80000ad0:	0340006f          	j	80000b04 <trapvec+0x1b0>
        case 13:
            printf("Load page fault\n");
80000ad4:	800027b7          	lui	a5,0x80002
80000ad8:	20478513          	addi	a0,a5,516 # 80002204 <memend+0xf8002204>
80000adc:	084000ef          	jal	ra,80000b60 <printf>
            break;
80000ae0:	0240006f          	j	80000b04 <trapvec+0x1b0>
        case 15:
            printf("Store/AMO page fault\n");
80000ae4:	800027b7          	lui	a5,0x80002
80000ae8:	21878513          	addi	a0,a5,536 # 80002218 <memend+0xf8002218>
80000aec:	074000ef          	jal	ra,80000b60 <printf>
            break;
80000af0:	0140006f          	j	80000b04 <trapvec+0x1b0>
        default:
            printf("Other\n");
80000af4:	800027b7          	lui	a5,0x80002
80000af8:	23078513          	addi	a0,a5,560 # 80002230 <memend+0xf8002230>
80000afc:	064000ef          	jal	ra,80000b60 <printf>
            break;
80000b00:	00000013          	nop
        }
        panic("Trap Exception");
80000b04:	800027b7          	lui	a5,0x80002
80000b08:	23878513          	addi	a0,a5,568 # 80002238 <memend+0xf8002238>
80000b0c:	01c000ef          	jal	ra,80000b28 <panic>
    }
}
80000b10:	00000013          	nop
80000b14:	00000013          	nop
80000b18:	01c12083          	lw	ra,28(sp)
80000b1c:	01812403          	lw	s0,24(sp)
80000b20:	02010113          	addi	sp,sp,32
80000b24:	00008067          	ret

80000b28 <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000b28:	fe010113          	addi	sp,sp,-32
80000b2c:	00112e23          	sw	ra,28(sp)
80000b30:	00812c23          	sw	s0,24(sp)
80000b34:	02010413          	addi	s0,sp,32
80000b38:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000b3c:	800027b7          	lui	a5,0x80002
80000b40:	28878513          	addi	a0,a5,648 # 80002288 <memend+0xf8002288>
80000b44:	c5dff0ef          	jal	ra,800007a0 <uartputs>
    uartputs(s);
80000b48:	fec42503          	lw	a0,-20(s0)
80000b4c:	c55ff0ef          	jal	ra,800007a0 <uartputs>
	uartputs("\n");
80000b50:	800027b7          	lui	a5,0x80002
80000b54:	29078513          	addi	a0,a5,656 # 80002290 <memend+0xf8002290>
80000b58:	c49ff0ef          	jal	ra,800007a0 <uartputs>
    while(1);
80000b5c:	0000006f          	j	80000b5c <panic+0x34>

80000b60 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000b60:	f8010113          	addi	sp,sp,-128
80000b64:	04112e23          	sw	ra,92(sp)
80000b68:	04812c23          	sw	s0,88(sp)
80000b6c:	06010413          	addi	s0,sp,96
80000b70:	faa42623          	sw	a0,-84(s0)
80000b74:	00b42223          	sw	a1,4(s0)
80000b78:	00c42423          	sw	a2,8(s0)
80000b7c:	00d42623          	sw	a3,12(s0)
80000b80:	00e42823          	sw	a4,16(s0)
80000b84:	00f42a23          	sw	a5,20(s0)
80000b88:	01042c23          	sw	a6,24(s0)
80000b8c:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000b90:	02040793          	addi	a5,s0,32
80000b94:	faf42423          	sw	a5,-88(s0)
80000b98:	fa842783          	lw	a5,-88(s0)
80000b9c:	fe478793          	addi	a5,a5,-28
80000ba0:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000ba4:	fac42783          	lw	a5,-84(s0)
80000ba8:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000bac:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000bb0:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
80000bb4:	36c0006f          	j	80000f20 <printf+0x3c0>
		if(ch=='%'){
80000bb8:	fbf44703          	lbu	a4,-65(s0)
80000bbc:	02500793          	li	a5,37
80000bc0:	04f71863          	bne	a4,a5,80000c10 <printf+0xb0>
			if(tt==1){
80000bc4:	fe842703          	lw	a4,-24(s0)
80000bc8:	00100793          	li	a5,1
80000bcc:	02f71663          	bne	a4,a5,80000bf8 <printf+0x98>
				outbuf[idx++]='%';
80000bd0:	fe442783          	lw	a5,-28(s0)
80000bd4:	00178713          	addi	a4,a5,1
80000bd8:	fee42223          	sw	a4,-28(s0)
80000bdc:	8000c737          	lui	a4,0x8000c
80000be0:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000be4:	00f707b3          	add	a5,a4,a5
80000be8:	02500713          	li	a4,37
80000bec:	00e78023          	sb	a4,0(a5)
				tt=0;
80000bf0:	fe042423          	sw	zero,-24(s0)
80000bf4:	00c0006f          	j	80000c00 <printf+0xa0>
			}else{
				tt=1;
80000bf8:	00100793          	li	a5,1
80000bfc:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000c00:	fec42783          	lw	a5,-20(s0)
80000c04:	00178793          	addi	a5,a5,1
80000c08:	fef42623          	sw	a5,-20(s0)
80000c0c:	3140006f          	j	80000f20 <printf+0x3c0>
		}else{
			if(tt==1){
80000c10:	fe842703          	lw	a4,-24(s0)
80000c14:	00100793          	li	a5,1
80000c18:	2cf71e63          	bne	a4,a5,80000ef4 <printf+0x394>
				switch (ch)
80000c1c:	fbf44783          	lbu	a5,-65(s0)
80000c20:	fa878793          	addi	a5,a5,-88
80000c24:	02000713          	li	a4,32
80000c28:	2af76663          	bltu	a4,a5,80000ed4 <printf+0x374>
80000c2c:	00279713          	slli	a4,a5,0x2
80000c30:	800027b7          	lui	a5,0x80002
80000c34:	2ac78793          	addi	a5,a5,684 # 800022ac <memend+0xf80022ac>
80000c38:	00f707b3          	add	a5,a4,a5
80000c3c:	0007a783          	lw	a5,0(a5)
80000c40:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000c44:	fb842783          	lw	a5,-72(s0)
80000c48:	00478713          	addi	a4,a5,4
80000c4c:	fae42c23          	sw	a4,-72(s0)
80000c50:	0007a783          	lw	a5,0(a5)
80000c54:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000c58:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000c5c:	fe042783          	lw	a5,-32(s0)
80000c60:	fcf42c23          	sw	a5,-40(s0)
80000c64:	0100006f          	j	80000c74 <printf+0x114>
80000c68:	fdc42783          	lw	a5,-36(s0)
80000c6c:	00178793          	addi	a5,a5,1
80000c70:	fcf42e23          	sw	a5,-36(s0)
80000c74:	fd842703          	lw	a4,-40(s0)
80000c78:	00a00793          	li	a5,10
80000c7c:	02f747b3          	div	a5,a4,a5
80000c80:	fcf42c23          	sw	a5,-40(s0)
80000c84:	fd842783          	lw	a5,-40(s0)
80000c88:	fe0790e3          	bnez	a5,80000c68 <printf+0x108>
					for(int i=len;i>=0;i--){
80000c8c:	fdc42783          	lw	a5,-36(s0)
80000c90:	fcf42a23          	sw	a5,-44(s0)
80000c94:	0540006f          	j	80000ce8 <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000c98:	fe042703          	lw	a4,-32(s0)
80000c9c:	00a00793          	li	a5,10
80000ca0:	02f767b3          	rem	a5,a4,a5
80000ca4:	0ff7f713          	andi	a4,a5,255
80000ca8:	fe442683          	lw	a3,-28(s0)
80000cac:	fd442783          	lw	a5,-44(s0)
80000cb0:	00f687b3          	add	a5,a3,a5
80000cb4:	03070713          	addi	a4,a4,48
80000cb8:	0ff77713          	andi	a4,a4,255
80000cbc:	8000c6b7          	lui	a3,0x8000c
80000cc0:	00468693          	addi	a3,a3,4 # 8000c004 <memend+0xf800c004>
80000cc4:	00f687b3          	add	a5,a3,a5
80000cc8:	00e78023          	sb	a4,0(a5)
						x/=10;
80000ccc:	fe042703          	lw	a4,-32(s0)
80000cd0:	00a00793          	li	a5,10
80000cd4:	02f747b3          	div	a5,a4,a5
80000cd8:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000cdc:	fd442783          	lw	a5,-44(s0)
80000ce0:	fff78793          	addi	a5,a5,-1
80000ce4:	fcf42a23          	sw	a5,-44(s0)
80000ce8:	fd442783          	lw	a5,-44(s0)
80000cec:	fa07d6e3          	bgez	a5,80000c98 <printf+0x138>
					}
					idx+=(len+1);
80000cf0:	fdc42783          	lw	a5,-36(s0)
80000cf4:	00178793          	addi	a5,a5,1
80000cf8:	fe442703          	lw	a4,-28(s0)
80000cfc:	00f707b3          	add	a5,a4,a5
80000d00:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000d04:	fe042423          	sw	zero,-24(s0)
					break;
80000d08:	1dc0006f          	j	80000ee4 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000d0c:	fe442783          	lw	a5,-28(s0)
80000d10:	00178713          	addi	a4,a5,1
80000d14:	fee42223          	sw	a4,-28(s0)
80000d18:	8000c737          	lui	a4,0x8000c
80000d1c:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000d20:	00f707b3          	add	a5,a4,a5
80000d24:	03000713          	li	a4,48
80000d28:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000d2c:	fe442783          	lw	a5,-28(s0)
80000d30:	00178713          	addi	a4,a5,1
80000d34:	fee42223          	sw	a4,-28(s0)
80000d38:	8000c737          	lui	a4,0x8000c
80000d3c:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000d40:	00f707b3          	add	a5,a4,a5
80000d44:	07800713          	li	a4,120
80000d48:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80000d4c:	fb842783          	lw	a5,-72(s0)
80000d50:	00478713          	addi	a4,a5,4
80000d54:	fae42c23          	sw	a4,-72(s0)
80000d58:	0007a783          	lw	a5,0(a5)
80000d5c:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80000d60:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80000d64:	fd042783          	lw	a5,-48(s0)
80000d68:	fcf42423          	sw	a5,-56(s0)
80000d6c:	0100006f          	j	80000d7c <printf+0x21c>
80000d70:	fcc42783          	lw	a5,-52(s0)
80000d74:	00178793          	addi	a5,a5,1
80000d78:	fcf42623          	sw	a5,-52(s0)
80000d7c:	fc842783          	lw	a5,-56(s0)
80000d80:	0047d793          	srli	a5,a5,0x4
80000d84:	fcf42423          	sw	a5,-56(s0)
80000d88:	fc842783          	lw	a5,-56(s0)
80000d8c:	fe0792e3          	bnez	a5,80000d70 <printf+0x210>
					for(int i=len;i>=0;i--){
80000d90:	fcc42783          	lw	a5,-52(s0)
80000d94:	fcf42223          	sw	a5,-60(s0)
80000d98:	0840006f          	j	80000e1c <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80000d9c:	fd042783          	lw	a5,-48(s0)
80000da0:	00f7f713          	andi	a4,a5,15
80000da4:	00900793          	li	a5,9
80000da8:	02e7f063          	bgeu	a5,a4,80000dc8 <printf+0x268>
80000dac:	fd042783          	lw	a5,-48(s0)
80000db0:	0ff7f793          	andi	a5,a5,255
80000db4:	00f7f793          	andi	a5,a5,15
80000db8:	0ff7f793          	andi	a5,a5,255
80000dbc:	05778793          	addi	a5,a5,87
80000dc0:	0ff7f793          	andi	a5,a5,255
80000dc4:	01c0006f          	j	80000de0 <printf+0x280>
80000dc8:	fd042783          	lw	a5,-48(s0)
80000dcc:	0ff7f793          	andi	a5,a5,255
80000dd0:	00f7f793          	andi	a5,a5,15
80000dd4:	0ff7f793          	andi	a5,a5,255
80000dd8:	03078793          	addi	a5,a5,48
80000ddc:	0ff7f793          	andi	a5,a5,255
80000de0:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80000de4:	fe442703          	lw	a4,-28(s0)
80000de8:	fc442783          	lw	a5,-60(s0)
80000dec:	00f707b3          	add	a5,a4,a5
80000df0:	8000c737          	lui	a4,0x8000c
80000df4:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000df8:	00f707b3          	add	a5,a4,a5
80000dfc:	fbe44703          	lbu	a4,-66(s0)
80000e00:	00e78023          	sb	a4,0(a5)
						x/=16;
80000e04:	fd042783          	lw	a5,-48(s0)
80000e08:	0047d793          	srli	a5,a5,0x4
80000e0c:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80000e10:	fc442783          	lw	a5,-60(s0)
80000e14:	fff78793          	addi	a5,a5,-1
80000e18:	fcf42223          	sw	a5,-60(s0)
80000e1c:	fc442783          	lw	a5,-60(s0)
80000e20:	f607dee3          	bgez	a5,80000d9c <printf+0x23c>
					}
					idx+=(len+1);
80000e24:	fcc42783          	lw	a5,-52(s0)
80000e28:	00178793          	addi	a5,a5,1
80000e2c:	fe442703          	lw	a4,-28(s0)
80000e30:	00f707b3          	add	a5,a4,a5
80000e34:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000e38:	fe042423          	sw	zero,-24(s0)
					break;
80000e3c:	0a80006f          	j	80000ee4 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80000e40:	fb842783          	lw	a5,-72(s0)
80000e44:	00478713          	addi	a4,a5,4
80000e48:	fae42c23          	sw	a4,-72(s0)
80000e4c:	0007a783          	lw	a5,0(a5)
80000e50:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80000e54:	fe442783          	lw	a5,-28(s0)
80000e58:	00178713          	addi	a4,a5,1
80000e5c:	fee42223          	sw	a4,-28(s0)
80000e60:	8000c737          	lui	a4,0x8000c
80000e64:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000e68:	00f707b3          	add	a5,a4,a5
80000e6c:	fbf44703          	lbu	a4,-65(s0)
80000e70:	00e78023          	sb	a4,0(a5)
					tt=0;
80000e74:	fe042423          	sw	zero,-24(s0)
					break;
80000e78:	06c0006f          	j	80000ee4 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80000e7c:	fb842783          	lw	a5,-72(s0)
80000e80:	00478713          	addi	a4,a5,4
80000e84:	fae42c23          	sw	a4,-72(s0)
80000e88:	0007a783          	lw	a5,0(a5)
80000e8c:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80000e90:	0300006f          	j	80000ec0 <printf+0x360>
						outbuf[idx++]=*ss++;
80000e94:	fc042703          	lw	a4,-64(s0)
80000e98:	00170793          	addi	a5,a4,1
80000e9c:	fcf42023          	sw	a5,-64(s0)
80000ea0:	fe442783          	lw	a5,-28(s0)
80000ea4:	00178693          	addi	a3,a5,1
80000ea8:	fed42223          	sw	a3,-28(s0)
80000eac:	00074703          	lbu	a4,0(a4)
80000eb0:	8000c6b7          	lui	a3,0x8000c
80000eb4:	00468693          	addi	a3,a3,4 # 8000c004 <memend+0xf800c004>
80000eb8:	00f687b3          	add	a5,a3,a5
80000ebc:	00e78023          	sb	a4,0(a5)
					while(*ss){
80000ec0:	fc042783          	lw	a5,-64(s0)
80000ec4:	0007c783          	lbu	a5,0(a5)
80000ec8:	fc0796e3          	bnez	a5,80000e94 <printf+0x334>
					}
					tt=0;
80000ecc:	fe042423          	sw	zero,-24(s0)
					break;
80000ed0:	0140006f          	j	80000ee4 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80000ed4:	800027b7          	lui	a5,0x80002
80000ed8:	29478513          	addi	a0,a5,660 # 80002294 <memend+0xf8002294>
80000edc:	c4dff0ef          	jal	ra,80000b28 <panic>
					break;
80000ee0:	00000013          	nop
				}
				s++;
80000ee4:	fec42783          	lw	a5,-20(s0)
80000ee8:	00178793          	addi	a5,a5,1
80000eec:	fef42623          	sw	a5,-20(s0)
80000ef0:	0300006f          	j	80000f20 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80000ef4:	fe442783          	lw	a5,-28(s0)
80000ef8:	00178713          	addi	a4,a5,1
80000efc:	fee42223          	sw	a4,-28(s0)
80000f00:	8000c737          	lui	a4,0x8000c
80000f04:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000f08:	00f707b3          	add	a5,a4,a5
80000f0c:	fbf44703          	lbu	a4,-65(s0)
80000f10:	00e78023          	sb	a4,0(a5)
				s++;
80000f14:	fec42783          	lw	a5,-20(s0)
80000f18:	00178793          	addi	a5,a5,1
80000f1c:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
80000f20:	fec42783          	lw	a5,-20(s0)
80000f24:	0007c783          	lbu	a5,0(a5)
80000f28:	faf40fa3          	sb	a5,-65(s0)
80000f2c:	fbf44783          	lbu	a5,-65(s0)
80000f30:	c80794e3          	bnez	a5,80000bb8 <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80000f34:	8000c7b7          	lui	a5,0x8000c
80000f38:	00478713          	addi	a4,a5,4 # 8000c004 <memend+0xf800c004>
80000f3c:	fe442783          	lw	a5,-28(s0)
80000f40:	00f707b3          	add	a5,a4,a5
80000f44:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
80000f48:	8000c7b7          	lui	a5,0x8000c
80000f4c:	00478513          	addi	a0,a5,4 # 8000c004 <memend+0xf800c004>
80000f50:	851ff0ef          	jal	ra,800007a0 <uartputs>
	return idx;
80000f54:	fe442783          	lw	a5,-28(s0)
80000f58:	00078513          	mv	a0,a5
80000f5c:	05c12083          	lw	ra,92(sp)
80000f60:	05812403          	lw	s0,88(sp)
80000f64:	08010113          	addi	sp,sp,128
80000f68:	00008067          	ret

80000f6c <minit>:
struct
{
    struct pmp* freelist;
}mem;

void minit(){
80000f6c:	fe010113          	addi	sp,sp,-32
80000f70:	00812e23          	sw	s0,28(sp)
80000f74:	02010413          	addi	s0,sp,32
        printf("mstart:%p   ",mstart);
        printf("mend:%p\n",mend);
        printf("stack:%p\n",stacks);
    #endif

    char* p=(char*)mstart;
80000f78:	8000d7b7          	lui	a5,0x8000d
80000f7c:	00078793          	mv	a5,a5
80000f80:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80000f84:	0380006f          	j	80000fbc <minit+0x50>
        m=(struct pmp*)p;
80000f88:	fec42783          	lw	a5,-20(s0)
80000f8c:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
80000f90:	8000c7b7          	lui	a5,0x8000c
80000f94:	4047a703          	lw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
80000f98:	fe842783          	lw	a5,-24(s0)
80000f9c:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
80000fa0:	8000c7b7          	lui	a5,0x8000c
80000fa4:	fe842703          	lw	a4,-24(s0)
80000fa8:	40e7a223          	sw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80000fac:	fec42703          	lw	a4,-20(s0)
80000fb0:	000017b7          	lui	a5,0x1
80000fb4:	00f707b3          	add	a5,a4,a5
80000fb8:	fef42623          	sw	a5,-20(s0)
80000fbc:	fec42703          	lw	a4,-20(s0)
80000fc0:	000017b7          	lui	a5,0x1
80000fc4:	00f70733          	add	a4,a4,a5
80000fc8:	880007b7          	lui	a5,0x88000
80000fcc:	00078793          	mv	a5,a5
80000fd0:	fae7fce3          	bgeu	a5,a4,80000f88 <minit+0x1c>
    }
}
80000fd4:	00000013          	nop
80000fd8:	00000013          	nop
80000fdc:	01c12403          	lw	s0,28(sp)
80000fe0:	02010113          	addi	sp,sp,32
80000fe4:	00008067          	ret

80000fe8 <palloc>:

void* palloc(){
80000fe8:	fe010113          	addi	sp,sp,-32
80000fec:	00112e23          	sw	ra,28(sp)
80000ff0:	00812c23          	sw	s0,24(sp)
80000ff4:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80000ff8:	8000c7b7          	lui	a5,0x8000c
80000ffc:	4047a783          	lw	a5,1028(a5) # 8000c404 <memend+0xf800c404>
80001000:	fef42623          	sw	a5,-20(s0)
    if(p)
80001004:	fec42783          	lw	a5,-20(s0)
80001008:	00078c63          	beqz	a5,80001020 <palloc+0x38>
        mem.freelist=mem.freelist->next;
8000100c:	8000c7b7          	lui	a5,0x8000c
80001010:	4047a783          	lw	a5,1028(a5) # 8000c404 <memend+0xf800c404>
80001014:	0007a703          	lw	a4,0(a5)
80001018:	8000c7b7          	lui	a5,0x8000c
8000101c:	40e7a223          	sw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
    if(p)
80001020:	fec42783          	lw	a5,-20(s0)
80001024:	00078a63          	beqz	a5,80001038 <palloc+0x50>
        memset(p,0,PGSIZE);
80001028:	00001637          	lui	a2,0x1
8000102c:	00000593          	li	a1,0
80001030:	fec42503          	lw	a0,-20(s0)
80001034:	195000ef          	jal	ra,800019c8 <memset>
    return (void*)p;
80001038:	fec42783          	lw	a5,-20(s0)
}
8000103c:	00078513          	mv	a0,a5
80001040:	01c12083          	lw	ra,28(sp)
80001044:	01812403          	lw	s0,24(sp)
80001048:	02010113          	addi	sp,sp,32
8000104c:	00008067          	ret

80001050 <pfree>:

void pfree(void* addr){
80001050:	fd010113          	addi	sp,sp,-48
80001054:	02812623          	sw	s0,44(sp)
80001058:	03010413          	addi	s0,sp,48
8000105c:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80001060:	fdc42783          	lw	a5,-36(s0)
80001064:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
80001068:	8000c7b7          	lui	a5,0x8000c
8000106c:	4047a703          	lw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
80001070:	fec42783          	lw	a5,-20(s0)
80001074:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
80001078:	8000c7b7          	lui	a5,0x8000c
8000107c:	fec42703          	lw	a4,-20(s0)
80001080:	40e7a223          	sw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
80001084:	00000013          	nop
80001088:	02c12403          	lw	s0,44(sp)
8000108c:	03010113          	addi	sp,sp,48
80001090:	00008067          	ret

80001094 <r_tp>:
static inline uint32 r_tp(){
80001094:	fe010113          	addi	sp,sp,-32
80001098:	00812e23          	sw	s0,28(sp)
8000109c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800010a0:	00020793          	mv	a5,tp
800010a4:	fef42623          	sw	a5,-20(s0)
    return x;
800010a8:	fec42783          	lw	a5,-20(s0)
}
800010ac:	00078513          	mv	a0,a5
800010b0:	01c12403          	lw	s0,28(sp)
800010b4:	02010113          	addi	sp,sp,32
800010b8:	00008067          	ret

800010bc <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
800010bc:	fe010113          	addi	sp,sp,-32
800010c0:	00812e23          	sw	s0,28(sp)
800010c4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
800010c8:	104027f3          	csrr	a5,sie
800010cc:	fef42623          	sw	a5,-20(s0)
    return x;
800010d0:	fec42783          	lw	a5,-20(s0)
}
800010d4:	00078513          	mv	a0,a5
800010d8:	01c12403          	lw	s0,28(sp)
800010dc:	02010113          	addi	sp,sp,32
800010e0:	00008067          	ret

800010e4 <w_sie>:
static inline void w_sie(uint32 x){
800010e4:	fe010113          	addi	sp,sp,-32
800010e8:	00812e23          	sw	s0,28(sp)
800010ec:	02010413          	addi	s0,sp,32
800010f0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
800010f4:	fec42783          	lw	a5,-20(s0)
800010f8:	10479073          	csrw	sie,a5
}
800010fc:	00000013          	nop
80001100:	01c12403          	lw	s0,28(sp)
80001104:	02010113          	addi	sp,sp,32
80001108:	00008067          	ret

8000110c <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
8000110c:	ff010113          	addi	sp,sp,-16
80001110:	00112623          	sw	ra,12(sp)
80001114:	00812423          	sw	s0,8(sp)
80001118:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
8000111c:	0c0007b7          	lui	a5,0xc000
80001120:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001124:	00100713          	li	a4,1
80001128:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
8000112c:	f69ff0ef          	jal	ra,80001094 <r_tp>
80001130:	00050793          	mv	a5,a0
80001134:	00879713          	slli	a4,a5,0x8
80001138:	0c0027b7          	lui	a5,0xc002
8000113c:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001140:	00f707b3          	add	a5,a4,a5
80001144:	00078713          	mv	a4,a5
80001148:	40000793          	li	a5,1024
8000114c:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001150:	f45ff0ef          	jal	ra,80001094 <r_tp>
80001154:	00050713          	mv	a4,a0
80001158:	000c07b7          	lui	a5,0xc0
8000115c:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
80001160:	00f707b3          	add	a5,a4,a5
80001164:	00879793          	slli	a5,a5,0x8
80001168:	00078713          	mv	a4,a5
8000116c:	40000793          	li	a5,1024
80001170:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
80001174:	f21ff0ef          	jal	ra,80001094 <r_tp>
80001178:	00050713          	mv	a4,a0
8000117c:	000067b7          	lui	a5,0x6
80001180:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
80001184:	00f707b3          	add	a5,a4,a5
80001188:	00d79793          	slli	a5,a5,0xd
8000118c:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
80001190:	f05ff0ef          	jal	ra,80001094 <r_tp>
80001194:	00050793          	mv	a5,a0
80001198:	00d79713          	slli	a4,a5,0xd
8000119c:	0c2017b7          	lui	a5,0xc201
800011a0:	00f707b3          	add	a5,a4,a5
800011a4:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800011a8:	f15ff0ef          	jal	ra,800010bc <r_sie>
800011ac:	00050793          	mv	a5,a0
800011b0:	2227e793          	ori	a5,a5,546
800011b4:	00078513          	mv	a0,a5
800011b8:	f2dff0ef          	jal	ra,800010e4 <w_sie>
}
800011bc:	00000013          	nop
800011c0:	00c12083          	lw	ra,12(sp)
800011c4:	00812403          	lw	s0,8(sp)
800011c8:	01010113          	addi	sp,sp,16
800011cc:	00008067          	ret

800011d0 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
800011d0:	ff010113          	addi	sp,sp,-16
800011d4:	00112623          	sw	ra,12(sp)
800011d8:	00812423          	sw	s0,8(sp)
800011dc:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
800011e0:	eb5ff0ef          	jal	ra,80001094 <r_tp>
800011e4:	00050793          	mv	a5,a0
800011e8:	00d79713          	slli	a4,a5,0xd
800011ec:	0c2017b7          	lui	a5,0xc201
800011f0:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
800011f4:	00f707b3          	add	a5,a4,a5
800011f8:	0007a783          	lw	a5,0(a5)
}
800011fc:	00078513          	mv	a0,a5
80001200:	00c12083          	lw	ra,12(sp)
80001204:	00812403          	lw	s0,8(sp)
80001208:	01010113          	addi	sp,sp,16
8000120c:	00008067          	ret

80001210 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001210:	fe010113          	addi	sp,sp,-32
80001214:	00112e23          	sw	ra,28(sp)
80001218:	00812c23          	sw	s0,24(sp)
8000121c:	02010413          	addi	s0,sp,32
80001220:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80001224:	e71ff0ef          	jal	ra,80001094 <r_tp>
80001228:	00050793          	mv	a5,a0
8000122c:	00d79713          	slli	a4,a5,0xd
80001230:	0c2007b7          	lui	a5,0xc200
80001234:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
80001238:	00f707b3          	add	a5,a4,a5
8000123c:	00078713          	mv	a4,a5
80001240:	fec42783          	lw	a5,-20(s0)
80001244:	00f72023          	sw	a5,0(a4)
80001248:	00000013          	nop
8000124c:	01c12083          	lw	ra,28(sp)
80001250:	01812403          	lw	s0,24(sp)
80001254:	02010113          	addi	sp,sp,32
80001258:	00008067          	ret

8000125c <w_satp>:
static inline void w_satp(uint32 x){
8000125c:	fe010113          	addi	sp,sp,-32
80001260:	00812e23          	sw	s0,28(sp)
80001264:	02010413          	addi	s0,sp,32
80001268:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
8000126c:	fec42783          	lw	a5,-20(s0)
80001270:	18079073          	csrw	satp,a5
}
80001274:	00000013          	nop
80001278:	01c12403          	lw	s0,28(sp)
8000127c:	02010113          	addi	sp,sp,32
80001280:	00008067          	ret

80001284 <sfence_vma>:
static inline void sfence_vma(){
80001284:	ff010113          	addi	sp,sp,-16
80001288:	00812623          	sw	s0,12(sp)
8000128c:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
80001290:	12000073          	sfence.vma
}
80001294:	00000013          	nop
80001298:	00c12403          	lw	s0,12(sp)
8000129c:	01010113          	addi	sp,sp,16
800012a0:	00008067          	ret

800012a4 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
800012a4:	fd010113          	addi	sp,sp,-48
800012a8:	02112623          	sw	ra,44(sp)
800012ac:	02812423          	sw	s0,40(sp)
800012b0:	03010413          	addi	s0,sp,48
800012b4:	fca42e23          	sw	a0,-36(s0)
800012b8:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
800012bc:	fd842783          	lw	a5,-40(s0)
800012c0:	0167d793          	srli	a5,a5,0x16
800012c4:	00279793          	slli	a5,a5,0x2
800012c8:	fdc42703          	lw	a4,-36(s0)
800012cc:	00f707b3          	add	a5,a4,a5
800012d0:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
800012d4:	fec42783          	lw	a5,-20(s0)
800012d8:	0007a783          	lw	a5,0(a5)
800012dc:	0017f793          	andi	a5,a5,1
800012e0:	00078e63          	beqz	a5,800012fc <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
800012e4:	fec42783          	lw	a5,-20(s0)
800012e8:	0007a783          	lw	a5,0(a5)
800012ec:	00a7d793          	srli	a5,a5,0xa
800012f0:	00c79793          	slli	a5,a5,0xc
800012f4:	fcf42e23          	sw	a5,-36(s0)
800012f8:	0340006f          	j	8000132c <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
800012fc:	cedff0ef          	jal	ra,80000fe8 <palloc>
80001300:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001304:	00001637          	lui	a2,0x1
80001308:	00000593          	li	a1,0
8000130c:	fdc42503          	lw	a0,-36(s0)
80001310:	6b8000ef          	jal	ra,800019c8 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001314:	fdc42783          	lw	a5,-36(s0)
80001318:	00c7d793          	srli	a5,a5,0xc
8000131c:	00a79793          	slli	a5,a5,0xa
80001320:	0017e713          	ori	a4,a5,1
80001324:	fec42783          	lw	a5,-20(s0)
80001328:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
8000132c:	fd842783          	lw	a5,-40(s0)
80001330:	00c7d793          	srli	a5,a5,0xc
80001334:	3ff7f793          	andi	a5,a5,1023
80001338:	00279793          	slli	a5,a5,0x2
8000133c:	fdc42703          	lw	a4,-36(s0)
80001340:	00f707b3          	add	a5,a4,a5
}
80001344:	00078513          	mv	a0,a5
80001348:	02c12083          	lw	ra,44(sp)
8000134c:	02812403          	lw	s0,40(sp)
80001350:	03010113          	addi	sp,sp,48
80001354:	00008067          	ret

80001358 <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
80001358:	fc010113          	addi	sp,sp,-64
8000135c:	02112e23          	sw	ra,60(sp)
80001360:	02812c23          	sw	s0,56(sp)
80001364:	04010413          	addi	s0,sp,64
80001368:	fca42e23          	sw	a0,-36(s0)
8000136c:	fcb42c23          	sw	a1,-40(s0)
80001370:	fcc42a23          	sw	a2,-44(s0)
80001374:	fcd42823          	sw	a3,-48(s0)
80001378:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
8000137c:	fd842703          	lw	a4,-40(s0)
80001380:	fffff7b7          	lui	a5,0xfffff
80001384:	00f777b3          	and	a5,a4,a5
80001388:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
8000138c:	fd042703          	lw	a4,-48(s0)
80001390:	fd842783          	lw	a5,-40(s0)
80001394:	00f707b3          	add	a5,a4,a5
80001398:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
8000139c:	fffff7b7          	lui	a5,0xfffff
800013a0:	00f777b3          	and	a5,a4,a5
800013a4:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
800013a8:	fec42583          	lw	a1,-20(s0)
800013ac:	fdc42503          	lw	a0,-36(s0)
800013b0:	ef5ff0ef          	jal	ra,800012a4 <acquriepte>
800013b4:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
800013b8:	fe442783          	lw	a5,-28(s0)
800013bc:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
800013c0:	0017f793          	andi	a5,a5,1
800013c4:	00078863          	beqz	a5,800013d4 <vmmap+0x7c>
            panic("repeat map");
800013c8:	800027b7          	lui	a5,0x80002
800013cc:	33078513          	addi	a0,a5,816 # 80002330 <memend+0xf8002330>
800013d0:	f58ff0ef          	jal	ra,80000b28 <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
800013d4:	fd442783          	lw	a5,-44(s0)
800013d8:	00c7d793          	srli	a5,a5,0xc
800013dc:	00a79713          	slli	a4,a5,0xa
800013e0:	fcc42783          	lw	a5,-52(s0)
800013e4:	00f767b3          	or	a5,a4,a5
800013e8:	0017e713          	ori	a4,a5,1
800013ec:	fe442783          	lw	a5,-28(s0)
800013f0:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
800013f4:	fec42703          	lw	a4,-20(s0)
800013f8:	fe842783          	lw	a5,-24(s0)
800013fc:	02f70463          	beq	a4,a5,80001424 <vmmap+0xcc>
        start += PGSIZE;
80001400:	fec42703          	lw	a4,-20(s0)
80001404:	000017b7          	lui	a5,0x1
80001408:	00f707b3          	add	a5,a4,a5
8000140c:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001410:	fd442703          	lw	a4,-44(s0)
80001414:	000017b7          	lui	a5,0x1
80001418:	00f707b3          	add	a5,a4,a5
8000141c:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001420:	f89ff06f          	j	800013a8 <vmmap+0x50>
        if(start==end)  break;
80001424:	00000013          	nop
    }
}
80001428:	00000013          	nop
8000142c:	03c12083          	lw	ra,60(sp)
80001430:	03812403          	lw	s0,56(sp)
80001434:	04010113          	addi	sp,sp,64
80001438:	00008067          	ret

8000143c <printpgt>:

void printpgt(addr_t* pgt){
8000143c:	fc010113          	addi	sp,sp,-64
80001440:	02112e23          	sw	ra,60(sp)
80001444:	02812c23          	sw	s0,56(sp)
80001448:	04010413          	addi	s0,sp,64
8000144c:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
80001450:	fe042623          	sw	zero,-20(s0)
80001454:	0c40006f          	j	80001518 <printpgt+0xdc>
        pte_t pte=pgt[i];
80001458:	fec42783          	lw	a5,-20(s0)
8000145c:	00279793          	slli	a5,a5,0x2
80001460:	fcc42703          	lw	a4,-52(s0)
80001464:	00f707b3          	add	a5,a4,a5
80001468:	0007a783          	lw	a5,0(a5) # 1000 <sz>
8000146c:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
80001470:	fe442783          	lw	a5,-28(s0)
80001474:	0017f793          	andi	a5,a5,1
80001478:	08078a63          	beqz	a5,8000150c <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
8000147c:	fe442783          	lw	a5,-28(s0)
80001480:	00a7d793          	srli	a5,a5,0xa
80001484:	00c79793          	slli	a5,a5,0xc
80001488:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
8000148c:	fe042683          	lw	a3,-32(s0)
80001490:	fe442603          	lw	a2,-28(s0)
80001494:	fec42583          	lw	a1,-20(s0)
80001498:	800027b7          	lui	a5,0x80002
8000149c:	33c78513          	addi	a0,a5,828 # 8000233c <memend+0xf800233c>
800014a0:	ec0ff0ef          	jal	ra,80000b60 <printf>
            for(int j=0;j<1024;j++){
800014a4:	fe042423          	sw	zero,-24(s0)
800014a8:	0580006f          	j	80001500 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
800014ac:	fe842783          	lw	a5,-24(s0)
800014b0:	00279793          	slli	a5,a5,0x2
800014b4:	fe042703          	lw	a4,-32(s0)
800014b8:	00f707b3          	add	a5,a4,a5
800014bc:	0007a783          	lw	a5,0(a5)
800014c0:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
800014c4:	fdc42783          	lw	a5,-36(s0)
800014c8:	0017f793          	andi	a5,a5,1
800014cc:	02078463          	beqz	a5,800014f4 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
800014d0:	fdc42783          	lw	a5,-36(s0)
800014d4:	00a7d793          	srli	a5,a5,0xa
800014d8:	00c79793          	slli	a5,a5,0xc
800014dc:	00078693          	mv	a3,a5
800014e0:	fdc42603          	lw	a2,-36(s0)
800014e4:	fe842583          	lw	a1,-24(s0)
800014e8:	800027b7          	lui	a5,0x80002
800014ec:	35478513          	addi	a0,a5,852 # 80002354 <memend+0xf8002354>
800014f0:	e70ff0ef          	jal	ra,80000b60 <printf>
            for(int j=0;j<1024;j++){
800014f4:	fe842783          	lw	a5,-24(s0)
800014f8:	00178793          	addi	a5,a5,1
800014fc:	fef42423          	sw	a5,-24(s0)
80001500:	fe842703          	lw	a4,-24(s0)
80001504:	3ff00793          	li	a5,1023
80001508:	fae7d2e3          	bge	a5,a4,800014ac <printpgt+0x70>
    for(int i=0;i<1024;i++){
8000150c:	fec42783          	lw	a5,-20(s0)
80001510:	00178793          	addi	a5,a5,1
80001514:	fef42623          	sw	a5,-20(s0)
80001518:	fec42703          	lw	a4,-20(s0)
8000151c:	3ff00793          	li	a5,1023
80001520:	f2e7dce3          	bge	a5,a4,80001458 <printpgt+0x1c>
                }
            }
        }
    }
}
80001524:	00000013          	nop
80001528:	00000013          	nop
8000152c:	03c12083          	lw	ra,60(sp)
80001530:	03812403          	lw	s0,56(sp)
80001534:	04010113          	addi	sp,sp,64
80001538:	00008067          	ret

8000153c <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
8000153c:	fd010113          	addi	sp,sp,-48
80001540:	02112623          	sw	ra,44(sp)
80001544:	02812423          	sw	s0,40(sp)
80001548:	03010413          	addi	s0,sp,48
8000154c:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
80001550:	fe042623          	sw	zero,-20(s0)
80001554:	04c0006f          	j	800015a0 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
80001558:	fec42783          	lw	a5,-20(s0)
8000155c:	00d79793          	slli	a5,a5,0xd
80001560:	00078713          	mv	a4,a5
80001564:	c00017b7          	lui	a5,0xc0001
80001568:	00f707b3          	add	a5,a4,a5
8000156c:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
80001570:	a79ff0ef          	jal	ra,80000fe8 <palloc>
80001574:	00050793          	mv	a5,a0
80001578:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
8000157c:	00600713          	li	a4,6
80001580:	000016b7          	lui	a3,0x1
80001584:	fe442603          	lw	a2,-28(s0)
80001588:	fe842583          	lw	a1,-24(s0)
8000158c:	fdc42503          	lw	a0,-36(s0)
80001590:	dc9ff0ef          	jal	ra,80001358 <vmmap>
    for(int i=0;i<NPROC;i++){
80001594:	fec42783          	lw	a5,-20(s0)
80001598:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
8000159c:	fef42623          	sw	a5,-20(s0)
800015a0:	fec42703          	lw	a4,-20(s0)
800015a4:	00300793          	li	a5,3
800015a8:	fae7d8e3          	bge	a5,a4,80001558 <mkstack+0x1c>
    }
}
800015ac:	00000013          	nop
800015b0:	00000013          	nop
800015b4:	02c12083          	lw	ra,44(sp)
800015b8:	02812403          	lw	s0,40(sp)
800015bc:	03010113          	addi	sp,sp,48
800015c0:	00008067          	ret

800015c4 <vminit>:

// 初始化虚拟内存
void vminit(){
800015c4:	ff010113          	addi	sp,sp,-16
800015c8:	00112623          	sw	ra,12(sp)
800015cc:	00812423          	sw	s0,8(sp)
800015d0:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
800015d4:	a15ff0ef          	jal	ra,80000fe8 <palloc>
800015d8:	00050713          	mv	a4,a0
800015dc:	8000c7b7          	lui	a5,0x8000c
800015e0:	62e7ac23          	sw	a4,1592(a5) # 8000c638 <memend+0xf800c638>
    memset(kpgt,0,PGSIZE);
800015e4:	8000c7b7          	lui	a5,0x8000c
800015e8:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
800015ec:	00001637          	lui	a2,0x1
800015f0:	00000593          	li	a1,0
800015f4:	00078513          	mv	a0,a5
800015f8:	3d0000ef          	jal	ra,800019c8 <memset>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
800015fc:	8000c7b7          	lui	a5,0x8000c
80001600:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
80001604:	00600713          	li	a4,6
80001608:	004006b7          	lui	a3,0x400
8000160c:	0c000637          	lui	a2,0xc000
80001610:	0c0005b7          	lui	a1,0xc000
80001614:	00078513          	mv	a0,a5
80001618:	d41ff0ef          	jal	ra,80001358 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
8000161c:	8000c7b7          	lui	a5,0x8000c
80001620:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
80001624:	00600713          	li	a4,6
80001628:	000016b7          	lui	a3,0x1
8000162c:	10000637          	lui	a2,0x10000
80001630:	100005b7          	lui	a1,0x10000
80001634:	00078513          	mv	a0,a5
80001638:	d21ff0ef          	jal	ra,80001358 <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
8000163c:	8000c7b7          	lui	a5,0x8000c
80001640:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001644:	800007b7          	lui	a5,0x80000
80001648:	00078593          	mv	a1,a5
8000164c:	800007b7          	lui	a5,0x80000
80001650:	00078613          	mv	a2,a5
80001654:	800027b7          	lui	a5,0x80002
80001658:	c1878713          	addi	a4,a5,-1000 # 80001c18 <memend+0xf8001c18>
8000165c:	800007b7          	lui	a5,0x80000
80001660:	00078793          	mv	a5,a5
80001664:	40f707b3          	sub	a5,a4,a5
80001668:	00a00713          	li	a4,10
8000166c:	00078693          	mv	a3,a5
80001670:	ce9ff0ef          	jal	ra,80001358 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001674:	8000c7b7          	lui	a5,0x8000c
80001678:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
8000167c:	800027b7          	lui	a5,0x80002
80001680:	00078593          	mv	a1,a5
80001684:	800027b7          	lui	a5,0x80002
80001688:	00078613          	mv	a2,a5
8000168c:	800027b7          	lui	a5,0x80002
80001690:	36b78713          	addi	a4,a5,875 # 8000236b <memend+0xf800236b>
80001694:	800027b7          	lui	a5,0x80002
80001698:	00078793          	mv	a5,a5
8000169c:	40f707b3          	sub	a5,a4,a5
800016a0:	00200713          	li	a4,2
800016a4:	00078693          	mv	a3,a5
800016a8:	cb1ff0ef          	jal	ra,80001358 <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
800016ac:	8000c7b7          	lui	a5,0x8000c
800016b0:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
800016b4:	800037b7          	lui	a5,0x80003
800016b8:	00078593          	mv	a1,a5
800016bc:	800037b7          	lui	a5,0x80003
800016c0:	00078613          	mv	a2,a5
800016c4:	8000b7b7          	lui	a5,0x8000b
800016c8:	00478713          	addi	a4,a5,4 # 8000b004 <memend+0xf800b004>
800016cc:	800037b7          	lui	a5,0x80003
800016d0:	00078793          	mv	a5,a5
800016d4:	40f707b3          	sub	a5,a4,a5
800016d8:	00600713          	li	a4,6
800016dc:	00078693          	mv	a3,a5
800016e0:	c79ff0ef          	jal	ra,80001358 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
800016e4:	8000c7b7          	lui	a5,0x8000c
800016e8:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
800016ec:	8000c7b7          	lui	a5,0x8000c
800016f0:	00078593          	mv	a1,a5
800016f4:	8000c7b7          	lui	a5,0x8000c
800016f8:	00078613          	mv	a2,a5
800016fc:	8000c7b7          	lui	a5,0x8000c
80001700:	63c78713          	addi	a4,a5,1596 # 8000c63c <memend+0xf800c63c>
80001704:	8000c7b7          	lui	a5,0x8000c
80001708:	00078793          	mv	a5,a5
8000170c:	40f707b3          	sub	a5,a4,a5
80001710:	00600713          	li	a4,6
80001714:	00078693          	mv	a3,a5
80001718:	c41ff0ef          	jal	ra,80001358 <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
8000171c:	8000c7b7          	lui	a5,0x8000c
80001720:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001724:	8000d7b7          	lui	a5,0x8000d
80001728:	00078593          	mv	a1,a5
8000172c:	8000d7b7          	lui	a5,0x8000d
80001730:	00078613          	mv	a2,a5
80001734:	880007b7          	lui	a5,0x88000
80001738:	00078713          	mv	a4,a5
8000173c:	8000d7b7          	lui	a5,0x8000d
80001740:	00078793          	mv	a5,a5
80001744:	40f707b3          	sub	a5,a4,a5
80001748:	00600713          	li	a4,6
8000174c:	00078693          	mv	a3,a5
80001750:	c09ff0ef          	jal	ra,80001358 <vmmap>

    mkstack(kpgt);
80001754:	8000c7b7          	lui	a5,0x8000c
80001758:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
8000175c:	00078513          	mv	a0,a5
80001760:	dddff0ef          	jal	ra,8000153c <mkstack>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001764:	8000c7b7          	lui	a5,0x8000c
80001768:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
8000176c:	00c7d713          	srli	a4,a5,0xc
80001770:	800007b7          	lui	a5,0x80000
80001774:	00f767b3          	or	a5,a4,a5
80001778:	00078513          	mv	a0,a5
8000177c:	ae1ff0ef          	jal	ra,8000125c <w_satp>
    sfence_vma();       // 刷新页表
80001780:	b05ff0ef          	jal	ra,80001284 <sfence_vma>
}
80001784:	00000013          	nop
80001788:	00c12083          	lw	ra,12(sp)
8000178c:	00812403          	lw	s0,8(sp)
80001790:	01010113          	addi	sp,sp,16
80001794:	00008067          	ret

80001798 <pgtcreate>:

addr_t* pgtcreate(){
80001798:	fe010113          	addi	sp,sp,-32
8000179c:	00112e23          	sw	ra,28(sp)
800017a0:	00812c23          	sw	s0,24(sp)
800017a4:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
800017a8:	841ff0ef          	jal	ra,80000fe8 <palloc>
800017ac:	fea42623          	sw	a0,-20(s0)

    return pgt;
800017b0:	fec42783          	lw	a5,-20(s0)
}
800017b4:	00078513          	mv	a0,a5
800017b8:	01c12083          	lw	ra,28(sp)
800017bc:	01812403          	lw	s0,24(sp)
800017c0:	02010113          	addi	sp,sp,32
800017c4:	00008067          	ret

800017c8 <procinit>:
#include "vm.h"
#include "defs.h"

uint nextpid=0;

void procinit(){
800017c8:	fe010113          	addi	sp,sp,-32
800017cc:	00812e23          	sw	s0,28(sp)
800017d0:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
800017d4:	fe042623          	sw	zero,-20(s0)
800017d8:	0480006f          	j	80001820 <procinit+0x58>
        p=&proc[i];
800017dc:	fec42703          	lw	a4,-20(s0)
800017e0:	08c00793          	li	a5,140
800017e4:	02f70733          	mul	a4,a4,a5
800017e8:	8000c7b7          	lui	a5,0x8000c
800017ec:	40878793          	addi	a5,a5,1032 # 8000c408 <memend+0xf800c408>
800017f0:	00f707b3          	add	a5,a4,a5
800017f4:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
800017f8:	fec42783          	lw	a5,-20(s0)
800017fc:	00d79793          	slli	a5,a5,0xd
80001800:	00078713          	mv	a4,a5
80001804:	c00027b7          	lui	a5,0xc0002
80001808:	00f70733          	add	a4,a4,a5
8000180c:	fe842783          	lw	a5,-24(s0)
80001810:	08e7a423          	sw	a4,136(a5) # c0002088 <memend+0x38002088>
    for(int i=0;i<NPROC;i++){
80001814:	fec42783          	lw	a5,-20(s0)
80001818:	00178793          	addi	a5,a5,1
8000181c:	fef42623          	sw	a5,-20(s0)
80001820:	fec42703          	lw	a4,-20(s0)
80001824:	00300793          	li	a5,3
80001828:	fae7dae3          	bge	a5,a4,800017dc <procinit+0x14>
    }
}
8000182c:	00000013          	nop
80001830:	00000013          	nop
80001834:	01c12403          	lw	s0,28(sp)
80001838:	02010113          	addi	sp,sp,32
8000183c:	00008067          	ret

80001840 <pidalloc>:

uint pidalloc(){
80001840:	ff010113          	addi	sp,sp,-16
80001844:	00812623          	sw	s0,12(sp)
80001848:	01010413          	addi	s0,sp,16
    return nextpid++;
8000184c:	8000c7b7          	lui	a5,0x8000c
80001850:	0007a783          	lw	a5,0(a5) # 8000c000 <memend+0xf800c000>
80001854:	00178693          	addi	a3,a5,1
80001858:	8000c737          	lui	a4,0x8000c
8000185c:	00d72023          	sw	a3,0(a4) # 8000c000 <memend+0xf800c000>
} 
80001860:	00078513          	mv	a0,a5
80001864:	00c12403          	lw	s0,12(sp)
80001868:	01010113          	addi	sp,sp,16
8000186c:	00008067          	ret

80001870 <procalloc>:

struct pcb* procalloc(){
80001870:	fe010113          	addi	sp,sp,-32
80001874:	00112e23          	sw	ra,28(sp)
80001878:	00812c23          	sw	s0,24(sp)
8000187c:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80001880:	8000c7b7          	lui	a5,0x8000c
80001884:	40878793          	addi	a5,a5,1032 # 8000c408 <memend+0xf800c408>
80001888:	fef42623          	sw	a5,-20(s0)
8000188c:	0540006f          	j	800018e0 <procalloc+0x70>
        if(p->status==UNUSED){
80001890:	fec42783          	lw	a5,-20(s0)
80001894:	0047a783          	lw	a5,4(a5)
80001898:	02079e63          	bnez	a5,800018d4 <procalloc+0x64>
            p->pid=pidalloc();
8000189c:	fa5ff0ef          	jal	ra,80001840 <pidalloc>
800018a0:	00050793          	mv	a5,a0
800018a4:	00078713          	mv	a4,a5
800018a8:	fec42783          	lw	a5,-20(s0)
800018ac:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
800018b0:	fec42783          	lw	a5,-20(s0)
800018b4:	00100713          	li	a4,1
800018b8:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
800018bc:	eddff0ef          	jal	ra,80001798 <pgtcreate>
800018c0:	00050713          	mv	a4,a0
800018c4:	fec42783          	lw	a5,-20(s0)
800018c8:	08e7a223          	sw	a4,132(a5)
            return p;
800018cc:	fec42783          	lw	a5,-20(s0)
800018d0:	0240006f          	j	800018f4 <procalloc+0x84>
    for(p=proc;p<&proc[NPROC];p++){
800018d4:	fec42783          	lw	a5,-20(s0)
800018d8:	08c78793          	addi	a5,a5,140
800018dc:	fef42623          	sw	a5,-20(s0)
800018e0:	fec42703          	lw	a4,-20(s0)
800018e4:	8000c7b7          	lui	a5,0x8000c
800018e8:	63878793          	addi	a5,a5,1592 # 8000c638 <memend+0xf800c638>
800018ec:	faf762e3          	bltu	a4,a5,80001890 <procalloc+0x20>
        }
    }
    return 0;
800018f0:	00000793          	li	a5,0
}
800018f4:	00078513          	mv	a0,a5
800018f8:	01c12083          	lw	ra,28(sp)
800018fc:	01812403          	lw	s0,24(sp)
80001900:	02010113          	addi	sp,sp,32
80001904:	00008067          	ret

80001908 <userinit>:

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
80001908:	fe010113          	addi	sp,sp,-32
8000190c:	00112e23          	sw	ra,28(sp)
80001910:	00812c23          	sw	s0,24(sp)
80001914:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80001918:	f59ff0ef          	jal	ra,80001870 <procalloc>
8000191c:	fea42623          	sw	a0,-20(s0)
    
    char* m=(char*)palloc();
80001920:	ec8ff0ef          	jal	ra,80000fe8 <palloc>
80001924:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80001928:	00400613          	li	a2,4
8000192c:	00000693          	li	a3,0
80001930:	800037b7          	lui	a5,0x80003
80001934:	00078593          	mv	a1,a5
80001938:	fe842503          	lw	a0,-24(s0)
8000193c:	0f8000ef          	jal	ra,80001a34 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X);
80001940:	fec42783          	lw	a5,-20(s0)
80001944:	0847a783          	lw	a5,132(a5) # 80003084 <memend+0xf8003084>
80001948:	fe842603          	lw	a2,-24(s0)
8000194c:	00e00713          	li	a4,14
80001950:	000016b7          	lui	a3,0x1
80001954:	00000593          	li	a1,0
80001958:	00078513          	mv	a0,a5
8000195c:	9fdff0ef          	jal	ra,80001358 <vmmap>

    p->context.sp=KSPACE;
80001960:	fec42783          	lw	a5,-20(s0)
80001964:	c0000737          	lui	a4,0xc0000
80001968:	00e7a623          	sw	a4,12(a5)

    p->status=RUNABLE;
8000196c:	fec42783          	lw	a5,-20(s0)
80001970:	00200713          	li	a4,2
80001974:	00e7a223          	sw	a4,4(a5)
}
80001978:	00000013          	nop
8000197c:	01c12083          	lw	ra,28(sp)
80001980:	01812403          	lw	s0,24(sp)
80001984:	02010113          	addi	sp,sp,32
80001988:	00008067          	ret

8000198c <schedule>:

void schedule(){
8000198c:	fe010113          	addi	sp,sp,-32
80001990:	00812e23          	sw	s0,28(sp)
80001994:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
80001998:	8000c7b7          	lui	a5,0x8000c
8000199c:	40878793          	addi	a5,a5,1032 # 8000c408 <memend+0xf800c408>
800019a0:	fef42623          	sw	a5,-20(s0)
800019a4:	0100006f          	j	800019b4 <schedule+0x28>
800019a8:	fec42783          	lw	a5,-20(s0)
800019ac:	08c78793          	addi	a5,a5,140
800019b0:	fef42623          	sw	a5,-20(s0)
800019b4:	fec42703          	lw	a4,-20(s0)
800019b8:	8000c7b7          	lui	a5,0x8000c
800019bc:	63878793          	addi	a5,a5,1592 # 8000c638 <memend+0xf800c638>
800019c0:	fef764e3          	bltu	a4,a5,800019a8 <schedule+0x1c>
    for(;;){
800019c4:	fd5ff06f          	j	80001998 <schedule+0xc>

800019c8 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
800019c8:	fd010113          	addi	sp,sp,-48
800019cc:	02812623          	sw	s0,44(sp)
800019d0:	03010413          	addi	s0,sp,48
800019d4:	fca42e23          	sw	a0,-36(s0)
800019d8:	fcb42c23          	sw	a1,-40(s0)
800019dc:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
800019e0:	fdc42783          	lw	a5,-36(s0)
800019e4:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
800019e8:	fe042623          	sw	zero,-20(s0)
800019ec:	0280006f          	j	80001a14 <memset+0x4c>
        maddr[i] = (char)c;
800019f0:	fe842703          	lw	a4,-24(s0)
800019f4:	fec42783          	lw	a5,-20(s0)
800019f8:	00f707b3          	add	a5,a4,a5
800019fc:	fd842703          	lw	a4,-40(s0)
80001a00:	0ff77713          	andi	a4,a4,255
80001a04:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001a08:	fec42783          	lw	a5,-20(s0)
80001a0c:	00178793          	addi	a5,a5,1
80001a10:	fef42623          	sw	a5,-20(s0)
80001a14:	fec42703          	lw	a4,-20(s0)
80001a18:	fd442783          	lw	a5,-44(s0)
80001a1c:	fcf76ae3          	bltu	a4,a5,800019f0 <memset+0x28>
    }
    return addr;
80001a20:	fdc42783          	lw	a5,-36(s0)
}
80001a24:	00078513          	mv	a0,a5
80001a28:	02c12403          	lw	s0,44(sp)
80001a2c:	03010113          	addi	sp,sp,48
80001a30:	00008067          	ret

80001a34 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80001a34:	fd010113          	addi	sp,sp,-48
80001a38:	02812623          	sw	s0,44(sp)
80001a3c:	03010413          	addi	s0,sp,48
80001a40:	fca42e23          	sw	a0,-36(s0)
80001a44:	fcb42c23          	sw	a1,-40(s0)
80001a48:	fcc42823          	sw	a2,-48(s0)
80001a4c:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001a50:	fd042783          	lw	a5,-48(s0)
80001a54:	fd442703          	lw	a4,-44(s0)
80001a58:	00e7e7b3          	or	a5,a5,a4
80001a5c:	00079663          	bnez	a5,80001a68 <memmove+0x34>
        return dst;
80001a60:	fdc42783          	lw	a5,-36(s0)
80001a64:	1200006f          	j	80001b84 <memmove+0x150>
    }

    s = src;
80001a68:	fd842783          	lw	a5,-40(s0)
80001a6c:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001a70:	fdc42783          	lw	a5,-36(s0)
80001a74:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001a78:	fec42703          	lw	a4,-20(s0)
80001a7c:	fe842783          	lw	a5,-24(s0)
80001a80:	0cf77263          	bgeu	a4,a5,80001b44 <memmove+0x110>
80001a84:	fd042783          	lw	a5,-48(s0)
80001a88:	fec42703          	lw	a4,-20(s0)
80001a8c:	00f707b3          	add	a5,a4,a5
80001a90:	fe842703          	lw	a4,-24(s0)
80001a94:	0af77863          	bgeu	a4,a5,80001b44 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80001a98:	fd042783          	lw	a5,-48(s0)
80001a9c:	fec42703          	lw	a4,-20(s0)
80001aa0:	00f707b3          	add	a5,a4,a5
80001aa4:	fef42623          	sw	a5,-20(s0)
        d += n;
80001aa8:	fd042783          	lw	a5,-48(s0)
80001aac:	fe842703          	lw	a4,-24(s0)
80001ab0:	00f707b3          	add	a5,a4,a5
80001ab4:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80001ab8:	02c0006f          	j	80001ae4 <memmove+0xb0>
            *--d = *--s;
80001abc:	fec42783          	lw	a5,-20(s0)
80001ac0:	fff78793          	addi	a5,a5,-1
80001ac4:	fef42623          	sw	a5,-20(s0)
80001ac8:	fe842783          	lw	a5,-24(s0)
80001acc:	fff78793          	addi	a5,a5,-1
80001ad0:	fef42423          	sw	a5,-24(s0)
80001ad4:	fec42783          	lw	a5,-20(s0)
80001ad8:	0007c703          	lbu	a4,0(a5)
80001adc:	fe842783          	lw	a5,-24(s0)
80001ae0:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80001ae4:	fd042703          	lw	a4,-48(s0)
80001ae8:	fd442783          	lw	a5,-44(s0)
80001aec:	fff00513          	li	a0,-1
80001af0:	fff00593          	li	a1,-1
80001af4:	00a70633          	add	a2,a4,a0
80001af8:	00060813          	mv	a6,a2
80001afc:	00e83833          	sltu	a6,a6,a4
80001b00:	00b786b3          	add	a3,a5,a1
80001b04:	00d805b3          	add	a1,a6,a3
80001b08:	00058693          	mv	a3,a1
80001b0c:	fcc42823          	sw	a2,-48(s0)
80001b10:	fcd42a23          	sw	a3,-44(s0)
80001b14:	00070693          	mv	a3,a4
80001b18:	00f6e6b3          	or	a3,a3,a5
80001b1c:	fa0690e3          	bnez	a3,80001abc <memmove+0x88>
    if(s < d && s + n > d){     
80001b20:	0600006f          	j	80001b80 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80001b24:	fec42703          	lw	a4,-20(s0)
80001b28:	00170793          	addi	a5,a4,1 # c0000001 <memend+0x38000001>
80001b2c:	fef42623          	sw	a5,-20(s0)
80001b30:	fe842783          	lw	a5,-24(s0)
80001b34:	00178693          	addi	a3,a5,1
80001b38:	fed42423          	sw	a3,-24(s0)
80001b3c:	00074703          	lbu	a4,0(a4)
80001b40:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80001b44:	fd042703          	lw	a4,-48(s0)
80001b48:	fd442783          	lw	a5,-44(s0)
80001b4c:	fff00513          	li	a0,-1
80001b50:	fff00593          	li	a1,-1
80001b54:	00a70633          	add	a2,a4,a0
80001b58:	00060813          	mv	a6,a2
80001b5c:	00e83833          	sltu	a6,a6,a4
80001b60:	00b786b3          	add	a3,a5,a1
80001b64:	00d805b3          	add	a1,a6,a3
80001b68:	00058693          	mv	a3,a1
80001b6c:	fcc42823          	sw	a2,-48(s0)
80001b70:	fcd42a23          	sw	a3,-44(s0)
80001b74:	00070693          	mv	a3,a4
80001b78:	00f6e6b3          	or	a3,a3,a5
80001b7c:	fa0694e3          	bnez	a3,80001b24 <memmove+0xf0>
        }
    }
    return dst;
80001b80:	fdc42783          	lw	a5,-36(s0)
}
80001b84:	00078513          	mv	a0,a5
80001b88:	02c12403          	lw	s0,44(sp)
80001b8c:	03010113          	addi	sp,sp,48
80001b90:	00008067          	ret

80001b94 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80001b94:	fd010113          	addi	sp,sp,-48
80001b98:	02812623          	sw	s0,44(sp)
80001b9c:	03010413          	addi	s0,sp,48
80001ba0:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80001ba4:	00000793          	li	a5,0
80001ba8:	00000813          	li	a6,0
80001bac:	fef42423          	sw	a5,-24(s0)
80001bb0:	ff042623          	sw	a6,-20(s0)
80001bb4:	0340006f          	j	80001be8 <strlen+0x54>
80001bb8:	fe842603          	lw	a2,-24(s0)
80001bbc:	fec42683          	lw	a3,-20(s0)
80001bc0:	00100513          	li	a0,1
80001bc4:	00000593          	li	a1,0
80001bc8:	00a60733          	add	a4,a2,a0
80001bcc:	00070813          	mv	a6,a4
80001bd0:	00c83833          	sltu	a6,a6,a2
80001bd4:	00b687b3          	add	a5,a3,a1
80001bd8:	00f806b3          	add	a3,a6,a5
80001bdc:	00068793          	mv	a5,a3
80001be0:	fee42423          	sw	a4,-24(s0)
80001be4:	fef42623          	sw	a5,-20(s0)
80001be8:	fe842783          	lw	a5,-24(s0)
80001bec:	fdc42703          	lw	a4,-36(s0)
80001bf0:	00f707b3          	add	a5,a4,a5
80001bf4:	0007c783          	lbu	a5,0(a5)
80001bf8:	fc0790e3          	bnez	a5,80001bb8 <strlen+0x24>
    
    return n;
80001bfc:	fe842703          	lw	a4,-24(s0)
80001c00:	fec42783          	lw	a5,-20(s0)
80001c04:	00070513          	mv	a0,a4
80001c08:	00078593          	mv	a1,a5
80001c0c:	02c12403          	lw	s0,44(sp)
80001c10:	03010113          	addi	sp,sp,48
80001c14:	00008067          	ret
