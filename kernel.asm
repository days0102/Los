
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
80000020:	7040006f          	j	80000724 <start>

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
800000ac:	3dd000ef          	jal	ra,80000c88 <trapvec>

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

80000230 <saveframe>:

// void saveframe(struct trapframe* tf)
.global usertrap
saveframe:
    sw ra,16(a0)
80000230:	00152823          	sw	ra,16(a0)
    sw sp,20(a0)
80000234:	00252a23          	sw	sp,20(a0)
    sw gp,24(a0)
80000238:	00352c23          	sw	gp,24(a0)
    sw tp,28(a0)
8000023c:	00452e23          	sw	tp,28(a0)
    sw a0,32(a0)
80000240:	02a52023          	sw	a0,32(a0)
    sw a1,36(a0)
80000244:	02b52223          	sw	a1,36(a0)
    sw a2,40(a0)
80000248:	02c52423          	sw	a2,40(a0)
    sw a3,44(a0)
8000024c:	02d52623          	sw	a3,44(a0)
    sw a4,48(a0)
80000250:	02e52823          	sw	a4,48(a0)
    sw a5,52(a0)
80000254:	02f52a23          	sw	a5,52(a0)
    sw a6,56(a0)
80000258:	03052c23          	sw	a6,56(a0)
    sw a5,52(a0)
8000025c:	02f52a23          	sw	a5,52(a0)
    sw a7,60(a0)
80000260:	03152e23          	sw	a7,60(a0)
    sw s0,64(a0)
80000264:	04852023          	sw	s0,64(a0)
    sw s1,68(a0)
80000268:	04952223          	sw	s1,68(a0)
    sw s2,72(a0)
8000026c:	05252423          	sw	s2,72(a0)
    sw s3,76(a0)
80000270:	05352623          	sw	s3,76(a0)
    sw s4,80(a0)
80000274:	05452823          	sw	s4,80(a0)
    sw s5,84(a0)
80000278:	05552a23          	sw	s5,84(a0)
    sw s6,88(a0)
8000027c:	05652c23          	sw	s6,88(a0)
    sw s7,92(a0)
80000280:	05752e23          	sw	s7,92(a0)
    sw s8,96(a0)
80000284:	07852023          	sw	s8,96(a0)
    sw s9,100(a0)
80000288:	07952223          	sw	s9,100(a0)
    sw s10,104(a0)
8000028c:	07a52423          	sw	s10,104(a0)
    sw s11,108(a0)
80000290:	07b52623          	sw	s11,108(a0)
    sw t0,112(a0)
80000294:	06552823          	sw	t0,112(a0)
    sw t1,116(a0)
80000298:	06652a23          	sw	t1,116(a0)
    sw t2,120(a0)
8000029c:	06752c23          	sw	t2,120(a0)
    sw t3,124(a0)
800002a0:	07c52e23          	sw	t3,124(a0)
    sw t4,128(a0)
800002a4:	09d52023          	sw	t4,128(a0)
    sw t5,132(a0)
800002a8:	09e52223          	sw	t5,132(a0)
    sw t6,136(a0)
800002ac:	09f52423          	sw	t6,136(a0)

    ret
800002b0:	00008067          	ret

800002b4 <loadframe>:

.global loadframe
loadframe:
    # lw ra,16(a0)
    # lw sp,20(a0)
    lw gp,24(a0)
800002b4:	01852183          	lw	gp,24(a0)
    lw tp,28(a0)
800002b8:	01c52203          	lw	tp,28(a0)
    # lw a0,32(a0)
    lw a1,36(a0)
800002bc:	02452583          	lw	a1,36(a0)
    lw a2,40(a0)
800002c0:	02852603          	lw	a2,40(a0)
    lw a3,44(a0)
800002c4:	02c52683          	lw	a3,44(a0)
    lw a4,48(a0)
800002c8:	03052703          	lw	a4,48(a0)
    lw a5,52(a0)
800002cc:	03452783          	lw	a5,52(a0)
    lw a6,56(a0)
800002d0:	03852803          	lw	a6,56(a0)
    lw a5,52(a0)
800002d4:	03452783          	lw	a5,52(a0)
    lw a7,60(a0)
800002d8:	03c52883          	lw	a7,60(a0)
    lw s0,64(a0)
800002dc:	04052403          	lw	s0,64(a0)
    lw s1,68(a0)
800002e0:	04452483          	lw	s1,68(a0)
    lw s2,72(a0)
800002e4:	04852903          	lw	s2,72(a0)
    lw s3,76(a0)
800002e8:	04c52983          	lw	s3,76(a0)
    lw s4,80(a0)
800002ec:	05052a03          	lw	s4,80(a0)
    lw s5,84(a0)
800002f0:	05452a83          	lw	s5,84(a0)
    lw s6,88(a0)
800002f4:	05852b03          	lw	s6,88(a0)
    lw s7,92(a0)
800002f8:	05c52b83          	lw	s7,92(a0)
    lw s8,96(a0)
800002fc:	06052c03          	lw	s8,96(a0)
    lw s9,100(a0)
80000300:	06452c83          	lw	s9,100(a0)
    lw s10,104(a0)
80000304:	06852d03          	lw	s10,104(a0)
    lw s11,108(a0)
80000308:	06c52d83          	lw	s11,108(a0)
    lw t0,112(a0)
8000030c:	07052283          	lw	t0,112(a0)
    lw t1,116(a0)
80000310:	07452303          	lw	t1,116(a0)
    lw t2,120(a0)
80000314:	07852383          	lw	t2,120(a0)
    lw t3,124(a0)
80000318:	07c52e03          	lw	t3,124(a0)
    lw t4,128(a0)
8000031c:	08052e83          	lw	t4,128(a0)
    lw t5,132(a0)
80000320:	08452f03          	lw	t5,132(a0)

    # lw t6,0(a0)
    # csrw sscratch,t6

    lw t6,136(a0)
80000324:	08852f83          	lw	t6,136(a0)
    lw a0,32(a0)
80000328:	02052503          	lw	a0,32(a0)

    # csrw satp,sscratch
    # sfence.vma zero, zero

8000032c:	00008067          	ret

80000330 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80000330:	fe010113          	addi	sp,sp,-32
80000334:	00812e23          	sw	s0,28(sp)
80000338:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
8000033c:	300027f3          	csrr	a5,mstatus
80000340:	fef42623          	sw	a5,-20(s0)
    return x;
80000344:	fec42783          	lw	a5,-20(s0)
}
80000348:	00078513          	mv	a0,a5
8000034c:	01c12403          	lw	s0,28(sp)
80000350:	02010113          	addi	sp,sp,32
80000354:	00008067          	ret

80000358 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
80000358:	fe010113          	addi	sp,sp,-32
8000035c:	00812e23          	sw	s0,28(sp)
80000360:	02010413          	addi	s0,sp,32
80000364:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80000368:	fec42783          	lw	a5,-20(s0)
8000036c:	30079073          	csrw	mstatus,a5
}
80000370:	00000013          	nop
80000374:	01c12403          	lw	s0,28(sp)
80000378:	02010113          	addi	sp,sp,32
8000037c:	00008067          	ret

80000380 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000380:	fd010113          	addi	sp,sp,-48
80000384:	02112623          	sw	ra,44(sp)
80000388:	02812423          	sw	s0,40(sp)
8000038c:	03010413          	addi	s0,sp,48
80000390:	00050793          	mv	a5,a0
80000394:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
80000398:	f99ff0ef          	jal	ra,80000330 <r_mstatus>
8000039c:	fea42623          	sw	a0,-20(s0)
    switch (m)
800003a0:	fdf44783          	lbu	a5,-33(s0)
800003a4:	00300713          	li	a4,3
800003a8:	06e78063          	beq	a5,a4,80000408 <s_mstatus_xpp+0x88>
800003ac:	00300713          	li	a4,3
800003b0:	08f74263          	blt	a4,a5,80000434 <s_mstatus_xpp+0xb4>
800003b4:	00078863          	beqz	a5,800003c4 <s_mstatus_xpp+0x44>
800003b8:	00100713          	li	a4,1
800003bc:	02e78063          	beq	a5,a4,800003dc <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800003c0:	0740006f          	j	80000434 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800003c4:	fec42703          	lw	a4,-20(s0)
800003c8:	ffffe7b7          	lui	a5,0xffffe
800003cc:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800003d0:	00f777b3          	and	a5,a4,a5
800003d4:	fef42623          	sw	a5,-20(s0)
        break;
800003d8:	0600006f          	j	80000438 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800003dc:	fec42703          	lw	a4,-20(s0)
800003e0:	ffffe7b7          	lui	a5,0xffffe
800003e4:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800003e8:	00f777b3          	and	a5,a4,a5
800003ec:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
800003f0:	fec42703          	lw	a4,-20(s0)
800003f4:	000017b7          	lui	a5,0x1
800003f8:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
800003fc:	00f767b3          	or	a5,a4,a5
80000400:	fef42623          	sw	a5,-20(s0)
        break;
80000404:	0340006f          	j	80000438 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80000408:	fec42703          	lw	a4,-20(s0)
8000040c:	ffffe7b7          	lui	a5,0xffffe
80000410:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000414:	00f777b3          	and	a5,a4,a5
80000418:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
8000041c:	fec42703          	lw	a4,-20(s0)
80000420:	000027b7          	lui	a5,0x2
80000424:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
80000428:	00f767b3          	or	a5,a4,a5
8000042c:	fef42623          	sw	a5,-20(s0)
        break;
80000430:	0080006f          	j	80000438 <s_mstatus_xpp+0xb8>
        break;
80000434:	00000013          	nop
    }
    w_mstatus(x);
80000438:	fec42503          	lw	a0,-20(s0)
8000043c:	f1dff0ef          	jal	ra,80000358 <w_mstatus>
}
80000440:	00000013          	nop
80000444:	02c12083          	lw	ra,44(sp)
80000448:	02812403          	lw	s0,40(sp)
8000044c:	03010113          	addi	sp,sp,48
80000450:	00008067          	ret

80000454 <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
80000454:	fe010113          	addi	sp,sp,-32
80000458:	00812e23          	sw	s0,28(sp)
8000045c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000460:	100027f3          	csrr	a5,sstatus
80000464:	fef42623          	sw	a5,-20(s0)
    return x;
80000468:	fec42783          	lw	a5,-20(s0)
}
8000046c:	00078513          	mv	a0,a5
80000470:	01c12403          	lw	s0,28(sp)
80000474:	02010113          	addi	sp,sp,32
80000478:	00008067          	ret

8000047c <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
8000047c:	fe010113          	addi	sp,sp,-32
80000480:	00812e23          	sw	s0,28(sp)
80000484:	02010413          	addi	s0,sp,32
80000488:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
8000048c:	fec42783          	lw	a5,-20(s0)
80000490:	10079073          	csrw	sstatus,a5
}
80000494:	00000013          	nop
80000498:	01c12403          	lw	s0,28(sp)
8000049c:	02010113          	addi	sp,sp,32
800004a0:	00008067          	ret

800004a4 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
800004a4:	fe010113          	addi	sp,sp,-32
800004a8:	00812e23          	sw	s0,28(sp)
800004ac:	02010413          	addi	s0,sp,32
800004b0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
800004b4:	fec42783          	lw	a5,-20(s0)
800004b8:	34179073          	csrw	mepc,a5
}
800004bc:	00000013          	nop
800004c0:	01c12403          	lw	s0,28(sp)
800004c4:	02010113          	addi	sp,sp,32
800004c8:	00008067          	ret

800004cc <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
800004cc:	fe010113          	addi	sp,sp,-32
800004d0:	00812e23          	sw	s0,28(sp)
800004d4:	02010413          	addi	s0,sp,32
800004d8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
800004dc:	fec42783          	lw	a5,-20(s0)
800004e0:	10579073          	csrw	stvec,a5
}
800004e4:	00000013          	nop
800004e8:	01c12403          	lw	s0,28(sp)
800004ec:	02010113          	addi	sp,sp,32
800004f0:	00008067          	ret

800004f4 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
800004f4:	fe010113          	addi	sp,sp,-32
800004f8:	00812e23          	sw	s0,28(sp)
800004fc:	02010413          	addi	s0,sp,32
80000500:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
80000504:	fec42783          	lw	a5,-20(s0)
80000508:	30379073          	csrw	mideleg,a5
}
8000050c:	00000013          	nop
80000510:	01c12403          	lw	s0,28(sp)
80000514:	02010113          	addi	sp,sp,32
80000518:	00008067          	ret

8000051c <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
8000051c:	fe010113          	addi	sp,sp,-32
80000520:	00812e23          	sw	s0,28(sp)
80000524:	02010413          	addi	s0,sp,32
80000528:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
8000052c:	fec42783          	lw	a5,-20(s0)
80000530:	30279073          	csrw	medeleg,a5
}
80000534:	00000013          	nop
80000538:	01c12403          	lw	s0,28(sp)
8000053c:	02010113          	addi	sp,sp,32
80000540:	00008067          	ret

80000544 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
80000544:	fe010113          	addi	sp,sp,-32
80000548:	00812e23          	sw	s0,28(sp)
8000054c:	02010413          	addi	s0,sp,32
80000550:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80000554:	fec42783          	lw	a5,-20(s0)
80000558:	18079073          	csrw	satp,a5
}
8000055c:	00000013          	nop
80000560:	01c12403          	lw	s0,28(sp)
80000564:	02010113          	addi	sp,sp,32
80000568:	00008067          	ret

8000056c <s_mstatus_intr>:
        break;
    }
    return x;
}

