
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
8000000c:	00004117          	auipc	sp,0x4
80000010:	ff810113          	addi	sp,sp,-8 # 80004004 <stacks>
    li t1,sz
80000014:	00001337          	lui	t1,0x1
    mul t1,t1,t0
80000018:	02530333          	mul	t1,t1,t0
    add sp,sp,t1 # 栈指针指向栈顶
8000001c:	00610133          	add	sp,sp,t1
    
    # 跳转到start()
    j start
80000020:	6240006f          	j	80000644 <start>

80000024 <empty>:

empty:
    wfi       # 休眠指令 wait for interrupt 直至收到中断
80000024:	10500073          	wfi
    j empty
80000028:	ffdff06f          	j	80000024 <empty>

8000002c <kvec>:
#include "clint.h"

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
800000ac:	229000ef          	jal	ra,80000ad4 <trapvec>

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
    
    sret
80000130:	10200073          	sret

80000134 <tvec>:

.global tvec
tvec:
    
80000134:	1a1000ef          	jal	ra,80000ad4 <trapvec>

80000138 <swtch>:
// swtch(struct context* old,struct context* new)
// 保存 old,加载 new ; old->a0,new->a1

.global swtch
swtch:
    sw ra,0(a0)
80000138:	00152023          	sw	ra,0(a0)
    sw sp,4(a0)
8000013c:	00252223          	sw	sp,4(a0)
    sw gp,8(a0)
80000140:	00352423          	sw	gp,8(a0)
    sw tp,12(a0)
80000144:	00452623          	sw	tp,12(a0)
    sw a0,16(a0)
80000148:	00a52823          	sw	a0,16(a0)
    sw a1,20(a0)
8000014c:	00b52a23          	sw	a1,20(a0)
    sw a2,24(a0)
80000150:	00c52c23          	sw	a2,24(a0)
    sw a3,28(a0)
80000154:	00d52e23          	sw	a3,28(a0)
    sw a4,32(a0)
80000158:	02e52023          	sw	a4,32(a0)
    sw a5,36(a0)
8000015c:	02f52223          	sw	a5,36(a0)
    sw a6,40(a0)
80000160:	03052423          	sw	a6,40(a0)
    sw a7,44(a0)
80000164:	03152623          	sw	a7,44(a0)
    sw s0,48(a0)
80000168:	02852823          	sw	s0,48(a0)
    sw s1,52(a0)
8000016c:	02952a23          	sw	s1,52(a0)
    sw s2,56(a0)
80000170:	03252c23          	sw	s2,56(a0)
    sw s3,60(a0)
80000174:	03352e23          	sw	s3,60(a0)
    sw s4,64(a0)
80000178:	05452023          	sw	s4,64(a0)
    sw s5,68(a0)
8000017c:	05552223          	sw	s5,68(a0)
    sw s6,72(a0)
80000180:	05652423          	sw	s6,72(a0)
    sw s7,76(a0)
80000184:	05752623          	sw	s7,76(a0)
    sw s8,80(a0)
80000188:	05852823          	sw	s8,80(a0)
    sw s9,84(a0)
8000018c:	05952a23          	sw	s9,84(a0)
    sw s10,88(a0)
80000190:	05a52c23          	sw	s10,88(a0)
    sw s11,92(a0)
80000194:	05b52e23          	sw	s11,92(a0)
    sw t0,96(a0)
80000198:	06552023          	sw	t0,96(a0)
    sw t1,100(a0)
8000019c:	06652223          	sw	t1,100(a0)
    sw t2,104(a0)
800001a0:	06752423          	sw	t2,104(a0)
    sw t3,108(a0)
800001a4:	07c52623          	sw	t3,108(a0)
    sw t4,112(a0)
800001a8:	07d52823          	sw	t4,112(a0)
    sw t5,116(a0)
800001ac:	07e52a23          	sw	t5,116(a0)
    sw t6,120(a0)
800001b0:	07f52c23          	sw	t6,120(a0)


    lw ra,0(a1)
800001b4:	0005a083          	lw	ra,0(a1)
    lw sp,4(a1)
800001b8:	0045a103          	lw	sp,4(a1)
    lw gp,8(a1)
800001bc:	0085a183          	lw	gp,8(a1)
    lw tp,12(a1)
800001c0:	00c5a203          	lw	tp,12(a1)
    lw a0,16(a1)
800001c4:	0105a503          	lw	a0,16(a1)
    // a1
    lw a2,24(a1)
800001c8:	0185a603          	lw	a2,24(a1)
    lw a3,28(a1)
800001cc:	01c5a683          	lw	a3,28(a1)
    lw a4,32(a1)
800001d0:	0205a703          	lw	a4,32(a1)
    lw a5,36(a1)
800001d4:	0245a783          	lw	a5,36(a1)
    lw a6,40(a1)
800001d8:	0285a803          	lw	a6,40(a1)
    lw a7,44(a1)
800001dc:	02c5a883          	lw	a7,44(a1)
    lw s0,48(a1)
800001e0:	0305a403          	lw	s0,48(a1)
    lw s1,52(a1)
800001e4:	0345a483          	lw	s1,52(a1)
    lw s2,56(a1)
800001e8:	0385a903          	lw	s2,56(a1)
    lw s3,60(a1)
800001ec:	03c5a983          	lw	s3,60(a1)
    lw s4,64(a1)
800001f0:	0405aa03          	lw	s4,64(a1)
    lw s5,68(a1)
800001f4:	0445aa83          	lw	s5,68(a1)
    lw s6,72(a1)
800001f8:	0485ab03          	lw	s6,72(a1)
    lw s7,76(a1)
800001fc:	04c5ab83          	lw	s7,76(a1)
    lw s8,80(a1)
80000200:	0505ac03          	lw	s8,80(a1)
    lw s9,84(a1)
80000204:	0545ac83          	lw	s9,84(a1)
    lw s10,88(a1)
80000208:	0585ad03          	lw	s10,88(a1)
    lw s11,92(a1)
8000020c:	05c5ad83          	lw	s11,92(a1)
    lw t0,96(a1)
80000210:	0605a283          	lw	t0,96(a1)
    lw t1,100(a1)
80000214:	0645a303          	lw	t1,100(a1)
    lw t2,104(a1)
80000218:	0685a383          	lw	t2,104(a1)
    lw t3,108(a1)
8000021c:	06c5ae03          	lw	t3,108(a1)
    lw t4,112(a1)
80000220:	0705ae83          	lw	t4,112(a1)
    lw t5,116(a1)
80000224:	0745af03          	lw	t5,116(a1)
    lw t6,120(a1)
80000228:	0785af83          	lw	t6,120(a1)

    lw a1,20(a1)
8000022c:	0145a583          	lw	a1,20(a1)

80000230:	00008067          	ret

80000234 <saveframe>:

// void saveframe(struct trapframe* tf)
.global usertrap
.align 2
saveframe:
    sw ra,16(a0)
80000234:	00152823          	sw	ra,16(a0)
    sw sp,20(a0)
80000238:	00252a23          	sw	sp,20(a0)
    sw gp,24(a0)
8000023c:	00352c23          	sw	gp,24(a0)
    sw tp,28(a0)
80000240:	00452e23          	sw	tp,28(a0)
    sw a0,32(a0)
80000244:	02a52023          	sw	a0,32(a0)
    sw a1,36(a0)
80000248:	02b52223          	sw	a1,36(a0)
    sw a2,40(a0)
8000024c:	02c52423          	sw	a2,40(a0)
    sw a3,44(a0)
80000250:	02d52623          	sw	a3,44(a0)
    sw a4,48(a0)
80000254:	02e52823          	sw	a4,48(a0)
    sw a5,52(a0)
80000258:	02f52a23          	sw	a5,52(a0)
    sw a6,56(a0)
8000025c:	03052c23          	sw	a6,56(a0)
    sw a5,52(a0)
80000260:	02f52a23          	sw	a5,52(a0)
    sw a7,60(a0)
80000264:	03152e23          	sw	a7,60(a0)
    sw s0,64(a0)
80000268:	04852023          	sw	s0,64(a0)
    sw s1,68(a0)
8000026c:	04952223          	sw	s1,68(a0)
    sw s2,72(a0)
80000270:	05252423          	sw	s2,72(a0)
    sw s3,76(a0)
80000274:	05352623          	sw	s3,76(a0)
    sw s4,80(a0)
80000278:	05452823          	sw	s4,80(a0)
    sw s5,84(a0)
8000027c:	05552a23          	sw	s5,84(a0)
    sw s6,88(a0)
80000280:	05652c23          	sw	s6,88(a0)
    sw s7,92(a0)
80000284:	05752e23          	sw	s7,92(a0)
    sw s8,96(a0)
80000288:	07852023          	sw	s8,96(a0)
    sw s9,100(a0)
8000028c:	07952223          	sw	s9,100(a0)
    sw s10,104(a0)
80000290:	07a52423          	sw	s10,104(a0)
    sw s11,108(a0)
80000294:	07b52623          	sw	s11,108(a0)
    sw t0,112(a0)
80000298:	06552823          	sw	t0,112(a0)
    sw t1,116(a0)
8000029c:	06652a23          	sw	t1,116(a0)
    sw t2,120(a0)
800002a0:	06752c23          	sw	t2,120(a0)
    sw t3,124(a0)
800002a4:	07c52e23          	sw	t3,124(a0)
    sw t4,128(a0)
800002a8:	09d52023          	sw	t4,128(a0)
    sw t5,132(a0)
800002ac:	09e52223          	sw	t5,132(a0)
    sw t6,136(a0)
800002b0:	09f52423          	sw	t6,136(a0)

    ret
800002b4:	00008067          	ret

800002b8 <loadframe>:

.global loadframe
.align 2
loadframe:
    lw t6,0(a0)
800002b8:	00052f83          	lw	t6,0(a0)
    csrw satp,t6
800002bc:	180f9073          	csrw	satp,t6
    sfence.vma zero, zero
800002c0:	12000073          	sfence.vma

    lw ra,16(a0)
800002c4:	01052083          	lw	ra,16(a0)
    lw sp,20(a0)
800002c8:	01452103          	lw	sp,20(a0)
    lw gp,24(a0)
800002cc:	01852183          	lw	gp,24(a0)
    lw tp,28(a0)
800002d0:	01c52203          	lw	tp,28(a0)

    lw a1,36(a0)
800002d4:	02452583          	lw	a1,36(a0)
    lw a2,40(a0)
800002d8:	02852603          	lw	a2,40(a0)
    lw a3,44(a0)
800002dc:	02c52683          	lw	a3,44(a0)
    lw a4,48(a0)
800002e0:	03052703          	lw	a4,48(a0)
    lw a5,52(a0)
800002e4:	03452783          	lw	a5,52(a0)
    lw a6,56(a0)
800002e8:	03852803          	lw	a6,56(a0)
    lw a5,52(a0)
800002ec:	03452783          	lw	a5,52(a0)
    lw a7,60(a0)
800002f0:	03c52883          	lw	a7,60(a0)
    lw s0,64(a0)
800002f4:	04052403          	lw	s0,64(a0)
    lw s1,68(a0)
800002f8:	04452483          	lw	s1,68(a0)
    lw s2,72(a0)
800002fc:	04852903          	lw	s2,72(a0)
    lw s3,76(a0)
80000300:	04c52983          	lw	s3,76(a0)
    lw s4,80(a0)
80000304:	05052a03          	lw	s4,80(a0)
    lw s5,84(a0)
80000308:	05452a83          	lw	s5,84(a0)
    lw s6,88(a0)
8000030c:	05852b03          	lw	s6,88(a0)
    lw s7,92(a0)
80000310:	05c52b83          	lw	s7,92(a0)
    lw s8,96(a0)
80000314:	06052c03          	lw	s8,96(a0)
    lw s9,100(a0)
80000318:	06452c83          	lw	s9,100(a0)
    lw s10,104(a0)
8000031c:	06852d03          	lw	s10,104(a0)
    lw s11,108(a0)
80000320:	06c52d83          	lw	s11,108(a0)
    lw t0,112(a0)
80000324:	07052283          	lw	t0,112(a0)
    lw t1,116(a0)
80000328:	07452303          	lw	t1,116(a0)
    lw t2,120(a0)
8000032c:	07852383          	lw	t2,120(a0)
    lw t3,124(a0)
80000330:	07c52e03          	lw	t3,124(a0)
    lw t4,128(a0)
80000334:	08052e83          	lw	t4,128(a0)
    lw t5,132(a0)
80000338:	08452f03          	lw	t5,132(a0)
    lw t6,136(a0)
8000033c:	08852f83          	lw	t6,136(a0)

    lw a0,32(a0)
80000340:	02052503          	lw	a0,32(a0)

80000344:	10200073          	sret

80000348 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80000348:	fe010113          	addi	sp,sp,-32
8000034c:	00812e23          	sw	s0,28(sp)
80000350:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80000354:	300027f3          	csrr	a5,mstatus
80000358:	fef42623          	sw	a5,-20(s0)
    return x;
8000035c:	fec42783          	lw	a5,-20(s0)
}
80000360:	00078513          	mv	a0,a5
80000364:	01c12403          	lw	s0,28(sp)
80000368:	02010113          	addi	sp,sp,32
8000036c:	00008067          	ret

80000370 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
80000370:	fe010113          	addi	sp,sp,-32
80000374:	00812e23          	sw	s0,28(sp)
80000378:	02010413          	addi	s0,sp,32
8000037c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80000380:	fec42783          	lw	a5,-20(s0)
80000384:	30079073          	csrw	mstatus,a5
}
80000388:	00000013          	nop
8000038c:	01c12403          	lw	s0,28(sp)
80000390:	02010113          	addi	sp,sp,32
80000394:	00008067          	ret

80000398 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000398:	fd010113          	addi	sp,sp,-48
8000039c:	02112623          	sw	ra,44(sp)
800003a0:	02812423          	sw	s0,40(sp)
800003a4:	03010413          	addi	s0,sp,48
800003a8:	00050793          	mv	a5,a0
800003ac:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
800003b0:	f99ff0ef          	jal	ra,80000348 <r_mstatus>
800003b4:	fea42623          	sw	a0,-20(s0)
    switch (m)
800003b8:	fdf44783          	lbu	a5,-33(s0)
800003bc:	00300713          	li	a4,3
800003c0:	06e78063          	beq	a5,a4,80000420 <s_mstatus_xpp+0x88>
800003c4:	00300713          	li	a4,3
800003c8:	08f74263          	blt	a4,a5,8000044c <s_mstatus_xpp+0xb4>
800003cc:	00078863          	beqz	a5,800003dc <s_mstatus_xpp+0x44>
800003d0:	00100713          	li	a4,1
800003d4:	02e78063          	beq	a5,a4,800003f4 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800003d8:	0740006f          	j	8000044c <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800003dc:	fec42703          	lw	a4,-20(s0)
800003e0:	ffffe7b7          	lui	a5,0xffffe
800003e4:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800003e8:	00f777b3          	and	a5,a4,a5
800003ec:	fef42623          	sw	a5,-20(s0)
        break;
800003f0:	0600006f          	j	80000450 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800003f4:	fec42703          	lw	a4,-20(s0)
800003f8:	ffffe7b7          	lui	a5,0xffffe
800003fc:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000400:	00f777b3          	and	a5,a4,a5
80000404:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
80000408:	fec42703          	lw	a4,-20(s0)
8000040c:	000017b7          	lui	a5,0x1
80000410:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
80000414:	00f767b3          	or	a5,a4,a5
80000418:	fef42623          	sw	a5,-20(s0)
        break;
8000041c:	0340006f          	j	80000450 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80000420:	fec42703          	lw	a4,-20(s0)
80000424:	ffffe7b7          	lui	a5,0xffffe
80000428:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
8000042c:	00f777b3          	and	a5,a4,a5
80000430:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
80000434:	fec42703          	lw	a4,-20(s0)
80000438:	000027b7          	lui	a5,0x2
8000043c:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
80000440:	00f767b3          	or	a5,a4,a5
80000444:	fef42623          	sw	a5,-20(s0)
        break;
80000448:	0080006f          	j	80000450 <s_mstatus_xpp+0xb8>
        break;
8000044c:	00000013          	nop
    }
    w_mstatus(x);
