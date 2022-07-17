
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
80000010:	ff410113          	addi	sp,sp,-12 # 80003000 <datastart>
    li t1,sz
80000014:	00001337          	lui	t1,0x1
    mul t1,t1,t0
80000018:	02530333          	mul	t1,t1,t0
    add sp,sp,t1 # 栈指针指向栈顶
8000001c:	00610133          	add	sp,sp,t1
    
    # 跳转到start()
    j start
80000020:	6040006f          	j	80000624 <start>

80000024 <empty>:

empty:
    wfi       # 休眠指令 wait for interrupt 直至收到中断
80000024:	10500073          	wfi
    j empty
80000028:	ffdff06f          	j	80000024 <empty>

8000002c <cswap>:

.global cswap
cswap:
    sw ra,0(a1)
8000002c:	0015a023          	sw	ra,0(a1)
    sw sp,4(a1)
80000030:	0025a223          	sw	sp,4(a1)
    sw gp,8(a1)
80000034:	0035a423          	sw	gp,8(a1)
    sw tp,12(a1)
80000038:	0045a623          	sw	tp,12(a1)
    sw a0,16(a1)
8000003c:	00a5a823          	sw	a0,16(a1)
    sw a1,20(a1)
80000040:	00b5aa23          	sw	a1,20(a1)
    sw a2,24(a1)
80000044:	00c5ac23          	sw	a2,24(a1)
    sw a3,28(a1)
80000048:	00d5ae23          	sw	a3,28(a1)
    sw a4,32(a1)
8000004c:	02e5a023          	sw	a4,32(a1)
    sw a5,36(a1)
80000050:	02f5a223          	sw	a5,36(a1)
    sw a6,40(a1)
80000054:	0305a423          	sw	a6,40(a1)
    sw a7,44(a1)
80000058:	0315a623          	sw	a7,44(a1)
    sw s0,48(a1)
8000005c:	0285a823          	sw	s0,48(a1)
    sw s1,52(a1)
80000060:	0295aa23          	sw	s1,52(a1)
    sw s2,56(a1)
80000064:	0325ac23          	sw	s2,56(a1)
    sw s3,60(a1)
80000068:	0335ae23          	sw	s3,60(a1)
    sw s4,64(a1)
8000006c:	0545a023          	sw	s4,64(a1)
    sw s5,68(a1)
80000070:	0555a223          	sw	s5,68(a1)
    sw s6,72(a1)
80000074:	0565a423          	sw	s6,72(a1)
    sw s7,76(a1)
80000078:	0575a623          	sw	s7,76(a1)
    sw s8,80(a1)
8000007c:	0585a823          	sw	s8,80(a1)
    sw s9,84(a1)
80000080:	0595aa23          	sw	s9,84(a1)
    sw s10,88(a1)
80000084:	05a5ac23          	sw	s10,88(a1)
    sw s11,92(a1)
80000088:	05b5ae23          	sw	s11,92(a1)
    sw t0,96(a1)
8000008c:	0655a023          	sw	t0,96(a1)
    sw t1,100(a1)
80000090:	0665a223          	sw	t1,100(a1)
    sw t2,104(a1)
80000094:	0675a423          	sw	t2,104(a1)
    sw t3,108(a1)
80000098:	07c5a623          	sw	t3,108(a1)
    sw t4,112(a1)
8000009c:	07d5a823          	sw	t4,112(a1)
    sw t5,116(a1)
800000a0:	07e5aa23          	sw	t5,116(a1)
    sw t6,120(a1)
800000a4:	07f5ac23          	sw	t6,120(a1)


    lw ra,0(a0)
800000a8:	00052083          	lw	ra,0(a0)
    lw sp,4(a0)
800000ac:	00452103          	lw	sp,4(a0)
    lw gp,8(a0)
800000b0:	00852183          	lw	gp,8(a0)
    lw tp,12(a0)
800000b4:	00c52203          	lw	tp,12(a0)
    lw a0,16(a0)
800000b8:	01052503          	lw	a0,16(a0)
    lw a1,20(a0)
800000bc:	01452583          	lw	a1,20(a0)
    lw a2,24(a0)
800000c0:	01852603          	lw	a2,24(a0)
    lw a3,28(a0)
800000c4:	01c52683          	lw	a3,28(a0)
    lw a4,32(a0)
800000c8:	02052703          	lw	a4,32(a0)
    lw a5,36(a0)
800000cc:	02452783          	lw	a5,36(a0)
    lw a6,40(a0)
800000d0:	02852803          	lw	a6,40(a0)
    lw a7,44(a0)
800000d4:	02c52883          	lw	a7,44(a0)
    lw s0,48(a0)
800000d8:	03052403          	lw	s0,48(a0)
    lw s1,52(a0)
800000dc:	03452483          	lw	s1,52(a0)
    lw s2,56(a0)
800000e0:	03852903          	lw	s2,56(a0)
    lw s3,60(a0)
800000e4:	03c52983          	lw	s3,60(a0)
    lw s4,64(a0)
800000e8:	04052a03          	lw	s4,64(a0)
    lw s5,68(a0)
800000ec:	04452a83          	lw	s5,68(a0)
    lw s6,72(a0)
800000f0:	04852b03          	lw	s6,72(a0)
    lw s7,76(a0)
800000f4:	04c52b83          	lw	s7,76(a0)
    lw s8,80(a0)
800000f8:	05052c03          	lw	s8,80(a0)
    lw s9,84(a0)
800000fc:	05452c83          	lw	s9,84(a0)
    lw s10,88(a0)
80000100:	05852d03          	lw	s10,88(a0)
    lw s11,92(a0)
80000104:	05c52d83          	lw	s11,92(a0)
    lw t0,96(a0)
80000108:	06052283          	lw	t0,96(a0)
    lw t1,100(a0)
8000010c:	06452303          	lw	t1,100(a0)
    lw t2,104(a0)
80000110:	06852383          	lw	t2,104(a0)
    lw t3,108(a0)
80000114:	06c52e03          	lw	t3,108(a0)
    lw t4,112(a0)
80000118:	07052e83          	lw	t4,112(a0)
    lw t5,116(a0)
8000011c:	07452f03          	lw	t5,116(a0)
    lw t6,120(a0)
80000120:	07852f83          	lw	t6,120(a0)

    ret
80000124:	00008067          	ret

80000128 <kvec>:
.global kvec
kvec:
    addi sp,sp,-128
80000128:	f8010113          	addi	sp,sp,-128
    sw ra,0(sp)
8000012c:	00112023          	sw	ra,0(sp)
    sw sp,4(sp)
80000130:	00212223          	sw	sp,4(sp)
    sw gp,8(sp)
80000134:	00312423          	sw	gp,8(sp)
    sw tp,12(sp)
80000138:	00412623          	sw	tp,12(sp)
    sw a0,16(sp)
8000013c:	00a12823          	sw	a0,16(sp)
    sw a1,20(sp)
80000140:	00b12a23          	sw	a1,20(sp)
    sw a2,24(sp)
80000144:	00c12c23          	sw	a2,24(sp)
    sw a3,28(sp)
80000148:	00d12e23          	sw	a3,28(sp)
    sw a4,32(sp)
8000014c:	02e12023          	sw	a4,32(sp)
    sw a5,36(sp)
80000150:	02f12223          	sw	a5,36(sp)
    sw a6,40(sp)
80000154:	03012423          	sw	a6,40(sp)
    sw a7,44(sp)
80000158:	03112623          	sw	a7,44(sp)
    sw s0,48(sp)
8000015c:	02812823          	sw	s0,48(sp)
    sw s1,52(sp)
80000160:	02912a23          	sw	s1,52(sp)
    sw s2,56(sp)
80000164:	03212c23          	sw	s2,56(sp)
    sw s3,60(sp)
80000168:	03312e23          	sw	s3,60(sp)
    sw s4,64(sp)
8000016c:	05412023          	sw	s4,64(sp)
    sw s5,68(sp)
80000170:	05512223          	sw	s5,68(sp)
    sw s6,72(sp)
80000174:	05612423          	sw	s6,72(sp)
    sw s7,76(sp)
80000178:	05712623          	sw	s7,76(sp)
    sw s8,80(sp)
8000017c:	05812823          	sw	s8,80(sp)
    sw s9,84(sp)
80000180:	05912a23          	sw	s9,84(sp)
    sw s10,88(sp)
80000184:	05a12c23          	sw	s10,88(sp)
    sw s11,92(sp)
80000188:	05b12e23          	sw	s11,92(sp)
    sw t0,96(sp)
8000018c:	06512023          	sw	t0,96(sp)
    sw t1,100(sp)
80000190:	06612223          	sw	t1,100(sp)
    sw t2,104(sp)
80000194:	06712423          	sw	t2,104(sp)
    sw t3,108(sp)
80000198:	07c12623          	sw	t3,108(sp)
    sw t4,112(sp)
8000019c:	07d12823          	sw	t4,112(sp)
    sw t5,116(sp)
800001a0:	07e12a23          	sw	t5,116(sp)
    sw t6,120(sp)
800001a4:	07f12c23          	sw	t6,120(sp)

    call trapvec
800001a8:	0b1000ef          	jal	ra,80000a58 <trapvec>

    lw ra,0(sp)
800001ac:	00012083          	lw	ra,0(sp)
    lw sp,4(sp)
800001b0:	00412103          	lw	sp,4(sp)
    lw gp,8(sp)
800001b4:	00812183          	lw	gp,8(sp)
    lw tp,12(sp)
800001b8:	00c12203          	lw	tp,12(sp)
    lw a0,16(sp)
800001bc:	01012503          	lw	a0,16(sp)
    lw a1,20(sp)
800001c0:	01412583          	lw	a1,20(sp)
    lw a2,24(sp)
800001c4:	01812603          	lw	a2,24(sp)
    lw a3,28(sp)
800001c8:	01c12683          	lw	a3,28(sp)
    lw a4,32(sp)
800001cc:	02012703          	lw	a4,32(sp)
    lw a5,36(sp)
800001d0:	02412783          	lw	a5,36(sp)
    lw a6,40(sp)
800001d4:	02812803          	lw	a6,40(sp)
    lw a7,44(sp)
800001d8:	02c12883          	lw	a7,44(sp)
    lw s0,48(sp)
800001dc:	03012403          	lw	s0,48(sp)
    lw s1,52(sp)
800001e0:	03412483          	lw	s1,52(sp)
    lw s2,56(sp)
800001e4:	03812903          	lw	s2,56(sp)
    lw s3,60(sp)
800001e8:	03c12983          	lw	s3,60(sp)
    lw s4,64(sp)
800001ec:	04012a03          	lw	s4,64(sp)
    lw s5,68(sp)
800001f0:	04412a83          	lw	s5,68(sp)
    lw s6,72(sp)
800001f4:	04812b03          	lw	s6,72(sp)
    lw s7,76(sp)
800001f8:	04c12b83          	lw	s7,76(sp)
    lw s8,80(sp)
800001fc:	05012c03          	lw	s8,80(sp)
    lw s9,84(sp)
80000200:	05412c83          	lw	s9,84(sp)
    lw s10,88(sp)
80000204:	05812d03          	lw	s10,88(sp)
    lw s11,92(sp)
80000208:	05c12d83          	lw	s11,92(sp)
    lw t0,96(sp)
8000020c:	06012283          	lw	t0,96(sp)
    lw t1,100(sp)
80000210:	06412303          	lw	t1,100(sp)
    lw t2,104(sp)
80000214:	06812383          	lw	t2,104(sp)
    lw t3,108(sp)
80000218:	06c12e03          	lw	t3,108(sp)
    lw t4,112(sp)
8000021c:	07012e83          	lw	t4,112(sp)
    lw t5,116(sp)
80000220:	07412f03          	lw	t5,116(sp)
    lw t6,120(sp)
80000224:	07812f83          	lw	t6,120(sp)

    addi sp,sp,128
80000228:	08010113          	addi	sp,sp,128
    
8000022c:	10200073          	sret

80000230 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80000230:	fe010113          	addi	sp,sp,-32
80000234:	00812e23          	sw	s0,28(sp)
80000238:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
8000023c:	300027f3          	csrr	a5,mstatus
80000240:	fef42623          	sw	a5,-20(s0)
    return x;
80000244:	fec42783          	lw	a5,-20(s0)
}
80000248:	00078513          	mv	a0,a5
8000024c:	01c12403          	lw	s0,28(sp)
80000250:	02010113          	addi	sp,sp,32
80000254:	00008067          	ret

80000258 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
80000258:	fe010113          	addi	sp,sp,-32
8000025c:	00812e23          	sw	s0,28(sp)
80000260:	02010413          	addi	s0,sp,32
80000264:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80000268:	fec42783          	lw	a5,-20(s0)
8000026c:	30079073          	csrw	mstatus,a5
}
80000270:	00000013          	nop
80000274:	01c12403          	lw	s0,28(sp)
80000278:	02010113          	addi	sp,sp,32
8000027c:	00008067          	ret

80000280 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000280:	fd010113          	addi	sp,sp,-48
80000284:	02112623          	sw	ra,44(sp)
80000288:	02812423          	sw	s0,40(sp)
8000028c:	03010413          	addi	s0,sp,48
80000290:	00050793          	mv	a5,a0
80000294:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
80000298:	f99ff0ef          	jal	ra,80000230 <r_mstatus>
8000029c:	fea42623          	sw	a0,-20(s0)
    switch (m)