static inline void s_mstatus_intr(uint32 m){
8000056c:	fd010113          	addi	sp,sp,-48
80000570:	02112623          	sw	ra,44(sp)
80000574:	02812423          	sw	s0,40(sp)
80000578:	03010413          	addi	s0,sp,48
8000057c:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80000580:	db1ff0ef          	jal	ra,80000330 <r_mstatus>
80000584:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000588:	fdc42703          	lw	a4,-36(s0)
8000058c:	08000793          	li	a5,128
80000590:	04f70263          	beq	a4,a5,800005d4 <s_mstatus_intr+0x68>
80000594:	fdc42703          	lw	a4,-36(s0)
80000598:	08000793          	li	a5,128
8000059c:	0ae7e463          	bltu	a5,a4,80000644 <s_mstatus_intr+0xd8>
800005a0:	fdc42703          	lw	a4,-36(s0)
800005a4:	02000793          	li	a5,32
800005a8:	04f70463          	beq	a4,a5,800005f0 <s_mstatus_intr+0x84>
800005ac:	fdc42703          	lw	a4,-36(s0)
800005b0:	02000793          	li	a5,32
800005b4:	08e7e863          	bltu	a5,a4,80000644 <s_mstatus_intr+0xd8>
800005b8:	fdc42703          	lw	a4,-36(s0)
800005bc:	00200793          	li	a5,2
800005c0:	06f70463          	beq	a4,a5,80000628 <s_mstatus_intr+0xbc>
800005c4:	fdc42703          	lw	a4,-36(s0)
800005c8:	00800793          	li	a5,8
800005cc:	04f70063          	beq	a4,a5,8000060c <s_mstatus_intr+0xa0>
    case INTR_SIE:
        x &= ~INTR_SIE;
        x |= INTR_SIE;
        break;
    default:
        break;
800005d0:	0740006f          	j	80000644 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
800005d4:	fec42783          	lw	a5,-20(s0)
800005d8:	f7f7f793          	andi	a5,a5,-129
800005dc:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
800005e0:	fec42783          	lw	a5,-20(s0)
800005e4:	0807e793          	ori	a5,a5,128
800005e8:	fef42623          	sw	a5,-20(s0)
        break;
800005ec:	05c0006f          	j	80000648 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800005f0:	fec42783          	lw	a5,-20(s0)
800005f4:	fdf7f793          	andi	a5,a5,-33
800005f8:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
800005fc:	fec42783          	lw	a5,-20(s0)
80000600:	0207e793          	ori	a5,a5,32
80000604:	fef42623          	sw	a5,-20(s0)
        break;
80000608:	0400006f          	j	80000648 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
8000060c:	fec42783          	lw	a5,-20(s0)
80000610:	ff77f793          	andi	a5,a5,-9
80000614:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80000618:	fec42783          	lw	a5,-20(s0)
8000061c:	0087e793          	ori	a5,a5,8
80000620:	fef42623          	sw	a5,-20(s0)
        break;
80000624:	0240006f          	j	80000648 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80000628:	fec42783          	lw	a5,-20(s0)
8000062c:	ffd7f793          	andi	a5,a5,-3
80000630:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80000634:	fec42783          	lw	a5,-20(s0)
80000638:	0027e793          	ori	a5,a5,2
8000063c:	fef42623          	sw	a5,-20(s0)
        break;
80000640:	0080006f          	j	80000648 <s_mstatus_intr+0xdc>
        break;
80000644:	00000013          	nop
    }
    w_mstatus(x);
80000648:	fec42503          	lw	a0,-20(s0)
8000064c:	d0dff0ef          	jal	ra,80000358 <w_mstatus>
}
80000650:	00000013          	nop
80000654:	02c12083          	lw	ra,44(sp)
80000658:	02812403          	lw	s0,40(sp)
8000065c:	03010113          	addi	sp,sp,48
80000660:	00008067          	ret

80000664 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
80000664:	fd010113          	addi	sp,sp,-48
80000668:	02112623          	sw	ra,44(sp)
8000066c:	02812423          	sw	s0,40(sp)
80000670:	03010413          	addi	s0,sp,48
80000674:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
80000678:	dddff0ef          	jal	ra,80000454 <r_sstatus>
8000067c:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000680:	fdc42703          	lw	a4,-36(s0)
80000684:	ffd00793          	li	a5,-3
80000688:	06f70863          	beq	a4,a5,800006f8 <s_sstatus_intr+0x94>
8000068c:	fdc42703          	lw	a4,-36(s0)
80000690:	ffd00793          	li	a5,-3
80000694:	06e7e863          	bltu	a5,a4,80000704 <s_sstatus_intr+0xa0>
80000698:	fdc42703          	lw	a4,-36(s0)
8000069c:	fdf00793          	li	a5,-33
800006a0:	02f70c63          	beq	a4,a5,800006d8 <s_sstatus_intr+0x74>
800006a4:	fdc42703          	lw	a4,-36(s0)
800006a8:	fdf00793          	li	a5,-33
800006ac:	04e7ec63          	bltu	a5,a4,80000704 <s_sstatus_intr+0xa0>
800006b0:	fdc42703          	lw	a4,-36(s0)
800006b4:	00200793          	li	a5,2
800006b8:	02f70863          	beq	a4,a5,800006e8 <s_sstatus_intr+0x84>
800006bc:	fdc42703          	lw	a4,-36(s0)
800006c0:	02000793          	li	a5,32
800006c4:	04f71063          	bne	a4,a5,80000704 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
800006c8:	fec42783          	lw	a5,-20(s0)
800006cc:	0207e793          	ori	a5,a5,32
800006d0:	fef42623          	sw	a5,-20(s0)
        break;
800006d4:	0340006f          	j	80000708 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
800006d8:	fec42783          	lw	a5,-20(s0)
800006dc:	fdf7f793          	andi	a5,a5,-33
800006e0:	fef42623          	sw	a5,-20(s0)
        break;
800006e4:	0240006f          	j	80000708 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
800006e8:	fec42783          	lw	a5,-20(s0)
800006ec:	0027e793          	ori	a5,a5,2
800006f0:	fef42623          	sw	a5,-20(s0)
        break;
800006f4:	0140006f          	j	80000708 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
800006f8:	fec42783          	lw	a5,-20(s0)
800006fc:	0027f793          	andi	a5,a5,2
80000700:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
80000704:	00000013          	nop
    }
    w_sstatus(x);
80000708:	fec42503          	lw	a0,-20(s0)
8000070c:	d71ff0ef          	jal	ra,8000047c <w_sstatus>
}
80000710:	00000013          	nop
80000714:	02c12083          	lw	ra,44(sp)
80000718:	02812403          	lw	s0,40(sp)
8000071c:	03010113          	addi	sp,sp,48
80000720:	00008067          	ret

80000724 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();     // 定义在main.c

void start(){
80000724:	ff010113          	addi	sp,sp,-16
80000728:	00112623          	sw	ra,12(sp)
8000072c:	00812423          	sw	s0,8(sp)
80000730:	01010413          	addi	s0,sp,16
    uartinit();
80000734:	080000ef          	jal	ra,800007b4 <uartinit>
    uartputs("Hello Los!\n");
80000738:	800027b7          	lui	a5,0x80002
8000073c:	00078513          	mv	a0,a5
80000740:	168000ef          	jal	ra,800008a8 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
80000744:	00100513          	li	a0,1
80000748:	c39ff0ef          	jal	ra,80000380 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
8000074c:	00000513          	li	a0,0
80000750:	df5ff0ef          	jal	ra,80000544 <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
80000754:	000107b7          	lui	a5,0x10
80000758:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
8000075c:	d99ff0ef          	jal	ra,800004f4 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80000760:	000107b7          	lui	a5,0x10
80000764:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000768:	db5ff0ef          	jal	ra,8000051c <w_medeleg>

    s_mstatus_intr(INTR_MPIE);  // S-mode 开全局中断
8000076c:	08000513          	li	a0,128
80000770:	dfdff0ef          	jal	ra,8000056c <s_mstatus_intr>
    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
80000774:	00200513          	li	a0,2
80000778:	eedff0ef          	jal	ra,80000664 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
8000077c:	800007b7          	lui	a5,0x80000
80000780:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000784:	00078513          	mv	a0,a5
80000788:	d45ff0ef          	jal	ra,800004cc <w_stvec>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
8000078c:	800017b7          	lui	a5,0x80001
80000790:	a0c78793          	addi	a5,a5,-1524 # 80000a0c <memend+0xf8000a0c>
80000794:	00078513          	mv	a0,a5
80000798:	d0dff0ef          	jal	ra,800004a4 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
8000079c:	30200073          	mret
800007a0:	00000013          	nop
800007a4:	00c12083          	lw	ra,12(sp)
800007a8:	00812403          	lw	s0,8(sp)
800007ac:	01010113          	addi	sp,sp,16
800007b0:	00008067          	ret

800007b4 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
800007b4:	fe010113          	addi	sp,sp,-32
800007b8:	00812e23          	sw	s0,28(sp)
800007bc:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800007c0:	100007b7          	lui	a5,0x10000
800007c4:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007c8:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800007cc:	100007b7          	lui	a5,0x10000
800007d0:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800007d4:	0007c783          	lbu	a5,0(a5)
800007d8:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800007dc:	100007b7          	lui	a5,0x10000
800007e0:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800007e4:	fef44703          	lbu	a4,-17(s0)
800007e8:	f8076713          	ori	a4,a4,-128
800007ec:	0ff77713          	andi	a4,a4,255
800007f0:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
800007f4:	100007b7          	lui	a5,0x10000
800007f8:	00300713          	li	a4,3
800007fc:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
80000800:	100007b7          	lui	a5,0x10000
80000804:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000808:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
8000080c:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80000810:	100007b7          	lui	a5,0x10000
80000814:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000818:	fef44703          	lbu	a4,-17(s0)
8000081c:	00376713          	ori	a4,a4,3
80000820:	0ff77713          	andi	a4,a4,255
80000824:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
80000828:	100007b7          	lui	a5,0x10000
8000082c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000830:	0007c783          	lbu	a5,0(a5)
80000834:	0ff7f713          	andi	a4,a5,255
80000838:	100007b7          	lui	a5,0x10000
8000083c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000840:	00176713          	ori	a4,a4,1
80000844:	0ff77713          	andi	a4,a4,255
80000848:	00e78023          	sb	a4,0(a5)
}
8000084c:	00000013          	nop
80000850:	01c12403          	lw	s0,28(sp)
80000854:	02010113          	addi	sp,sp,32
80000858:	00008067          	ret

8000085c <uartputc>:

// 轮询处理数据
char uartputc(char c){
8000085c:	fe010113          	addi	sp,sp,-32
80000860:	00812e23          	sw	s0,28(sp)
80000864:	02010413          	addi	s0,sp,32
80000868:	00050793          	mv	a5,a0
8000086c:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80000870:	00000013          	nop
80000874:	100007b7          	lui	a5,0x10000
80000878:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
8000087c:	0007c783          	lbu	a5,0(a5)
80000880:	0ff7f793          	andi	a5,a5,255
80000884:	0207f793          	andi	a5,a5,32
80000888:	fe0786e3          	beqz	a5,80000874 <uartputc+0x18>
    return uart_write(UART_THR,c);
8000088c:	10000737          	lui	a4,0x10000
80000890:	fef44783          	lbu	a5,-17(s0)
80000894:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
80000898:	00078513          	mv	a0,a5
8000089c:	01c12403          	lw	s0,28(sp)
800008a0:	02010113          	addi	sp,sp,32
800008a4:	00008067          	ret

800008a8 <uartputs>:

// 发送字符串
void uartputs(char* s){
800008a8:	fe010113          	addi	sp,sp,-32
800008ac:	00112e23          	sw	ra,28(sp)
800008b0:	00812c23          	sw	s0,24(sp)
800008b4:	02010413          	addi	s0,sp,32
800008b8:	fea42623          	sw	a0,-20(s0)
    while (*s)
800008bc:	01c0006f          	j	800008d8 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
800008c0:	fec42783          	lw	a5,-20(s0)
800008c4:	00178713          	addi	a4,a5,1
800008c8:	fee42623          	sw	a4,-20(s0)
800008cc:	0007c783          	lbu	a5,0(a5)
800008d0:	00078513          	mv	a0,a5
800008d4:	f89ff0ef          	jal	ra,8000085c <uartputc>
    while (*s)
800008d8:	fec42783          	lw	a5,-20(s0)
800008dc:	0007c783          	lbu	a5,0(a5)
800008e0:	fe0790e3          	bnez	a5,800008c0 <uartputs+0x18>
    }
    
}
800008e4:	00000013          	nop
800008e8:	00000013          	nop
800008ec:	01c12083          	lw	ra,28(sp)
800008f0:	01812403          	lw	s0,24(sp)
800008f4:	02010113          	addi	sp,sp,32
800008f8:	00008067          	ret

800008fc <uartgetc>:

// 接收输入
int uartgetc(){
800008fc:	ff010113          	addi	sp,sp,-16
80000900:	00812623          	sw	s0,12(sp)
80000904:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
80000908:	100007b7          	lui	a5,0x10000
8000090c:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000910:	0007c783          	lbu	a5,0(a5)
80000914:	0ff7f793          	andi	a5,a5,255
80000918:	0017f793          	andi	a5,a5,1
8000091c:	00078a63          	beqz	a5,80000930 <uartgetc+0x34>
        return uart_read(UART_RHR);
80000920:	100007b7          	lui	a5,0x10000
80000924:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
80000928:	0ff7f793          	andi	a5,a5,255
8000092c:	0080006f          	j	80000934 <uartgetc+0x38>
    }else{
        return -1;
80000930:	fff00793          	li	a5,-1
    }
}
80000934:	00078513          	mv	a0,a5
80000938:	00c12403          	lw	s0,12(sp)
8000093c:	01010113          	addi	sp,sp,16
80000940:	00008067          	ret

80000944 <uartintr>:

// 键盘输入中断
char uartintr(){
80000944:	ff010113          	addi	sp,sp,-16
80000948:	00112623          	sw	ra,12(sp)
8000094c:	00812423          	sw	s0,8(sp)
80000950:	01010413          	addi	s0,sp,16
    return uartgetc();
80000954:	fa9ff0ef          	jal	ra,800008fc <uartgetc>
80000958:	00050793          	mv	a5,a0
8000095c:	0ff7f793          	andi	a5,a5,255
80000960:	00078513          	mv	a0,a5
80000964:	00c12083          	lw	ra,12(sp)
80000968:	00812403          	lw	s0,8(sp)
8000096c:	01010113          	addi	sp,sp,16
80000970:	00008067          	ret

80000974 <r_sp>:
static inline void w_tp(uint32 x){
    asm volatile("mv tp , %0": : "r"(x));
}

// 获取 thread id
static inline uint32 r_sp(){
80000974:	fe010113          	addi	sp,sp,-32
80000978:	00812e23          	sw	s0,28(sp)
8000097c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("mv %0 , sp": "=r"(x));
80000980:	00010793          	mv	a5,sp
80000984:	fef42623          	sw	a5,-20(s0)
    return x;
80000988:	fec42783          	lw	a5,-20(s0)
}
8000098c:	00078513          	mv	a0,a5
80000990:	01c12403          	lw	s0,28(sp)
80000994:	02010113          	addi	sp,sp,32
80000998:	00008067          	ret

8000099c <task>:
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"
void task(){
8000099c:	fe010113          	addi	sp,sp,-32
800009a0:	00112e23          	sw	ra,28(sp)
800009a4:	00812c23          	sw	s0,24(sp)
800009a8:	02010413          	addi	s0,sp,32
    int  j=5;
800009ac:	00500793          	li	a5,5
800009b0:	fef42623          	sw	a5,-20(s0)
    while(j--){
800009b4:	0300006f          	j	800009e4 <task+0x48>
        int i=100000000;
800009b8:	05f5e7b7          	lui	a5,0x5f5e
800009bc:	10078793          	addi	a5,a5,256 # 5f5e100 <sz+0x5f5d100>
800009c0:	fef42423          	sw	a5,-24(s0)
        while(i--);
800009c4:	00000013          	nop
800009c8:	fe842783          	lw	a5,-24(s0)
800009cc:	fff78713          	addi	a4,a5,-1
800009d0:	fee42423          	sw	a4,-24(s0)
800009d4:	fe079ae3          	bnez	a5,800009c8 <task+0x2c>
        printf("tesk\n");
800009d8:	800027b7          	lui	a5,0x80002
800009dc:	00c78513          	addi	a0,a5,12 # 8000200c <memend+0xf800200c>
800009e0:	4d4000ef          	jal	ra,80000eb4 <printf>
    while(j--){
800009e4:	fec42783          	lw	a5,-20(s0)
800009e8:	fff78713          	addi	a4,a5,-1
800009ec:	fee42623          	sw	a4,-20(s0)
800009f0:	fc0794e3          	bnez	a5,800009b8 <task+0x1c>
    }
}
800009f4:	00000013          	nop
800009f8:	00000013          	nop
800009fc:	01c12083          	lw	ra,28(sp)
80000a00:	01812403          	lw	s0,24(sp)
80000a04:	02010113          	addi	sp,sp,32
80000a08:	00008067          	ret

80000a0c <main>:
void main(){
80000a0c:	ef010113          	addi	sp,sp,-272
80000a10:	10112623          	sw	ra,268(sp)
80000a14:	10812423          	sw	s0,264(sp)
80000a18:	11010413          	addi	s0,sp,272
    printf("start run main()\n");
80000a1c:	800027b7          	lui	a5,0x80002
80000a20:	01478513          	addi	a0,a5,20 # 80002014 <memend+0xf8002014>
80000a24:	490000ef          	jal	ra,80000eb4 <printf>

    minit();        // 物理内存管理
80000a28:	099000ef          	jal	ra,800012c0 <minit>
    plicinit();     // PLIC 中断处理
80000a2c:	235000ef          	jal	ra,80001460 <plicinit>
    vminit();       // 启动虚拟内存
80000a30:	6e9000ef          	jal	ra,80001918 <vminit>

    procinit();
80000a34:	0e8010ef          	jal	ra,80001b1c <procinit>
    // *va=10;
    // *(int *)0x00000000 = 100;
   
    struct context old;
    struct context new;
    new.ra=(reg_t)task;
80000a38:	800017b7          	lui	a5,0x80001
80000a3c:	99c78793          	addi	a5,a5,-1636 # 8000099c <memend+0xf800099c>
80000a40:	eef42c23          	sw	a5,-264(s0)
    new.sp=r_sp();
80000a44:	f31ff0ef          	jal	ra,80000974 <r_sp>
80000a48:	00050793          	mv	a5,a0
80000a4c:	eef42e23          	sw	a5,-260(s0)
    // swtch(&old,&new);

    userinit();
80000a50:	220010ef          	jal	ra,80001c70 <userinit>
    asm volatile("ecall");
80000a54:	00000073          	ecall
    printf("----------------------\n");
80000a58:	800027b7          	lui	a5,0x80002
80000a5c:	02878513          	addi	a0,a5,40 # 80002028 <memend+0xf8002028>
80000a60:	454000ef          	jal	ra,80000eb4 <printf>
    while(1);
80000a64:	0000006f          	j	80000a64 <main+0x58>

80000a68 <r_sepc>:
static inline uint32 r_sepc(){
80000a68:	fe010113          	addi	sp,sp,-32
80000a6c:	00812e23          	sw	s0,28(sp)
80000a70:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, sepc" : "=r" (x) );
80000a74:	141027f3          	csrr	a5,sepc
80000a78:	fef42623          	sw	a5,-20(s0)
    return x;
80000a7c:	fec42783          	lw	a5,-20(s0)
}
80000a80:	00078513          	mv	a0,a5
80000a84:	01c12403          	lw	s0,28(sp)
80000a88:	02010113          	addi	sp,sp,32
80000a8c:	00008067          	ret

80000a90 <w_sepc>:
static inline void w_sepc(uint32 x){
80000a90:	fe010113          	addi	sp,sp,-32
80000a94:	00812e23          	sw	s0,28(sp)
80000a98:	02010413          	addi	s0,sp,32
80000a9c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
80000aa0:	fec42783          	lw	a5,-20(s0)
80000aa4:	14179073          	csrw	sepc,a5
}
80000aa8:	00000013          	nop
80000aac:	01c12403          	lw	s0,28(sp)
80000ab0:	02010113          	addi	sp,sp,32
80000ab4:	00008067          	ret

80000ab8 <w_satp>:
static inline void w_satp(uint32 x){
80000ab8:	fe010113          	addi	sp,sp,-32
80000abc:	00812e23          	sw	s0,28(sp)
80000ac0:	02010413          	addi	s0,sp,32
80000ac4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80000ac8:	fec42783          	lw	a5,-20(s0)
80000acc:	18079073          	csrw	satp,a5
}
80000ad0:	00000013          	nop
80000ad4:	01c12403          	lw	s0,28(sp)
80000ad8:	02010113          	addi	sp,sp,32
80000adc:	00008067          	ret

80000ae0 <sfence_vma>:
static inline void sfence_vma(){
80000ae0:	ff010113          	addi	sp,sp,-16
80000ae4:	00812623          	sw	s0,12(sp)
80000ae8:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
80000aec:	12000073          	sfence.vma
}
80000af0:	00000013          	nop
80000af4:	00c12403          	lw	s0,12(sp)
80000af8:	01010113          	addi	sp,sp,16
80000afc:	00008067          	ret

80000b00 <w_sp>:
static inline void w_sp(uint32 x){
80000b00:	fe010113          	addi	sp,sp,-32
80000b04:	00812e23          	sw	s0,28(sp)
80000b08:	02010413          	addi	s0,sp,32
80000b0c:	fea42623          	sw	a0,-20(s0)
    asm volatile("mv sp , %0": : "r"(x));
80000b10:	fec42783          	lw	a5,-20(s0)
80000b14:	00078113          	mv	sp,a5
}
80000b18:	00000013          	nop
80000b1c:	01c12403          	lw	s0,28(sp)
80000b20:	02010113          	addi	sp,sp,32
80000b24:	00008067          	ret

80000b28 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
80000b28:	fe010113          	addi	sp,sp,-32
80000b2c:	00812e23          	sw	s0,28(sp)
80000b30:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
80000b34:	142027f3          	csrr	a5,scause
80000b38:	fef42623          	sw	a5,-20(s0)
    return x;
80000b3c:	fec42783          	lw	a5,-20(s0)
}
80000b40:	00078513          	mv	a0,a5
80000b44:	01c12403          	lw	s0,28(sp)
80000b48:	02010113          	addi	sp,sp,32
80000b4c:	00008067          	ret

80000b50 <externinterrupt>:
#include "proc.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
80000b50:	fe010113          	addi	sp,sp,-32
80000b54:	00112e23          	sw	ra,28(sp)
80000b58:	00812c23          	sw	s0,24(sp)
80000b5c:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000b60:	1c5000ef          	jal	ra,80001524 <r_plicclaim>
80000b64:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000b68:	fec42583          	lw	a1,-20(s0)
80000b6c:	800027b7          	lui	a5,0x80002
80000b70:	04078513          	addi	a0,a5,64 # 80002040 <memend+0xf8002040>
80000b74:	340000ef          	jal	ra,80000eb4 <printf>
    switch (irq)
80000b78:	fec42703          	lw	a4,-20(s0)
80000b7c:	00a00793          	li	a5,10
80000b80:	02f71063          	bne	a4,a5,80000ba0 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80000b84:	dc1ff0ef          	jal	ra,80000944 <uartintr>
80000b88:	00050793          	mv	a5,a0
80000b8c:	00078593          	mv	a1,a5
80000b90:	800027b7          	lui	a5,0x80002
80000b94:	04c78513          	addi	a0,a5,76 # 8000204c <memend+0xf800204c>
80000b98:	31c000ef          	jal	ra,80000eb4 <printf>
        break;
80000b9c:	0080006f          	j	80000ba4 <externinterrupt+0x54>
    default:
        break;
80000ba0:	00000013          	nop
    }
    w_pliccomplete(irq);
80000ba4:	fec42503          	lw	a0,-20(s0)
80000ba8:	1bd000ef          	jal	ra,80001564 <w_pliccomplete>
}
80000bac:	00000013          	nop
80000bb0:	01c12083          	lw	ra,28(sp)
80000bb4:	01812403          	lw	s0,24(sp)
80000bb8:	02010113          	addi	sp,sp,32
80000bbc:	00008067          	ret

80000bc0 <zero>:

void zero(){
80000bc0:	fe010113          	addi	sp,sp,-32
80000bc4:	00112e23          	sw	ra,28(sp)
80000bc8:	00812c23          	sw	s0,24(sp)
80000bcc:	02010413          	addi	s0,sp,32
    printf("zero\n");
80000bd0:	800027b7          	lui	a5,0x80002
80000bd4:	05c78513          	addi	a0,a5,92 # 8000205c <memend+0xf800205c>
80000bd8:	2dc000ef          	jal	ra,80000eb4 <printf>
    reg_t pc=r_sepc();
80000bdc:	e8dff0ef          	jal	ra,80000a68 <r_sepc>
80000be0:	fea42423          	sw	a0,-24(s0)
    w_sepc(pc+4);
80000be4:	fe842783          	lw	a5,-24(s0)
80000be8:	00478793          	addi	a5,a5,4
80000bec:	00078513          	mv	a0,a5
80000bf0:	ea1ff0ef          	jal	ra,80000a90 <w_sepc>
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80000bf4:	8000c7b7          	lui	a5,0x8000c
80000bf8:	44c78793          	addi	a5,a5,1100 # 8000c44c <memend+0xf800c44c>
80000bfc:	fef42623          	sw	a5,-20(s0)
80000c00:	0600006f          	j	80000c60 <zero+0xa0>
        if(p->status==RUNABLE){
80000c04:	fec42783          	lw	a5,-20(s0)
80000c08:	0047a703          	lw	a4,4(a5)
80000c0c:	00200793          	li	a5,2
80000c10:	04f71263          	bne	a4,a5,80000c54 <zero+0x94>
            loadframe(&p->trapframe);
80000c14:	fec42783          	lw	a5,-20(s0)
80000c18:	00878793          	addi	a5,a5,8
80000c1c:	00078513          	mv	a0,a5
80000c20:	e94ff0ef          	jal	ra,800002b4 <loadframe>
            w_sp(p->trapframe.sp);
80000c24:	fec42783          	lw	a5,-20(s0)
80000c28:	01c7a783          	lw	a5,28(a5)
80000c2c:	00078513          	mv	a0,a5
80000c30:	ed1ff0ef          	jal	ra,80000b00 <w_sp>
            w_satp(SATP_SV32|(p->trapframe.ksatp>>12));
80000c34:	fec42783          	lw	a5,-20(s0)
80000c38:	0087a783          	lw	a5,8(a5)
80000c3c:	00c7d713          	srli	a4,a5,0xc
80000c40:	800007b7          	lui	a5,0x80000
80000c44:	00f767b3          	or	a5,a4,a5
80000c48:	00078513          	mv	a0,a5
80000c4c:	e6dff0ef          	jal	ra,80000ab8 <w_satp>
            sfence_vma();
80000c50:	e91ff0ef          	jal	ra,80000ae0 <sfence_vma>
    for(p=proc;p<&proc[NPROC];p++){
80000c54:	fec42783          	lw	a5,-20(s0)
80000c58:	11878793          	addi	a5,a5,280 # 80000118 <memend+0xf8000118>
80000c5c:	fef42623          	sw	a5,-20(s0)
80000c60:	fec42703          	lw	a4,-20(s0)
80000c64:	8000d7b7          	lui	a5,0x8000d
80000c68:	8ac78793          	addi	a5,a5,-1876 # 8000c8ac <memend+0xf800c8ac>
80000c6c:	f8f76ce3          	bltu	a4,a5,80000c04 <zero+0x44>
        }
    }
}
80000c70:	00000013          	nop
80000c74:	00000013          	nop
80000c78:	01c12083          	lw	ra,28(sp)
80000c7c:	01812403          	lw	s0,24(sp)
80000c80:	02010113          	addi	sp,sp,32
80000c84:	00008067          	ret

80000c88 <trapvec>:

void trapvec(){
80000c88:	fe010113          	addi	sp,sp,-32
80000c8c:	00112e23          	sw	ra,28(sp)
80000c90:	00812c23          	sw	s0,24(sp)
80000c94:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000c98:	e91ff0ef          	jal	ra,80000b28 <r_scause>
80000c9c:	fea42423          	sw	a0,-24(s0)

    uint16 code= scause & 0xffff;
80000ca0:	fe842783          	lw	a5,-24(s0)
80000ca4:	fef41323          	sh	a5,-26(s0)

    if(scause & (1<<31)){
80000ca8:	fe842783          	lw	a5,-24(s0)
80000cac:	0607de63          	bgez	a5,80000d28 <trapvec+0xa0>
        printf("Interrupt : ");
80000cb0:	800027b7          	lui	a5,0x80002
80000cb4:	06478513          	addi	a0,a5,100 # 80002064 <memend+0xf8002064>
80000cb8:	1fc000ef          	jal	ra,80000eb4 <printf>
        switch (code)
80000cbc:	fe645783          	lhu	a5,-26(s0)
80000cc0:	00900713          	li	a4,9
80000cc4:	04e78063          	beq	a5,a4,80000d04 <trapvec+0x7c>
80000cc8:	00900713          	li	a4,9
80000ccc:	04f74663          	blt	a4,a5,80000d18 <trapvec+0x90>
80000cd0:	00100713          	li	a4,1
80000cd4:	00e78863          	beq	a5,a4,80000ce4 <trapvec+0x5c>
80000cd8:	00500713          	li	a4,5
80000cdc:	00e78c63          	beq	a5,a4,80000cf4 <trapvec+0x6c>
80000ce0:	0380006f          	j	80000d18 <trapvec+0x90>
        {
        case 1:
            printf("Supervisor software interrupt\n");
80000ce4:	800027b7          	lui	a5,0x80002
80000ce8:	07478513          	addi	a0,a5,116 # 80002074 <memend+0xf8002074>
80000cec:	1c8000ef          	jal	ra,80000eb4 <printf>
            break;
80000cf0:	1780006f          	j	80000e68 <trapvec+0x1e0>
        case 5:
            printf("Supervisor timer interrupt\n");
80000cf4:	800027b7          	lui	a5,0x80002
80000cf8:	09478513          	addi	a0,a5,148 # 80002094 <memend+0xf8002094>
80000cfc:	1b8000ef          	jal	ra,80000eb4 <printf>
            break;
80000d00:	1680006f          	j	80000e68 <trapvec+0x1e0>
        case 9:
            printf("Supervisor external interrupt\n");
80000d04:	800027b7          	lui	a5,0x80002
80000d08:	0b078513          	addi	a0,a5,176 # 800020b0 <memend+0xf80020b0>
80000d0c:	1a8000ef          	jal	ra,80000eb4 <printf>
            externinterrupt();
80000d10:	e41ff0ef          	jal	ra,80000b50 <externinterrupt>
            break;
80000d14:	1540006f          	j	80000e68 <trapvec+0x1e0>
        default:
            printf("Other interrupt\n");
80000d18:	800027b7          	lui	a5,0x80002
80000d1c:	0d078513          	addi	a0,a5,208 # 800020d0 <memend+0xf80020d0>
80000d20:	194000ef          	jal	ra,80000eb4 <printf>
            break;
80000d24:	1440006f          	j	80000e68 <trapvec+0x1e0>
        }
    }else{
        int ecall=0;
80000d28:	fe042623          	sw	zero,-20(s0)
        printf("Exception : ");
80000d2c:	800027b7          	lui	a5,0x80002
80000d30:	0e478513          	addi	a0,a5,228 # 800020e4 <memend+0xf80020e4>
80000d34:	180000ef          	jal	ra,80000eb4 <printf>
        switch (code)
80000d38:	fe645783          	lhu	a5,-26(s0)
80000d3c:	00f00713          	li	a4,15
80000d40:	0ef76c63          	bltu	a4,a5,80000e38 <trapvec+0x1b0>
80000d44:	00279713          	slli	a4,a5,0x2
80000d48:	800027b7          	lui	a5,0x80002
80000d4c:	25878793          	addi	a5,a5,600 # 80002258 <memend+0xf8002258>
80000d50:	00f707b3          	add	a5,a4,a5
80000d54:	0007a783          	lw	a5,0(a5)
80000d58:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000d5c:	800027b7          	lui	a5,0x80002
80000d60:	0f478513          	addi	a0,a5,244 # 800020f4 <memend+0xf80020f4>
80000d64:	150000ef          	jal	ra,80000eb4 <printf>
            break;
80000d68:	0e00006f          	j	80000e48 <trapvec+0x1c0>
        case 1:
            printf("Instruction access fault\n");
80000d6c:	800027b7          	lui	a5,0x80002
80000d70:	11478513          	addi	a0,a5,276 # 80002114 <memend+0xf8002114>
80000d74:	140000ef          	jal	ra,80000eb4 <printf>
            break;
80000d78:	0d00006f          	j	80000e48 <trapvec+0x1c0>
        case 2:
            printf("Illegal instruction\n");
80000d7c:	800027b7          	lui	a5,0x80002
80000d80:	13078513          	addi	a0,a5,304 # 80002130 <memend+0xf8002130>
80000d84:	130000ef          	jal	ra,80000eb4 <printf>
            break;
80000d88:	0c00006f          	j	80000e48 <trapvec+0x1c0>
        case 3:
            printf("Breakpoint\n");
80000d8c:	800027b7          	lui	a5,0x80002
80000d90:	14878513          	addi	a0,a5,328 # 80002148 <memend+0xf8002148>
80000d94:	120000ef          	jal	ra,80000eb4 <printf>
            break;
80000d98:	0b00006f          	j	80000e48 <trapvec+0x1c0>
        case 4:
            printf("Load address misaligned\n");
80000d9c:	800027b7          	lui	a5,0x80002
80000da0:	15478513          	addi	a0,a5,340 # 80002154 <memend+0xf8002154>
80000da4:	110000ef          	jal	ra,80000eb4 <printf>
            break;
80000da8:	0a00006f          	j	80000e48 <trapvec+0x1c0>
        case 5:
            printf("Load access fault\n");
80000dac:	800027b7          	lui	a5,0x80002
80000db0:	17078513          	addi	a0,a5,368 # 80002170 <memend+0xf8002170>
80000db4:	100000ef          	jal	ra,80000eb4 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000db8:	0900006f          	j	80000e48 <trapvec+0x1c0>
        case 6:
            printf("Store/AMO address misaligned\n");
80000dbc:	800027b7          	lui	a5,0x80002
80000dc0:	18478513          	addi	a0,a5,388 # 80002184 <memend+0xf8002184>
80000dc4:	0f0000ef          	jal	ra,80000eb4 <printf>
            break;
80000dc8:	0800006f          	j	80000e48 <trapvec+0x1c0>
        case 7:
            printf("Store/AMO access fault\n");
80000dcc:	800027b7          	lui	a5,0x80002
80000dd0:	1a478513          	addi	a0,a5,420 # 800021a4 <memend+0xf80021a4>
80000dd4:	0e0000ef          	jal	ra,80000eb4 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000dd8:	0700006f          	j	80000e48 <trapvec+0x1c0>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000ddc:	800027b7          	lui	a5,0x80002
80000de0:	1bc78513          	addi	a0,a5,444 # 800021bc <memend+0xf80021bc>
80000de4:	0d0000ef          	jal	ra,80000eb4 <printf>
            break;
80000de8:	0600006f          	j	80000e48 <trapvec+0x1c0>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000dec:	800027b7          	lui	a5,0x80002
80000df0:	1dc78513          	addi	a0,a5,476 # 800021dc <memend+0xf80021dc>
80000df4:	0c0000ef          	jal	ra,80000eb4 <printf>
            zero();
80000df8:	dc9ff0ef          	jal	ra,80000bc0 <zero>
            ecall=1;
80000dfc:	00100793          	li	a5,1
80000e00:	fef42623          	sw	a5,-20(s0)
            break;
80000e04:	0440006f          	j	80000e48 <trapvec+0x1c0>
        case 12:
            printf("Instruction page fault\n");
80000e08:	800027b7          	lui	a5,0x80002
80000e0c:	1fc78513          	addi	a0,a5,508 # 800021fc <memend+0xf80021fc>
80000e10:	0a4000ef          	jal	ra,80000eb4 <printf>
            break;
80000e14:	0340006f          	j	80000e48 <trapvec+0x1c0>
        case 13:
            printf("Load page fault\n");
80000e18:	800027b7          	lui	a5,0x80002
80000e1c:	21478513          	addi	a0,a5,532 # 80002214 <memend+0xf8002214>
80000e20:	094000ef          	jal	ra,80000eb4 <printf>
            break;
80000e24:	0240006f          	j	80000e48 <trapvec+0x1c0>
        case 15:
            printf("Store/AMO page fault\n");
80000e28:	800027b7          	lui	a5,0x80002
80000e2c:	22878513          	addi	a0,a5,552 # 80002228 <memend+0xf8002228>
80000e30:	084000ef          	jal	ra,80000eb4 <printf>
            break;
80000e34:	0140006f          	j	80000e48 <trapvec+0x1c0>
        default:
            printf("Other\n");
80000e38:	800027b7          	lui	a5,0x80002
80000e3c:	24078513          	addi	a0,a5,576 # 80002240 <memend+0xf8002240>
80000e40:	074000ef          	jal	ra,80000eb4 <printf>
            break;
80000e44:	00000013          	nop
        }
        if(!ecall){
80000e48:	fec42783          	lw	a5,-20(s0)
80000e4c:	00079e63          	bnez	a5,80000e68 <trapvec+0x1e0>
            panic("Trap Exception");
80000e50:	800027b7          	lui	a5,0x80002
80000e54:	24878513          	addi	a0,a5,584 # 80002248 <memend+0xf8002248>
80000e58:	024000ef          	jal	ra,80000e7c <panic>
            ecall=1;
80000e5c:	00100793          	li	a5,1
80000e60:	fef42623          	sw	a5,-20(s0)
        }
    }
}
80000e64:	0040006f          	j	80000e68 <trapvec+0x1e0>
80000e68:	00000013          	nop
80000e6c:	01c12083          	lw	ra,28(sp)
80000e70:	01812403          	lw	s0,24(sp)
80000e74:	02010113          	addi	sp,sp,32
80000e78:	00008067          	ret

80000e7c <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000e7c:	fe010113          	addi	sp,sp,-32
80000e80:	00112e23          	sw	ra,28(sp)
80000e84:	00812c23          	sw	s0,24(sp)
80000e88:	02010413          	addi	s0,sp,32
80000e8c:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000e90:	800027b7          	lui	a5,0x80002
80000e94:	29878513          	addi	a0,a5,664 # 80002298 <memend+0xf8002298>
80000e98:	a11ff0ef          	jal	ra,800008a8 <uartputs>
    uartputs(s);
80000e9c:	fec42503          	lw	a0,-20(s0)
80000ea0:	a09ff0ef          	jal	ra,800008a8 <uartputs>
	uartputs("\n");
80000ea4:	800027b7          	lui	a5,0x80002
80000ea8:	2a078513          	addi	a0,a5,672 # 800022a0 <memend+0xf80022a0>
80000eac:	9fdff0ef          	jal	ra,800008a8 <uartputs>
    while(1);
80000eb0:	0000006f          	j	80000eb0 <panic+0x34>