80000450:	fec42503          	lw	a0,-20(s0)
80000454:	f1dff0ef          	jal	ra,80000370 <w_mstatus>
}
80000458:	00000013          	nop
8000045c:	02c12083          	lw	ra,44(sp)
80000460:	02812403          	lw	s0,40(sp)
80000464:	03010113          	addi	sp,sp,48
80000468:	00008067          	ret

8000046c <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
8000046c:	fe010113          	addi	sp,sp,-32
80000470:	00812e23          	sw	s0,28(sp)
80000474:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000478:	100027f3          	csrr	a5,sstatus
8000047c:	fef42623          	sw	a5,-20(s0)
    return x;
80000480:	fec42783          	lw	a5,-20(s0)
}
80000484:	00078513          	mv	a0,a5
80000488:	01c12403          	lw	s0,28(sp)
8000048c:	02010113          	addi	sp,sp,32
80000490:	00008067          	ret

80000494 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
80000494:	fe010113          	addi	sp,sp,-32
80000498:	00812e23          	sw	s0,28(sp)
8000049c:	02010413          	addi	s0,sp,32
800004a0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
800004a4:	fec42783          	lw	a5,-20(s0)
800004a8:	10079073          	csrw	sstatus,a5
}
800004ac:	00000013          	nop
800004b0:	01c12403          	lw	s0,28(sp)
800004b4:	02010113          	addi	sp,sp,32
800004b8:	00008067          	ret

800004bc <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
800004bc:	fe010113          	addi	sp,sp,-32
800004c0:	00812e23          	sw	s0,28(sp)
800004c4:	02010413          	addi	s0,sp,32
800004c8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
800004cc:	fec42783          	lw	a5,-20(s0)
800004d0:	34179073          	csrw	mepc,a5
}
800004d4:	00000013          	nop
800004d8:	01c12403          	lw	s0,28(sp)
800004dc:	02010113          	addi	sp,sp,32
800004e0:	00008067          	ret

800004e4 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
800004e4:	fe010113          	addi	sp,sp,-32
800004e8:	00812e23          	sw	s0,28(sp)
800004ec:	02010413          	addi	s0,sp,32
800004f0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
800004f4:	fec42783          	lw	a5,-20(s0)
800004f8:	10579073          	csrw	stvec,a5
}
800004fc:	00000013          	nop
80000500:	01c12403          	lw	s0,28(sp)
80000504:	02010113          	addi	sp,sp,32
80000508:	00008067          	ret

8000050c <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
8000050c:	fe010113          	addi	sp,sp,-32
80000510:	00812e23          	sw	s0,28(sp)
80000514:	02010413          	addi	s0,sp,32
80000518:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
8000051c:	fec42783          	lw	a5,-20(s0)
80000520:	30379073          	csrw	mideleg,a5
}
80000524:	00000013          	nop
80000528:	01c12403          	lw	s0,28(sp)
8000052c:	02010113          	addi	sp,sp,32
80000530:	00008067          	ret

80000534 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
80000534:	fe010113          	addi	sp,sp,-32
80000538:	00812e23          	sw	s0,28(sp)
8000053c:	02010413          	addi	s0,sp,32
80000540:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
80000544:	fec42783          	lw	a5,-20(s0)
80000548:	30279073          	csrw	medeleg,a5
}
8000054c:	00000013          	nop
80000550:	01c12403          	lw	s0,28(sp)
80000554:	02010113          	addi	sp,sp,32
80000558:	00008067          	ret

8000055c <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
8000055c:	fe010113          	addi	sp,sp,-32
80000560:	00812e23          	sw	s0,28(sp)
80000564:	02010413          	addi	s0,sp,32
80000568:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
8000056c:	fec42783          	lw	a5,-20(s0)
80000570:	18079073          	csrw	satp,a5
}
80000574:	00000013          	nop
80000578:	01c12403          	lw	s0,28(sp)
8000057c:	02010113          	addi	sp,sp,32
80000580:	00008067          	ret

80000584 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
80000584:	fd010113          	addi	sp,sp,-48
80000588:	02112623          	sw	ra,44(sp)
8000058c:	02812423          	sw	s0,40(sp)
80000590:	03010413          	addi	s0,sp,48
80000594:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
80000598:	ed5ff0ef          	jal	ra,8000046c <r_sstatus>
8000059c:	fea42623          	sw	a0,-20(s0)
    switch (m)
800005a0:	fdc42703          	lw	a4,-36(s0)
800005a4:	ffd00793          	li	a5,-3
800005a8:	06f70863          	beq	a4,a5,80000618 <s_sstatus_intr+0x94>
800005ac:	fdc42703          	lw	a4,-36(s0)
800005b0:	ffd00793          	li	a5,-3
800005b4:	06e7e863          	bltu	a5,a4,80000624 <s_sstatus_intr+0xa0>
800005b8:	fdc42703          	lw	a4,-36(s0)
800005bc:	fdf00793          	li	a5,-33
800005c0:	02f70c63          	beq	a4,a5,800005f8 <s_sstatus_intr+0x74>
800005c4:	fdc42703          	lw	a4,-36(s0)
800005c8:	fdf00793          	li	a5,-33
800005cc:	04e7ec63          	bltu	a5,a4,80000624 <s_sstatus_intr+0xa0>
800005d0:	fdc42703          	lw	a4,-36(s0)
800005d4:	00200793          	li	a5,2
800005d8:	02f70863          	beq	a4,a5,80000608 <s_sstatus_intr+0x84>
800005dc:	fdc42703          	lw	a4,-36(s0)
800005e0:	02000793          	li	a5,32
800005e4:	04f71063          	bne	a4,a5,80000624 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
800005e8:	fec42783          	lw	a5,-20(s0)
800005ec:	0207e793          	ori	a5,a5,32
800005f0:	fef42623          	sw	a5,-20(s0)
        break;
800005f4:	0340006f          	j	80000628 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
800005f8:	fec42783          	lw	a5,-20(s0)
800005fc:	fdf7f793          	andi	a5,a5,-33
80000600:	fef42623          	sw	a5,-20(s0)
        break;
80000604:	0240006f          	j	80000628 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
80000608:	fec42783          	lw	a5,-20(s0)
8000060c:	0027e793          	ori	a5,a5,2
80000610:	fef42623          	sw	a5,-20(s0)
        break;
80000614:	0140006f          	j	80000628 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
80000618:	fec42783          	lw	a5,-20(s0)
8000061c:	0027f793          	andi	a5,a5,2
80000620:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
80000624:	00000013          	nop
    }
    w_sstatus(x);
80000628:	fec42503          	lw	a0,-20(s0)
8000062c:	e69ff0ef          	jal	ra,80000494 <w_sstatus>
}
80000630:	00000013          	nop
80000634:	02c12083          	lw	ra,44(sp)
80000638:	02812403          	lw	s0,40(sp)
8000063c:	03010113          	addi	sp,sp,48
80000640:	00008067          	ret

80000644 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();     // 定义在main.c

void start(){
80000644:	ff010113          	addi	sp,sp,-16
80000648:	00112623          	sw	ra,12(sp)
8000064c:	00812423          	sw	s0,8(sp)
80000650:	01010413          	addi	s0,sp,16
    uartinit();
80000654:	07c000ef          	jal	ra,800006d0 <uartinit>
    uartputs("Hello Los!\n");
80000658:	800037b7          	lui	a5,0x80003
8000065c:	00078513          	mv	a0,a5
80000660:	164000ef          	jal	ra,800007c4 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
80000664:	00100513          	li	a0,1
80000668:	d31ff0ef          	jal	ra,80000398 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
8000066c:	00000513          	li	a0,0
80000670:	eedff0ef          	jal	ra,8000055c <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
80000674:	000107b7          	lui	a5,0x10
80000678:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
8000067c:	e91ff0ef          	jal	ra,8000050c <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80000680:	000107b7          	lui	a5,0x10
80000684:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000688:	eadff0ef          	jal	ra,80000534 <w_medeleg>

    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
8000068c:	00200513          	li	a0,2
80000690:	ef5ff0ef          	jal	ra,80000584 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
80000694:	800007b7          	lui	a5,0x80000
80000698:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
8000069c:	00078513          	mv	a0,a5
800006a0:	e45ff0ef          	jal	ra,800004e4 <w_stvec>

    timerinit();                // 时钟定时器
800006a4:	281010ef          	jal	ra,80002124 <timerinit>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
800006a8:	800017b7          	lui	a5,0x80001
800006ac:	90078793          	addi	a5,a5,-1792 # 80000900 <memend+0xf8000900>
800006b0:	00078513          	mv	a0,a5
800006b4:	e09ff0ef          	jal	ra,800004bc <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
800006b8:	30200073          	mret
800006bc:	00000013          	nop
800006c0:	00c12083          	lw	ra,12(sp)
800006c4:	00812403          	lw	s0,8(sp)
800006c8:	01010113          	addi	sp,sp,16
800006cc:	00008067          	ret

800006d0 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
800006d0:	fe010113          	addi	sp,sp,-32
800006d4:	00812e23          	sw	s0,28(sp)
800006d8:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800006dc:	100007b7          	lui	a5,0x10000
800006e0:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800006e4:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800006e8:	100007b7          	lui	a5,0x10000
800006ec:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006f0:	0007c783          	lbu	a5,0(a5)
800006f4:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800006f8:	100007b7          	lui	a5,0x10000
800006fc:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000700:	fef44703          	lbu	a4,-17(s0)
80000704:	f8076713          	ori	a4,a4,-128
80000708:	0ff77713          	andi	a4,a4,255
8000070c:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
80000710:	100007b7          	lui	a5,0x10000
80000714:	00300713          	li	a4,3
80000718:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
8000071c:	100007b7          	lui	a5,0x10000
80000720:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000724:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
80000728:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
8000072c:	100007b7          	lui	a5,0x10000
80000730:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000734:	fef44703          	lbu	a4,-17(s0)
80000738:	00376713          	ori	a4,a4,3
8000073c:	0ff77713          	andi	a4,a4,255
80000740:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
80000744:	100007b7          	lui	a5,0x10000
80000748:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
8000074c:	0007c783          	lbu	a5,0(a5)
80000750:	0ff7f713          	andi	a4,a5,255
80000754:	100007b7          	lui	a5,0x10000
80000758:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
8000075c:	00176713          	ori	a4,a4,1
80000760:	0ff77713          	andi	a4,a4,255
80000764:	00e78023          	sb	a4,0(a5)
}
80000768:	00000013          	nop
8000076c:	01c12403          	lw	s0,28(sp)
80000770:	02010113          	addi	sp,sp,32
80000774:	00008067          	ret

80000778 <uartputc>:

// 轮询处理数据
char uartputc(char c){
80000778:	fe010113          	addi	sp,sp,-32
8000077c:	00812e23          	sw	s0,28(sp)
80000780:	02010413          	addi	s0,sp,32
80000784:	00050793          	mv	a5,a0
80000788:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
8000078c:	00000013          	nop
80000790:	100007b7          	lui	a5,0x10000
80000794:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000798:	0007c783          	lbu	a5,0(a5)
8000079c:	0ff7f793          	andi	a5,a5,255
800007a0:	0207f793          	andi	a5,a5,32
800007a4:	fe0786e3          	beqz	a5,80000790 <uartputc+0x18>
    return uart_write(UART_THR,c);
800007a8:	10000737          	lui	a4,0x10000
800007ac:	fef44783          	lbu	a5,-17(s0)
800007b0:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
800007b4:	00078513          	mv	a0,a5
800007b8:	01c12403          	lw	s0,28(sp)
800007bc:	02010113          	addi	sp,sp,32
800007c0:	00008067          	ret

800007c4 <uartputs>:

// 发送字符串
void uartputs(char* s){
800007c4:	fe010113          	addi	sp,sp,-32
800007c8:	00112e23          	sw	ra,28(sp)
800007cc:	00812c23          	sw	s0,24(sp)
800007d0:	02010413          	addi	s0,sp,32
800007d4:	fea42623          	sw	a0,-20(s0)
    while (*s)
800007d8:	01c0006f          	j	800007f4 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
800007dc:	fec42783          	lw	a5,-20(s0)
800007e0:	00178713          	addi	a4,a5,1
800007e4:	fee42623          	sw	a4,-20(s0)
800007e8:	0007c783          	lbu	a5,0(a5)
800007ec:	00078513          	mv	a0,a5
800007f0:	f89ff0ef          	jal	ra,80000778 <uartputc>
    while (*s)
800007f4:	fec42783          	lw	a5,-20(s0)
800007f8:	0007c783          	lbu	a5,0(a5)
800007fc:	fe0790e3          	bnez	a5,800007dc <uartputs+0x18>
    }
    
}
80000800:	00000013          	nop
80000804:	00000013          	nop
80000808:	01c12083          	lw	ra,28(sp)
8000080c:	01812403          	lw	s0,24(sp)
80000810:	02010113          	addi	sp,sp,32
80000814:	00008067          	ret

80000818 <uartgetc>:

// 接收输入
int uartgetc(){
80000818:	ff010113          	addi	sp,sp,-16
8000081c:	00812623          	sw	s0,12(sp)
80000820:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
80000824:	100007b7          	lui	a5,0x10000
80000828:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
8000082c:	0007c783          	lbu	a5,0(a5)
80000830:	0ff7f793          	andi	a5,a5,255
80000834:	0017f793          	andi	a5,a5,1
80000838:	00078a63          	beqz	a5,8000084c <uartgetc+0x34>
        return uart_read(UART_RHR);
8000083c:	100007b7          	lui	a5,0x10000
80000840:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
80000844:	0ff7f793          	andi	a5,a5,255
80000848:	0080006f          	j	80000850 <uartgetc+0x38>
    }else{
        return -1;
8000084c:	fff00793          	li	a5,-1
    }
}
80000850:	00078513          	mv	a0,a5
80000854:	00c12403          	lw	s0,12(sp)
80000858:	01010113          	addi	sp,sp,16
8000085c:	00008067          	ret

80000860 <uartintr>:

// 键盘输入中断
char uartintr(){
80000860:	ff010113          	addi	sp,sp,-16
80000864:	00112623          	sw	ra,12(sp)
80000868:	00812423          	sw	s0,8(sp)
8000086c:	01010413          	addi	s0,sp,16
    return uartgetc();
80000870:	fa9ff0ef          	jal	ra,80000818 <uartgetc>
80000874:	00050793          	mv	a5,a0
80000878:	0ff7f793          	andi	a5,a5,255
8000087c:	00078513          	mv	a0,a5
80000880:	00c12083          	lw	ra,12(sp)
80000884:	00812403          	lw	s0,8(sp)
80000888:	01010113          	addi	sp,sp,16
8000088c:	00008067          	ret

80000890 <task>:
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"
void task(){
80000890:	fe010113          	addi	sp,sp,-32
80000894:	00112e23          	sw	ra,28(sp)
80000898:	00812c23          	sw	s0,24(sp)
8000089c:	02010413          	addi	s0,sp,32
    int  j=5;
800008a0:	00500793          	li	a5,5
800008a4:	fef42623          	sw	a5,-20(s0)
    while(j--){
800008a8:	0300006f          	j	800008d8 <task+0x48>
        int i=100000000;
800008ac:	05f5e7b7          	lui	a5,0x5f5e
800008b0:	10078793          	addi	a5,a5,256 # 5f5e100 <sz+0x5f5d100>
800008b4:	fef42423          	sw	a5,-24(s0)
        while(i--);
800008b8:	00000013          	nop
800008bc:	fe842783          	lw	a5,-24(s0)
800008c0:	fff78713          	addi	a4,a5,-1
800008c4:	fee42423          	sw	a4,-24(s0)
800008c8:	fe079ae3          	bnez	a5,800008bc <task+0x2c>
        printf("tesk\n");
800008cc:	800037b7          	lui	a5,0x80003
800008d0:	00c78513          	addi	a0,a5,12 # 8000300c <memend+0xf800300c>
800008d4:	42c000ef          	jal	ra,80000d00 <printf>
    while(j--){
800008d8:	fec42783          	lw	a5,-20(s0)
800008dc:	fff78713          	addi	a4,a5,-1
800008e0:	fee42623          	sw	a4,-20(s0)
800008e4:	fc0794e3          	bnez	a5,800008ac <task+0x1c>
    }
}
800008e8:	00000013          	nop
800008ec:	00000013          	nop
800008f0:	01c12083          	lw	ra,28(sp)
800008f4:	01812403          	lw	s0,24(sp)
800008f8:	02010113          	addi	sp,sp,32
800008fc:	00008067          	ret

80000900 <main>:
void main(){
80000900:	ff010113          	addi	sp,sp,-16
80000904:	00112623          	sw	ra,12(sp)
80000908:	00812423          	sw	s0,8(sp)
8000090c:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
80000910:	800037b7          	lui	a5,0x80003
80000914:	01478513          	addi	a0,a5,20 # 80003014 <memend+0xf8003014>
80000918:	3e8000ef          	jal	ra,80000d00 <printf>

    minit();        // 物理内存管理
8000091c:	7f0000ef          	jal	ra,8000110c <minit>
    plicinit();     // PLIC 中断处理
80000920:	18d000ef          	jal	ra,800012ac <plicinit>
    
    kvminit();       // 启动虚拟内存
80000924:	641000ef          	jal	ra,80001764 <kvminit>
    // new.sp=r_sp();
    // // swtch(&old,&new);

    // userinit();
    // asm volatile("ecall");
    printf("----------------------\n");
80000928:	800037b7          	lui	a5,0x80003
8000092c:	02878513          	addi	a0,a5,40 # 80003028 <memend+0xf8003028>
80000930:	3d0000ef          	jal	ra,80000d00 <printf>
    while(1);
80000934:	0000006f          	j	80000934 <main+0x34>

80000938 <r_sepc>:

/**
 * @description: 读取 sepc 寄存器
 * S-mode 返回时跳转到 pc = sepc指向的地址
 */
static inline uint32 r_sepc(){
80000938:	fe010113          	addi	sp,sp,-32
8000093c:	00812e23          	sw	s0,28(sp)
80000940:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sepc" : "=r" (x) );
80000944:	141027f3          	csrr	a5,sepc
80000948:	fef42623          	sw	a5,-20(s0)
    return x;
8000094c:	fec42783          	lw	a5,-20(s0)
}
80000950:	00078513          	mv	a0,a5
80000954:	01c12403          	lw	s0,28(sp)
80000958:	02010113          	addi	sp,sp,32
8000095c:	00008067          	ret

80000960 <w_sepc>:
// 写 sepc寄存器
static inline void w_sepc(uint32 x){
80000960:	fe010113          	addi	sp,sp,-32
80000964:	00812e23          	sw	s0,28(sp)
80000968:	02010413          	addi	s0,sp,32
8000096c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
80000970:	fec42783          	lw	a5,-20(s0)
80000974:	14179073          	csrw	sepc,a5
}
80000978:	00000013          	nop
8000097c:	01c12403          	lw	s0,28(sp)
80000980:	02010113          	addi	sp,sp,32
80000984:	00008067          	ret

80000988 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
80000988:	fe010113          	addi	sp,sp,-32
8000098c:	00812e23          	sw	s0,28(sp)
80000990:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
80000994:	142027f3          	csrr	a5,scause
80000998:	fef42623          	sw	a5,-20(s0)
    return x;
8000099c:	fec42783          	lw	a5,-20(s0)
}
800009a0:	00078513          	mv	a0,a5
800009a4:	01c12403          	lw	s0,28(sp)
800009a8:	02010113          	addi	sp,sp,32
800009ac:	00008067          	ret

800009b0 <externinterrupt>:
#include "proc.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
800009b0:	fe010113          	addi	sp,sp,-32
800009b4:	00112e23          	sw	ra,28(sp)
800009b8:	00812c23          	sw	s0,24(sp)
800009bc:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
800009c0:	1b1000ef          	jal	ra,80001370 <r_plicclaim>
800009c4:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
800009c8:	fec42583          	lw	a1,-20(s0)
800009cc:	800037b7          	lui	a5,0x80003
800009d0:	04078513          	addi	a0,a5,64 # 80003040 <memend+0xf8003040>
800009d4:	32c000ef          	jal	ra,80000d00 <printf>
    switch (irq)
800009d8:	fec42703          	lw	a4,-20(s0)
800009dc:	00a00793          	li	a5,10
800009e0:	02f71063          	bne	a4,a5,80000a00 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
800009e4:	e7dff0ef          	jal	ra,80000860 <uartintr>
800009e8:	00050793          	mv	a5,a0
800009ec:	00078593          	mv	a1,a5
800009f0:	800037b7          	lui	a5,0x80003
800009f4:	04c78513          	addi	a0,a5,76 # 8000304c <memend+0xf800304c>
800009f8:	308000ef          	jal	ra,80000d00 <printf>
        break;
800009fc:	0080006f          	j	80000a04 <externinterrupt+0x54>
    default:
        break;
80000a00:	00000013          	nop
    }
    w_pliccomplete(irq);
80000a04:	fec42503          	lw	a0,-20(s0)
80000a08:	1a9000ef          	jal	ra,800013b0 <w_pliccomplete>
}
80000a0c:	00000013          	nop
80000a10:	01c12083          	lw	ra,28(sp)
80000a14:	01812403          	lw	s0,24(sp)
80000a18:	02010113          	addi	sp,sp,32
80000a1c:	00008067          	ret

80000a20 <usertrapret>:

// 返回用户空间
void usertrapret(){
80000a20:	fe010113          	addi	sp,sp,-32
80000a24:	00112e23          	sw	ra,28(sp)
80000a28:	00812c23          	sw	s0,24(sp)
80000a2c:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80000a30:	7f9000ef          	jal	ra,80001a28 <nowproc>
80000a34:	fea42623          	sw	a0,-20(s0)
    loadframe(&p->trapframe);
80000a38:	fec42783          	lw	a5,-20(s0)
80000a3c:	00878793          	addi	a5,a5,8
80000a40:	00078513          	mv	a0,a5
80000a44:	875ff0ef          	jal	ra,800002b8 <loadframe>
}
80000a48:	00000013          	nop
80000a4c:	01c12083          	lw	ra,28(sp)
80000a50:	01812403          	lw	s0,24(sp)
80000a54:	02010113          	addi	sp,sp,32
80000a58:	00008067          	ret

80000a5c <zero>:

void zero(){
80000a5c:	fe010113          	addi	sp,sp,-32
80000a60:	00112e23          	sw	ra,28(sp)
80000a64:	00812c23          	sw	s0,24(sp)
80000a68:	02010413          	addi	s0,sp,32
    printf("zero\n");
80000a6c:	800037b7          	lui	a5,0x80003
80000a70:	05c78513          	addi	a0,a5,92 # 8000305c <memend+0xf800305c>
80000a74:	28c000ef          	jal	ra,80000d00 <printf>
    reg_t pc=r_sepc();
80000a78:	ec1ff0ef          	jal	ra,80000938 <r_sepc>
80000a7c:	fea42423          	sw	a0,-24(s0)
    w_sepc(pc+4);
80000a80:	fe842783          	lw	a5,-24(s0)
80000a84:	00478793          	addi	a5,a5,4
80000a88:	00078513          	mv	a0,a5
80000a8c:	ed5ff0ef          	jal	ra,80000960 <w_sepc>
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80000a90:	8000d7b7          	lui	a5,0x8000d
80000a94:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80000a98:	fef42623          	sw	a5,-20(s0)
80000a9c:	0100006f          	j	80000aac <zero+0x50>
80000aa0:	fec42783          	lw	a5,-20(s0)
80000aa4:	11878793          	addi	a5,a5,280
80000aa8:	fef42623          	sw	a5,-20(s0)
80000aac:	fec42703          	lw	a4,-20(s0)
80000ab0:	8000e7b7          	lui	a5,0x8000e
80000ab4:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80000ab8:	fef764e3          	bltu	a4,a5,80000aa0 <zero+0x44>
        if(p->status==RUNABLE){
            
        }
    }
    usertrapret();
80000abc:	f65ff0ef          	jal	ra,80000a20 <usertrapret>
}
80000ac0:	00000013          	nop
80000ac4:	01c12083          	lw	ra,28(sp)
80000ac8:	01812403          	lw	s0,24(sp)
80000acc:	02010113          	addi	sp,sp,32
80000ad0:	00008067          	ret

80000ad4 <trapvec>:

void trapvec(){
80000ad4:	fe010113          	addi	sp,sp,-32
80000ad8:	00112e23          	sw	ra,28(sp)
80000adc:	00812c23          	sw	s0,24(sp)
80000ae0:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000ae4:	ea5ff0ef          	jal	ra,80000988 <r_scause>
80000ae8:	fea42423          	sw	a0,-24(s0)

    uint16 code= scause & 0xffff;
80000aec:	fe842783          	lw	a5,-24(s0)
80000af0:	fef41323          	sh	a5,-26(s0)

    if(scause & (1<<31)){
80000af4:	fe842783          	lw	a5,-24(s0)
80000af8:	0607de63          	bgez	a5,80000b74 <trapvec+0xa0>
        printf("Interrupt : ");
80000afc:	800037b7          	lui	a5,0x80003
80000b00:	06478513          	addi	a0,a5,100 # 80003064 <memend+0xf8003064>
80000b04:	1fc000ef          	jal	ra,80000d00 <printf>
        switch (code)
80000b08:	fe645783          	lhu	a5,-26(s0)
80000b0c:	00900713          	li	a4,9
80000b10:	04e78063          	beq	a5,a4,80000b50 <trapvec+0x7c>
80000b14:	00900713          	li	a4,9
80000b18:	04f74663          	blt	a4,a5,80000b64 <trapvec+0x90>
80000b1c:	00100713          	li	a4,1
80000b20:	00e78863          	beq	a5,a4,80000b30 <trapvec+0x5c>
80000b24:	00500713          	li	a4,5
80000b28:	00e78c63          	beq	a5,a4,80000b40 <trapvec+0x6c>
80000b2c:	0380006f          	j	80000b64 <trapvec+0x90>
        {
        case 1:
            printf("Supervisor software interrupt\n");
80000b30:	800037b7          	lui	a5,0x80003
80000b34:	07478513          	addi	a0,a5,116 # 80003074 <memend+0xf8003074>
80000b38:	1c8000ef          	jal	ra,80000d00 <printf>
            break;
80000b3c:	1780006f          	j	80000cb4 <trapvec+0x1e0>
        case 5:
            printf("Supervisor timer interrupt\n");
80000b40:	800037b7          	lui	a5,0x80003
80000b44:	09478513          	addi	a0,a5,148 # 80003094 <memend+0xf8003094>
80000b48:	1b8000ef          	jal	ra,80000d00 <printf>
            break;
80000b4c:	1680006f          	j	80000cb4 <trapvec+0x1e0>
        case 9:
            printf("Supervisor external interrupt\n");
80000b50:	800037b7          	lui	a5,0x80003
80000b54:	0b078513          	addi	a0,a5,176 # 800030b0 <memend+0xf80030b0>
80000b58:	1a8000ef          	jal	ra,80000d00 <printf>
            externinterrupt();
80000b5c:	e55ff0ef          	jal	ra,800009b0 <externinterrupt>
            break;
80000b60:	1540006f          	j	80000cb4 <trapvec+0x1e0>
        default:
            printf("Other interrupt\n");
80000b64:	800037b7          	lui	a5,0x80003
80000b68:	0d078513          	addi	a0,a5,208 # 800030d0 <memend+0xf80030d0>
80000b6c:	194000ef          	jal	ra,80000d00 <printf>
            break;
80000b70:	1440006f          	j	80000cb4 <trapvec+0x1e0>
        }
    }else{
        int ecall=0;
80000b74:	fe042623          	sw	zero,-20(s0)
        printf("Exception : ");
80000b78:	800037b7          	lui	a5,0x80003
80000b7c:	0e478513          	addi	a0,a5,228 # 800030e4 <memend+0xf80030e4>
80000b80:	180000ef          	jal	ra,80000d00 <printf>
        switch (code)
80000b84:	fe645783          	lhu	a5,-26(s0)
80000b88:	00f00713          	li	a4,15
80000b8c:	0ef76c63          	bltu	a4,a5,80000c84 <trapvec+0x1b0>
80000b90:	00279713          	slli	a4,a5,0x2
80000b94:	800037b7          	lui	a5,0x80003
80000b98:	25878793          	addi	a5,a5,600 # 80003258 <memend+0xf8003258>
80000b9c:	00f707b3          	add	a5,a4,a5
80000ba0:	0007a783          	lw	a5,0(a5)
80000ba4:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000ba8:	800037b7          	lui	a5,0x80003
80000bac:	0f478513          	addi	a0,a5,244 # 800030f4 <memend+0xf80030f4>
80000bb0:	150000ef          	jal	ra,80000d00 <printf>
            break;
80000bb4:	0e00006f          	j	80000c94 <trapvec+0x1c0>
        case 1:
            printf("Instruction access fault\n");
80000bb8:	800037b7          	lui	a5,0x80003
80000bbc:	11478513          	addi	a0,a5,276 # 80003114 <memend+0xf8003114>
80000bc0:	140000ef          	jal	ra,80000d00 <printf>
            break;
80000bc4:	0d00006f          	j	80000c94 <trapvec+0x1c0>
        case 2:
            printf("Illegal instruction\n");
80000bc8:	800037b7          	lui	a5,0x80003
80000bcc:	13078513          	addi	a0,a5,304 # 80003130 <memend+0xf8003130>
80000bd0:	130000ef          	jal	ra,80000d00 <printf>
            break;
80000bd4:	0c00006f          	j	80000c94 <trapvec+0x1c0>
        case 3:
            printf("Breakpoint\n");
80000bd8:	800037b7          	lui	a5,0x80003
80000bdc:	14878513          	addi	a0,a5,328 # 80003148 <memend+0xf8003148>
80000be0:	120000ef          	jal	ra,80000d00 <printf>
            break;
80000be4:	0b00006f          	j	80000c94 <trapvec+0x1c0>
        case 4:
            printf("Load address misaligned\n");
80000be8:	800037b7          	lui	a5,0x80003
80000bec:	15478513          	addi	a0,a5,340 # 80003154 <memend+0xf8003154>
80000bf0:	110000ef          	jal	ra,80000d00 <printf>
            break;
80000bf4:	0a00006f          	j	80000c94 <trapvec+0x1c0>
        case 5:
            printf("Load access fault\n");
80000bf8:	800037b7          	lui	a5,0x80003
80000bfc:	17078513          	addi	a0,a5,368 # 80003170 <memend+0xf8003170>
80000c00:	100000ef          	jal	ra,80000d00 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000c04:	0900006f          	j	80000c94 <trapvec+0x1c0>
        case 6:
            printf("Store/AMO address misaligned\n");
80000c08:	800037b7          	lui	a5,0x80003
80000c0c:	18478513          	addi	a0,a5,388 # 80003184 <memend+0xf8003184>
80000c10:	0f0000ef          	jal	ra,80000d00 <printf>
            break;
80000c14:	0800006f          	j	80000c94 <trapvec+0x1c0>
        case 7:
            printf("Store/AMO access fault\n");
80000c18:	800037b7          	lui	a5,0x80003
80000c1c:	1a478513          	addi	a0,a5,420 # 800031a4 <memend+0xf80031a4>
80000c20:	0e0000ef          	jal	ra,80000d00 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000c24:	0700006f          	j	80000c94 <trapvec+0x1c0>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000c28:	800037b7          	lui	a5,0x80003
80000c2c:	1bc78513          	addi	a0,a5,444 # 800031bc <memend+0xf80031bc>
80000c30:	0d0000ef          	jal	ra,80000d00 <printf>
            break;
80000c34:	0600006f          	j	80000c94 <trapvec+0x1c0>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000c38:	800037b7          	lui	a5,0x80003
80000c3c:	1dc78513          	addi	a0,a5,476 # 800031dc <memend+0xf80031dc>
80000c40:	0c0000ef          	jal	ra,80000d00 <printf>
            zero();
80000c44:	e19ff0ef          	jal	ra,80000a5c <zero>
            ecall=1;
80000c48:	00100793          	li	a5,1
80000c4c:	fef42623          	sw	a5,-20(s0)
            break;
80000c50:	0440006f          	j	80000c94 <trapvec+0x1c0>
        case 12:
            printf("Instruction page fault\n");
80000c54:	800037b7          	lui	a5,0x80003
80000c58:	1fc78513          	addi	a0,a5,508 # 800031fc <memend+0xf80031fc>
80000c5c:	0a4000ef          	jal	ra,80000d00 <printf>
            break;
80000c60:	0340006f          	j	80000c94 <trapvec+0x1c0>
        case 13:
            printf("Load page fault\n");
80000c64:	800037b7          	lui	a5,0x80003
80000c68:	21478513          	addi	a0,a5,532 # 80003214 <memend+0xf8003214>
80000c6c:	094000ef          	jal	ra,80000d00 <printf>
            break;
80000c70:	0240006f          	j	80000c94 <trapvec+0x1c0>
        case 15:
            printf("Store/AMO page fault\n");
80000c74:	800037b7          	lui	a5,0x80003
80000c78:	22878513          	addi	a0,a5,552 # 80003228 <memend+0xf8003228>
80000c7c:	084000ef          	jal	ra,80000d00 <printf>
            break;
80000c80:	0140006f          	j	80000c94 <trapvec+0x1c0>
        default:
            printf("Other\n");
80000c84:	800037b7          	lui	a5,0x80003
80000c88:	24078513          	addi	a0,a5,576 # 80003240 <memend+0xf8003240>
80000c8c:	074000ef          	jal	ra,80000d00 <printf>
            break;
80000c90:	00000013          	nop
        }
        if(!ecall){
80000c94:	fec42783          	lw	a5,-20(s0)
80000c98:	00079e63          	bnez	a5,80000cb4 <trapvec+0x1e0>
            panic("Trap Exception");
80000c9c:	800037b7          	lui	a5,0x80003
80000ca0:	24878513          	addi	a0,a5,584 # 80003248 <memend+0xf8003248>
80000ca4:	024000ef          	jal	ra,80000cc8 <panic>
            ecall=1;
80000ca8:	00100793          	li	a5,1
80000cac:	fef42623          	sw	a5,-20(s0)
        }
    }
}
80000cb0:	0040006f          	j	80000cb4 <trapvec+0x1e0>
80000cb4:	00000013          	nop
80000cb8:	01c12083          	lw	ra,28(sp)
80000cbc:	01812403          	lw	s0,24(sp)
80000cc0:	02010113          	addi	sp,sp,32
80000cc4:	00008067          	ret