800002a0:	fdf44783          	lbu	a5,-33(s0)
800002a4:	00300713          	li	a4,3
800002a8:	06e78063          	beq	a5,a4,80000308 <s_mstatus_xpp+0x88>
800002ac:	00300713          	li	a4,3
800002b0:	08f74263          	blt	a4,a5,80000334 <s_mstatus_xpp+0xb4>
800002b4:	00078863          	beqz	a5,800002c4 <s_mstatus_xpp+0x44>
800002b8:	00100713          	li	a4,1
800002bc:	02e78063          	beq	a5,a4,800002dc <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800002c0:	0740006f          	j	80000334 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800002c4:	fec42703          	lw	a4,-20(s0)
800002c8:	ffffe7b7          	lui	a5,0xffffe
800002cc:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800002d0:	00f777b3          	and	a5,a4,a5
800002d4:	fef42623          	sw	a5,-20(s0)
        break;
800002d8:	0600006f          	j	80000338 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800002dc:	fec42703          	lw	a4,-20(s0)
800002e0:	ffffe7b7          	lui	a5,0xffffe
800002e4:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800002e8:	00f777b3          	and	a5,a4,a5
800002ec:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
800002f0:	fec42703          	lw	a4,-20(s0)
800002f4:	000017b7          	lui	a5,0x1
800002f8:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
800002fc:	00f767b3          	or	a5,a4,a5
80000300:	fef42623          	sw	a5,-20(s0)
        break;
80000304:	0340006f          	j	80000338 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80000308:	fec42703          	lw	a4,-20(s0)
8000030c:	ffffe7b7          	lui	a5,0xffffe
80000310:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000314:	00f777b3          	and	a5,a4,a5
80000318:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
8000031c:	fec42703          	lw	a4,-20(s0)
80000320:	000027b7          	lui	a5,0x2
80000324:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
80000328:	00f767b3          	or	a5,a4,a5
8000032c:	fef42623          	sw	a5,-20(s0)
        break;
80000330:	0080006f          	j	80000338 <s_mstatus_xpp+0xb8>
        break;
80000334:	00000013          	nop
    }
    w_mstatus(x);
80000338:	fec42503          	lw	a0,-20(s0)
8000033c:	f1dff0ef          	jal	ra,80000258 <w_mstatus>
}
80000340:	00000013          	nop
80000344:	02c12083          	lw	ra,44(sp)
80000348:	02812403          	lw	s0,40(sp)
8000034c:	03010113          	addi	sp,sp,48
80000350:	00008067          	ret

80000354 <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
80000354:	fe010113          	addi	sp,sp,-32
80000358:	00812e23          	sw	s0,28(sp)
8000035c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000360:	100027f3          	csrr	a5,sstatus
80000364:	fef42623          	sw	a5,-20(s0)
    return x;
80000368:	fec42783          	lw	a5,-20(s0)
}
8000036c:	00078513          	mv	a0,a5
80000370:	01c12403          	lw	s0,28(sp)
80000374:	02010113          	addi	sp,sp,32
80000378:	00008067          	ret

8000037c <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
8000037c:	fe010113          	addi	sp,sp,-32
80000380:	00812e23          	sw	s0,28(sp)
80000384:	02010413          	addi	s0,sp,32
80000388:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
8000038c:	fec42783          	lw	a5,-20(s0)
80000390:	10079073          	csrw	sstatus,a5
}
80000394:	00000013          	nop
80000398:	01c12403          	lw	s0,28(sp)
8000039c:	02010113          	addi	sp,sp,32
800003a0:	00008067          	ret

800003a4 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
800003a4:	fe010113          	addi	sp,sp,-32
800003a8:	00812e23          	sw	s0,28(sp)
800003ac:	02010413          	addi	s0,sp,32
800003b0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
800003b4:	fec42783          	lw	a5,-20(s0)
800003b8:	34179073          	csrw	mepc,a5
}
800003bc:	00000013          	nop
800003c0:	01c12403          	lw	s0,28(sp)
800003c4:	02010113          	addi	sp,sp,32
800003c8:	00008067          	ret

800003cc <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
800003cc:	fe010113          	addi	sp,sp,-32
800003d0:	00812e23          	sw	s0,28(sp)
800003d4:	02010413          	addi	s0,sp,32
800003d8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
800003dc:	fec42783          	lw	a5,-20(s0)
800003e0:	10579073          	csrw	stvec,a5
}
800003e4:	00000013          	nop
800003e8:	01c12403          	lw	s0,28(sp)
800003ec:	02010113          	addi	sp,sp,32
800003f0:	00008067          	ret

800003f4 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
800003f4:	fe010113          	addi	sp,sp,-32
800003f8:	00812e23          	sw	s0,28(sp)
800003fc:	02010413          	addi	s0,sp,32
80000400:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
80000404:	fec42783          	lw	a5,-20(s0)
80000408:	30379073          	csrw	mideleg,a5
}
8000040c:	00000013          	nop
80000410:	01c12403          	lw	s0,28(sp)
80000414:	02010113          	addi	sp,sp,32
80000418:	00008067          	ret

8000041c <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
8000041c:	fe010113          	addi	sp,sp,-32
80000420:	00812e23          	sw	s0,28(sp)
80000424:	02010413          	addi	s0,sp,32
80000428:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
8000042c:	fec42783          	lw	a5,-20(s0)
80000430:	30279073          	csrw	medeleg,a5
}
80000434:	00000013          	nop
80000438:	01c12403          	lw	s0,28(sp)
8000043c:	02010113          	addi	sp,sp,32
80000440:	00008067          	ret

80000444 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
80000444:	fe010113          	addi	sp,sp,-32
80000448:	00812e23          	sw	s0,28(sp)
8000044c:	02010413          	addi	s0,sp,32
80000450:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80000454:	fec42783          	lw	a5,-20(s0)
80000458:	18079073          	csrw	satp,a5
}
8000045c:	00000013          	nop
80000460:	01c12403          	lw	s0,28(sp)
80000464:	02010113          	addi	sp,sp,32
80000468:	00008067          	ret

8000046c <s_mstatus_intr>:
        break;
    }
    return x;
}

static inline void s_mstatus_intr(uint32 m){
8000046c:	fd010113          	addi	sp,sp,-48
80000470:	02112623          	sw	ra,44(sp)
80000474:	02812423          	sw	s0,40(sp)
80000478:	03010413          	addi	s0,sp,48
8000047c:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80000480:	db1ff0ef          	jal	ra,80000230 <r_mstatus>
80000484:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000488:	fdc42703          	lw	a4,-36(s0)
8000048c:	08000793          	li	a5,128
80000490:	04f70263          	beq	a4,a5,800004d4 <s_mstatus_intr+0x68>
80000494:	fdc42703          	lw	a4,-36(s0)
80000498:	08000793          	li	a5,128
8000049c:	0ae7e463          	bltu	a5,a4,80000544 <s_mstatus_intr+0xd8>
800004a0:	fdc42703          	lw	a4,-36(s0)
800004a4:	02000793          	li	a5,32
800004a8:	04f70463          	beq	a4,a5,800004f0 <s_mstatus_intr+0x84>
800004ac:	fdc42703          	lw	a4,-36(s0)
800004b0:	02000793          	li	a5,32
800004b4:	08e7e863          	bltu	a5,a4,80000544 <s_mstatus_intr+0xd8>
800004b8:	fdc42703          	lw	a4,-36(s0)
800004bc:	00200793          	li	a5,2
800004c0:	06f70463          	beq	a4,a5,80000528 <s_mstatus_intr+0xbc>
800004c4:	fdc42703          	lw	a4,-36(s0)
800004c8:	00800793          	li	a5,8
800004cc:	04f70063          	beq	a4,a5,8000050c <s_mstatus_intr+0xa0>
    case INTR_SIE:
        x &= ~INTR_SIE;
        x |= INTR_SIE;
        break;
    default:
        break;
800004d0:	0740006f          	j	80000544 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
800004d4:	fec42783          	lw	a5,-20(s0)
800004d8:	f7f7f793          	andi	a5,a5,-129
800004dc:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
800004e0:	fec42783          	lw	a5,-20(s0)
800004e4:	0807e793          	ori	a5,a5,128
800004e8:	fef42623          	sw	a5,-20(s0)
        break;
800004ec:	05c0006f          	j	80000548 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800004f0:	fec42783          	lw	a5,-20(s0)
800004f4:	fdf7f793          	andi	a5,a5,-33
800004f8:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
800004fc:	fec42783          	lw	a5,-20(s0)
80000500:	0207e793          	ori	a5,a5,32
80000504:	fef42623          	sw	a5,-20(s0)
        break;
80000508:	0400006f          	j	80000548 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
8000050c:	fec42783          	lw	a5,-20(s0)
80000510:	ff77f793          	andi	a5,a5,-9
80000514:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80000518:	fec42783          	lw	a5,-20(s0)
8000051c:	0087e793          	ori	a5,a5,8
80000520:	fef42623          	sw	a5,-20(s0)
        break;
80000524:	0240006f          	j	80000548 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80000528:	fec42783          	lw	a5,-20(s0)
8000052c:	ffd7f793          	andi	a5,a5,-3
80000530:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80000534:	fec42783          	lw	a5,-20(s0)
80000538:	0027e793          	ori	a5,a5,2
8000053c:	fef42623          	sw	a5,-20(s0)
        break;
80000540:	0080006f          	j	80000548 <s_mstatus_intr+0xdc>
        break;
80000544:	00000013          	nop
    }
    w_mstatus(x);
80000548:	fec42503          	lw	a0,-20(s0)
8000054c:	d0dff0ef          	jal	ra,80000258 <w_mstatus>
}
80000550:	00000013          	nop
80000554:	02c12083          	lw	ra,44(sp)
80000558:	02812403          	lw	s0,40(sp)
8000055c:	03010113          	addi	sp,sp,48
80000560:	00008067          	ret

80000564 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
80000564:	fd010113          	addi	sp,sp,-48
80000568:	02112623          	sw	ra,44(sp)
8000056c:	02812423          	sw	s0,40(sp)
80000570:	03010413          	addi	s0,sp,48
80000574:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
80000578:	dddff0ef          	jal	ra,80000354 <r_sstatus>
8000057c:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000580:	fdc42703          	lw	a4,-36(s0)
80000584:	ffd00793          	li	a5,-3
80000588:	06f70863          	beq	a4,a5,800005f8 <s_sstatus_intr+0x94>
8000058c:	fdc42703          	lw	a4,-36(s0)
80000590:	ffd00793          	li	a5,-3
80000594:	06e7e863          	bltu	a5,a4,80000604 <s_sstatus_intr+0xa0>
80000598:	fdc42703          	lw	a4,-36(s0)
8000059c:	fdf00793          	li	a5,-33
800005a0:	02f70c63          	beq	a4,a5,800005d8 <s_sstatus_intr+0x74>
800005a4:	fdc42703          	lw	a4,-36(s0)
800005a8:	fdf00793          	li	a5,-33
800005ac:	04e7ec63          	bltu	a5,a4,80000604 <s_sstatus_intr+0xa0>
800005b0:	fdc42703          	lw	a4,-36(s0)
800005b4:	00200793          	li	a5,2
800005b8:	02f70863          	beq	a4,a5,800005e8 <s_sstatus_intr+0x84>
800005bc:	fdc42703          	lw	a4,-36(s0)
800005c0:	02000793          	li	a5,32
800005c4:	04f71063          	bne	a4,a5,80000604 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
800005c8:	fec42783          	lw	a5,-20(s0)
800005cc:	0207e793          	ori	a5,a5,32
800005d0:	fef42623          	sw	a5,-20(s0)
        break;
800005d4:	0340006f          	j	80000608 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
800005d8:	fec42783          	lw	a5,-20(s0)
800005dc:	fdf7f793          	andi	a5,a5,-33
800005e0:	fef42623          	sw	a5,-20(s0)
        break;
800005e4:	0240006f          	j	80000608 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
800005e8:	fec42783          	lw	a5,-20(s0)
800005ec:	0027e793          	ori	a5,a5,2
800005f0:	fef42623          	sw	a5,-20(s0)
        break;
800005f4:	0140006f          	j	80000608 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
800005f8:	fec42783          	lw	a5,-20(s0)
800005fc:	0027f793          	andi	a5,a5,2
80000600:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
80000604:	00000013          	nop
    }
    w_sstatus(x);
80000608:	fec42503          	lw	a0,-20(s0)
8000060c:	d71ff0ef          	jal	ra,8000037c <w_sstatus>
}
80000610:	00000013          	nop
80000614:	02c12083          	lw	ra,44(sp)
80000618:	02812403          	lw	s0,40(sp)
8000061c:	03010113          	addi	sp,sp,48
80000620:	00008067          	ret

80000624 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();

