
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
8000000c:	00000117          	auipc	sp,0x0
80000010:	02010113          	addi	sp,sp,32 # 8000002c <stacks>
    li t1,sz
80000014:	00001337          	lui	t1,0x1
    mul t1,t1,t0
80000018:	02530333          	mul	t1,t1,t0
    add sp,sp,t1 # 栈指针指向栈顶
8000001c:	00610133          	add	sp,sp,t1
    
    # 跳转到start()
    j start
80000020:	6040806f          	j	80008624 <start>

80000024 <empty>:

empty:
    wfi       # 休眠指令 wait for interrupt 直至收到中断
80000024:	10500073          	wfi
    j empty
80000028:	ffdff06f          	j	80000024 <empty>

8000002c <stacks>:
	...

8000802c <cswap>:

.global cswap
cswap:
    sw ra,0(a1)
8000802c:	0015a023          	sw	ra,0(a1)
    sw sp,4(a1)
80008030:	0025a223          	sw	sp,4(a1)
    sw gp,8(a1)
80008034:	0035a423          	sw	gp,8(a1)
    sw tp,12(a1)
80008038:	0045a623          	sw	tp,12(a1)
    sw a0,16(a1)
8000803c:	00a5a823          	sw	a0,16(a1)
    sw a1,20(a1)
80008040:	00b5aa23          	sw	a1,20(a1)
    sw a2,24(a1)
80008044:	00c5ac23          	sw	a2,24(a1)
    sw a3,28(a1)
80008048:	00d5ae23          	sw	a3,28(a1)
    sw a4,32(a1)
8000804c:	02e5a023          	sw	a4,32(a1)
    sw a5,36(a1)
80008050:	02f5a223          	sw	a5,36(a1)
    sw a6,40(a1)
80008054:	0305a423          	sw	a6,40(a1)
    sw a7,44(a1)
80008058:	0315a623          	sw	a7,44(a1)
    sw s0,48(a1)
8000805c:	0285a823          	sw	s0,48(a1)
    sw s1,52(a1)
80008060:	0295aa23          	sw	s1,52(a1)
    sw s2,56(a1)
80008064:	0325ac23          	sw	s2,56(a1)
    sw s3,60(a1)
80008068:	0335ae23          	sw	s3,60(a1)
    sw s4,64(a1)
8000806c:	0545a023          	sw	s4,64(a1)
    sw s5,68(a1)
80008070:	0555a223          	sw	s5,68(a1)
    sw s6,72(a1)
80008074:	0565a423          	sw	s6,72(a1)
    sw s7,76(a1)
80008078:	0575a623          	sw	s7,76(a1)
    sw s8,80(a1)
8000807c:	0585a823          	sw	s8,80(a1)
    sw s9,84(a1)
80008080:	0595aa23          	sw	s9,84(a1)
    sw s10,88(a1)
80008084:	05a5ac23          	sw	s10,88(a1)
    sw s11,92(a1)
80008088:	05b5ae23          	sw	s11,92(a1)
    sw t0,96(a1)
8000808c:	0655a023          	sw	t0,96(a1)
    sw t1,100(a1)
80008090:	0665a223          	sw	t1,100(a1)
    sw t2,104(a1)
80008094:	0675a423          	sw	t2,104(a1)
    sw t3,108(a1)
80008098:	07c5a623          	sw	t3,108(a1)
    sw t4,112(a1)
8000809c:	07d5a823          	sw	t4,112(a1)
    sw t5,116(a1)
800080a0:	07e5aa23          	sw	t5,116(a1)
    sw t6,120(a1)
800080a4:	07f5ac23          	sw	t6,120(a1)


    lw ra,0(a0)
800080a8:	00052083          	lw	ra,0(a0)
    lw sp,4(a0)
800080ac:	00452103          	lw	sp,4(a0)
    lw gp,8(a0)
800080b0:	00852183          	lw	gp,8(a0)
    lw tp,12(a0)
800080b4:	00c52203          	lw	tp,12(a0)
    lw a0,16(a0)
800080b8:	01052503          	lw	a0,16(a0)
    lw a1,20(a0)
800080bc:	01452583          	lw	a1,20(a0)
    lw a2,24(a0)
800080c0:	01852603          	lw	a2,24(a0)
    lw a3,28(a0)
800080c4:	01c52683          	lw	a3,28(a0)
    lw a4,32(a0)
800080c8:	02052703          	lw	a4,32(a0)
    lw a5,36(a0)
800080cc:	02452783          	lw	a5,36(a0)
    lw a6,40(a0)
800080d0:	02852803          	lw	a6,40(a0)
    lw a7,44(a0)
800080d4:	02c52883          	lw	a7,44(a0)
    lw s0,48(a0)
800080d8:	03052403          	lw	s0,48(a0)
    lw s1,52(a0)
800080dc:	03452483          	lw	s1,52(a0)
    lw s2,56(a0)
800080e0:	03852903          	lw	s2,56(a0)
    lw s3,60(a0)
800080e4:	03c52983          	lw	s3,60(a0)
    lw s4,64(a0)
800080e8:	04052a03          	lw	s4,64(a0)
    lw s5,68(a0)
800080ec:	04452a83          	lw	s5,68(a0)
    lw s6,72(a0)
800080f0:	04852b03          	lw	s6,72(a0)
    lw s7,76(a0)
800080f4:	04c52b83          	lw	s7,76(a0)
    lw s8,80(a0)
800080f8:	05052c03          	lw	s8,80(a0)
    lw s9,84(a0)
800080fc:	05452c83          	lw	s9,84(a0)
    lw s10,88(a0)
80008100:	05852d03          	lw	s10,88(a0)
    lw s11,92(a0)
80008104:	05c52d83          	lw	s11,92(a0)
    lw t0,96(a0)
80008108:	06052283          	lw	t0,96(a0)
    lw t1,100(a0)
8000810c:	06452303          	lw	t1,100(a0)
    lw t2,104(a0)
80008110:	06852383          	lw	t2,104(a0)
    lw t3,108(a0)
80008114:	06c52e03          	lw	t3,108(a0)
    lw t4,112(a0)
80008118:	07052e83          	lw	t4,112(a0)
    lw t5,116(a0)
8000811c:	07452f03          	lw	t5,116(a0)
    lw t6,120(a0)
80008120:	07852f83          	lw	t6,120(a0)

    ret
80008124:	00008067          	ret

80008128 <kvec>:
.global kvec
kvec:
    addi sp,sp,-128
80008128:	f8010113          	addi	sp,sp,-128
    sw ra,0(sp)
8000812c:	00112023          	sw	ra,0(sp)
    sw sp,4(sp)
80008130:	00212223          	sw	sp,4(sp)
    sw gp,8(sp)
80008134:	00312423          	sw	gp,8(sp)
    sw tp,12(sp)
80008138:	00412623          	sw	tp,12(sp)
    sw a0,16(sp)
8000813c:	00a12823          	sw	a0,16(sp)
    sw a1,20(sp)
80008140:	00b12a23          	sw	a1,20(sp)
    sw a2,24(sp)
80008144:	00c12c23          	sw	a2,24(sp)
    sw a3,28(sp)
80008148:	00d12e23          	sw	a3,28(sp)
    sw a4,32(sp)
8000814c:	02e12023          	sw	a4,32(sp)
    sw a5,36(sp)
80008150:	02f12223          	sw	a5,36(sp)
    sw a6,40(sp)
80008154:	03012423          	sw	a6,40(sp)
    sw a7,44(sp)
80008158:	03112623          	sw	a7,44(sp)
    sw s0,48(sp)
8000815c:	02812823          	sw	s0,48(sp)
    sw s1,52(sp)
80008160:	02912a23          	sw	s1,52(sp)
    sw s2,56(sp)
80008164:	03212c23          	sw	s2,56(sp)
    sw s3,60(sp)
80008168:	03312e23          	sw	s3,60(sp)
    sw s4,64(sp)
8000816c:	05412023          	sw	s4,64(sp)
    sw s5,68(sp)
80008170:	05512223          	sw	s5,68(sp)
    sw s6,72(sp)
80008174:	05612423          	sw	s6,72(sp)
    sw s7,76(sp)
80008178:	05712623          	sw	s7,76(sp)
    sw s8,80(sp)
8000817c:	05812823          	sw	s8,80(sp)
    sw s9,84(sp)
80008180:	05912a23          	sw	s9,84(sp)
    sw s10,88(sp)
80008184:	05a12c23          	sw	s10,88(sp)
    sw s11,92(sp)
80008188:	05b12e23          	sw	s11,92(sp)
    sw t0,96(sp)
8000818c:	06512023          	sw	t0,96(sp)
    sw t1,100(sp)
80008190:	06612223          	sw	t1,100(sp)
    sw t2,104(sp)
80008194:	06712423          	sw	t2,104(sp)
    sw t3,108(sp)
80008198:	07c12623          	sw	t3,108(sp)
    sw t4,112(sp)
8000819c:	07d12823          	sw	t4,112(sp)
    sw t5,116(sp)
800081a0:	07e12a23          	sw	t5,116(sp)
    sw t6,120(sp)
800081a4:	07f12c23          	sw	t6,120(sp)

    call trapvec
800081a8:	0a1000ef          	jal	ra,80008a48 <trapvec>

    lw ra,0(sp)
800081ac:	00012083          	lw	ra,0(sp)
    lw sp,4(sp)
800081b0:	00412103          	lw	sp,4(sp)
    lw gp,8(sp)
800081b4:	00812183          	lw	gp,8(sp)
    lw tp,12(sp)
800081b8:	00c12203          	lw	tp,12(sp)
    lw a0,16(sp)
800081bc:	01012503          	lw	a0,16(sp)
    lw a1,20(sp)
800081c0:	01412583          	lw	a1,20(sp)
    lw a2,24(sp)
800081c4:	01812603          	lw	a2,24(sp)
    lw a3,28(sp)
800081c8:	01c12683          	lw	a3,28(sp)
    lw a4,32(sp)
800081cc:	02012703          	lw	a4,32(sp)
    lw a5,36(sp)
800081d0:	02412783          	lw	a5,36(sp)
    lw a6,40(sp)
800081d4:	02812803          	lw	a6,40(sp)
    lw a7,44(sp)
800081d8:	02c12883          	lw	a7,44(sp)
    lw s0,48(sp)
800081dc:	03012403          	lw	s0,48(sp)
    lw s1,52(sp)
800081e0:	03412483          	lw	s1,52(sp)
    lw s2,56(sp)
800081e4:	03812903          	lw	s2,56(sp)
    lw s3,60(sp)
