
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
80000020:	6040006f          	j	80000624 <start>

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
800000ac:	0fd000ef          	jal	ra,800009a8 <trapvec>

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


    lw ra,0(a1)
800001b0:	0005a083          	lw	ra,0(a1)
    lw sp,4(a1)
800001b4:	0045a103          	lw	sp,4(a1)
    lw gp,8(a1)
800001b8:	0085a183          	lw	gp,8(a1)
    lw tp,12(a1)
800001bc:	00c5a203          	lw	tp,12(a1)
    lw a0,16(a1)
800001c0:	0105a503          	lw	a0,16(a1)
    // a1
    lw a2,24(a1)
800001c4:	0185a603          	lw	a2,24(a1)
    lw a3,28(a1)
800001c8:	01c5a683          	lw	a3,28(a1)
    lw a4,32(a1)
800001cc:	0205a703          	lw	a4,32(a1)
    lw a5,36(a1)
800001d0:	0245a783          	lw	a5,36(a1)
    lw a6,40(a1)
800001d4:	0285a803          	lw	a6,40(a1)
    lw a7,44(a1)
800001d8:	02c5a883          	lw	a7,44(a1)
    lw s0,48(a1)
800001dc:	0305a403          	lw	s0,48(a1)
    lw s1,52(a1)
800001e0:	0345a483          	lw	s1,52(a1)
    lw s2,56(a1)
800001e4:	0385a903          	lw	s2,56(a1)
    lw s3,60(a1)
800001e8:	03c5a983          	lw	s3,60(a1)
    lw s4,64(a1)
800001ec:	0405aa03          	lw	s4,64(a1)
    lw s5,68(a1)
800001f0:	0445aa83          	lw	s5,68(a1)
    lw s6,72(a1)
800001f4:	0485ab03          	lw	s6,72(a1)
    lw s7,76(a1)
800001f8:	04c5ab83          	lw	s7,76(a1)
    lw s8,80(a1)
800001fc:	0505ac03          	lw	s8,80(a1)
    lw s9,84(a1)
80000200:	0545ac83          	lw	s9,84(a1)
    lw s10,88(a1)
80000204:	0585ad03          	lw	s10,88(a1)
    lw s11,92(a1)
80000208:	05c5ad83          	lw	s11,92(a1)
    lw t0,96(a1)
8000020c:	0605a283          	lw	t0,96(a1)
    lw t1,100(a1)
80000210:	0645a303          	lw	t1,100(a1)
    lw t2,104(a1)
80000214:	0685a383          	lw	t2,104(a1)
    lw t3,108(a1)
80000218:	06c5ae03          	lw	t3,108(a1)
    lw t4,112(a1)
8000021c:	0705ae83          	lw	t4,112(a1)
    lw t5,116(a1)
80000220:	0745af03          	lw	t5,116(a1)
    lw t6,120(a1)
80000224:	0785af83          	lw	t6,120(a1)

    lw a1,20(a1)
80000228:	0145a583          	lw	a1,20(a1)

8000022c:	00008067          	ret

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

extern void main();     // 定义在main.c

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
80000680:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000684:	00078513          	mv	a0,a5
80000688:	d45ff0ef          	jal	ra,800003cc <w_stvec>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
8000068c:	800017b7          	lui	a5,0x80001
80000690:	8b478793          	addi	a5,a5,-1868 # 800008b4 <memend+0xf80008b4>
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

80000874 <task>:
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"
void task(){
80000874:	fe010113          	addi	sp,sp,-32
80000878:	00112e23          	sw	ra,28(sp)
8000087c:	00812c23          	sw	s0,24(sp)
80000880:	02010413          	addi	s0,sp,32
    while(1){
        int i=100000000;
80000884:	05f5e7b7          	lui	a5,0x5f5e
80000888:	10078793          	addi	a5,a5,256 # 5f5e100 <sz+0x5f5d100>
8000088c:	fef42623          	sw	a5,-20(s0)
        while(i--);
80000890:	00000013          	nop
80000894:	fec42783          	lw	a5,-20(s0)
80000898:	fff78713          	addi	a4,a5,-1
8000089c:	fee42623          	sw	a4,-20(s0)
800008a0:	fe079ae3          	bnez	a5,80000894 <task+0x20>
        printf("tesk\n");
800008a4:	800027b7          	lui	a5,0x80002
800008a8:	00c78513          	addi	a0,a5,12 # 8000200c <memend+0xf800200c>
800008ac:	308000ef          	jal	ra,80000bb4 <printf>
    while(1){
800008b0:	fd5ff06f          	j	80000884 <task+0x10>

800008b4 <main>:
    }
}
void main(){
800008b4:	ef010113          	addi	sp,sp,-272
800008b8:	10112623          	sw	ra,268(sp)
800008bc:	10812423          	sw	s0,264(sp)
800008c0:	11010413          	addi	s0,sp,272
    printf("start run main()\n");
800008c4:	800027b7          	lui	a5,0x80002
800008c8:	01478513          	addi	a0,a5,20 # 80002014 <memend+0xf8002014>
800008cc:	2e8000ef          	jal	ra,80000bb4 <printf>

    minit();        // 物理内存管理
800008d0:	6f0000ef          	jal	ra,80000fc0 <minit>
    plicinit();     // PLIC 中断处理
800008d4:	08d000ef          	jal	ra,80001160 <plicinit>
    vminit();       // 启动虚拟内存
800008d8:	541000ef          	jal	ra,80001618 <vminit>

    procinit();
800008dc:	741000ef          	jal	ra,8000181c <procinit>
    // *va=10;
    // *(int *)0x00000000 = 100;
   
    struct context old;
    struct context new;
    new.ra=(reg_t)task;
800008e0:	800017b7          	lui	a5,0x80001
800008e4:	87478793          	addi	a5,a5,-1932 # 80000874 <memend+0xf8000874>
800008e8:	eef42c23          	sw	a5,-264(s0)
    swtch(&old,&new);
800008ec:	ef840713          	addi	a4,s0,-264
800008f0:	f7440793          	addi	a5,s0,-140
800008f4:	00070593          	mv	a1,a4
800008f8:	00078513          	mv	a0,a5
800008fc:	839ff0ef          	jal	ra,80000134 <swtch>

    printf("----------------------\n");
80000900:	800027b7          	lui	a5,0x80002
80000904:	02878513          	addi	a0,a5,40 # 80002028 <memend+0xf8002028>
80000908:	2ac000ef          	jal	ra,80000bb4 <printf>

    while(1);
8000090c:	0000006f          	j	8000090c <main+0x58>

80000910 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
80000910:	fe010113          	addi	sp,sp,-32
80000914:	00812e23          	sw	s0,28(sp)
80000918:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
8000091c:	142027f3          	csrr	a5,scause
80000920:	fef42623          	sw	a5,-20(s0)
    return x;
80000924:	fec42783          	lw	a5,-20(s0)
}
80000928:	00078513          	mv	a0,a5
8000092c:	01c12403          	lw	s0,28(sp)
80000930:	02010113          	addi	sp,sp,32
80000934:	00008067          	ret

80000938 <externinterrupt>:
#include "plic.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
80000938:	fe010113          	addi	sp,sp,-32
8000093c:	00112e23          	sw	ra,28(sp)
80000940:	00812c23          	sw	s0,24(sp)
80000944:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000948:	0dd000ef          	jal	ra,80001224 <r_plicclaim>
8000094c:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000950:	fec42583          	lw	a1,-20(s0)
80000954:	800027b7          	lui	a5,0x80002
80000958:	04078513          	addi	a0,a5,64 # 80002040 <memend+0xf8002040>
8000095c:	258000ef          	jal	ra,80000bb4 <printf>
    switch (irq)
80000960:	fec42703          	lw	a4,-20(s0)
80000964:	00a00793          	li	a5,10
80000968:	02f71063          	bne	a4,a5,80000988 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
8000096c:	ed9ff0ef          	jal	ra,80000844 <uartintr>
80000970:	00050793          	mv	a5,a0
80000974:	00078593          	mv	a1,a5
80000978:	800027b7          	lui	a5,0x80002
8000097c:	04c78513          	addi	a0,a5,76 # 8000204c <memend+0xf800204c>
80000980:	234000ef          	jal	ra,80000bb4 <printf>
        break;
80000984:	0080006f          	j	8000098c <externinterrupt+0x54>
    default:
        break;
80000988:	00000013          	nop
    }
    w_pliccomplete(irq);
8000098c:	fec42503          	lw	a0,-20(s0)
80000990:	0d5000ef          	jal	ra,80001264 <w_pliccomplete>
}
80000994:	00000013          	nop
80000998:	01c12083          	lw	ra,28(sp)
8000099c:	01812403          	lw	s0,24(sp)
800009a0:	02010113          	addi	sp,sp,32
800009a4:	00008067          	ret

800009a8 <trapvec>:

void trapvec(){
800009a8:	fe010113          	addi	sp,sp,-32
800009ac:	00112e23          	sw	ra,28(sp)
800009b0:	00812c23          	sw	s0,24(sp)
800009b4:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
800009b8:	f59ff0ef          	jal	ra,80000910 <r_scause>
800009bc:	fea42623          	sw	a0,-20(s0)

    uint16 code= scause & 0xffff;
800009c0:	fec42783          	lw	a5,-20(s0)
800009c4:	fef41523          	sh	a5,-22(s0)

    if(scause & (1<<31)){
800009c8:	fec42783          	lw	a5,-20(s0)
800009cc:	0607de63          	bgez	a5,80000a48 <trapvec+0xa0>
        printf("Interrupt : ");
800009d0:	800027b7          	lui	a5,0x80002
800009d4:	05c78513          	addi	a0,a5,92 # 8000205c <memend+0xf800205c>
800009d8:	1dc000ef          	jal	ra,80000bb4 <printf>
        switch (code)
800009dc:	fea45783          	lhu	a5,-22(s0)
800009e0:	00900713          	li	a4,9
800009e4:	04e78063          	beq	a5,a4,80000a24 <trapvec+0x7c>
800009e8:	00900713          	li	a4,9
800009ec:	04f74663          	blt	a4,a5,80000a38 <trapvec+0x90>
800009f0:	00100713          	li	a4,1
800009f4:	00e78863          	beq	a5,a4,80000a04 <trapvec+0x5c>
800009f8:	00500713          	li	a4,5
800009fc:	00e78c63          	beq	a5,a4,80000a14 <trapvec+0x6c>
80000a00:	0380006f          	j	80000a38 <trapvec+0x90>
        {
        case 1:
            printf("Supervisor software interrupt\n");
80000a04:	800027b7          	lui	a5,0x80002
80000a08:	06c78513          	addi	a0,a5,108 # 8000206c <memend+0xf800206c>
80000a0c:	1a8000ef          	jal	ra,80000bb4 <printf>
            break;
80000a10:	1580006f          	j	80000b68 <trapvec+0x1c0>
        case 5:
            printf("Supervisor timer interrupt\n");
80000a14:	800027b7          	lui	a5,0x80002
80000a18:	08c78513          	addi	a0,a5,140 # 8000208c <memend+0xf800208c>
80000a1c:	198000ef          	jal	ra,80000bb4 <printf>
            break;
80000a20:	1480006f          	j	80000b68 <trapvec+0x1c0>
        case 9:
            printf("Supervisor external interrupt\n");
80000a24:	800027b7          	lui	a5,0x80002
80000a28:	0a878513          	addi	a0,a5,168 # 800020a8 <memend+0xf80020a8>
80000a2c:	188000ef          	jal	ra,80000bb4 <printf>
            externinterrupt();
80000a30:	f09ff0ef          	jal	ra,80000938 <externinterrupt>
            break;
80000a34:	1340006f          	j	80000b68 <trapvec+0x1c0>
        default:
            printf("Other interrupt\n");
80000a38:	800027b7          	lui	a5,0x80002
80000a3c:	0c878513          	addi	a0,a5,200 # 800020c8 <memend+0xf80020c8>
80000a40:	174000ef          	jal	ra,80000bb4 <printf>
            break;
80000a44:	1240006f          	j	80000b68 <trapvec+0x1c0>
        }
    }else{
        printf("Exception : ");
80000a48:	800027b7          	lui	a5,0x80002
80000a4c:	0dc78513          	addi	a0,a5,220 # 800020dc <memend+0xf80020dc>
80000a50:	164000ef          	jal	ra,80000bb4 <printf>
        switch (code)
80000a54:	fea45783          	lhu	a5,-22(s0)
80000a58:	00f00713          	li	a4,15
80000a5c:	0ef76663          	bltu	a4,a5,80000b48 <trapvec+0x1a0>
80000a60:	00279713          	slli	a4,a5,0x2
80000a64:	800027b7          	lui	a5,0x80002
80000a68:	25078793          	addi	a5,a5,592 # 80002250 <memend+0xf8002250>
80000a6c:	00f707b3          	add	a5,a4,a5
80000a70:	0007a783          	lw	a5,0(a5)
80000a74:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000a78:	800027b7          	lui	a5,0x80002
80000a7c:	0ec78513          	addi	a0,a5,236 # 800020ec <memend+0xf80020ec>
80000a80:	134000ef          	jal	ra,80000bb4 <printf>
            break;
80000a84:	0d40006f          	j	80000b58 <trapvec+0x1b0>
        case 1:
            printf("Instruction access fault\n");
80000a88:	800027b7          	lui	a5,0x80002
80000a8c:	10c78513          	addi	a0,a5,268 # 8000210c <memend+0xf800210c>
80000a90:	124000ef          	jal	ra,80000bb4 <printf>
            break;
80000a94:	0c40006f          	j	80000b58 <trapvec+0x1b0>
        case 2:
            printf("Illegal instruction\n");
80000a98:	800027b7          	lui	a5,0x80002
80000a9c:	12878513          	addi	a0,a5,296 # 80002128 <memend+0xf8002128>
80000aa0:	114000ef          	jal	ra,80000bb4 <printf>
            break;
80000aa4:	0b40006f          	j	80000b58 <trapvec+0x1b0>
        case 3:
            printf("Breakpoint\n");
80000aa8:	800027b7          	lui	a5,0x80002
80000aac:	14078513          	addi	a0,a5,320 # 80002140 <memend+0xf8002140>
80000ab0:	104000ef          	jal	ra,80000bb4 <printf>
            break;
80000ab4:	0a40006f          	j	80000b58 <trapvec+0x1b0>
        case 4:
            printf("Load address misaligned\n");
80000ab8:	800027b7          	lui	a5,0x80002
80000abc:	14c78513          	addi	a0,a5,332 # 8000214c <memend+0xf800214c>
80000ac0:	0f4000ef          	jal	ra,80000bb4 <printf>
            break;
80000ac4:	0940006f          	j	80000b58 <trapvec+0x1b0>
        case 5:
            printf("Load access fault\n");
80000ac8:	800027b7          	lui	a5,0x80002
80000acc:	16878513          	addi	a0,a5,360 # 80002168 <memend+0xf8002168>
80000ad0:	0e4000ef          	jal	ra,80000bb4 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000ad4:	0840006f          	j	80000b58 <trapvec+0x1b0>
        case 6:
            printf("Store/AMO address misaligned\n");
80000ad8:	800027b7          	lui	a5,0x80002
80000adc:	17c78513          	addi	a0,a5,380 # 8000217c <memend+0xf800217c>
80000ae0:	0d4000ef          	jal	ra,80000bb4 <printf>
            break;
80000ae4:	0740006f          	j	80000b58 <trapvec+0x1b0>
        case 7:
            printf("Store/AMO access fault\n");
80000ae8:	800027b7          	lui	a5,0x80002
80000aec:	19c78513          	addi	a0,a5,412 # 8000219c <memend+0xf800219c>
80000af0:	0c4000ef          	jal	ra,80000bb4 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000af4:	0640006f          	j	80000b58 <trapvec+0x1b0>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000af8:	800027b7          	lui	a5,0x80002
80000afc:	1b478513          	addi	a0,a5,436 # 800021b4 <memend+0xf80021b4>
80000b00:	0b4000ef          	jal	ra,80000bb4 <printf>
            break;
80000b04:	0540006f          	j	80000b58 <trapvec+0x1b0>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000b08:	800027b7          	lui	a5,0x80002
80000b0c:	1d478513          	addi	a0,a5,468 # 800021d4 <memend+0xf80021d4>
80000b10:	0a4000ef          	jal	ra,80000bb4 <printf>
            break;
80000b14:	0440006f          	j	80000b58 <trapvec+0x1b0>
        case 12:
            printf("Instruction page fault\n");
80000b18:	800027b7          	lui	a5,0x80002
80000b1c:	1f478513          	addi	a0,a5,500 # 800021f4 <memend+0xf80021f4>
80000b20:	094000ef          	jal	ra,80000bb4 <printf>
            break;
80000b24:	0340006f          	j	80000b58 <trapvec+0x1b0>
        case 13:
            printf("Load page fault\n");
80000b28:	800027b7          	lui	a5,0x80002
80000b2c:	20c78513          	addi	a0,a5,524 # 8000220c <memend+0xf800220c>
80000b30:	084000ef          	jal	ra,80000bb4 <printf>
            break;
80000b34:	0240006f          	j	80000b58 <trapvec+0x1b0>
        case 15:
            printf("Store/AMO page fault\n");
80000b38:	800027b7          	lui	a5,0x80002
80000b3c:	22078513          	addi	a0,a5,544 # 80002220 <memend+0xf8002220>
80000b40:	074000ef          	jal	ra,80000bb4 <printf>
            break;
80000b44:	0140006f          	j	80000b58 <trapvec+0x1b0>
        default:
            printf("Other\n");
80000b48:	800027b7          	lui	a5,0x80002
80000b4c:	23878513          	addi	a0,a5,568 # 80002238 <memend+0xf8002238>
80000b50:	064000ef          	jal	ra,80000bb4 <printf>
            break;
80000b54:	00000013          	nop
        }
        panic("Trap Exception");
80000b58:	800027b7          	lui	a5,0x80002
80000b5c:	24078513          	addi	a0,a5,576 # 80002240 <memend+0xf8002240>
80000b60:	01c000ef          	jal	ra,80000b7c <panic>
    }
}
80000b64:	00000013          	nop
80000b68:	00000013          	nop
80000b6c:	01c12083          	lw	ra,28(sp)
80000b70:	01812403          	lw	s0,24(sp)
80000b74:	02010113          	addi	sp,sp,32
80000b78:	00008067          	ret

80000b7c <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000b7c:	fe010113          	addi	sp,sp,-32
80000b80:	00112e23          	sw	ra,28(sp)
80000b84:	00812c23          	sw	s0,24(sp)
80000b88:	02010413          	addi	s0,sp,32
80000b8c:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000b90:	800027b7          	lui	a5,0x80002
80000b94:	29078513          	addi	a0,a5,656 # 80002290 <memend+0xf8002290>
80000b98:	c11ff0ef          	jal	ra,800007a8 <uartputs>
    uartputs(s);
80000b9c:	fec42503          	lw	a0,-20(s0)
80000ba0:	c09ff0ef          	jal	ra,800007a8 <uartputs>
	uartputs("\n");
80000ba4:	800027b7          	lui	a5,0x80002
80000ba8:	29878513          	addi	a0,a5,664 # 80002298 <memend+0xf8002298>
80000bac:	bfdff0ef          	jal	ra,800007a8 <uartputs>
    while(1);
80000bb0:	0000006f          	j	80000bb0 <panic+0x34>