void start(){
80000624:	ff010113          	addi	sp,sp,-16
80000628:	00112623          	sw	ra,12(sp)
8000062c:	00812423          	sw	s0,8(sp)
80000630:	01010413          	addi	s0,sp,16
    uartinit();
80000634:	080000ef          	jal	ra,800006b4 <uartinit>
    uartputs("Hello Los!\n");
80000638:	800027b7          	lui	a5,0x80002
8000063c:	00078513          	mv	a0,a5
80000640:	168000ef          	jal	ra,800007a8 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
80000644:	00100513          	li	a0,1
80000648:	c39ff0ef          	jal	ra,80000280 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
8000064c:	00000513          	li	a0,0
80000650:	df5ff0ef          	jal	ra,80000444 <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
80000654:	000107b7          	lui	a5,0x10
80000658:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
8000065c:	d99ff0ef          	jal	ra,800003f4 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80000660:	000107b7          	lui	a5,0x10
80000664:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000668:	db5ff0ef          	jal	ra,8000041c <w_medeleg>

    s_mstatus_intr(INTR_MPIE);  // S-mode 开全局中断
8000066c:	08000513          	li	a0,128
80000670:	dfdff0ef          	jal	ra,8000046c <s_mstatus_intr>
    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
80000674:	00200513          	li	a0,2
80000678:	eedff0ef          	jal	ra,80000564 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
8000067c:	800007b7          	lui	a5,0x80000
80000680:	12878793          	addi	a5,a5,296 # 80000128 <memend+0xf8000128>
80000684:	00078513          	mv	a0,a5
80000688:	d45ff0ef          	jal	ra,800003cc <w_stvec>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
8000068c:	800017b7          	lui	a5,0x80001
80000690:	98878793          	addi	a5,a5,-1656 # 80000988 <memend+0xf8000988>
80000694:	00078513          	mv	a0,a5
80000698:	d0dff0ef          	jal	ra,800003a4 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
8000069c:	30200073          	mret
800006a0:	00000013          	nop
800006a4:	00c12083          	lw	ra,12(sp)
800006a8:	00812403          	lw	s0,8(sp)
800006ac:	01010113          	addi	sp,sp,16
800006b0:	00008067          	ret

800006b4 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
800006b4:	fe010113          	addi	sp,sp,-32
800006b8:	00812e23          	sw	s0,28(sp)
800006bc:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800006c0:	100007b7          	lui	a5,0x10000
800006c4:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800006c8:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800006cc:	100007b7          	lui	a5,0x10000
800006d0:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006d4:	0007c783          	lbu	a5,0(a5)
800006d8:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800006dc:	100007b7          	lui	a5,0x10000
800006e0:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006e4:	fef44703          	lbu	a4,-17(s0)
800006e8:	f8076713          	ori	a4,a4,-128
800006ec:	0ff77713          	andi	a4,a4,255
800006f0:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
800006f4:	100007b7          	lui	a5,0x10000
800006f8:	00300713          	li	a4,3
800006fc:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
80000700:	100007b7          	lui	a5,0x10000
80000704:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000708:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
8000070c:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80000710:	100007b7          	lui	a5,0x10000
80000714:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000718:	fef44703          	lbu	a4,-17(s0)
8000071c:	00376713          	ori	a4,a4,3
80000720:	0ff77713          	andi	a4,a4,255
80000724:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
80000728:	100007b7          	lui	a5,0x10000
8000072c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000730:	0007c783          	lbu	a5,0(a5)
80000734:	0ff7f713          	andi	a4,a5,255
80000738:	100007b7          	lui	a5,0x10000
8000073c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000740:	00176713          	ori	a4,a4,1
80000744:	0ff77713          	andi	a4,a4,255
80000748:	00e78023          	sb	a4,0(a5)
}
8000074c:	00000013          	nop
80000750:	01c12403          	lw	s0,28(sp)
80000754:	02010113          	addi	sp,sp,32
80000758:	00008067          	ret

8000075c <uartputc>:

// 轮询处理数据
char uartputc(char c){
8000075c:	fe010113          	addi	sp,sp,-32
80000760:	00812e23          	sw	s0,28(sp)
80000764:	02010413          	addi	s0,sp,32
80000768:	00050793          	mv	a5,a0
8000076c:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80000770:	00000013          	nop
80000774:	100007b7          	lui	a5,0x10000
80000778:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
8000077c:	0007c783          	lbu	a5,0(a5)
80000780:	0ff7f793          	andi	a5,a5,255
80000784:	0207f793          	andi	a5,a5,32
80000788:	fe0786e3          	beqz	a5,80000774 <uartputc+0x18>
    return uart_write(UART_THR,c);
8000078c:	10000737          	lui	a4,0x10000
80000790:	fef44783          	lbu	a5,-17(s0)
80000794:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
80000798:	00078513          	mv	a0,a5
8000079c:	01c12403          	lw	s0,28(sp)
800007a0:	02010113          	addi	sp,sp,32
800007a4:	00008067          	ret

800007a8 <uartputs>:

// 发送字符串
void uartputs(char* s){
800007a8:	fe010113          	addi	sp,sp,-32
800007ac:	00112e23          	sw	ra,28(sp)
800007b0:	00812c23          	sw	s0,24(sp)
800007b4:	02010413          	addi	s0,sp,32
800007b8:	fea42623          	sw	a0,-20(s0)
    while (*s)
800007bc:	01c0006f          	j	800007d8 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
800007c0:	fec42783          	lw	a5,-20(s0)
800007c4:	00178713          	addi	a4,a5,1
800007c8:	fee42623          	sw	a4,-20(s0)
800007cc:	0007c783          	lbu	a5,0(a5)
800007d0:	00078513          	mv	a0,a5
800007d4:	f89ff0ef          	jal	ra,8000075c <uartputc>
    while (*s)
800007d8:	fec42783          	lw	a5,-20(s0)
800007dc:	0007c783          	lbu	a5,0(a5)
800007e0:	fe0790e3          	bnez	a5,800007c0 <uartputs+0x18>
    }
    
}
800007e4:	00000013          	nop
800007e8:	00000013          	nop
800007ec:	01c12083          	lw	ra,28(sp)
800007f0:	01812403          	lw	s0,24(sp)
800007f4:	02010113          	addi	sp,sp,32
800007f8:	00008067          	ret

800007fc <uartgetc>:

// 接收输入
int uartgetc(){
800007fc:	ff010113          	addi	sp,sp,-16
80000800:	00812623          	sw	s0,12(sp)
80000804:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
80000808:	100007b7          	lui	a5,0x10000
8000080c:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000810:	0007c783          	lbu	a5,0(a5)
80000814:	0ff7f793          	andi	a5,a5,255
80000818:	0017f793          	andi	a5,a5,1
8000081c:	00078a63          	beqz	a5,80000830 <uartgetc+0x34>
        return uart_read(UART_RHR);
80000820:	100007b7          	lui	a5,0x10000
80000824:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
80000828:	0ff7f793          	andi	a5,a5,255
8000082c:	0080006f          	j	80000834 <uartgetc+0x38>
    }else{
        return -1;
80000830:	fff00793          	li	a5,-1
    }
}
80000834:	00078513          	mv	a0,a5
80000838:	00c12403          	lw	s0,12(sp)
8000083c:	01010113          	addi	sp,sp,16
80000840:	00008067          	ret

80000844 <uartintr>:

// 键盘输入中断
char uartintr(){
80000844:	ff010113          	addi	sp,sp,-16
80000848:	00112623          	sw	ra,12(sp)
8000084c:	00812423          	sw	s0,8(sp)
80000850:	01010413          	addi	s0,sp,16
    return uartgetc();
80000854:	fa9ff0ef          	jal	ra,800007fc <uartgetc>
80000858:	00050793          	mv	a5,a0
8000085c:	0ff7f793          	andi	a5,a5,255
80000860:	00078513          	mv	a0,a5
80000864:	00c12083          	lw	ra,12(sp)
80000868:	00812403          	lw	s0,8(sp)
8000086c:	01010113          	addi	sp,sp,16
80000870:	00008067          	ret

80000874 <swtch>:
 * @FilePath: /los/kernel/swtch.c
 */

#include "defs.h"

void swtch(struct context* old,struct context* new){
80000874:	fe010113          	addi	sp,sp,-32
80000878:	00812e23          	sw	s0,28(sp)
8000087c:	02010413          	addi	s0,sp,32
80000880:	fea42623          	sw	a0,-20(s0)
80000884:	feb42423          	sw	a1,-24(s0)
    // 将当前context 保存到 old context 中
    asm volatile("addi	sp,sp,32");
80000888:	02010113          	addi	sp,sp,32
    asm volatile("sw ra,0(a0)");
8000088c:	00152023          	sw	ra,0(a0)
    asm volatile("sw sp,4(a0)");
80000890:	00252223          	sw	sp,4(a0)
    asm volatile("sw gp,8(a0)");
80000894:	00352423          	sw	gp,8(a0)
    asm volatile("sw tp,12(a0)");
80000898:	00452623          	sw	tp,12(a0)
    asm volatile("sw a0,16(a0)");
8000089c:	00a52823          	sw	a0,16(a0)
    asm volatile("sw a1,20(a0)");
800008a0:	00b52a23          	sw	a1,20(a0)
    asm volatile("sw a2,24(a0)");
800008a4:	00c52c23          	sw	a2,24(a0)
    asm volatile("sw a3,28(a0)");
800008a8:	00d52e23          	sw	a3,28(a0)
    asm volatile("sw a4,32(a0)");
800008ac:	02e52023          	sw	a4,32(a0)
    asm volatile("sw a5,36(a0)");
800008b0:	02f52223          	sw	a5,36(a0)
    asm volatile("sw a6,40(a0)");
800008b4:	03052423          	sw	a6,40(a0)
    asm volatile("sw a7,44(a0)");
800008b8:	03152623          	sw	a7,44(a0)
    asm volatile("sw s0,48(a0)");
800008bc:	02852823          	sw	s0,48(a0)
    asm volatile("sw s1,52(a0)");
800008c0:	02952a23          	sw	s1,52(a0)
    asm volatile("sw s2,56(a0)");
800008c4:	03252c23          	sw	s2,56(a0)
    asm volatile("sw s3,60(a0)");
800008c8:	03352e23          	sw	s3,60(a0)
    asm volatile("sw s4,64(a0)");
800008cc:	05452023          	sw	s4,64(a0)
    asm volatile("sw s5,68(a0)");
800008d0:	05552223          	sw	s5,68(a0)
    asm volatile("sw s6,72(a0)");
800008d4:	05652423          	sw	s6,72(a0)
    asm volatile("sw s7,76(a0)");
800008d8:	05752623          	sw	s7,76(a0)
    asm volatile("sw s8,80(a0)");
800008dc:	05852823          	sw	s8,80(a0)
    asm volatile("sw s9,84(a0)");
800008e0:	05952a23          	sw	s9,84(a0)
    asm volatile("sw s10,88(a0)");
800008e4:	05a52c23          	sw	s10,88(a0)
    asm volatile("sw s11,92(a0)");
800008e8:	05b52e23          	sw	s11,92(a0)
    asm volatile("sw t0,96(a0)");
800008ec:	06552023          	sw	t0,96(a0)
    asm volatile("sw t1,100(a0)");
800008f0:	06652223          	sw	t1,100(a0)
    asm volatile("sw t2,104(a0)");
800008f4:	06752423          	sw	t2,104(a0)
    asm volatile("sw t3,108(a0)");
800008f8:	07c52623          	sw	t3,108(a0)
    asm volatile("sw t4,112(a0)");
800008fc:	07d52823          	sw	t4,112(a0)
    asm volatile("sw t5,116(a0)");
80000900:	07e52a23          	sw	t5,116(a0)
    asm volatile("sw t6,120(a0)");
80000904:	07f52c23          	sw	t6,120(a0)

    // 将 new context 加载到寄存器中
    // asm volatile("lw ra,0(a1)");
    // asm volatile("lw sp,4(a1)");
    asm volatile("lw gp,8(a1)");
80000908:	0085a183          	lw	gp,8(a1)
    asm volatile("lw tp,12(a1)");
8000090c:	00c5a203          	lw	tp,12(a1)
    asm volatile("lw a0,16(a1)");
80000910:	0105a503          	lw	a0,16(a1)
    // asm volatile("lw a1,20(a1)");
    asm volatile("lw a2,24(a1)");
80000914:	0185a603          	lw	a2,24(a1)
    asm volatile("lw a3,28(a1)");
80000918:	01c5a683          	lw	a3,28(a1)
    asm volatile("lw a4,32(a1)");
8000091c:	0205a703          	lw	a4,32(a1)
    asm volatile("lw a5,36(a1)");
80000920:	0245a783          	lw	a5,36(a1)
    asm volatile("lw a6,40(a1)");
80000924:	0285a803          	lw	a6,40(a1)
    asm volatile("lw a7,44(a1)");
80000928:	02c5a883          	lw	a7,44(a1)
    asm volatile("lw s0,48(a1)");
8000092c:	0305a403          	lw	s0,48(a1)
    asm volatile("lw s1,52(a1)");
80000930:	0345a483          	lw	s1,52(a1)
    asm volatile("lw s2,56(a1)");
80000934:	0385a903          	lw	s2,56(a1)
    asm volatile("lw s3,60(a1)");
80000938:	03c5a983          	lw	s3,60(a1)
    asm volatile("lw s4,64(a1)");
8000093c:	0405aa03          	lw	s4,64(a1)
    asm volatile("lw s5,68(a1)");
80000940:	0445aa83          	lw	s5,68(a1)
    asm volatile("lw s6,72(a1)");
80000944:	0485ab03          	lw	s6,72(a1)
    asm volatile("lw s7,76(a1)");
80000948:	04c5ab83          	lw	s7,76(a1)
    asm volatile("lw s8,80(a1)");
8000094c:	0505ac03          	lw	s8,80(a1)
    asm volatile("lw s9,84(a1)");
80000950:	0545ac83          	lw	s9,84(a1)
    asm volatile("lw s10,88(a1)");
80000954:	0585ad03          	lw	s10,88(a1)
    asm volatile("lw s11,92(a1)");
80000958:	05c5ad83          	lw	s11,92(a1)
    asm volatile("lw t0,96(a1)");
8000095c:	0605a283          	lw	t0,96(a1)
    asm volatile("lw t1,100(a1)");
80000960:	0645a303          	lw	t1,100(a1)
    asm volatile("lw t2,104(a1)");
80000964:	0685a383          	lw	t2,104(a1)
    asm volatile("lw t3,108(a1)");
80000968:	06c5ae03          	lw	t3,108(a1)
    asm volatile("lw t4,112(a1)");
8000096c:	0705ae83          	lw	t4,112(a1)
    asm volatile("lw t5,116(a1)");
80000970:	0745af03          	lw	t5,116(a1)
    asm volatile("lw t6,120(a1)");
80000974:	0785af83          	lw	t6,120(a1)
    
80000978:	00000013          	nop
8000097c:	01c12403          	lw	s0,28(sp)
80000980:	02010113          	addi	sp,sp,32
80000984:	00008067          	ret

80000988 <main>:
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"

void main(){
80000988:	ff010113          	addi	sp,sp,-16
8000098c:	00112623          	sw	ra,12(sp)
80000990:	00812423          	sw	s0,8(sp)
80000994:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
80000998:	800027b7          	lui	a5,0x80002
8000099c:	00c78513          	addi	a0,a5,12 # 8000200c <memend+0xf800200c>
800009a0:	2c4000ef          	jal	ra,80000c64 <printf>

    minit();        // 物理内存管理
800009a4:	738000ef          	jal	ra,800010dc <minit>
    plicinit();     // PLIC 中断处理
800009a8:	1b9000ef          	jal	ra,80001360 <plicinit>
    vminit();       // 启动虚拟内存
800009ac:	5e5000ef          	jal	ra,80001790 <vminit>
    
    printf("-----------\n");
800009b0:	800027b7          	lui	a5,0x80002
800009b4:	02078513          	addi	a0,a5,32 # 80002020 <memend+0xf8002020>
800009b8:	2ac000ef          	jal	ra,80000c64 <printf>
    while(1);
800009bc:	0000006f          	j	800009bc <main+0x34>

800009c0 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
800009c0:	fe010113          	addi	sp,sp,-32
800009c4:	00812e23          	sw	s0,28(sp)
800009c8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
800009cc:	142027f3          	csrr	a5,scause
800009d0:	fef42623          	sw	a5,-20(s0)
    return x;
800009d4:	fec42783          	lw	a5,-20(s0)
}
800009d8:	00078513          	mv	a0,a5
800009dc:	01c12403          	lw	s0,28(sp)
800009e0:	02010113          	addi	sp,sp,32
800009e4:	00008067          	ret

800009e8 <externinterrupt>:
#include "plic.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
800009e8:	fe010113          	addi	sp,sp,-32
800009ec:	00112e23          	sw	ra,28(sp)
800009f0:	00812c23          	sw	s0,24(sp)
800009f4:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
800009f8:	22d000ef          	jal	ra,80001424 <r_plicclaim>
800009fc:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000a00:	fec42583          	lw	a1,-20(s0)
80000a04:	800027b7          	lui	a5,0x80002
80000a08:	03078513          	addi	a0,a5,48 # 80002030 <memend+0xf8002030>
80000a0c:	258000ef          	jal	ra,80000c64 <printf>
    switch (irq)
80000a10:	fec42703          	lw	a4,-20(s0)
80000a14:	00a00793          	li	a5,10
80000a18:	02f71063          	bne	a4,a5,80000a38 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80000a1c:	e29ff0ef          	jal	ra,80000844 <uartintr>
80000a20:	00050793          	mv	a5,a0
80000a24:	00078593          	mv	a1,a5
80000a28:	800027b7          	lui	a5,0x80002
80000a2c:	03c78513          	addi	a0,a5,60 # 8000203c <memend+0xf800203c>
80000a30:	234000ef          	jal	ra,80000c64 <printf>
        break;
80000a34:	0080006f          	j	80000a3c <externinterrupt+0x54>
    default:
        break;
80000a38:	00000013          	nop
    }
    w_pliccomplete(irq);
80000a3c:	fec42503          	lw	a0,-20(s0)
80000a40:	225000ef          	jal	ra,80001464 <w_pliccomplete>
}
80000a44:	00000013          	nop
80000a48:	01c12083          	lw	ra,28(sp)
80000a4c:	01812403          	lw	s0,24(sp)
80000a50:	02010113          	addi	sp,sp,32
80000a54:	00008067          	ret