800081e8:	03c12983          	lw	s3,60(sp)
    lw s4,64(sp)
800081ec:	04012a03          	lw	s4,64(sp)
    lw s5,68(sp)
800081f0:	04412a83          	lw	s5,68(sp)
    lw s6,72(sp)
800081f4:	04812b03          	lw	s6,72(sp)
    lw s7,76(sp)
800081f8:	04c12b83          	lw	s7,76(sp)
    lw s8,80(sp)
800081fc:	05012c03          	lw	s8,80(sp)
    lw s9,84(sp)
80008200:	05412c83          	lw	s9,84(sp)
    lw s10,88(sp)
80008204:	05812d03          	lw	s10,88(sp)
    lw s11,92(sp)
80008208:	05c12d83          	lw	s11,92(sp)
    lw t0,96(sp)
8000820c:	06012283          	lw	t0,96(sp)
    lw t1,100(sp)
80008210:	06412303          	lw	t1,100(sp)
    lw t2,104(sp)
80008214:	06812383          	lw	t2,104(sp)
    lw t3,108(sp)
80008218:	06c12e03          	lw	t3,108(sp)
    lw t4,112(sp)
8000821c:	07012e83          	lw	t4,112(sp)
    lw t5,116(sp)
80008220:	07412f03          	lw	t5,116(sp)
    lw t6,120(sp)
80008224:	07812f83          	lw	t6,120(sp)

    addi sp,sp,128
80008228:	08010113          	addi	sp,sp,128
    
8000822c:	10200073          	sret

80008230 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80008230:	fe010113          	addi	sp,sp,-32
80008234:	00812e23          	sw	s0,28(sp)
80008238:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
8000823c:	300027f3          	csrr	a5,mstatus
80008240:	fef42623          	sw	a5,-20(s0)
    return x;
80008244:	fec42783          	lw	a5,-20(s0)
}
80008248:	00078513          	mv	a0,a5
8000824c:	01c12403          	lw	s0,28(sp)
80008250:	02010113          	addi	sp,sp,32
80008254:	00008067          	ret

80008258 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
80008258:	fe010113          	addi	sp,sp,-32
8000825c:	00812e23          	sw	s0,28(sp)
80008260:	02010413          	addi	s0,sp,32
80008264:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80008268:	fec42783          	lw	a5,-20(s0)
8000826c:	30079073          	csrw	mstatus,a5
}
80008270:	00000013          	nop
80008274:	01c12403          	lw	s0,28(sp)
80008278:	02010113          	addi	sp,sp,32
8000827c:	00008067          	ret

80008280 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80008280:	fd010113          	addi	sp,sp,-48
80008284:	02112623          	sw	ra,44(sp)
80008288:	02812423          	sw	s0,40(sp)
8000828c:	03010413          	addi	s0,sp,48
80008290:	00050793          	mv	a5,a0
80008294:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
80008298:	f99ff0ef          	jal	ra,80008230 <r_mstatus>
8000829c:	fea42623          	sw	a0,-20(s0)
    switch (m)
800082a0:	fdf44783          	lbu	a5,-33(s0)
800082a4:	00300713          	li	a4,3
800082a8:	06e78063          	beq	a5,a4,80008308 <s_mstatus_xpp+0x88>
800082ac:	00300713          	li	a4,3
800082b0:	08f74263          	blt	a4,a5,80008334 <s_mstatus_xpp+0xb4>
800082b4:	00078863          	beqz	a5,800082c4 <s_mstatus_xpp+0x44>
800082b8:	00100713          	li	a4,1
800082bc:	02e78063          	beq	a5,a4,800082dc <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800082c0:	0740006f          	j	80008334 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800082c4:	fec42703          	lw	a4,-20(s0)
800082c8:	ffffe7b7          	lui	a5,0xffffe
800082cc:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800082d0:	00f777b3          	and	a5,a4,a5
800082d4:	fef42623          	sw	a5,-20(s0)
        break;
800082d8:	0600006f          	j	80008338 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800082dc:	fec42703          	lw	a4,-20(s0)
800082e0:	ffffe7b7          	lui	a5,0xffffe
800082e4:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800082e8:	00f777b3          	and	a5,a4,a5
800082ec:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
800082f0:	fec42703          	lw	a4,-20(s0)
800082f4:	000017b7          	lui	a5,0x1
800082f8:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
800082fc:	00f767b3          	or	a5,a4,a5
80008300:	fef42623          	sw	a5,-20(s0)
        break;
80008304:	0340006f          	j	80008338 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80008308:	fec42703          	lw	a4,-20(s0)
8000830c:	ffffe7b7          	lui	a5,0xffffe
80008310:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80008314:	00f777b3          	and	a5,a4,a5
80008318:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
8000831c:	fec42703          	lw	a4,-20(s0)
80008320:	000027b7          	lui	a5,0x2
80008324:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
80008328:	00f767b3          	or	a5,a4,a5
8000832c:	fef42623          	sw	a5,-20(s0)
        break;
80008330:	0080006f          	j	80008338 <s_mstatus_xpp+0xb8>
        break;
80008334:	00000013          	nop
    }
    w_mstatus(x);
80008338:	fec42503          	lw	a0,-20(s0)
8000833c:	f1dff0ef          	jal	ra,80008258 <w_mstatus>
}
80008340:	00000013          	nop
80008344:	02c12083          	lw	ra,44(sp)
80008348:	02812403          	lw	s0,40(sp)
8000834c:	03010113          	addi	sp,sp,48
80008350:	00008067          	ret

80008354 <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
80008354:	fe010113          	addi	sp,sp,-32
80008358:	00812e23          	sw	s0,28(sp)
8000835c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80008360:	100027f3          	csrr	a5,sstatus
80008364:	fef42623          	sw	a5,-20(s0)
    return x;
80008368:	fec42783          	lw	a5,-20(s0)
}
8000836c:	00078513          	mv	a0,a5
80008370:	01c12403          	lw	s0,28(sp)
80008374:	02010113          	addi	sp,sp,32
80008378:	00008067          	ret

8000837c <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
8000837c:	fe010113          	addi	sp,sp,-32
80008380:	00812e23          	sw	s0,28(sp)
80008384:	02010413          	addi	s0,sp,32
80008388:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
8000838c:	fec42783          	lw	a5,-20(s0)
80008390:	10079073          	csrw	sstatus,a5
}
80008394:	00000013          	nop
80008398:	01c12403          	lw	s0,28(sp)
8000839c:	02010113          	addi	sp,sp,32
800083a0:	00008067          	ret

800083a4 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
800083a4:	fe010113          	addi	sp,sp,-32
800083a8:	00812e23          	sw	s0,28(sp)
800083ac:	02010413          	addi	s0,sp,32
800083b0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
800083b4:	fec42783          	lw	a5,-20(s0)
800083b8:	34179073          	csrw	mepc,a5
}
800083bc:	00000013          	nop
800083c0:	01c12403          	lw	s0,28(sp)
800083c4:	02010113          	addi	sp,sp,32
800083c8:	00008067          	ret

800083cc <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
800083cc:	fe010113          	addi	sp,sp,-32
800083d0:	00812e23          	sw	s0,28(sp)
800083d4:	02010413          	addi	s0,sp,32
800083d8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
800083dc:	fec42783          	lw	a5,-20(s0)
800083e0:	10579073          	csrw	stvec,a5
}
800083e4:	00000013          	nop
800083e8:	01c12403          	lw	s0,28(sp)
800083ec:	02010113          	addi	sp,sp,32
800083f0:	00008067          	ret

800083f4 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
800083f4:	fe010113          	addi	sp,sp,-32
800083f8:	00812e23          	sw	s0,28(sp)
800083fc:	02010413          	addi	s0,sp,32
80008400:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
80008404:	fec42783          	lw	a5,-20(s0)
80008408:	30379073          	csrw	mideleg,a5
}
8000840c:	00000013          	nop
80008410:	01c12403          	lw	s0,28(sp)
80008414:	02010113          	addi	sp,sp,32
80008418:	00008067          	ret

8000841c <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
8000841c:	fe010113          	addi	sp,sp,-32
80008420:	00812e23          	sw	s0,28(sp)
80008424:	02010413          	addi	s0,sp,32
80008428:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
8000842c:	fec42783          	lw	a5,-20(s0)
80008430:	30279073          	csrw	medeleg,a5
}
80008434:	00000013          	nop
80008438:	01c12403          	lw	s0,28(sp)
8000843c:	02010113          	addi	sp,sp,32
80008440:	00008067          	ret

80008444 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
80008444:	fe010113          	addi	sp,sp,-32
80008448:	00812e23          	sw	s0,28(sp)
8000844c:	02010413          	addi	s0,sp,32
80008450:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80008454:	fec42783          	lw	a5,-20(s0)
80008458:	18079073          	csrw	satp,a5
}
8000845c:	00000013          	nop
80008460:	01c12403          	lw	s0,28(sp)
80008464:	02010113          	addi	sp,sp,32
80008468:	00008067          	ret

8000846c <s_mstatus_intr>:
        break;
    }
    return x;
}