80000cc8 <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000cc8:	fe010113          	addi	sp,sp,-32
80000ccc:	00112e23          	sw	ra,28(sp)
80000cd0:	00812c23          	sw	s0,24(sp)
80000cd4:	02010413          	addi	s0,sp,32
80000cd8:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000cdc:	800037b7          	lui	a5,0x80003
80000ce0:	29878513          	addi	a0,a5,664 # 80003298 <memend+0xf8003298>
80000ce4:	ae1ff0ef          	jal	ra,800007c4 <uartputs>
    uartputs(s);
80000ce8:	fec42503          	lw	a0,-20(s0)
80000cec:	ad9ff0ef          	jal	ra,800007c4 <uartputs>
	uartputs("\n");
80000cf0:	800037b7          	lui	a5,0x80003
80000cf4:	2a078513          	addi	a0,a5,672 # 800032a0 <memend+0xf80032a0>
80000cf8:	acdff0ef          	jal	ra,800007c4 <uartputs>
    while(1);
80000cfc:	0000006f          	j	80000cfc <panic+0x34>

80000d00 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000d00:	f8010113          	addi	sp,sp,-128
80000d04:	04112e23          	sw	ra,92(sp)
80000d08:	04812c23          	sw	s0,88(sp)
80000d0c:	06010413          	addi	s0,sp,96
80000d10:	faa42623          	sw	a0,-84(s0)
80000d14:	00b42223          	sw	a1,4(s0)
80000d18:	00c42423          	sw	a2,8(s0)
80000d1c:	00d42623          	sw	a3,12(s0)
80000d20:	00e42823          	sw	a4,16(s0)
80000d24:	00f42a23          	sw	a5,20(s0)
80000d28:	01042c23          	sw	a6,24(s0)
80000d2c:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000d30:	02040793          	addi	a5,s0,32
80000d34:	faf42423          	sw	a5,-88(s0)
80000d38:	fa842783          	lw	a5,-88(s0)
80000d3c:	fe478793          	addi	a5,a5,-28
80000d40:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000d44:	fac42783          	lw	a5,-84(s0)
80000d48:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000d4c:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000d50:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
80000d54:	36c0006f          	j	800010c0 <printf+0x3c0>
		if(ch=='%'){
80000d58:	fbf44703          	lbu	a4,-65(s0)
80000d5c:	02500793          	li	a5,37
80000d60:	04f71863          	bne	a4,a5,80000db0 <printf+0xb0>
			if(tt==1){
80000d64:	fe842703          	lw	a4,-24(s0)
80000d68:	00100793          	li	a5,1
80000d6c:	02f71663          	bne	a4,a5,80000d98 <printf+0x98>
				outbuf[idx++]='%';
80000d70:	fe442783          	lw	a5,-28(s0)
80000d74:	00178713          	addi	a4,a5,1
80000d78:	fee42223          	sw	a4,-28(s0)
80000d7c:	8000d737          	lui	a4,0x8000d
80000d80:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000d84:	00f707b3          	add	a5,a4,a5
80000d88:	02500713          	li	a4,37
80000d8c:	00e78023          	sb	a4,0(a5)
				tt=0;
80000d90:	fe042423          	sw	zero,-24(s0)
80000d94:	00c0006f          	j	80000da0 <printf+0xa0>
			}else{
				tt=1;
80000d98:	00100793          	li	a5,1
80000d9c:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000da0:	fec42783          	lw	a5,-20(s0)
80000da4:	00178793          	addi	a5,a5,1
80000da8:	fef42623          	sw	a5,-20(s0)
80000dac:	3140006f          	j	800010c0 <printf+0x3c0>
		}else{
			if(tt==1){
80000db0:	fe842703          	lw	a4,-24(s0)
80000db4:	00100793          	li	a5,1
80000db8:	2cf71e63          	bne	a4,a5,80001094 <printf+0x394>
				switch (ch)
80000dbc:	fbf44783          	lbu	a5,-65(s0)
80000dc0:	fa878793          	addi	a5,a5,-88
80000dc4:	02000713          	li	a4,32
80000dc8:	2af76663          	bltu	a4,a5,80001074 <printf+0x374>
80000dcc:	00279713          	slli	a4,a5,0x2
80000dd0:	800037b7          	lui	a5,0x80003
80000dd4:	2bc78793          	addi	a5,a5,700 # 800032bc <memend+0xf80032bc>
80000dd8:	00f707b3          	add	a5,a4,a5
80000ddc:	0007a783          	lw	a5,0(a5)
80000de0:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000de4:	fb842783          	lw	a5,-72(s0)
80000de8:	00478713          	addi	a4,a5,4
80000dec:	fae42c23          	sw	a4,-72(s0)
80000df0:	0007a783          	lw	a5,0(a5)
80000df4:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000df8:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000dfc:	fe042783          	lw	a5,-32(s0)
80000e00:	fcf42c23          	sw	a5,-40(s0)
80000e04:	0100006f          	j	80000e14 <printf+0x114>
80000e08:	fdc42783          	lw	a5,-36(s0)
80000e0c:	00178793          	addi	a5,a5,1
80000e10:	fcf42e23          	sw	a5,-36(s0)
80000e14:	fd842703          	lw	a4,-40(s0)
80000e18:	00a00793          	li	a5,10
80000e1c:	02f747b3          	div	a5,a4,a5
80000e20:	fcf42c23          	sw	a5,-40(s0)
80000e24:	fd842783          	lw	a5,-40(s0)
80000e28:	fe0790e3          	bnez	a5,80000e08 <printf+0x108>
					for(int i=len;i>=0;i--){
80000e2c:	fdc42783          	lw	a5,-36(s0)
80000e30:	fcf42a23          	sw	a5,-44(s0)
80000e34:	0540006f          	j	80000e88 <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000e38:	fe042703          	lw	a4,-32(s0)
80000e3c:	00a00793          	li	a5,10
80000e40:	02f767b3          	rem	a5,a4,a5
80000e44:	0ff7f713          	andi	a4,a5,255
80000e48:	fe442683          	lw	a3,-28(s0)
80000e4c:	fd442783          	lw	a5,-44(s0)
80000e50:	00f687b3          	add	a5,a3,a5
80000e54:	03070713          	addi	a4,a4,48
80000e58:	0ff77713          	andi	a4,a4,255
80000e5c:	8000d6b7          	lui	a3,0x8000d
80000e60:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
80000e64:	00f687b3          	add	a5,a3,a5
80000e68:	00e78023          	sb	a4,0(a5)
						x/=10;
80000e6c:	fe042703          	lw	a4,-32(s0)
80000e70:	00a00793          	li	a5,10
80000e74:	02f747b3          	div	a5,a4,a5
80000e78:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000e7c:	fd442783          	lw	a5,-44(s0)
80000e80:	fff78793          	addi	a5,a5,-1
80000e84:	fcf42a23          	sw	a5,-44(s0)
80000e88:	fd442783          	lw	a5,-44(s0)
80000e8c:	fa07d6e3          	bgez	a5,80000e38 <printf+0x138>
					}
					idx+=(len+1);
80000e90:	fdc42783          	lw	a5,-36(s0)
80000e94:	00178793          	addi	a5,a5,1
80000e98:	fe442703          	lw	a4,-28(s0)
80000e9c:	00f707b3          	add	a5,a4,a5
80000ea0:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000ea4:	fe042423          	sw	zero,-24(s0)
					break;
80000ea8:	1dc0006f          	j	80001084 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000eac:	fe442783          	lw	a5,-28(s0)
80000eb0:	00178713          	addi	a4,a5,1
80000eb4:	fee42223          	sw	a4,-28(s0)
80000eb8:	8000d737          	lui	a4,0x8000d
80000ebc:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000ec0:	00f707b3          	add	a5,a4,a5
80000ec4:	03000713          	li	a4,48
80000ec8:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000ecc:	fe442783          	lw	a5,-28(s0)
80000ed0:	00178713          	addi	a4,a5,1
80000ed4:	fee42223          	sw	a4,-28(s0)
80000ed8:	8000d737          	lui	a4,0x8000d
80000edc:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000ee0:	00f707b3          	add	a5,a4,a5
80000ee4:	07800713          	li	a4,120
80000ee8:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80000eec:	fb842783          	lw	a5,-72(s0)
80000ef0:	00478713          	addi	a4,a5,4
80000ef4:	fae42c23          	sw	a4,-72(s0)
80000ef8:	0007a783          	lw	a5,0(a5)
80000efc:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80000f00:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80000f04:	fd042783          	lw	a5,-48(s0)
80000f08:	fcf42423          	sw	a5,-56(s0)
80000f0c:	0100006f          	j	80000f1c <printf+0x21c>
80000f10:	fcc42783          	lw	a5,-52(s0)
80000f14:	00178793          	addi	a5,a5,1
80000f18:	fcf42623          	sw	a5,-52(s0)
80000f1c:	fc842783          	lw	a5,-56(s0)
80000f20:	0047d793          	srli	a5,a5,0x4
80000f24:	fcf42423          	sw	a5,-56(s0)
80000f28:	fc842783          	lw	a5,-56(s0)
80000f2c:	fe0792e3          	bnez	a5,80000f10 <printf+0x210>
					for(int i=len;i>=0;i--){
80000f30:	fcc42783          	lw	a5,-52(s0)
80000f34:	fcf42223          	sw	a5,-60(s0)
80000f38:	0840006f          	j	80000fbc <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80000f3c:	fd042783          	lw	a5,-48(s0)
80000f40:	00f7f713          	andi	a4,a5,15
80000f44:	00900793          	li	a5,9
80000f48:	02e7f063          	bgeu	a5,a4,80000f68 <printf+0x268>
80000f4c:	fd042783          	lw	a5,-48(s0)
80000f50:	0ff7f793          	andi	a5,a5,255
80000f54:	00f7f793          	andi	a5,a5,15
80000f58:	0ff7f793          	andi	a5,a5,255
80000f5c:	05778793          	addi	a5,a5,87
80000f60:	0ff7f793          	andi	a5,a5,255
80000f64:	01c0006f          	j	80000f80 <printf+0x280>
80000f68:	fd042783          	lw	a5,-48(s0)
80000f6c:	0ff7f793          	andi	a5,a5,255
80000f70:	00f7f793          	andi	a5,a5,15
80000f74:	0ff7f793          	andi	a5,a5,255
80000f78:	03078793          	addi	a5,a5,48
80000f7c:	0ff7f793          	andi	a5,a5,255
80000f80:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80000f84:	fe442703          	lw	a4,-28(s0)
80000f88:	fc442783          	lw	a5,-60(s0)
80000f8c:	00f707b3          	add	a5,a4,a5
80000f90:	8000d737          	lui	a4,0x8000d
80000f94:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000f98:	00f707b3          	add	a5,a4,a5
80000f9c:	fbe44703          	lbu	a4,-66(s0)
80000fa0:	00e78023          	sb	a4,0(a5)
						x/=16;
80000fa4:	fd042783          	lw	a5,-48(s0)
80000fa8:	0047d793          	srli	a5,a5,0x4
80000fac:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80000fb0:	fc442783          	lw	a5,-60(s0)
80000fb4:	fff78793          	addi	a5,a5,-1
80000fb8:	fcf42223          	sw	a5,-60(s0)
80000fbc:	fc442783          	lw	a5,-60(s0)
80000fc0:	f607dee3          	bgez	a5,80000f3c <printf+0x23c>
					}
					idx+=(len+1);
80000fc4:	fcc42783          	lw	a5,-52(s0)
80000fc8:	00178793          	addi	a5,a5,1
80000fcc:	fe442703          	lw	a4,-28(s0)
80000fd0:	00f707b3          	add	a5,a4,a5
80000fd4:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000fd8:	fe042423          	sw	zero,-24(s0)
					break;
80000fdc:	0a80006f          	j	80001084 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80000fe0:	fb842783          	lw	a5,-72(s0)
80000fe4:	00478713          	addi	a4,a5,4
80000fe8:	fae42c23          	sw	a4,-72(s0)
80000fec:	0007a783          	lw	a5,0(a5)
80000ff0:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80000ff4:	fe442783          	lw	a5,-28(s0)
80000ff8:	00178713          	addi	a4,a5,1
80000ffc:	fee42223          	sw	a4,-28(s0)
80001000:	8000d737          	lui	a4,0x8000d
80001004:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001008:	00f707b3          	add	a5,a4,a5
8000100c:	fbf44703          	lbu	a4,-65(s0)
80001010:	00e78023          	sb	a4,0(a5)
					tt=0;
80001014:	fe042423          	sw	zero,-24(s0)
					break;
80001018:	06c0006f          	j	80001084 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
8000101c:	fb842783          	lw	a5,-72(s0)
80001020:	00478713          	addi	a4,a5,4
80001024:	fae42c23          	sw	a4,-72(s0)
80001028:	0007a783          	lw	a5,0(a5)
8000102c:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80001030:	0300006f          	j	80001060 <printf+0x360>
						outbuf[idx++]=*ss++;
80001034:	fc042703          	lw	a4,-64(s0)
80001038:	00170793          	addi	a5,a4,1
8000103c:	fcf42023          	sw	a5,-64(s0)
80001040:	fe442783          	lw	a5,-28(s0)
80001044:	00178693          	addi	a3,a5,1
80001048:	fed42223          	sw	a3,-28(s0)
8000104c:	00074703          	lbu	a4,0(a4)
80001050:	8000d6b7          	lui	a3,0x8000d
80001054:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
80001058:	00f687b3          	add	a5,a3,a5
8000105c:	00e78023          	sb	a4,0(a5)
					while(*ss){
80001060:	fc042783          	lw	a5,-64(s0)
80001064:	0007c783          	lbu	a5,0(a5)
80001068:	fc0796e3          	bnez	a5,80001034 <printf+0x334>
					}
					tt=0;
8000106c:	fe042423          	sw	zero,-24(s0)
					break;
80001070:	0140006f          	j	80001084 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80001074:	800037b7          	lui	a5,0x80003
80001078:	2a478513          	addi	a0,a5,676 # 800032a4 <memend+0xf80032a4>
8000107c:	c4dff0ef          	jal	ra,80000cc8 <panic>
					break;
80001080:	00000013          	nop
				}
				s++;
80001084:	fec42783          	lw	a5,-20(s0)
80001088:	00178793          	addi	a5,a5,1
8000108c:	fef42623          	sw	a5,-20(s0)
80001090:	0300006f          	j	800010c0 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80001094:	fe442783          	lw	a5,-28(s0)
80001098:	00178713          	addi	a4,a5,1
8000109c:	fee42223          	sw	a4,-28(s0)
800010a0:	8000d737          	lui	a4,0x8000d
800010a4:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
800010a8:	00f707b3          	add	a5,a4,a5
800010ac:	fbf44703          	lbu	a4,-65(s0)
800010b0:	00e78023          	sb	a4,0(a5)
				s++;
800010b4:	fec42783          	lw	a5,-20(s0)
800010b8:	00178793          	addi	a5,a5,1
800010bc:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
800010c0:	fec42783          	lw	a5,-20(s0)
800010c4:	0007c783          	lbu	a5,0(a5)
800010c8:	faf40fa3          	sb	a5,-65(s0)
800010cc:	fbf44783          	lbu	a5,-65(s0)
800010d0:	c80794e3          	bnez	a5,80000d58 <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
800010d4:	8000d7b7          	lui	a5,0x8000d
800010d8:	00478713          	addi	a4,a5,4 # 8000d004 <memend+0xf800d004>
800010dc:	fe442783          	lw	a5,-28(s0)
800010e0:	00f707b3          	add	a5,a4,a5
800010e4:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
800010e8:	8000d7b7          	lui	a5,0x8000d
800010ec:	00478513          	addi	a0,a5,4 # 8000d004 <memend+0xf800d004>
800010f0:	ed4ff0ef          	jal	ra,800007c4 <uartputs>
	return idx;
800010f4:	fe442783          	lw	a5,-28(s0)
800010f8:	00078513          	mv	a0,a5
800010fc:	05c12083          	lw	ra,92(sp)
80001100:	05812403          	lw	s0,88(sp)
80001104:	08010113          	addi	sp,sp,128
80001108:	00008067          	ret

8000110c <minit>:
struct
{
    struct pmp* freelist;
}mem;

void minit(){
8000110c:	fe010113          	addi	sp,sp,-32
80001110:	00812e23          	sw	s0,28(sp)
80001114:	02010413          	addi	s0,sp,32
        printf("mstart:%p   ",mstart);
        printf("mend:%p\n",mend);
        printf("stack:%p\n",stacks);
    #endif

    char* p=(char*)mstart;
80001118:	8000e7b7          	lui	a5,0x8000e
8000111c:	00078793          	mv	a5,a5
80001120:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001124:	0380006f          	j	8000115c <minit+0x50>
        m=(struct pmp*)p;
80001128:	fec42783          	lw	a5,-20(s0)
8000112c:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
80001130:	8000e7b7          	lui	a5,0x8000e
80001134:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001138:	fe842783          	lw	a5,-24(s0)
8000113c:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
80001140:	8000e7b7          	lui	a5,0x8000e
80001144:	fe842703          	lw	a4,-24(s0)
80001148:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
8000114c:	fec42703          	lw	a4,-20(s0)
80001150:	000017b7          	lui	a5,0x1
80001154:	00f707b3          	add	a5,a4,a5
80001158:	fef42623          	sw	a5,-20(s0)
8000115c:	fec42703          	lw	a4,-20(s0)
80001160:	000017b7          	lui	a5,0x1
80001164:	00f70733          	add	a4,a4,a5
80001168:	880007b7          	lui	a5,0x88000
8000116c:	00078793          	mv	a5,a5
80001170:	fae7fce3          	bgeu	a5,a4,80001128 <minit+0x1c>
    }
}
80001174:	00000013          	nop
80001178:	00000013          	nop
8000117c:	01c12403          	lw	s0,28(sp)
80001180:	02010113          	addi	sp,sp,32
80001184:	00008067          	ret

80001188 <palloc>:

void* palloc(){
80001188:	fe010113          	addi	sp,sp,-32
8000118c:	00112e23          	sw	ra,28(sp)
80001190:	00812c23          	sw	s0,24(sp)
80001194:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80001198:	8000e7b7          	lui	a5,0x8000e
8000119c:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800011a0:	fef42623          	sw	a5,-20(s0)
    if(p)
800011a4:	fec42783          	lw	a5,-20(s0)
800011a8:	00078c63          	beqz	a5,800011c0 <palloc+0x38>
        mem.freelist=mem.freelist->next;
800011ac:	8000e7b7          	lui	a5,0x8000e
800011b0:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800011b4:	0007a703          	lw	a4,0(a5)
800011b8:	8000e7b7          	lui	a5,0x8000e
800011bc:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    if(p)
800011c0:	fec42783          	lw	a5,-20(s0)
800011c4:	00078a63          	beqz	a5,800011d8 <palloc+0x50>
        memset(p,0,PGSIZE);
800011c8:	00001637          	lui	a2,0x1
800011cc:	00000593          	li	a1,0
800011d0:	fec42503          	lw	a0,-20(s0)
800011d4:	261000ef          	jal	ra,80001c34 <memset>
    return (void*)p;
800011d8:	fec42783          	lw	a5,-20(s0)
}
800011dc:	00078513          	mv	a0,a5
800011e0:	01c12083          	lw	ra,28(sp)
800011e4:	01812403          	lw	s0,24(sp)
800011e8:	02010113          	addi	sp,sp,32
800011ec:	00008067          	ret

800011f0 <pfree>:

void pfree(void* addr){
800011f0:	fd010113          	addi	sp,sp,-48
800011f4:	02812623          	sw	s0,44(sp)
800011f8:	03010413          	addi	s0,sp,48
800011fc:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80001200:	fdc42783          	lw	a5,-36(s0)
80001204:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
80001208:	8000e7b7          	lui	a5,0x8000e
8000120c:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001210:	fec42783          	lw	a5,-20(s0)
80001214:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
80001218:	8000e7b7          	lui	a5,0x8000e
8000121c:	fec42703          	lw	a4,-20(s0)
80001220:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001224:	00000013          	nop
80001228:	02c12403          	lw	s0,44(sp)
8000122c:	03010113          	addi	sp,sp,48
80001230:	00008067          	ret

80001234 <r_tp>:
static inline uint32 r_tp(){
80001234:	fe010113          	addi	sp,sp,-32
80001238:	00812e23          	sw	s0,28(sp)
8000123c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001240:	00020793          	mv	a5,tp
80001244:	fef42623          	sw	a5,-20(s0)
    return x;
80001248:	fec42783          	lw	a5,-20(s0)
}
8000124c:	00078513          	mv	a0,a5
80001250:	01c12403          	lw	s0,28(sp)
80001254:	02010113          	addi	sp,sp,32
80001258:	00008067          	ret

8000125c <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
8000125c:	fe010113          	addi	sp,sp,-32
80001260:	00812e23          	sw	s0,28(sp)
80001264:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
80001268:	104027f3          	csrr	a5,sie
8000126c:	fef42623          	sw	a5,-20(s0)
    return x;
80001270:	fec42783          	lw	a5,-20(s0)
}
80001274:	00078513          	mv	a0,a5
80001278:	01c12403          	lw	s0,28(sp)
8000127c:	02010113          	addi	sp,sp,32
80001280:	00008067          	ret

80001284 <w_sie>:
static inline void w_sie(uint32 x){
80001284:	fe010113          	addi	sp,sp,-32
80001288:	00812e23          	sw	s0,28(sp)
8000128c:	02010413          	addi	s0,sp,32
80001290:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80001294:	fec42783          	lw	a5,-20(s0)
80001298:	10479073          	csrw	sie,a5
}
8000129c:	00000013          	nop
800012a0:	01c12403          	lw	s0,28(sp)
800012a4:	02010113          	addi	sp,sp,32
800012a8:	00008067          	ret

800012ac <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
800012ac:	ff010113          	addi	sp,sp,-16
800012b0:	00112623          	sw	ra,12(sp)
800012b4:	00812423          	sw	s0,8(sp)
800012b8:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
800012bc:	0c0007b7          	lui	a5,0xc000
800012c0:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
800012c4:	00100713          	li	a4,1
800012c8:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800012cc:	f69ff0ef          	jal	ra,80001234 <r_tp>
800012d0:	00050793          	mv	a5,a0
800012d4:	00879713          	slli	a4,a5,0x8
800012d8:	0c0027b7          	lui	a5,0xc002
800012dc:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
800012e0:	00f707b3          	add	a5,a4,a5
800012e4:	00078713          	mv	a4,a5
800012e8:	40000793          	li	a5,1024
800012ec:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800012f0:	f45ff0ef          	jal	ra,80001234 <r_tp>
800012f4:	00050713          	mv	a4,a0
800012f8:	000c07b7          	lui	a5,0xc0
800012fc:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
80001300:	00f707b3          	add	a5,a4,a5
80001304:	00879793          	slli	a5,a5,0x8
80001308:	00078713          	mv	a4,a5
8000130c:	40000793          	li	a5,1024
80001310:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
80001314:	f21ff0ef          	jal	ra,80001234 <r_tp>
80001318:	00050713          	mv	a4,a0
8000131c:	000067b7          	lui	a5,0x6
80001320:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
80001324:	00f707b3          	add	a5,a4,a5
80001328:	00d79793          	slli	a5,a5,0xd
8000132c:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
80001330:	f05ff0ef          	jal	ra,80001234 <r_tp>
80001334:	00050793          	mv	a5,a0
80001338:	00d79713          	slli	a4,a5,0xd
8000133c:	0c2017b7          	lui	a5,0xc201
80001340:	00f707b3          	add	a5,a4,a5
80001344:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
80001348:	f15ff0ef          	jal	ra,8000125c <r_sie>
8000134c:	00050793          	mv	a5,a0
80001350:	2227e793          	ori	a5,a5,546
80001354:	00078513          	mv	a0,a5
80001358:	f2dff0ef          	jal	ra,80001284 <w_sie>
}
8000135c:	00000013          	nop
80001360:	00c12083          	lw	ra,12(sp)
80001364:	00812403          	lw	s0,8(sp)
80001368:	01010113          	addi	sp,sp,16
8000136c:	00008067          	ret