80000bb4 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000bb4:	f8010113          	addi	sp,sp,-128
80000bb8:	04112e23          	sw	ra,92(sp)
80000bbc:	04812c23          	sw	s0,88(sp)
80000bc0:	06010413          	addi	s0,sp,96
80000bc4:	faa42623          	sw	a0,-84(s0)
80000bc8:	00b42223          	sw	a1,4(s0)
80000bcc:	00c42423          	sw	a2,8(s0)
80000bd0:	00d42623          	sw	a3,12(s0)
80000bd4:	00e42823          	sw	a4,16(s0)
80000bd8:	00f42a23          	sw	a5,20(s0)
80000bdc:	01042c23          	sw	a6,24(s0)
80000be0:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000be4:	02040793          	addi	a5,s0,32
80000be8:	faf42423          	sw	a5,-88(s0)
80000bec:	fa842783          	lw	a5,-88(s0)
80000bf0:	fe478793          	addi	a5,a5,-28
80000bf4:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000bf8:	fac42783          	lw	a5,-84(s0)
80000bfc:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000c00:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000c04:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
80000c08:	36c0006f          	j	80000f74 <printf+0x3c0>
		if(ch=='%'){
80000c0c:	fbf44703          	lbu	a4,-65(s0)
80000c10:	02500793          	li	a5,37
80000c14:	04f71863          	bne	a4,a5,80000c64 <printf+0xb0>
			if(tt==1){
80000c18:	fe842703          	lw	a4,-24(s0)
80000c1c:	00100793          	li	a5,1
80000c20:	02f71663          	bne	a4,a5,80000c4c <printf+0x98>
				outbuf[idx++]='%';
80000c24:	fe442783          	lw	a5,-28(s0)
80000c28:	00178713          	addi	a4,a5,1
80000c2c:	fee42223          	sw	a4,-28(s0)
80000c30:	8000c737          	lui	a4,0x8000c
80000c34:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000c38:	00f707b3          	add	a5,a4,a5
80000c3c:	02500713          	li	a4,37
80000c40:	00e78023          	sb	a4,0(a5)
				tt=0;
80000c44:	fe042423          	sw	zero,-24(s0)
80000c48:	00c0006f          	j	80000c54 <printf+0xa0>
			}else{
				tt=1;
80000c4c:	00100793          	li	a5,1
80000c50:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000c54:	fec42783          	lw	a5,-20(s0)
80000c58:	00178793          	addi	a5,a5,1
80000c5c:	fef42623          	sw	a5,-20(s0)
80000c60:	3140006f          	j	80000f74 <printf+0x3c0>
		}else{
			if(tt==1){
80000c64:	fe842703          	lw	a4,-24(s0)
80000c68:	00100793          	li	a5,1
80000c6c:	2cf71e63          	bne	a4,a5,80000f48 <printf+0x394>
				switch (ch)
80000c70:	fbf44783          	lbu	a5,-65(s0)
80000c74:	fa878793          	addi	a5,a5,-88
80000c78:	02000713          	li	a4,32
80000c7c:	2af76663          	bltu	a4,a5,80000f28 <printf+0x374>
80000c80:	00279713          	slli	a4,a5,0x2
80000c84:	800027b7          	lui	a5,0x80002
80000c88:	2b478793          	addi	a5,a5,692 # 800022b4 <memend+0xf80022b4>
80000c8c:	00f707b3          	add	a5,a4,a5
80000c90:	0007a783          	lw	a5,0(a5)
80000c94:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000c98:	fb842783          	lw	a5,-72(s0)
80000c9c:	00478713          	addi	a4,a5,4
80000ca0:	fae42c23          	sw	a4,-72(s0)
80000ca4:	0007a783          	lw	a5,0(a5)
80000ca8:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000cac:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000cb0:	fe042783          	lw	a5,-32(s0)
80000cb4:	fcf42c23          	sw	a5,-40(s0)
80000cb8:	0100006f          	j	80000cc8 <printf+0x114>
80000cbc:	fdc42783          	lw	a5,-36(s0)
80000cc0:	00178793          	addi	a5,a5,1
80000cc4:	fcf42e23          	sw	a5,-36(s0)
80000cc8:	fd842703          	lw	a4,-40(s0)
80000ccc:	00a00793          	li	a5,10
80000cd0:	02f747b3          	div	a5,a4,a5
80000cd4:	fcf42c23          	sw	a5,-40(s0)
80000cd8:	fd842783          	lw	a5,-40(s0)
80000cdc:	fe0790e3          	bnez	a5,80000cbc <printf+0x108>
					for(int i=len;i>=0;i--){
80000ce0:	fdc42783          	lw	a5,-36(s0)
80000ce4:	fcf42a23          	sw	a5,-44(s0)
80000ce8:	0540006f          	j	80000d3c <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000cec:	fe042703          	lw	a4,-32(s0)
80000cf0:	00a00793          	li	a5,10
80000cf4:	02f767b3          	rem	a5,a4,a5
80000cf8:	0ff7f713          	andi	a4,a5,255
80000cfc:	fe442683          	lw	a3,-28(s0)
80000d00:	fd442783          	lw	a5,-44(s0)
80000d04:	00f687b3          	add	a5,a3,a5
80000d08:	03070713          	addi	a4,a4,48
80000d0c:	0ff77713          	andi	a4,a4,255
80000d10:	8000c6b7          	lui	a3,0x8000c
80000d14:	00468693          	addi	a3,a3,4 # 8000c004 <memend+0xf800c004>
80000d18:	00f687b3          	add	a5,a3,a5
80000d1c:	00e78023          	sb	a4,0(a5)
						x/=10;
80000d20:	fe042703          	lw	a4,-32(s0)
80000d24:	00a00793          	li	a5,10
80000d28:	02f747b3          	div	a5,a4,a5
80000d2c:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000d30:	fd442783          	lw	a5,-44(s0)
80000d34:	fff78793          	addi	a5,a5,-1
80000d38:	fcf42a23          	sw	a5,-44(s0)
80000d3c:	fd442783          	lw	a5,-44(s0)
80000d40:	fa07d6e3          	bgez	a5,80000cec <printf+0x138>
					}
					idx+=(len+1);
80000d44:	fdc42783          	lw	a5,-36(s0)
80000d48:	00178793          	addi	a5,a5,1
80000d4c:	fe442703          	lw	a4,-28(s0)
80000d50:	00f707b3          	add	a5,a4,a5
80000d54:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000d58:	fe042423          	sw	zero,-24(s0)
					break;
80000d5c:	1dc0006f          	j	80000f38 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000d60:	fe442783          	lw	a5,-28(s0)
80000d64:	00178713          	addi	a4,a5,1
80000d68:	fee42223          	sw	a4,-28(s0)
80000d6c:	8000c737          	lui	a4,0x8000c
80000d70:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000d74:	00f707b3          	add	a5,a4,a5
80000d78:	03000713          	li	a4,48
80000d7c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000d80:	fe442783          	lw	a5,-28(s0)
80000d84:	00178713          	addi	a4,a5,1
80000d88:	fee42223          	sw	a4,-28(s0)
80000d8c:	8000c737          	lui	a4,0x8000c
80000d90:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000d94:	00f707b3          	add	a5,a4,a5
80000d98:	07800713          	li	a4,120
80000d9c:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80000da0:	fb842783          	lw	a5,-72(s0)
80000da4:	00478713          	addi	a4,a5,4
80000da8:	fae42c23          	sw	a4,-72(s0)
80000dac:	0007a783          	lw	a5,0(a5)
80000db0:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80000db4:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80000db8:	fd042783          	lw	a5,-48(s0)
80000dbc:	fcf42423          	sw	a5,-56(s0)
80000dc0:	0100006f          	j	80000dd0 <printf+0x21c>
80000dc4:	fcc42783          	lw	a5,-52(s0)
80000dc8:	00178793          	addi	a5,a5,1
80000dcc:	fcf42623          	sw	a5,-52(s0)
80000dd0:	fc842783          	lw	a5,-56(s0)
80000dd4:	0047d793          	srli	a5,a5,0x4
80000dd8:	fcf42423          	sw	a5,-56(s0)
80000ddc:	fc842783          	lw	a5,-56(s0)
80000de0:	fe0792e3          	bnez	a5,80000dc4 <printf+0x210>
					for(int i=len;i>=0;i--){
80000de4:	fcc42783          	lw	a5,-52(s0)
80000de8:	fcf42223          	sw	a5,-60(s0)
80000dec:	0840006f          	j	80000e70 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80000df0:	fd042783          	lw	a5,-48(s0)
80000df4:	00f7f713          	andi	a4,a5,15
80000df8:	00900793          	li	a5,9
80000dfc:	02e7f063          	bgeu	a5,a4,80000e1c <printf+0x268>
80000e00:	fd042783          	lw	a5,-48(s0)
80000e04:	0ff7f793          	andi	a5,a5,255
80000e08:	00f7f793          	andi	a5,a5,15
80000e0c:	0ff7f793          	andi	a5,a5,255
80000e10:	05778793          	addi	a5,a5,87
80000e14:	0ff7f793          	andi	a5,a5,255
80000e18:	01c0006f          	j	80000e34 <printf+0x280>
80000e1c:	fd042783          	lw	a5,-48(s0)
80000e20:	0ff7f793          	andi	a5,a5,255
80000e24:	00f7f793          	andi	a5,a5,15
80000e28:	0ff7f793          	andi	a5,a5,255
80000e2c:	03078793          	addi	a5,a5,48
80000e30:	0ff7f793          	andi	a5,a5,255
80000e34:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80000e38:	fe442703          	lw	a4,-28(s0)
80000e3c:	fc442783          	lw	a5,-60(s0)
80000e40:	00f707b3          	add	a5,a4,a5
80000e44:	8000c737          	lui	a4,0x8000c
80000e48:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000e4c:	00f707b3          	add	a5,a4,a5
80000e50:	fbe44703          	lbu	a4,-66(s0)
80000e54:	00e78023          	sb	a4,0(a5)
						x/=16;
80000e58:	fd042783          	lw	a5,-48(s0)
80000e5c:	0047d793          	srli	a5,a5,0x4
80000e60:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80000e64:	fc442783          	lw	a5,-60(s0)
80000e68:	fff78793          	addi	a5,a5,-1
80000e6c:	fcf42223          	sw	a5,-60(s0)
80000e70:	fc442783          	lw	a5,-60(s0)
80000e74:	f607dee3          	bgez	a5,80000df0 <printf+0x23c>
					}
					idx+=(len+1);
80000e78:	fcc42783          	lw	a5,-52(s0)
80000e7c:	00178793          	addi	a5,a5,1
80000e80:	fe442703          	lw	a4,-28(s0)
80000e84:	00f707b3          	add	a5,a4,a5
80000e88:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000e8c:	fe042423          	sw	zero,-24(s0)
					break;
80000e90:	0a80006f          	j	80000f38 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80000e94:	fb842783          	lw	a5,-72(s0)
80000e98:	00478713          	addi	a4,a5,4
80000e9c:	fae42c23          	sw	a4,-72(s0)
80000ea0:	0007a783          	lw	a5,0(a5)
80000ea4:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80000ea8:	fe442783          	lw	a5,-28(s0)
80000eac:	00178713          	addi	a4,a5,1
80000eb0:	fee42223          	sw	a4,-28(s0)
80000eb4:	8000c737          	lui	a4,0x8000c
80000eb8:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000ebc:	00f707b3          	add	a5,a4,a5
80000ec0:	fbf44703          	lbu	a4,-65(s0)
80000ec4:	00e78023          	sb	a4,0(a5)
					tt=0;
80000ec8:	fe042423          	sw	zero,-24(s0)
					break;
80000ecc:	06c0006f          	j	80000f38 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80000ed0:	fb842783          	lw	a5,-72(s0)
80000ed4:	00478713          	addi	a4,a5,4
80000ed8:	fae42c23          	sw	a4,-72(s0)
80000edc:	0007a783          	lw	a5,0(a5)
80000ee0:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80000ee4:	0300006f          	j	80000f14 <printf+0x360>
						outbuf[idx++]=*ss++;
80000ee8:	fc042703          	lw	a4,-64(s0)
80000eec:	00170793          	addi	a5,a4,1
80000ef0:	fcf42023          	sw	a5,-64(s0)
80000ef4:	fe442783          	lw	a5,-28(s0)
80000ef8:	00178693          	addi	a3,a5,1
80000efc:	fed42223          	sw	a3,-28(s0)
80000f00:	00074703          	lbu	a4,0(a4)
80000f04:	8000c6b7          	lui	a3,0x8000c
80000f08:	00468693          	addi	a3,a3,4 # 8000c004 <memend+0xf800c004>
80000f0c:	00f687b3          	add	a5,a3,a5
80000f10:	00e78023          	sb	a4,0(a5)
					while(*ss){
80000f14:	fc042783          	lw	a5,-64(s0)
80000f18:	0007c783          	lbu	a5,0(a5)
80000f1c:	fc0796e3          	bnez	a5,80000ee8 <printf+0x334>
					}
					tt=0;
80000f20:	fe042423          	sw	zero,-24(s0)
					break;
80000f24:	0140006f          	j	80000f38 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80000f28:	800027b7          	lui	a5,0x80002
80000f2c:	29c78513          	addi	a0,a5,668 # 8000229c <memend+0xf800229c>
80000f30:	c4dff0ef          	jal	ra,80000b7c <panic>
					break;
80000f34:	00000013          	nop
				}
				s++;
80000f38:	fec42783          	lw	a5,-20(s0)
80000f3c:	00178793          	addi	a5,a5,1
80000f40:	fef42623          	sw	a5,-20(s0)
80000f44:	0300006f          	j	80000f74 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80000f48:	fe442783          	lw	a5,-28(s0)
80000f4c:	00178713          	addi	a4,a5,1
80000f50:	fee42223          	sw	a4,-28(s0)
80000f54:	8000c737          	lui	a4,0x8000c
80000f58:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000f5c:	00f707b3          	add	a5,a4,a5
80000f60:	fbf44703          	lbu	a4,-65(s0)
80000f64:	00e78023          	sb	a4,0(a5)
				s++;
80000f68:	fec42783          	lw	a5,-20(s0)
80000f6c:	00178793          	addi	a5,a5,1
80000f70:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
80000f74:	fec42783          	lw	a5,-20(s0)
80000f78:	0007c783          	lbu	a5,0(a5)
80000f7c:	faf40fa3          	sb	a5,-65(s0)
80000f80:	fbf44783          	lbu	a5,-65(s0)
80000f84:	c80794e3          	bnez	a5,80000c0c <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80000f88:	8000c7b7          	lui	a5,0x8000c
80000f8c:	00478713          	addi	a4,a5,4 # 8000c004 <memend+0xf800c004>
80000f90:	fe442783          	lw	a5,-28(s0)
80000f94:	00f707b3          	add	a5,a4,a5
80000f98:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
80000f9c:	8000c7b7          	lui	a5,0x8000c
80000fa0:	00478513          	addi	a0,a5,4 # 8000c004 <memend+0xf800c004>
80000fa4:	805ff0ef          	jal	ra,800007a8 <uartputs>
	return idx;
80000fa8:	fe442783          	lw	a5,-28(s0)
80000fac:	00078513          	mv	a0,a5
80000fb0:	05c12083          	lw	ra,92(sp)
80000fb4:	05812403          	lw	s0,88(sp)
80000fb8:	08010113          	addi	sp,sp,128
80000fbc:	00008067          	ret

80000fc0 <minit>:
struct
{
    struct pmp* freelist;
}mem;

void minit(){
80000fc0:	fe010113          	addi	sp,sp,-32
80000fc4:	00812e23          	sw	s0,28(sp)
80000fc8:	02010413          	addi	s0,sp,32
        printf("mstart:%p   ",mstart);
        printf("mend:%p\n",mend);
        printf("stack:%p\n",stacks);
    #endif

    char* p=(char*)mstart;
80000fcc:	8000d7b7          	lui	a5,0x8000d
80000fd0:	00078793          	mv	a5,a5
80000fd4:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80000fd8:	0380006f          	j	80001010 <minit+0x50>
        m=(struct pmp*)p;
80000fdc:	fec42783          	lw	a5,-20(s0)
80000fe0:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
80000fe4:	8000c7b7          	lui	a5,0x8000c
80000fe8:	4047a703          	lw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
80000fec:	fe842783          	lw	a5,-24(s0)
80000ff0:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
80000ff4:	8000c7b7          	lui	a5,0x8000c
80000ff8:	fe842703          	lw	a4,-24(s0)
80000ffc:	40e7a223          	sw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001000:	fec42703          	lw	a4,-20(s0)
80001004:	000017b7          	lui	a5,0x1
80001008:	00f707b3          	add	a5,a4,a5
8000100c:	fef42623          	sw	a5,-20(s0)
80001010:	fec42703          	lw	a4,-20(s0)
80001014:	000017b7          	lui	a5,0x1
80001018:	00f70733          	add	a4,a4,a5
8000101c:	880007b7          	lui	a5,0x88000
80001020:	00078793          	mv	a5,a5
80001024:	fae7fce3          	bgeu	a5,a4,80000fdc <minit+0x1c>
    }
}
80001028:	00000013          	nop
8000102c:	00000013          	nop
80001030:	01c12403          	lw	s0,28(sp)
80001034:	02010113          	addi	sp,sp,32
80001038:	00008067          	ret

8000103c <palloc>:

void* palloc(){
8000103c:	fe010113          	addi	sp,sp,-32
80001040:	00112e23          	sw	ra,28(sp)
80001044:	00812c23          	sw	s0,24(sp)
80001048:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
8000104c:	8000c7b7          	lui	a5,0x8000c
80001050:	4047a783          	lw	a5,1028(a5) # 8000c404 <memend+0xf800c404>
80001054:	fef42623          	sw	a5,-20(s0)
    if(p)
80001058:	fec42783          	lw	a5,-20(s0)
8000105c:	00078c63          	beqz	a5,80001074 <palloc+0x38>
        mem.freelist=mem.freelist->next;
80001060:	8000c7b7          	lui	a5,0x8000c
80001064:	4047a783          	lw	a5,1028(a5) # 8000c404 <memend+0xf800c404>
80001068:	0007a703          	lw	a4,0(a5)
8000106c:	8000c7b7          	lui	a5,0x8000c
80001070:	40e7a223          	sw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
    if(p)
80001074:	fec42783          	lw	a5,-20(s0)
80001078:	00078a63          	beqz	a5,8000108c <palloc+0x50>
        memset(p,0,PGSIZE);
8000107c:	00001637          	lui	a2,0x1
80001080:	00000593          	li	a1,0
80001084:	fec42503          	lw	a0,-20(s0)
80001088:	195000ef          	jal	ra,80001a1c <memset>
    return (void*)p;
8000108c:	fec42783          	lw	a5,-20(s0)
}
80001090:	00078513          	mv	a0,a5
80001094:	01c12083          	lw	ra,28(sp)
80001098:	01812403          	lw	s0,24(sp)
8000109c:	02010113          	addi	sp,sp,32
800010a0:	00008067          	ret

800010a4 <pfree>:

void pfree(void* addr){
800010a4:	fd010113          	addi	sp,sp,-48
800010a8:	02812623          	sw	s0,44(sp)
800010ac:	03010413          	addi	s0,sp,48
800010b0:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
800010b4:	fdc42783          	lw	a5,-36(s0)
800010b8:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
800010bc:	8000c7b7          	lui	a5,0x8000c
800010c0:	4047a703          	lw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
800010c4:	fec42783          	lw	a5,-20(s0)
800010c8:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
800010cc:	8000c7b7          	lui	a5,0x8000c
800010d0:	fec42703          	lw	a4,-20(s0)
800010d4:	40e7a223          	sw	a4,1028(a5) # 8000c404 <memend+0xf800c404>
800010d8:	00000013          	nop
800010dc:	02c12403          	lw	s0,44(sp)
800010e0:	03010113          	addi	sp,sp,48
800010e4:	00008067          	ret

800010e8 <r_tp>:
static inline uint32 r_tp(){
800010e8:	fe010113          	addi	sp,sp,-32
800010ec:	00812e23          	sw	s0,28(sp)
800010f0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800010f4:	00020793          	mv	a5,tp
800010f8:	fef42623          	sw	a5,-20(s0)
    return x;
800010fc:	fec42783          	lw	a5,-20(s0)
}
80001100:	00078513          	mv	a0,a5
80001104:	01c12403          	lw	s0,28(sp)
80001108:	02010113          	addi	sp,sp,32
8000110c:	00008067          	ret

80001110 <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
80001110:	fe010113          	addi	sp,sp,-32
80001114:	00812e23          	sw	s0,28(sp)
80001118:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
8000111c:	104027f3          	csrr	a5,sie
80001120:	fef42623          	sw	a5,-20(s0)
    return x;
80001124:	fec42783          	lw	a5,-20(s0)
}
80001128:	00078513          	mv	a0,a5
8000112c:	01c12403          	lw	s0,28(sp)
80001130:	02010113          	addi	sp,sp,32
80001134:	00008067          	ret

80001138 <w_sie>:
static inline void w_sie(uint32 x){
80001138:	fe010113          	addi	sp,sp,-32
8000113c:	00812e23          	sw	s0,28(sp)
80001140:	02010413          	addi	s0,sp,32
80001144:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80001148:	fec42783          	lw	a5,-20(s0)
8000114c:	10479073          	csrw	sie,a5
}
80001150:	00000013          	nop
80001154:	01c12403          	lw	s0,28(sp)
80001158:	02010113          	addi	sp,sp,32
8000115c:	00008067          	ret

80001160 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
80001160:	ff010113          	addi	sp,sp,-16
80001164:	00112623          	sw	ra,12(sp)
80001168:	00812423          	sw	s0,8(sp)
8000116c:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
80001170:	0c0007b7          	lui	a5,0xc000
80001174:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001178:	00100713          	li	a4,1
8000117c:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001180:	f69ff0ef          	jal	ra,800010e8 <r_tp>
80001184:	00050793          	mv	a5,a0
80001188:	00879713          	slli	a4,a5,0x8
8000118c:	0c0027b7          	lui	a5,0xc002
80001190:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001194:	00f707b3          	add	a5,a4,a5
80001198:	00078713          	mv	a4,a5
8000119c:	40000793          	li	a5,1024
800011a0:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800011a4:	f45ff0ef          	jal	ra,800010e8 <r_tp>
800011a8:	00050713          	mv	a4,a0
800011ac:	000c07b7          	lui	a5,0xc0
800011b0:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800011b4:	00f707b3          	add	a5,a4,a5
800011b8:	00879793          	slli	a5,a5,0x8
800011bc:	00078713          	mv	a4,a5
800011c0:	40000793          	li	a5,1024
800011c4:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
800011c8:	f21ff0ef          	jal	ra,800010e8 <r_tp>
800011cc:	00050713          	mv	a4,a0
800011d0:	000067b7          	lui	a5,0x6
800011d4:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800011d8:	00f707b3          	add	a5,a4,a5
800011dc:	00d79793          	slli	a5,a5,0xd
800011e0:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800011e4:	f05ff0ef          	jal	ra,800010e8 <r_tp>
800011e8:	00050793          	mv	a5,a0
800011ec:	00d79713          	slli	a4,a5,0xd
800011f0:	0c2017b7          	lui	a5,0xc201
800011f4:	00f707b3          	add	a5,a4,a5
800011f8:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800011fc:	f15ff0ef          	jal	ra,80001110 <r_sie>
80001200:	00050793          	mv	a5,a0
80001204:	2227e793          	ori	a5,a5,546
80001208:	00078513          	mv	a0,a5
8000120c:	f2dff0ef          	jal	ra,80001138 <w_sie>
}
80001210:	00000013          	nop
80001214:	00c12083          	lw	ra,12(sp)
80001218:	00812403          	lw	s0,8(sp)
8000121c:	01010113          	addi	sp,sp,16
80001220:	00008067          	ret