static inline void s_mstatus_intr(uint32 m){
8000846c:	fd010113          	addi	sp,sp,-48
80008470:	02112623          	sw	ra,44(sp)
80008474:	02812423          	sw	s0,40(sp)
80008478:	03010413          	addi	s0,sp,48
8000847c:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80008480:	db1ff0ef          	jal	ra,80008230 <r_mstatus>
80008484:	fea42623          	sw	a0,-20(s0)
    switch (m)
80008488:	fdc42703          	lw	a4,-36(s0)
8000848c:	08000793          	li	a5,128
80008490:	04f70263          	beq	a4,a5,800084d4 <s_mstatus_intr+0x68>
80008494:	fdc42703          	lw	a4,-36(s0)
80008498:	08000793          	li	a5,128
8000849c:	0ae7e463          	bltu	a5,a4,80008544 <s_mstatus_intr+0xd8>
800084a0:	fdc42703          	lw	a4,-36(s0)
800084a4:	02000793          	li	a5,32
800084a8:	04f70463          	beq	a4,a5,800084f0 <s_mstatus_intr+0x84>
800084ac:	fdc42703          	lw	a4,-36(s0)
800084b0:	02000793          	li	a5,32
800084b4:	08e7e863          	bltu	a5,a4,80008544 <s_mstatus_intr+0xd8>
800084b8:	fdc42703          	lw	a4,-36(s0)
800084bc:	00200793          	li	a5,2
800084c0:	06f70463          	beq	a4,a5,80008528 <s_mstatus_intr+0xbc>
800084c4:	fdc42703          	lw	a4,-36(s0)
800084c8:	00800793          	li	a5,8
800084cc:	04f70063          	beq	a4,a5,8000850c <s_mstatus_intr+0xa0>
    case INTR_SIE:
        x &= ~INTR_SIE;
        x |= INTR_SIE;
        break;
    default:
        break;
800084d0:	0740006f          	j	80008544 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
800084d4:	fec42783          	lw	a5,-20(s0)
800084d8:	f7f7f793          	andi	a5,a5,-129
800084dc:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
800084e0:	fec42783          	lw	a5,-20(s0)
800084e4:	0807e793          	ori	a5,a5,128
800084e8:	fef42623          	sw	a5,-20(s0)
        break;
800084ec:	05c0006f          	j	80008548 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800084f0:	fec42783          	lw	a5,-20(s0)
800084f4:	fdf7f793          	andi	a5,a5,-33
800084f8:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
800084fc:	fec42783          	lw	a5,-20(s0)
80008500:	0207e793          	ori	a5,a5,32
80008504:	fef42623          	sw	a5,-20(s0)
        break;
80008508:	0400006f          	j	80008548 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
8000850c:	fec42783          	lw	a5,-20(s0)
80008510:	ff77f793          	andi	a5,a5,-9
80008514:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80008518:	fec42783          	lw	a5,-20(s0)
8000851c:	0087e793          	ori	a5,a5,8
80008520:	fef42623          	sw	a5,-20(s0)
        break;
80008524:	0240006f          	j	80008548 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80008528:	fec42783          	lw	a5,-20(s0)
8000852c:	ffd7f793          	andi	a5,a5,-3
80008530:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80008534:	fec42783          	lw	a5,-20(s0)
80008538:	0027e793          	ori	a5,a5,2
8000853c:	fef42623          	sw	a5,-20(s0)
        break;
80008540:	0080006f          	j	80008548 <s_mstatus_intr+0xdc>
        break;
80008544:	00000013          	nop
    }
    w_mstatus(x);
80008548:	fec42503          	lw	a0,-20(s0)
8000854c:	d0dff0ef          	jal	ra,80008258 <w_mstatus>
}
80008550:	00000013          	nop
80008554:	02c12083          	lw	ra,44(sp)
80008558:	02812403          	lw	s0,40(sp)
8000855c:	03010113          	addi	sp,sp,48
80008560:	00008067          	ret

80008564 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
80008564:	fd010113          	addi	sp,sp,-48
80008568:	02112623          	sw	ra,44(sp)
8000856c:	02812423          	sw	s0,40(sp)
80008570:	03010413          	addi	s0,sp,48
80008574:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
80008578:	dddff0ef          	jal	ra,80008354 <r_sstatus>
8000857c:	fea42623          	sw	a0,-20(s0)
    switch (m)
80008580:	fdc42703          	lw	a4,-36(s0)
80008584:	ffd00793          	li	a5,-3
80008588:	06f70863          	beq	a4,a5,800085f8 <s_sstatus_intr+0x94>
8000858c:	fdc42703          	lw	a4,-36(s0)
80008590:	ffd00793          	li	a5,-3
80008594:	06e7e863          	bltu	a5,a4,80008604 <s_sstatus_intr+0xa0>
80008598:	fdc42703          	lw	a4,-36(s0)
8000859c:	fdf00793          	li	a5,-33
800085a0:	02f70c63          	beq	a4,a5,800085d8 <s_sstatus_intr+0x74>
800085a4:	fdc42703          	lw	a4,-36(s0)
800085a8:	fdf00793          	li	a5,-33
800085ac:	04e7ec63          	bltu	a5,a4,80008604 <s_sstatus_intr+0xa0>
800085b0:	fdc42703          	lw	a4,-36(s0)
800085b4:	00200793          	li	a5,2
800085b8:	02f70863          	beq	a4,a5,800085e8 <s_sstatus_intr+0x84>
800085bc:	fdc42703          	lw	a4,-36(s0)
800085c0:	02000793          	li	a5,32
800085c4:	04f71063          	bne	a4,a5,80008604 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
800085c8:	fec42783          	lw	a5,-20(s0)
800085cc:	0207e793          	ori	a5,a5,32
800085d0:	fef42623          	sw	a5,-20(s0)
        break;
800085d4:	0340006f          	j	80008608 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
800085d8:	fec42783          	lw	a5,-20(s0)
800085dc:	fdf7f793          	andi	a5,a5,-33
800085e0:	fef42623          	sw	a5,-20(s0)
        break;
800085e4:	0240006f          	j	80008608 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
800085e8:	fec42783          	lw	a5,-20(s0)
800085ec:	0027e793          	ori	a5,a5,2
800085f0:	fef42623          	sw	a5,-20(s0)
        break;
800085f4:	0140006f          	j	80008608 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
800085f8:	fec42783          	lw	a5,-20(s0)
800085fc:	0027f793          	andi	a5,a5,2
80008600:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
80008604:	00000013          	nop
    }
    w_sstatus(x);
80008608:	fec42503          	lw	a0,-20(s0)
8000860c:	d71ff0ef          	jal	ra,8000837c <w_sstatus>
}
80008610:	00000013          	nop
80008614:	02c12083          	lw	ra,44(sp)
80008618:	02812403          	lw	s0,40(sp)
8000861c:	03010113          	addi	sp,sp,48
80008620:	00008067          	ret

80008624 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();

void start(){
80008624:	ff010113          	addi	sp,sp,-16
80008628:	00112623          	sw	ra,12(sp)
8000862c:	00812423          	sw	s0,8(sp)
80008630:	01010413          	addi	s0,sp,16
    uartinit();
80008634:	080000ef          	jal	ra,800086b4 <uartinit>
    uartputs("Hello Los!\n");
80008638:	8000a7b7          	lui	a5,0x8000a
8000863c:	00078513          	mv	a0,a5
80008640:	168000ef          	jal	ra,800087a8 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
80008644:	00100513          	li	a0,1
80008648:	c39ff0ef          	jal	ra,80008280 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
8000864c:	00000513          	li	a0,0
80008650:	df5ff0ef          	jal	ra,80008444 <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
80008654:	000107b7          	lui	a5,0x10
80008658:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
8000865c:	d99ff0ef          	jal	ra,800083f4 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80008660:	000107b7          	lui	a5,0x10
80008664:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80008668:	db5ff0ef          	jal	ra,8000841c <w_medeleg>

    s_mstatus_intr(INTR_MPIE);  // S-mode 开全局中断
8000866c:	08000513          	li	a0,128
80008670:	dfdff0ef          	jal	ra,8000846c <s_mstatus_intr>
    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
80008674:	00200513          	li	a0,2
80008678:	eedff0ef          	jal	ra,80008564 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
8000867c:	800087b7          	lui	a5,0x80008
80008680:	12878793          	addi	a5,a5,296 # 80008128 <memend+0xf8008128>
80008684:	00078513          	mv	a0,a5
80008688:	d45ff0ef          	jal	ra,800083cc <w_stvec>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
8000868c:	800097b7          	lui	a5,0x80009
80008690:	98878793          	addi	a5,a5,-1656 # 80008988 <memend+0xf8008988>
80008694:	00078513          	mv	a0,a5
80008698:	d0dff0ef          	jal	ra,800083a4 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
8000869c:	30200073          	mret
800086a0:	00000013          	nop
800086a4:	00c12083          	lw	ra,12(sp)
800086a8:	00812403          	lw	s0,8(sp)
800086ac:	01010113          	addi	sp,sp,16
800086b0:	00008067          	ret

800086b4 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
800086b4:	fe010113          	addi	sp,sp,-32
800086b8:	00812e23          	sw	s0,28(sp)
800086bc:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800086c0:	100007b7          	lui	a5,0x10000
800086c4:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800086c8:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800086cc:	100007b7          	lui	a5,0x10000
800086d0:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800086d4:	0007c783          	lbu	a5,0(a5)
800086d8:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800086dc:	100007b7          	lui	a5,0x10000
800086e0:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800086e4:	fef44703          	lbu	a4,-17(s0)
800086e8:	f8076713          	ori	a4,a4,-128
800086ec:	0ff77713          	andi	a4,a4,255
800086f0:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
800086f4:	100007b7          	lui	a5,0x10000
800086f8:	00300713          	li	a4,3
800086fc:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
80008700:	100007b7          	lui	a5,0x10000
80008704:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80008708:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
8000870c:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80008710:	100007b7          	lui	a5,0x10000
80008714:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80008718:	fef44703          	lbu	a4,-17(s0)
8000871c:	00376713          	ori	a4,a4,3
80008720:	0ff77713          	andi	a4,a4,255
80008724:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
80008728:	100007b7          	lui	a5,0x10000
8000872c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80008730:	0007c783          	lbu	a5,0(a5)
80008734:	0ff7f713          	andi	a4,a5,255
80008738:	100007b7          	lui	a5,0x10000
8000873c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80008740:	00176713          	ori	a4,a4,1
80008744:	0ff77713          	andi	a4,a4,255
80008748:	00e78023          	sb	a4,0(a5)
}
8000874c:	00000013          	nop
80008750:	01c12403          	lw	s0,28(sp)
80008754:	02010113          	addi	sp,sp,32
80008758:	00008067          	ret

8000875c <uartputc>:

// 轮询处理数据
char uartputc(char c){
8000875c:	fe010113          	addi	sp,sp,-32
80008760:	00812e23          	sw	s0,28(sp)
80008764:	02010413          	addi	s0,sp,32
80008768:	00050793          	mv	a5,a0
8000876c:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80008770:	00000013          	nop
80008774:	100007b7          	lui	a5,0x10000
80008778:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
8000877c:	0007c783          	lbu	a5,0(a5)
80008780:	0ff7f793          	andi	a5,a5,255
80008784:	0207f793          	andi	a5,a5,32
80008788:	fe0786e3          	beqz	a5,80008774 <uartputc+0x18>
    return uart_write(UART_THR,c);
8000878c:	10000737          	lui	a4,0x10000
80008790:	fef44783          	lbu	a5,-17(s0)
80008794:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
80008798:	00078513          	mv	a0,a5
8000879c:	01c12403          	lw	s0,28(sp)
800087a0:	02010113          	addi	sp,sp,32
800087a4:	00008067          	ret

800087a8 <uartputs>:

// 发送字符串
void uartputs(char* s){
800087a8:	fe010113          	addi	sp,sp,-32
800087ac:	00112e23          	sw	ra,28(sp)
800087b0:	00812c23          	sw	s0,24(sp)
800087b4:	02010413          	addi	s0,sp,32
800087b8:	fea42623          	sw	a0,-20(s0)
    while (*s)
800087bc:	01c0006f          	j	800087d8 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
800087c0:	fec42783          	lw	a5,-20(s0)
800087c4:	00178713          	addi	a4,a5,1
800087c8:	fee42623          	sw	a4,-20(s0)
800087cc:	0007c783          	lbu	a5,0(a5)
800087d0:	00078513          	mv	a0,a5
800087d4:	f89ff0ef          	jal	ra,8000875c <uartputc>
    while (*s)
800087d8:	fec42783          	lw	a5,-20(s0)
800087dc:	0007c783          	lbu	a5,0(a5)
800087e0:	fe0790e3          	bnez	a5,800087c0 <uartputs+0x18>
    }
    
}
800087e4:	00000013          	nop
800087e8:	00000013          	nop
800087ec:	01c12083          	lw	ra,28(sp)
800087f0:	01812403          	lw	s0,24(sp)
800087f4:	02010113          	addi	sp,sp,32
800087f8:	00008067          	ret