80001370 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80001370:	ff010113          	addi	sp,sp,-16
80001374:	00112623          	sw	ra,12(sp)
80001378:	00812423          	sw	s0,8(sp)
8000137c:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001380:	eb5ff0ef          	jal	ra,80001234 <r_tp>
80001384:	00050793          	mv	a5,a0
80001388:	00d79713          	slli	a4,a5,0xd
8000138c:	0c2017b7          	lui	a5,0xc201
80001390:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001394:	00f707b3          	add	a5,a4,a5
80001398:	0007a783          	lw	a5,0(a5)
}
8000139c:	00078513          	mv	a0,a5
800013a0:	00c12083          	lw	ra,12(sp)
800013a4:	00812403          	lw	s0,8(sp)
800013a8:	01010113          	addi	sp,sp,16
800013ac:	00008067          	ret

800013b0 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
800013b0:	fe010113          	addi	sp,sp,-32
800013b4:	00112e23          	sw	ra,28(sp)
800013b8:	00812c23          	sw	s0,24(sp)
800013bc:	02010413          	addi	s0,sp,32
800013c0:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
800013c4:	e71ff0ef          	jal	ra,80001234 <r_tp>
800013c8:	00050793          	mv	a5,a0
800013cc:	00d79713          	slli	a4,a5,0xd
800013d0:	0c2007b7          	lui	a5,0xc200
800013d4:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
800013d8:	00f707b3          	add	a5,a4,a5
800013dc:	00078713          	mv	a4,a5
800013e0:	fec42783          	lw	a5,-20(s0)
800013e4:	00f72023          	sw	a5,0(a4)
800013e8:	00000013          	nop
800013ec:	01c12083          	lw	ra,28(sp)
800013f0:	01812403          	lw	s0,24(sp)
800013f4:	02010113          	addi	sp,sp,32
800013f8:	00008067          	ret

800013fc <w_satp>:
static inline void w_satp(uint32 x){
800013fc:	fe010113          	addi	sp,sp,-32
80001400:	00812e23          	sw	s0,28(sp)
80001404:	02010413          	addi	s0,sp,32
80001408:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
8000140c:	fec42783          	lw	a5,-20(s0)
80001410:	18079073          	csrw	satp,a5
}
80001414:	00000013          	nop
80001418:	01c12403          	lw	s0,28(sp)
8000141c:	02010113          	addi	sp,sp,32
80001420:	00008067          	ret

80001424 <sfence_vma>:
static inline void sfence_vma(){
80001424:	ff010113          	addi	sp,sp,-16
80001428:	00812623          	sw	s0,12(sp)
8000142c:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
80001430:	12000073          	sfence.vma
}
80001434:	00000013          	nop
80001438:	00c12403          	lw	s0,12(sp)
8000143c:	01010113          	addi	sp,sp,16
80001440:	00008067          	ret

80001444 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
80001444:	fd010113          	addi	sp,sp,-48
80001448:	02112623          	sw	ra,44(sp)
8000144c:	02812423          	sw	s0,40(sp)
80001450:	03010413          	addi	s0,sp,48
80001454:	fca42e23          	sw	a0,-36(s0)
80001458:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
8000145c:	fd842783          	lw	a5,-40(s0)
80001460:	0167d793          	srli	a5,a5,0x16
80001464:	00279793          	slli	a5,a5,0x2
80001468:	fdc42703          	lw	a4,-36(s0)
8000146c:	00f707b3          	add	a5,a4,a5
80001470:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001474:	fec42783          	lw	a5,-20(s0)
80001478:	0007a783          	lw	a5,0(a5)
8000147c:	0017f793          	andi	a5,a5,1
80001480:	00078e63          	beqz	a5,8000149c <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001484:	fec42783          	lw	a5,-20(s0)
80001488:	0007a783          	lw	a5,0(a5)
8000148c:	00a7d793          	srli	a5,a5,0xa
80001490:	00c79793          	slli	a5,a5,0xc
80001494:	fcf42e23          	sw	a5,-36(s0)
80001498:	0340006f          	j	800014cc <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
8000149c:	cedff0ef          	jal	ra,80001188 <palloc>
800014a0:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
800014a4:	00001637          	lui	a2,0x1
800014a8:	00000593          	li	a1,0
800014ac:	fdc42503          	lw	a0,-36(s0)
800014b0:	784000ef          	jal	ra,80001c34 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
800014b4:	fdc42783          	lw	a5,-36(s0)
800014b8:	00c7d793          	srli	a5,a5,0xc
800014bc:	00a79793          	slli	a5,a5,0xa
800014c0:	0017e713          	ori	a4,a5,1
800014c4:	fec42783          	lw	a5,-20(s0)
800014c8:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
800014cc:	fd842783          	lw	a5,-40(s0)
800014d0:	00c7d793          	srli	a5,a5,0xc
800014d4:	3ff7f793          	andi	a5,a5,1023
800014d8:	00279793          	slli	a5,a5,0x2
800014dc:	fdc42703          	lw	a4,-36(s0)
800014e0:	00f707b3          	add	a5,a4,a5
}
800014e4:	00078513          	mv	a0,a5
800014e8:	02c12083          	lw	ra,44(sp)
800014ec:	02812403          	lw	s0,40(sp)
800014f0:	03010113          	addi	sp,sp,48
800014f4:	00008067          	ret