80001224 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80001224:	ff010113          	addi	sp,sp,-16
80001228:	00112623          	sw	ra,12(sp)
8000122c:	00812423          	sw	s0,8(sp)
80001230:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001234:	eb5ff0ef          	jal	ra,800010e8 <r_tp>
80001238:	00050793          	mv	a5,a0
8000123c:	00d79713          	slli	a4,a5,0xd
80001240:	0c2017b7          	lui	a5,0xc201
80001244:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001248:	00f707b3          	add	a5,a4,a5
8000124c:	0007a783          	lw	a5,0(a5)
}
80001250:	00078513          	mv	a0,a5
80001254:	00c12083          	lw	ra,12(sp)
80001258:	00812403          	lw	s0,8(sp)
8000125c:	01010113          	addi	sp,sp,16
80001260:	00008067          	ret

80001264 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001264:	fe010113          	addi	sp,sp,-32
80001268:	00112e23          	sw	ra,28(sp)
8000126c:	00812c23          	sw	s0,24(sp)
80001270:	02010413          	addi	s0,sp,32
80001274:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80001278:	e71ff0ef          	jal	ra,800010e8 <r_tp>
8000127c:	00050793          	mv	a5,a0
80001280:	00d79713          	slli	a4,a5,0xd
80001284:	0c2007b7          	lui	a5,0xc200
80001288:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
8000128c:	00f707b3          	add	a5,a4,a5
80001290:	00078713          	mv	a4,a5
80001294:	fec42783          	lw	a5,-20(s0)
80001298:	00f72023          	sw	a5,0(a4)
8000129c:	00000013          	nop
800012a0:	01c12083          	lw	ra,28(sp)
800012a4:	01812403          	lw	s0,24(sp)
800012a8:	02010113          	addi	sp,sp,32
800012ac:	00008067          	ret