800087fc <uartgetc>:

// 接收输入
int uartgetc(){
800087fc:	ff010113          	addi	sp,sp,-16
80008800:	00812623          	sw	s0,12(sp)
80008804:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
80008808:	100007b7          	lui	a5,0x10000
8000880c:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80008810:	0007c783          	lbu	a5,0(a5)
80008814:	0ff7f793          	andi	a5,a5,255
80008818:	0017f793          	andi	a5,a5,1
8000881c:	00078a63          	beqz	a5,80008830 <uartgetc+0x34>
        return uart_read(UART_RHR);
80008820:	100007b7          	lui	a5,0x10000
80008824:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
80008828:	0ff7f793          	andi	a5,a5,255
8000882c:	0080006f          	j	80008834 <uartgetc+0x38>
    }else{
        return -1;
80008830:	fff00793          	li	a5,-1
    }
}
80008834:	00078513          	mv	a0,a5
80008838:	00c12403          	lw	s0,12(sp)
8000883c:	01010113          	addi	sp,sp,16
80008840:	00008067          	ret

80008844 <uartintr>:

// 键盘输入中断
char uartintr(){
80008844:	ff010113          	addi	sp,sp,-16
80008848:	00112623          	sw	ra,12(sp)
8000884c:	00812423          	sw	s0,8(sp)
80008850:	01010413          	addi	s0,sp,16
    return uartgetc();
80008854:	fa9ff0ef          	jal	ra,800087fc <uartgetc>
80008858:	00050793          	mv	a5,a0
8000885c:	0ff7f793          	andi	a5,a5,255
80008860:	00078513          	mv	a0,a5
80008864:	00c12083          	lw	ra,12(sp)
80008868:	00812403          	lw	s0,8(sp)
8000886c:	01010113          	addi	sp,sp,16
80008870:	00008067          	ret

80008874 <swtch>:
 * @FilePath: /los/kernel/swtch.c
 */

#include "defs.h"

void swtch(struct context* old,struct context* new){
80008874:	fe010113          	addi	sp,sp,-32
80008878:	00812e23          	sw	s0,28(sp)
8000887c:	02010413          	addi	s0,sp,32
80008880:	fea42623          	sw	a0,-20(s0)
80008884:	feb42423          	sw	a1,-24(s0)
    // 将当前context 保存到 old context 中
    asm volatile("addi	sp,sp,32");
80008888:	02010113          	addi	sp,sp,32
    asm volatile("sw ra,0(a0)");
8000888c:	00152023          	sw	ra,0(a0)
    asm volatile("sw sp,4(a0)");
80008890:	00252223          	sw	sp,4(a0)
    asm volatile("sw gp,8(a0)");
80008894:	00352423          	sw	gp,8(a0)
    asm volatile("sw tp,12(a0)");
80008898:	00452623          	sw	tp,12(a0)
    asm volatile("sw a0,16(a0)");
8000889c:	00a52823          	sw	a0,16(a0)
    asm volatile("sw a1,20(a0)");
800088a0:	00b52a23          	sw	a1,20(a0)
    asm volatile("sw a2,24(a0)");
800088a4:	00c52c23          	sw	a2,24(a0)
    asm volatile("sw a3,28(a0)");
800088a8:	00d52e23          	sw	a3,28(a0)
    asm volatile("sw a4,32(a0)");
800088ac:	02e52023          	sw	a4,32(a0)
    asm volatile("sw a5,36(a0)");
800088b0:	02f52223          	sw	a5,36(a0)
    asm volatile("sw a6,40(a0)");
800088b4:	03052423          	sw	a6,40(a0)
    asm volatile("sw a7,44(a0)");
800088b8:	03152623          	sw	a7,44(a0)
    asm volatile("sw s0,48(a0)");
800088bc:	02852823          	sw	s0,48(a0)
    asm volatile("sw s1,52(a0)");
800088c0:	02952a23          	sw	s1,52(a0)
    asm volatile("sw s2,56(a0)");
800088c4:	03252c23          	sw	s2,56(a0)
    asm volatile("sw s3,60(a0)");
800088c8:	03352e23          	sw	s3,60(a0)
    asm volatile("sw s4,64(a0)");
800088cc:	05452023          	sw	s4,64(a0)
    asm volatile("sw s5,68(a0)");
800088d0:	05552223          	sw	s5,68(a0)
    asm volatile("sw s6,72(a0)");
800088d4:	05652423          	sw	s6,72(a0)
    asm volatile("sw s7,76(a0)");
800088d8:	05752623          	sw	s7,76(a0)
    asm volatile("sw s8,80(a0)");
800088dc:	05852823          	sw	s8,80(a0)
    asm volatile("sw s9,84(a0)");
800088e0:	05952a23          	sw	s9,84(a0)
    asm volatile("sw s10,88(a0)");
800088e4:	05a52c23          	sw	s10,88(a0)
    asm volatile("sw s11,92(a0)");
800088e8:	05b52e23          	sw	s11,92(a0)
    asm volatile("sw t0,96(a0)");
800088ec:	06552023          	sw	t0,96(a0)
    asm volatile("sw t1,100(a0)");
800088f0:	06652223          	sw	t1,100(a0)
    asm volatile("sw t2,104(a0)");
800088f4:	06752423          	sw	t2,104(a0)
    asm volatile("sw t3,108(a0)");
800088f8:	07c52623          	sw	t3,108(a0)
    asm volatile("sw t4,112(a0)");
800088fc:	07d52823          	sw	t4,112(a0)
    asm volatile("sw t5,116(a0)");
80008900:	07e52a23          	sw	t5,116(a0)
    asm volatile("sw t6,120(a0)");
80008904:	07f52c23          	sw	t6,120(a0)

    // 将 new context 加载到寄存器中
    // asm volatile("lw ra,0(a1)");
    // asm volatile("lw sp,4(a1)");
    asm volatile("lw gp,8(a1)");
80008908:	0085a183          	lw	gp,8(a1)
    asm volatile("lw tp,12(a1)");
8000890c:	00c5a203          	lw	tp,12(a1)
    asm volatile("lw a0,16(a1)");
80008910:	0105a503          	lw	a0,16(a1)
    // asm volatile("lw a1,20(a1)");
    asm volatile("lw a2,24(a1)");
80008914:	0185a603          	lw	a2,24(a1)
    asm volatile("lw a3,28(a1)");
80008918:	01c5a683          	lw	a3,28(a1)
    asm volatile("lw a4,32(a1)");
8000891c:	0205a703          	lw	a4,32(a1)
    asm volatile("lw a5,36(a1)");
80008920:	0245a783          	lw	a5,36(a1)
    asm volatile("lw a6,40(a1)");
80008924:	0285a803          	lw	a6,40(a1)
    asm volatile("lw a7,44(a1)");
80008928:	02c5a883          	lw	a7,44(a1)
    asm volatile("lw s0,48(a1)");
8000892c:	0305a403          	lw	s0,48(a1)
    asm volatile("lw s1,52(a1)");
80008930:	0345a483          	lw	s1,52(a1)
    asm volatile("lw s2,56(a1)");
80008934:	0385a903          	lw	s2,56(a1)
    asm volatile("lw s3,60(a1)");
80008938:	03c5a983          	lw	s3,60(a1)
    asm volatile("lw s4,64(a1)");
8000893c:	0405aa03          	lw	s4,64(a1)
    asm volatile("lw s5,68(a1)");
80008940:	0445aa83          	lw	s5,68(a1)
    asm volatile("lw s6,72(a1)");
80008944:	0485ab03          	lw	s6,72(a1)
    asm volatile("lw s7,76(a1)");
80008948:	04c5ab83          	lw	s7,76(a1)
    asm volatile("lw s8,80(a1)");
8000894c:	0505ac03          	lw	s8,80(a1)
    asm volatile("lw s9,84(a1)");
80008950:	0545ac83          	lw	s9,84(a1)
    asm volatile("lw s10,88(a1)");
80008954:	0585ad03          	lw	s10,88(a1)
    asm volatile("lw s11,92(a1)");
80008958:	05c5ad83          	lw	s11,92(a1)
    asm volatile("lw t0,96(a1)");
8000895c:	0605a283          	lw	t0,96(a1)
    asm volatile("lw t1,100(a1)");
80008960:	0645a303          	lw	t1,100(a1)
    asm volatile("lw t2,104(a1)");
80008964:	0685a383          	lw	t2,104(a1)
    asm volatile("lw t3,108(a1)");
80008968:	06c5ae03          	lw	t3,108(a1)
    asm volatile("lw t4,112(a1)");
8000896c:	0705ae83          	lw	t4,112(a1)
    asm volatile("lw t5,116(a1)");
80008970:	0745af03          	lw	t5,116(a1)
    asm volatile("lw t6,120(a1)");
80008974:	0785af83          	lw	t6,120(a1)
    
80008978:	00000013          	nop
8000897c:	01c12403          	lw	s0,28(sp)
80008980:	02010113          	addi	sp,sp,32
80008984:	00008067          	ret

80008988 <main>:
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"

void main(){
80008988:	ff010113          	addi	sp,sp,-16
8000898c:	00112623          	sw	ra,12(sp)
80008990:	00812423          	sw	s0,8(sp)
80008994:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
80008998:	8000a7b7          	lui	a5,0x8000a
8000899c:	00c78513          	addi	a0,a5,12 # 8000a00c <memend+0xf800a00c>
800089a0:	2b4000ef          	jal	ra,80008c54 <printf>
    minit();
800089a4:	728000ef          	jal	ra,800090cc <minit>
    plicinit();
800089a8:	0c5000ef          	jal	ra,8000926c <plicinit>

    while(1);
800089ac:	0000006f          	j	800089ac <main+0x24>

800089b0 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
800089b0:	fe010113          	addi	sp,sp,-32
800089b4:	00812e23          	sw	s0,28(sp)
800089b8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
800089bc:	142027f3          	csrr	a5,scause
800089c0:	fef42623          	sw	a5,-20(s0)
    return x;
800089c4:	fec42783          	lw	a5,-20(s0)
}
800089c8:	00078513          	mv	a0,a5
800089cc:	01c12403          	lw	s0,28(sp)
800089d0:	02010113          	addi	sp,sp,32
800089d4:	00008067          	ret

800089d8 <externinterrupt>:
#include "plic.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
800089d8:	fe010113          	addi	sp,sp,-32
800089dc:	00112e23          	sw	ra,28(sp)
800089e0:	00812c23          	sw	s0,24(sp)
800089e4:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
800089e8:	149000ef          	jal	ra,80009330 <r_plicclaim>
800089ec:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
800089f0:	fec42583          	lw	a1,-20(s0)
800089f4:	8000a7b7          	lui	a5,0x8000a
800089f8:	02078513          	addi	a0,a5,32 # 8000a020 <memend+0xf800a020>
800089fc:	258000ef          	jal	ra,80008c54 <printf>
    switch (irq)
80008a00:	fec42703          	lw	a4,-20(s0)
80008a04:	00a00793          	li	a5,10
80008a08:	02f71063          	bne	a4,a5,80008a28 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80008a0c:	e39ff0ef          	jal	ra,80008844 <uartintr>
80008a10:	00050793          	mv	a5,a0
80008a14:	00078593          	mv	a1,a5
80008a18:	8000a7b7          	lui	a5,0x8000a
80008a1c:	02c78513          	addi	a0,a5,44 # 8000a02c <memend+0xf800a02c>
80008a20:	234000ef          	jal	ra,80008c54 <printf>
        break;
80008a24:	0080006f          	j	80008a2c <externinterrupt+0x54>
    default:
        break;
80008a28:	00000013          	nop
    }
    w_pliccomplete(irq);
80008a2c:	fec42503          	lw	a0,-20(s0)
80008a30:	141000ef          	jal	ra,80009370 <w_pliccomplete>
}
80008a34:	00000013          	nop
80008a38:	01c12083          	lw	ra,28(sp)
80008a3c:	01812403          	lw	s0,24(sp)
80008a40:	02010113          	addi	sp,sp,32
80008a44:	00008067          	ret