80000a58 <trapvec>:

void trapvec(){
80000a58:	fe010113          	addi	sp,sp,-32
80000a5c:	00112e23          	sw	ra,28(sp)
80000a60:	00812c23          	sw	s0,24(sp)
80000a64:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000a68:	f59ff0ef          	jal	ra,800009c0 <r_scause>
80000a6c:	fea42623          	sw	a0,-20(s0)

    uint16 code= scause & 0xffff;
80000a70:	fec42783          	lw	a5,-20(s0)
80000a74:	fef41523          	sh	a5,-22(s0)

    if(scause & (1<<31)){
80000a78:	fec42783          	lw	a5,-20(s0)
80000a7c:	0607de63          	bgez	a5,80000af8 <trapvec+0xa0>
        printf("Interrupt : ");
80000a80:	800027b7          	lui	a5,0x80002
80000a84:	04c78513          	addi	a0,a5,76 # 8000204c <memend+0xf800204c>
80000a88:	1dc000ef          	jal	ra,80000c64 <printf>
        switch (code)
80000a8c:	fea45783          	lhu	a5,-22(s0)
80000a90:	00900713          	li	a4,9
80000a94:	04e78063          	beq	a5,a4,80000ad4 <trapvec+0x7c>
80000a98:	00900713          	li	a4,9
80000a9c:	04f74663          	blt	a4,a5,80000ae8 <trapvec+0x90>
80000aa0:	00100713          	li	a4,1
80000aa4:	00e78863          	beq	a5,a4,80000ab4 <trapvec+0x5c>
80000aa8:	00500713          	li	a4,5
80000aac:	00e78c63          	beq	a5,a4,80000ac4 <trapvec+0x6c>
80000ab0:	0380006f          	j	80000ae8 <trapvec+0x90>
        {
        case 1:
            printf("Supervisor software interrupt\n");
80000ab4:	800027b7          	lui	a5,0x80002
80000ab8:	05c78513          	addi	a0,a5,92 # 8000205c <memend+0xf800205c>
80000abc:	1a8000ef          	jal	ra,80000c64 <printf>
            break;
80000ac0:	1580006f          	j	80000c18 <trapvec+0x1c0>
        case 5:
            printf("Supervisor timer interrupt\n");
80000ac4:	800027b7          	lui	a5,0x80002
80000ac8:	07c78513          	addi	a0,a5,124 # 8000207c <memend+0xf800207c>
80000acc:	198000ef          	jal	ra,80000c64 <printf>
            break;
80000ad0:	1480006f          	j	80000c18 <trapvec+0x1c0>
        case 9:
            printf("Supervisor external interrupt\n");
80000ad4:	800027b7          	lui	a5,0x80002
80000ad8:	09878513          	addi	a0,a5,152 # 80002098 <memend+0xf8002098>
80000adc:	188000ef          	jal	ra,80000c64 <printf>
            externinterrupt();
80000ae0:	f09ff0ef          	jal	ra,800009e8 <externinterrupt>
            break;
80000ae4:	1340006f          	j	80000c18 <trapvec+0x1c0>
        default:
            printf("Other interrupt\n");
80000ae8:	800027b7          	lui	a5,0x80002
80000aec:	0b878513          	addi	a0,a5,184 # 800020b8 <memend+0xf80020b8>
80000af0:	174000ef          	jal	ra,80000c64 <printf>
            break;
80000af4:	1240006f          	j	80000c18 <trapvec+0x1c0>
        }
    }else{
        printf("Exception : ");
80000af8:	800027b7          	lui	a5,0x80002
80000afc:	0cc78513          	addi	a0,a5,204 # 800020cc <memend+0xf80020cc>
80000b00:	164000ef          	jal	ra,80000c64 <printf>
        switch (code)
80000b04:	fea45783          	lhu	a5,-22(s0)
80000b08:	00f00713          	li	a4,15
80000b0c:	0ef76663          	bltu	a4,a5,80000bf8 <trapvec+0x1a0>
80000b10:	00279713          	slli	a4,a5,0x2
80000b14:	800027b7          	lui	a5,0x80002
80000b18:	24078793          	addi	a5,a5,576 # 80002240 <memend+0xf8002240>
80000b1c:	00f707b3          	add	a5,a4,a5
80000b20:	0007a783          	lw	a5,0(a5)
80000b24:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000b28:	800027b7          	lui	a5,0x80002
80000b2c:	0dc78513          	addi	a0,a5,220 # 800020dc <memend+0xf80020dc>
80000b30:	134000ef          	jal	ra,80000c64 <printf>
            break;
80000b34:	0d40006f          	j	80000c08 <trapvec+0x1b0>
        case 1:
            printf("Instruction access fault\n");
80000b38:	800027b7          	lui	a5,0x80002
80000b3c:	0fc78513          	addi	a0,a5,252 # 800020fc <memend+0xf80020fc>
80000b40:	124000ef          	jal	ra,80000c64 <printf>
            break;
80000b44:	0c40006f          	j	80000c08 <trapvec+0x1b0>
        case 2:
            printf("Illegal instruction\n");
80000b48:	800027b7          	lui	a5,0x80002
80000b4c:	11878513          	addi	a0,a5,280 # 80002118 <memend+0xf8002118>
80000b50:	114000ef          	jal	ra,80000c64 <printf>
            break;
80000b54:	0b40006f          	j	80000c08 <trapvec+0x1b0>
        case 3:
            printf("Breakpoint\n");
80000b58:	800027b7          	lui	a5,0x80002
80000b5c:	13078513          	addi	a0,a5,304 # 80002130 <memend+0xf8002130>
80000b60:	104000ef          	jal	ra,80000c64 <printf>
            break;
80000b64:	0a40006f          	j	80000c08 <trapvec+0x1b0>
        case 4:
            printf("Load address misaligned\n");
80000b68:	800027b7          	lui	a5,0x80002
80000b6c:	13c78513          	addi	a0,a5,316 # 8000213c <memend+0xf800213c>
80000b70:	0f4000ef          	jal	ra,80000c64 <printf>
            break;
80000b74:	0940006f          	j	80000c08 <trapvec+0x1b0>
        case 5:
            printf("Load access fault\n");
80000b78:	800027b7          	lui	a5,0x80002
80000b7c:	15878513          	addi	a0,a5,344 # 80002158 <memend+0xf8002158>
80000b80:	0e4000ef          	jal	ra,80000c64 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000b84:	0840006f          	j	80000c08 <trapvec+0x1b0>
        case 6:
            printf("Store/AMO address misaligned\n");
80000b88:	800027b7          	lui	a5,0x80002
80000b8c:	16c78513          	addi	a0,a5,364 # 8000216c <memend+0xf800216c>
80000b90:	0d4000ef          	jal	ra,80000c64 <printf>
            break;
80000b94:	0740006f          	j	80000c08 <trapvec+0x1b0>
        case 7:
            printf("Store/AMO access fault\n");
80000b98:	800027b7          	lui	a5,0x80002
80000b9c:	18c78513          	addi	a0,a5,396 # 8000218c <memend+0xf800218c>
80000ba0:	0c4000ef          	jal	ra,80000c64 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000ba4:	0640006f          	j	80000c08 <trapvec+0x1b0>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000ba8:	800027b7          	lui	a5,0x80002
80000bac:	1a478513          	addi	a0,a5,420 # 800021a4 <memend+0xf80021a4>
80000bb0:	0b4000ef          	jal	ra,80000c64 <printf>
            break;
80000bb4:	0540006f          	j	80000c08 <trapvec+0x1b0>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000bb8:	800027b7          	lui	a5,0x80002
80000bbc:	1c478513          	addi	a0,a5,452 # 800021c4 <memend+0xf80021c4>
80000bc0:	0a4000ef          	jal	ra,80000c64 <printf>
            break;
80000bc4:	0440006f          	j	80000c08 <trapvec+0x1b0>
        case 12:
            printf("Instruction page fault\n");
80000bc8:	800027b7          	lui	a5,0x80002
80000bcc:	1e478513          	addi	a0,a5,484 # 800021e4 <memend+0xf80021e4>
80000bd0:	094000ef          	jal	ra,80000c64 <printf>
            break;
80000bd4:	0340006f          	j	80000c08 <trapvec+0x1b0>
        case 13:
            printf("Load page fault\n");
80000bd8:	800027b7          	lui	a5,0x80002
80000bdc:	1fc78513          	addi	a0,a5,508 # 800021fc <memend+0xf80021fc>
80000be0:	084000ef          	jal	ra,80000c64 <printf>
            break;
80000be4:	0240006f          	j	80000c08 <trapvec+0x1b0>
        case 15:
            printf("Store/AMO page fault\n");
80000be8:	800027b7          	lui	a5,0x80002
80000bec:	21078513          	addi	a0,a5,528 # 80002210 <memend+0xf8002210>
80000bf0:	074000ef          	jal	ra,80000c64 <printf>
            break;
80000bf4:	0140006f          	j	80000c08 <trapvec+0x1b0>
        default:
            printf("Other\n");
80000bf8:	800027b7          	lui	a5,0x80002
80000bfc:	22878513          	addi	a0,a5,552 # 80002228 <memend+0xf8002228>
80000c00:	064000ef          	jal	ra,80000c64 <printf>
            break;
80000c04:	00000013          	nop
        }
        panic("Trap Exception");
80000c08:	800027b7          	lui	a5,0x80002
80000c0c:	23078513          	addi	a0,a5,560 # 80002230 <memend+0xf8002230>
80000c10:	01c000ef          	jal	ra,80000c2c <panic>
    }
}
80000c14:	00000013          	nop
80000c18:	00000013          	nop
80000c1c:	01c12083          	lw	ra,28(sp)
80000c20:	01812403          	lw	s0,24(sp)
80000c24:	02010113          	addi	sp,sp,32
80000c28:	00008067          	ret