800014f8 <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
800014f8:	fc010113          	addi	sp,sp,-64
800014fc:	02112e23          	sw	ra,60(sp)
80001500:	02812c23          	sw	s0,56(sp)
80001504:	04010413          	addi	s0,sp,64
80001508:	fca42e23          	sw	a0,-36(s0)
8000150c:	fcb42c23          	sw	a1,-40(s0)
80001510:	fcc42a23          	sw	a2,-44(s0)
80001514:	fcd42823          	sw	a3,-48(s0)
80001518:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
8000151c:	fd842703          	lw	a4,-40(s0)
80001520:	fffff7b7          	lui	a5,0xfffff
80001524:	00f777b3          	and	a5,a4,a5
80001528:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
8000152c:	fd042703          	lw	a4,-48(s0)
80001530:	fd842783          	lw	a5,-40(s0)
80001534:	00f707b3          	add	a5,a4,a5
80001538:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
8000153c:	fffff7b7          	lui	a5,0xfffff
80001540:	00f777b3          	and	a5,a4,a5
80001544:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
80001548:	fec42583          	lw	a1,-20(s0)
8000154c:	fdc42503          	lw	a0,-36(s0)
80001550:	ef5ff0ef          	jal	ra,80001444 <acquriepte>
80001554:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
80001558:	fe442783          	lw	a5,-28(s0)
8000155c:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001560:	0017f793          	andi	a5,a5,1
80001564:	00078863          	beqz	a5,80001574 <vmmap+0x7c>
            panic("repeat map");
80001568:	800037b7          	lui	a5,0x80003
8000156c:	34078513          	addi	a0,a5,832 # 80003340 <memend+0xf8003340>
80001570:	f58ff0ef          	jal	ra,80000cc8 <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001574:	fd442783          	lw	a5,-44(s0)
80001578:	00c7d793          	srli	a5,a5,0xc
8000157c:	00a79713          	slli	a4,a5,0xa
80001580:	fcc42783          	lw	a5,-52(s0)
80001584:	00f767b3          	or	a5,a4,a5
80001588:	0017e713          	ori	a4,a5,1
8000158c:	fe442783          	lw	a5,-28(s0)
80001590:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001594:	fec42703          	lw	a4,-20(s0)
80001598:	fe842783          	lw	a5,-24(s0)
8000159c:	02f70463          	beq	a4,a5,800015c4 <vmmap+0xcc>
        start += PGSIZE;
800015a0:	fec42703          	lw	a4,-20(s0)
800015a4:	000017b7          	lui	a5,0x1
800015a8:	00f707b3          	add	a5,a4,a5
800015ac:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
800015b0:	fd442703          	lw	a4,-44(s0)
800015b4:	000017b7          	lui	a5,0x1
800015b8:	00f707b3          	add	a5,a4,a5
800015bc:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
800015c0:	f89ff06f          	j	80001548 <vmmap+0x50>
        if(start==end)  break;
800015c4:	00000013          	nop
    }
}
800015c8:	00000013          	nop
800015cc:	03c12083          	lw	ra,60(sp)
800015d0:	03812403          	lw	s0,56(sp)
800015d4:	04010113          	addi	sp,sp,64
800015d8:	00008067          	ret

800015dc <printpgt>:

void printpgt(addr_t* pgt){
800015dc:	fc010113          	addi	sp,sp,-64
800015e0:	02112e23          	sw	ra,60(sp)
800015e4:	02812c23          	sw	s0,56(sp)
800015e8:	04010413          	addi	s0,sp,64
800015ec:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
800015f0:	fe042623          	sw	zero,-20(s0)
800015f4:	0c40006f          	j	800016b8 <printpgt+0xdc>
        pte_t pte=pgt[i];
800015f8:	fec42783          	lw	a5,-20(s0)
800015fc:	00279793          	slli	a5,a5,0x2
80001600:	fcc42703          	lw	a4,-52(s0)
80001604:	00f707b3          	add	a5,a4,a5
80001608:	0007a783          	lw	a5,0(a5) # 1000 <sz>
8000160c:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
80001610:	fe442783          	lw	a5,-28(s0)
80001614:	0017f793          	andi	a5,a5,1
80001618:	08078a63          	beqz	a5,800016ac <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
8000161c:	fe442783          	lw	a5,-28(s0)
80001620:	00a7d793          	srli	a5,a5,0xa
80001624:	00c79793          	slli	a5,a5,0xc
80001628:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
8000162c:	fe042683          	lw	a3,-32(s0)
80001630:	fe442603          	lw	a2,-28(s0)
80001634:	fec42583          	lw	a1,-20(s0)
80001638:	800037b7          	lui	a5,0x80003
8000163c:	34c78513          	addi	a0,a5,844 # 8000334c <memend+0xf800334c>
80001640:	ec0ff0ef          	jal	ra,80000d00 <printf>
            for(int j=0;j<1024;j++){
80001644:	fe042423          	sw	zero,-24(s0)
80001648:	0580006f          	j	800016a0 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
8000164c:	fe842783          	lw	a5,-24(s0)
80001650:	00279793          	slli	a5,a5,0x2
80001654:	fe042703          	lw	a4,-32(s0)
80001658:	00f707b3          	add	a5,a4,a5
8000165c:	0007a783          	lw	a5,0(a5)
80001660:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001664:	fdc42783          	lw	a5,-36(s0)
80001668:	0017f793          	andi	a5,a5,1
8000166c:	02078463          	beqz	a5,80001694 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001670:	fdc42783          	lw	a5,-36(s0)
80001674:	00a7d793          	srli	a5,a5,0xa
80001678:	00c79793          	slli	a5,a5,0xc
8000167c:	00078693          	mv	a3,a5
80001680:	fdc42603          	lw	a2,-36(s0)
80001684:	fe842583          	lw	a1,-24(s0)
80001688:	800037b7          	lui	a5,0x80003
8000168c:	36478513          	addi	a0,a5,868 # 80003364 <memend+0xf8003364>
80001690:	e70ff0ef          	jal	ra,80000d00 <printf>
            for(int j=0;j<1024;j++){
80001694:	fe842783          	lw	a5,-24(s0)
80001698:	00178793          	addi	a5,a5,1
8000169c:	fef42423          	sw	a5,-24(s0)
800016a0:	fe842703          	lw	a4,-24(s0)
800016a4:	3ff00793          	li	a5,1023
800016a8:	fae7d2e3          	bge	a5,a4,8000164c <printpgt+0x70>
    for(int i=0;i<1024;i++){
800016ac:	fec42783          	lw	a5,-20(s0)
800016b0:	00178793          	addi	a5,a5,1
800016b4:	fef42623          	sw	a5,-20(s0)
800016b8:	fec42703          	lw	a4,-20(s0)
800016bc:	3ff00793          	li	a5,1023
800016c0:	f2e7dce3          	bge	a5,a4,800015f8 <printpgt+0x1c>
                }
            }
        }
    }
}
800016c4:	00000013          	nop
800016c8:	00000013          	nop
800016cc:	03c12083          	lw	ra,60(sp)
800016d0:	03812403          	lw	s0,56(sp)
800016d4:	04010113          	addi	sp,sp,64
800016d8:	00008067          	ret

800016dc <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
800016dc:	fd010113          	addi	sp,sp,-48
800016e0:	02112623          	sw	ra,44(sp)
800016e4:	02812423          	sw	s0,40(sp)
800016e8:	03010413          	addi	s0,sp,48
800016ec:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
800016f0:	fe042623          	sw	zero,-20(s0)
800016f4:	04c0006f          	j	80001740 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
800016f8:	fec42783          	lw	a5,-20(s0)
800016fc:	00d79793          	slli	a5,a5,0xd
80001700:	00078713          	mv	a4,a5
80001704:	c00017b7          	lui	a5,0xc0001
80001708:	00f707b3          	add	a5,a4,a5
8000170c:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
80001710:	a79ff0ef          	jal	ra,80001188 <palloc>
80001714:	00050793          	mv	a5,a0
80001718:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
8000171c:	00600713          	li	a4,6
80001720:	000016b7          	lui	a3,0x1
80001724:	fe442603          	lw	a2,-28(s0)
80001728:	fe842583          	lw	a1,-24(s0)
8000172c:	fdc42503          	lw	a0,-36(s0)
80001730:	dc9ff0ef          	jal	ra,800014f8 <vmmap>
    for(int i=0;i<NPROC;i++){
80001734:	fec42783          	lw	a5,-20(s0)
80001738:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
8000173c:	fef42623          	sw	a5,-20(s0)
80001740:	fec42703          	lw	a4,-20(s0)
80001744:	00300793          	li	a5,3
80001748:	fae7d8e3          	bge	a5,a4,800016f8 <mkstack+0x1c>
    }
}
8000174c:	00000013          	nop
80001750:	00000013          	nop
80001754:	02c12083          	lw	ra,44(sp)
80001758:	02812403          	lw	s0,40(sp)
8000175c:	03010113          	addi	sp,sp,48
80001760:	00008067          	ret

80001764 <kvminit>:

// 初始化虚拟内存
void kvminit(){
80001764:	ff010113          	addi	sp,sp,-16
80001768:	00112623          	sw	ra,12(sp)
8000176c:	00812423          	sw	s0,8(sp)
80001770:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001774:	a15ff0ef          	jal	ra,80001188 <palloc>
80001778:	00050713          	mv	a4,a0
8000177c:	8000e7b7          	lui	a5,0x8000e
80001780:	8ae7a423          	sw	a4,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
    memset(kpgt,0,PGSIZE);
80001784:	8000e7b7          	lui	a5,0x8000e
80001788:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
8000178c:	00001637          	lui	a2,0x1
80001790:	00000593          	li	a1,0
80001794:	00078513          	mv	a0,a5
80001798:	49c000ef          	jal	ra,80001c34 <memset>

    // 映射 CLINT
    vmmap(kpgt,CLINT_BASE,CLINT_BASE,0xc000,PTE_R|PTE_W);
8000179c:	8000e7b7          	lui	a5,0x8000e
800017a0:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800017a4:	00600713          	li	a4,6
800017a8:	0000c6b7          	lui	a3,0xc
800017ac:	02000637          	lui	a2,0x2000
800017b0:	020005b7          	lui	a1,0x2000
800017b4:	00078513          	mv	a0,a5
800017b8:	d41ff0ef          	jal	ra,800014f8 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
800017bc:	8000e7b7          	lui	a5,0x8000e
800017c0:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800017c4:	00600713          	li	a4,6
800017c8:	004006b7          	lui	a3,0x400
800017cc:	0c000637          	lui	a2,0xc000
800017d0:	0c0005b7          	lui	a1,0xc000
800017d4:	00078513          	mv	a0,a5
800017d8:	d21ff0ef          	jal	ra,800014f8 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
800017dc:	8000e7b7          	lui	a5,0x8000e
800017e0:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800017e4:	00600713          	li	a4,6
800017e8:	000016b7          	lui	a3,0x1
800017ec:	10000637          	lui	a2,0x10000
800017f0:	100005b7          	lui	a1,0x10000
800017f4:	00078513          	mv	a0,a5
800017f8:	d01ff0ef          	jal	ra,800014f8 <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
800017fc:	8000e7b7          	lui	a5,0x8000e
80001800:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001804:	800007b7          	lui	a5,0x80000
80001808:	00078593          	mv	a1,a5
8000180c:	800007b7          	lui	a5,0x80000
80001810:	00078613          	mv	a2,a5
80001814:	800027b7          	lui	a5,0x80002
80001818:	20478713          	addi	a4,a5,516 # 80002204 <memend+0xf8002204>
8000181c:	800007b7          	lui	a5,0x80000
80001820:	00078793          	mv	a5,a5
80001824:	40f707b3          	sub	a5,a4,a5
80001828:	00a00713          	li	a4,10
8000182c:	00078693          	mv	a3,a5
80001830:	cc9ff0ef          	jal	ra,800014f8 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001834:	8000e7b7          	lui	a5,0x8000e
80001838:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
8000183c:	800037b7          	lui	a5,0x80003
80001840:	00078593          	mv	a1,a5
80001844:	800037b7          	lui	a5,0x80003
80001848:	00078613          	mv	a2,a5
8000184c:	800037b7          	lui	a5,0x80003
80001850:	37b78713          	addi	a4,a5,891 # 8000337b <memend+0xf800337b>
80001854:	800037b7          	lui	a5,0x80003
80001858:	00078793          	mv	a5,a5
8000185c:	40f707b3          	sub	a5,a4,a5
80001860:	00200713          	li	a4,2
80001864:	00078693          	mv	a3,a5
80001868:	c91ff0ef          	jal	ra,800014f8 <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
8000186c:	8000e7b7          	lui	a5,0x8000e
80001870:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001874:	800047b7          	lui	a5,0x80004
80001878:	00078593          	mv	a1,a5
8000187c:	800047b7          	lui	a5,0x80004
80001880:	00078613          	mv	a2,a5
80001884:	8000c7b7          	lui	a5,0x8000c
80001888:	00478713          	addi	a4,a5,4 # 8000c004 <memend+0xf800c004>
8000188c:	800047b7          	lui	a5,0x80004
80001890:	00078793          	mv	a5,a5
80001894:	40f707b3          	sub	a5,a4,a5
80001898:	00600713          	li	a4,6
8000189c:	00078693          	mv	a3,a5
800018a0:	c59ff0ef          	jal	ra,800014f8 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
800018a4:	8000e7b7          	lui	a5,0x8000e
800018a8:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018ac:	8000d7b7          	lui	a5,0x8000d
800018b0:	00078593          	mv	a1,a5
800018b4:	8000d7b7          	lui	a5,0x8000d
800018b8:	00078613          	mv	a2,a5
800018bc:	8000e7b7          	lui	a5,0x8000e
800018c0:	94c78713          	addi	a4,a5,-1716 # 8000d94c <memend+0xf800d94c>
800018c4:	8000d7b7          	lui	a5,0x8000d
800018c8:	00078793          	mv	a5,a5
800018cc:	40f707b3          	sub	a5,a4,a5
800018d0:	00600713          	li	a4,6
800018d4:	00078693          	mv	a3,a5
800018d8:	c21ff0ef          	jal	ra,800014f8 <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
800018dc:	8000e7b7          	lui	a5,0x8000e
800018e0:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018e4:	8000e7b7          	lui	a5,0x8000e
800018e8:	00078593          	mv	a1,a5
800018ec:	8000e7b7          	lui	a5,0x8000e
800018f0:	00078613          	mv	a2,a5
800018f4:	880007b7          	lui	a5,0x88000
800018f8:	00078713          	mv	a4,a5
800018fc:	8000e7b7          	lui	a5,0x8000e
80001900:	00078793          	mv	a5,a5
80001904:	40f707b3          	sub	a5,a4,a5
80001908:	00600713          	li	a4,6
8000190c:	00078693          	mv	a3,a5
80001910:	be9ff0ef          	jal	ra,800014f8 <vmmap>

    mkstack(kpgt);
80001914:	8000e7b7          	lui	a5,0x8000e
80001918:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
8000191c:	00078513          	mv	a0,a5
80001920:	dbdff0ef          	jal	ra,800016dc <mkstack>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001924:	8000e7b7          	lui	a5,0x8000e
80001928:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
8000192c:	00c7d713          	srli	a4,a5,0xc
80001930:	800007b7          	lui	a5,0x80000
80001934:	00f767b3          	or	a5,a4,a5
80001938:	00078513          	mv	a0,a5
8000193c:	ac1ff0ef          	jal	ra,800013fc <w_satp>
    sfence_vma();       // 刷新页表
80001940:	ae5ff0ef          	jal	ra,80001424 <sfence_vma>
}
80001944:	00000013          	nop
80001948:	00c12083          	lw	ra,12(sp)
8000194c:	00812403          	lw	s0,8(sp)
80001950:	01010113          	addi	sp,sp,16
80001954:	00008067          	ret

80001958 <pgtcreate>:

addr_t* pgtcreate(){
80001958:	fe010113          	addi	sp,sp,-32
8000195c:	00112e23          	sw	ra,28(sp)
80001960:	00812c23          	sw	s0,24(sp)
80001964:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001968:	821ff0ef          	jal	ra,80001188 <palloc>
8000196c:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001970:	fec42783          	lw	a5,-20(s0)
}
80001974:	00078513          	mv	a0,a5
80001978:	01c12083          	lw	ra,28(sp)
8000197c:	01812403          	lw	s0,24(sp)
80001980:	02010113          	addi	sp,sp,32
80001984:	00008067          	ret

80001988 <r_tp>:
static inline uint32 r_tp(){
80001988:	fe010113          	addi	sp,sp,-32
8000198c:	00812e23          	sw	s0,28(sp)
80001990:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001994:	00020793          	mv	a5,tp
80001998:	fef42623          	sw	a5,-20(s0)
    return x;
8000199c:	fec42783          	lw	a5,-20(s0)
}
800019a0:	00078513          	mv	a0,a5
800019a4:	01c12403          	lw	s0,28(sp)
800019a8:	02010113          	addi	sp,sp,32
800019ac:	00008067          	ret