80000eb4 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000eb4:	f8010113          	addi	sp,sp,-128
80000eb8:	04112e23          	sw	ra,92(sp)
80000ebc:	04812c23          	sw	s0,88(sp)
80000ec0:	06010413          	addi	s0,sp,96
80000ec4:	faa42623          	sw	a0,-84(s0)
80000ec8:	00b42223          	sw	a1,4(s0)
80000ecc:	00c42423          	sw	a2,8(s0)
80000ed0:	00d42623          	sw	a3,12(s0)
80000ed4:	00e42823          	sw	a4,16(s0)
80000ed8:	00f42a23          	sw	a5,20(s0)
80000edc:	01042c23          	sw	a6,24(s0)
80000ee0:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000ee4:	02040793          	addi	a5,s0,32
80000ee8:	faf42423          	sw	a5,-88(s0)
80000eec:	fa842783          	lw	a5,-88(s0)
80000ef0:	fe478793          	addi	a5,a5,-28
80000ef4:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000ef8:	fac42783          	lw	a5,-84(s0)
80000efc:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000f00:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000f04:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
80000f08:	36c0006f          	j	80001274 <printf+0x3c0>
		if(ch=='%'){
80000f0c:	fbf44703          	lbu	a4,-65(s0)
80000f10:	02500793          	li	a5,37
80000f14:	04f71863          	bne	a4,a5,80000f64 <printf+0xb0>
			if(tt==1){
80000f18:	fe842703          	lw	a4,-24(s0)
80000f1c:	00100793          	li	a5,1
80000f20:	02f71663          	bne	a4,a5,80000f4c <printf+0x98>
				outbuf[idx++]='%';
80000f24:	fe442783          	lw	a5,-28(s0)
80000f28:	00178713          	addi	a4,a5,1
80000f2c:	fee42223          	sw	a4,-28(s0)
80000f30:	8000c737          	lui	a4,0x8000c
80000f34:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80000f38:	00f707b3          	add	a5,a4,a5
80000f3c:	02500713          	li	a4,37
80000f40:	00e78023          	sb	a4,0(a5)
				tt=0;
80000f44:	fe042423          	sw	zero,-24(s0)
80000f48:	00c0006f          	j	80000f54 <printf+0xa0>
			}else{
				tt=1;
80000f4c:	00100793          	li	a5,1
80000f50:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000f54:	fec42783          	lw	a5,-20(s0)
80000f58:	00178793          	addi	a5,a5,1
80000f5c:	fef42623          	sw	a5,-20(s0)
80000f60:	3140006f          	j	80001274 <printf+0x3c0>
		}else{
			if(tt==1){
80000f64:	fe842703          	lw	a4,-24(s0)
80000f68:	00100793          	li	a5,1
80000f6c:	2cf71e63          	bne	a4,a5,80001248 <printf+0x394>
				switch (ch)
80000f70:	fbf44783          	lbu	a5,-65(s0)
80000f74:	fa878793          	addi	a5,a5,-88
80000f78:	02000713          	li	a4,32
80000f7c:	2af76663          	bltu	a4,a5,80001228 <printf+0x374>
80000f80:	00279713          	slli	a4,a5,0x2
80000f84:	800027b7          	lui	a5,0x80002
80000f88:	2bc78793          	addi	a5,a5,700 # 800022bc <memend+0xf80022bc>
80000f8c:	00f707b3          	add	a5,a4,a5
80000f90:	0007a783          	lw	a5,0(a5)
80000f94:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000f98:	fb842783          	lw	a5,-72(s0)
80000f9c:	00478713          	addi	a4,a5,4
80000fa0:	fae42c23          	sw	a4,-72(s0)
80000fa4:	0007a783          	lw	a5,0(a5)
80000fa8:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000fac:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000fb0:	fe042783          	lw	a5,-32(s0)
80000fb4:	fcf42c23          	sw	a5,-40(s0)
80000fb8:	0100006f          	j	80000fc8 <printf+0x114>
80000fbc:	fdc42783          	lw	a5,-36(s0)
80000fc0:	00178793          	addi	a5,a5,1
80000fc4:	fcf42e23          	sw	a5,-36(s0)
80000fc8:	fd842703          	lw	a4,-40(s0)
80000fcc:	00a00793          	li	a5,10
80000fd0:	02f747b3          	div	a5,a4,a5
80000fd4:	fcf42c23          	sw	a5,-40(s0)
80000fd8:	fd842783          	lw	a5,-40(s0)
80000fdc:	fe0790e3          	bnez	a5,80000fbc <printf+0x108>
					for(int i=len;i>=0;i--){
80000fe0:	fdc42783          	lw	a5,-36(s0)
80000fe4:	fcf42a23          	sw	a5,-44(s0)
80000fe8:	0540006f          	j	8000103c <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000fec:	fe042703          	lw	a4,-32(s0)
80000ff0:	00a00793          	li	a5,10
80000ff4:	02f767b3          	rem	a5,a4,a5
80000ff8:	0ff7f713          	andi	a4,a5,255
80000ffc:	fe442683          	lw	a3,-28(s0)
80001000:	fd442783          	lw	a5,-44(s0)
80001004:	00f687b3          	add	a5,a3,a5
80001008:	03070713          	addi	a4,a4,48
8000100c:	0ff77713          	andi	a4,a4,255
80001010:	8000c6b7          	lui	a3,0x8000c
80001014:	00468693          	addi	a3,a3,4 # 8000c004 <memend+0xf800c004>
80001018:	00f687b3          	add	a5,a3,a5
8000101c:	00e78023          	sb	a4,0(a5)
						x/=10;
80001020:	fe042703          	lw	a4,-32(s0)
80001024:	00a00793          	li	a5,10
80001028:	02f747b3          	div	a5,a4,a5
8000102c:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80001030:	fd442783          	lw	a5,-44(s0)
80001034:	fff78793          	addi	a5,a5,-1
80001038:	fcf42a23          	sw	a5,-44(s0)
8000103c:	fd442783          	lw	a5,-44(s0)
80001040:	fa07d6e3          	bgez	a5,80000fec <printf+0x138>
					}
					idx+=(len+1);
80001044:	fdc42783          	lw	a5,-36(s0)
80001048:	00178793          	addi	a5,a5,1
8000104c:	fe442703          	lw	a4,-28(s0)
80001050:	00f707b3          	add	a5,a4,a5
80001054:	fef42223          	sw	a5,-28(s0)
					tt=0;
80001058:	fe042423          	sw	zero,-24(s0)
					break;
8000105c:	1dc0006f          	j	80001238 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80001060:	fe442783          	lw	a5,-28(s0)
80001064:	00178713          	addi	a4,a5,1
80001068:	fee42223          	sw	a4,-28(s0)
8000106c:	8000c737          	lui	a4,0x8000c
80001070:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80001074:	00f707b3          	add	a5,a4,a5
80001078:	03000713          	li	a4,48
8000107c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80001080:	fe442783          	lw	a5,-28(s0)
80001084:	00178713          	addi	a4,a5,1
80001088:	fee42223          	sw	a4,-28(s0)
8000108c:	8000c737          	lui	a4,0x8000c
80001090:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
80001094:	00f707b3          	add	a5,a4,a5
80001098:	07800713          	li	a4,120
8000109c:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
800010a0:	fb842783          	lw	a5,-72(s0)
800010a4:	00478713          	addi	a4,a5,4
800010a8:	fae42c23          	sw	a4,-72(s0)
800010ac:	0007a783          	lw	a5,0(a5)
800010b0:	fcf42823          	sw	a5,-48(s0)
					int len=0;
800010b4:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
800010b8:	fd042783          	lw	a5,-48(s0)
800010bc:	fcf42423          	sw	a5,-56(s0)
800010c0:	0100006f          	j	800010d0 <printf+0x21c>
800010c4:	fcc42783          	lw	a5,-52(s0)
800010c8:	00178793          	addi	a5,a5,1
800010cc:	fcf42623          	sw	a5,-52(s0)
800010d0:	fc842783          	lw	a5,-56(s0)
800010d4:	0047d793          	srli	a5,a5,0x4
800010d8:	fcf42423          	sw	a5,-56(s0)
800010dc:	fc842783          	lw	a5,-56(s0)
800010e0:	fe0792e3          	bnez	a5,800010c4 <printf+0x210>
					for(int i=len;i>=0;i--){
800010e4:	fcc42783          	lw	a5,-52(s0)
800010e8:	fcf42223          	sw	a5,-60(s0)
800010ec:	0840006f          	j	80001170 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
800010f0:	fd042783          	lw	a5,-48(s0)
800010f4:	00f7f713          	andi	a4,a5,15
800010f8:	00900793          	li	a5,9
800010fc:	02e7f063          	bgeu	a5,a4,8000111c <printf+0x268>
80001100:	fd042783          	lw	a5,-48(s0)
80001104:	0ff7f793          	andi	a5,a5,255
80001108:	00f7f793          	andi	a5,a5,15
8000110c:	0ff7f793          	andi	a5,a5,255
80001110:	05778793          	addi	a5,a5,87
80001114:	0ff7f793          	andi	a5,a5,255
80001118:	01c0006f          	j	80001134 <printf+0x280>
8000111c:	fd042783          	lw	a5,-48(s0)
80001120:	0ff7f793          	andi	a5,a5,255
80001124:	00f7f793          	andi	a5,a5,15
80001128:	0ff7f793          	andi	a5,a5,255
8000112c:	03078793          	addi	a5,a5,48
80001130:	0ff7f793          	andi	a5,a5,255
80001134:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80001138:	fe442703          	lw	a4,-28(s0)
8000113c:	fc442783          	lw	a5,-60(s0)
80001140:	00f707b3          	add	a5,a4,a5
80001144:	8000c737          	lui	a4,0x8000c
80001148:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
8000114c:	00f707b3          	add	a5,a4,a5
80001150:	fbe44703          	lbu	a4,-66(s0)
80001154:	00e78023          	sb	a4,0(a5)
						x/=16;
80001158:	fd042783          	lw	a5,-48(s0)
8000115c:	0047d793          	srli	a5,a5,0x4
80001160:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80001164:	fc442783          	lw	a5,-60(s0)
80001168:	fff78793          	addi	a5,a5,-1
8000116c:	fcf42223          	sw	a5,-60(s0)
80001170:	fc442783          	lw	a5,-60(s0)
80001174:	f607dee3          	bgez	a5,800010f0 <printf+0x23c>
					}
					idx+=(len+1);
80001178:	fcc42783          	lw	a5,-52(s0)
8000117c:	00178793          	addi	a5,a5,1
80001180:	fe442703          	lw	a4,-28(s0)
80001184:	00f707b3          	add	a5,a4,a5
80001188:	fef42223          	sw	a5,-28(s0)
					tt=0;
8000118c:	fe042423          	sw	zero,-24(s0)
					break;
80001190:	0a80006f          	j	80001238 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80001194:	fb842783          	lw	a5,-72(s0)
80001198:	00478713          	addi	a4,a5,4
8000119c:	fae42c23          	sw	a4,-72(s0)
800011a0:	0007a783          	lw	a5,0(a5)
800011a4:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
800011a8:	fe442783          	lw	a5,-28(s0)
800011ac:	00178713          	addi	a4,a5,1
800011b0:	fee42223          	sw	a4,-28(s0)
800011b4:	8000c737          	lui	a4,0x8000c
800011b8:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
800011bc:	00f707b3          	add	a5,a4,a5
800011c0:	fbf44703          	lbu	a4,-65(s0)
800011c4:	00e78023          	sb	a4,0(a5)
					tt=0;
800011c8:	fe042423          	sw	zero,-24(s0)
					break;
800011cc:	06c0006f          	j	80001238 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
800011d0:	fb842783          	lw	a5,-72(s0)
800011d4:	00478713          	addi	a4,a5,4
800011d8:	fae42c23          	sw	a4,-72(s0)
800011dc:	0007a783          	lw	a5,0(a5)
800011e0:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
800011e4:	0300006f          	j	80001214 <printf+0x360>
						outbuf[idx++]=*ss++;
800011e8:	fc042703          	lw	a4,-64(s0)
800011ec:	00170793          	addi	a5,a4,1
800011f0:	fcf42023          	sw	a5,-64(s0)
800011f4:	fe442783          	lw	a5,-28(s0)
800011f8:	00178693          	addi	a3,a5,1
800011fc:	fed42223          	sw	a3,-28(s0)
80001200:	00074703          	lbu	a4,0(a4)
80001204:	8000c6b7          	lui	a3,0x8000c
80001208:	00468693          	addi	a3,a3,4 # 8000c004 <memend+0xf800c004>
8000120c:	00f687b3          	add	a5,a3,a5
80001210:	00e78023          	sb	a4,0(a5)
					while(*ss){
80001214:	fc042783          	lw	a5,-64(s0)
80001218:	0007c783          	lbu	a5,0(a5)
8000121c:	fc0796e3          	bnez	a5,800011e8 <printf+0x334>
					}
					tt=0;
80001220:	fe042423          	sw	zero,-24(s0)
					break;
80001224:	0140006f          	j	80001238 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80001228:	800027b7          	lui	a5,0x80002
8000122c:	2a478513          	addi	a0,a5,676 # 800022a4 <memend+0xf80022a4>
80001230:	c4dff0ef          	jal	ra,80000e7c <panic>
					break;
80001234:	00000013          	nop
				}
				s++;
80001238:	fec42783          	lw	a5,-20(s0)
8000123c:	00178793          	addi	a5,a5,1
80001240:	fef42623          	sw	a5,-20(s0)
80001244:	0300006f          	j	80001274 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80001248:	fe442783          	lw	a5,-28(s0)
8000124c:	00178713          	addi	a4,a5,1
80001250:	fee42223          	sw	a4,-28(s0)
80001254:	8000c737          	lui	a4,0x8000c
80001258:	00470713          	addi	a4,a4,4 # 8000c004 <memend+0xf800c004>
8000125c:	00f707b3          	add	a5,a4,a5
80001260:	fbf44703          	lbu	a4,-65(s0)
80001264:	00e78023          	sb	a4,0(a5)
				s++;
80001268:	fec42783          	lw	a5,-20(s0)
8000126c:	00178793          	addi	a5,a5,1
80001270:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
80001274:	fec42783          	lw	a5,-20(s0)
80001278:	0007c783          	lbu	a5,0(a5)
8000127c:	faf40fa3          	sb	a5,-65(s0)
80001280:	fbf44783          	lbu	a5,-65(s0)
80001284:	c80794e3          	bnez	a5,80000f0c <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80001288:	8000c7b7          	lui	a5,0x8000c
8000128c:	00478713          	addi	a4,a5,4 # 8000c004 <memend+0xf800c004>
80001290:	fe442783          	lw	a5,-28(s0)
80001294:	00f707b3          	add	a5,a4,a5
80001298:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
8000129c:	8000c7b7          	lui	a5,0x8000c
800012a0:	00478513          	addi	a0,a5,4 # 8000c004 <memend+0xf800c004>
800012a4:	e04ff0ef          	jal	ra,800008a8 <uartputs>
	return idx;
800012a8:	fe442783          	lw	a5,-28(s0)
800012ac:	00078513          	mv	a0,a5
800012b0:	05c12083          	lw	ra,92(sp)
800012b4:	05812403          	lw	s0,88(sp)
800012b8:	08010113          	addi	sp,sp,128
800012bc:	00008067          	ret

800012c0 <minit>:
struct
{
    struct pmp* freelist;
}mem;

void minit(){
800012c0:	fe010113          	addi	sp,sp,-32
800012c4:	00812e23          	sw	s0,28(sp)
800012c8:	02010413          	addi	s0,sp,32
        printf("mstart:%p   ",mstart);
        printf("mend:%p\n",mend);
        printf("stack:%p\n",stacks);
    #endif

    char* p=(char*)mstart;
800012cc:	8000d7b7          	lui	a5,0x8000d
800012d0:	00078793          	mv	a5,a5
800012d4:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800012d8:	0380006f          	j	80001310 <minit+0x50>
        m=(struct pmp*)p;
800012dc:	fec42783          	lw	a5,-20(s0)
800012e0:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
800012e4:	8000c7b7          	lui	a5,0x8000c
800012e8:	4447a703          	lw	a4,1092(a5) # 8000c444 <memend+0xf800c444>
800012ec:	fe842783          	lw	a5,-24(s0)
800012f0:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
800012f4:	8000c7b7          	lui	a5,0x8000c
800012f8:	fe842703          	lw	a4,-24(s0)
800012fc:	44e7a223          	sw	a4,1092(a5) # 8000c444 <memend+0xf800c444>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001300:	fec42703          	lw	a4,-20(s0)
80001304:	000017b7          	lui	a5,0x1
80001308:	00f707b3          	add	a5,a4,a5
8000130c:	fef42623          	sw	a5,-20(s0)
80001310:	fec42703          	lw	a4,-20(s0)
80001314:	000017b7          	lui	a5,0x1
80001318:	00f70733          	add	a4,a4,a5
8000131c:	880007b7          	lui	a5,0x88000
80001320:	00078793          	mv	a5,a5
80001324:	fae7fce3          	bgeu	a5,a4,800012dc <minit+0x1c>
    }
}
80001328:	00000013          	nop
8000132c:	00000013          	nop
80001330:	01c12403          	lw	s0,28(sp)
80001334:	02010113          	addi	sp,sp,32
80001338:	00008067          	ret

8000133c <palloc>:

void* palloc(){
8000133c:	fe010113          	addi	sp,sp,-32
80001340:	00112e23          	sw	ra,28(sp)
80001344:	00812c23          	sw	s0,24(sp)
80001348:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
8000134c:	8000c7b7          	lui	a5,0x8000c
80001350:	4447a783          	lw	a5,1092(a5) # 8000c444 <memend+0xf800c444>
80001354:	fef42623          	sw	a5,-20(s0)
    if(p)
80001358:	fec42783          	lw	a5,-20(s0)
8000135c:	00078c63          	beqz	a5,80001374 <palloc+0x38>
        mem.freelist=mem.freelist->next;
80001360:	8000c7b7          	lui	a5,0x8000c
80001364:	4447a783          	lw	a5,1092(a5) # 8000c444 <memend+0xf800c444>
80001368:	0007a703          	lw	a4,0(a5)
8000136c:	8000c7b7          	lui	a5,0x8000c
80001370:	44e7a223          	sw	a4,1092(a5) # 8000c444 <memend+0xf800c444>
    if(p)
80001374:	fec42783          	lw	a5,-20(s0)
80001378:	00078a63          	beqz	a5,8000138c <palloc+0x50>
        memset(p,0,PGSIZE);
8000137c:	00001637          	lui	a2,0x1
80001380:	00000593          	li	a1,0
80001384:	fec42503          	lw	a0,-20(s0)
80001388:	1a9000ef          	jal	ra,80001d30 <memset>
    return (void*)p;
8000138c:	fec42783          	lw	a5,-20(s0)
}
80001390:	00078513          	mv	a0,a5
80001394:	01c12083          	lw	ra,28(sp)
80001398:	01812403          	lw	s0,24(sp)
8000139c:	02010113          	addi	sp,sp,32
800013a0:	00008067          	ret

800013a4 <pfree>:

void pfree(void* addr){
800013a4:	fd010113          	addi	sp,sp,-48
800013a8:	02812623          	sw	s0,44(sp)
800013ac:	03010413          	addi	s0,sp,48
800013b0:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
800013b4:	fdc42783          	lw	a5,-36(s0)
800013b8:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
800013bc:	8000c7b7          	lui	a5,0x8000c
800013c0:	4447a703          	lw	a4,1092(a5) # 8000c444 <memend+0xf800c444>
800013c4:	fec42783          	lw	a5,-20(s0)
800013c8:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
800013cc:	8000c7b7          	lui	a5,0x8000c
800013d0:	fec42703          	lw	a4,-20(s0)
800013d4:	44e7a223          	sw	a4,1092(a5) # 8000c444 <memend+0xf800c444>
800013d8:	00000013          	nop
800013dc:	02c12403          	lw	s0,44(sp)
800013e0:	03010113          	addi	sp,sp,48
800013e4:	00008067          	ret

800013e8 <r_tp>:
static inline uint32 r_tp(){
800013e8:	fe010113          	addi	sp,sp,-32
800013ec:	00812e23          	sw	s0,28(sp)
800013f0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800013f4:	00020793          	mv	a5,tp
800013f8:	fef42623          	sw	a5,-20(s0)
    return x;
800013fc:	fec42783          	lw	a5,-20(s0)
}
80001400:	00078513          	mv	a0,a5
80001404:	01c12403          	lw	s0,28(sp)
80001408:	02010113          	addi	sp,sp,32
8000140c:	00008067          	ret

80001410 <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
80001410:	fe010113          	addi	sp,sp,-32
80001414:	00812e23          	sw	s0,28(sp)
80001418:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
8000141c:	104027f3          	csrr	a5,sie
80001420:	fef42623          	sw	a5,-20(s0)
    return x;
80001424:	fec42783          	lw	a5,-20(s0)
}
80001428:	00078513          	mv	a0,a5
8000142c:	01c12403          	lw	s0,28(sp)
80001430:	02010113          	addi	sp,sp,32
80001434:	00008067          	ret

80001438 <w_sie>:
static inline void w_sie(uint32 x){
80001438:	fe010113          	addi	sp,sp,-32
8000143c:	00812e23          	sw	s0,28(sp)
80001440:	02010413          	addi	s0,sp,32
80001444:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80001448:	fec42783          	lw	a5,-20(s0)
8000144c:	10479073          	csrw	sie,a5
}
80001450:	00000013          	nop
80001454:	01c12403          	lw	s0,28(sp)
80001458:	02010113          	addi	sp,sp,32
8000145c:	00008067          	ret

80001460 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
80001460:	ff010113          	addi	sp,sp,-16
80001464:	00112623          	sw	ra,12(sp)
80001468:	00812423          	sw	s0,8(sp)
8000146c:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
80001470:	0c0007b7          	lui	a5,0xc000
80001474:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001478:	00100713          	li	a4,1
8000147c:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001480:	f69ff0ef          	jal	ra,800013e8 <r_tp>
80001484:	00050793          	mv	a5,a0
80001488:	00879713          	slli	a4,a5,0x8
8000148c:	0c0027b7          	lui	a5,0xc002
80001490:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001494:	00f707b3          	add	a5,a4,a5
80001498:	00078713          	mv	a4,a5
8000149c:	40000793          	li	a5,1024
800014a0:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800014a4:	f45ff0ef          	jal	ra,800013e8 <r_tp>
800014a8:	00050713          	mv	a4,a0
800014ac:	000c07b7          	lui	a5,0xc0
800014b0:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800014b4:	00f707b3          	add	a5,a4,a5
800014b8:	00879793          	slli	a5,a5,0x8
800014bc:	00078713          	mv	a4,a5
800014c0:	40000793          	li	a5,1024
800014c4:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
800014c8:	f21ff0ef          	jal	ra,800013e8 <r_tp>
800014cc:	00050713          	mv	a4,a0
800014d0:	000067b7          	lui	a5,0x6
800014d4:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800014d8:	00f707b3          	add	a5,a4,a5
800014dc:	00d79793          	slli	a5,a5,0xd
800014e0:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800014e4:	f05ff0ef          	jal	ra,800013e8 <r_tp>
800014e8:	00050793          	mv	a5,a0
800014ec:	00d79713          	slli	a4,a5,0xd
800014f0:	0c2017b7          	lui	a5,0xc201
800014f4:	00f707b3          	add	a5,a4,a5
800014f8:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800014fc:	f15ff0ef          	jal	ra,80001410 <r_sie>
80001500:	00050793          	mv	a5,a0
80001504:	2227e793          	ori	a5,a5,546
80001508:	00078513          	mv	a0,a5
8000150c:	f2dff0ef          	jal	ra,80001438 <w_sie>
}
80001510:	00000013          	nop
80001514:	00c12083          	lw	ra,12(sp)
80001518:	00812403          	lw	s0,8(sp)
8000151c:	01010113          	addi	sp,sp,16
80001520:	00008067          	ret