80008a48 <trapvec>:

void trapvec(){
80008a48:	fe010113          	addi	sp,sp,-32
80008a4c:	00112e23          	sw	ra,28(sp)
80008a50:	00812c23          	sw	s0,24(sp)
80008a54:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80008a58:	f59ff0ef          	jal	ra,800089b0 <r_scause>
80008a5c:	fea42623          	sw	a0,-20(s0)

    uint16 code= scause & 0xffff;
80008a60:	fec42783          	lw	a5,-20(s0)
80008a64:	fef41523          	sh	a5,-22(s0)

    if(scause & (1<<31)){
80008a68:	fec42783          	lw	a5,-20(s0)
80008a6c:	0607de63          	bgez	a5,80008ae8 <trapvec+0xa0>
        printf("Interrupt : ");
80008a70:	8000a7b7          	lui	a5,0x8000a
80008a74:	03c78513          	addi	a0,a5,60 # 8000a03c <memend+0xf800a03c>
80008a78:	1dc000ef          	jal	ra,80008c54 <printf>
        switch (code)
80008a7c:	fea45783          	lhu	a5,-22(s0)
80008a80:	00900713          	li	a4,9
80008a84:	04e78063          	beq	a5,a4,80008ac4 <trapvec+0x7c>
80008a88:	00900713          	li	a4,9
80008a8c:	04f74663          	blt	a4,a5,80008ad8 <trapvec+0x90>
80008a90:	00100713          	li	a4,1
80008a94:	00e78863          	beq	a5,a4,80008aa4 <trapvec+0x5c>
80008a98:	00500713          	li	a4,5
80008a9c:	00e78c63          	beq	a5,a4,80008ab4 <trapvec+0x6c>
80008aa0:	0380006f          	j	80008ad8 <trapvec+0x90>
        {
        case 1:
            printf("Supervisor software interrupt\n");
80008aa4:	8000a7b7          	lui	a5,0x8000a
80008aa8:	04c78513          	addi	a0,a5,76 # 8000a04c <memend+0xf800a04c>
80008aac:	1a8000ef          	jal	ra,80008c54 <printf>
            break;
80008ab0:	1580006f          	j	80008c08 <trapvec+0x1c0>
        case 5:
            printf("Supervisor timer interrupt\n");
80008ab4:	8000a7b7          	lui	a5,0x8000a
80008ab8:	06c78513          	addi	a0,a5,108 # 8000a06c <memend+0xf800a06c>
80008abc:	198000ef          	jal	ra,80008c54 <printf>
            break;
80008ac0:	1480006f          	j	80008c08 <trapvec+0x1c0>
        case 9:
            printf("Supervisor external interrupt\n");
80008ac4:	8000a7b7          	lui	a5,0x8000a
80008ac8:	08878513          	addi	a0,a5,136 # 8000a088 <memend+0xf800a088>
80008acc:	188000ef          	jal	ra,80008c54 <printf>
            externinterrupt();
80008ad0:	f09ff0ef          	jal	ra,800089d8 <externinterrupt>
            break;
80008ad4:	1340006f          	j	80008c08 <trapvec+0x1c0>
        default:
            printf("Other interrupt\n");
80008ad8:	8000a7b7          	lui	a5,0x8000a
80008adc:	0a878513          	addi	a0,a5,168 # 8000a0a8 <memend+0xf800a0a8>
80008ae0:	174000ef          	jal	ra,80008c54 <printf>
            break;
80008ae4:	1240006f          	j	80008c08 <trapvec+0x1c0>
        }
    }else{
        printf("Exception : ");
80008ae8:	8000a7b7          	lui	a5,0x8000a
80008aec:	0bc78513          	addi	a0,a5,188 # 8000a0bc <memend+0xf800a0bc>
80008af0:	164000ef          	jal	ra,80008c54 <printf>
        switch (code)
80008af4:	fea45783          	lhu	a5,-22(s0)
80008af8:	00f00713          	li	a4,15
80008afc:	0ef76663          	bltu	a4,a5,80008be8 <trapvec+0x1a0>
80008b00:	00279713          	slli	a4,a5,0x2
80008b04:	8000a7b7          	lui	a5,0x8000a
80008b08:	23078793          	addi	a5,a5,560 # 8000a230 <memend+0xf800a230>
80008b0c:	00f707b3          	add	a5,a4,a5
80008b10:	0007a783          	lw	a5,0(a5)
80008b14:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80008b18:	8000a7b7          	lui	a5,0x8000a
80008b1c:	0cc78513          	addi	a0,a5,204 # 8000a0cc <memend+0xf800a0cc>
80008b20:	134000ef          	jal	ra,80008c54 <printf>
            break;
80008b24:	0d40006f          	j	80008bf8 <trapvec+0x1b0>
        case 1:
            printf("Instruction access fault\n");
80008b28:	8000a7b7          	lui	a5,0x8000a
80008b2c:	0ec78513          	addi	a0,a5,236 # 8000a0ec <memend+0xf800a0ec>
80008b30:	124000ef          	jal	ra,80008c54 <printf>
            break;
80008b34:	0c40006f          	j	80008bf8 <trapvec+0x1b0>
        case 2:
            printf("Illegal instruction\n");
80008b38:	8000a7b7          	lui	a5,0x8000a
80008b3c:	10878513          	addi	a0,a5,264 # 8000a108 <memend+0xf800a108>
80008b40:	114000ef          	jal	ra,80008c54 <printf>
            break;
80008b44:	0b40006f          	j	80008bf8 <trapvec+0x1b0>
        case 3:
            printf("Breakpoint\n");
80008b48:	8000a7b7          	lui	a5,0x8000a
80008b4c:	12078513          	addi	a0,a5,288 # 8000a120 <memend+0xf800a120>
80008b50:	104000ef          	jal	ra,80008c54 <printf>
            break;
80008b54:	0a40006f          	j	80008bf8 <trapvec+0x1b0>
        case 4:
            printf("Load address misaligned\n");
80008b58:	8000a7b7          	lui	a5,0x8000a
80008b5c:	12c78513          	addi	a0,a5,300 # 8000a12c <memend+0xf800a12c>
80008b60:	0f4000ef          	jal	ra,80008c54 <printf>
            break;
80008b64:	0940006f          	j	80008bf8 <trapvec+0x1b0>
        case 5:
            printf("Load access fault\n");
80008b68:	8000a7b7          	lui	a5,0x8000a
80008b6c:	14878513          	addi	a0,a5,328 # 8000a148 <memend+0xf800a148>
80008b70:	0e4000ef          	jal	ra,80008c54 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80008b74:	0840006f          	j	80008bf8 <trapvec+0x1b0>
        case 6:
            printf("Store/AMO address misaligned\n");
80008b78:	8000a7b7          	lui	a5,0x8000a
80008b7c:	15c78513          	addi	a0,a5,348 # 8000a15c <memend+0xf800a15c>
80008b80:	0d4000ef          	jal	ra,80008c54 <printf>
            break;
80008b84:	0740006f          	j	80008bf8 <trapvec+0x1b0>
        case 7:
            printf("Store/AMO access fault\n");
80008b88:	8000a7b7          	lui	a5,0x8000a
80008b8c:	17c78513          	addi	a0,a5,380 # 8000a17c <memend+0xf800a17c>
80008b90:	0c4000ef          	jal	ra,80008c54 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80008b94:	0640006f          	j	80008bf8 <trapvec+0x1b0>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80008b98:	8000a7b7          	lui	a5,0x8000a
80008b9c:	19478513          	addi	a0,a5,404 # 8000a194 <memend+0xf800a194>
80008ba0:	0b4000ef          	jal	ra,80008c54 <printf>
            break;
80008ba4:	0540006f          	j	80008bf8 <trapvec+0x1b0>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80008ba8:	8000a7b7          	lui	a5,0x8000a
80008bac:	1b478513          	addi	a0,a5,436 # 8000a1b4 <memend+0xf800a1b4>
80008bb0:	0a4000ef          	jal	ra,80008c54 <printf>
            break;
80008bb4:	0440006f          	j	80008bf8 <trapvec+0x1b0>
        case 12:
            printf("Instruction page fault\n");
80008bb8:	8000a7b7          	lui	a5,0x8000a
80008bbc:	1d478513          	addi	a0,a5,468 # 8000a1d4 <memend+0xf800a1d4>
80008bc0:	094000ef          	jal	ra,80008c54 <printf>
            break;
80008bc4:	0340006f          	j	80008bf8 <trapvec+0x1b0>
        case 13:
            printf("Load page fault\n");
80008bc8:	8000a7b7          	lui	a5,0x8000a
80008bcc:	1ec78513          	addi	a0,a5,492 # 8000a1ec <memend+0xf800a1ec>
80008bd0:	084000ef          	jal	ra,80008c54 <printf>
            break;
80008bd4:	0240006f          	j	80008bf8 <trapvec+0x1b0>
        case 15:
            printf("Store/AMO page fault\n");
80008bd8:	8000a7b7          	lui	a5,0x8000a
80008bdc:	20078513          	addi	a0,a5,512 # 8000a200 <memend+0xf800a200>
80008be0:	074000ef          	jal	ra,80008c54 <printf>
            break;
80008be4:	0140006f          	j	80008bf8 <trapvec+0x1b0>
        default:
            printf("Other\n");
80008be8:	8000a7b7          	lui	a5,0x8000a
80008bec:	21878513          	addi	a0,a5,536 # 8000a218 <memend+0xf800a218>
80008bf0:	064000ef          	jal	ra,80008c54 <printf>
            break;
80008bf4:	00000013          	nop
        }
        panic("Trap Exception");
80008bf8:	8000a7b7          	lui	a5,0x8000a
80008bfc:	22078513          	addi	a0,a5,544 # 8000a220 <memend+0xf800a220>
80008c00:	01c000ef          	jal	ra,80008c1c <panic>
    }
}
80008c04:	00000013          	nop
80008c08:	00000013          	nop
80008c0c:	01c12083          	lw	ra,28(sp)
80008c10:	01812403          	lw	s0,24(sp)
80008c14:	02010113          	addi	sp,sp,32
80008c18:	00008067          	ret