800019b0 <procinit>:
#include "defs.h"
#include "riscv.h"

uint nextpid=0;

void procinit(){
800019b0:	fe010113          	addi	sp,sp,-32
800019b4:	00812e23          	sw	s0,28(sp)
800019b8:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
800019bc:	fe042623          	sw	zero,-20(s0)
800019c0:	0480006f          	j	80001a08 <procinit+0x58>
        p=&proc[i];
800019c4:	fec42703          	lw	a4,-20(s0)
800019c8:	11800793          	li	a5,280
800019cc:	02f70733          	mul	a4,a4,a5
800019d0:	8000d7b7          	lui	a5,0x8000d
800019d4:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
800019d8:	00f707b3          	add	a5,a4,a5
800019dc:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
800019e0:	fec42783          	lw	a5,-20(s0)
800019e4:	00d79793          	slli	a5,a5,0xd
800019e8:	00078713          	mv	a4,a5
800019ec:	c00027b7          	lui	a5,0xc0002
800019f0:	00f70733          	add	a4,a4,a5
800019f4:	fe842783          	lw	a5,-24(s0)
800019f8:	10e7aa23          	sw	a4,276(a5) # c0002114 <memend+0x38002114>
    for(int i=0;i<NPROC;i++){
800019fc:	fec42783          	lw	a5,-20(s0)
80001a00:	00178793          	addi	a5,a5,1
80001a04:	fef42623          	sw	a5,-20(s0)
80001a08:	fec42703          	lw	a4,-20(s0)
80001a0c:	00300793          	li	a5,3
80001a10:	fae7dae3          	bge	a5,a4,800019c4 <procinit+0x14>
    }
}
80001a14:	00000013          	nop
80001a18:	00000013          	nop
80001a1c:	01c12403          	lw	s0,28(sp)
80001a20:	02010113          	addi	sp,sp,32
80001a24:	00008067          	ret

80001a28 <nowproc>:

struct pcb* nowproc(){
80001a28:	fe010113          	addi	sp,sp,-32
80001a2c:	00112e23          	sw	ra,28(sp)
80001a30:	00812c23          	sw	s0,24(sp)
80001a34:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80001a38:	f51ff0ef          	jal	ra,80001988 <r_tp>
80001a3c:	00050793          	mv	a5,a0
80001a40:	fef42623          	sw	a5,-20(s0)
    return cpu[hart].proc;
80001a44:	8000e7b7          	lui	a5,0x8000e
80001a48:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001a4c:	fec42783          	lw	a5,-20(s0)
80001a50:	00379793          	slli	a5,a5,0x3
80001a54:	00f707b3          	add	a5,a4,a5
80001a58:	0007a783          	lw	a5,0(a5)
}
80001a5c:	00078513          	mv	a0,a5
80001a60:	01c12083          	lw	ra,28(sp)
80001a64:	01812403          	lw	s0,24(sp)
80001a68:	02010113          	addi	sp,sp,32
80001a6c:	00008067          	ret

80001a70 <pidalloc>:

uint pidalloc(){
80001a70:	ff010113          	addi	sp,sp,-16
80001a74:	00812623          	sw	s0,12(sp)
80001a78:	01010413          	addi	s0,sp,16
    return nextpid++;
80001a7c:	8000d7b7          	lui	a5,0x8000d
80001a80:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
80001a84:	00178693          	addi	a3,a5,1
80001a88:	8000d737          	lui	a4,0x8000d
80001a8c:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
} 
80001a90:	00078513          	mv	a0,a5
80001a94:	00c12403          	lw	s0,12(sp)
80001a98:	01010113          	addi	sp,sp,16
80001a9c:	00008067          	ret

80001aa0 <procalloc>:

struct pcb* procalloc(){
80001aa0:	fe010113          	addi	sp,sp,-32
80001aa4:	00112e23          	sw	ra,28(sp)
80001aa8:	00812c23          	sw	s0,24(sp)
80001aac:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80001ab0:	8000d7b7          	lui	a5,0x8000d
80001ab4:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001ab8:	fef42623          	sw	a5,-20(s0)
80001abc:	0680006f          	j	80001b24 <procalloc+0x84>
        if(p->status==UNUSED){
80001ac0:	fec42783          	lw	a5,-20(s0)
80001ac4:	0047a783          	lw	a5,4(a5)
80001ac8:	04079863          	bnez	a5,80001b18 <procalloc+0x78>
            p->pid=pidalloc();
80001acc:	fa5ff0ef          	jal	ra,80001a70 <pidalloc>
80001ad0:	00050793          	mv	a5,a0
80001ad4:	00078713          	mv	a4,a5
80001ad8:	fec42783          	lw	a5,-20(s0)
80001adc:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80001ae0:	fec42783          	lw	a5,-20(s0)
80001ae4:	00100713          	li	a4,1
80001ae8:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
80001aec:	e6dff0ef          	jal	ra,80001958 <pgtcreate>
80001af0:	00050713          	mv	a4,a0
80001af4:	fec42783          	lw	a5,-20(s0)
80001af8:	10e7a823          	sw	a4,272(a5)
            
            p->trapframe.epc=0;
80001afc:	fec42783          	lw	a5,-20(s0)
80001b00:	0007aa23          	sw	zero,20(a5)
            p->trapframe.sp=KSPACE;
80001b04:	fec42783          	lw	a5,-20(s0)
80001b08:	c0000737          	lui	a4,0xc0000
80001b0c:	00e7ae23          	sw	a4,28(a5)

            return p;
80001b10:	fec42783          	lw	a5,-20(s0)
80001b14:	0240006f          	j	80001b38 <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
80001b18:	fec42783          	lw	a5,-20(s0)
80001b1c:	11878793          	addi	a5,a5,280
80001b20:	fef42623          	sw	a5,-20(s0)
80001b24:	fec42703          	lw	a4,-20(s0)
80001b28:	8000e7b7          	lui	a5,0x8000e
80001b2c:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001b30:	f8f768e3          	bltu	a4,a5,80001ac0 <procalloc+0x20>
        }
    }
    return 0;
80001b34:	00000793          	li	a5,0
}
80001b38:	00078513          	mv	a0,a5
80001b3c:	01c12083          	lw	ra,28(sp)
80001b40:	01812403          	lw	s0,24(sp)
80001b44:	02010113          	addi	sp,sp,32
80001b48:	00008067          	ret

80001b4c <userinit>:

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
80001b4c:	fe010113          	addi	sp,sp,-32
80001b50:	00112e23          	sw	ra,28(sp)
80001b54:	00812c23          	sw	s0,24(sp)
80001b58:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80001b5c:	f45ff0ef          	jal	ra,80001aa0 <procalloc>
80001b60:	fea42623          	sw	a0,-20(s0)
    
    char* m=(char*)palloc();
80001b64:	e24ff0ef          	jal	ra,80001188 <palloc>
80001b68:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80001b6c:	00400613          	li	a2,4
80001b70:	00000693          	li	a3,0
80001b74:	800047b7          	lui	a5,0x80004
80001b78:	00078593          	mv	a1,a5
80001b7c:	fe842503          	lw	a0,-24(s0)
80001b80:	120000ef          	jal	ra,80001ca0 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X);
80001b84:	fec42783          	lw	a5,-20(s0)
80001b88:	1107a783          	lw	a5,272(a5) # 80004110 <memend+0xf8004110>
80001b8c:	fe842603          	lw	a2,-24(s0)
80001b90:	00e00713          	li	a4,14
80001b94:	000016b7          	lui	a3,0x1
80001b98:	00000593          	li	a1,0
80001b9c:	00078513          	mv	a0,a5
80001ba0:	959ff0ef          	jal	ra,800014f8 <vmmap>

    p->context.sp=KSPACE;
80001ba4:	fec42783          	lw	a5,-20(s0)
80001ba8:	c0000737          	lui	a4,0xc0000
80001bac:	08e7ac23          	sw	a4,152(a5)

    p->status=RUNABLE;
80001bb0:	fec42783          	lw	a5,-20(s0)
80001bb4:	00200713          	li	a4,2
80001bb8:	00e7a223          	sw	a4,4(a5)

    int id=r_tp();
80001bbc:	dcdff0ef          	jal	ra,80001988 <r_tp>
80001bc0:	00050793          	mv	a5,a0
80001bc4:	fef42223          	sw	a5,-28(s0)
    cpu[id].proc=p;
80001bc8:	8000e7b7          	lui	a5,0x8000e
80001bcc:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001bd0:	fe442783          	lw	a5,-28(s0)
80001bd4:	00379793          	slli	a5,a5,0x3
80001bd8:	00f707b3          	add	a5,a4,a5
80001bdc:	fec42703          	lw	a4,-20(s0)
80001be0:	00e7a023          	sw	a4,0(a5)
}
80001be4:	00000013          	nop
80001be8:	01c12083          	lw	ra,28(sp)
80001bec:	01812403          	lw	s0,24(sp)
80001bf0:	02010113          	addi	sp,sp,32
80001bf4:	00008067          	ret

80001bf8 <schedule>:

void schedule(){
80001bf8:	fe010113          	addi	sp,sp,-32
80001bfc:	00812e23          	sw	s0,28(sp)
80001c00:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
80001c04:	8000d7b7          	lui	a5,0x8000d
80001c08:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001c0c:	fef42623          	sw	a5,-20(s0)
80001c10:	0100006f          	j	80001c20 <schedule+0x28>
80001c14:	fec42783          	lw	a5,-20(s0)
80001c18:	11878793          	addi	a5,a5,280
80001c1c:	fef42623          	sw	a5,-20(s0)
80001c20:	fec42703          	lw	a4,-20(s0)
80001c24:	8000e7b7          	lui	a5,0x8000e
80001c28:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001c2c:	fef764e3          	bltu	a4,a5,80001c14 <schedule+0x1c>
    for(;;){
80001c30:	fd5ff06f          	j	80001c04 <schedule+0xc>

80001c34 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80001c34:	fd010113          	addi	sp,sp,-48
80001c38:	02812623          	sw	s0,44(sp)
80001c3c:	03010413          	addi	s0,sp,48
80001c40:	fca42e23          	sw	a0,-36(s0)
80001c44:	fcb42c23          	sw	a1,-40(s0)
80001c48:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
80001c4c:	fdc42783          	lw	a5,-36(s0)
80001c50:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001c54:	fe042623          	sw	zero,-20(s0)
80001c58:	0280006f          	j	80001c80 <memset+0x4c>
        maddr[i] = (char)c;
80001c5c:	fe842703          	lw	a4,-24(s0)
80001c60:	fec42783          	lw	a5,-20(s0)
80001c64:	00f707b3          	add	a5,a4,a5
80001c68:	fd842703          	lw	a4,-40(s0)
80001c6c:	0ff77713          	andi	a4,a4,255
80001c70:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001c74:	fec42783          	lw	a5,-20(s0)
80001c78:	00178793          	addi	a5,a5,1
80001c7c:	fef42623          	sw	a5,-20(s0)
80001c80:	fec42703          	lw	a4,-20(s0)
80001c84:	fd442783          	lw	a5,-44(s0)
80001c88:	fcf76ae3          	bltu	a4,a5,80001c5c <memset+0x28>
    }
    return addr;
80001c8c:	fdc42783          	lw	a5,-36(s0)
}
80001c90:	00078513          	mv	a0,a5
80001c94:	02c12403          	lw	s0,44(sp)
80001c98:	03010113          	addi	sp,sp,48
80001c9c:	00008067          	ret

80001ca0 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80001ca0:	fd010113          	addi	sp,sp,-48
80001ca4:	02812623          	sw	s0,44(sp)
80001ca8:	03010413          	addi	s0,sp,48
80001cac:	fca42e23          	sw	a0,-36(s0)
80001cb0:	fcb42c23          	sw	a1,-40(s0)
80001cb4:	fcc42823          	sw	a2,-48(s0)
80001cb8:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001cbc:	fd042783          	lw	a5,-48(s0)
80001cc0:	fd442703          	lw	a4,-44(s0)
80001cc4:	00e7e7b3          	or	a5,a5,a4
80001cc8:	00079663          	bnez	a5,80001cd4 <memmove+0x34>
        return dst;
80001ccc:	fdc42783          	lw	a5,-36(s0)
80001cd0:	1200006f          	j	80001df0 <memmove+0x150>
    }

    s = src;
80001cd4:	fd842783          	lw	a5,-40(s0)
80001cd8:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001cdc:	fdc42783          	lw	a5,-36(s0)
80001ce0:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001ce4:	fec42703          	lw	a4,-20(s0)
80001ce8:	fe842783          	lw	a5,-24(s0)
80001cec:	0cf77263          	bgeu	a4,a5,80001db0 <memmove+0x110>
80001cf0:	fd042783          	lw	a5,-48(s0)
80001cf4:	fec42703          	lw	a4,-20(s0)
80001cf8:	00f707b3          	add	a5,a4,a5
80001cfc:	fe842703          	lw	a4,-24(s0)
80001d00:	0af77863          	bgeu	a4,a5,80001db0 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80001d04:	fd042783          	lw	a5,-48(s0)
80001d08:	fec42703          	lw	a4,-20(s0)
80001d0c:	00f707b3          	add	a5,a4,a5
80001d10:	fef42623          	sw	a5,-20(s0)
        d += n;
80001d14:	fd042783          	lw	a5,-48(s0)
80001d18:	fe842703          	lw	a4,-24(s0)
80001d1c:	00f707b3          	add	a5,a4,a5
80001d20:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80001d24:	02c0006f          	j	80001d50 <memmove+0xb0>
            *--d = *--s;
80001d28:	fec42783          	lw	a5,-20(s0)
80001d2c:	fff78793          	addi	a5,a5,-1
80001d30:	fef42623          	sw	a5,-20(s0)
80001d34:	fe842783          	lw	a5,-24(s0)
80001d38:	fff78793          	addi	a5,a5,-1
80001d3c:	fef42423          	sw	a5,-24(s0)
80001d40:	fec42783          	lw	a5,-20(s0)
80001d44:	0007c703          	lbu	a4,0(a5)
80001d48:	fe842783          	lw	a5,-24(s0)
80001d4c:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80001d50:	fd042703          	lw	a4,-48(s0)
80001d54:	fd442783          	lw	a5,-44(s0)
80001d58:	fff00513          	li	a0,-1
80001d5c:	fff00593          	li	a1,-1
80001d60:	00a70633          	add	a2,a4,a0
80001d64:	00060813          	mv	a6,a2
80001d68:	00e83833          	sltu	a6,a6,a4
80001d6c:	00b786b3          	add	a3,a5,a1
80001d70:	00d805b3          	add	a1,a6,a3
80001d74:	00058693          	mv	a3,a1
80001d78:	fcc42823          	sw	a2,-48(s0)
80001d7c:	fcd42a23          	sw	a3,-44(s0)
80001d80:	00070693          	mv	a3,a4
80001d84:	00f6e6b3          	or	a3,a3,a5
80001d88:	fa0690e3          	bnez	a3,80001d28 <memmove+0x88>
    if(s < d && s + n > d){     
80001d8c:	0600006f          	j	80001dec <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80001d90:	fec42703          	lw	a4,-20(s0)
80001d94:	00170793          	addi	a5,a4,1 # c0000001 <memend+0x38000001>
80001d98:	fef42623          	sw	a5,-20(s0)
80001d9c:	fe842783          	lw	a5,-24(s0)
80001da0:	00178693          	addi	a3,a5,1
80001da4:	fed42423          	sw	a3,-24(s0)
80001da8:	00074703          	lbu	a4,0(a4)
80001dac:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80001db0:	fd042703          	lw	a4,-48(s0)
80001db4:	fd442783          	lw	a5,-44(s0)
80001db8:	fff00513          	li	a0,-1
80001dbc:	fff00593          	li	a1,-1
80001dc0:	00a70633          	add	a2,a4,a0
80001dc4:	00060813          	mv	a6,a2
80001dc8:	00e83833          	sltu	a6,a6,a4
80001dcc:	00b786b3          	add	a3,a5,a1
80001dd0:	00d805b3          	add	a1,a6,a3
80001dd4:	00058693          	mv	a3,a1
80001dd8:	fcc42823          	sw	a2,-48(s0)
80001ddc:	fcd42a23          	sw	a3,-44(s0)
80001de0:	00070693          	mv	a3,a4
80001de4:	00f6e6b3          	or	a3,a3,a5
80001de8:	fa0694e3          	bnez	a3,80001d90 <memmove+0xf0>
        }
    }
    return dst;