80000c2c <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000c2c:	fe010113          	addi	sp,sp,-32
80000c30:	00112e23          	sw	ra,28(sp)
80000c34:	00812c23          	sw	s0,24(sp)
80000c38:	02010413          	addi	s0,sp,32
80000c3c:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000c40:	800027b7          	lui	a5,0x80002
80000c44:	28078513          	addi	a0,a5,640 # 80002280 <memend+0xf8002280>
80000c48:	b61ff0ef          	jal	ra,800007a8 <uartputs>
    uartputs(s);
80000c4c:	fec42503          	lw	a0,-20(s0)
80000c50:	b59ff0ef          	jal	ra,800007a8 <uartputs>
	uartputs("\n");
80000c54:	800027b7          	lui	a5,0x80002
80000c58:	28878513          	addi	a0,a5,648 # 80002288 <memend+0xf8002288>
80000c5c:	b4dff0ef          	jal	ra,800007a8 <uartputs>
    while(1);
80000c60:	0000006f          	j	80000c60 <panic+0x34>

80000c64 <printf>:
}

static char outbuf[1024];
// # 简易版 printf
// ! 未处理异常
int printf(const char* fmt,...){
80000c64:	f8010113          	addi	sp,sp,-128
80000c68:	04112e23          	sw	ra,92(sp)
80000c6c:	04812c23          	sw	s0,88(sp)
80000c70:	06010413          	addi	s0,sp,96
80000c74:	faa42623          	sw	a0,-84(s0)
80000c78:	00b42223          	sw	a1,4(s0)
80000c7c:	00c42423          	sw	a2,8(s0)
80000c80:	00d42623          	sw	a3,12(s0)
80000c84:	00e42823          	sw	a4,16(s0)
80000c88:	00f42a23          	sw	a5,20(s0)
80000c8c:	01042c23          	sw	a6,24(s0)
80000c90:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000c94:	02040793          	addi	a5,s0,32
80000c98:	faf42423          	sw	a5,-88(s0)
80000c9c:	fa842783          	lw	a5,-88(s0)
80000ca0:	fe478793          	addi	a5,a5,-28
80000ca4:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000ca8:	fac42783          	lw	a5,-84(s0)
80000cac:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000cb0:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000cb4:	fe042223          	sw	zero,-28(s0)
	while(ch=*(s)){
80000cb8:	36c0006f          	j	80001024 <printf+0x3c0>
		if(ch=='%'){
80000cbc:	fbf44703          	lbu	a4,-65(s0)
80000cc0:	02500793          	li	a5,37
80000cc4:	04f71863          	bne	a4,a5,80000d14 <printf+0xb0>
			if(tt==1){
80000cc8:	fe842703          	lw	a4,-24(s0)
80000ccc:	00100793          	li	a5,1
80000cd0:	02f71663          	bne	a4,a5,80000cfc <printf+0x98>
				outbuf[idx++]='%';
80000cd4:	fe442783          	lw	a5,-28(s0)
80000cd8:	00178713          	addi	a4,a5,1
80000cdc:	fee42223          	sw	a4,-28(s0)
80000ce0:	8000b737          	lui	a4,0x8000b
80000ce4:	00070713          	mv	a4,a4
80000ce8:	00f707b3          	add	a5,a4,a5
80000cec:	02500713          	li	a4,37
80000cf0:	00e78023          	sb	a4,0(a5)
				tt=0;
80000cf4:	fe042423          	sw	zero,-24(s0)
80000cf8:	00c0006f          	j	80000d04 <printf+0xa0>
			}else{
				tt=1;
80000cfc:	00100793          	li	a5,1
80000d00:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000d04:	fec42783          	lw	a5,-20(s0)
80000d08:	00178793          	addi	a5,a5,1
80000d0c:	fef42623          	sw	a5,-20(s0)
80000d10:	3140006f          	j	80001024 <printf+0x3c0>
		}else{
			if(tt==1){
80000d14:	fe842703          	lw	a4,-24(s0)
80000d18:	00100793          	li	a5,1
80000d1c:	2cf71e63          	bne	a4,a5,80000ff8 <printf+0x394>
				switch (ch)
80000d20:	fbf44783          	lbu	a5,-65(s0)
80000d24:	fa878793          	addi	a5,a5,-88
80000d28:	02000713          	li	a4,32
80000d2c:	2af76663          	bltu	a4,a5,80000fd8 <printf+0x374>
80000d30:	00279713          	slli	a4,a5,0x2
80000d34:	800027b7          	lui	a5,0x80002
80000d38:	2a478793          	addi	a5,a5,676 # 800022a4 <memend+0xf80022a4>
80000d3c:	00f707b3          	add	a5,a4,a5
80000d40:	0007a783          	lw	a5,0(a5)
80000d44:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000d48:	fb842783          	lw	a5,-72(s0)
80000d4c:	00478713          	addi	a4,a5,4
80000d50:	fae42c23          	sw	a4,-72(s0)
80000d54:	0007a783          	lw	a5,0(a5)
80000d58:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000d5c:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000d60:	fe042783          	lw	a5,-32(s0)
80000d64:	fcf42c23          	sw	a5,-40(s0)
80000d68:	0100006f          	j	80000d78 <printf+0x114>
80000d6c:	fdc42783          	lw	a5,-36(s0)
80000d70:	00178793          	addi	a5,a5,1
80000d74:	fcf42e23          	sw	a5,-36(s0)
80000d78:	fd842703          	lw	a4,-40(s0)
80000d7c:	00a00793          	li	a5,10
80000d80:	02f747b3          	div	a5,a4,a5
80000d84:	fcf42c23          	sw	a5,-40(s0)
80000d88:	fd842783          	lw	a5,-40(s0)
80000d8c:	fe0790e3          	bnez	a5,80000d6c <printf+0x108>
					for(int i=len;i>=0;i--){
80000d90:	fdc42783          	lw	a5,-36(s0)
80000d94:	fcf42a23          	sw	a5,-44(s0)
80000d98:	0540006f          	j	80000dec <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000d9c:	fe042703          	lw	a4,-32(s0)
80000da0:	00a00793          	li	a5,10
80000da4:	02f767b3          	rem	a5,a4,a5
80000da8:	0ff7f713          	andi	a4,a5,255
80000dac:	fe442683          	lw	a3,-28(s0)
80000db0:	fd442783          	lw	a5,-44(s0)
80000db4:	00f687b3          	add	a5,a3,a5
80000db8:	03070713          	addi	a4,a4,48 # 8000b030 <memend+0xf800b030>
80000dbc:	0ff77713          	andi	a4,a4,255
80000dc0:	8000b6b7          	lui	a3,0x8000b
80000dc4:	00068693          	mv	a3,a3
80000dc8:	00f687b3          	add	a5,a3,a5
80000dcc:	00e78023          	sb	a4,0(a5)
						x/=10;
80000dd0:	fe042703          	lw	a4,-32(s0)
80000dd4:	00a00793          	li	a5,10
80000dd8:	02f747b3          	div	a5,a4,a5
80000ddc:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000de0:	fd442783          	lw	a5,-44(s0)
80000de4:	fff78793          	addi	a5,a5,-1
80000de8:	fcf42a23          	sw	a5,-44(s0)
80000dec:	fd442783          	lw	a5,-44(s0)
80000df0:	fa07d6e3          	bgez	a5,80000d9c <printf+0x138>
					}
					idx+=(len+1);
80000df4:	fdc42783          	lw	a5,-36(s0)
80000df8:	00178793          	addi	a5,a5,1
80000dfc:	fe442703          	lw	a4,-28(s0)
80000e00:	00f707b3          	add	a5,a4,a5
80000e04:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000e08:	fe042423          	sw	zero,-24(s0)
					break;
80000e0c:	1dc0006f          	j	80000fe8 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000e10:	fe442783          	lw	a5,-28(s0)
80000e14:	00178713          	addi	a4,a5,1
80000e18:	fee42223          	sw	a4,-28(s0)
80000e1c:	8000b737          	lui	a4,0x8000b
80000e20:	00070713          	mv	a4,a4
80000e24:	00f707b3          	add	a5,a4,a5
80000e28:	03000713          	li	a4,48
80000e2c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000e30:	fe442783          	lw	a5,-28(s0)
80000e34:	00178713          	addi	a4,a5,1
80000e38:	fee42223          	sw	a4,-28(s0)
80000e3c:	8000b737          	lui	a4,0x8000b
80000e40:	00070713          	mv	a4,a4
80000e44:	00f707b3          	add	a5,a4,a5
80000e48:	07800713          	li	a4,120
80000e4c:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80000e50:	fb842783          	lw	a5,-72(s0)
80000e54:	00478713          	addi	a4,a5,4
80000e58:	fae42c23          	sw	a4,-72(s0)
80000e5c:	0007a783          	lw	a5,0(a5)
80000e60:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80000e64:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80000e68:	fd042783          	lw	a5,-48(s0)
80000e6c:	fcf42423          	sw	a5,-56(s0)
80000e70:	0100006f          	j	80000e80 <printf+0x21c>
80000e74:	fcc42783          	lw	a5,-52(s0)
80000e78:	00178793          	addi	a5,a5,1
80000e7c:	fcf42623          	sw	a5,-52(s0)
80000e80:	fc842783          	lw	a5,-56(s0)
80000e84:	0047d793          	srli	a5,a5,0x4
80000e88:	fcf42423          	sw	a5,-56(s0)
80000e8c:	fc842783          	lw	a5,-56(s0)
80000e90:	fe0792e3          	bnez	a5,80000e74 <printf+0x210>
					for(int i=len;i>=0;i--){
80000e94:	fcc42783          	lw	a5,-52(s0)
80000e98:	fcf42223          	sw	a5,-60(s0)
80000e9c:	0840006f          	j	80000f20 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80000ea0:	fd042783          	lw	a5,-48(s0)
80000ea4:	00f7f713          	andi	a4,a5,15
80000ea8:	00900793          	li	a5,9
80000eac:	02e7f063          	bgeu	a5,a4,80000ecc <printf+0x268>
80000eb0:	fd042783          	lw	a5,-48(s0)
80000eb4:	0ff7f793          	andi	a5,a5,255
80000eb8:	00f7f793          	andi	a5,a5,15
80000ebc:	0ff7f793          	andi	a5,a5,255
80000ec0:	05778793          	addi	a5,a5,87
80000ec4:	0ff7f793          	andi	a5,a5,255
80000ec8:	01c0006f          	j	80000ee4 <printf+0x280>
80000ecc:	fd042783          	lw	a5,-48(s0)
80000ed0:	0ff7f793          	andi	a5,a5,255
80000ed4:	00f7f793          	andi	a5,a5,15
80000ed8:	0ff7f793          	andi	a5,a5,255
80000edc:	03078793          	addi	a5,a5,48
80000ee0:	0ff7f793          	andi	a5,a5,255
80000ee4:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80000ee8:	fe442703          	lw	a4,-28(s0)
80000eec:	fc442783          	lw	a5,-60(s0)
80000ef0:	00f707b3          	add	a5,a4,a5
80000ef4:	8000b737          	lui	a4,0x8000b
80000ef8:	00070713          	mv	a4,a4
80000efc:	00f707b3          	add	a5,a4,a5
80000f00:	fbe44703          	lbu	a4,-66(s0)
80000f04:	00e78023          	sb	a4,0(a5)
						x/=16;
80000f08:	fd042783          	lw	a5,-48(s0)
80000f0c:	0047d793          	srli	a5,a5,0x4
80000f10:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80000f14:	fc442783          	lw	a5,-60(s0)
80000f18:	fff78793          	addi	a5,a5,-1
80000f1c:	fcf42223          	sw	a5,-60(s0)
80000f20:	fc442783          	lw	a5,-60(s0)
80000f24:	f607dee3          	bgez	a5,80000ea0 <printf+0x23c>
					}
					idx+=(len+1);
80000f28:	fcc42783          	lw	a5,-52(s0)
80000f2c:	00178793          	addi	a5,a5,1
80000f30:	fe442703          	lw	a4,-28(s0)
80000f34:	00f707b3          	add	a5,a4,a5
80000f38:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000f3c:	fe042423          	sw	zero,-24(s0)
					break;
80000f40:	0a80006f          	j	80000fe8 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80000f44:	fb842783          	lw	a5,-72(s0)
80000f48:	00478713          	addi	a4,a5,4
80000f4c:	fae42c23          	sw	a4,-72(s0)
80000f50:	0007a783          	lw	a5,0(a5)
80000f54:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80000f58:	fe442783          	lw	a5,-28(s0)
80000f5c:	00178713          	addi	a4,a5,1
80000f60:	fee42223          	sw	a4,-28(s0)
80000f64:	8000b737          	lui	a4,0x8000b
80000f68:	00070713          	mv	a4,a4
80000f6c:	00f707b3          	add	a5,a4,a5
80000f70:	fbf44703          	lbu	a4,-65(s0)
80000f74:	00e78023          	sb	a4,0(a5)
					tt=0;
80000f78:	fe042423          	sw	zero,-24(s0)
					break;
80000f7c:	06c0006f          	j	80000fe8 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80000f80:	fb842783          	lw	a5,-72(s0)
80000f84:	00478713          	addi	a4,a5,4
80000f88:	fae42c23          	sw	a4,-72(s0)
80000f8c:	0007a783          	lw	a5,0(a5)
80000f90:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80000f94:	0300006f          	j	80000fc4 <printf+0x360>
						outbuf[idx++]=*ss++;
80000f98:	fc042703          	lw	a4,-64(s0)
80000f9c:	00170793          	addi	a5,a4,1 # 8000b001 <memend+0xf800b001>
80000fa0:	fcf42023          	sw	a5,-64(s0)
80000fa4:	fe442783          	lw	a5,-28(s0)
80000fa8:	00178693          	addi	a3,a5,1
80000fac:	fed42223          	sw	a3,-28(s0)
80000fb0:	00074703          	lbu	a4,0(a4)
80000fb4:	8000b6b7          	lui	a3,0x8000b
80000fb8:	00068693          	mv	a3,a3
80000fbc:	00f687b3          	add	a5,a3,a5
80000fc0:	00e78023          	sb	a4,0(a5)
					while(*ss){
80000fc4:	fc042783          	lw	a5,-64(s0)
80000fc8:	0007c783          	lbu	a5,0(a5)
80000fcc:	fc0796e3          	bnez	a5,80000f98 <printf+0x334>
					}
					tt=0;
80000fd0:	fe042423          	sw	zero,-24(s0)
					break;
80000fd4:	0140006f          	j	80000fe8 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80000fd8:	800027b7          	lui	a5,0x80002
80000fdc:	28c78513          	addi	a0,a5,652 # 8000228c <memend+0xf800228c>
80000fe0:	c4dff0ef          	jal	ra,80000c2c <panic>
					break;
80000fe4:	00000013          	nop
				}
				s++;
80000fe8:	fec42783          	lw	a5,-20(s0)
80000fec:	00178793          	addi	a5,a5,1
80000ff0:	fef42623          	sw	a5,-20(s0)
80000ff4:	0300006f          	j	80001024 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80000ff8:	fe442783          	lw	a5,-28(s0)
80000ffc:	00178713          	addi	a4,a5,1
80001000:	fee42223          	sw	a4,-28(s0)
80001004:	8000b737          	lui	a4,0x8000b
80001008:	00070713          	mv	a4,a4
8000100c:	00f707b3          	add	a5,a4,a5
80001010:	fbf44703          	lbu	a4,-65(s0)
80001014:	00e78023          	sb	a4,0(a5)
				s++;
80001018:	fec42783          	lw	a5,-20(s0)
8000101c:	00178793          	addi	a5,a5,1
80001020:	fef42623          	sw	a5,-20(s0)
	while(ch=*(s)){
80001024:	fec42783          	lw	a5,-20(s0)
80001028:	0007c783          	lbu	a5,0(a5)
8000102c:	faf40fa3          	sb	a5,-65(s0)
80001030:	fbf44783          	lbu	a5,-65(s0)
80001034:	c80794e3          	bnez	a5,80000cbc <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80001038:	8000b7b7          	lui	a5,0x8000b
8000103c:	00078713          	mv	a4,a5
80001040:	fe442783          	lw	a5,-28(s0)
80001044:	00f707b3          	add	a5,a4,a5
80001048:	00078023          	sb	zero,0(a5) # 8000b000 <memend+0xf800b000>
	uartputs(outbuf);
8000104c:	8000b7b7          	lui	a5,0x8000b
80001050:	00078513          	mv	a0,a5
80001054:	f54ff0ef          	jal	ra,800007a8 <uartputs>
80001058:	00000013          	nop
8000105c:	00078513          	mv	a0,a5
80001060:	05c12083          	lw	ra,92(sp)
80001064:	05812403          	lw	s0,88(sp)
80001068:	08010113          	addi	sp,sp,128
8000106c:	00008067          	ret

80001070 <memset>:
struct
{
    struct pmp* freelist;
}mem;

void* memset(void* addr,int c,uint n){
80001070:	fd010113          	addi	sp,sp,-48
80001074:	02812623          	sw	s0,44(sp)
80001078:	03010413          	addi	s0,sp,48
8000107c:	fca42e23          	sw	a0,-36(s0)
80001080:	fcb42c23          	sw	a1,-40(s0)
80001084:	fcc42a23          	sw	a2,-44(s0)
    char* maddr=(char*)addr;
80001088:	fdc42783          	lw	a5,-36(s0)
8000108c:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001090:	fe042623          	sw	zero,-20(s0)
80001094:	0280006f          	j	800010bc <memset+0x4c>
        maddr[i]=(char)c;
80001098:	fe842703          	lw	a4,-24(s0)
8000109c:	fec42783          	lw	a5,-20(s0)
800010a0:	00f707b3          	add	a5,a4,a5
800010a4:	fd842703          	lw	a4,-40(s0)
800010a8:	0ff77713          	andi	a4,a4,255
800010ac:	00e78023          	sb	a4,0(a5) # 8000b000 <memend+0xf800b000>
    for(uint i=0;i<n;i++){
800010b0:	fec42783          	lw	a5,-20(s0)
800010b4:	00178793          	addi	a5,a5,1
800010b8:	fef42623          	sw	a5,-20(s0)
800010bc:	fec42703          	lw	a4,-20(s0)
800010c0:	fd442783          	lw	a5,-44(s0)
800010c4:	fcf76ae3          	bltu	a4,a5,80001098 <memset+0x28>
    }
    return addr;
800010c8:	fdc42783          	lw	a5,-36(s0)
}
800010cc:	00078513          	mv	a0,a5
800010d0:	02c12403          	lw	s0,44(sp)
800010d4:	03010113          	addi	sp,sp,48
800010d8:	00008067          	ret

800010dc <minit>:

void minit(){
800010dc:	fe010113          	addi	sp,sp,-32
800010e0:	00112e23          	sw	ra,28(sp)
800010e4:	00812c23          	sw	s0,24(sp)
800010e8:	02010413          	addi	s0,sp,32
    printf("textstart:%p    ",textstart);
800010ec:	800007b7          	lui	a5,0x80000
800010f0:	00078593          	mv	a1,a5
800010f4:	800027b7          	lui	a5,0x80002
800010f8:	32878513          	addi	a0,a5,808 # 80002328 <memend+0xf8002328>
800010fc:	b69ff0ef          	jal	ra,80000c64 <printf>
    printf("textend:%p\n",textend);
80001100:	800027b7          	lui	a5,0x80002
80001104:	95478593          	addi	a1,a5,-1708 # 80001954 <memend+0xf8001954>
80001108:	800027b7          	lui	a5,0x80002
8000110c:	33c78513          	addi	a0,a5,828 # 8000233c <memend+0xf800233c>
80001110:	b55ff0ef          	jal	ra,80000c64 <printf>
    printf("rodatastart:%p  ",rodatastart);
80001114:	800027b7          	lui	a5,0x80002
80001118:	00078593          	mv	a1,a5
8000111c:	800027b7          	lui	a5,0x80002
80001120:	34878513          	addi	a0,a5,840 # 80002348 <memend+0xf8002348>
80001124:	b41ff0ef          	jal	ra,80000c64 <printf>
    printf("rodataend:%p\n",rodataend);
80001128:	800027b7          	lui	a5,0x80002
8000112c:	40f78593          	addi	a1,a5,1039 # 8000240f <memend+0xf800240f>
80001130:	800027b7          	lui	a5,0x80002
80001134:	35c78513          	addi	a0,a5,860 # 8000235c <memend+0xf800235c>
80001138:	b2dff0ef          	jal	ra,80000c64 <printf>
    printf("datastart:%p    ",datastart);
8000113c:	800037b7          	lui	a5,0x80003
80001140:	00078593          	mv	a1,a5
80001144:	800027b7          	lui	a5,0x80002
80001148:	36c78513          	addi	a0,a5,876 # 8000236c <memend+0xf800236c>
8000114c:	b19ff0ef          	jal	ra,80000c64 <printf>
    printf("dataend:%p\n",dataend);
80001150:	8000b7b7          	lui	a5,0x8000b
80001154:	00078593          	mv	a1,a5
80001158:	800027b7          	lui	a5,0x80002
8000115c:	38078513          	addi	a0,a5,896 # 80002380 <memend+0xf8002380>
80001160:	b05ff0ef          	jal	ra,80000c64 <printf>
    printf("bssstart:%p     ",bssstart);
80001164:	8000b7b7          	lui	a5,0x8000b
80001168:	00078593          	mv	a1,a5
8000116c:	800027b7          	lui	a5,0x80002
80001170:	38c78513          	addi	a0,a5,908 # 8000238c <memend+0xf800238c>
80001174:	af1ff0ef          	jal	ra,80000c64 <printf>
    printf("bssend:%p\n",bssend);
80001178:	8000b7b7          	lui	a5,0x8000b
8000117c:	40878593          	addi	a1,a5,1032 # 8000b408 <memend+0xf800b408>
80001180:	800027b7          	lui	a5,0x80002
80001184:	3a078513          	addi	a0,a5,928 # 800023a0 <memend+0xf80023a0>
80001188:	addff0ef          	jal	ra,80000c64 <printf>
    printf("mstart:%p   ",mstart);
8000118c:	8000c7b7          	lui	a5,0x8000c
80001190:	00078593          	mv	a1,a5
80001194:	800027b7          	lui	a5,0x80002
80001198:	3ac78513          	addi	a0,a5,940 # 800023ac <memend+0xf80023ac>
8000119c:	ac9ff0ef          	jal	ra,80000c64 <printf>
    printf("mend:%p\n",mend);
800011a0:	880007b7          	lui	a5,0x88000
800011a4:	00078593          	mv	a1,a5
800011a8:	800027b7          	lui	a5,0x80002
800011ac:	3bc78513          	addi	a0,a5,956 # 800023bc <memend+0xf80023bc>
800011b0:	ab5ff0ef          	jal	ra,80000c64 <printf>
    printf("stack:%p\n",stacks);
800011b4:	800037b7          	lui	a5,0x80003
800011b8:	00078593          	mv	a1,a5
800011bc:	800027b7          	lui	a5,0x80002
800011c0:	3c878513          	addi	a0,a5,968 # 800023c8 <memend+0xf80023c8>
800011c4:	aa1ff0ef          	jal	ra,80000c64 <printf>

    char* p=(char*)mstart;
800011c8:	8000c7b7          	lui	a5,0x8000c
800011cc:	00078793          	mv	a5,a5
800011d0:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800011d4:	0380006f          	j	8000120c <minit+0x130>
        m=(struct pmp*)p;
800011d8:	fec42783          	lw	a5,-20(s0)
800011dc:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
800011e0:	8000b7b7          	lui	a5,0x8000b
800011e4:	4007a703          	lw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
800011e8:	fe842783          	lw	a5,-24(s0)
800011ec:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
800011f0:	8000b7b7          	lui	a5,0x8000b
800011f4:	fe842703          	lw	a4,-24(s0)
800011f8:	40e7a023          	sw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800011fc:	fec42703          	lw	a4,-20(s0)
80001200:	000017b7          	lui	a5,0x1
80001204:	00f707b3          	add	a5,a4,a5
80001208:	fef42623          	sw	a5,-20(s0)
8000120c:	fec42703          	lw	a4,-20(s0)
80001210:	000017b7          	lui	a5,0x1
80001214:	00f70733          	add	a4,a4,a5
80001218:	880007b7          	lui	a5,0x88000
8000121c:	00078793          	mv	a5,a5
80001220:	fae7fce3          	bgeu	a5,a4,800011d8 <minit+0xfc>
    }
}
80001224:	00000013          	nop
80001228:	00000013          	nop
8000122c:	01c12083          	lw	ra,28(sp)
80001230:	01812403          	lw	s0,24(sp)
80001234:	02010113          	addi	sp,sp,32
80001238:	00008067          	ret

8000123c <palloc>:

void* palloc(){
8000123c:	fe010113          	addi	sp,sp,-32
80001240:	00112e23          	sw	ra,28(sp)
80001244:	00812c23          	sw	s0,24(sp)
80001248:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
8000124c:	8000b7b7          	lui	a5,0x8000b
80001250:	4007a783          	lw	a5,1024(a5) # 8000b400 <memend+0xf800b400>
80001254:	fef42623          	sw	a5,-20(s0)
    if(p)
80001258:	fec42783          	lw	a5,-20(s0)
8000125c:	00078c63          	beqz	a5,80001274 <palloc+0x38>
        mem.freelist=mem.freelist->next;
80001260:	8000b7b7          	lui	a5,0x8000b
80001264:	4007a783          	lw	a5,1024(a5) # 8000b400 <memend+0xf800b400>
80001268:	0007a703          	lw	a4,0(a5)
8000126c:	8000b7b7          	lui	a5,0x8000b
80001270:	40e7a023          	sw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
    if(p)
80001274:	fec42783          	lw	a5,-20(s0)
80001278:	00078a63          	beqz	a5,8000128c <palloc+0x50>
        memset(p,0,PGSIZE);
8000127c:	00001637          	lui	a2,0x1
80001280:	00000593          	li	a1,0
80001284:	fec42503          	lw	a0,-20(s0)
80001288:	de9ff0ef          	jal	ra,80001070 <memset>
    return (void*)p;
8000128c:	fec42783          	lw	a5,-20(s0)
}
80001290:	00078513          	mv	a0,a5
80001294:	01c12083          	lw	ra,28(sp)
80001298:	01812403          	lw	s0,24(sp)
8000129c:	02010113          	addi	sp,sp,32
800012a0:	00008067          	ret

800012a4 <pfree>:

void pfree(void* addr){
800012a4:	fd010113          	addi	sp,sp,-48
800012a8:	02812623          	sw	s0,44(sp)
800012ac:	03010413          	addi	s0,sp,48
800012b0:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
800012b4:	fdc42783          	lw	a5,-36(s0)
800012b8:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
800012bc:	8000b7b7          	lui	a5,0x8000b
800012c0:	4007a703          	lw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
800012c4:	fec42783          	lw	a5,-20(s0)
800012c8:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
800012cc:	8000b7b7          	lui	a5,0x8000b
800012d0:	fec42703          	lw	a4,-20(s0)
800012d4:	40e7a023          	sw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
800012d8:	00000013          	nop
800012dc:	02c12403          	lw	s0,44(sp)
800012e0:	03010113          	addi	sp,sp,48
800012e4:	00008067          	ret

800012e8 <r_tp>:
static inline uint32 r_tp(){
800012e8:	fe010113          	addi	sp,sp,-32
800012ec:	00812e23          	sw	s0,28(sp)
800012f0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800012f4:	00020793          	mv	a5,tp
800012f8:	fef42623          	sw	a5,-20(s0)
    return x;
800012fc:	fec42783          	lw	a5,-20(s0)
}
80001300:	00078513          	mv	a0,a5
80001304:	01c12403          	lw	s0,28(sp)
80001308:	02010113          	addi	sp,sp,32
8000130c:	00008067          	ret

80001310 <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
80001310:	fe010113          	addi	sp,sp,-32
80001314:	00812e23          	sw	s0,28(sp)
80001318:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
8000131c:	104027f3          	csrr	a5,sie
80001320:	fef42623          	sw	a5,-20(s0)
    return x;
80001324:	fec42783          	lw	a5,-20(s0)
}
80001328:	00078513          	mv	a0,a5
8000132c:	01c12403          	lw	s0,28(sp)
80001330:	02010113          	addi	sp,sp,32
80001334:	00008067          	ret

80001338 <w_sie>:
static inline void w_sie(uint32 x){
80001338:	fe010113          	addi	sp,sp,-32
8000133c:	00812e23          	sw	s0,28(sp)
80001340:	02010413          	addi	s0,sp,32
80001344:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80001348:	fec42783          	lw	a5,-20(s0)
8000134c:	10479073          	csrw	sie,a5
}
80001350:	00000013          	nop
80001354:	01c12403          	lw	s0,28(sp)
80001358:	02010113          	addi	sp,sp,32
8000135c:	00008067          	ret

80001360 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
80001360:	ff010113          	addi	sp,sp,-16
80001364:	00112623          	sw	ra,12(sp)
80001368:	00812423          	sw	s0,8(sp)
8000136c:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
80001370:	0c0007b7          	lui	a5,0xc000
80001374:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001378:	00100713          	li	a4,1
8000137c:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001380:	f69ff0ef          	jal	ra,800012e8 <r_tp>
80001384:	00050793          	mv	a5,a0
80001388:	00879713          	slli	a4,a5,0x8
8000138c:	0c0027b7          	lui	a5,0xc002
80001390:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001394:	00f707b3          	add	a5,a4,a5
80001398:	00078713          	mv	a4,a5
8000139c:	40000793          	li	a5,1024
800013a0:	00f72023          	sw	a5,0(a4) # 8000b000 <memend+0xf800b000>
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800013a4:	f45ff0ef          	jal	ra,800012e8 <r_tp>
800013a8:	00050713          	mv	a4,a0
800013ac:	000c07b7          	lui	a5,0xc0
800013b0:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800013b4:	00f707b3          	add	a5,a4,a5
800013b8:	00879793          	slli	a5,a5,0x8
800013bc:	00078713          	mv	a4,a5
800013c0:	40000793          	li	a5,1024
800013c4:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
800013c8:	f21ff0ef          	jal	ra,800012e8 <r_tp>
800013cc:	00050713          	mv	a4,a0
800013d0:	000067b7          	lui	a5,0x6
800013d4:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800013d8:	00f707b3          	add	a5,a4,a5
800013dc:	00d79793          	slli	a5,a5,0xd
800013e0:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800013e4:	f05ff0ef          	jal	ra,800012e8 <r_tp>
800013e8:	00050793          	mv	a5,a0
800013ec:	00d79713          	slli	a4,a5,0xd
800013f0:	0c2017b7          	lui	a5,0xc201
800013f4:	00f707b3          	add	a5,a4,a5
800013f8:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800013fc:	f15ff0ef          	jal	ra,80001310 <r_sie>
80001400:	00050793          	mv	a5,a0
80001404:	2227e793          	ori	a5,a5,546
80001408:	00078513          	mv	a0,a5
8000140c:	f2dff0ef          	jal	ra,80001338 <w_sie>
}
80001410:	00000013          	nop
80001414:	00c12083          	lw	ra,12(sp)
80001418:	00812403          	lw	s0,8(sp)
8000141c:	01010113          	addi	sp,sp,16
80001420:	00008067          	ret

80001424 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80001424:	ff010113          	addi	sp,sp,-16
80001428:	00112623          	sw	ra,12(sp)
8000142c:	00812423          	sw	s0,8(sp)
80001430:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001434:	eb5ff0ef          	jal	ra,800012e8 <r_tp>
80001438:	00050793          	mv	a5,a0
8000143c:	00d79713          	slli	a4,a5,0xd
80001440:	0c2017b7          	lui	a5,0xc201
80001444:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001448:	00f707b3          	add	a5,a4,a5
8000144c:	0007a783          	lw	a5,0(a5)
}
80001450:	00078513          	mv	a0,a5
80001454:	00c12083          	lw	ra,12(sp)
80001458:	00812403          	lw	s0,8(sp)
8000145c:	01010113          	addi	sp,sp,16
80001460:	00008067          	ret

80001464 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001464:	fe010113          	addi	sp,sp,-32
80001468:	00112e23          	sw	ra,28(sp)
8000146c:	00812c23          	sw	s0,24(sp)
80001470:	02010413          	addi	s0,sp,32
80001474:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80001478:	e71ff0ef          	jal	ra,800012e8 <r_tp>
8000147c:	00050793          	mv	a5,a0
80001480:	00d79713          	slli	a4,a5,0xd
80001484:	0c2007b7          	lui	a5,0xc200
80001488:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
8000148c:	00f707b3          	add	a5,a4,a5
80001490:	00078713          	mv	a4,a5
80001494:	fec42783          	lw	a5,-20(s0)
80001498:	00f72023          	sw	a5,0(a4)
8000149c:	00000013          	nop
800014a0:	01c12083          	lw	ra,28(sp)
800014a4:	01812403          	lw	s0,24(sp)
800014a8:	02010113          	addi	sp,sp,32
800014ac:	00008067          	ret

800014b0 <w_satp>:
static inline void w_satp(uint32 x){
800014b0:	fe010113          	addi	sp,sp,-32
800014b4:	00812e23          	sw	s0,28(sp)
800014b8:	02010413          	addi	s0,sp,32
800014bc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800014c0:	fec42783          	lw	a5,-20(s0)
800014c4:	18079073          	csrw	satp,a5
}
800014c8:	00000013          	nop
800014cc:	01c12403          	lw	s0,28(sp)
800014d0:	02010113          	addi	sp,sp,32
800014d4:	00008067          	ret

800014d8 <sfence_vma>:
static inline void sfence_vma(){
800014d8:	ff010113          	addi	sp,sp,-16
800014dc:	00812623          	sw	s0,12(sp)
800014e0:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800014e4:	12000073          	sfence.vma
}
800014e8:	00000013          	nop
800014ec:	00c12403          	lw	s0,12(sp)
800014f0:	01010113          	addi	sp,sp,16
800014f4:	00008067          	ret

800014f8 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
800014f8:	fd010113          	addi	sp,sp,-48
800014fc:	02112623          	sw	ra,44(sp)
80001500:	02812423          	sw	s0,40(sp)
80001504:	03010413          	addi	s0,sp,48
80001508:	fca42e23          	sw	a0,-36(s0)
8000150c:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
80001510:	fd842783          	lw	a5,-40(s0)
80001514:	0167d793          	srli	a5,a5,0x16
80001518:	00279793          	slli	a5,a5,0x2
8000151c:	fdc42703          	lw	a4,-36(s0)
80001520:	00f707b3          	add	a5,a4,a5
80001524:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001528:	fec42783          	lw	a5,-20(s0)
8000152c:	0007a783          	lw	a5,0(a5)
80001530:	0017f793          	andi	a5,a5,1
80001534:	00078e63          	beqz	a5,80001550 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001538:	fec42783          	lw	a5,-20(s0)
8000153c:	0007a783          	lw	a5,0(a5)
80001540:	00a7d793          	srli	a5,a5,0xa
80001544:	00c79793          	slli	a5,a5,0xc
80001548:	fcf42e23          	sw	a5,-36(s0)
8000154c:	0340006f          	j	80001580 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
80001550:	cedff0ef          	jal	ra,8000123c <palloc>
80001554:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001558:	00001637          	lui	a2,0x1
8000155c:	00000593          	li	a1,0
80001560:	fdc42503          	lw	a0,-36(s0)
80001564:	b0dff0ef          	jal	ra,80001070 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001568:	fdc42783          	lw	a5,-36(s0)
8000156c:	00c7d793          	srli	a5,a5,0xc
80001570:	00a79793          	slli	a5,a5,0xa
80001574:	0017e713          	ori	a4,a5,1
80001578:	fec42783          	lw	a5,-20(s0)
8000157c:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001580:	fd842783          	lw	a5,-40(s0)
80001584:	00c7d793          	srli	a5,a5,0xc
80001588:	3ff7f793          	andi	a5,a5,1023
8000158c:	00279793          	slli	a5,a5,0x2
80001590:	fdc42703          	lw	a4,-36(s0)
80001594:	00f707b3          	add	a5,a4,a5
}
80001598:	00078513          	mv	a0,a5
8000159c:	02c12083          	lw	ra,44(sp)
800015a0:	02812403          	lw	s0,40(sp)
800015a4:	03010113          	addi	sp,sp,48
800015a8:	00008067          	ret

800015ac <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
800015ac:	fc010113          	addi	sp,sp,-64
800015b0:	02112e23          	sw	ra,60(sp)
800015b4:	02812c23          	sw	s0,56(sp)
800015b8:	04010413          	addi	s0,sp,64
800015bc:	fca42e23          	sw	a0,-36(s0)
800015c0:	fcb42c23          	sw	a1,-40(s0)
800015c4:	fcc42a23          	sw	a2,-44(s0)
800015c8:	fcd42823          	sw	a3,-48(s0)
800015cc:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
800015d0:	fd842703          	lw	a4,-40(s0)
800015d4:	fffff7b7          	lui	a5,0xfffff
800015d8:	00f777b3          	and	a5,a4,a5
800015dc:	fef42623          	sw	a5,-20(s0)
    addr_t end = (((va + size - 1) >>12)<<12);
800015e0:	fd842703          	lw	a4,-40(s0)
800015e4:	fd042783          	lw	a5,-48(s0)
800015e8:	00f707b3          	add	a5,a4,a5
800015ec:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
800015f0:	fffff7b7          	lui	a5,0xfffff
800015f4:	00f777b3          	and	a5,a4,a5
800015f8:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
800015fc:	fec42583          	lw	a1,-20(s0)
80001600:	fdc42503          	lw	a0,-36(s0)
80001604:	ef5ff0ef          	jal	ra,800014f8 <acquriepte>
80001608:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
8000160c:	fe442783          	lw	a5,-28(s0)
80001610:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001614:	0017f793          	andi	a5,a5,1
80001618:	00078863          	beqz	a5,80001628 <vmmap+0x7c>
            panic("repeat map");
8000161c:	800027b7          	lui	a5,0x80002
80001620:	3d478513          	addi	a0,a5,980 # 800023d4 <memend+0xf80023d4>
80001624:	e08ff0ef          	jal	ra,80000c2c <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001628:	fd442783          	lw	a5,-44(s0)
8000162c:	00c7d793          	srli	a5,a5,0xc
80001630:	00a79713          	slli	a4,a5,0xa
80001634:	fcc42783          	lw	a5,-52(s0)
80001638:	00f767b3          	or	a5,a4,a5
8000163c:	0017e713          	ori	a4,a5,1
80001640:	fe442783          	lw	a5,-28(s0)
80001644:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001648:	fec42703          	lw	a4,-20(s0)
8000164c:	fe842783          	lw	a5,-24(s0)
80001650:	02f70463          	beq	a4,a5,80001678 <vmmap+0xcc>
        start += PGSIZE;
80001654:	fec42703          	lw	a4,-20(s0)
80001658:	000017b7          	lui	a5,0x1
8000165c:	00f707b3          	add	a5,a4,a5
80001660:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001664:	fd442703          	lw	a4,-44(s0)
80001668:	000017b7          	lui	a5,0x1
8000166c:	00f707b3          	add	a5,a4,a5
80001670:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001674:	f89ff06f          	j	800015fc <vmmap+0x50>
        if(start==end)  break;
80001678:	00000013          	nop
    }
}
8000167c:	00000013          	nop
80001680:	03c12083          	lw	ra,60(sp)
80001684:	03812403          	lw	s0,56(sp)
80001688:	04010113          	addi	sp,sp,64
8000168c:	00008067          	ret