80008c1c <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80008c1c:	fe010113          	addi	sp,sp,-32
80008c20:	00112e23          	sw	ra,28(sp)
80008c24:	00812c23          	sw	s0,24(sp)
80008c28:	02010413          	addi	s0,sp,32
80008c2c:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80008c30:	8000a7b7          	lui	a5,0x8000a
80008c34:	27078513          	addi	a0,a5,624 # 8000a270 <memend+0xf800a270>
80008c38:	b71ff0ef          	jal	ra,800087a8 <uartputs>
    uartputs(s);
80008c3c:	fec42503          	lw	a0,-20(s0)
80008c40:	b69ff0ef          	jal	ra,800087a8 <uartputs>
	uartputs("\n");
80008c44:	8000a7b7          	lui	a5,0x8000a
80008c48:	27878513          	addi	a0,a5,632 # 8000a278 <memend+0xf800a278>
80008c4c:	b5dff0ef          	jal	ra,800087a8 <uartputs>
    while(1);
80008c50:	0000006f          	j	80008c50 <panic+0x34>

80008c54 <printf>:
}

static char outbuf[1024];
// # 简易版 printf
// ! 未处理异常
int printf(const char* fmt,...){
80008c54:	f8010113          	addi	sp,sp,-128
80008c58:	04112e23          	sw	ra,92(sp)
80008c5c:	04812c23          	sw	s0,88(sp)
80008c60:	06010413          	addi	s0,sp,96
80008c64:	faa42623          	sw	a0,-84(s0)
80008c68:	00b42223          	sw	a1,4(s0)
80008c6c:	00c42423          	sw	a2,8(s0)
80008c70:	00d42623          	sw	a3,12(s0)
80008c74:	00e42823          	sw	a4,16(s0)
80008c78:	00f42a23          	sw	a5,20(s0)
80008c7c:	01042c23          	sw	a6,24(s0)
80008c80:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80008c84:	02040793          	addi	a5,s0,32
80008c88:	faf42423          	sw	a5,-88(s0)
80008c8c:	fa842783          	lw	a5,-88(s0)
80008c90:	fe478793          	addi	a5,a5,-28
80008c94:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80008c98:	fac42783          	lw	a5,-84(s0)
80008c9c:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80008ca0:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80008ca4:	fe042223          	sw	zero,-28(s0)
	while(ch=*(s)){
80008ca8:	36c0006f          	j	80009014 <printf+0x3c0>
		if(ch=='%'){
80008cac:	fbf44703          	lbu	a4,-65(s0)
80008cb0:	02500793          	li	a5,37
80008cb4:	04f71863          	bne	a4,a5,80008d04 <printf+0xb0>
			if(tt==1){
80008cb8:	fe842703          	lw	a4,-24(s0)
80008cbc:	00100793          	li	a5,1
80008cc0:	02f71663          	bne	a4,a5,80008cec <printf+0x98>
				outbuf[idx++]='%';
80008cc4:	fe442783          	lw	a5,-28(s0)
80008cc8:	00178713          	addi	a4,a5,1
80008ccc:	fee42223          	sw	a4,-28(s0)
80008cd0:	8000b737          	lui	a4,0x8000b
80008cd4:	00070713          	mv	a4,a4
80008cd8:	00f707b3          	add	a5,a4,a5
80008cdc:	02500713          	li	a4,37
80008ce0:	00e78023          	sb	a4,0(a5)
				tt=0;
80008ce4:	fe042423          	sw	zero,-24(s0)
80008ce8:	00c0006f          	j	80008cf4 <printf+0xa0>
			}else{
				tt=1;
80008cec:	00100793          	li	a5,1
80008cf0:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80008cf4:	fec42783          	lw	a5,-20(s0)
80008cf8:	00178793          	addi	a5,a5,1
80008cfc:	fef42623          	sw	a5,-20(s0)
80008d00:	3140006f          	j	80009014 <printf+0x3c0>
		}else{
			if(tt==1){
80008d04:	fe842703          	lw	a4,-24(s0)
80008d08:	00100793          	li	a5,1
80008d0c:	2cf71e63          	bne	a4,a5,80008fe8 <printf+0x394>
				switch (ch)
80008d10:	fbf44783          	lbu	a5,-65(s0)
80008d14:	fa878793          	addi	a5,a5,-88
80008d18:	02000713          	li	a4,32
80008d1c:	2af76663          	bltu	a4,a5,80008fc8 <printf+0x374>
80008d20:	00279713          	slli	a4,a5,0x2
80008d24:	8000a7b7          	lui	a5,0x8000a
80008d28:	29478793          	addi	a5,a5,660 # 8000a294 <memend+0xf800a294>
80008d2c:	00f707b3          	add	a5,a4,a5
80008d30:	0007a783          	lw	a5,0(a5)
80008d34:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80008d38:	fb842783          	lw	a5,-72(s0)
80008d3c:	00478713          	addi	a4,a5,4
80008d40:	fae42c23          	sw	a4,-72(s0)
80008d44:	0007a783          	lw	a5,0(a5)
80008d48:	fef42023          	sw	a5,-32(s0)
					int len=0;
80008d4c:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80008d50:	fe042783          	lw	a5,-32(s0)
80008d54:	fcf42c23          	sw	a5,-40(s0)
80008d58:	0100006f          	j	80008d68 <printf+0x114>
80008d5c:	fdc42783          	lw	a5,-36(s0)
80008d60:	00178793          	addi	a5,a5,1
80008d64:	fcf42e23          	sw	a5,-36(s0)
80008d68:	fd842703          	lw	a4,-40(s0)
80008d6c:	00a00793          	li	a5,10
80008d70:	02f747b3          	div	a5,a4,a5
80008d74:	fcf42c23          	sw	a5,-40(s0)
80008d78:	fd842783          	lw	a5,-40(s0)
80008d7c:	fe0790e3          	bnez	a5,80008d5c <printf+0x108>
					for(int i=len;i>=0;i--){
80008d80:	fdc42783          	lw	a5,-36(s0)
80008d84:	fcf42a23          	sw	a5,-44(s0)
80008d88:	0540006f          	j	80008ddc <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80008d8c:	fe042703          	lw	a4,-32(s0)
80008d90:	00a00793          	li	a5,10
80008d94:	02f767b3          	rem	a5,a4,a5
80008d98:	0ff7f713          	andi	a4,a5,255
80008d9c:	fe442683          	lw	a3,-28(s0)
80008da0:	fd442783          	lw	a5,-44(s0)
80008da4:	00f687b3          	add	a5,a3,a5
80008da8:	03070713          	addi	a4,a4,48 # 8000b030 <memend+0xf800b030>
80008dac:	0ff77713          	andi	a4,a4,255
80008db0:	8000b6b7          	lui	a3,0x8000b
80008db4:	00068693          	mv	a3,a3
80008db8:	00f687b3          	add	a5,a3,a5
80008dbc:	00e78023          	sb	a4,0(a5)
						x/=10;
80008dc0:	fe042703          	lw	a4,-32(s0)
80008dc4:	00a00793          	li	a5,10
80008dc8:	02f747b3          	div	a5,a4,a5
80008dcc:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80008dd0:	fd442783          	lw	a5,-44(s0)
80008dd4:	fff78793          	addi	a5,a5,-1
80008dd8:	fcf42a23          	sw	a5,-44(s0)
80008ddc:	fd442783          	lw	a5,-44(s0)
80008de0:	fa07d6e3          	bgez	a5,80008d8c <printf+0x138>
					}
					idx+=(len+1);
80008de4:	fdc42783          	lw	a5,-36(s0)
80008de8:	00178793          	addi	a5,a5,1
80008dec:	fe442703          	lw	a4,-28(s0)
80008df0:	00f707b3          	add	a5,a4,a5
80008df4:	fef42223          	sw	a5,-28(s0)
					tt=0;
80008df8:	fe042423          	sw	zero,-24(s0)
					break;
80008dfc:	1dc0006f          	j	80008fd8 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80008e00:	fe442783          	lw	a5,-28(s0)
80008e04:	00178713          	addi	a4,a5,1
80008e08:	fee42223          	sw	a4,-28(s0)
80008e0c:	8000b737          	lui	a4,0x8000b
80008e10:	00070713          	mv	a4,a4
80008e14:	00f707b3          	add	a5,a4,a5
80008e18:	03000713          	li	a4,48
80008e1c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80008e20:	fe442783          	lw	a5,-28(s0)
80008e24:	00178713          	addi	a4,a5,1
80008e28:	fee42223          	sw	a4,-28(s0)
80008e2c:	8000b737          	lui	a4,0x8000b
80008e30:	00070713          	mv	a4,a4
80008e34:	00f707b3          	add	a5,a4,a5
80008e38:	07800713          	li	a4,120
80008e3c:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80008e40:	fb842783          	lw	a5,-72(s0)
80008e44:	00478713          	addi	a4,a5,4
80008e48:	fae42c23          	sw	a4,-72(s0)
80008e4c:	0007a783          	lw	a5,0(a5)
80008e50:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80008e54:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80008e58:	fd042783          	lw	a5,-48(s0)
80008e5c:	fcf42423          	sw	a5,-56(s0)
80008e60:	0100006f          	j	80008e70 <printf+0x21c>
80008e64:	fcc42783          	lw	a5,-52(s0)
80008e68:	00178793          	addi	a5,a5,1
80008e6c:	fcf42623          	sw	a5,-52(s0)
80008e70:	fc842783          	lw	a5,-56(s0)
80008e74:	0047d793          	srli	a5,a5,0x4
80008e78:	fcf42423          	sw	a5,-56(s0)
80008e7c:	fc842783          	lw	a5,-56(s0)
80008e80:	fe0792e3          	bnez	a5,80008e64 <printf+0x210>
					for(int i=len;i>=0;i--){
80008e84:	fcc42783          	lw	a5,-52(s0)
80008e88:	fcf42223          	sw	a5,-60(s0)
80008e8c:	0840006f          	j	80008f10 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80008e90:	fd042783          	lw	a5,-48(s0)
80008e94:	00f7f713          	andi	a4,a5,15
80008e98:	00900793          	li	a5,9
80008e9c:	02e7f063          	bgeu	a5,a4,80008ebc <printf+0x268>
80008ea0:	fd042783          	lw	a5,-48(s0)
80008ea4:	0ff7f793          	andi	a5,a5,255
80008ea8:	00f7f793          	andi	a5,a5,15
80008eac:	0ff7f793          	andi	a5,a5,255
80008eb0:	05778793          	addi	a5,a5,87
80008eb4:	0ff7f793          	andi	a5,a5,255
80008eb8:	01c0006f          	j	80008ed4 <printf+0x280>
80008ebc:	fd042783          	lw	a5,-48(s0)
80008ec0:	0ff7f793          	andi	a5,a5,255
80008ec4:	00f7f793          	andi	a5,a5,15
80008ec8:	0ff7f793          	andi	a5,a5,255
80008ecc:	03078793          	addi	a5,a5,48
80008ed0:	0ff7f793          	andi	a5,a5,255
80008ed4:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80008ed8:	fe442703          	lw	a4,-28(s0)
80008edc:	fc442783          	lw	a5,-60(s0)
80008ee0:	00f707b3          	add	a5,a4,a5
80008ee4:	8000b737          	lui	a4,0x8000b
80008ee8:	00070713          	mv	a4,a4
80008eec:	00f707b3          	add	a5,a4,a5
80008ef0:	fbe44703          	lbu	a4,-66(s0)
80008ef4:	00e78023          	sb	a4,0(a5)
						x/=16;
80008ef8:	fd042783          	lw	a5,-48(s0)
80008efc:	0047d793          	srli	a5,a5,0x4
80008f00:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80008f04:	fc442783          	lw	a5,-60(s0)
80008f08:	fff78793          	addi	a5,a5,-1
80008f0c:	fcf42223          	sw	a5,-60(s0)
80008f10:	fc442783          	lw	a5,-60(s0)
80008f14:	f607dee3          	bgez	a5,80008e90 <printf+0x23c>
					}
					idx+=(len+1);
80008f18:	fcc42783          	lw	a5,-52(s0)
80008f1c:	00178793          	addi	a5,a5,1
80008f20:	fe442703          	lw	a4,-28(s0)
80008f24:	00f707b3          	add	a5,a4,a5
80008f28:	fef42223          	sw	a5,-28(s0)
					tt=0;
80008f2c:	fe042423          	sw	zero,-24(s0)
					break;
80008f30:	0a80006f          	j	80008fd8 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80008f34:	fb842783          	lw	a5,-72(s0)
80008f38:	00478713          	addi	a4,a5,4
80008f3c:	fae42c23          	sw	a4,-72(s0)
80008f40:	0007a783          	lw	a5,0(a5)
80008f44:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80008f48:	fe442783          	lw	a5,-28(s0)
80008f4c:	00178713          	addi	a4,a5,1
80008f50:	fee42223          	sw	a4,-28(s0)
80008f54:	8000b737          	lui	a4,0x8000b
80008f58:	00070713          	mv	a4,a4
80008f5c:	00f707b3          	add	a5,a4,a5
80008f60:	fbf44703          	lbu	a4,-65(s0)
80008f64:	00e78023          	sb	a4,0(a5)
					tt=0;
80008f68:	fe042423          	sw	zero,-24(s0)
					break;
80008f6c:	06c0006f          	j	80008fd8 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80008f70:	fb842783          	lw	a5,-72(s0)
80008f74:	00478713          	addi	a4,a5,4
80008f78:	fae42c23          	sw	a4,-72(s0)
80008f7c:	0007a783          	lw	a5,0(a5)
80008f80:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80008f84:	0300006f          	j	80008fb4 <printf+0x360>
						outbuf[idx++]=*ss++;
80008f88:	fc042703          	lw	a4,-64(s0)
80008f8c:	00170793          	addi	a5,a4,1 # 8000b001 <memend+0xf800b001>
80008f90:	fcf42023          	sw	a5,-64(s0)
80008f94:	fe442783          	lw	a5,-28(s0)
80008f98:	00178693          	addi	a3,a5,1
80008f9c:	fed42223          	sw	a3,-28(s0)
80008fa0:	00074703          	lbu	a4,0(a4)
80008fa4:	8000b6b7          	lui	a3,0x8000b
80008fa8:	00068693          	mv	a3,a3
80008fac:	00f687b3          	add	a5,a3,a5
80008fb0:	00e78023          	sb	a4,0(a5)
					while(*ss){
80008fb4:	fc042783          	lw	a5,-64(s0)
80008fb8:	0007c783          	lbu	a5,0(a5)
80008fbc:	fc0796e3          	bnez	a5,80008f88 <printf+0x334>
					}
					tt=0;
80008fc0:	fe042423          	sw	zero,-24(s0)
					break;
80008fc4:	0140006f          	j	80008fd8 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80008fc8:	8000a7b7          	lui	a5,0x8000a
80008fcc:	27c78513          	addi	a0,a5,636 # 8000a27c <memend+0xf800a27c>
80008fd0:	c4dff0ef          	jal	ra,80008c1c <panic>
					break;
80008fd4:	00000013          	nop
				}
				s++;
80008fd8:	fec42783          	lw	a5,-20(s0)
80008fdc:	00178793          	addi	a5,a5,1
80008fe0:	fef42623          	sw	a5,-20(s0)
80008fe4:	0300006f          	j	80009014 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80008fe8:	fe442783          	lw	a5,-28(s0)
80008fec:	00178713          	addi	a4,a5,1
80008ff0:	fee42223          	sw	a4,-28(s0)
80008ff4:	8000b737          	lui	a4,0x8000b
80008ff8:	00070713          	mv	a4,a4
80008ffc:	00f707b3          	add	a5,a4,a5
80009000:	fbf44703          	lbu	a4,-65(s0)
80009004:	00e78023          	sb	a4,0(a5)
				s++;
80009008:	fec42783          	lw	a5,-20(s0)
8000900c:	00178793          	addi	a5,a5,1
80009010:	fef42623          	sw	a5,-20(s0)
	while(ch=*(s)){
80009014:	fec42783          	lw	a5,-20(s0)
80009018:	0007c783          	lbu	a5,0(a5)
8000901c:	faf40fa3          	sb	a5,-65(s0)
80009020:	fbf44783          	lbu	a5,-65(s0)
80009024:	c80794e3          	bnez	a5,80008cac <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80009028:	8000b7b7          	lui	a5,0x8000b
8000902c:	00078713          	mv	a4,a5
80009030:	fe442783          	lw	a5,-28(s0)
80009034:	00f707b3          	add	a5,a4,a5
80009038:	00078023          	sb	zero,0(a5) # 8000b000 <memend+0xf800b000>
	uartputs(outbuf);
8000903c:	8000b7b7          	lui	a5,0x8000b
80009040:	00078513          	mv	a0,a5
80009044:	f64ff0ef          	jal	ra,800087a8 <uartputs>
80009048:	00000013          	nop
8000904c:	00078513          	mv	a0,a5
80009050:	05c12083          	lw	ra,92(sp)
80009054:	05812403          	lw	s0,88(sp)
80009058:	08010113          	addi	sp,sp,128
8000905c:	00008067          	ret

80009060 <memset>:
extern uint8 pstart[];
extern uint8 pend[];
extern uint8 memstart[];
extern uint8 memend[];

void* memset(void* addr,int c,uint n){
80009060:	fd010113          	addi	sp,sp,-48
80009064:	02812623          	sw	s0,44(sp)
80009068:	03010413          	addi	s0,sp,48
8000906c:	fca42e23          	sw	a0,-36(s0)
80009070:	fcb42c23          	sw	a1,-40(s0)
80009074:	fcc42a23          	sw	a2,-44(s0)
    char* maddr=(char*)addr;
80009078:	fdc42783          	lw	a5,-36(s0)
8000907c:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80009080:	fe042623          	sw	zero,-20(s0)
80009084:	0280006f          	j	800090ac <memset+0x4c>
        maddr[i]=(char)c;
80009088:	fe842703          	lw	a4,-24(s0)
8000908c:	fec42783          	lw	a5,-20(s0)
80009090:	00f707b3          	add	a5,a4,a5
80009094:	fd842703          	lw	a4,-40(s0)
80009098:	0ff77713          	andi	a4,a4,255
8000909c:	00e78023          	sb	a4,0(a5) # 8000b000 <memend+0xf800b000>
    for(uint i=0;i<n;i++){
800090a0:	fec42783          	lw	a5,-20(s0)
800090a4:	00178793          	addi	a5,a5,1
800090a8:	fef42623          	sw	a5,-20(s0)
800090ac:	fec42703          	lw	a4,-20(s0)
800090b0:	fd442783          	lw	a5,-44(s0)
800090b4:	fcf76ae3          	bltu	a4,a5,80009088 <memset+0x28>
    }
    return addr;
800090b8:	fdc42783          	lw	a5,-36(s0)
}
800090bc:	00078513          	mv	a0,a5
800090c0:	02c12403          	lw	s0,44(sp)
800090c4:	03010113          	addi	sp,sp,48
800090c8:	00008067          	ret

800090cc <minit>:

void minit(){
800090cc:	fe010113          	addi	sp,sp,-32
800090d0:	00812e23          	sw	s0,28(sp)
800090d4:	02010413          	addi	s0,sp,32
    // uint32* te=textend;
    // uint32* re=rodataend;
    // uint32* de=dataend;
    // uint32* be=bssend;
    // uint8* me=memend;
    char* p=(char*)pstart;
800090d8:	8000c7b7          	lui	a5,0x8000c
800090dc:	00078793          	mv	a5,a5
800090e0:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)pend ; p+=PGSIZE){
800090e4:	0380006f          	j	8000911c <minit+0x50>
        m=(struct pmp*)p;
800090e8:	fec42783          	lw	a5,-20(s0)
800090ec:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
800090f0:	8000b7b7          	lui	a5,0x8000b
800090f4:	4007a703          	lw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
800090f8:	fe842783          	lw	a5,-24(s0)
800090fc:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
80009100:	8000b7b7          	lui	a5,0x8000b
80009104:	fe842703          	lw	a4,-24(s0)
80009108:	40e7a023          	sw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
    for( ; p + PGSIZE <= (char*)pend ; p+=PGSIZE){
8000910c:	fec42703          	lw	a4,-20(s0)
80009110:	000017b7          	lui	a5,0x1
80009114:	00f707b3          	add	a5,a4,a5
80009118:	fef42623          	sw	a5,-20(s0)
8000911c:	fec42703          	lw	a4,-20(s0)
80009120:	000017b7          	lui	a5,0x1
80009124:	00f70733          	add	a4,a4,a5
80009128:	880007b7          	lui	a5,0x88000
8000912c:	00078793          	mv	a5,a5
80009130:	fae7fce3          	bgeu	a5,a4,800090e8 <minit+0x1c>
    }
}
80009134:	00000013          	nop
80009138:	00000013          	nop
8000913c:	01c12403          	lw	s0,28(sp)
80009140:	02010113          	addi	sp,sp,32
80009144:	00008067          	ret

80009148 <palloc>:

void* palloc(){
80009148:	fe010113          	addi	sp,sp,-32
8000914c:	00112e23          	sw	ra,28(sp)
80009150:	00812c23          	sw	s0,24(sp)
80009154:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80009158:	8000b7b7          	lui	a5,0x8000b
8000915c:	4007a783          	lw	a5,1024(a5) # 8000b400 <memend+0xf800b400>
80009160:	fef42623          	sw	a5,-20(s0)
    if(p)
80009164:	fec42783          	lw	a5,-20(s0)
80009168:	00078c63          	beqz	a5,80009180 <palloc+0x38>
        mem.freelist=mem.freelist->next;
8000916c:	8000b7b7          	lui	a5,0x8000b
80009170:	4007a783          	lw	a5,1024(a5) # 8000b400 <memend+0xf800b400>
80009174:	0007a703          	lw	a4,0(a5)
80009178:	8000b7b7          	lui	a5,0x8000b
8000917c:	40e7a023          	sw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
    if(p)
80009180:	fec42783          	lw	a5,-20(s0)
80009184:	00078a63          	beqz	a5,80009198 <palloc+0x50>
        memset(p,0,PGSIZE);
80009188:	00001637          	lui	a2,0x1
8000918c:	00000593          	li	a1,0
80009190:	fec42503          	lw	a0,-20(s0)
80009194:	ecdff0ef          	jal	ra,80009060 <memset>
    return (void*)p;
80009198:	fec42783          	lw	a5,-20(s0)
}
8000919c:	00078513          	mv	a0,a5
800091a0:	01c12083          	lw	ra,28(sp)
800091a4:	01812403          	lw	s0,24(sp)
800091a8:	02010113          	addi	sp,sp,32
800091ac:	00008067          	ret

800091b0 <pfree>:

void pfree(void* addr){
800091b0:	fd010113          	addi	sp,sp,-48
800091b4:	02812623          	sw	s0,44(sp)
800091b8:	03010413          	addi	s0,sp,48
800091bc:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
800091c0:	fdc42783          	lw	a5,-36(s0)
800091c4:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
800091c8:	8000b7b7          	lui	a5,0x8000b
800091cc:	4007a703          	lw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
800091d0:	fec42783          	lw	a5,-20(s0)
800091d4:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
800091d8:	8000b7b7          	lui	a5,0x8000b
800091dc:	fec42703          	lw	a4,-20(s0)
800091e0:	40e7a023          	sw	a4,1024(a5) # 8000b400 <memend+0xf800b400>
800091e4:	00000013          	nop
800091e8:	02c12403          	lw	s0,44(sp)
800091ec:	03010113          	addi	sp,sp,48
800091f0:	00008067          	ret

800091f4 <r_tp>:
static inline uint32 r_tp(){
800091f4:	fe010113          	addi	sp,sp,-32
800091f8:	00812e23          	sw	s0,28(sp)
800091fc:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80009200:	00020793          	mv	a5,tp
80009204:	fef42623          	sw	a5,-20(s0)
    return x;
80009208:	fec42783          	lw	a5,-20(s0)
}
8000920c:	00078513          	mv	a0,a5
80009210:	01c12403          	lw	s0,28(sp)
80009214:	02010113          	addi	sp,sp,32
80009218:	00008067          	ret

8000921c <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
8000921c:	fe010113          	addi	sp,sp,-32
80009220:	00812e23          	sw	s0,28(sp)
80009224:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
80009228:	104027f3          	csrr	a5,sie
8000922c:	fef42623          	sw	a5,-20(s0)
    return x;
80009230:	fec42783          	lw	a5,-20(s0)
}
80009234:	00078513          	mv	a0,a5
80009238:	01c12403          	lw	s0,28(sp)
8000923c:	02010113          	addi	sp,sp,32
80009240:	00008067          	ret

80009244 <w_sie>:
static inline void w_sie(uint32 x){
80009244:	fe010113          	addi	sp,sp,-32
80009248:	00812e23          	sw	s0,28(sp)
8000924c:	02010413          	addi	s0,sp,32
80009250:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80009254:	fec42783          	lw	a5,-20(s0)
80009258:	10479073          	csrw	sie,a5
}
8000925c:	00000013          	nop
80009260:	01c12403          	lw	s0,28(sp)
80009264:	02010113          	addi	sp,sp,32
80009268:	00008067          	ret

8000926c <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
8000926c:	ff010113          	addi	sp,sp,-16
80009270:	00112623          	sw	ra,12(sp)
80009274:	00812423          	sw	s0,8(sp)
80009278:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
8000927c:	0c0007b7          	lui	a5,0xc000
80009280:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80009284:	00100713          	li	a4,1
80009288:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
8000928c:	f69ff0ef          	jal	ra,800091f4 <r_tp>
80009290:	00050793          	mv	a5,a0
80009294:	00879713          	slli	a4,a5,0x8
80009298:	0c0027b7          	lui	a5,0xc002
8000929c:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
800092a0:	00f707b3          	add	a5,a4,a5
800092a4:	00078713          	mv	a4,a5
800092a8:	40000793          	li	a5,1024
800092ac:	00f72023          	sw	a5,0(a4) # 8000b000 <memend+0xf800b000>
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800092b0:	f45ff0ef          	jal	ra,800091f4 <r_tp>
800092b4:	00050713          	mv	a4,a0
800092b8:	000c07b7          	lui	a5,0xc0
800092bc:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800092c0:	00f707b3          	add	a5,a4,a5
800092c4:	00879793          	slli	a5,a5,0x8
800092c8:	00078713          	mv	a4,a5
800092cc:	40000793          	li	a5,1024
800092d0:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
800092d4:	f21ff0ef          	jal	ra,800091f4 <r_tp>
800092d8:	00050713          	mv	a4,a0
800092dc:	000067b7          	lui	a5,0x6
800092e0:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800092e4:	00f707b3          	add	a5,a4,a5
800092e8:	00d79793          	slli	a5,a5,0xd
800092ec:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800092f0:	f05ff0ef          	jal	ra,800091f4 <r_tp>
800092f4:	00050793          	mv	a5,a0
800092f8:	00d79713          	slli	a4,a5,0xd
800092fc:	0c2017b7          	lui	a5,0xc201
80009300:	00f707b3          	add	a5,a4,a5
80009304:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
80009308:	f15ff0ef          	jal	ra,8000921c <r_sie>
8000930c:	00050793          	mv	a5,a0
80009310:	2227e793          	ori	a5,a5,546
80009314:	00078513          	mv	a0,a5
80009318:	f2dff0ef          	jal	ra,80009244 <w_sie>
}
8000931c:	00000013          	nop
80009320:	00c12083          	lw	ra,12(sp)
80009324:	00812403          	lw	s0,8(sp)
80009328:	01010113          	addi	sp,sp,16
8000932c:	00008067          	ret

80009330 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80009330:	ff010113          	addi	sp,sp,-16
80009334:	00112623          	sw	ra,12(sp)
80009338:	00812423          	sw	s0,8(sp)
8000933c:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80009340:	eb5ff0ef          	jal	ra,800091f4 <r_tp>
80009344:	00050793          	mv	a5,a0
80009348:	00d79713          	slli	a4,a5,0xd
8000934c:	0c2017b7          	lui	a5,0xc201
80009350:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80009354:	00f707b3          	add	a5,a4,a5
80009358:	0007a783          	lw	a5,0(a5)
}
8000935c:	00078513          	mv	a0,a5
80009360:	00c12083          	lw	ra,12(sp)
80009364:	00812403          	lw	s0,8(sp)
80009368:	01010113          	addi	sp,sp,16
8000936c:	00008067          	ret

80009370 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80009370:	fe010113          	addi	sp,sp,-32
80009374:	00112e23          	sw	ra,28(sp)
80009378:	00812c23          	sw	s0,24(sp)
8000937c:	02010413          	addi	s0,sp,32
80009380:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80009384:	e71ff0ef          	jal	ra,800091f4 <r_tp>
80009388:	00050793          	mv	a5,a0
8000938c:	00d79713          	slli	a4,a5,0xd
80009390:	0c2007b7          	lui	a5,0xc200
80009394:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
80009398:	00f707b3          	add	a5,a4,a5
8000939c:	00078713          	mv	a4,a5
800093a0:	fec42783          	lw	a5,-20(s0)
800093a4:	00f72023          	sw	a5,0(a4)
800093a8:	00000013          	nop
800093ac:	01c12083          	lw	ra,28(sp)
800093b0:	01812403          	lw	s0,24(sp)
800093b4:	02010113          	addi	sp,sp,32
800093b8:	00008067          	ret