80001dec:	fdc42783          	lw	a5,-36(s0)
}
80001df0:	00078513          	mv	a0,a5
80001df4:	02c12403          	lw	s0,44(sp)
80001df8:	03010113          	addi	sp,sp,48
80001dfc:	00008067          	ret

80001e00 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80001e00:	fd010113          	addi	sp,sp,-48
80001e04:	02812623          	sw	s0,44(sp)
80001e08:	03010413          	addi	s0,sp,48
80001e0c:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80001e10:	00000793          	li	a5,0
80001e14:	00000813          	li	a6,0
80001e18:	fef42423          	sw	a5,-24(s0)
80001e1c:	ff042623          	sw	a6,-20(s0)
80001e20:	0340006f          	j	80001e54 <strlen+0x54>
80001e24:	fe842603          	lw	a2,-24(s0)
80001e28:	fec42683          	lw	a3,-20(s0)
80001e2c:	00100513          	li	a0,1
80001e30:	00000593          	li	a1,0
80001e34:	00a60733          	add	a4,a2,a0
80001e38:	00070813          	mv	a6,a4
80001e3c:	00c83833          	sltu	a6,a6,a2
80001e40:	00b687b3          	add	a5,a3,a1
80001e44:	00f806b3          	add	a3,a6,a5
80001e48:	00068793          	mv	a5,a3
80001e4c:	fee42423          	sw	a4,-24(s0)
80001e50:	fef42623          	sw	a5,-20(s0)
80001e54:	fe842783          	lw	a5,-24(s0)
80001e58:	fdc42703          	lw	a4,-36(s0)
80001e5c:	00f707b3          	add	a5,a4,a5
80001e60:	0007c783          	lbu	a5,0(a5)
80001e64:	fc0790e3          	bnez	a5,80001e24 <strlen+0x24>
    
    return n;
80001e68:	fe842703          	lw	a4,-24(s0)
80001e6c:	fec42783          	lw	a5,-20(s0)
80001e70:	00070513          	mv	a0,a4
80001e74:	00078593          	mv	a1,a5
80001e78:	02c12403          	lw	s0,44(sp)
80001e7c:	03010113          	addi	sp,sp,48
80001e80:	00008067          	ret

80001e84 <r_tp>:
static inline uint32 r_tp(){
80001e84:	fe010113          	addi	sp,sp,-32
80001e88:	00812e23          	sw	s0,28(sp)
80001e8c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001e90:	00020793          	mv	a5,tp
80001e94:	fef42623          	sw	a5,-20(s0)
    return x;
80001e98:	fec42783          	lw	a5,-20(s0)
}
80001e9c:	00078513          	mv	a0,a5
80001ea0:	01c12403          	lw	s0,28(sp)
80001ea4:	02010113          	addi	sp,sp,32
80001ea8:	00008067          	ret

80001eac <clintinit>:
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit(){
80001eac:	fe010113          	addi	sp,sp,-32
80001eb0:	00112e23          	sw	ra,28(sp)
80001eb4:	00812c23          	sw	s0,24(sp)
80001eb8:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp 
    int hart=r_tp();
80001ebc:	fc9ff0ef          	jal	ra,80001e84 <r_tp>
80001ec0:	00050793          	mv	a5,a0
80001ec4:	fef42623          	sw	a5,-20(s0)
    *(reg_t*)CLINT_MTIMECMP(hart)=*(reg_t*)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
80001ec8:	fec42703          	lw	a4,-20(s0)
80001ecc:	008017b7          	lui	a5,0x801
80001ed0:	00f707b3          	add	a5,a4,a5
80001ed4:	00279793          	slli	a5,a5,0x2
80001ed8:	0007a703          	lw	a4,0(a5) # 801000 <sz+0x800000>
80001edc:	fec42683          	lw	a3,-20(s0)
80001ee0:	008017b7          	lui	a5,0x801
80001ee4:	00f687b3          	add	a5,a3,a5
80001ee8:	00279793          	slli	a5,a5,0x2
80001eec:	00078693          	mv	a3,a5
80001ef0:	009897b7          	lui	a5,0x989
80001ef4:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80001ef8:	00f707b3          	add	a5,a4,a5
80001efc:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
80001f00:	00000013          	nop
80001f04:	01c12083          	lw	ra,28(sp)
80001f08:	01812403          	lw	s0,24(sp)
80001f0c:	02010113          	addi	sp,sp,32
80001f10:	00008067          	ret

80001f14 <r_mstatus>:
static inline uint32 r_mstatus(){
80001f14:	fe010113          	addi	sp,sp,-32
80001f18:	00812e23          	sw	s0,28(sp)
80001f1c:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80001f20:	300027f3          	csrr	a5,mstatus
80001f24:	fef42623          	sw	a5,-20(s0)
    return x;
80001f28:	fec42783          	lw	a5,-20(s0)
}
80001f2c:	00078513          	mv	a0,a5
80001f30:	01c12403          	lw	s0,28(sp)
80001f34:	02010113          	addi	sp,sp,32
80001f38:	00008067          	ret

80001f3c <w_mstatus>:
static inline void w_mstatus(uint32 x){
80001f3c:	fe010113          	addi	sp,sp,-32
80001f40:	00812e23          	sw	s0,28(sp)
80001f44:	02010413          	addi	s0,sp,32
80001f48:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80001f4c:	fec42783          	lw	a5,-20(s0)
80001f50:	30079073          	csrw	mstatus,a5
}
80001f54:	00000013          	nop
80001f58:	01c12403          	lw	s0,28(sp)
80001f5c:	02010113          	addi	sp,sp,32
80001f60:	00008067          	ret

80001f64 <w_mtvec>:
static inline void w_mtvec(uint32 x){
80001f64:	fe010113          	addi	sp,sp,-32
80001f68:	00812e23          	sw	s0,28(sp)
80001f6c:	02010413          	addi	s0,sp,32
80001f70:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0" : : "r"(x));
80001f74:	fec42783          	lw	a5,-20(s0)
80001f78:	30579073          	csrw	mtvec,a5
}
80001f7c:	00000013          	nop
80001f80:	01c12403          	lw	s0,28(sp)
80001f84:	02010113          	addi	sp,sp,32
80001f88:	00008067          	ret

80001f8c <r_tp>:
static inline uint32 r_tp(){
80001f8c:	fe010113          	addi	sp,sp,-32
80001f90:	00812e23          	sw	s0,28(sp)
80001f94:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001f98:	00020793          	mv	a5,tp
80001f9c:	fef42623          	sw	a5,-20(s0)
    return x;
80001fa0:	fec42783          	lw	a5,-20(s0)
}
80001fa4:	00078513          	mv	a0,a5
80001fa8:	01c12403          	lw	s0,28(sp)
80001fac:	02010113          	addi	sp,sp,32
80001fb0:	00008067          	ret

80001fb4 <s_mstatus_intr>:
static inline void s_mstatus_intr(uint32 m){
80001fb4:	fd010113          	addi	sp,sp,-48
80001fb8:	02112623          	sw	ra,44(sp)
80001fbc:	02812423          	sw	s0,40(sp)
80001fc0:	03010413          	addi	s0,sp,48
80001fc4:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80001fc8:	f4dff0ef          	jal	ra,80001f14 <r_mstatus>
80001fcc:	fea42623          	sw	a0,-20(s0)
    switch (m)
80001fd0:	fdc42703          	lw	a4,-36(s0)
80001fd4:	08000793          	li	a5,128
80001fd8:	04f70263          	beq	a4,a5,8000201c <s_mstatus_intr+0x68>
80001fdc:	fdc42703          	lw	a4,-36(s0)
80001fe0:	08000793          	li	a5,128
80001fe4:	0ae7e463          	bltu	a5,a4,8000208c <s_mstatus_intr+0xd8>
80001fe8:	fdc42703          	lw	a4,-36(s0)
80001fec:	02000793          	li	a5,32
80001ff0:	04f70463          	beq	a4,a5,80002038 <s_mstatus_intr+0x84>
80001ff4:	fdc42703          	lw	a4,-36(s0)
80001ff8:	02000793          	li	a5,32
80001ffc:	08e7e863          	bltu	a5,a4,8000208c <s_mstatus_intr+0xd8>
80002000:	fdc42703          	lw	a4,-36(s0)
80002004:	00200793          	li	a5,2
80002008:	06f70463          	beq	a4,a5,80002070 <s_mstatus_intr+0xbc>
8000200c:	fdc42703          	lw	a4,-36(s0)
80002010:	00800793          	li	a5,8
80002014:	04f70063          	beq	a4,a5,80002054 <s_mstatus_intr+0xa0>
        break;
80002018:	0740006f          	j	8000208c <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
8000201c:	fec42783          	lw	a5,-20(s0)
80002020:	f7f7f793          	andi	a5,a5,-129
80002024:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
80002028:	fec42783          	lw	a5,-20(s0)
8000202c:	0807e793          	ori	a5,a5,128
80002030:	fef42623          	sw	a5,-20(s0)
        break;
80002034:	05c0006f          	j	80002090 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
80002038:	fec42783          	lw	a5,-20(s0)
8000203c:	fdf7f793          	andi	a5,a5,-33
80002040:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
80002044:	fec42783          	lw	a5,-20(s0)
80002048:	0207e793          	ori	a5,a5,32
8000204c:	fef42623          	sw	a5,-20(s0)
        break;
80002050:	0400006f          	j	80002090 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
80002054:	fec42783          	lw	a5,-20(s0)
80002058:	ff77f793          	andi	a5,a5,-9
8000205c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80002060:	fec42783          	lw	a5,-20(s0)
80002064:	0087e793          	ori	a5,a5,8
80002068:	fef42623          	sw	a5,-20(s0)
        break;
8000206c:	0240006f          	j	80002090 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80002070:	fec42783          	lw	a5,-20(s0)
80002074:	ffd7f793          	andi	a5,a5,-3
80002078:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
8000207c:	fec42783          	lw	a5,-20(s0)
80002080:	0027e793          	ori	a5,a5,2
80002084:	fef42623          	sw	a5,-20(s0)
        break;
80002088:	0080006f          	j	80002090 <s_mstatus_intr+0xdc>
        break;
8000208c:	00000013          	nop
    w_mstatus(x);
80002090:	fec42503          	lw	a0,-20(s0)
80002094:	ea9ff0ef          	jal	ra,80001f3c <w_mstatus>
}
80002098:	00000013          	nop
8000209c:	02c12083          	lw	ra,44(sp)
800020a0:	02812403          	lw	s0,40(sp)
800020a4:	03010113          	addi	sp,sp,48
800020a8:	00008067          	ret

800020ac <r_mie>:
#define MEIE (1<<11)
#define MTIE (1<<7)
#define MSIE (1<<3)
static inline uint32 r_mie(){
800020ac:	fe010113          	addi	sp,sp,-32
800020b0:	00812e23          	sw	s0,28(sp)
800020b4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie " : "=r"(x));
800020b8:	304027f3          	csrr	a5,mie
800020bc:	fef42623          	sw	a5,-20(s0)
    return x;
800020c0:	fec42783          	lw	a5,-20(s0)
}
800020c4:	00078513          	mv	a0,a5
800020c8:	01c12403          	lw	s0,28(sp)
800020cc:	02010113          	addi	sp,sp,32
800020d0:	00008067          	ret

800020d4 <w_mie>:
static inline void w_mie(uint32 x){
800020d4:	fe010113          	addi	sp,sp,-32
800020d8:	00812e23          	sw	s0,28(sp)
800020dc:	02010413          	addi	s0,sp,32
800020e0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"::"r"(x));
800020e4:	fec42783          	lw	a5,-20(s0)
800020e8:	30479073          	csrw	mie,a5
}
800020ec:	00000013          	nop
800020f0:	01c12403          	lw	s0,28(sp)
800020f4:	02010113          	addi	sp,sp,32
800020f8:	00008067          	ret

800020fc <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x){
800020fc:	fe010113          	addi	sp,sp,-32
80002100:	00812e23          	sw	s0,28(sp)
80002104:	02010413          	addi	s0,sp,32
80002108:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0" : :"r"(x));
8000210c:	fec42783          	lw	a5,-20(s0)
80002110:	34079073          	csrw	mscratch,a5
80002114:	00000013          	nop
80002118:	01c12403          	lw	s0,28(sp)
8000211c:	02010113          	addi	sp,sp,32
80002120:	00008067          	ret

80002124 <timerinit>:

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint32 timer_sscartch[NCPUS][5];

void timerinit(){
80002124:	fe010113          	addi	sp,sp,-32
80002128:	00112e23          	sw	ra,28(sp)
8000212c:	00812c23          	sw	s0,24(sp)
80002130:	02010413          	addi	s0,sp,32
    uint hart=r_tp();
80002134:	e59ff0ef          	jal	ra,80001f8c <r_tp>
80002138:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
8000213c:	fec42703          	lw	a4,-20(s0)
80002140:	00070793          	mv	a5,a4
80002144:	00279793          	slli	a5,a5,0x2
80002148:	00e787b3          	add	a5,a5,a4
8000214c:	00279793          	slli	a5,a5,0x2
80002150:	8000e737          	lui	a4,0x8000e
80002154:	8ac70713          	addi	a4,a4,-1876 # 8000d8ac <memend+0xf800d8ac>
80002158:	00e787b3          	add	a5,a5,a4
8000215c:	00078513          	mv	a0,a5
80002160:	f9dff0ef          	jal	ra,800020fc <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
80002164:	fec42703          	lw	a4,-20(s0)
80002168:	008017b7          	lui	a5,0x801
8000216c:	00f707b3          	add	a5,a4,a5
80002170:	00279693          	slli	a3,a5,0x2
80002174:	8000e7b7          	lui	a5,0x8000e
80002178:	8ac78613          	addi	a2,a5,-1876 # 8000d8ac <memend+0xf800d8ac>
8000217c:	fec42703          	lw	a4,-20(s0)
80002180:	00070793          	mv	a5,a4
80002184:	00279793          	slli	a5,a5,0x2
80002188:	00e787b3          	add	a5,a5,a4
8000218c:	00279793          	slli	a5,a5,0x2
80002190:	00f607b3          	add	a5,a2,a5
80002194:	00d7a023          	sw	a3,0(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;
80002198:	8000e7b7          	lui	a5,0x8000e
8000219c:	8ac78693          	addi	a3,a5,-1876 # 8000d8ac <memend+0xf800d8ac>
800021a0:	fec42703          	lw	a4,-20(s0)
800021a4:	00070793          	mv	a5,a4
800021a8:	00279793          	slli	a5,a5,0x2
800021ac:	00e787b3          	add	a5,a5,a4
800021b0:	00279793          	slli	a5,a5,0x2
800021b4:	00f687b3          	add	a5,a3,a5
800021b8:	00989737          	lui	a4,0x989
800021bc:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
800021c0:	00e7a223          	sw	a4,4(a5)

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数
800021c4:	800007b7          	lui	a5,0x80000
800021c8:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
800021cc:	00078513          	mv	a0,a5
800021d0:	d95ff0ef          	jal	ra,80001f64 <w_mtvec>

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断
800021d4:	00800513          	li	a0,8
800021d8:	dddff0ef          	jal	ra,80001fb4 <s_mstatus_intr>

    w_mie(r_mie() | MTIE);      // 开启 M-mode 中断
800021dc:	ed1ff0ef          	jal	ra,800020ac <r_mie>
800021e0:	00050793          	mv	a5,a0
800021e4:	0807e793          	ori	a5,a5,128
800021e8:	00078513          	mv	a0,a5
800021ec:	ee9ff0ef          	jal	ra,800020d4 <w_mie>

    // clintinit();                
800021f0:	00000013          	nop
800021f4:	01c12083          	lw	ra,28(sp)
800021f8:	01812403          	lw	s0,24(sp)
800021fc:	02010113          	addi	sp,sp,32
80002200:	00008067          	ret