800012b0 <w_satp>:
static inline void w_satp(uint32 x){
800012b0:	fe010113          	addi	sp,sp,-32
800012b4:	00812e23          	sw	s0,28(sp)
800012b8:	02010413          	addi	s0,sp,32
800012bc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800012c0:	fec42783          	lw	a5,-20(s0)
800012c4:	18079073          	csrw	satp,a5
}
800012c8:	00000013          	nop
800012cc:	01c12403          	lw	s0,28(sp)
800012d0:	02010113          	addi	sp,sp,32
800012d4:	00008067          	ret

800012d8 <sfence_vma>:
static inline void sfence_vma(){
800012d8:	ff010113          	addi	sp,sp,-16
800012dc:	00812623          	sw	s0,12(sp)
800012e0:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800012e4:	12000073          	sfence.vma
}
800012e8:	00000013          	nop
800012ec:	00c12403          	lw	s0,12(sp)
800012f0:	01010113          	addi	sp,sp,16
800012f4:	00008067          	ret

800012f8 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
800012f8:	fd010113          	addi	sp,sp,-48
800012fc:	02112623          	sw	ra,44(sp)
80001300:	02812423          	sw	s0,40(sp)
80001304:	03010413          	addi	s0,sp,48
80001308:	fca42e23          	sw	a0,-36(s0)
8000130c:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
80001310:	fd842783          	lw	a5,-40(s0)
80001314:	0167d793          	srli	a5,a5,0x16
80001318:	00279793          	slli	a5,a5,0x2
8000131c:	fdc42703          	lw	a4,-36(s0)
80001320:	00f707b3          	add	a5,a4,a5
80001324:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001328:	fec42783          	lw	a5,-20(s0)
8000132c:	0007a783          	lw	a5,0(a5)
80001330:	0017f793          	andi	a5,a5,1
80001334:	00078e63          	beqz	a5,80001350 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001338:	fec42783          	lw	a5,-20(s0)
8000133c:	0007a783          	lw	a5,0(a5)
80001340:	00a7d793          	srli	a5,a5,0xa
80001344:	00c79793          	slli	a5,a5,0xc
80001348:	fcf42e23          	sw	a5,-36(s0)
8000134c:	0340006f          	j	80001380 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
80001350:	cedff0ef          	jal	ra,8000103c <palloc>
80001354:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001358:	00001637          	lui	a2,0x1
8000135c:	00000593          	li	a1,0
80001360:	fdc42503          	lw	a0,-36(s0)
80001364:	6b8000ef          	jal	ra,80001a1c <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001368:	fdc42783          	lw	a5,-36(s0)
8000136c:	00c7d793          	srli	a5,a5,0xc
80001370:	00a79793          	slli	a5,a5,0xa
80001374:	0017e713          	ori	a4,a5,1
80001378:	fec42783          	lw	a5,-20(s0)
8000137c:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001380:	fd842783          	lw	a5,-40(s0)
80001384:	00c7d793          	srli	a5,a5,0xc
80001388:	3ff7f793          	andi	a5,a5,1023
8000138c:	00279793          	slli	a5,a5,0x2
80001390:	fdc42703          	lw	a4,-36(s0)
80001394:	00f707b3          	add	a5,a4,a5
}
80001398:	00078513          	mv	a0,a5
8000139c:	02c12083          	lw	ra,44(sp)
800013a0:	02812403          	lw	s0,40(sp)
800013a4:	03010113          	addi	sp,sp,48
800013a8:	00008067          	ret

800013ac <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
800013ac:	fc010113          	addi	sp,sp,-64
800013b0:	02112e23          	sw	ra,60(sp)
800013b4:	02812c23          	sw	s0,56(sp)
800013b8:	04010413          	addi	s0,sp,64
800013bc:	fca42e23          	sw	a0,-36(s0)
800013c0:	fcb42c23          	sw	a1,-40(s0)
800013c4:	fcc42a23          	sw	a2,-44(s0)
800013c8:	fcd42823          	sw	a3,-48(s0)
800013cc:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
800013d0:	fd842703          	lw	a4,-40(s0)
800013d4:	fffff7b7          	lui	a5,0xfffff
800013d8:	00f777b3          	and	a5,a4,a5
800013dc:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
800013e0:	fd042703          	lw	a4,-48(s0)
800013e4:	fd842783          	lw	a5,-40(s0)
800013e8:	00f707b3          	add	a5,a4,a5
800013ec:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
800013f0:	fffff7b7          	lui	a5,0xfffff
800013f4:	00f777b3          	and	a5,a4,a5
800013f8:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
800013fc:	fec42583          	lw	a1,-20(s0)
80001400:	fdc42503          	lw	a0,-36(s0)
80001404:	ef5ff0ef          	jal	ra,800012f8 <acquriepte>
80001408:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
8000140c:	fe442783          	lw	a5,-28(s0)
80001410:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001414:	0017f793          	andi	a5,a5,1
80001418:	00078863          	beqz	a5,80001428 <vmmap+0x7c>
            panic("repeat map");
8000141c:	800027b7          	lui	a5,0x80002
80001420:	33878513          	addi	a0,a5,824 # 80002338 <memend+0xf8002338>
80001424:	f58ff0ef          	jal	ra,80000b7c <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001428:	fd442783          	lw	a5,-44(s0)
8000142c:	00c7d793          	srli	a5,a5,0xc
80001430:	00a79713          	slli	a4,a5,0xa
80001434:	fcc42783          	lw	a5,-52(s0)
80001438:	00f767b3          	or	a5,a4,a5
8000143c:	0017e713          	ori	a4,a5,1
80001440:	fe442783          	lw	a5,-28(s0)
80001444:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001448:	fec42703          	lw	a4,-20(s0)
8000144c:	fe842783          	lw	a5,-24(s0)
80001450:	02f70463          	beq	a4,a5,80001478 <vmmap+0xcc>
        start += PGSIZE;