80001690 <printpgt>:

void printpgt(addr_t* pgt){
80001690:	fc010113          	addi	sp,sp,-64
80001694:	02112e23          	sw	ra,60(sp)
80001698:	02812c23          	sw	s0,56(sp)
8000169c:	04010413          	addi	s0,sp,64
800016a0:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
800016a4:	fe042623          	sw	zero,-20(s0)
800016a8:	0c40006f          	j	8000176c <printpgt+0xdc>
        pte_t pte=pgt[i];
800016ac:	fec42783          	lw	a5,-20(s0)
800016b0:	00279793          	slli	a5,a5,0x2
800016b4:	fcc42703          	lw	a4,-52(s0)
800016b8:	00f707b3          	add	a5,a4,a5
800016bc:	0007a783          	lw	a5,0(a5) # 1000 <sz>
800016c0:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
800016c4:	fe442783          	lw	a5,-28(s0)
800016c8:	0017f793          	andi	a5,a5,1
800016cc:	08078a63          	beqz	a5,80001760 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
800016d0:	fe442783          	lw	a5,-28(s0)
800016d4:	00a7d793          	srli	a5,a5,0xa
800016d8:	00c79793          	slli	a5,a5,0xc
800016dc:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
800016e0:	fe042683          	lw	a3,-32(s0)
800016e4:	fe442603          	lw	a2,-28(s0)
800016e8:	fec42583          	lw	a1,-20(s0)
800016ec:	800027b7          	lui	a5,0x80002
800016f0:	3e078513          	addi	a0,a5,992 # 800023e0 <memend+0xf80023e0>
800016f4:	d70ff0ef          	jal	ra,80000c64 <printf>
            for(int j=0;j<1024;j++){
800016f8:	fe042423          	sw	zero,-24(s0)
800016fc:	0580006f          	j	80001754 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001700:	fe842783          	lw	a5,-24(s0)
80001704:	00279793          	slli	a5,a5,0x2
80001708:	fe042703          	lw	a4,-32(s0)
8000170c:	00f707b3          	add	a5,a4,a5
80001710:	0007a783          	lw	a5,0(a5)
80001714:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001718:	fdc42783          	lw	a5,-36(s0)
8000171c:	0017f793          	andi	a5,a5,1
80001720:	02078463          	beqz	a5,80001748 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001724:	fdc42783          	lw	a5,-36(s0)
80001728:	00a7d793          	srli	a5,a5,0xa
8000172c:	00c79793          	slli	a5,a5,0xc
80001730:	00078693          	mv	a3,a5
80001734:	fdc42603          	lw	a2,-36(s0)
80001738:	fe842583          	lw	a1,-24(s0)
8000173c:	800027b7          	lui	a5,0x80002
80001740:	3f878513          	addi	a0,a5,1016 # 800023f8 <memend+0xf80023f8>
80001744:	d20ff0ef          	jal	ra,80000c64 <printf>
            for(int j=0;j<1024;j++){
80001748:	fe842783          	lw	a5,-24(s0)
8000174c:	00178793          	addi	a5,a5,1
80001750:	fef42423          	sw	a5,-24(s0)
80001754:	fe842703          	lw	a4,-24(s0)
80001758:	3ff00793          	li	a5,1023
8000175c:	fae7d2e3          	bge	a5,a4,80001700 <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001760:	fec42783          	lw	a5,-20(s0)
80001764:	00178793          	addi	a5,a5,1
80001768:	fef42623          	sw	a5,-20(s0)
8000176c:	fec42703          	lw	a4,-20(s0)
80001770:	3ff00793          	li	a5,1023
80001774:	f2e7dce3          	bge	a5,a4,800016ac <printpgt+0x1c>
                }
            }
        }
    }
}
80001778:	00000013          	nop
8000177c:	00000013          	nop
80001780:	03c12083          	lw	ra,60(sp)
80001784:	03812403          	lw	s0,56(sp)
80001788:	04010113          	addi	sp,sp,64
8000178c:	00008067          	ret