80001524 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80001524:	ff010113          	addi	sp,sp,-16
80001528:	00112623          	sw	ra,12(sp)
8000152c:	00812423          	sw	s0,8(sp)
80001530:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001534:	eb5ff0ef          	jal	ra,800013e8 <r_tp>
80001538:	00050793          	mv	a5,a0
8000153c:	00d79713          	slli	a4,a5,0xd
80001540:	0c2017b7          	lui	a5,0xc201
80001544:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001548:	00f707b3          	add	a5,a4,a5
8000154c:	0007a783          	lw	a5,0(a5)
}
80001550:	00078513          	mv	a0,a5
80001554:	00c12083          	lw	ra,12(sp)
80001558:	00812403          	lw	s0,8(sp)
8000155c:	01010113          	addi	sp,sp,16
80001560:	00008067          	ret

80001564 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001564:	fe010113          	addi	sp,sp,-32
80001568:	00112e23          	sw	ra,28(sp)
8000156c:	00812c23          	sw	s0,24(sp)
80001570:	02010413          	addi	s0,sp,32
80001574:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80001578:	e71ff0ef          	jal	ra,800013e8 <r_tp>
8000157c:	00050793          	mv	a5,a0
80001580:	00d79713          	slli	a4,a5,0xd
80001584:	0c2007b7          	lui	a5,0xc200
80001588:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
8000158c:	00f707b3          	add	a5,a4,a5
80001590:	00078713          	mv	a4,a5
80001594:	fec42783          	lw	a5,-20(s0)
80001598:	00f72023          	sw	a5,0(a4)
8000159c:	00000013          	nop
800015a0:	01c12083          	lw	ra,28(sp)
800015a4:	01812403          	lw	s0,24(sp)
800015a8:	02010113          	addi	sp,sp,32
800015ac:	00008067          	ret

800015b0 <w_satp>:
static inline void w_satp(uint32 x){
800015b0:	fe010113          	addi	sp,sp,-32
800015b4:	00812e23          	sw	s0,28(sp)
800015b8:	02010413          	addi	s0,sp,32
800015bc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800015c0:	fec42783          	lw	a5,-20(s0)
800015c4:	18079073          	csrw	satp,a5
}
800015c8:	00000013          	nop
800015cc:	01c12403          	lw	s0,28(sp)
800015d0:	02010113          	addi	sp,sp,32
800015d4:	00008067          	ret

800015d8 <sfence_vma>:
static inline void sfence_vma(){
800015d8:	ff010113          	addi	sp,sp,-16
800015dc:	00812623          	sw	s0,12(sp)
800015e0:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800015e4:	12000073          	sfence.vma
}
800015e8:	00000013          	nop
800015ec:	00c12403          	lw	s0,12(sp)
800015f0:	01010113          	addi	sp,sp,16
800015f4:	00008067          	ret

800015f8 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
800015f8:	fd010113          	addi	sp,sp,-48
800015fc:	02112623          	sw	ra,44(sp)
80001600:	02812423          	sw	s0,40(sp)
80001604:	03010413          	addi	s0,sp,48
80001608:	fca42e23          	sw	a0,-36(s0)
8000160c:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
80001610:	fd842783          	lw	a5,-40(s0)
80001614:	0167d793          	srli	a5,a5,0x16
80001618:	00279793          	slli	a5,a5,0x2
8000161c:	fdc42703          	lw	a4,-36(s0)
80001620:	00f707b3          	add	a5,a4,a5
80001624:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001628:	fec42783          	lw	a5,-20(s0)
8000162c:	0007a783          	lw	a5,0(a5)
80001630:	0017f793          	andi	a5,a5,1
80001634:	00078e63          	beqz	a5,80001650 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001638:	fec42783          	lw	a5,-20(s0)
8000163c:	0007a783          	lw	a5,0(a5)
80001640:	00a7d793          	srli	a5,a5,0xa
80001644:	00c79793          	slli	a5,a5,0xc
80001648:	fcf42e23          	sw	a5,-36(s0)
8000164c:	0340006f          	j	80001680 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
80001650:	cedff0ef          	jal	ra,8000133c <palloc>
80001654:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001658:	00001637          	lui	a2,0x1
8000165c:	00000593          	li	a1,0
80001660:	fdc42503          	lw	a0,-36(s0)
80001664:	6cc000ef          	jal	ra,80001d30 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001668:	fdc42783          	lw	a5,-36(s0)
8000166c:	00c7d793          	srli	a5,a5,0xc
80001670:	00a79793          	slli	a5,a5,0xa
80001674:	0017e713          	ori	a4,a5,1
80001678:	fec42783          	lw	a5,-20(s0)
8000167c:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001680:	fd842783          	lw	a5,-40(s0)
80001684:	00c7d793          	srli	a5,a5,0xc
80001688:	3ff7f793          	andi	a5,a5,1023
8000168c:	00279793          	slli	a5,a5,0x2
80001690:	fdc42703          	lw	a4,-36(s0)
80001694:	00f707b3          	add	a5,a4,a5
}
80001698:	00078513          	mv	a0,a5
8000169c:	02c12083          	lw	ra,44(sp)
800016a0:	02812403          	lw	s0,40(sp)
800016a4:	03010113          	addi	sp,sp,48
800016a8:	00008067          	ret

800016ac <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
800016ac:	fc010113          	addi	sp,sp,-64
800016b0:	02112e23          	sw	ra,60(sp)
800016b4:	02812c23          	sw	s0,56(sp)
800016b8:	04010413          	addi	s0,sp,64
800016bc:	fca42e23          	sw	a0,-36(s0)
800016c0:	fcb42c23          	sw	a1,-40(s0)
800016c4:	fcc42a23          	sw	a2,-44(s0)
800016c8:	fcd42823          	sw	a3,-48(s0)
800016cc:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
800016d0:	fd842703          	lw	a4,-40(s0)
800016d4:	fffff7b7          	lui	a5,0xfffff
800016d8:	00f777b3          	and	a5,a4,a5
800016dc:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
800016e0:	fd042703          	lw	a4,-48(s0)
800016e4:	fd842783          	lw	a5,-40(s0)
800016e8:	00f707b3          	add	a5,a4,a5
800016ec:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
800016f0:	fffff7b7          	lui	a5,0xfffff
800016f4:	00f777b3          	and	a5,a4,a5
800016f8:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
800016fc:	fec42583          	lw	a1,-20(s0)
80001700:	fdc42503          	lw	a0,-36(s0)
80001704:	ef5ff0ef          	jal	ra,800015f8 <acquriepte>
80001708:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
8000170c:	fe442783          	lw	a5,-28(s0)
80001710:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001714:	0017f793          	andi	a5,a5,1
80001718:	00078863          	beqz	a5,80001728 <vmmap+0x7c>
            panic("repeat map");
8000171c:	800027b7          	lui	a5,0x80002
80001720:	34078513          	addi	a0,a5,832 # 80002340 <memend+0xf8002340>
80001724:	f58ff0ef          	jal	ra,80000e7c <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001728:	fd442783          	lw	a5,-44(s0)
8000172c:	00c7d793          	srli	a5,a5,0xc
80001730:	00a79713          	slli	a4,a5,0xa
80001734:	fcc42783          	lw	a5,-52(s0)
80001738:	00f767b3          	or	a5,a4,a5
8000173c:	0017e713          	ori	a4,a5,1
80001740:	fe442783          	lw	a5,-28(s0)
80001744:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001748:	fec42703          	lw	a4,-20(s0)
8000174c:	fe842783          	lw	a5,-24(s0)
80001750:	02f70463          	beq	a4,a5,80001778 <vmmap+0xcc>
        start += PGSIZE;
80001754:	fec42703          	lw	a4,-20(s0)
80001758:	000017b7          	lui	a5,0x1
8000175c:	00f707b3          	add	a5,a4,a5
80001760:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001764:	fd442703          	lw	a4,-44(s0)
80001768:	000017b7          	lui	a5,0x1
8000176c:	00f707b3          	add	a5,a4,a5
80001770:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001774:	f89ff06f          	j	800016fc <vmmap+0x50>
        if(start==end)  break;
80001778:	00000013          	nop
    }
}
8000177c:	00000013          	nop
80001780:	03c12083          	lw	ra,60(sp)
80001784:	03812403          	lw	s0,56(sp)
80001788:	04010113          	addi	sp,sp,64
8000178c:	00008067          	ret

80001790 <printpgt>:

void printpgt(addr_t* pgt){
80001790:	fc010113          	addi	sp,sp,-64
80001794:	02112e23          	sw	ra,60(sp)
80001798:	02812c23          	sw	s0,56(sp)
8000179c:	04010413          	addi	s0,sp,64
800017a0:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
800017a4:	fe042623          	sw	zero,-20(s0)
800017a8:	0c40006f          	j	8000186c <printpgt+0xdc>
        pte_t pte=pgt[i];
800017ac:	fec42783          	lw	a5,-20(s0)
800017b0:	00279793          	slli	a5,a5,0x2
800017b4:	fcc42703          	lw	a4,-52(s0)
800017b8:	00f707b3          	add	a5,a4,a5
800017bc:	0007a783          	lw	a5,0(a5) # 1000 <sz>
800017c0:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
800017c4:	fe442783          	lw	a5,-28(s0)
800017c8:	0017f793          	andi	a5,a5,1
800017cc:	08078a63          	beqz	a5,80001860 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
800017d0:	fe442783          	lw	a5,-28(s0)
800017d4:	00a7d793          	srli	a5,a5,0xa
800017d8:	00c79793          	slli	a5,a5,0xc
800017dc:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
800017e0:	fe042683          	lw	a3,-32(s0)
800017e4:	fe442603          	lw	a2,-28(s0)
800017e8:	fec42583          	lw	a1,-20(s0)
800017ec:	800027b7          	lui	a5,0x80002
800017f0:	34c78513          	addi	a0,a5,844 # 8000234c <memend+0xf800234c>
800017f4:	ec0ff0ef          	jal	ra,80000eb4 <printf>
            for(int j=0;j<1024;j++){
800017f8:	fe042423          	sw	zero,-24(s0)
800017fc:	0580006f          	j	80001854 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001800:	fe842783          	lw	a5,-24(s0)
80001804:	00279793          	slli	a5,a5,0x2
80001808:	fe042703          	lw	a4,-32(s0)
8000180c:	00f707b3          	add	a5,a4,a5
80001810:	0007a783          	lw	a5,0(a5)
80001814:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001818:	fdc42783          	lw	a5,-36(s0)
8000181c:	0017f793          	andi	a5,a5,1
80001820:	02078463          	beqz	a5,80001848 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001824:	fdc42783          	lw	a5,-36(s0)
80001828:	00a7d793          	srli	a5,a5,0xa
8000182c:	00c79793          	slli	a5,a5,0xc
80001830:	00078693          	mv	a3,a5
80001834:	fdc42603          	lw	a2,-36(s0)
80001838:	fe842583          	lw	a1,-24(s0)
8000183c:	800027b7          	lui	a5,0x80002
80001840:	36478513          	addi	a0,a5,868 # 80002364 <memend+0xf8002364>
80001844:	e70ff0ef          	jal	ra,80000eb4 <printf>
            for(int j=0;j<1024;j++){
80001848:	fe842783          	lw	a5,-24(s0)
8000184c:	00178793          	addi	a5,a5,1
80001850:	fef42423          	sw	a5,-24(s0)
80001854:	fe842703          	lw	a4,-24(s0)
80001858:	3ff00793          	li	a5,1023
8000185c:	fae7d2e3          	bge	a5,a4,80001800 <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001860:	fec42783          	lw	a5,-20(s0)
80001864:	00178793          	addi	a5,a5,1
80001868:	fef42623          	sw	a5,-20(s0)
8000186c:	fec42703          	lw	a4,-20(s0)
80001870:	3ff00793          	li	a5,1023
80001874:	f2e7dce3          	bge	a5,a4,800017ac <printpgt+0x1c>
                }
            }
        }
    }
}
80001878:	00000013          	nop
8000187c:	00000013          	nop
80001880:	03c12083          	lw	ra,60(sp)
80001884:	03812403          	lw	s0,56(sp)
80001888:	04010113          	addi	sp,sp,64
8000188c:	00008067          	ret