80001454:	fec42703          	lw	a4,-20(s0)
80001458:	000017b7          	lui	a5,0x1
8000145c:	00f707b3          	add	a5,a4,a5
80001460:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001464:	fd442703          	lw	a4,-44(s0)
80001468:	000017b7          	lui	a5,0x1
8000146c:	00f707b3          	add	a5,a4,a5
80001470:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001474:	f89ff06f          	j	800013fc <vmmap+0x50>
        if(start==end)  break;
80001478:	00000013          	nop
    }
}
8000147c:	00000013          	nop
80001480:	03c12083          	lw	ra,60(sp)
80001484:	03812403          	lw	s0,56(sp)
80001488:	04010113          	addi	sp,sp,64
8000148c:	00008067          	ret

80001490 <printpgt>:

void printpgt(addr_t* pgt){
80001490:	fc010113          	addi	sp,sp,-64
80001494:	02112e23          	sw	ra,60(sp)
80001498:	02812c23          	sw	s0,56(sp)
8000149c:	04010413          	addi	s0,sp,64
800014a0:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
800014a4:	fe042623          	sw	zero,-20(s0)
800014a8:	0c40006f          	j	8000156c <printpgt+0xdc>
        pte_t pte=pgt[i];
800014ac:	fec42783          	lw	a5,-20(s0)
800014b0:	00279793          	slli	a5,a5,0x2
800014b4:	fcc42703          	lw	a4,-52(s0)
800014b8:	00f707b3          	add	a5,a4,a5
800014bc:	0007a783          	lw	a5,0(a5) # 1000 <sz>
800014c0:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
800014c4:	fe442783          	lw	a5,-28(s0)
800014c8:	0017f793          	andi	a5,a5,1
800014cc:	08078a63          	beqz	a5,80001560 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
800014d0:	fe442783          	lw	a5,-28(s0)
800014d4:	00a7d793          	srli	a5,a5,0xa
800014d8:	00c79793          	slli	a5,a5,0xc
800014dc:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
800014e0:	fe042683          	lw	a3,-32(s0)
800014e4:	fe442603          	lw	a2,-28(s0)
800014e8:	fec42583          	lw	a1,-20(s0)
800014ec:	800027b7          	lui	a5,0x80002
800014f0:	34478513          	addi	a0,a5,836 # 80002344 <memend+0xf8002344>
800014f4:	ec0ff0ef          	jal	ra,80000bb4 <printf>
            for(int j=0;j<1024;j++){
800014f8:	fe042423          	sw	zero,-24(s0)
800014fc:	0580006f          	j	80001554 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001500:	fe842783          	lw	a5,-24(s0)
80001504:	00279793          	slli	a5,a5,0x2
80001508:	fe042703          	lw	a4,-32(s0)
8000150c:	00f707b3          	add	a5,a4,a5
80001510:	0007a783          	lw	a5,0(a5)
80001514:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001518:	fdc42783          	lw	a5,-36(s0)
8000151c:	0017f793          	andi	a5,a5,1
80001520:	02078463          	beqz	a5,80001548 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001524:	fdc42783          	lw	a5,-36(s0)
80001528:	00a7d793          	srli	a5,a5,0xa
8000152c:	00c79793          	slli	a5,a5,0xc
80001530:	00078693          	mv	a3,a5
80001534:	fdc42603          	lw	a2,-36(s0)
80001538:	fe842583          	lw	a1,-24(s0)
8000153c:	800027b7          	lui	a5,0x80002
80001540:	35c78513          	addi	a0,a5,860 # 8000235c <memend+0xf800235c>
80001544:	e70ff0ef          	jal	ra,80000bb4 <printf>
            for(int j=0;j<1024;j++){
80001548:	fe842783          	lw	a5,-24(s0)
8000154c:	00178793          	addi	a5,a5,1
80001550:	fef42423          	sw	a5,-24(s0)
80001554:	fe842703          	lw	a4,-24(s0)
80001558:	3ff00793          	li	a5,1023
8000155c:	fae7d2e3          	bge	a5,a4,80001500 <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001560:	fec42783          	lw	a5,-20(s0)
80001564:	00178793          	addi	a5,a5,1
80001568:	fef42623          	sw	a5,-20(s0)
8000156c:	fec42703          	lw	a4,-20(s0)
80001570:	3ff00793          	li	a5,1023
80001574:	f2e7dce3          	bge	a5,a4,800014ac <printpgt+0x1c>
                }
            }
        }
    }
}
80001578:	00000013          	nop
8000157c:	00000013          	nop
80001580:	03c12083          	lw	ra,60(sp)
80001584:	03812403          	lw	s0,56(sp)
80001588:	04010113          	addi	sp,sp,64
8000158c:	00008067          	ret

80001590 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
80001590:	fd010113          	addi	sp,sp,-48
80001594:	02112623          	sw	ra,44(sp)
80001598:	02812423          	sw	s0,40(sp)
8000159c:	03010413          	addi	s0,sp,48
800015a0:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
800015a4:	fe042623          	sw	zero,-20(s0)
800015a8:	04c0006f          	j	800015f4 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
800015ac:	fec42783          	lw	a5,-20(s0)
800015b0:	00d79793          	slli	a5,a5,0xd
800015b4:	00078713          	mv	a4,a5
800015b8:	c00017b7          	lui	a5,0xc0001
800015bc:	00f707b3          	add	a5,a4,a5
800015c0:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
800015c4:	a79ff0ef          	jal	ra,8000103c <palloc>
800015c8:	00050793          	mv	a5,a0
800015cc:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
800015d0:	00600713          	li	a4,6
800015d4:	000016b7          	lui	a3,0x1
800015d8:	fe442603          	lw	a2,-28(s0)
800015dc:	fe842583          	lw	a1,-24(s0)
800015e0:	fdc42503          	lw	a0,-36(s0)
800015e4:	dc9ff0ef          	jal	ra,800013ac <vmmap>
    for(int i=0;i<NPROC;i++){
800015e8:	fec42783          	lw	a5,-20(s0)
800015ec:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
800015f0:	fef42623          	sw	a5,-20(s0)
800015f4:	fec42703          	lw	a4,-20(s0)
800015f8:	00300793          	li	a5,3
800015fc:	fae7d8e3          	bge	a5,a4,800015ac <mkstack+0x1c>
    }
}
80001600:	00000013          	nop
80001604:	00000013          	nop
80001608:	02c12083          	lw	ra,44(sp)
8000160c:	02812403          	lw	s0,40(sp)
80001610:	03010113          	addi	sp,sp,48
80001614:	00008067          	ret

80001618 <vminit>:

// 初始化虚拟内存
void vminit(){
80001618:	ff010113          	addi	sp,sp,-16
8000161c:	00112623          	sw	ra,12(sp)
80001620:	00812423          	sw	s0,8(sp)
80001624:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001628:	a15ff0ef          	jal	ra,8000103c <palloc>
8000162c:	00050713          	mv	a4,a0
80001630:	8000c7b7          	lui	a5,0x8000c
80001634:	62e7ac23          	sw	a4,1592(a5) # 8000c638 <memend+0xf800c638>
    memset(kpgt,0,PGSIZE);
80001638:	8000c7b7          	lui	a5,0x8000c
8000163c:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
80001640:	00001637          	lui	a2,0x1
80001644:	00000593          	li	a1,0
80001648:	00078513          	mv	a0,a5
8000164c:	3d0000ef          	jal	ra,80001a1c <memset>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
80001650:	8000c7b7          	lui	a5,0x8000c
80001654:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
80001658:	00600713          	li	a4,6
8000165c:	004006b7          	lui	a3,0x400
80001660:	0c000637          	lui	a2,0xc000
80001664:	0c0005b7          	lui	a1,0xc000
80001668:	00078513          	mv	a0,a5
8000166c:	d41ff0ef          	jal	ra,800013ac <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
80001670:	8000c7b7          	lui	a5,0x8000c
80001674:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
80001678:	00600713          	li	a4,6
8000167c:	000016b7          	lui	a3,0x1
80001680:	10000637          	lui	a2,0x10000
80001684:	100005b7          	lui	a1,0x10000
80001688:	00078513          	mv	a0,a5
8000168c:	d21ff0ef          	jal	ra,800013ac <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
80001690:	8000c7b7          	lui	a5,0x8000c
80001694:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001698:	800007b7          	lui	a5,0x80000
8000169c:	00078593          	mv	a1,a5
800016a0:	800007b7          	lui	a5,0x80000
800016a4:	00078613          	mv	a2,a5
800016a8:	800027b7          	lui	a5,0x80002
800016ac:	c6c78713          	addi	a4,a5,-916 # 80001c6c <memend+0xf8001c6c>
800016b0:	800007b7          	lui	a5,0x80000
800016b4:	00078793          	mv	a5,a5
800016b8:	40f707b3          	sub	a5,a4,a5
800016bc:	00a00713          	li	a4,10
800016c0:	00078693          	mv	a3,a5
800016c4:	ce9ff0ef          	jal	ra,800013ac <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
800016c8:	8000c7b7          	lui	a5,0x8000c
800016cc:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
800016d0:	800027b7          	lui	a5,0x80002
800016d4:	00078593          	mv	a1,a5
800016d8:	800027b7          	lui	a5,0x80002
800016dc:	00078613          	mv	a2,a5
800016e0:	800027b7          	lui	a5,0x80002
800016e4:	37378713          	addi	a4,a5,883 # 80002373 <memend+0xf8002373>
800016e8:	800027b7          	lui	a5,0x80002
800016ec:	00078793          	mv	a5,a5
800016f0:	40f707b3          	sub	a5,a4,a5
800016f4:	00200713          	li	a4,2
800016f8:	00078693          	mv	a3,a5
800016fc:	cb1ff0ef          	jal	ra,800013ac <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001700:	8000c7b7          	lui	a5,0x8000c
80001704:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001708:	800037b7          	lui	a5,0x80003
8000170c:	00078593          	mv	a1,a5
80001710:	800037b7          	lui	a5,0x80003
80001714:	00078613          	mv	a2,a5
80001718:	8000b7b7          	lui	a5,0x8000b
8000171c:	00478713          	addi	a4,a5,4 # 8000b004 <memend+0xf800b004>
80001720:	800037b7          	lui	a5,0x80003
80001724:	00078793          	mv	a5,a5
80001728:	40f707b3          	sub	a5,a4,a5
8000172c:	00600713          	li	a4,6
80001730:	00078693          	mv	a3,a5
80001734:	c79ff0ef          	jal	ra,800013ac <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001738:	8000c7b7          	lui	a5,0x8000c
8000173c:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001740:	8000c7b7          	lui	a5,0x8000c
80001744:	00078593          	mv	a1,a5
80001748:	8000c7b7          	lui	a5,0x8000c
8000174c:	00078613          	mv	a2,a5
80001750:	8000c7b7          	lui	a5,0x8000c
80001754:	67c78713          	addi	a4,a5,1660 # 8000c67c <memend+0xf800c67c>
80001758:	8000c7b7          	lui	a5,0x8000c
8000175c:	00078793          	mv	a5,a5
80001760:	40f707b3          	sub	a5,a4,a5
80001764:	00600713          	li	a4,6
80001768:	00078693          	mv	a3,a5
8000176c:	c41ff0ef          	jal	ra,800013ac <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001770:	8000c7b7          	lui	a5,0x8000c
80001774:	6387a503          	lw	a0,1592(a5) # 8000c638 <memend+0xf800c638>
80001778:	8000d7b7          	lui	a5,0x8000d
8000177c:	00078593          	mv	a1,a5
80001780:	8000d7b7          	lui	a5,0x8000d
80001784:	00078613          	mv	a2,a5
80001788:	880007b7          	lui	a5,0x88000
8000178c:	00078713          	mv	a4,a5
80001790:	8000d7b7          	lui	a5,0x8000d
80001794:	00078793          	mv	a5,a5
80001798:	40f707b3          	sub	a5,a4,a5
8000179c:	00600713          	li	a4,6
800017a0:	00078693          	mv	a3,a5
800017a4:	c09ff0ef          	jal	ra,800013ac <vmmap>

    mkstack(kpgt);
800017a8:	8000c7b7          	lui	a5,0x8000c
800017ac:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
800017b0:	00078513          	mv	a0,a5
800017b4:	dddff0ef          	jal	ra,80001590 <mkstack>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
800017b8:	8000c7b7          	lui	a5,0x8000c
800017bc:	6387a783          	lw	a5,1592(a5) # 8000c638 <memend+0xf800c638>
800017c0:	00c7d713          	srli	a4,a5,0xc
800017c4:	800007b7          	lui	a5,0x80000
800017c8:	00f767b3          	or	a5,a4,a5
800017cc:	00078513          	mv	a0,a5
800017d0:	ae1ff0ef          	jal	ra,800012b0 <w_satp>
    sfence_vma();       // 刷新页表
800017d4:	b05ff0ef          	jal	ra,800012d8 <sfence_vma>
}
800017d8:	00000013          	nop
800017dc:	00c12083          	lw	ra,12(sp)
800017e0:	00812403          	lw	s0,8(sp)
800017e4:	01010113          	addi	sp,sp,16
800017e8:	00008067          	ret