80001790 <vminit>:

// 初始化虚拟内存
void vminit(){
80001790:	ff010113          	addi	sp,sp,-16
80001794:	00112623          	sw	ra,12(sp)
80001798:	00812423          	sw	s0,8(sp)
8000179c:	01010413          	addi	s0,sp,16
    pgt=(addr_t*)palloc();
800017a0:	a9dff0ef          	jal	ra,8000123c <palloc>
800017a4:	00050713          	mv	a4,a0
800017a8:	8000b7b7          	lui	a5,0x8000b
800017ac:	40e7a223          	sw	a4,1028(a5) # 8000b404 <memend+0xf800b404>
    memset(pgt,0,PGSIZE);
800017b0:	8000b7b7          	lui	a5,0x8000b
800017b4:	4047a783          	lw	a5,1028(a5) # 8000b404 <memend+0xf800b404>
800017b8:	00001637          	lui	a2,0x1
800017bc:	00000593          	li	a1,0
800017c0:	00078513          	mv	a0,a5
800017c4:	8adff0ef          	jal	ra,80001070 <memset>

    // 映射 PLIC 寄存器
    vmmap(pgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
800017c8:	8000b7b7          	lui	a5,0x8000b
800017cc:	4047a783          	lw	a5,1028(a5) # 8000b404 <memend+0xf800b404>
800017d0:	00600713          	li	a4,6
800017d4:	004006b7          	lui	a3,0x400
800017d8:	0c000637          	lui	a2,0xc000
800017dc:	0c0005b7          	lui	a1,0xc000
800017e0:	00078513          	mv	a0,a5
800017e4:	dc9ff0ef          	jal	ra,800015ac <vmmap>

    // 映射 UART 寄存器
    vmmap(pgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
800017e8:	8000b7b7          	lui	a5,0x8000b
800017ec:	4047a783          	lw	a5,1028(a5) # 8000b404 <memend+0xf800b404>
800017f0:	00600713          	li	a4,6
800017f4:	000016b7          	lui	a3,0x1
800017f8:	10000637          	lui	a2,0x10000
800017fc:	100005b7          	lui	a1,0x10000
80001800:	00078513          	mv	a0,a5
80001804:	da9ff0ef          	jal	ra,800015ac <vmmap>
    
    // 映射 内核 指令区
    vmmap(pgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
80001808:	8000b7b7          	lui	a5,0x8000b
8000180c:	4047a503          	lw	a0,1028(a5) # 8000b404 <memend+0xf800b404>
80001810:	800007b7          	lui	a5,0x80000
80001814:	00078593          	mv	a1,a5
80001818:	800007b7          	lui	a5,0x80000
8000181c:	00078613          	mv	a2,a5
80001820:	800027b7          	lui	a5,0x80002
80001824:	95478713          	addi	a4,a5,-1708 # 80001954 <memend+0xf8001954>
80001828:	800007b7          	lui	a5,0x80000
8000182c:	00078793          	mv	a5,a5
80001830:	40f707b3          	sub	a5,a4,a5
80001834:	00a00713          	li	a4,10
80001838:	00078693          	mv	a3,a5
8000183c:	d71ff0ef          	jal	ra,800015ac <vmmap>
    // 映射 内核 只读区
    vmmap(pgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001840:	8000b7b7          	lui	a5,0x8000b
80001844:	4047a503          	lw	a0,1028(a5) # 8000b404 <memend+0xf800b404>
80001848:	800027b7          	lui	a5,0x80002
8000184c:	00078593          	mv	a1,a5
80001850:	800027b7          	lui	a5,0x80002
80001854:	00078613          	mv	a2,a5
80001858:	800027b7          	lui	a5,0x80002
8000185c:	40f78713          	addi	a4,a5,1039 # 8000240f <memend+0xf800240f>
80001860:	800027b7          	lui	a5,0x80002
80001864:	00078793          	mv	a5,a5
80001868:	40f707b3          	sub	a5,a4,a5
8000186c:	00200713          	li	a4,2
80001870:	00078693          	mv	a3,a5
80001874:	d39ff0ef          	jal	ra,800015ac <vmmap>
    // 映射 数据区
    vmmap(pgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001878:	8000b7b7          	lui	a5,0x8000b
8000187c:	4047a503          	lw	a0,1028(a5) # 8000b404 <memend+0xf800b404>
80001880:	800037b7          	lui	a5,0x80003
80001884:	00078593          	mv	a1,a5
80001888:	800037b7          	lui	a5,0x80003
8000188c:	00078613          	mv	a2,a5
80001890:	8000b7b7          	lui	a5,0x8000b
80001894:	00078713          	mv	a4,a5
80001898:	800037b7          	lui	a5,0x80003
8000189c:	00078793          	mv	a5,a5
800018a0:	40f707b3          	sub	a5,a4,a5
800018a4:	00600713          	li	a4,6
800018a8:	00078693          	mv	a3,a5
800018ac:	d01ff0ef          	jal	ra,800015ac <vmmap>
    // 映射 内核 全局数据区
    vmmap(pgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
800018b0:	8000b7b7          	lui	a5,0x8000b
800018b4:	4047a503          	lw	a0,1028(a5) # 8000b404 <memend+0xf800b404>
800018b8:	8000b7b7          	lui	a5,0x8000b
800018bc:	00078593          	mv	a1,a5
800018c0:	8000b7b7          	lui	a5,0x8000b
800018c4:	00078613          	mv	a2,a5
800018c8:	8000b7b7          	lui	a5,0x8000b
800018cc:	40878713          	addi	a4,a5,1032 # 8000b408 <memend+0xf800b408>
800018d0:	8000b7b7          	lui	a5,0x8000b
800018d4:	00078793          	mv	a5,a5
800018d8:	40f707b3          	sub	a5,a4,a5
800018dc:	00600713          	li	a4,6
800018e0:	00078693          	mv	a3,a5
800018e4:	cc9ff0ef          	jal	ra,800015ac <vmmap>
    
    // 映射空闲内存区
    vmmap(pgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
800018e8:	8000b7b7          	lui	a5,0x8000b
800018ec:	4047a503          	lw	a0,1028(a5) # 8000b404 <memend+0xf800b404>
800018f0:	8000c7b7          	lui	a5,0x8000c
800018f4:	00078593          	mv	a1,a5
800018f8:	8000c7b7          	lui	a5,0x8000c
800018fc:	00078613          	mv	a2,a5
80001900:	880007b7          	lui	a5,0x88000
80001904:	00078713          	mv	a4,a5
80001908:	8000c7b7          	lui	a5,0x8000c
8000190c:	00078793          	mv	a5,a5
80001910:	40f707b3          	sub	a5,a4,a5
80001914:	00600713          	li	a4,6
80001918:	00078693          	mv	a3,a5
8000191c:	c91ff0ef          	jal	ra,800015ac <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)pgt)>>12)); // 页表 PPN 写入Satp
80001920:	8000b7b7          	lui	a5,0x8000b
80001924:	4047a783          	lw	a5,1028(a5) # 8000b404 <memend+0xf800b404>
80001928:	00c7d713          	srli	a4,a5,0xc
8000192c:	800007b7          	lui	a5,0x80000
80001930:	00f767b3          	or	a5,a4,a5
80001934:	00078513          	mv	a0,a5
80001938:	b79ff0ef          	jal	ra,800014b0 <w_satp>
    sfence_vma();       // 刷新页表
8000193c:	b9dff0ef          	jal	ra,800014d8 <sfence_vma>

}
80001940:	00000013          	nop
80001944:	00c12083          	lw	ra,12(sp)
80001948:	00812403          	lw	s0,8(sp)
8000194c:	01010113          	addi	sp,sp,16
80001950:	00008067          	ret