80001890 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
80001890:	fd010113          	addi	sp,sp,-48
80001894:	02112623          	sw	ra,44(sp)
80001898:	02812423          	sw	s0,40(sp)
8000189c:	03010413          	addi	s0,sp,48
800018a0:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
800018a4:	fe042623          	sw	zero,-20(s0)
800018a8:	04c0006f          	j	800018f4 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
800018ac:	fec42783          	lw	a5,-20(s0)
800018b0:	00d79793          	slli	a5,a5,0xd
800018b4:	00078713          	mv	a4,a5
800018b8:	c00017b7          	lui	a5,0xc0001
800018bc:	00f707b3          	add	a5,a4,a5
800018c0:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
800018c4:	a79ff0ef          	jal	ra,8000133c <palloc>
800018c8:	00050793          	mv	a5,a0
800018cc:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
800018d0:	00600713          	li	a4,6
800018d4:	000016b7          	lui	a3,0x1
800018d8:	fe442603          	lw	a2,-28(s0)
800018dc:	fe842583          	lw	a1,-24(s0)
800018e0:	fdc42503          	lw	a0,-36(s0)
800018e4:	dc9ff0ef          	jal	ra,800016ac <vmmap>
    for(int i=0;i<NPROC;i++){
800018e8:	fec42783          	lw	a5,-20(s0)
800018ec:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
800018f0:	fef42623          	sw	a5,-20(s0)
800018f4:	fec42703          	lw	a4,-20(s0)
800018f8:	00300793          	li	a5,3
800018fc:	fae7d8e3          	bge	a5,a4,800018ac <mkstack+0x1c>
    }
}
80001900:	00000013          	nop
80001904:	00000013          	nop
80001908:	02c12083          	lw	ra,44(sp)
8000190c:	02812403          	lw	s0,40(sp)
80001910:	03010113          	addi	sp,sp,48
80001914:	00008067          	ret

80001918 <vminit>:

// 初始化虚拟内存
void vminit(){
80001918:	ff010113          	addi	sp,sp,-16
8000191c:	00112623          	sw	ra,12(sp)
80001920:	00812423          	sw	s0,8(sp)
80001924:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001928:	a15ff0ef          	jal	ra,8000133c <palloc>
8000192c:	00050713          	mv	a4,a0
80001930:	8000c7b7          	lui	a5,0x8000c
80001934:	44e7a423          	sw	a4,1096(a5) # 8000c448 <memend+0xf800c448>
    memset(kpgt,0,PGSIZE);
80001938:	8000c7b7          	lui	a5,0x8000c
8000193c:	4487a783          	lw	a5,1096(a5) # 8000c448 <memend+0xf800c448>
80001940:	00001637          	lui	a2,0x1
80001944:	00000593          	li	a1,0
80001948:	00078513          	mv	a0,a5
8000194c:	3e4000ef          	jal	ra,80001d30 <memset>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
80001950:	8000c7b7          	lui	a5,0x8000c
80001954:	4487a783          	lw	a5,1096(a5) # 8000c448 <memend+0xf800c448>
80001958:	00600713          	li	a4,6
8000195c:	004006b7          	lui	a3,0x400
80001960:	0c000637          	lui	a2,0xc000
80001964:	0c0005b7          	lui	a1,0xc000
80001968:	00078513          	mv	a0,a5
8000196c:	d41ff0ef          	jal	ra,800016ac <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
80001970:	8000c7b7          	lui	a5,0x8000c
80001974:	4487a783          	lw	a5,1096(a5) # 8000c448 <memend+0xf800c448>
80001978:	00600713          	li	a4,6
8000197c:	000016b7          	lui	a3,0x1
80001980:	10000637          	lui	a2,0x10000
80001984:	100005b7          	lui	a1,0x10000
80001988:	00078513          	mv	a0,a5
8000198c:	d21ff0ef          	jal	ra,800016ac <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
80001990:	8000c7b7          	lui	a5,0x8000c
80001994:	4487a503          	lw	a0,1096(a5) # 8000c448 <memend+0xf800c448>
80001998:	800007b7          	lui	a5,0x80000
8000199c:	00078593          	mv	a1,a5
800019a0:	800007b7          	lui	a5,0x80000
800019a4:	00078613          	mv	a2,a5
800019a8:	800027b7          	lui	a5,0x80002
800019ac:	f8078713          	addi	a4,a5,-128 # 80001f80 <memend+0xf8001f80>
800019b0:	800007b7          	lui	a5,0x80000
800019b4:	00078793          	mv	a5,a5
800019b8:	40f707b3          	sub	a5,a4,a5
800019bc:	00a00713          	li	a4,10
800019c0:	00078693          	mv	a3,a5
800019c4:	ce9ff0ef          	jal	ra,800016ac <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
800019c8:	8000c7b7          	lui	a5,0x8000c
800019cc:	4487a503          	lw	a0,1096(a5) # 8000c448 <memend+0xf800c448>
800019d0:	800027b7          	lui	a5,0x80002
800019d4:	00078593          	mv	a1,a5
800019d8:	800027b7          	lui	a5,0x80002
800019dc:	00078613          	mv	a2,a5
800019e0:	800027b7          	lui	a5,0x80002
800019e4:	37b78713          	addi	a4,a5,891 # 8000237b <memend+0xf800237b>
800019e8:	800027b7          	lui	a5,0x80002
800019ec:	00078793          	mv	a5,a5
800019f0:	40f707b3          	sub	a5,a4,a5
800019f4:	00200713          	li	a4,2
800019f8:	00078693          	mv	a3,a5
800019fc:	cb1ff0ef          	jal	ra,800016ac <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001a00:	8000c7b7          	lui	a5,0x8000c
80001a04:	4487a503          	lw	a0,1096(a5) # 8000c448 <memend+0xf800c448>
80001a08:	800037b7          	lui	a5,0x80003
80001a0c:	00078593          	mv	a1,a5
80001a10:	800037b7          	lui	a5,0x80003
80001a14:	00078613          	mv	a2,a5
80001a18:	8000b7b7          	lui	a5,0x8000b
80001a1c:	00478713          	addi	a4,a5,4 # 8000b004 <memend+0xf800b004>
80001a20:	800037b7          	lui	a5,0x80003
80001a24:	00078793          	mv	a5,a5
80001a28:	40f707b3          	sub	a5,a4,a5
80001a2c:	00600713          	li	a4,6
80001a30:	00078693          	mv	a3,a5
80001a34:	c79ff0ef          	jal	ra,800016ac <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001a38:	8000c7b7          	lui	a5,0x8000c
80001a3c:	4487a503          	lw	a0,1096(a5) # 8000c448 <memend+0xf800c448>
80001a40:	8000c7b7          	lui	a5,0x8000c
80001a44:	00078593          	mv	a1,a5
80001a48:	8000c7b7          	lui	a5,0x8000c
80001a4c:	00078613          	mv	a2,a5
80001a50:	8000d7b7          	lui	a5,0x8000d
80001a54:	8bc78713          	addi	a4,a5,-1860 # 8000c8bc <memend+0xf800c8bc>
80001a58:	8000c7b7          	lui	a5,0x8000c
80001a5c:	00078793          	mv	a5,a5
80001a60:	40f707b3          	sub	a5,a4,a5
80001a64:	00600713          	li	a4,6
80001a68:	00078693          	mv	a3,a5
80001a6c:	c41ff0ef          	jal	ra,800016ac <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001a70:	8000c7b7          	lui	a5,0x8000c
80001a74:	4487a503          	lw	a0,1096(a5) # 8000c448 <memend+0xf800c448>
80001a78:	8000d7b7          	lui	a5,0x8000d
80001a7c:	00078593          	mv	a1,a5
80001a80:	8000d7b7          	lui	a5,0x8000d
80001a84:	00078613          	mv	a2,a5
80001a88:	880007b7          	lui	a5,0x88000
80001a8c:	00078713          	mv	a4,a5
80001a90:	8000d7b7          	lui	a5,0x8000d
80001a94:	00078793          	mv	a5,a5
80001a98:	40f707b3          	sub	a5,a4,a5
80001a9c:	00600713          	li	a4,6
80001aa0:	00078693          	mv	a3,a5
80001aa4:	c09ff0ef          	jal	ra,800016ac <vmmap>

    mkstack(kpgt);
80001aa8:	8000c7b7          	lui	a5,0x8000c
80001aac:	4487a783          	lw	a5,1096(a5) # 8000c448 <memend+0xf800c448>
80001ab0:	00078513          	mv	a0,a5
80001ab4:	dddff0ef          	jal	ra,80001890 <mkstack>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001ab8:	8000c7b7          	lui	a5,0x8000c
80001abc:	4487a783          	lw	a5,1096(a5) # 8000c448 <memend+0xf800c448>
80001ac0:	00c7d713          	srli	a4,a5,0xc
80001ac4:	800007b7          	lui	a5,0x80000
80001ac8:	00f767b3          	or	a5,a4,a5
80001acc:	00078513          	mv	a0,a5
80001ad0:	ae1ff0ef          	jal	ra,800015b0 <w_satp>
    sfence_vma();       // 刷新页表
80001ad4:	b05ff0ef          	jal	ra,800015d8 <sfence_vma>
}
80001ad8:	00000013          	nop
80001adc:	00c12083          	lw	ra,12(sp)
80001ae0:	00812403          	lw	s0,8(sp)
80001ae4:	01010113          	addi	sp,sp,16
80001ae8:	00008067          	ret

80001aec <pgtcreate>:

addr_t* pgtcreate(){
80001aec:	fe010113          	addi	sp,sp,-32
80001af0:	00112e23          	sw	ra,28(sp)
80001af4:	00812c23          	sw	s0,24(sp)
80001af8:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001afc:	841ff0ef          	jal	ra,8000133c <palloc>
80001b00:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001b04:	fec42783          	lw	a5,-20(s0)
}
80001b08:	00078513          	mv	a0,a5
80001b0c:	01c12083          	lw	ra,28(sp)
80001b10:	01812403          	lw	s0,24(sp)
80001b14:	02010113          	addi	sp,sp,32
80001b18:	00008067          	ret

80001b1c <procinit>:
#include "vm.h"
#include "defs.h"

uint nextpid=0;

void procinit(){
80001b1c:	fe010113          	addi	sp,sp,-32
80001b20:	00812e23          	sw	s0,28(sp)
80001b24:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001b28:	fe042623          	sw	zero,-20(s0)
80001b2c:	0480006f          	j	80001b74 <procinit+0x58>
        p=&proc[i];
80001b30:	fec42703          	lw	a4,-20(s0)
80001b34:	11c00793          	li	a5,284
80001b38:	02f70733          	mul	a4,a4,a5
80001b3c:	8000c7b7          	lui	a5,0x8000c
80001b40:	44c78793          	addi	a5,a5,1100 # 8000c44c <memend+0xf800c44c>
80001b44:	00f707b3          	add	a5,a4,a5
80001b48:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
80001b4c:	fec42783          	lw	a5,-20(s0)
80001b50:	00d79793          	slli	a5,a5,0xd
80001b54:	00078713          	mv	a4,a5
80001b58:	c00027b7          	lui	a5,0xc0002
80001b5c:	00f70733          	add	a4,a4,a5
80001b60:	fe842783          	lw	a5,-24(s0)
80001b64:	10e7ac23          	sw	a4,280(a5) # c0002118 <memend+0x38002118>
    for(int i=0;i<NPROC;i++){
80001b68:	fec42783          	lw	a5,-20(s0)
80001b6c:	00178793          	addi	a5,a5,1
80001b70:	fef42623          	sw	a5,-20(s0)
80001b74:	fec42703          	lw	a4,-20(s0)
80001b78:	00300793          	li	a5,3
80001b7c:	fae7dae3          	bge	a5,a4,80001b30 <procinit+0x14>
    }
}
80001b80:	00000013          	nop
80001b84:	00000013          	nop
80001b88:	01c12403          	lw	s0,28(sp)
80001b8c:	02010113          	addi	sp,sp,32
80001b90:	00008067          	ret

80001b94 <pidalloc>:

uint pidalloc(){
80001b94:	ff010113          	addi	sp,sp,-16
80001b98:	00812623          	sw	s0,12(sp)
80001b9c:	01010413          	addi	s0,sp,16
    return nextpid++;
80001ba0:	8000c7b7          	lui	a5,0x8000c
80001ba4:	0007a783          	lw	a5,0(a5) # 8000c000 <memend+0xf800c000>
80001ba8:	00178693          	addi	a3,a5,1
80001bac:	8000c737          	lui	a4,0x8000c
80001bb0:	00d72023          	sw	a3,0(a4) # 8000c000 <memend+0xf800c000>
} 
80001bb4:	00078513          	mv	a0,a5
80001bb8:	00c12403          	lw	s0,12(sp)
80001bbc:	01010113          	addi	sp,sp,16
80001bc0:	00008067          	ret

80001bc4 <procalloc>:

struct pcb* procalloc(){
80001bc4:	fe010113          	addi	sp,sp,-32
80001bc8:	00112e23          	sw	ra,28(sp)
80001bcc:	00812c23          	sw	s0,24(sp)
80001bd0:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80001bd4:	8000c7b7          	lui	a5,0x8000c
80001bd8:	44c78793          	addi	a5,a5,1100 # 8000c44c <memend+0xf800c44c>
80001bdc:	fef42623          	sw	a5,-20(s0)
80001be0:	0680006f          	j	80001c48 <procalloc+0x84>
        if(p->status==UNUSED){
80001be4:	fec42783          	lw	a5,-20(s0)
80001be8:	0047a783          	lw	a5,4(a5)
80001bec:	04079863          	bnez	a5,80001c3c <procalloc+0x78>
            p->pid=pidalloc();
80001bf0:	fa5ff0ef          	jal	ra,80001b94 <pidalloc>
80001bf4:	00050793          	mv	a5,a0
80001bf8:	00078713          	mv	a4,a5
80001bfc:	fec42783          	lw	a5,-20(s0)
80001c00:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80001c04:	fec42783          	lw	a5,-20(s0)
80001c08:	00100713          	li	a4,1
80001c0c:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
80001c10:	eddff0ef          	jal	ra,80001aec <pgtcreate>
80001c14:	00050713          	mv	a4,a0
80001c18:	fec42783          	lw	a5,-20(s0)
80001c1c:	10e7aa23          	sw	a4,276(a5)
            
            p->trapframe.epc=0;
80001c20:	fec42783          	lw	a5,-20(s0)
80001c24:	0007ac23          	sw	zero,24(a5)
            p->trapframe.sp=KSPACE;
80001c28:	fec42783          	lw	a5,-20(s0)
80001c2c:	c0000737          	lui	a4,0xc0000
80001c30:	02e7a023          	sw	a4,32(a5)

            return p;
80001c34:	fec42783          	lw	a5,-20(s0)
80001c38:	0240006f          	j	80001c5c <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
80001c3c:	fec42783          	lw	a5,-20(s0)
80001c40:	11c78793          	addi	a5,a5,284
80001c44:	fef42623          	sw	a5,-20(s0)
80001c48:	fec42703          	lw	a4,-20(s0)
80001c4c:	8000d7b7          	lui	a5,0x8000d
80001c50:	8bc78793          	addi	a5,a5,-1860 # 8000c8bc <memend+0xf800c8bc>
80001c54:	f8f768e3          	bltu	a4,a5,80001be4 <procalloc+0x20>
        }
    }
    return 0;
80001c58:	00000793          	li	a5,0
}
80001c5c:	00078513          	mv	a0,a5
80001c60:	01c12083          	lw	ra,28(sp)
80001c64:	01812403          	lw	s0,24(sp)
80001c68:	02010113          	addi	sp,sp,32
80001c6c:	00008067          	ret

80001c70 <userinit>:

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
80001c70:	fe010113          	addi	sp,sp,-32
80001c74:	00112e23          	sw	ra,28(sp)
80001c78:	00812c23          	sw	s0,24(sp)
80001c7c:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80001c80:	f45ff0ef          	jal	ra,80001bc4 <procalloc>
80001c84:	fea42623          	sw	a0,-20(s0)
    
    char* m=(char*)palloc();
80001c88:	eb4ff0ef          	jal	ra,8000133c <palloc>
80001c8c:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80001c90:	00400613          	li	a2,4
80001c94:	00000693          	li	a3,0
80001c98:	800037b7          	lui	a5,0x80003
80001c9c:	00078593          	mv	a1,a5
80001ca0:	fe842503          	lw	a0,-24(s0)
80001ca4:	0f8000ef          	jal	ra,80001d9c <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X);
80001ca8:	fec42783          	lw	a5,-20(s0)
80001cac:	1147a783          	lw	a5,276(a5) # 80003114 <memend+0xf8003114>
80001cb0:	fe842603          	lw	a2,-24(s0)
80001cb4:	00e00713          	li	a4,14
80001cb8:	000016b7          	lui	a3,0x1
80001cbc:	00000593          	li	a1,0
80001cc0:	00078513          	mv	a0,a5
80001cc4:	9e9ff0ef          	jal	ra,800016ac <vmmap>

    p->context.sp=KSPACE;
80001cc8:	fec42783          	lw	a5,-20(s0)
80001ccc:	c0000737          	lui	a4,0xc0000
80001cd0:	08e7ae23          	sw	a4,156(a5)

    p->status=RUNABLE;
80001cd4:	fec42783          	lw	a5,-20(s0)
80001cd8:	00200713          	li	a4,2
80001cdc:	00e7a223          	sw	a4,4(a5)
}
80001ce0:	00000013          	nop
80001ce4:	01c12083          	lw	ra,28(sp)
80001ce8:	01812403          	lw	s0,24(sp)
80001cec:	02010113          	addi	sp,sp,32
80001cf0:	00008067          	ret

80001cf4 <schedule>:

void schedule(){
80001cf4:	fe010113          	addi	sp,sp,-32
80001cf8:	00812e23          	sw	s0,28(sp)
80001cfc:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
80001d00:	8000c7b7          	lui	a5,0x8000c
80001d04:	44c78793          	addi	a5,a5,1100 # 8000c44c <memend+0xf800c44c>
80001d08:	fef42623          	sw	a5,-20(s0)
80001d0c:	0100006f          	j	80001d1c <schedule+0x28>
80001d10:	fec42783          	lw	a5,-20(s0)
80001d14:	11c78793          	addi	a5,a5,284
80001d18:	fef42623          	sw	a5,-20(s0)
80001d1c:	fec42703          	lw	a4,-20(s0)
80001d20:	8000d7b7          	lui	a5,0x8000d
80001d24:	8bc78793          	addi	a5,a5,-1860 # 8000c8bc <memend+0xf800c8bc>
80001d28:	fef764e3          	bltu	a4,a5,80001d10 <schedule+0x1c>
    for(;;){
80001d2c:	fd5ff06f          	j	80001d00 <schedule+0xc>

80001d30 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80001d30:	fd010113          	addi	sp,sp,-48
80001d34:	02812623          	sw	s0,44(sp)
80001d38:	03010413          	addi	s0,sp,48
80001d3c:	fca42e23          	sw	a0,-36(s0)
80001d40:	fcb42c23          	sw	a1,-40(s0)
80001d44:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
80001d48:	fdc42783          	lw	a5,-36(s0)
80001d4c:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001d50:	fe042623          	sw	zero,-20(s0)
80001d54:	0280006f          	j	80001d7c <memset+0x4c>
        maddr[i] = (char)c;
80001d58:	fe842703          	lw	a4,-24(s0)
80001d5c:	fec42783          	lw	a5,-20(s0)
80001d60:	00f707b3          	add	a5,a4,a5
80001d64:	fd842703          	lw	a4,-40(s0)
80001d68:	0ff77713          	andi	a4,a4,255
80001d6c:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001d70:	fec42783          	lw	a5,-20(s0)
80001d74:	00178793          	addi	a5,a5,1
80001d78:	fef42623          	sw	a5,-20(s0)
80001d7c:	fec42703          	lw	a4,-20(s0)
80001d80:	fd442783          	lw	a5,-44(s0)
80001d84:	fcf76ae3          	bltu	a4,a5,80001d58 <memset+0x28>
    }
    return addr;
80001d88:	fdc42783          	lw	a5,-36(s0)
}
80001d8c:	00078513          	mv	a0,a5
80001d90:	02c12403          	lw	s0,44(sp)
80001d94:	03010113          	addi	sp,sp,48
80001d98:	00008067          	ret

80001d9c <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80001d9c:	fd010113          	addi	sp,sp,-48
80001da0:	02812623          	sw	s0,44(sp)
80001da4:	03010413          	addi	s0,sp,48
80001da8:	fca42e23          	sw	a0,-36(s0)
80001dac:	fcb42c23          	sw	a1,-40(s0)
80001db0:	fcc42823          	sw	a2,-48(s0)
80001db4:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001db8:	fd042783          	lw	a5,-48(s0)
80001dbc:	fd442703          	lw	a4,-44(s0)
80001dc0:	00e7e7b3          	or	a5,a5,a4
80001dc4:	00079663          	bnez	a5,80001dd0 <memmove+0x34>
        return dst;
80001dc8:	fdc42783          	lw	a5,-36(s0)
80001dcc:	1200006f          	j	80001eec <memmove+0x150>
    }

    s = src;
80001dd0:	fd842783          	lw	a5,-40(s0)
80001dd4:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001dd8:	fdc42783          	lw	a5,-36(s0)
80001ddc:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001de0:	fec42703          	lw	a4,-20(s0)
80001de4:	fe842783          	lw	a5,-24(s0)
80001de8:	0cf77263          	bgeu	a4,a5,80001eac <memmove+0x110>
80001dec:	fd042783          	lw	a5,-48(s0)
80001df0:	fec42703          	lw	a4,-20(s0)
80001df4:	00f707b3          	add	a5,a4,a5
80001df8:	fe842703          	lw	a4,-24(s0)
80001dfc:	0af77863          	bgeu	a4,a5,80001eac <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80001e00:	fd042783          	lw	a5,-48(s0)
80001e04:	fec42703          	lw	a4,-20(s0)
80001e08:	00f707b3          	add	a5,a4,a5
80001e0c:	fef42623          	sw	a5,-20(s0)
        d += n;
80001e10:	fd042783          	lw	a5,-48(s0)
80001e14:	fe842703          	lw	a4,-24(s0)
80001e18:	00f707b3          	add	a5,a4,a5
80001e1c:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80001e20:	02c0006f          	j	80001e4c <memmove+0xb0>
            *--d = *--s;
80001e24:	fec42783          	lw	a5,-20(s0)
80001e28:	fff78793          	addi	a5,a5,-1
80001e2c:	fef42623          	sw	a5,-20(s0)
80001e30:	fe842783          	lw	a5,-24(s0)
80001e34:	fff78793          	addi	a5,a5,-1
80001e38:	fef42423          	sw	a5,-24(s0)
80001e3c:	fec42783          	lw	a5,-20(s0)
80001e40:	0007c703          	lbu	a4,0(a5)
80001e44:	fe842783          	lw	a5,-24(s0)
80001e48:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80001e4c:	fd042703          	lw	a4,-48(s0)
80001e50:	fd442783          	lw	a5,-44(s0)
80001e54:	fff00513          	li	a0,-1
80001e58:	fff00593          	li	a1,-1
80001e5c:	00a70633          	add	a2,a4,a0
80001e60:	00060813          	mv	a6,a2
80001e64:	00e83833          	sltu	a6,a6,a4
80001e68:	00b786b3          	add	a3,a5,a1
80001e6c:	00d805b3          	add	a1,a6,a3
80001e70:	00058693          	mv	a3,a1
80001e74:	fcc42823          	sw	a2,-48(s0)
80001e78:	fcd42a23          	sw	a3,-44(s0)
80001e7c:	00070693          	mv	a3,a4
80001e80:	00f6e6b3          	or	a3,a3,a5
80001e84:	fa0690e3          	bnez	a3,80001e24 <memmove+0x88>
    if(s < d && s + n > d){     
80001e88:	0600006f          	j	80001ee8 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80001e8c:	fec42703          	lw	a4,-20(s0)
80001e90:	00170793          	addi	a5,a4,1 # c0000001 <memend+0x38000001>
80001e94:	fef42623          	sw	a5,-20(s0)
80001e98:	fe842783          	lw	a5,-24(s0)
80001e9c:	00178693          	addi	a3,a5,1
80001ea0:	fed42423          	sw	a3,-24(s0)
80001ea4:	00074703          	lbu	a4,0(a4)
80001ea8:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80001eac:	fd042703          	lw	a4,-48(s0)
80001eb0:	fd442783          	lw	a5,-44(s0)
80001eb4:	fff00513          	li	a0,-1
80001eb8:	fff00593          	li	a1,-1
80001ebc:	00a70633          	add	a2,a4,a0
80001ec0:	00060813          	mv	a6,a2
80001ec4:	00e83833          	sltu	a6,a6,a4
80001ec8:	00b786b3          	add	a3,a5,a1
80001ecc:	00d805b3          	add	a1,a6,a3
80001ed0:	00058693          	mv	a3,a1
80001ed4:	fcc42823          	sw	a2,-48(s0)
80001ed8:	fcd42a23          	sw	a3,-44(s0)
80001edc:	00070693          	mv	a3,a4
80001ee0:	00f6e6b3          	or	a3,a3,a5
80001ee4:	fa0694e3          	bnez	a3,80001e8c <memmove+0xf0>
        }
    }
    return dst;
80001ee8:	fdc42783          	lw	a5,-36(s0)
}
80001eec:	00078513          	mv	a0,a5
80001ef0:	02c12403          	lw	s0,44(sp)
80001ef4:	03010113          	addi	sp,sp,48
80001ef8:	00008067          	ret

80001efc <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80001efc:	fd010113          	addi	sp,sp,-48
80001f00:	02812623          	sw	s0,44(sp)
80001f04:	03010413          	addi	s0,sp,48
80001f08:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80001f0c:	00000793          	li	a5,0
80001f10:	00000813          	li	a6,0
80001f14:	fef42423          	sw	a5,-24(s0)
80001f18:	ff042623          	sw	a6,-20(s0)
80001f1c:	0340006f          	j	80001f50 <strlen+0x54>
80001f20:	fe842603          	lw	a2,-24(s0)
80001f24:	fec42683          	lw	a3,-20(s0)
80001f28:	00100513          	li	a0,1
80001f2c:	00000593          	li	a1,0
80001f30:	00a60733          	add	a4,a2,a0
80001f34:	00070813          	mv	a6,a4
80001f38:	00c83833          	sltu	a6,a6,a2
80001f3c:	00b687b3          	add	a5,a3,a1
80001f40:	00f806b3          	add	a3,a6,a5
80001f44:	00068793          	mv	a5,a3
80001f48:	fee42423          	sw	a4,-24(s0)
80001f4c:	fef42623          	sw	a5,-20(s0)
80001f50:	fe842783          	lw	a5,-24(s0)
80001f54:	fdc42703          	lw	a4,-36(s0)
80001f58:	00f707b3          	add	a5,a4,a5
80001f5c:	0007c783          	lbu	a5,0(a5)
80001f60:	fc0790e3          	bnez	a5,80001f20 <strlen+0x24>
    
    return n;
80001f64:	fe842703          	lw	a4,-24(s0)
80001f68:	fec42783          	lw	a5,-20(s0)
80001f6c:	00070513          	mv	a0,a4
80001f70:	00078593          	mv	a1,a5
80001f74:	02c12403          	lw	s0,44(sp)
80001f78:	03010113          	addi	sp,sp,48
80001f7c:	00008067          	ret