800017ec <pgtcreate>:

addr_t* pgtcreate(){
800017ec:	fe010113          	addi	sp,sp,-32
800017f0:	00112e23          	sw	ra,28(sp)
800017f4:	00812c23          	sw	s0,24(sp)
800017f8:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
800017fc:	841ff0ef          	jal	ra,8000103c <palloc>
80001800:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001804:	fec42783          	lw	a5,-20(s0)
}
80001808:	00078513          	mv	a0,a5
8000180c:	01c12083          	lw	ra,28(sp)
80001810:	01812403          	lw	s0,24(sp)
80001814:	02010113          	addi	sp,sp,32
80001818:	00008067          	ret

8000181c <procinit>:
#include "vm.h"
#include "defs.h"

uint nextpid=0;

void procinit(){
8000181c:	fe010113          	addi	sp,sp,-32
80001820:	00812e23          	sw	s0,28(sp)
80001824:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001828:	fe042623          	sw	zero,-20(s0)
8000182c:	0480006f          	j	80001874 <procinit+0x58>
        p=&proc[i];
80001830:	fec42703          	lw	a4,-20(s0)
80001834:	08c00793          	li	a5,140
80001838:	02f70733          	mul	a4,a4,a5
8000183c:	8000c7b7          	lui	a5,0x8000c
80001840:	40878793          	addi	a5,a5,1032 # 8000c408 <memend+0xf800c408>
80001844:	00f707b3          	add	a5,a4,a5
80001848:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
8000184c:	fec42783          	lw	a5,-20(s0)
80001850:	00d79793          	slli	a5,a5,0xd
80001854:	00078713          	mv	a4,a5
80001858:	c00027b7          	lui	a5,0xc0002
8000185c:	00f70733          	add	a4,a4,a5
80001860:	fe842783          	lw	a5,-24(s0)
80001864:	08e7a423          	sw	a4,136(a5) # c0002088 <memend+0x38002088>
    for(int i=0;i<NPROC;i++){
80001868:	fec42783          	lw	a5,-20(s0)
8000186c:	00178793          	addi	a5,a5,1
80001870:	fef42623          	sw	a5,-20(s0)
80001874:	fec42703          	lw	a4,-20(s0)
80001878:	00300793          	li	a5,3
8000187c:	fae7dae3          	bge	a5,a4,80001830 <procinit+0x14>
    }
}
80001880:	00000013          	nop
80001884:	00000013          	nop
80001888:	01c12403          	lw	s0,28(sp)
8000188c:	02010113          	addi	sp,sp,32
80001890:	00008067          	ret

80001894 <pidalloc>:

uint pidalloc(){
80001894:	ff010113          	addi	sp,sp,-16
80001898:	00812623          	sw	s0,12(sp)
8000189c:	01010413          	addi	s0,sp,16
    return nextpid++;
800018a0:	8000c7b7          	lui	a5,0x8000c
800018a4:	0007a783          	lw	a5,0(a5) # 8000c000 <memend+0xf800c000>
800018a8:	00178693          	addi	a3,a5,1
800018ac:	8000c737          	lui	a4,0x8000c
800018b0:	00d72023          	sw	a3,0(a4) # 8000c000 <memend+0xf800c000>
} 
800018b4:	00078513          	mv	a0,a5
800018b8:	00c12403          	lw	s0,12(sp)
800018bc:	01010113          	addi	sp,sp,16
800018c0:	00008067          	ret

800018c4 <procalloc>:

struct pcb* procalloc(){
800018c4:	fe010113          	addi	sp,sp,-32
800018c8:	00112e23          	sw	ra,28(sp)
800018cc:	00812c23          	sw	s0,24(sp)
800018d0:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
800018d4:	8000c7b7          	lui	a5,0x8000c
800018d8:	40878793          	addi	a5,a5,1032 # 8000c408 <memend+0xf800c408>
800018dc:	fef42623          	sw	a5,-20(s0)
800018e0:	0540006f          	j	80001934 <procalloc+0x70>
        if(p->status==UNUSED){
800018e4:	fec42783          	lw	a5,-20(s0)
800018e8:	0047a783          	lw	a5,4(a5)
800018ec:	02079e63          	bnez	a5,80001928 <procalloc+0x64>
            p->pid=pidalloc();
800018f0:	fa5ff0ef          	jal	ra,80001894 <pidalloc>
800018f4:	00050793          	mv	a5,a0
800018f8:	00078713          	mv	a4,a5
800018fc:	fec42783          	lw	a5,-20(s0)
80001900:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80001904:	fec42783          	lw	a5,-20(s0)
80001908:	00100713          	li	a4,1
8000190c:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
80001910:	eddff0ef          	jal	ra,800017ec <pgtcreate>
80001914:	00050713          	mv	a4,a0
80001918:	fec42783          	lw	a5,-20(s0)
8000191c:	08e7a223          	sw	a4,132(a5)
            return p;
80001920:	fec42783          	lw	a5,-20(s0)
80001924:	0240006f          	j	80001948 <procalloc+0x84>
    for(p=proc;p<&proc[NPROC];p++){
80001928:	fec42783          	lw	a5,-20(s0)
8000192c:	08c78793          	addi	a5,a5,140
80001930:	fef42623          	sw	a5,-20(s0)
80001934:	fec42703          	lw	a4,-20(s0)
80001938:	8000c7b7          	lui	a5,0x8000c
8000193c:	63878793          	addi	a5,a5,1592 # 8000c638 <memend+0xf800c638>
80001940:	faf762e3          	bltu	a4,a5,800018e4 <procalloc+0x20>
        }
    }
    return 0;
80001944:	00000793          	li	a5,0
}
80001948:	00078513          	mv	a0,a5
8000194c:	01c12083          	lw	ra,28(sp)
80001950:	01812403          	lw	s0,24(sp)
80001954:	02010113          	addi	sp,sp,32
80001958:	00008067          	ret

8000195c <userinit>:

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
8000195c:	fe010113          	addi	sp,sp,-32
80001960:	00112e23          	sw	ra,28(sp)
80001964:	00812c23          	sw	s0,24(sp)
80001968:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
8000196c:	f59ff0ef          	jal	ra,800018c4 <procalloc>
80001970:	fea42623          	sw	a0,-20(s0)
    
    char* m=(char*)palloc();
80001974:	ec8ff0ef          	jal	ra,8000103c <palloc>
80001978:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
8000197c:	00400613          	li	a2,4
80001980:	00000693          	li	a3,0
80001984:	800037b7          	lui	a5,0x80003
80001988:	00078593          	mv	a1,a5
8000198c:	fe842503          	lw	a0,-24(s0)
80001990:	0f8000ef          	jal	ra,80001a88 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X);
80001994:	fec42783          	lw	a5,-20(s0)
80001998:	0847a783          	lw	a5,132(a5) # 80003084 <memend+0xf8003084>
8000199c:	fe842603          	lw	a2,-24(s0)
800019a0:	00e00713          	li	a4,14
800019a4:	000016b7          	lui	a3,0x1
800019a8:	00000593          	li	a1,0
800019ac:	00078513          	mv	a0,a5
800019b0:	9fdff0ef          	jal	ra,800013ac <vmmap>

    p->context.sp=KSPACE;
800019b4:	fec42783          	lw	a5,-20(s0)
800019b8:	c0000737          	lui	a4,0xc0000
800019bc:	00e7a623          	sw	a4,12(a5)

    p->status=RUNABLE;
800019c0:	fec42783          	lw	a5,-20(s0)
800019c4:	00200713          	li	a4,2
800019c8:	00e7a223          	sw	a4,4(a5)
}
800019cc:	00000013          	nop
800019d0:	01c12083          	lw	ra,28(sp)
800019d4:	01812403          	lw	s0,24(sp)
800019d8:	02010113          	addi	sp,sp,32
800019dc:	00008067          	ret

800019e0 <schedule>:

void schedule(){
800019e0:	fe010113          	addi	sp,sp,-32
800019e4:	00812e23          	sw	s0,28(sp)
800019e8:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
800019ec:	8000c7b7          	lui	a5,0x8000c
800019f0:	40878793          	addi	a5,a5,1032 # 8000c408 <memend+0xf800c408>
800019f4:	fef42623          	sw	a5,-20(s0)
800019f8:	0100006f          	j	80001a08 <schedule+0x28>
800019fc:	fec42783          	lw	a5,-20(s0)
80001a00:	08c78793          	addi	a5,a5,140
80001a04:	fef42623          	sw	a5,-20(s0)
80001a08:	fec42703          	lw	a4,-20(s0)
80001a0c:	8000c7b7          	lui	a5,0x8000c
80001a10:	63878793          	addi	a5,a5,1592 # 8000c638 <memend+0xf800c638>
80001a14:	fef764e3          	bltu	a4,a5,800019fc <schedule+0x1c>
    for(;;){
80001a18:	fd5ff06f          	j	800019ec <schedule+0xc>

80001a1c <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80001a1c:	fd010113          	addi	sp,sp,-48
80001a20:	02812623          	sw	s0,44(sp)
80001a24:	03010413          	addi	s0,sp,48
80001a28:	fca42e23          	sw	a0,-36(s0)
80001a2c:	fcb42c23          	sw	a1,-40(s0)
80001a30:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
80001a34:	fdc42783          	lw	a5,-36(s0)
80001a38:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001a3c:	fe042623          	sw	zero,-20(s0)
80001a40:	0280006f          	j	80001a68 <memset+0x4c>
        maddr[i] = (char)c;
80001a44:	fe842703          	lw	a4,-24(s0)
80001a48:	fec42783          	lw	a5,-20(s0)
80001a4c:	00f707b3          	add	a5,a4,a5
80001a50:	fd842703          	lw	a4,-40(s0)
80001a54:	0ff77713          	andi	a4,a4,255
80001a58:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001a5c:	fec42783          	lw	a5,-20(s0)
80001a60:	00178793          	addi	a5,a5,1
80001a64:	fef42623          	sw	a5,-20(s0)
80001a68:	fec42703          	lw	a4,-20(s0)
80001a6c:	fd442783          	lw	a5,-44(s0)
80001a70:	fcf76ae3          	bltu	a4,a5,80001a44 <memset+0x28>
    }
    return addr;
80001a74:	fdc42783          	lw	a5,-36(s0)
}
80001a78:	00078513          	mv	a0,a5
80001a7c:	02c12403          	lw	s0,44(sp)
80001a80:	03010113          	addi	sp,sp,48
80001a84:	00008067          	ret

80001a88 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80001a88:	fd010113          	addi	sp,sp,-48
80001a8c:	02812623          	sw	s0,44(sp)
80001a90:	03010413          	addi	s0,sp,48
80001a94:	fca42e23          	sw	a0,-36(s0)
80001a98:	fcb42c23          	sw	a1,-40(s0)
80001a9c:	fcc42823          	sw	a2,-48(s0)
80001aa0:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001aa4:	fd042783          	lw	a5,-48(s0)
80001aa8:	fd442703          	lw	a4,-44(s0)
80001aac:	00e7e7b3          	or	a5,a5,a4
80001ab0:	00079663          	bnez	a5,80001abc <memmove+0x34>
        return dst;
80001ab4:	fdc42783          	lw	a5,-36(s0)
80001ab8:	1200006f          	j	80001bd8 <memmove+0x150>
    }

    s = src;
80001abc:	fd842783          	lw	a5,-40(s0)
80001ac0:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001ac4:	fdc42783          	lw	a5,-36(s0)
80001ac8:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001acc:	fec42703          	lw	a4,-20(s0)
80001ad0:	fe842783          	lw	a5,-24(s0)
80001ad4:	0cf77263          	bgeu	a4,a5,80001b98 <memmove+0x110>
80001ad8:	fd042783          	lw	a5,-48(s0)
80001adc:	fec42703          	lw	a4,-20(s0)
80001ae0:	00f707b3          	add	a5,a4,a5
80001ae4:	fe842703          	lw	a4,-24(s0)
80001ae8:	0af77863          	bgeu	a4,a5,80001b98 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80001aec:	fd042783          	lw	a5,-48(s0)
80001af0:	fec42703          	lw	a4,-20(s0)
80001af4:	00f707b3          	add	a5,a4,a5
80001af8:	fef42623          	sw	a5,-20(s0)
        d += n;
80001afc:	fd042783          	lw	a5,-48(s0)
80001b00:	fe842703          	lw	a4,-24(s0)
80001b04:	00f707b3          	add	a5,a4,a5
80001b08:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80001b0c:	02c0006f          	j	80001b38 <memmove+0xb0>
            *--d = *--s;
80001b10:	fec42783          	lw	a5,-20(s0)
80001b14:	fff78793          	addi	a5,a5,-1
80001b18:	fef42623          	sw	a5,-20(s0)
80001b1c:	fe842783          	lw	a5,-24(s0)
80001b20:	fff78793          	addi	a5,a5,-1
80001b24:	fef42423          	sw	a5,-24(s0)
80001b28:	fec42783          	lw	a5,-20(s0)
80001b2c:	0007c703          	lbu	a4,0(a5)
80001b30:	fe842783          	lw	a5,-24(s0)
80001b34:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80001b38:	fd042703          	lw	a4,-48(s0)
80001b3c:	fd442783          	lw	a5,-44(s0)
80001b40:	fff00513          	li	a0,-1
80001b44:	fff00593          	li	a1,-1
80001b48:	00a70633          	add	a2,a4,a0
80001b4c:	00060813          	mv	a6,a2
80001b50:	00e83833          	sltu	a6,a6,a4
80001b54:	00b786b3          	add	a3,a5,a1
80001b58:	00d805b3          	add	a1,a6,a3
80001b5c:	00058693          	mv	a3,a1
80001b60:	fcc42823          	sw	a2,-48(s0)
80001b64:	fcd42a23          	sw	a3,-44(s0)
80001b68:	00070693          	mv	a3,a4
80001b6c:	00f6e6b3          	or	a3,a3,a5
80001b70:	fa0690e3          	bnez	a3,80001b10 <memmove+0x88>
    if(s < d && s + n > d){     
80001b74:	0600006f          	j	80001bd4 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80001b78:	fec42703          	lw	a4,-20(s0)
80001b7c:	00170793          	addi	a5,a4,1 # c0000001 <memend+0x38000001>
80001b80:	fef42623          	sw	a5,-20(s0)
80001b84:	fe842783          	lw	a5,-24(s0)
80001b88:	00178693          	addi	a3,a5,1
80001b8c:	fed42423          	sw	a3,-24(s0)
80001b90:	00074703          	lbu	a4,0(a4)
80001b94:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80001b98:	fd042703          	lw	a4,-48(s0)
80001b9c:	fd442783          	lw	a5,-44(s0)
80001ba0:	fff00513          	li	a0,-1
80001ba4:	fff00593          	li	a1,-1
80001ba8:	00a70633          	add	a2,a4,a0
80001bac:	00060813          	mv	a6,a2
80001bb0:	00e83833          	sltu	a6,a6,a4
80001bb4:	00b786b3          	add	a3,a5,a1
80001bb8:	00d805b3          	add	a1,a6,a3
80001bbc:	00058693          	mv	a3,a1
80001bc0:	fcc42823          	sw	a2,-48(s0)
80001bc4:	fcd42a23          	sw	a3,-44(s0)
80001bc8:	00070693          	mv	a3,a4
80001bcc:	00f6e6b3          	or	a3,a3,a5
80001bd0:	fa0694e3          	bnez	a3,80001b78 <memmove+0xf0>
        }
    }
    return dst;
80001bd4:	fdc42783          	lw	a5,-36(s0)
}
80001bd8:	00078513          	mv	a0,a5
80001bdc:	02c12403          	lw	s0,44(sp)
80001be0:	03010113          	addi	sp,sp,48
80001be4:	00008067          	ret

80001be8 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80001be8:	fd010113          	addi	sp,sp,-48
80001bec:	02812623          	sw	s0,44(sp)
80001bf0:	03010413          	addi	s0,sp,48
80001bf4:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80001bf8:	00000793          	li	a5,0
80001bfc:	00000813          	li	a6,0
80001c00:	fef42423          	sw	a5,-24(s0)
80001c04:	ff042623          	sw	a6,-20(s0)
80001c08:	0340006f          	j	80001c3c <strlen+0x54>
80001c0c:	fe842603          	lw	a2,-24(s0)
80001c10:	fec42683          	lw	a3,-20(s0)
80001c14:	00100513          	li	a0,1
80001c18:	00000593          	li	a1,0
80001c1c:	00a60733          	add	a4,a2,a0
80001c20:	00070813          	mv	a6,a4
80001c24:	00c83833          	sltu	a6,a6,a2
80001c28:	00b687b3          	add	a5,a3,a1
80001c2c:	00f806b3          	add	a3,a6,a5
80001c30:	00068793          	mv	a5,a3
80001c34:	fee42423          	sw	a4,-24(s0)
80001c38:	fef42623          	sw	a5,-20(s0)
80001c3c:	fe842783          	lw	a5,-24(s0)
80001c40:	fdc42703          	lw	a4,-36(s0)
80001c44:	00f707b3          	add	a5,a4,a5
80001c48:	0007c783          	lbu	a5,0(a5)
80001c4c:	fc0790e3          	bnez	a5,80001c0c <strlen+0x24>
    
    return n;
80001c50:	fe842703          	lw	a4,-24(s0)
80001c54:	fec42783          	lw	a5,-20(s0)
80001c58:	00070513          	mv	a0,a4
80001c5c:	00078593          	mv	a1,a5
80001c60:	02c12403          	lw	s0,44(sp)
80001c64:	03010113          	addi	sp,sp,48
80001c68:	00008067          	ret
