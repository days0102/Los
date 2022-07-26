
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
#include "clint.h"

.global kvec
kvec:
    // 利用栈空间保存寄存器状态
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
800000ac:	215000ef          	jal	ra,80000ac0 <trapvec>

    // 恢复寄存器状态
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
// riscv 时钟中断产生在 M-mode 
tvec:     // 时钟中断处理
    // timerinit()将mscratch指向time_scartch
    csrrw a0,mscratch,a0   
80000134:	34051573          	csrrw	a0,mscratch,a0
    // 后面要使用 t1,t1,t3,t4,t5 ,先保存
    sw t0,4*4(a0)
80000138:	00552823          	sw	t0,16(a0)
    sw t1,5*4(a0)
8000013c:	00652a23          	sw	t1,20(a0)
    sw t2,6*4(a0)
80000140:	00752c23          	sw	t2,24(a0)
    sw t3,7*4(a0)
80000144:	01c52e23          	sw	t3,28(a0)
    sw t4,8*4(a0)
80000148:	03d52023          	sw	t4,32(a0)
    sw t5,9*4(a0)
8000014c:	03e52223          	sw	t5,36(a0)

    lw t0,0(a0)     // CLINT_MTIMECMP(hart)
80000150:	00052283          	lw	t0,0(a0)
    lw t1,8(a0)     // CLINT_INTERVAL 10000000
80000154:	00852303          	lw	t1,8(a0)
    // CLINT_MTIMECMP 8byte 用两个寄存器存
    lw t2,0(t0)     // *CLINT_MTIMECMP(hart) 0~3byte
80000158:	0002a383          	lw	t2,0(t0)
    lw t3,4(t0)     // *CLINT_MTIMECMP(hart) 4~7byte
8000015c:	0042ae03          	lw	t3,4(t0)

    add t4,t2,t1    // 低位相加
80000160:	00638eb3          	add	t4,t2,t1
    sltu t5,t4,t2   // 处理进位，t4小于t2则t5为1
80000164:	007ebf33          	sltu	t5,t4,t2
    add t3,t3,t5    // 高位加进位
80000168:	01ee0e33          	add	t3,t3,t5
    mv t2,t4        // t2=t2+t1
8000016c:	000e8393          	mv	t2,t4

    sw t2,0(t0)
80000170:	0072a023          	sw	t2,0(t0)
    sw t3,4(t0)
80000174:	01c2a223          	sw	t3,4(t0)

    // 产生一个 S-mode 软件中断
    // mret 时触发 S-mode 软件中断
    csrwi sip,2
80000178:	14415073          	csrwi	sip,2

    // 恢复寄存器状态
    lw t0,4*4(a0)
8000017c:	01052283          	lw	t0,16(a0)
    lw t1,5*4(a0)
80000180:	01452303          	lw	t1,20(a0)
    lw t2,6*4(a0)
80000184:	01852383          	lw	t2,24(a0)
    lw t3,7*4(a0)
80000188:	01c52e03          	lw	t3,28(a0)
    lw t4,8*4(a0)
8000018c:	02052e83          	lw	t4,32(a0)
    lw t5,9*4(a0)
80000190:	02452f03          	lw	t5,36(a0)

    csrrw a0,mscratch,a0
80000194:	34051573          	csrrw	a0,mscratch,a0

80000198:	30200073          	mret

8000019c <swtch>:
// swtch(struct context* old,struct context* new)
// 保存 old,加载 new ; old->a0,new->a1

.global swtch
swtch:
    sw ra,0(a0)
8000019c:	00152023          	sw	ra,0(a0)
    sw sp,4(a0)
800001a0:	00252223          	sw	sp,4(a0)
    sw gp,8(a0)
800001a4:	00352423          	sw	gp,8(a0)
    sw tp,12(a0)
800001a8:	00452623          	sw	tp,12(a0)
    sw a0,16(a0)
800001ac:	00a52823          	sw	a0,16(a0)
    sw a1,20(a0)
800001b0:	00b52a23          	sw	a1,20(a0)
    sw a2,24(a0)
800001b4:	00c52c23          	sw	a2,24(a0)
    sw a3,28(a0)
800001b8:	00d52e23          	sw	a3,28(a0)
    sw a4,32(a0)
800001bc:	02e52023          	sw	a4,32(a0)
    sw a5,36(a0)
800001c0:	02f52223          	sw	a5,36(a0)
    sw a6,40(a0)
800001c4:	03052423          	sw	a6,40(a0)
    sw a7,44(a0)
800001c8:	03152623          	sw	a7,44(a0)
    sw s0,48(a0)
800001cc:	02852823          	sw	s0,48(a0)
    sw s1,52(a0)
800001d0:	02952a23          	sw	s1,52(a0)
    sw s2,56(a0)
800001d4:	03252c23          	sw	s2,56(a0)
    sw s3,60(a0)
800001d8:	03352e23          	sw	s3,60(a0)
    sw s4,64(a0)
800001dc:	05452023          	sw	s4,64(a0)
    sw s5,68(a0)
800001e0:	05552223          	sw	s5,68(a0)
    sw s6,72(a0)
800001e4:	05652423          	sw	s6,72(a0)
    sw s7,76(a0)
800001e8:	05752623          	sw	s7,76(a0)
    sw s8,80(a0)
800001ec:	05852823          	sw	s8,80(a0)
    sw s9,84(a0)
800001f0:	05952a23          	sw	s9,84(a0)
    sw s10,88(a0)
800001f4:	05a52c23          	sw	s10,88(a0)
    sw s11,92(a0)
800001f8:	05b52e23          	sw	s11,92(a0)
    sw t0,96(a0)
800001fc:	06552023          	sw	t0,96(a0)
    sw t1,100(a0)
80000200:	06652223          	sw	t1,100(a0)
    sw t2,104(a0)
80000204:	06752423          	sw	t2,104(a0)
    sw t3,108(a0)
80000208:	07c52623          	sw	t3,108(a0)
    sw t4,112(a0)
8000020c:	07d52823          	sw	t4,112(a0)
    sw t5,116(a0)
80000210:	07e52a23          	sw	t5,116(a0)
    sw t6,120(a0)
80000214:	07f52c23          	sw	t6,120(a0)


    lw ra,0(a1)
80000218:	0005a083          	lw	ra,0(a1)
    lw sp,4(a1)
8000021c:	0045a103          	lw	sp,4(a1)
    lw gp,8(a1)
80000220:	0085a183          	lw	gp,8(a1)
    lw tp,12(a1)
80000224:	00c5a203          	lw	tp,12(a1)
    lw a0,16(a1)
80000228:	0105a503          	lw	a0,16(a1)
    // a1
    lw a2,24(a1)
8000022c:	0185a603          	lw	a2,24(a1)
    lw a3,28(a1)
80000230:	01c5a683          	lw	a3,28(a1)
    lw a4,32(a1)
80000234:	0205a703          	lw	a4,32(a1)
    lw a5,36(a1)
80000238:	0245a783          	lw	a5,36(a1)
    lw a6,40(a1)
8000023c:	0285a803          	lw	a6,40(a1)
    lw a7,44(a1)
80000240:	02c5a883          	lw	a7,44(a1)
    lw s0,48(a1)
80000244:	0305a403          	lw	s0,48(a1)
    lw s1,52(a1)
80000248:	0345a483          	lw	s1,52(a1)
    lw s2,56(a1)
8000024c:	0385a903          	lw	s2,56(a1)
    lw s3,60(a1)
80000250:	03c5a983          	lw	s3,60(a1)
    lw s4,64(a1)
80000254:	0405aa03          	lw	s4,64(a1)
    lw s5,68(a1)
80000258:	0445aa83          	lw	s5,68(a1)
    lw s6,72(a1)
8000025c:	0485ab03          	lw	s6,72(a1)
    lw s7,76(a1)
80000260:	04c5ab83          	lw	s7,76(a1)
    lw s8,80(a1)
80000264:	0505ac03          	lw	s8,80(a1)
    lw s9,84(a1)
80000268:	0545ac83          	lw	s9,84(a1)
    lw s10,88(a1)
8000026c:	0585ad03          	lw	s10,88(a1)
    lw s11,92(a1)
80000270:	05c5ad83          	lw	s11,92(a1)
    lw t0,96(a1)
80000274:	0605a283          	lw	t0,96(a1)
    lw t1,100(a1)
80000278:	0645a303          	lw	t1,100(a1)
    lw t2,104(a1)
8000027c:	0685a383          	lw	t2,104(a1)
    lw t3,108(a1)
80000280:	06c5ae03          	lw	t3,108(a1)
    lw t4,112(a1)
80000284:	0705ae83          	lw	t4,112(a1)
    lw t5,116(a1)
80000288:	0745af03          	lw	t5,116(a1)
    lw t6,120(a1)
8000028c:	0785af83          	lw	t6,120(a1)

    lw a1,20(a1)
80000290:	0145a583          	lw	a1,20(a1)

80000294:	00008067          	ret

80000298 <saveframe>:

.global usertrap
usertrap:
.global saveframe
saveframe:
    sw ra,16(a0)
80000298:	00152823          	sw	ra,16(a0)
    sw sp,20(a0)
8000029c:	00252a23          	sw	sp,20(a0)
    sw gp,24(a0)
800002a0:	00352c23          	sw	gp,24(a0)
    sw tp,28(a0)
800002a4:	00452e23          	sw	tp,28(a0)
    sw a0,32(a0)
800002a8:	02a52023          	sw	a0,32(a0)
    sw a1,36(a0)
800002ac:	02b52223          	sw	a1,36(a0)
    sw a2,40(a0)
800002b0:	02c52423          	sw	a2,40(a0)
    sw a3,44(a0)
800002b4:	02d52623          	sw	a3,44(a0)
    sw a4,48(a0)
800002b8:	02e52823          	sw	a4,48(a0)
    sw a5,52(a0)
800002bc:	02f52a23          	sw	a5,52(a0)
    sw a6,56(a0)
800002c0:	03052c23          	sw	a6,56(a0)
    sw a5,52(a0)
800002c4:	02f52a23          	sw	a5,52(a0)
    sw a7,60(a0)
800002c8:	03152e23          	sw	a7,60(a0)
    sw s0,64(a0)
800002cc:	04852023          	sw	s0,64(a0)
    sw s1,68(a0)
800002d0:	04952223          	sw	s1,68(a0)
    sw s2,72(a0)
800002d4:	05252423          	sw	s2,72(a0)
    sw s3,76(a0)
800002d8:	05352623          	sw	s3,76(a0)
    sw s4,80(a0)
800002dc:	05452823          	sw	s4,80(a0)
    sw s5,84(a0)
800002e0:	05552a23          	sw	s5,84(a0)
    sw s6,88(a0)
800002e4:	05652c23          	sw	s6,88(a0)
    sw s7,92(a0)
800002e8:	05752e23          	sw	s7,92(a0)
    sw s8,96(a0)
800002ec:	07852023          	sw	s8,96(a0)
    sw s9,100(a0)
800002f0:	07952223          	sw	s9,100(a0)
    sw s10,104(a0)
800002f4:	07a52423          	sw	s10,104(a0)
    sw s11,108(a0)
800002f8:	07b52623          	sw	s11,108(a0)
    sw t0,112(a0)
800002fc:	06552823          	sw	t0,112(a0)
    sw t1,116(a0)
80000300:	06652a23          	sw	t1,116(a0)
    sw t2,120(a0)
80000304:	06752c23          	sw	t2,120(a0)
    sw t3,124(a0)
80000308:	07c52e23          	sw	t3,124(a0)
    sw t4,128(a0)
8000030c:	09d52023          	sw	t4,128(a0)
    sw t5,132(a0)
80000310:	09e52223          	sw	t5,132(a0)
    sw t6,136(a0)
80000314:	09f52423          	sw	t6,136(a0)

    ret
80000318:	00008067          	ret

8000031c <loadframe>:

#     lw a0,32(a0)
# lw t6,12(a0)
#     csrw sepc,t6

8000031c:	10200073          	sret

80000320 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80000320:	fe010113          	addi	sp,sp,-32
80000324:	00812e23          	sw	s0,28(sp)
80000328:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
8000032c:	300027f3          	csrr	a5,mstatus
80000330:	fef42623          	sw	a5,-20(s0)
    return x;
80000334:	fec42783          	lw	a5,-20(s0)
}
80000338:	00078513          	mv	a0,a5
8000033c:	01c12403          	lw	s0,28(sp)
80000340:	02010113          	addi	sp,sp,32
80000344:	00008067          	ret

80000348 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
80000348:	fe010113          	addi	sp,sp,-32
8000034c:	00812e23          	sw	s0,28(sp)
80000350:	02010413          	addi	s0,sp,32
80000354:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80000358:	fec42783          	lw	a5,-20(s0)
8000035c:	30079073          	csrw	mstatus,a5
}
80000360:	00000013          	nop
80000364:	01c12403          	lw	s0,28(sp)
80000368:	02010113          	addi	sp,sp,32
8000036c:	00008067          	ret

80000370 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000370:	fd010113          	addi	sp,sp,-48
80000374:	02112623          	sw	ra,44(sp)
80000378:	02812423          	sw	s0,40(sp)
8000037c:	03010413          	addi	s0,sp,48
80000380:	00050793          	mv	a5,a0
80000384:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
80000388:	f99ff0ef          	jal	ra,80000320 <r_mstatus>
8000038c:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000390:	fdf44783          	lbu	a5,-33(s0)
80000394:	00300713          	li	a4,3
80000398:	06e78063          	beq	a5,a4,800003f8 <s_mstatus_xpp+0x88>
8000039c:	00300713          	li	a4,3
800003a0:	08f74263          	blt	a4,a5,80000424 <s_mstatus_xpp+0xb4>
800003a4:	00078863          	beqz	a5,800003b4 <s_mstatus_xpp+0x44>
800003a8:	00100713          	li	a4,1
800003ac:	02e78063          	beq	a5,a4,800003cc <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800003b0:	0740006f          	j	80000424 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800003b4:	fec42703          	lw	a4,-20(s0)
800003b8:	ffffe7b7          	lui	a5,0xffffe
800003bc:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800003c0:	00f777b3          	and	a5,a4,a5
800003c4:	fef42623          	sw	a5,-20(s0)
        break;
800003c8:	0600006f          	j	80000428 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800003cc:	fec42703          	lw	a4,-20(s0)
800003d0:	ffffe7b7          	lui	a5,0xffffe
800003d4:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800003d8:	00f777b3          	and	a5,a4,a5
800003dc:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
800003e0:	fec42703          	lw	a4,-20(s0)
800003e4:	000017b7          	lui	a5,0x1
800003e8:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
800003ec:	00f767b3          	or	a5,a4,a5
800003f0:	fef42623          	sw	a5,-20(s0)
        break;
800003f4:	0340006f          	j	80000428 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800003f8:	fec42703          	lw	a4,-20(s0)
800003fc:	ffffe7b7          	lui	a5,0xffffe
80000400:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000404:	00f777b3          	and	a5,a4,a5
80000408:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
8000040c:	fec42703          	lw	a4,-20(s0)
80000410:	000027b7          	lui	a5,0x2
80000414:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
80000418:	00f767b3          	or	a5,a4,a5
8000041c:	fef42623          	sw	a5,-20(s0)
        break;
80000420:	0080006f          	j	80000428 <s_mstatus_xpp+0xb8>
        break;
80000424:	00000013          	nop
    }
    w_mstatus(x);
80000428:	fec42503          	lw	a0,-20(s0)
8000042c:	f1dff0ef          	jal	ra,80000348 <w_mstatus>
}
80000430:	00000013          	nop
80000434:	02c12083          	lw	ra,44(sp)
80000438:	02812403          	lw	s0,40(sp)
8000043c:	03010113          	addi	sp,sp,48
80000440:	00008067          	ret

80000444 <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
80000444:	fe010113          	addi	sp,sp,-32
80000448:	00812e23          	sw	s0,28(sp)
8000044c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000450:	100027f3          	csrr	a5,sstatus
80000454:	fef42623          	sw	a5,-20(s0)
    return x;
80000458:	fec42783          	lw	a5,-20(s0)
}
8000045c:	00078513          	mv	a0,a5
80000460:	01c12403          	lw	s0,28(sp)
80000464:	02010113          	addi	sp,sp,32
80000468:	00008067          	ret

8000046c <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
8000046c:	fe010113          	addi	sp,sp,-32
80000470:	00812e23          	sw	s0,28(sp)
80000474:	02010413          	addi	s0,sp,32
80000478:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
8000047c:	fec42783          	lw	a5,-20(s0)
80000480:	10079073          	csrw	sstatus,a5
}
80000484:	00000013          	nop
80000488:	01c12403          	lw	s0,28(sp)
8000048c:	02010113          	addi	sp,sp,32
80000490:	00008067          	ret

80000494 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
80000494:	fe010113          	addi	sp,sp,-32
80000498:	00812e23          	sw	s0,28(sp)
8000049c:	02010413          	addi	s0,sp,32
800004a0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
800004a4:	fec42783          	lw	a5,-20(s0)
800004a8:	34179073          	csrw	mepc,a5
}
800004ac:	00000013          	nop
800004b0:	01c12403          	lw	s0,28(sp)
800004b4:	02010113          	addi	sp,sp,32
800004b8:	00008067          	ret

800004bc <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
800004bc:	fe010113          	addi	sp,sp,-32
800004c0:	00812e23          	sw	s0,28(sp)
800004c4:	02010413          	addi	s0,sp,32
800004c8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
800004cc:	fec42783          	lw	a5,-20(s0)
800004d0:	10579073          	csrw	stvec,a5
}
800004d4:	00000013          	nop
800004d8:	01c12403          	lw	s0,28(sp)
800004dc:	02010113          	addi	sp,sp,32
800004e0:	00008067          	ret

800004e4 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
800004e4:	fe010113          	addi	sp,sp,-32
800004e8:	00812e23          	sw	s0,28(sp)
800004ec:	02010413          	addi	s0,sp,32
800004f0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
800004f4:	fec42783          	lw	a5,-20(s0)
800004f8:	30379073          	csrw	mideleg,a5
}
800004fc:	00000013          	nop
80000500:	01c12403          	lw	s0,28(sp)
80000504:	02010113          	addi	sp,sp,32
80000508:	00008067          	ret

8000050c <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
8000050c:	fe010113          	addi	sp,sp,-32
80000510:	00812e23          	sw	s0,28(sp)
80000514:	02010413          	addi	s0,sp,32
80000518:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
8000051c:	fec42783          	lw	a5,-20(s0)
80000520:	30279073          	csrw	medeleg,a5
}
80000524:	00000013          	nop
80000528:	01c12403          	lw	s0,28(sp)
8000052c:	02010113          	addi	sp,sp,32
80000530:	00008067          	ret

80000534 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
80000534:	fe010113          	addi	sp,sp,-32
80000538:	00812e23          	sw	s0,28(sp)
8000053c:	02010413          	addi	s0,sp,32
80000540:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80000544:	fec42783          	lw	a5,-20(s0)
80000548:	18079073          	csrw	satp,a5
}
8000054c:	00000013          	nop
80000550:	01c12403          	lw	s0,28(sp)
80000554:	02010113          	addi	sp,sp,32
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
80000570:	ed5ff0ef          	jal	ra,80000444 <r_sstatus>
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
80000604:	e69ff0ef          	jal	ra,8000046c <w_sstatus>
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
8000062c:	07c000ef          	jal	ra,800006a8 <uartinit>
    uartputs("Hello Los!\n");
80000630:	8000c7b7          	lui	a5,0x8000c
80000634:	00078513          	mv	a0,a5
80000638:	164000ef          	jal	ra,8000079c <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
8000063c:	00100513          	li	a0,1
80000640:	d31ff0ef          	jal	ra,80000370 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
80000644:	00000513          	li	a0,0
80000648:	eedff0ef          	jal	ra,80000534 <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
8000064c:	000107b7          	lui	a5,0x10
80000650:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000654:	e91ff0ef          	jal	ra,800004e4 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80000658:	000107b7          	lui	a5,0x10
8000065c:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000660:	eadff0ef          	jal	ra,8000050c <w_medeleg>

    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
80000664:	00200513          	li	a0,2
80000668:	ef5ff0ef          	jal	ra,8000055c <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
8000066c:	800007b7          	lui	a5,0x80000
80000670:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000674:	00078513          	mv	a0,a5
80000678:	e45ff0ef          	jal	ra,800004bc <w_stvec>

    timerinit();                // 时钟定时器
8000067c:	445010ef          	jal	ra,800022c0 <timerinit>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
80000680:	800017b7          	lui	a5,0x80001
80000684:	86878793          	addi	a5,a5,-1944 # 80000868 <memend+0xf8000868>
80000688:	00078513          	mv	a0,a5
8000068c:	e09ff0ef          	jal	ra,80000494 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
80000690:	30200073          	mret
80000694:	00000013          	nop
80000698:	00c12083          	lw	ra,12(sp)
8000069c:	00812403          	lw	s0,8(sp)
800006a0:	01010113          	addi	sp,sp,16
800006a4:	00008067          	ret

800006a8 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
800006a8:	fe010113          	addi	sp,sp,-32
800006ac:	00812e23          	sw	s0,28(sp)
800006b0:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800006b4:	100007b7          	lui	a5,0x10000
800006b8:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800006bc:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800006c0:	100007b7          	lui	a5,0x10000
800006c4:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006c8:	0007c783          	lbu	a5,0(a5)
800006cc:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800006d0:	100007b7          	lui	a5,0x10000
800006d4:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006d8:	fef44703          	lbu	a4,-17(s0)
800006dc:	f8076713          	ori	a4,a4,-128
800006e0:	0ff77713          	andi	a4,a4,255
800006e4:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
800006e8:	100007b7          	lui	a5,0x10000
800006ec:	00300713          	li	a4,3
800006f0:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
800006f4:	100007b7          	lui	a5,0x10000
800006f8:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800006fc:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
80000700:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80000704:	100007b7          	lui	a5,0x10000
80000708:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
8000070c:	fef44703          	lbu	a4,-17(s0)
80000710:	00376713          	ori	a4,a4,3
80000714:	0ff77713          	andi	a4,a4,255
80000718:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
8000071c:	100007b7          	lui	a5,0x10000
80000720:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000724:	0007c783          	lbu	a5,0(a5)
80000728:	0ff7f713          	andi	a4,a5,255
8000072c:	100007b7          	lui	a5,0x10000
80000730:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000734:	00176713          	ori	a4,a4,1
80000738:	0ff77713          	andi	a4,a4,255
8000073c:	00e78023          	sb	a4,0(a5)
}
80000740:	00000013          	nop
80000744:	01c12403          	lw	s0,28(sp)
80000748:	02010113          	addi	sp,sp,32
8000074c:	00008067          	ret

80000750 <uartputc>:

// 轮询处理数据
char uartputc(char c){
80000750:	fe010113          	addi	sp,sp,-32
80000754:	00812e23          	sw	s0,28(sp)
80000758:	02010413          	addi	s0,sp,32
8000075c:	00050793          	mv	a5,a0
80000760:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80000764:	00000013          	nop
80000768:	100007b7          	lui	a5,0x10000
8000076c:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000770:	0007c783          	lbu	a5,0(a5)
80000774:	0ff7f793          	andi	a5,a5,255
80000778:	0207f793          	andi	a5,a5,32
8000077c:	fe0786e3          	beqz	a5,80000768 <uartputc+0x18>
    return uart_write(UART_THR,c);
80000780:	10000737          	lui	a4,0x10000
80000784:	fef44783          	lbu	a5,-17(s0)
80000788:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
8000078c:	00078513          	mv	a0,a5
80000790:	01c12403          	lw	s0,28(sp)
80000794:	02010113          	addi	sp,sp,32
80000798:	00008067          	ret

8000079c <uartputs>:

// 发送字符串
void uartputs(char* s){
8000079c:	fe010113          	addi	sp,sp,-32
800007a0:	00112e23          	sw	ra,28(sp)
800007a4:	00812c23          	sw	s0,24(sp)
800007a8:	02010413          	addi	s0,sp,32
800007ac:	fea42623          	sw	a0,-20(s0)
    while (*s)
800007b0:	01c0006f          	j	800007cc <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
800007b4:	fec42783          	lw	a5,-20(s0)
800007b8:	00178713          	addi	a4,a5,1
800007bc:	fee42623          	sw	a4,-20(s0)
800007c0:	0007c783          	lbu	a5,0(a5)
800007c4:	00078513          	mv	a0,a5
800007c8:	f89ff0ef          	jal	ra,80000750 <uartputc>
    while (*s)
800007cc:	fec42783          	lw	a5,-20(s0)
800007d0:	0007c783          	lbu	a5,0(a5)
800007d4:	fe0790e3          	bnez	a5,800007b4 <uartputs+0x18>
    }
    
}
800007d8:	00000013          	nop
800007dc:	00000013          	nop
800007e0:	01c12083          	lw	ra,28(sp)
800007e4:	01812403          	lw	s0,24(sp)
800007e8:	02010113          	addi	sp,sp,32
800007ec:	00008067          	ret

800007f0 <uartgetc>:

// 接收输入
int uartgetc(){
800007f0:	ff010113          	addi	sp,sp,-16
800007f4:	00812623          	sw	s0,12(sp)
800007f8:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
800007fc:	100007b7          	lui	a5,0x10000
80000800:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000804:	0007c783          	lbu	a5,0(a5)
80000808:	0ff7f793          	andi	a5,a5,255
8000080c:	0017f793          	andi	a5,a5,1
80000810:	00078a63          	beqz	a5,80000824 <uartgetc+0x34>
        return uart_read(UART_RHR);
80000814:	100007b7          	lui	a5,0x10000
80000818:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
8000081c:	0ff7f793          	andi	a5,a5,255
80000820:	0080006f          	j	80000828 <uartgetc+0x38>
    }else{
        return -1;
80000824:	fff00793          	li	a5,-1
    }
}
80000828:	00078513          	mv	a0,a5
8000082c:	00c12403          	lw	s0,12(sp)
80000830:	01010113          	addi	sp,sp,16
80000834:	00008067          	ret

80000838 <uartintr>:

// 键盘输入中断
char uartintr(){
80000838:	ff010113          	addi	sp,sp,-16
8000083c:	00112623          	sw	ra,12(sp)
80000840:	00812423          	sw	s0,8(sp)
80000844:	01010413          	addi	s0,sp,16
    return uartgetc();
80000848:	fa9ff0ef          	jal	ra,800007f0 <uartgetc>
8000084c:	00050793          	mv	a5,a0
80000850:	0ff7f793          	andi	a5,a5,255
80000854:	00078513          	mv	a0,a5
80000858:	00c12083          	lw	ra,12(sp)
8000085c:	00812403          	lw	s0,8(sp)
80000860:	01010113          	addi	sp,sp,16
80000864:	00008067          	ret

80000868 <main>:
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

void main(){
80000868:	ff010113          	addi	sp,sp,-16
8000086c:	00112623          	sw	ra,12(sp)
80000870:	00812423          	sw	s0,8(sp)
80000874:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
80000878:	8000c7b7          	lui	a5,0x8000c
8000087c:	00c78513          	addi	a0,a5,12 # 8000c00c <memend+0xf800c00c>
80000880:	458000ef          	jal	ra,80000cd8 <printf>

    minit();        // 物理内存管理
80000884:	061000ef          	jal	ra,800010e4 <minit>
    plicinit();     // PLIC 中断处理
80000888:	2e1000ef          	jal	ra,80001368 <plicinit>
    
    kvminit();       // 启动虚拟内存
8000088c:	795000ef          	jal	ra,80001820 <kvminit>

    printf("usertrap: %p\n",usertrap);
80000890:	800007b7          	lui	a5,0x80000
80000894:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80000898:	8000c7b7          	lui	a5,0x8000c
8000089c:	02078513          	addi	a0,a5,32 # 8000c020 <memend+0xf800c020>
800008a0:	438000ef          	jal	ra,80000cd8 <printf>

    userinit();
800008a4:	388010ef          	jal	ra,80001c2c <userinit>
    asm volatile("ecall");
800008a8:	00000073          	ecall

    printf("----------------------\n");
800008ac:	8000c7b7          	lui	a5,0x8000c
800008b0:	03078513          	addi	a0,a5,48 # 8000c030 <memend+0xf800c030>
800008b4:	424000ef          	jal	ra,80000cd8 <printf>
    while(1);
800008b8:	0000006f          	j	800008b8 <main+0x50>

800008bc <r_sepc>:

/**
 * @description: 读取 sepc 寄存器
 * S-mode 返回时跳转到 pc = sepc指向的地址
 */
static inline uint32 r_sepc(){
800008bc:	fe010113          	addi	sp,sp,-32
800008c0:	00812e23          	sw	s0,28(sp)
800008c4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sepc" : "=r" (x) );
800008c8:	141027f3          	csrr	a5,sepc
800008cc:	fef42623          	sw	a5,-20(s0)
    return x;
800008d0:	fec42783          	lw	a5,-20(s0)
}
800008d4:	00078513          	mv	a0,a5
800008d8:	01c12403          	lw	s0,28(sp)
800008dc:	02010113          	addi	sp,sp,32
800008e0:	00008067          	ret

800008e4 <w_sepc>:
// 写 sepc寄存器
static inline void w_sepc(uint32 x){
800008e4:	fe010113          	addi	sp,sp,-32
800008e8:	00812e23          	sw	s0,28(sp)
800008ec:	02010413          	addi	s0,sp,32
800008f0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
800008f4:	fec42783          	lw	a5,-20(s0)
800008f8:	14179073          	csrw	sepc,a5
}
800008fc:	00000013          	nop
80000900:	01c12403          	lw	s0,28(sp)
80000904:	02010113          	addi	sp,sp,32
80000908:	00008067          	ret

8000090c <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
8000090c:	fe010113          	addi	sp,sp,-32
80000910:	00812e23          	sw	s0,28(sp)
80000914:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
80000918:	142027f3          	csrr	a5,scause
8000091c:	fef42623          	sw	a5,-20(s0)
    return x;
80000920:	fec42783          	lw	a5,-20(s0)
}
80000924:	00078513          	mv	a0,a5
80000928:	01c12403          	lw	s0,28(sp)
8000092c:	02010113          	addi	sp,sp,32
80000930:	00008067          	ret

80000934 <r_sip>:

/**
 * @description: 
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip(){
80000934:	fe010113          	addi	sp,sp,-32
80000938:	00812e23          	sw	s0,28(sp)
8000093c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip":"=r"(x));
80000940:	144027f3          	csrr	a5,sip
80000944:	fef42623          	sw	a5,-20(s0)
    return x;
80000948:	fec42783          	lw	a5,-20(s0)
}
8000094c:	00078513          	mv	a0,a5
80000950:	01c12403          	lw	s0,28(sp)
80000954:	02010113          	addi	sp,sp,32
80000958:	00008067          	ret

8000095c <w_sip>:
static inline void w_sip(uint32 x){
8000095c:	fe010113          	addi	sp,sp,-32
80000960:	00812e23          	sw	s0,28(sp)
80000964:	02010413          	addi	s0,sp,32
80000968:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"::"r"(x));
8000096c:	fec42783          	lw	a5,-20(s0)
80000970:	14479073          	csrw	sip,a5
}
80000974:	00000013          	nop
80000978:	01c12403          	lw	s0,28(sp)
8000097c:	02010113          	addi	sp,sp,32
80000980:	00008067          	ret

80000984 <externinterrupt>:
#include "clint.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
80000984:	fe010113          	addi	sp,sp,-32
80000988:	00112e23          	sw	ra,28(sp)
8000098c:	00812c23          	sw	s0,24(sp)
80000990:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000994:	299000ef          	jal	ra,8000142c <r_plicclaim>
80000998:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
8000099c:	fec42583          	lw	a1,-20(s0)
800009a0:	8000c7b7          	lui	a5,0x8000c
800009a4:	04878513          	addi	a0,a5,72 # 8000c048 <memend+0xf800c048>
800009a8:	330000ef          	jal	ra,80000cd8 <printf>
    switch (irq)
800009ac:	fec42703          	lw	a4,-20(s0)
800009b0:	00a00793          	li	a5,10
800009b4:	02f71063          	bne	a4,a5,800009d4 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
800009b8:	e81ff0ef          	jal	ra,80000838 <uartintr>
800009bc:	00050793          	mv	a5,a0
800009c0:	00078593          	mv	a1,a5
800009c4:	8000c7b7          	lui	a5,0x8000c
800009c8:	05478513          	addi	a0,a5,84 # 8000c054 <memend+0xf800c054>
800009cc:	30c000ef          	jal	ra,80000cd8 <printf>
        break;
800009d0:	0080006f          	j	800009d8 <externinterrupt+0x54>
    default:
        break;
800009d4:	00000013          	nop
    }
    w_pliccomplete(irq);
800009d8:	fec42503          	lw	a0,-20(s0)
800009dc:	291000ef          	jal	ra,8000146c <w_pliccomplete>
}
800009e0:	00000013          	nop
800009e4:	01c12083          	lw	ra,28(sp)
800009e8:	01812403          	lw	s0,24(sp)
800009ec:	02010113          	addi	sp,sp,32
800009f0:	00008067          	ret

800009f4 <usertrapret>:

// 返回用户空间
void usertrapret(){
800009f4:	fe010113          	addi	sp,sp,-32
800009f8:	00112e23          	sw	ra,28(sp)
800009fc:	00812c23          	sw	s0,24(sp)
80000a00:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80000a04:	104010ef          	jal	ra,80001b08 <nowproc>
80000a08:	fea42623          	sw	a0,-20(s0)
    loadframe(&p->trapframe,p->pagetable);
80000a0c:	fec42783          	lw	a5,-20(s0)
80000a10:	00878713          	addi	a4,a5,8
80000a14:	fec42783          	lw	a5,-20(s0)
80000a18:	1107a783          	lw	a5,272(a5)
80000a1c:	00078593          	mv	a1,a5
80000a20:	00070513          	mv	a0,a4
80000a24:	8f9ff0ef          	jal	ra,8000031c <loadframe>
}
80000a28:	00000013          	nop
80000a2c:	01c12083          	lw	ra,28(sp)
80000a30:	01812403          	lw	s0,24(sp)
80000a34:	02010113          	addi	sp,sp,32
80000a38:	00008067          	ret

80000a3c <zero>:

void zero(){
80000a3c:	fe010113          	addi	sp,sp,-32
80000a40:	00112e23          	sw	ra,28(sp)
80000a44:	00812c23          	sw	s0,24(sp)
80000a48:	02010413          	addi	s0,sp,32
    printf("zero\n");
80000a4c:	8000c7b7          	lui	a5,0x8000c
80000a50:	06478513          	addi	a0,a5,100 # 8000c064 <memend+0xf800c064>
80000a54:	284000ef          	jal	ra,80000cd8 <printf>
    reg_t pc=r_sepc();
80000a58:	e65ff0ef          	jal	ra,800008bc <r_sepc>
80000a5c:	fea42623          	sw	a0,-20(s0)
    w_sepc(pc+4);
80000a60:	fec42783          	lw	a5,-20(s0)
80000a64:	00478793          	addi	a5,a5,4
80000a68:	00078513          	mv	a0,a5
80000a6c:	e79ff0ef          	jal	ra,800008e4 <w_sepc>
    usertrapret();
80000a70:	f85ff0ef          	jal	ra,800009f4 <usertrapret>
}
80000a74:	00000013          	nop
80000a78:	01c12083          	lw	ra,28(sp)
80000a7c:	01812403          	lw	s0,24(sp)
80000a80:	02010113          	addi	sp,sp,32
80000a84:	00008067          	ret

80000a88 <timerintr>:

void timerintr(){
80000a88:	ff010113          	addi	sp,sp,-16
80000a8c:	00112623          	sw	ra,12(sp)
80000a90:	00812423          	sw	s0,8(sp)
80000a94:	01010413          	addi	s0,sp,16
    w_sip(r_sip()& ~2); // 清除中断
80000a98:	e9dff0ef          	jal	ra,80000934 <r_sip>
80000a9c:	00050793          	mv	a5,a0
80000aa0:	ffd7f793          	andi	a5,a5,-3
80000aa4:	00078513          	mv	a0,a5
80000aa8:	eb5ff0ef          	jal	ra,8000095c <w_sip>
    // printf("timer interrupt\n");
}
80000aac:	00000013          	nop
80000ab0:	00c12083          	lw	ra,12(sp)
80000ab4:	00812403          	lw	s0,8(sp)
80000ab8:	01010113          	addi	sp,sp,16
80000abc:	00008067          	ret

80000ac0 <trapvec>:

void trapvec(){
80000ac0:	fe010113          	addi	sp,sp,-32
80000ac4:	00112e23          	sw	ra,28(sp)
80000ac8:	00812c23          	sw	s0,24(sp)
80000acc:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000ad0:	e3dff0ef          	jal	ra,8000090c <r_scause>
80000ad4:	fea42423          	sw	a0,-24(s0)

    uint16 code= scause & 0xffff;
80000ad8:	fe842783          	lw	a5,-24(s0)
80000adc:	fef41323          	sh	a5,-26(s0)

    if(scause & (1<<31)){
80000ae0:	fe842783          	lw	a5,-24(s0)
80000ae4:	0607d463          	bgez	a5,80000b4c <trapvec+0x8c>
    //     printf("Interrupt : ");
        switch (code)
80000ae8:	fe645783          	lhu	a5,-26(s0)
80000aec:	00900713          	li	a4,9
80000af0:	02e78c63          	beq	a5,a4,80000b28 <trapvec+0x68>
80000af4:	00900713          	li	a4,9
80000af8:	04f74263          	blt	a4,a5,80000b3c <trapvec+0x7c>
80000afc:	00100713          	li	a4,1
80000b00:	00e78863          	beq	a5,a4,80000b10 <trapvec+0x50>
80000b04:	00500713          	li	a4,5
80000b08:	00e78863          	beq	a5,a4,80000b18 <trapvec+0x58>
80000b0c:	0300006f          	j	80000b3c <trapvec+0x7c>
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
80000b10:	f79ff0ef          	jal	ra,80000a88 <timerintr>
            break;
80000b14:	1780006f          	j	80000c8c <trapvec+0x1cc>
        case 5:
            printf("Supervisor timer interrupt\n");
80000b18:	8000c7b7          	lui	a5,0x8000c
80000b1c:	06c78513          	addi	a0,a5,108 # 8000c06c <memend+0xf800c06c>
80000b20:	1b8000ef          	jal	ra,80000cd8 <printf>
            break;
80000b24:	1680006f          	j	80000c8c <trapvec+0x1cc>
        case 9:
            printf("Supervisor external interrupt\n");
80000b28:	8000c7b7          	lui	a5,0x8000c
80000b2c:	08878513          	addi	a0,a5,136 # 8000c088 <memend+0xf800c088>
80000b30:	1a8000ef          	jal	ra,80000cd8 <printf>
            externinterrupt();
80000b34:	e51ff0ef          	jal	ra,80000984 <externinterrupt>
            break;
80000b38:	1540006f          	j	80000c8c <trapvec+0x1cc>
        default:
            printf("Other interrupt\n");
80000b3c:	8000c7b7          	lui	a5,0x8000c
80000b40:	0a878513          	addi	a0,a5,168 # 8000c0a8 <memend+0xf800c0a8>
80000b44:	194000ef          	jal	ra,80000cd8 <printf>
            break;
80000b48:	1440006f          	j	80000c8c <trapvec+0x1cc>
        }
    }else{
        int ecall=0;
80000b4c:	fe042623          	sw	zero,-20(s0)
        printf("Exception : ");
80000b50:	8000c7b7          	lui	a5,0x8000c
80000b54:	0bc78513          	addi	a0,a5,188 # 8000c0bc <memend+0xf800c0bc>
80000b58:	180000ef          	jal	ra,80000cd8 <printf>
        switch (code)
80000b5c:	fe645783          	lhu	a5,-26(s0)
80000b60:	00f00713          	li	a4,15
80000b64:	0ef76c63          	bltu	a4,a5,80000c5c <trapvec+0x19c>
80000b68:	00279713          	slli	a4,a5,0x2
80000b6c:	8000c7b7          	lui	a5,0x8000c
80000b70:	23078793          	addi	a5,a5,560 # 8000c230 <memend+0xf800c230>
80000b74:	00f707b3          	add	a5,a4,a5
80000b78:	0007a783          	lw	a5,0(a5)
80000b7c:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000b80:	8000c7b7          	lui	a5,0x8000c
80000b84:	0cc78513          	addi	a0,a5,204 # 8000c0cc <memend+0xf800c0cc>
80000b88:	150000ef          	jal	ra,80000cd8 <printf>
            break;
80000b8c:	0e00006f          	j	80000c6c <trapvec+0x1ac>
        case 1:
            printf("Instruction access fault\n");
80000b90:	8000c7b7          	lui	a5,0x8000c
80000b94:	0ec78513          	addi	a0,a5,236 # 8000c0ec <memend+0xf800c0ec>
80000b98:	140000ef          	jal	ra,80000cd8 <printf>
            break;
80000b9c:	0d00006f          	j	80000c6c <trapvec+0x1ac>
        case 2:
            printf("Illegal instruction\n");
80000ba0:	8000c7b7          	lui	a5,0x8000c
80000ba4:	10878513          	addi	a0,a5,264 # 8000c108 <memend+0xf800c108>
80000ba8:	130000ef          	jal	ra,80000cd8 <printf>
            break;
80000bac:	0c00006f          	j	80000c6c <trapvec+0x1ac>
        case 3:
            printf("Breakpoint\n");
80000bb0:	8000c7b7          	lui	a5,0x8000c
80000bb4:	12078513          	addi	a0,a5,288 # 8000c120 <memend+0xf800c120>
80000bb8:	120000ef          	jal	ra,80000cd8 <printf>
            break;
80000bbc:	0b00006f          	j	80000c6c <trapvec+0x1ac>
        case 4:
            printf("Load address misaligned\n");
80000bc0:	8000c7b7          	lui	a5,0x8000c
80000bc4:	12c78513          	addi	a0,a5,300 # 8000c12c <memend+0xf800c12c>
80000bc8:	110000ef          	jal	ra,80000cd8 <printf>
            break;
80000bcc:	0a00006f          	j	80000c6c <trapvec+0x1ac>
        case 5:
            printf("Load access fault\n");
80000bd0:	8000c7b7          	lui	a5,0x8000c
80000bd4:	14878513          	addi	a0,a5,328 # 8000c148 <memend+0xf800c148>
80000bd8:	100000ef          	jal	ra,80000cd8 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000bdc:	0900006f          	j	80000c6c <trapvec+0x1ac>
        case 6:
            printf("Store/AMO address misaligned\n");
80000be0:	8000c7b7          	lui	a5,0x8000c
80000be4:	15c78513          	addi	a0,a5,348 # 8000c15c <memend+0xf800c15c>
80000be8:	0f0000ef          	jal	ra,80000cd8 <printf>
            break;
80000bec:	0800006f          	j	80000c6c <trapvec+0x1ac>
        case 7:
            printf("Store/AMO access fault\n");
80000bf0:	8000c7b7          	lui	a5,0x8000c
80000bf4:	17c78513          	addi	a0,a5,380 # 8000c17c <memend+0xf800c17c>
80000bf8:	0e0000ef          	jal	ra,80000cd8 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000bfc:	0700006f          	j	80000c6c <trapvec+0x1ac>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000c00:	8000c7b7          	lui	a5,0x8000c
80000c04:	19478513          	addi	a0,a5,404 # 8000c194 <memend+0xf800c194>
80000c08:	0d0000ef          	jal	ra,80000cd8 <printf>
            break;
80000c0c:	0600006f          	j	80000c6c <trapvec+0x1ac>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000c10:	8000c7b7          	lui	a5,0x8000c
80000c14:	1b478513          	addi	a0,a5,436 # 8000c1b4 <memend+0xf800c1b4>
80000c18:	0c0000ef          	jal	ra,80000cd8 <printf>
            zero();
80000c1c:	e21ff0ef          	jal	ra,80000a3c <zero>
            ecall=1;
80000c20:	00100793          	li	a5,1
80000c24:	fef42623          	sw	a5,-20(s0)
            break;
80000c28:	0440006f          	j	80000c6c <trapvec+0x1ac>
        case 12:
            printf("Instruction page fault\n");
80000c2c:	8000c7b7          	lui	a5,0x8000c
80000c30:	1d478513          	addi	a0,a5,468 # 8000c1d4 <memend+0xf800c1d4>
80000c34:	0a4000ef          	jal	ra,80000cd8 <printf>
            break;
80000c38:	0340006f          	j	80000c6c <trapvec+0x1ac>
        case 13:
            printf("Load page fault\n");
80000c3c:	8000c7b7          	lui	a5,0x8000c
80000c40:	1ec78513          	addi	a0,a5,492 # 8000c1ec <memend+0xf800c1ec>
80000c44:	094000ef          	jal	ra,80000cd8 <printf>
            break;
80000c48:	0240006f          	j	80000c6c <trapvec+0x1ac>
        case 15:
            printf("Store/AMO page fault\n");
80000c4c:	8000c7b7          	lui	a5,0x8000c
80000c50:	20078513          	addi	a0,a5,512 # 8000c200 <memend+0xf800c200>
80000c54:	084000ef          	jal	ra,80000cd8 <printf>
            break;
80000c58:	0140006f          	j	80000c6c <trapvec+0x1ac>
        default:
            printf("Other\n");
80000c5c:	8000c7b7          	lui	a5,0x8000c
80000c60:	21878513          	addi	a0,a5,536 # 8000c218 <memend+0xf800c218>
80000c64:	074000ef          	jal	ra,80000cd8 <printf>
            break;
80000c68:	00000013          	nop
        }
        if(!ecall){
80000c6c:	fec42783          	lw	a5,-20(s0)
80000c70:	00079e63          	bnez	a5,80000c8c <trapvec+0x1cc>
            panic("Trap Exception");
80000c74:	8000c7b7          	lui	a5,0x8000c
80000c78:	22078513          	addi	a0,a5,544 # 8000c220 <memend+0xf800c220>
80000c7c:	024000ef          	jal	ra,80000ca0 <panic>
            ecall=1;
80000c80:	00100793          	li	a5,1
80000c84:	fef42623          	sw	a5,-20(s0)
        }
    }
}
80000c88:	0040006f          	j	80000c8c <trapvec+0x1cc>
80000c8c:	00000013          	nop
80000c90:	01c12083          	lw	ra,28(sp)
80000c94:	01812403          	lw	s0,24(sp)
80000c98:	02010113          	addi	sp,sp,32
80000c9c:	00008067          	ret

80000ca0 <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000ca0:	fe010113          	addi	sp,sp,-32
80000ca4:	00112e23          	sw	ra,28(sp)
80000ca8:	00812c23          	sw	s0,24(sp)
80000cac:	02010413          	addi	s0,sp,32
80000cb0:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000cb4:	8000c7b7          	lui	a5,0x8000c
80000cb8:	27078513          	addi	a0,a5,624 # 8000c270 <memend+0xf800c270>
80000cbc:	ae1ff0ef          	jal	ra,8000079c <uartputs>
    uartputs(s);
80000cc0:	fec42503          	lw	a0,-20(s0)
80000cc4:	ad9ff0ef          	jal	ra,8000079c <uartputs>
	uartputs("\n");
80000cc8:	8000c7b7          	lui	a5,0x8000c
80000ccc:	27878513          	addi	a0,a5,632 # 8000c278 <memend+0xf800c278>
80000cd0:	acdff0ef          	jal	ra,8000079c <uartputs>
    while(1);
80000cd4:	0000006f          	j	80000cd4 <panic+0x34>

80000cd8 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000cd8:	f8010113          	addi	sp,sp,-128
80000cdc:	04112e23          	sw	ra,92(sp)
80000ce0:	04812c23          	sw	s0,88(sp)
80000ce4:	06010413          	addi	s0,sp,96
80000ce8:	faa42623          	sw	a0,-84(s0)
80000cec:	00b42223          	sw	a1,4(s0)
80000cf0:	00c42423          	sw	a2,8(s0)
80000cf4:	00d42623          	sw	a3,12(s0)
80000cf8:	00e42823          	sw	a4,16(s0)
80000cfc:	00f42a23          	sw	a5,20(s0)
80000d00:	01042c23          	sw	a6,24(s0)
80000d04:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000d08:	02040793          	addi	a5,s0,32
80000d0c:	faf42423          	sw	a5,-88(s0)
80000d10:	fa842783          	lw	a5,-88(s0)
80000d14:	fe478793          	addi	a5,a5,-28
80000d18:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000d1c:	fac42783          	lw	a5,-84(s0)
80000d20:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000d24:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000d28:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
80000d2c:	36c0006f          	j	80001098 <printf+0x3c0>
		if(ch=='%'){
80000d30:	fbf44703          	lbu	a4,-65(s0)
80000d34:	02500793          	li	a5,37
80000d38:	04f71863          	bne	a4,a5,80000d88 <printf+0xb0>
			if(tt==1){
80000d3c:	fe842703          	lw	a4,-24(s0)
80000d40:	00100793          	li	a5,1
80000d44:	02f71663          	bne	a4,a5,80000d70 <printf+0x98>
				outbuf[idx++]='%';
80000d48:	fe442783          	lw	a5,-28(s0)
80000d4c:	00178713          	addi	a4,a5,1
80000d50:	fee42223          	sw	a4,-28(s0)
80000d54:	8000d737          	lui	a4,0x8000d
80000d58:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000d5c:	00f707b3          	add	a5,a4,a5
80000d60:	02500713          	li	a4,37
80000d64:	00e78023          	sb	a4,0(a5)
				tt=0;
80000d68:	fe042423          	sw	zero,-24(s0)
80000d6c:	00c0006f          	j	80000d78 <printf+0xa0>
			}else{
				tt=1;
80000d70:	00100793          	li	a5,1
80000d74:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000d78:	fec42783          	lw	a5,-20(s0)
80000d7c:	00178793          	addi	a5,a5,1
80000d80:	fef42623          	sw	a5,-20(s0)
80000d84:	3140006f          	j	80001098 <printf+0x3c0>
		}else{
			if(tt==1){
80000d88:	fe842703          	lw	a4,-24(s0)
80000d8c:	00100793          	li	a5,1
80000d90:	2cf71e63          	bne	a4,a5,8000106c <printf+0x394>
				switch (ch)
80000d94:	fbf44783          	lbu	a5,-65(s0)
80000d98:	fa878793          	addi	a5,a5,-88
80000d9c:	02000713          	li	a4,32
80000da0:	2af76663          	bltu	a4,a5,8000104c <printf+0x374>
80000da4:	00279713          	slli	a4,a5,0x2
80000da8:	8000c7b7          	lui	a5,0x8000c
80000dac:	29478793          	addi	a5,a5,660 # 8000c294 <memend+0xf800c294>
80000db0:	00f707b3          	add	a5,a4,a5
80000db4:	0007a783          	lw	a5,0(a5)
80000db8:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000dbc:	fb842783          	lw	a5,-72(s0)
80000dc0:	00478713          	addi	a4,a5,4
80000dc4:	fae42c23          	sw	a4,-72(s0)
80000dc8:	0007a783          	lw	a5,0(a5)
80000dcc:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000dd0:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000dd4:	fe042783          	lw	a5,-32(s0)
80000dd8:	fcf42c23          	sw	a5,-40(s0)
80000ddc:	0100006f          	j	80000dec <printf+0x114>
80000de0:	fdc42783          	lw	a5,-36(s0)
80000de4:	00178793          	addi	a5,a5,1
80000de8:	fcf42e23          	sw	a5,-36(s0)
80000dec:	fd842703          	lw	a4,-40(s0)
80000df0:	00a00793          	li	a5,10
80000df4:	02f747b3          	div	a5,a4,a5
80000df8:	fcf42c23          	sw	a5,-40(s0)
80000dfc:	fd842783          	lw	a5,-40(s0)
80000e00:	fe0790e3          	bnez	a5,80000de0 <printf+0x108>
					for(int i=len;i>=0;i--){
80000e04:	fdc42783          	lw	a5,-36(s0)
80000e08:	fcf42a23          	sw	a5,-44(s0)
80000e0c:	0540006f          	j	80000e60 <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000e10:	fe042703          	lw	a4,-32(s0)
80000e14:	00a00793          	li	a5,10
80000e18:	02f767b3          	rem	a5,a4,a5
80000e1c:	0ff7f713          	andi	a4,a5,255
80000e20:	fe442683          	lw	a3,-28(s0)
80000e24:	fd442783          	lw	a5,-44(s0)
80000e28:	00f687b3          	add	a5,a3,a5
80000e2c:	03070713          	addi	a4,a4,48
80000e30:	0ff77713          	andi	a4,a4,255
80000e34:	8000d6b7          	lui	a3,0x8000d
80000e38:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
80000e3c:	00f687b3          	add	a5,a3,a5
80000e40:	00e78023          	sb	a4,0(a5)
						x/=10;
80000e44:	fe042703          	lw	a4,-32(s0)
80000e48:	00a00793          	li	a5,10
80000e4c:	02f747b3          	div	a5,a4,a5
80000e50:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000e54:	fd442783          	lw	a5,-44(s0)
80000e58:	fff78793          	addi	a5,a5,-1
80000e5c:	fcf42a23          	sw	a5,-44(s0)
80000e60:	fd442783          	lw	a5,-44(s0)
80000e64:	fa07d6e3          	bgez	a5,80000e10 <printf+0x138>
					}
					idx+=(len+1);
80000e68:	fdc42783          	lw	a5,-36(s0)
80000e6c:	00178793          	addi	a5,a5,1
80000e70:	fe442703          	lw	a4,-28(s0)
80000e74:	00f707b3          	add	a5,a4,a5
80000e78:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000e7c:	fe042423          	sw	zero,-24(s0)
					break;
80000e80:	1dc0006f          	j	8000105c <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000e84:	fe442783          	lw	a5,-28(s0)
80000e88:	00178713          	addi	a4,a5,1
80000e8c:	fee42223          	sw	a4,-28(s0)
80000e90:	8000d737          	lui	a4,0x8000d
80000e94:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000e98:	00f707b3          	add	a5,a4,a5
80000e9c:	03000713          	li	a4,48
80000ea0:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000ea4:	fe442783          	lw	a5,-28(s0)
80000ea8:	00178713          	addi	a4,a5,1
80000eac:	fee42223          	sw	a4,-28(s0)
80000eb0:	8000d737          	lui	a4,0x8000d
80000eb4:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000eb8:	00f707b3          	add	a5,a4,a5
80000ebc:	07800713          	li	a4,120
80000ec0:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80000ec4:	fb842783          	lw	a5,-72(s0)
80000ec8:	00478713          	addi	a4,a5,4
80000ecc:	fae42c23          	sw	a4,-72(s0)
80000ed0:	0007a783          	lw	a5,0(a5)
80000ed4:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80000ed8:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80000edc:	fd042783          	lw	a5,-48(s0)
80000ee0:	fcf42423          	sw	a5,-56(s0)
80000ee4:	0100006f          	j	80000ef4 <printf+0x21c>
80000ee8:	fcc42783          	lw	a5,-52(s0)
80000eec:	00178793          	addi	a5,a5,1
80000ef0:	fcf42623          	sw	a5,-52(s0)
80000ef4:	fc842783          	lw	a5,-56(s0)
80000ef8:	0047d793          	srli	a5,a5,0x4
80000efc:	fcf42423          	sw	a5,-56(s0)
80000f00:	fc842783          	lw	a5,-56(s0)
80000f04:	fe0792e3          	bnez	a5,80000ee8 <printf+0x210>
					for(int i=len;i>=0;i--){
80000f08:	fcc42783          	lw	a5,-52(s0)
80000f0c:	fcf42223          	sw	a5,-60(s0)
80000f10:	0840006f          	j	80000f94 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80000f14:	fd042783          	lw	a5,-48(s0)
80000f18:	00f7f713          	andi	a4,a5,15
80000f1c:	00900793          	li	a5,9
80000f20:	02e7f063          	bgeu	a5,a4,80000f40 <printf+0x268>
80000f24:	fd042783          	lw	a5,-48(s0)
80000f28:	0ff7f793          	andi	a5,a5,255
80000f2c:	00f7f793          	andi	a5,a5,15
80000f30:	0ff7f793          	andi	a5,a5,255
80000f34:	05778793          	addi	a5,a5,87
80000f38:	0ff7f793          	andi	a5,a5,255
80000f3c:	01c0006f          	j	80000f58 <printf+0x280>
80000f40:	fd042783          	lw	a5,-48(s0)
80000f44:	0ff7f793          	andi	a5,a5,255
80000f48:	00f7f793          	andi	a5,a5,15
80000f4c:	0ff7f793          	andi	a5,a5,255
80000f50:	03078793          	addi	a5,a5,48
80000f54:	0ff7f793          	andi	a5,a5,255
80000f58:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80000f5c:	fe442703          	lw	a4,-28(s0)
80000f60:	fc442783          	lw	a5,-60(s0)
80000f64:	00f707b3          	add	a5,a4,a5
80000f68:	8000d737          	lui	a4,0x8000d
80000f6c:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000f70:	00f707b3          	add	a5,a4,a5
80000f74:	fbe44703          	lbu	a4,-66(s0)
80000f78:	00e78023          	sb	a4,0(a5)
						x/=16;
80000f7c:	fd042783          	lw	a5,-48(s0)
80000f80:	0047d793          	srli	a5,a5,0x4
80000f84:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80000f88:	fc442783          	lw	a5,-60(s0)
80000f8c:	fff78793          	addi	a5,a5,-1
80000f90:	fcf42223          	sw	a5,-60(s0)
80000f94:	fc442783          	lw	a5,-60(s0)
80000f98:	f607dee3          	bgez	a5,80000f14 <printf+0x23c>
					}
					idx+=(len+1);
80000f9c:	fcc42783          	lw	a5,-52(s0)
80000fa0:	00178793          	addi	a5,a5,1
80000fa4:	fe442703          	lw	a4,-28(s0)
80000fa8:	00f707b3          	add	a5,a4,a5
80000fac:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000fb0:	fe042423          	sw	zero,-24(s0)
					break;
80000fb4:	0a80006f          	j	8000105c <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80000fb8:	fb842783          	lw	a5,-72(s0)
80000fbc:	00478713          	addi	a4,a5,4
80000fc0:	fae42c23          	sw	a4,-72(s0)
80000fc4:	0007a783          	lw	a5,0(a5)
80000fc8:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80000fcc:	fe442783          	lw	a5,-28(s0)
80000fd0:	00178713          	addi	a4,a5,1
80000fd4:	fee42223          	sw	a4,-28(s0)
80000fd8:	8000d737          	lui	a4,0x8000d
80000fdc:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000fe0:	00f707b3          	add	a5,a4,a5
80000fe4:	fbf44703          	lbu	a4,-65(s0)
80000fe8:	00e78023          	sb	a4,0(a5)
					tt=0;
80000fec:	fe042423          	sw	zero,-24(s0)
					break;
80000ff0:	06c0006f          	j	8000105c <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80000ff4:	fb842783          	lw	a5,-72(s0)
80000ff8:	00478713          	addi	a4,a5,4
80000ffc:	fae42c23          	sw	a4,-72(s0)
80001000:	0007a783          	lw	a5,0(a5)
80001004:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80001008:	0300006f          	j	80001038 <printf+0x360>
						outbuf[idx++]=*ss++;
8000100c:	fc042703          	lw	a4,-64(s0)
80001010:	00170793          	addi	a5,a4,1
80001014:	fcf42023          	sw	a5,-64(s0)
80001018:	fe442783          	lw	a5,-28(s0)
8000101c:	00178693          	addi	a3,a5,1
80001020:	fed42223          	sw	a3,-28(s0)
80001024:	00074703          	lbu	a4,0(a4)
80001028:	8000d6b7          	lui	a3,0x8000d
8000102c:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
80001030:	00f687b3          	add	a5,a3,a5
80001034:	00e78023          	sb	a4,0(a5)
					while(*ss){
80001038:	fc042783          	lw	a5,-64(s0)
8000103c:	0007c783          	lbu	a5,0(a5)
80001040:	fc0796e3          	bnez	a5,8000100c <printf+0x334>
					}
					tt=0;
80001044:	fe042423          	sw	zero,-24(s0)
					break;
80001048:	0140006f          	j	8000105c <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
8000104c:	8000c7b7          	lui	a5,0x8000c
80001050:	27c78513          	addi	a0,a5,636 # 8000c27c <memend+0xf800c27c>
80001054:	c4dff0ef          	jal	ra,80000ca0 <panic>
					break;
80001058:	00000013          	nop
				}
				s++;
8000105c:	fec42783          	lw	a5,-20(s0)
80001060:	00178793          	addi	a5,a5,1
80001064:	fef42623          	sw	a5,-20(s0)
80001068:	0300006f          	j	80001098 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
8000106c:	fe442783          	lw	a5,-28(s0)
80001070:	00178713          	addi	a4,a5,1
80001074:	fee42223          	sw	a4,-28(s0)
80001078:	8000d737          	lui	a4,0x8000d
8000107c:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001080:	00f707b3          	add	a5,a4,a5
80001084:	fbf44703          	lbu	a4,-65(s0)
80001088:	00e78023          	sb	a4,0(a5)
				s++;
8000108c:	fec42783          	lw	a5,-20(s0)
80001090:	00178793          	addi	a5,a5,1
80001094:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
80001098:	fec42783          	lw	a5,-20(s0)
8000109c:	0007c783          	lbu	a5,0(a5)
800010a0:	faf40fa3          	sb	a5,-65(s0)
800010a4:	fbf44783          	lbu	a5,-65(s0)
800010a8:	c80794e3          	bnez	a5,80000d30 <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
800010ac:	8000d7b7          	lui	a5,0x8000d
800010b0:	00478713          	addi	a4,a5,4 # 8000d004 <memend+0xf800d004>
800010b4:	fe442783          	lw	a5,-28(s0)
800010b8:	00f707b3          	add	a5,a4,a5
800010bc:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
800010c0:	8000d7b7          	lui	a5,0x8000d
800010c4:	00478513          	addi	a0,a5,4 # 8000d004 <memend+0xf800d004>
800010c8:	ed4ff0ef          	jal	ra,8000079c <uartputs>
	return idx;
800010cc:	fe442783          	lw	a5,-28(s0)
800010d0:	00078513          	mv	a0,a5
800010d4:	05c12083          	lw	ra,92(sp)
800010d8:	05812403          	lw	s0,88(sp)
800010dc:	08010113          	addi	sp,sp,128
800010e0:	00008067          	ret

800010e4 <minit>:
struct
{
    struct pmp* freelist;
}mem;
#define _DEBUG
void minit(){
800010e4:	fe010113          	addi	sp,sp,-32
800010e8:	00112e23          	sw	ra,28(sp)
800010ec:	00812c23          	sw	s0,24(sp)
800010f0:	02010413          	addi	s0,sp,32
    #ifdef _DEBUG
        printf("textstart:%p    ",textstart);
800010f4:	800007b7          	lui	a5,0x80000
800010f8:	00078593          	mv	a1,a5
800010fc:	8000c7b7          	lui	a5,0x8000c
80001100:	31878513          	addi	a0,a5,792 # 8000c318 <memend+0xf800c318>
80001104:	bd5ff0ef          	jal	ra,80000cd8 <printf>
        printf("textend:%p\n",textend);
80001108:	800027b7          	lui	a5,0x80002
8000110c:	3e078593          	addi	a1,a5,992 # 800023e0 <memend+0xf80023e0>
80001110:	8000c7b7          	lui	a5,0x8000c
80001114:	32c78513          	addi	a0,a5,812 # 8000c32c <memend+0xf800c32c>
80001118:	bc1ff0ef          	jal	ra,80000cd8 <printf>
        printf("datastart:%p    ",datastart);
8000111c:	800037b7          	lui	a5,0x80003
80001120:	00078593          	mv	a1,a5
80001124:	8000c7b7          	lui	a5,0x8000c
80001128:	33878513          	addi	a0,a5,824 # 8000c338 <memend+0xf800c338>
8000112c:	badff0ef          	jal	ra,80000cd8 <printf>
        printf("dataend:%p\n",dataend);
80001130:	8000b7b7          	lui	a5,0x8000b
80001134:	00478593          	addi	a1,a5,4 # 8000b004 <memend+0xf800b004>
80001138:	8000c7b7          	lui	a5,0x8000c
8000113c:	34c78513          	addi	a0,a5,844 # 8000c34c <memend+0xf800c34c>
80001140:	b99ff0ef          	jal	ra,80000cd8 <printf>
        printf("rodatastart:%p  ",rodatastart);
80001144:	8000c7b7          	lui	a5,0x8000c
80001148:	00078593          	mv	a1,a5
8000114c:	8000c7b7          	lui	a5,0x8000c
80001150:	35878513          	addi	a0,a5,856 # 8000c358 <memend+0xf800c358>
80001154:	b85ff0ef          	jal	ra,80000cd8 <printf>
        printf("rodataend:%p\n",rodataend);
80001158:	8000c7b7          	lui	a5,0x8000c
8000115c:	3ff78593          	addi	a1,a5,1023 # 8000c3ff <memend+0xf800c3ff>
80001160:	8000c7b7          	lui	a5,0x8000c
80001164:	36c78513          	addi	a0,a5,876 # 8000c36c <memend+0xf800c36c>
80001168:	b71ff0ef          	jal	ra,80000cd8 <printf>
        printf("bssstart:%p     ",bssstart);
8000116c:	8000d7b7          	lui	a5,0x8000d
80001170:	00078593          	mv	a1,a5
80001174:	8000c7b7          	lui	a5,0x8000c
80001178:	37c78513          	addi	a0,a5,892 # 8000c37c <memend+0xf800c37c>
8000117c:	b5dff0ef          	jal	ra,80000cd8 <printf>
        printf("bssend:%p\n",bssend);
80001180:	8000e7b7          	lui	a5,0x8000e
80001184:	9f078593          	addi	a1,a5,-1552 # 8000d9f0 <memend+0xf800d9f0>
80001188:	8000c7b7          	lui	a5,0x8000c
8000118c:	39078513          	addi	a0,a5,912 # 8000c390 <memend+0xf800c390>
80001190:	b49ff0ef          	jal	ra,80000cd8 <printf>
        printf("mstart:%p   ",mstart);
80001194:	8000e7b7          	lui	a5,0x8000e
80001198:	00078593          	mv	a1,a5
8000119c:	8000c7b7          	lui	a5,0x8000c
800011a0:	39c78513          	addi	a0,a5,924 # 8000c39c <memend+0xf800c39c>
800011a4:	b35ff0ef          	jal	ra,80000cd8 <printf>
        printf("mend:%p\n",mend);
800011a8:	880007b7          	lui	a5,0x88000
800011ac:	00078593          	mv	a1,a5
800011b0:	8000c7b7          	lui	a5,0x8000c
800011b4:	3ac78513          	addi	a0,a5,940 # 8000c3ac <memend+0xf800c3ac>
800011b8:	b21ff0ef          	jal	ra,80000cd8 <printf>
        printf("stack:%p\n",stacks);
800011bc:	800037b7          	lui	a5,0x80003
800011c0:	00478593          	addi	a1,a5,4 # 80003004 <memend+0xf8003004>
800011c4:	8000c7b7          	lui	a5,0x8000c
800011c8:	3b878513          	addi	a0,a5,952 # 8000c3b8 <memend+0xf800c3b8>
800011cc:	b0dff0ef          	jal	ra,80000cd8 <printf>
    #endif

    char* p=(char*)mstart;
800011d0:	8000e7b7          	lui	a5,0x8000e
800011d4:	00078793          	mv	a5,a5
800011d8:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800011dc:	0380006f          	j	80001214 <minit+0x130>
        m=(struct pmp*)p;
800011e0:	fec42783          	lw	a5,-20(s0)
800011e4:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
800011e8:	8000e7b7          	lui	a5,0x8000e
800011ec:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800011f0:	fe842783          	lw	a5,-24(s0)
800011f4:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
800011f8:	8000e7b7          	lui	a5,0x8000e
800011fc:	fe842703          	lw	a4,-24(s0)
80001200:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001204:	fec42703          	lw	a4,-20(s0)
80001208:	000017b7          	lui	a5,0x1
8000120c:	00f707b3          	add	a5,a4,a5
80001210:	fef42623          	sw	a5,-20(s0)
80001214:	fec42703          	lw	a4,-20(s0)
80001218:	000017b7          	lui	a5,0x1
8000121c:	00f70733          	add	a4,a4,a5
80001220:	880007b7          	lui	a5,0x88000
80001224:	00078793          	mv	a5,a5
80001228:	fae7fce3          	bgeu	a5,a4,800011e0 <minit+0xfc>
    }
}
8000122c:	00000013          	nop
80001230:	00000013          	nop
80001234:	01c12083          	lw	ra,28(sp)
80001238:	01812403          	lw	s0,24(sp)
8000123c:	02010113          	addi	sp,sp,32
80001240:	00008067          	ret

80001244 <palloc>:

void* palloc(){
80001244:	fe010113          	addi	sp,sp,-32
80001248:	00112e23          	sw	ra,28(sp)
8000124c:	00812c23          	sw	s0,24(sp)
80001250:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80001254:	8000e7b7          	lui	a5,0x8000e
80001258:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
8000125c:	fef42623          	sw	a5,-20(s0)
    if(p)
80001260:	fec42783          	lw	a5,-20(s0)
80001264:	00078c63          	beqz	a5,8000127c <palloc+0x38>
        mem.freelist=mem.freelist->next;
80001268:	8000e7b7          	lui	a5,0x8000e
8000126c:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001270:	0007a703          	lw	a4,0(a5)
80001274:	8000e7b7          	lui	a5,0x8000e
80001278:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    if(p)
8000127c:	fec42783          	lw	a5,-20(s0)
80001280:	00078a63          	beqz	a5,80001294 <palloc+0x50>
        memset(p,0,PGSIZE);
80001284:	00001637          	lui	a2,0x1
80001288:	00000593          	li	a1,0
8000128c:	fec42503          	lw	a0,-20(s0)
80001290:	2e9000ef          	jal	ra,80001d78 <memset>
    return (void*)p;
80001294:	fec42783          	lw	a5,-20(s0)
}
80001298:	00078513          	mv	a0,a5
8000129c:	01c12083          	lw	ra,28(sp)
800012a0:	01812403          	lw	s0,24(sp)
800012a4:	02010113          	addi	sp,sp,32
800012a8:	00008067          	ret

800012ac <pfree>:

void pfree(void* addr){
800012ac:	fd010113          	addi	sp,sp,-48
800012b0:	02812623          	sw	s0,44(sp)
800012b4:	03010413          	addi	s0,sp,48
800012b8:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
800012bc:	fdc42783          	lw	a5,-36(s0)
800012c0:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
800012c4:	8000e7b7          	lui	a5,0x8000e
800012c8:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800012cc:	fec42783          	lw	a5,-20(s0)
800012d0:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
800012d4:	8000e7b7          	lui	a5,0x8000e
800012d8:	fec42703          	lw	a4,-20(s0)
800012dc:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800012e0:	00000013          	nop
800012e4:	02c12403          	lw	s0,44(sp)
800012e8:	03010113          	addi	sp,sp,48
800012ec:	00008067          	ret

800012f0 <r_tp>:
static inline uint32 r_tp(){
800012f0:	fe010113          	addi	sp,sp,-32
800012f4:	00812e23          	sw	s0,28(sp)
800012f8:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800012fc:	00020793          	mv	a5,tp
80001300:	fef42623          	sw	a5,-20(s0)
    return x;
80001304:	fec42783          	lw	a5,-20(s0)
}
80001308:	00078513          	mv	a0,a5
8000130c:	01c12403          	lw	s0,28(sp)
80001310:	02010113          	addi	sp,sp,32
80001314:	00008067          	ret

80001318 <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
80001318:	fe010113          	addi	sp,sp,-32
8000131c:	00812e23          	sw	s0,28(sp)
80001320:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
80001324:	104027f3          	csrr	a5,sie
80001328:	fef42623          	sw	a5,-20(s0)
    return x;
8000132c:	fec42783          	lw	a5,-20(s0)
}
80001330:	00078513          	mv	a0,a5
80001334:	01c12403          	lw	s0,28(sp)
80001338:	02010113          	addi	sp,sp,32
8000133c:	00008067          	ret

80001340 <w_sie>:
static inline void w_sie(uint32 x){
80001340:	fe010113          	addi	sp,sp,-32
80001344:	00812e23          	sw	s0,28(sp)
80001348:	02010413          	addi	s0,sp,32
8000134c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80001350:	fec42783          	lw	a5,-20(s0)
80001354:	10479073          	csrw	sie,a5
}
80001358:	00000013          	nop
8000135c:	01c12403          	lw	s0,28(sp)
80001360:	02010113          	addi	sp,sp,32
80001364:	00008067          	ret

80001368 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
80001368:	ff010113          	addi	sp,sp,-16
8000136c:	00112623          	sw	ra,12(sp)
80001370:	00812423          	sw	s0,8(sp)
80001374:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
80001378:	0c0007b7          	lui	a5,0xc000
8000137c:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001380:	00100713          	li	a4,1
80001384:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001388:	f69ff0ef          	jal	ra,800012f0 <r_tp>
8000138c:	00050793          	mv	a5,a0
80001390:	00879713          	slli	a4,a5,0x8
80001394:	0c0027b7          	lui	a5,0xc002
80001398:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
8000139c:	00f707b3          	add	a5,a4,a5
800013a0:	00078713          	mv	a4,a5
800013a4:	40000793          	li	a5,1024
800013a8:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800013ac:	f45ff0ef          	jal	ra,800012f0 <r_tp>
800013b0:	00050713          	mv	a4,a0
800013b4:	000c07b7          	lui	a5,0xc0
800013b8:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800013bc:	00f707b3          	add	a5,a4,a5
800013c0:	00879793          	slli	a5,a5,0x8
800013c4:	00078713          	mv	a4,a5
800013c8:	40000793          	li	a5,1024
800013cc:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
800013d0:	f21ff0ef          	jal	ra,800012f0 <r_tp>
800013d4:	00050713          	mv	a4,a0
800013d8:	000067b7          	lui	a5,0x6
800013dc:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800013e0:	00f707b3          	add	a5,a4,a5
800013e4:	00d79793          	slli	a5,a5,0xd
800013e8:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800013ec:	f05ff0ef          	jal	ra,800012f0 <r_tp>
800013f0:	00050793          	mv	a5,a0
800013f4:	00d79713          	slli	a4,a5,0xd
800013f8:	0c2017b7          	lui	a5,0xc201
800013fc:	00f707b3          	add	a5,a4,a5
80001400:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
80001404:	f15ff0ef          	jal	ra,80001318 <r_sie>
80001408:	00050793          	mv	a5,a0
8000140c:	2227e793          	ori	a5,a5,546
80001410:	00078513          	mv	a0,a5
80001414:	f2dff0ef          	jal	ra,80001340 <w_sie>
}
80001418:	00000013          	nop
8000141c:	00c12083          	lw	ra,12(sp)
80001420:	00812403          	lw	s0,8(sp)
80001424:	01010113          	addi	sp,sp,16
80001428:	00008067          	ret

8000142c <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
8000142c:	ff010113          	addi	sp,sp,-16
80001430:	00112623          	sw	ra,12(sp)
80001434:	00812423          	sw	s0,8(sp)
80001438:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
8000143c:	eb5ff0ef          	jal	ra,800012f0 <r_tp>
80001440:	00050793          	mv	a5,a0
80001444:	00d79713          	slli	a4,a5,0xd
80001448:	0c2017b7          	lui	a5,0xc201
8000144c:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001450:	00f707b3          	add	a5,a4,a5
80001454:	0007a783          	lw	a5,0(a5)
}
80001458:	00078513          	mv	a0,a5
8000145c:	00c12083          	lw	ra,12(sp)
80001460:	00812403          	lw	s0,8(sp)
80001464:	01010113          	addi	sp,sp,16
80001468:	00008067          	ret

8000146c <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
8000146c:	fe010113          	addi	sp,sp,-32
80001470:	00112e23          	sw	ra,28(sp)
80001474:	00812c23          	sw	s0,24(sp)
80001478:	02010413          	addi	s0,sp,32
8000147c:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80001480:	e71ff0ef          	jal	ra,800012f0 <r_tp>
80001484:	00050793          	mv	a5,a0
80001488:	00d79713          	slli	a4,a5,0xd
8000148c:	0c2007b7          	lui	a5,0xc200
80001490:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
80001494:	00f707b3          	add	a5,a4,a5
80001498:	00078713          	mv	a4,a5
8000149c:	fec42783          	lw	a5,-20(s0)
800014a0:	00f72023          	sw	a5,0(a4)
800014a4:	00000013          	nop
800014a8:	01c12083          	lw	ra,28(sp)
800014ac:	01812403          	lw	s0,24(sp)
800014b0:	02010113          	addi	sp,sp,32
800014b4:	00008067          	ret

800014b8 <w_satp>:
static inline void w_satp(uint32 x){
800014b8:	fe010113          	addi	sp,sp,-32
800014bc:	00812e23          	sw	s0,28(sp)
800014c0:	02010413          	addi	s0,sp,32
800014c4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800014c8:	fec42783          	lw	a5,-20(s0)
800014cc:	18079073          	csrw	satp,a5
}
800014d0:	00000013          	nop
800014d4:	01c12403          	lw	s0,28(sp)
800014d8:	02010113          	addi	sp,sp,32
800014dc:	00008067          	ret

800014e0 <sfence_vma>:
static inline void sfence_vma(){
800014e0:	ff010113          	addi	sp,sp,-16
800014e4:	00812623          	sw	s0,12(sp)
800014e8:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800014ec:	12000073          	sfence.vma
}
800014f0:	00000013          	nop
800014f4:	00c12403          	lw	s0,12(sp)
800014f8:	01010113          	addi	sp,sp,16
800014fc:	00008067          	ret

80001500 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
80001500:	fd010113          	addi	sp,sp,-48
80001504:	02112623          	sw	ra,44(sp)
80001508:	02812423          	sw	s0,40(sp)
8000150c:	03010413          	addi	s0,sp,48
80001510:	fca42e23          	sw	a0,-36(s0)
80001514:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
80001518:	fd842783          	lw	a5,-40(s0)
8000151c:	0167d793          	srli	a5,a5,0x16
80001520:	00279793          	slli	a5,a5,0x2
80001524:	fdc42703          	lw	a4,-36(s0)
80001528:	00f707b3          	add	a5,a4,a5
8000152c:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001530:	fec42783          	lw	a5,-20(s0)
80001534:	0007a783          	lw	a5,0(a5)
80001538:	0017f793          	andi	a5,a5,1
8000153c:	00078e63          	beqz	a5,80001558 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001540:	fec42783          	lw	a5,-20(s0)
80001544:	0007a783          	lw	a5,0(a5)
80001548:	00a7d793          	srli	a5,a5,0xa
8000154c:	00c79793          	slli	a5,a5,0xc
80001550:	fcf42e23          	sw	a5,-36(s0)
80001554:	0340006f          	j	80001588 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
80001558:	cedff0ef          	jal	ra,80001244 <palloc>
8000155c:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001560:	00001637          	lui	a2,0x1
80001564:	00000593          	li	a1,0
80001568:	fdc42503          	lw	a0,-36(s0)
8000156c:	00d000ef          	jal	ra,80001d78 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001570:	fdc42783          	lw	a5,-36(s0)
80001574:	00c7d793          	srli	a5,a5,0xc
80001578:	00a79793          	slli	a5,a5,0xa
8000157c:	0017e713          	ori	a4,a5,1
80001580:	fec42783          	lw	a5,-20(s0)
80001584:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001588:	fd842783          	lw	a5,-40(s0)
8000158c:	00c7d793          	srli	a5,a5,0xc
80001590:	3ff7f793          	andi	a5,a5,1023
80001594:	00279793          	slli	a5,a5,0x2
80001598:	fdc42703          	lw	a4,-36(s0)
8000159c:	00f707b3          	add	a5,a4,a5
}
800015a0:	00078513          	mv	a0,a5
800015a4:	02c12083          	lw	ra,44(sp)
800015a8:	02812403          	lw	s0,40(sp)
800015ac:	03010113          	addi	sp,sp,48
800015b0:	00008067          	ret

800015b4 <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
800015b4:	fc010113          	addi	sp,sp,-64
800015b8:	02112e23          	sw	ra,60(sp)
800015bc:	02812c23          	sw	s0,56(sp)
800015c0:	04010413          	addi	s0,sp,64
800015c4:	fca42e23          	sw	a0,-36(s0)
800015c8:	fcb42c23          	sw	a1,-40(s0)
800015cc:	fcc42a23          	sw	a2,-44(s0)
800015d0:	fcd42823          	sw	a3,-48(s0)
800015d4:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
800015d8:	fd842703          	lw	a4,-40(s0)
800015dc:	fffff7b7          	lui	a5,0xfffff
800015e0:	00f777b3          	and	a5,a4,a5
800015e4:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
800015e8:	fd042703          	lw	a4,-48(s0)
800015ec:	fd842783          	lw	a5,-40(s0)
800015f0:	00f707b3          	add	a5,a4,a5
800015f4:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
800015f8:	fffff7b7          	lui	a5,0xfffff
800015fc:	00f777b3          	and	a5,a4,a5
80001600:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
80001604:	fec42583          	lw	a1,-20(s0)
80001608:	fdc42503          	lw	a0,-36(s0)
8000160c:	ef5ff0ef          	jal	ra,80001500 <acquriepte>
80001610:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
80001614:	fe442783          	lw	a5,-28(s0)
80001618:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
8000161c:	0017f793          	andi	a5,a5,1
80001620:	00078863          	beqz	a5,80001630 <vmmap+0x7c>
            panic("repeat map");
80001624:	8000c7b7          	lui	a5,0x8000c
80001628:	3c478513          	addi	a0,a5,964 # 8000c3c4 <memend+0xf800c3c4>
8000162c:	e74ff0ef          	jal	ra,80000ca0 <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001630:	fd442783          	lw	a5,-44(s0)
80001634:	00c7d793          	srli	a5,a5,0xc
80001638:	00a79713          	slli	a4,a5,0xa
8000163c:	fcc42783          	lw	a5,-52(s0)
80001640:	00f767b3          	or	a5,a4,a5
80001644:	0017e713          	ori	a4,a5,1
80001648:	fe442783          	lw	a5,-28(s0)
8000164c:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001650:	fec42703          	lw	a4,-20(s0)
80001654:	fe842783          	lw	a5,-24(s0)
80001658:	02f70463          	beq	a4,a5,80001680 <vmmap+0xcc>
        start += PGSIZE;
8000165c:	fec42703          	lw	a4,-20(s0)
80001660:	000017b7          	lui	a5,0x1
80001664:	00f707b3          	add	a5,a4,a5
80001668:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
8000166c:	fd442703          	lw	a4,-44(s0)
80001670:	000017b7          	lui	a5,0x1
80001674:	00f707b3          	add	a5,a4,a5
80001678:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
8000167c:	f89ff06f          	j	80001604 <vmmap+0x50>
        if(start==end)  break;
80001680:	00000013          	nop
    }
}
80001684:	00000013          	nop
80001688:	03c12083          	lw	ra,60(sp)
8000168c:	03812403          	lw	s0,56(sp)
80001690:	04010113          	addi	sp,sp,64
80001694:	00008067          	ret

80001698 <printpgt>:

void printpgt(addr_t* pgt){
80001698:	fc010113          	addi	sp,sp,-64
8000169c:	02112e23          	sw	ra,60(sp)
800016a0:	02812c23          	sw	s0,56(sp)
800016a4:	04010413          	addi	s0,sp,64
800016a8:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
800016ac:	fe042623          	sw	zero,-20(s0)
800016b0:	0c40006f          	j	80001774 <printpgt+0xdc>
        pte_t pte=pgt[i];
800016b4:	fec42783          	lw	a5,-20(s0)
800016b8:	00279793          	slli	a5,a5,0x2
800016bc:	fcc42703          	lw	a4,-52(s0)
800016c0:	00f707b3          	add	a5,a4,a5
800016c4:	0007a783          	lw	a5,0(a5) # 1000 <sz>
800016c8:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
800016cc:	fe442783          	lw	a5,-28(s0)
800016d0:	0017f793          	andi	a5,a5,1
800016d4:	08078a63          	beqz	a5,80001768 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
800016d8:	fe442783          	lw	a5,-28(s0)
800016dc:	00a7d793          	srli	a5,a5,0xa
800016e0:	00c79793          	slli	a5,a5,0xc
800016e4:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
800016e8:	fe042683          	lw	a3,-32(s0)
800016ec:	fe442603          	lw	a2,-28(s0)
800016f0:	fec42583          	lw	a1,-20(s0)
800016f4:	8000c7b7          	lui	a5,0x8000c
800016f8:	3d078513          	addi	a0,a5,976 # 8000c3d0 <memend+0xf800c3d0>
800016fc:	ddcff0ef          	jal	ra,80000cd8 <printf>
            for(int j=0;j<1024;j++){
80001700:	fe042423          	sw	zero,-24(s0)
80001704:	0580006f          	j	8000175c <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001708:	fe842783          	lw	a5,-24(s0)
8000170c:	00279793          	slli	a5,a5,0x2
80001710:	fe042703          	lw	a4,-32(s0)
80001714:	00f707b3          	add	a5,a4,a5
80001718:	0007a783          	lw	a5,0(a5)
8000171c:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001720:	fdc42783          	lw	a5,-36(s0)
80001724:	0017f793          	andi	a5,a5,1
80001728:	02078463          	beqz	a5,80001750 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
8000172c:	fdc42783          	lw	a5,-36(s0)
80001730:	00a7d793          	srli	a5,a5,0xa
80001734:	00c79793          	slli	a5,a5,0xc
80001738:	00078693          	mv	a3,a5
8000173c:	fdc42603          	lw	a2,-36(s0)
80001740:	fe842583          	lw	a1,-24(s0)
80001744:	8000c7b7          	lui	a5,0x8000c
80001748:	3e878513          	addi	a0,a5,1000 # 8000c3e8 <memend+0xf800c3e8>
8000174c:	d8cff0ef          	jal	ra,80000cd8 <printf>
            for(int j=0;j<1024;j++){
80001750:	fe842783          	lw	a5,-24(s0)
80001754:	00178793          	addi	a5,a5,1
80001758:	fef42423          	sw	a5,-24(s0)
8000175c:	fe842703          	lw	a4,-24(s0)
80001760:	3ff00793          	li	a5,1023
80001764:	fae7d2e3          	bge	a5,a4,80001708 <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001768:	fec42783          	lw	a5,-20(s0)
8000176c:	00178793          	addi	a5,a5,1
80001770:	fef42623          	sw	a5,-20(s0)
80001774:	fec42703          	lw	a4,-20(s0)
80001778:	3ff00793          	li	a5,1023
8000177c:	f2e7dce3          	bge	a5,a4,800016b4 <printpgt+0x1c>
                }
            }
        }
    }
}
80001780:	00000013          	nop
80001784:	00000013          	nop
80001788:	03c12083          	lw	ra,60(sp)
8000178c:	03812403          	lw	s0,56(sp)
80001790:	04010113          	addi	sp,sp,64
80001794:	00008067          	ret

80001798 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
80001798:	fd010113          	addi	sp,sp,-48
8000179c:	02112623          	sw	ra,44(sp)
800017a0:	02812423          	sw	s0,40(sp)
800017a4:	03010413          	addi	s0,sp,48
800017a8:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
800017ac:	fe042623          	sw	zero,-20(s0)
800017b0:	04c0006f          	j	800017fc <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
800017b4:	fec42783          	lw	a5,-20(s0)
800017b8:	00d79793          	slli	a5,a5,0xd
800017bc:	00078713          	mv	a4,a5
800017c0:	c00017b7          	lui	a5,0xc0001
800017c4:	00f707b3          	add	a5,a4,a5
800017c8:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
800017cc:	a79ff0ef          	jal	ra,80001244 <palloc>
800017d0:	00050793          	mv	a5,a0
800017d4:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
800017d8:	00600713          	li	a4,6
800017dc:	000016b7          	lui	a3,0x1
800017e0:	fe442603          	lw	a2,-28(s0)
800017e4:	fe842583          	lw	a1,-24(s0)
800017e8:	fdc42503          	lw	a0,-36(s0)
800017ec:	dc9ff0ef          	jal	ra,800015b4 <vmmap>
    for(int i=0;i<NPROC;i++){
800017f0:	fec42783          	lw	a5,-20(s0)
800017f4:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
800017f8:	fef42623          	sw	a5,-20(s0)
800017fc:	fec42703          	lw	a4,-20(s0)
80001800:	00300793          	li	a5,3
80001804:	fae7d8e3          	bge	a5,a4,800017b4 <mkstack+0x1c>
    }
}
80001808:	00000013          	nop
8000180c:	00000013          	nop
80001810:	02c12083          	lw	ra,44(sp)
80001814:	02812403          	lw	s0,40(sp)
80001818:	03010113          	addi	sp,sp,48
8000181c:	00008067          	ret

80001820 <kvminit>:

// 初始化虚拟内存
void kvminit(){
80001820:	ff010113          	addi	sp,sp,-16
80001824:	00112623          	sw	ra,12(sp)
80001828:	00812423          	sw	s0,8(sp)
8000182c:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001830:	a15ff0ef          	jal	ra,80001244 <palloc>
80001834:	00050713          	mv	a4,a0
80001838:	8000e7b7          	lui	a5,0x8000e
8000183c:	8ae7a423          	sw	a4,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
    memset(kpgt,0,PGSIZE);
80001840:	8000e7b7          	lui	a5,0x8000e
80001844:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001848:	00001637          	lui	a2,0x1
8000184c:	00000593          	li	a1,0
80001850:	00078513          	mv	a0,a5
80001854:	524000ef          	jal	ra,80001d78 <memset>

    // 映射 CLINT
    vmmap(kpgt,CLINT_BASE,CLINT_BASE,0xc000,PTE_R|PTE_W);
80001858:	8000e7b7          	lui	a5,0x8000e
8000185c:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001860:	00600713          	li	a4,6
80001864:	0000c6b7          	lui	a3,0xc
80001868:	02000637          	lui	a2,0x2000
8000186c:	020005b7          	lui	a1,0x2000
80001870:	00078513          	mv	a0,a5
80001874:	d41ff0ef          	jal	ra,800015b4 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
80001878:	8000e7b7          	lui	a5,0x8000e
8000187c:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001880:	00600713          	li	a4,6
80001884:	004006b7          	lui	a3,0x400
80001888:	0c000637          	lui	a2,0xc000
8000188c:	0c0005b7          	lui	a1,0xc000
80001890:	00078513          	mv	a0,a5
80001894:	d21ff0ef          	jal	ra,800015b4 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
80001898:	8000e7b7          	lui	a5,0x8000e
8000189c:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018a0:	00600713          	li	a4,6
800018a4:	000016b7          	lui	a3,0x1
800018a8:	10000637          	lui	a2,0x10000
800018ac:	100005b7          	lui	a1,0x10000
800018b0:	00078513          	mv	a0,a5
800018b4:	d01ff0ef          	jal	ra,800015b4 <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
800018b8:	8000e7b7          	lui	a5,0x8000e
800018bc:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018c0:	800007b7          	lui	a5,0x80000
800018c4:	00078593          	mv	a1,a5
800018c8:	800007b7          	lui	a5,0x80000
800018cc:	00078613          	mv	a2,a5
800018d0:	800027b7          	lui	a5,0x80002
800018d4:	3e078713          	addi	a4,a5,992 # 800023e0 <memend+0xf80023e0>
800018d8:	800007b7          	lui	a5,0x80000
800018dc:	00078793          	mv	a5,a5
800018e0:	40f707b3          	sub	a5,a4,a5
800018e4:	00a00713          	li	a4,10
800018e8:	00078693          	mv	a3,a5
800018ec:	cc9ff0ef          	jal	ra,800015b4 <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
800018f0:	8000e7b7          	lui	a5,0x8000e
800018f4:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018f8:	800037b7          	lui	a5,0x80003
800018fc:	00078593          	mv	a1,a5
80001900:	800037b7          	lui	a5,0x80003
80001904:	00078613          	mv	a2,a5
80001908:	8000b7b7          	lui	a5,0x8000b
8000190c:	00478713          	addi	a4,a5,4 # 8000b004 <memend+0xf800b004>
80001910:	800037b7          	lui	a5,0x80003
80001914:	00078793          	mv	a5,a5
80001918:	40f707b3          	sub	a5,a4,a5
8000191c:	00600713          	li	a4,6
80001920:	00078693          	mv	a3,a5
80001924:	c91ff0ef          	jal	ra,800015b4 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001928:	8000e7b7          	lui	a5,0x8000e
8000192c:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001930:	8000c7b7          	lui	a5,0x8000c
80001934:	00078593          	mv	a1,a5
80001938:	8000c7b7          	lui	a5,0x8000c
8000193c:	00078613          	mv	a2,a5
80001940:	8000c7b7          	lui	a5,0x8000c
80001944:	3ff78713          	addi	a4,a5,1023 # 8000c3ff <memend+0xf800c3ff>
80001948:	8000c7b7          	lui	a5,0x8000c
8000194c:	00078793          	mv	a5,a5
80001950:	40f707b3          	sub	a5,a4,a5
80001954:	00200713          	li	a4,2
80001958:	00078693          	mv	a3,a5
8000195c:	c59ff0ef          	jal	ra,800015b4 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001960:	8000e7b7          	lui	a5,0x8000e
80001964:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001968:	8000d7b7          	lui	a5,0x8000d
8000196c:	00078593          	mv	a1,a5
80001970:	8000d7b7          	lui	a5,0x8000d
80001974:	00078613          	mv	a2,a5
80001978:	8000e7b7          	lui	a5,0x8000e
8000197c:	9f078713          	addi	a4,a5,-1552 # 8000d9f0 <memend+0xf800d9f0>
80001980:	8000d7b7          	lui	a5,0x8000d
80001984:	00078793          	mv	a5,a5
80001988:	40f707b3          	sub	a5,a4,a5
8000198c:	00600713          	li	a4,6
80001990:	00078693          	mv	a3,a5
80001994:	c21ff0ef          	jal	ra,800015b4 <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001998:	8000e7b7          	lui	a5,0x8000e
8000199c:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019a0:	8000e7b7          	lui	a5,0x8000e
800019a4:	00078593          	mv	a1,a5
800019a8:	8000e7b7          	lui	a5,0x8000e
800019ac:	00078613          	mv	a2,a5
800019b0:	880007b7          	lui	a5,0x88000
800019b4:	00078713          	mv	a4,a5
800019b8:	8000e7b7          	lui	a5,0x8000e
800019bc:	00078793          	mv	a5,a5
800019c0:	40f707b3          	sub	a5,a4,a5
800019c4:	00600713          	li	a4,6
800019c8:	00078693          	mv	a3,a5
800019cc:	be9ff0ef          	jal	ra,800015b4 <vmmap>

    mkstack(kpgt);
800019d0:	8000e7b7          	lui	a5,0x8000e
800019d4:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019d8:	00078513          	mv	a0,a5
800019dc:	dbdff0ef          	jal	ra,80001798 <mkstack>

    // 映射 usertrap
    vmmap(kpgt,USERTRAP,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
800019e0:	8000e7b7          	lui	a5,0x8000e
800019e4:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019e8:	800007b7          	lui	a5,0x80000
800019ec:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
800019f0:	00a00713          	li	a4,10
800019f4:	000016b7          	lui	a3,0x1
800019f8:	00078613          	mv	a2,a5
800019fc:	fffff5b7          	lui	a1,0xfffff
80001a00:	bb5ff0ef          	jal	ra,800015b4 <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001a04:	8000e7b7          	lui	a5,0x8000e
80001a08:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001a0c:	00c7d713          	srli	a4,a5,0xc
80001a10:	800007b7          	lui	a5,0x80000
80001a14:	00f767b3          	or	a5,a4,a5
80001a18:	00078513          	mv	a0,a5
80001a1c:	a9dff0ef          	jal	ra,800014b8 <w_satp>
    sfence_vma();       // 刷新页表
80001a20:	ac1ff0ef          	jal	ra,800014e0 <sfence_vma>
}
80001a24:	00000013          	nop
80001a28:	00c12083          	lw	ra,12(sp)
80001a2c:	00812403          	lw	s0,8(sp)
80001a30:	01010113          	addi	sp,sp,16
80001a34:	00008067          	ret

80001a38 <pgtcreate>:

addr_t* pgtcreate(){
80001a38:	fe010113          	addi	sp,sp,-32
80001a3c:	00112e23          	sw	ra,28(sp)
80001a40:	00812c23          	sw	s0,24(sp)
80001a44:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001a48:	ffcff0ef          	jal	ra,80001244 <palloc>
80001a4c:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001a50:	fec42783          	lw	a5,-20(s0)
}
80001a54:	00078513          	mv	a0,a5
80001a58:	01c12083          	lw	ra,28(sp)
80001a5c:	01812403          	lw	s0,24(sp)
80001a60:	02010113          	addi	sp,sp,32
80001a64:	00008067          	ret

80001a68 <r_tp>:
static inline uint32 r_tp(){
80001a68:	fe010113          	addi	sp,sp,-32
80001a6c:	00812e23          	sw	s0,28(sp)
80001a70:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001a74:	00020793          	mv	a5,tp
80001a78:	fef42623          	sw	a5,-20(s0)
    return x;
80001a7c:	fec42783          	lw	a5,-20(s0)
}
80001a80:	00078513          	mv	a0,a5
80001a84:	01c12403          	lw	s0,28(sp)
80001a88:	02010113          	addi	sp,sp,32
80001a8c:	00008067          	ret

80001a90 <procinit>:
#include "defs.h"
#include "riscv.h"

uint nextpid=0;

void procinit(){
80001a90:	fe010113          	addi	sp,sp,-32
80001a94:	00812e23          	sw	s0,28(sp)
80001a98:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001a9c:	fe042623          	sw	zero,-20(s0)
80001aa0:	0480006f          	j	80001ae8 <procinit+0x58>
        p=&proc[i];
80001aa4:	fec42703          	lw	a4,-20(s0)
80001aa8:	11800793          	li	a5,280
80001aac:	02f70733          	mul	a4,a4,a5
80001ab0:	8000d7b7          	lui	a5,0x8000d
80001ab4:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001ab8:	00f707b3          	add	a5,a4,a5
80001abc:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
80001ac0:	fec42783          	lw	a5,-20(s0)
80001ac4:	00d79793          	slli	a5,a5,0xd
80001ac8:	00078713          	mv	a4,a5
80001acc:	c00027b7          	lui	a5,0xc0002
80001ad0:	00f70733          	add	a4,a4,a5
80001ad4:	fe842783          	lw	a5,-24(s0)
80001ad8:	10e7aa23          	sw	a4,276(a5) # c0002114 <memend+0x38002114>
    for(int i=0;i<NPROC;i++){
80001adc:	fec42783          	lw	a5,-20(s0)
80001ae0:	00178793          	addi	a5,a5,1
80001ae4:	fef42623          	sw	a5,-20(s0)
80001ae8:	fec42703          	lw	a4,-20(s0)
80001aec:	00300793          	li	a5,3
80001af0:	fae7dae3          	bge	a5,a4,80001aa4 <procinit+0x14>
    }
}
80001af4:	00000013          	nop
80001af8:	00000013          	nop
80001afc:	01c12403          	lw	s0,28(sp)
80001b00:	02010113          	addi	sp,sp,32
80001b04:	00008067          	ret

80001b08 <nowproc>:

struct pcb* nowproc(){
80001b08:	fe010113          	addi	sp,sp,-32
80001b0c:	00112e23          	sw	ra,28(sp)
80001b10:	00812c23          	sw	s0,24(sp)
80001b14:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80001b18:	f51ff0ef          	jal	ra,80001a68 <r_tp>
80001b1c:	00050793          	mv	a5,a0
80001b20:	fef42623          	sw	a5,-20(s0)
    return cpu[hart].proc;
80001b24:	8000e7b7          	lui	a5,0x8000e
80001b28:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001b2c:	fec42783          	lw	a5,-20(s0)
80001b30:	00379793          	slli	a5,a5,0x3
80001b34:	00f707b3          	add	a5,a4,a5
80001b38:	0007a783          	lw	a5,0(a5)
}
80001b3c:	00078513          	mv	a0,a5
80001b40:	01c12083          	lw	ra,28(sp)
80001b44:	01812403          	lw	s0,24(sp)
80001b48:	02010113          	addi	sp,sp,32
80001b4c:	00008067          	ret

80001b50 <pidalloc>:

uint pidalloc(){
80001b50:	ff010113          	addi	sp,sp,-16
80001b54:	00812623          	sw	s0,12(sp)
80001b58:	01010413          	addi	s0,sp,16
    return nextpid++;
80001b5c:	8000d7b7          	lui	a5,0x8000d
80001b60:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
80001b64:	00178693          	addi	a3,a5,1
80001b68:	8000d737          	lui	a4,0x8000d
80001b6c:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
} 
80001b70:	00078513          	mv	a0,a5
80001b74:	00c12403          	lw	s0,12(sp)
80001b78:	01010113          	addi	sp,sp,16
80001b7c:	00008067          	ret

80001b80 <procalloc>:

struct pcb* procalloc(){
80001b80:	fe010113          	addi	sp,sp,-32
80001b84:	00112e23          	sw	ra,28(sp)
80001b88:	00812c23          	sw	s0,24(sp)
80001b8c:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80001b90:	8000d7b7          	lui	a5,0x8000d
80001b94:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001b98:	fef42623          	sw	a5,-20(s0)
80001b9c:	0680006f          	j	80001c04 <procalloc+0x84>
        if(p->status==UNUSED){
80001ba0:	fec42783          	lw	a5,-20(s0)
80001ba4:	0047a783          	lw	a5,4(a5)
80001ba8:	04079863          	bnez	a5,80001bf8 <procalloc+0x78>
            p->pid=pidalloc();
80001bac:	fa5ff0ef          	jal	ra,80001b50 <pidalloc>
80001bb0:	00050793          	mv	a5,a0
80001bb4:	00078713          	mv	a4,a5
80001bb8:	fec42783          	lw	a5,-20(s0)
80001bbc:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80001bc0:	fec42783          	lw	a5,-20(s0)
80001bc4:	00100713          	li	a4,1
80001bc8:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
80001bcc:	e6dff0ef          	jal	ra,80001a38 <pgtcreate>
80001bd0:	00050713          	mv	a4,a0
80001bd4:	fec42783          	lw	a5,-20(s0)
80001bd8:	10e7a823          	sw	a4,272(a5)
            
            p->trapframe.epc=0;
80001bdc:	fec42783          	lw	a5,-20(s0)
80001be0:	0007aa23          	sw	zero,20(a5)
            p->trapframe.sp=KSPACE;
80001be4:	fec42783          	lw	a5,-20(s0)
80001be8:	c0000737          	lui	a4,0xc0000
80001bec:	00e7ae23          	sw	a4,28(a5)

            return p;
80001bf0:	fec42783          	lw	a5,-20(s0)
80001bf4:	0240006f          	j	80001c18 <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
80001bf8:	fec42783          	lw	a5,-20(s0)
80001bfc:	11878793          	addi	a5,a5,280
80001c00:	fef42623          	sw	a5,-20(s0)
80001c04:	fec42703          	lw	a4,-20(s0)
80001c08:	8000e7b7          	lui	a5,0x8000e
80001c0c:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001c10:	f8f768e3          	bltu	a4,a5,80001ba0 <procalloc+0x20>
        }
    }
    return 0;
80001c14:	00000793          	li	a5,0
}
80001c18:	00078513          	mv	a0,a5
80001c1c:	01c12083          	lw	ra,28(sp)
80001c20:	01812403          	lw	s0,24(sp)
80001c24:	02010113          	addi	sp,sp,32
80001c28:	00008067          	ret

80001c2c <userinit>:

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
80001c2c:	fe010113          	addi	sp,sp,-32
80001c30:	00112e23          	sw	ra,28(sp)
80001c34:	00812c23          	sw	s0,24(sp)
80001c38:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80001c3c:	f45ff0ef          	jal	ra,80001b80 <procalloc>
80001c40:	fea42623          	sw	a0,-20(s0)
    
    char* m=(char*)palloc();
80001c44:	e00ff0ef          	jal	ra,80001244 <palloc>
80001c48:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80001c4c:	00400613          	li	a2,4
80001c50:	00000693          	li	a3,0
80001c54:	800037b7          	lui	a5,0x80003
80001c58:	00078593          	mv	a1,a5
80001c5c:	fe842503          	lw	a0,-24(s0)
80001c60:	184000ef          	jal	ra,80001de4 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X|PTE_U);
80001c64:	fec42783          	lw	a5,-20(s0)
80001c68:	1107a783          	lw	a5,272(a5) # 80003110 <memend+0xf8003110>
80001c6c:	fe842603          	lw	a2,-24(s0)
80001c70:	01e00713          	li	a4,30
80001c74:	000016b7          	lui	a3,0x1
80001c78:	00000593          	li	a1,0
80001c7c:	00078513          	mv	a0,a5
80001c80:	935ff0ef          	jal	ra,800015b4 <vmmap>
    vmmap(p->pagetable,USERTRAP,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
80001c84:	fec42783          	lw	a5,-20(s0)
80001c88:	1107a503          	lw	a0,272(a5)
80001c8c:	800007b7          	lui	a5,0x80000
80001c90:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001c94:	00a00713          	li	a4,10
80001c98:	000016b7          	lui	a3,0x1
80001c9c:	00078613          	mv	a2,a5
80001ca0:	fffff5b7          	lui	a1,0xfffff
80001ca4:	911ff0ef          	jal	ra,800015b4 <vmmap>

    p->context.sp=KSPACE;
80001ca8:	fec42783          	lw	a5,-20(s0)
80001cac:	c0000737          	lui	a4,0xc0000
80001cb0:	08e7ac23          	sw	a4,152(a5)

    p->pagetable=(SATP_SV32|((reg_t)p->pagetable)>>12);
80001cb4:	fec42783          	lw	a5,-20(s0)
80001cb8:	1107a783          	lw	a5,272(a5)
80001cbc:	00c7d713          	srli	a4,a5,0xc
80001cc0:	800007b7          	lui	a5,0x80000
80001cc4:	00f767b3          	or	a5,a4,a5
80001cc8:	00078713          	mv	a4,a5
80001ccc:	fec42783          	lw	a5,-20(s0)
80001cd0:	10e7a823          	sw	a4,272(a5) # 80000110 <memend+0xf8000110>
    p->trapframe.ksp=p->kernelstack;
80001cd4:	fec42783          	lw	a5,-20(s0)
80001cd8:	1147a703          	lw	a4,276(a5)
80001cdc:	fec42783          	lw	a5,-20(s0)
80001ce0:	00e7a823          	sw	a4,16(a5)

    p->status=RUNABLE;
80001ce4:	fec42783          	lw	a5,-20(s0)
80001ce8:	00200713          	li	a4,2
80001cec:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
80001cf0:	fec42783          	lw	a5,-20(s0)
80001cf4:	1107a783          	lw	a5,272(a5)
80001cf8:	00078513          	mv	a0,a5
80001cfc:	a9dff0ef          	jal	ra,80001798 <mkstack>

    int id=r_tp();
80001d00:	d69ff0ef          	jal	ra,80001a68 <r_tp>
80001d04:	00050793          	mv	a5,a0
80001d08:	fef42223          	sw	a5,-28(s0)
    cpu[id].proc=p;
80001d0c:	8000e7b7          	lui	a5,0x8000e
80001d10:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001d14:	fe442783          	lw	a5,-28(s0)
80001d18:	00379793          	slli	a5,a5,0x3
80001d1c:	00f707b3          	add	a5,a4,a5
80001d20:	fec42703          	lw	a4,-20(s0)
80001d24:	00e7a023          	sw	a4,0(a5)
}
80001d28:	00000013          	nop
80001d2c:	01c12083          	lw	ra,28(sp)
80001d30:	01812403          	lw	s0,24(sp)
80001d34:	02010113          	addi	sp,sp,32
80001d38:	00008067          	ret

80001d3c <schedule>:

void schedule(){
80001d3c:	fe010113          	addi	sp,sp,-32
80001d40:	00812e23          	sw	s0,28(sp)
80001d44:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
80001d48:	8000d7b7          	lui	a5,0x8000d
80001d4c:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001d50:	fef42623          	sw	a5,-20(s0)
80001d54:	0100006f          	j	80001d64 <schedule+0x28>
80001d58:	fec42783          	lw	a5,-20(s0)
80001d5c:	11878793          	addi	a5,a5,280
80001d60:	fef42623          	sw	a5,-20(s0)
80001d64:	fec42703          	lw	a4,-20(s0)
80001d68:	8000e7b7          	lui	a5,0x8000e
80001d6c:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001d70:	fef764e3          	bltu	a4,a5,80001d58 <schedule+0x1c>
    for(;;){
80001d74:	fd5ff06f          	j	80001d48 <schedule+0xc>

80001d78 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80001d78:	fd010113          	addi	sp,sp,-48
80001d7c:	02812623          	sw	s0,44(sp)
80001d80:	03010413          	addi	s0,sp,48
80001d84:	fca42e23          	sw	a0,-36(s0)
80001d88:	fcb42c23          	sw	a1,-40(s0)
80001d8c:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
80001d90:	fdc42783          	lw	a5,-36(s0)
80001d94:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001d98:	fe042623          	sw	zero,-20(s0)
80001d9c:	0280006f          	j	80001dc4 <memset+0x4c>
        maddr[i] = (char)c;
80001da0:	fe842703          	lw	a4,-24(s0)
80001da4:	fec42783          	lw	a5,-20(s0)
80001da8:	00f707b3          	add	a5,a4,a5
80001dac:	fd842703          	lw	a4,-40(s0)
80001db0:	0ff77713          	andi	a4,a4,255
80001db4:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001db8:	fec42783          	lw	a5,-20(s0)
80001dbc:	00178793          	addi	a5,a5,1
80001dc0:	fef42623          	sw	a5,-20(s0)
80001dc4:	fec42703          	lw	a4,-20(s0)
80001dc8:	fd442783          	lw	a5,-44(s0)
80001dcc:	fcf76ae3          	bltu	a4,a5,80001da0 <memset+0x28>
    }
    return addr;
80001dd0:	fdc42783          	lw	a5,-36(s0)
}
80001dd4:	00078513          	mv	a0,a5
80001dd8:	02c12403          	lw	s0,44(sp)
80001ddc:	03010113          	addi	sp,sp,48
80001de0:	00008067          	ret

80001de4 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80001de4:	fd010113          	addi	sp,sp,-48
80001de8:	02812623          	sw	s0,44(sp)
80001dec:	03010413          	addi	s0,sp,48
80001df0:	fca42e23          	sw	a0,-36(s0)
80001df4:	fcb42c23          	sw	a1,-40(s0)
80001df8:	fcc42823          	sw	a2,-48(s0)
80001dfc:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001e00:	fd042783          	lw	a5,-48(s0)
80001e04:	fd442703          	lw	a4,-44(s0)
80001e08:	00e7e7b3          	or	a5,a5,a4
80001e0c:	00079663          	bnez	a5,80001e18 <memmove+0x34>
        return dst;
80001e10:	fdc42783          	lw	a5,-36(s0)
80001e14:	1200006f          	j	80001f34 <memmove+0x150>
    }

    s = src;
80001e18:	fd842783          	lw	a5,-40(s0)
80001e1c:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001e20:	fdc42783          	lw	a5,-36(s0)
80001e24:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001e28:	fec42703          	lw	a4,-20(s0)
80001e2c:	fe842783          	lw	a5,-24(s0)
80001e30:	0cf77263          	bgeu	a4,a5,80001ef4 <memmove+0x110>
80001e34:	fd042783          	lw	a5,-48(s0)
80001e38:	fec42703          	lw	a4,-20(s0)
80001e3c:	00f707b3          	add	a5,a4,a5
80001e40:	fe842703          	lw	a4,-24(s0)
80001e44:	0af77863          	bgeu	a4,a5,80001ef4 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80001e48:	fd042783          	lw	a5,-48(s0)
80001e4c:	fec42703          	lw	a4,-20(s0)
80001e50:	00f707b3          	add	a5,a4,a5
80001e54:	fef42623          	sw	a5,-20(s0)
        d += n;
80001e58:	fd042783          	lw	a5,-48(s0)
80001e5c:	fe842703          	lw	a4,-24(s0)
80001e60:	00f707b3          	add	a5,a4,a5
80001e64:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80001e68:	02c0006f          	j	80001e94 <memmove+0xb0>
            *--d = *--s;
80001e6c:	fec42783          	lw	a5,-20(s0)
80001e70:	fff78793          	addi	a5,a5,-1
80001e74:	fef42623          	sw	a5,-20(s0)
80001e78:	fe842783          	lw	a5,-24(s0)
80001e7c:	fff78793          	addi	a5,a5,-1
80001e80:	fef42423          	sw	a5,-24(s0)
80001e84:	fec42783          	lw	a5,-20(s0)
80001e88:	0007c703          	lbu	a4,0(a5)
80001e8c:	fe842783          	lw	a5,-24(s0)
80001e90:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80001e94:	fd042703          	lw	a4,-48(s0)
80001e98:	fd442783          	lw	a5,-44(s0)
80001e9c:	fff00513          	li	a0,-1
80001ea0:	fff00593          	li	a1,-1
80001ea4:	00a70633          	add	a2,a4,a0
80001ea8:	00060813          	mv	a6,a2
80001eac:	00e83833          	sltu	a6,a6,a4
80001eb0:	00b786b3          	add	a3,a5,a1
80001eb4:	00d805b3          	add	a1,a6,a3
80001eb8:	00058693          	mv	a3,a1
80001ebc:	fcc42823          	sw	a2,-48(s0)
80001ec0:	fcd42a23          	sw	a3,-44(s0)
80001ec4:	00070693          	mv	a3,a4
80001ec8:	00f6e6b3          	or	a3,a3,a5
80001ecc:	fa0690e3          	bnez	a3,80001e6c <memmove+0x88>
    if(s < d && s + n > d){     
80001ed0:	0600006f          	j	80001f30 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80001ed4:	fec42703          	lw	a4,-20(s0)
80001ed8:	00170793          	addi	a5,a4,1 # c0000001 <memend+0x38000001>
80001edc:	fef42623          	sw	a5,-20(s0)
80001ee0:	fe842783          	lw	a5,-24(s0)
80001ee4:	00178693          	addi	a3,a5,1
80001ee8:	fed42423          	sw	a3,-24(s0)
80001eec:	00074703          	lbu	a4,0(a4)
80001ef0:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80001ef4:	fd042703          	lw	a4,-48(s0)
80001ef8:	fd442783          	lw	a5,-44(s0)
80001efc:	fff00513          	li	a0,-1
80001f00:	fff00593          	li	a1,-1
80001f04:	00a70633          	add	a2,a4,a0
80001f08:	00060813          	mv	a6,a2
80001f0c:	00e83833          	sltu	a6,a6,a4
80001f10:	00b786b3          	add	a3,a5,a1
80001f14:	00d805b3          	add	a1,a6,a3
80001f18:	00058693          	mv	a3,a1
80001f1c:	fcc42823          	sw	a2,-48(s0)
80001f20:	fcd42a23          	sw	a3,-44(s0)
80001f24:	00070693          	mv	a3,a4
80001f28:	00f6e6b3          	or	a3,a3,a5
80001f2c:	fa0694e3          	bnez	a3,80001ed4 <memmove+0xf0>
        }
    }
    return dst;
80001f30:	fdc42783          	lw	a5,-36(s0)
}
80001f34:	00078513          	mv	a0,a5
80001f38:	02c12403          	lw	s0,44(sp)
80001f3c:	03010113          	addi	sp,sp,48
80001f40:	00008067          	ret

80001f44 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80001f44:	fd010113          	addi	sp,sp,-48
80001f48:	02812623          	sw	s0,44(sp)
80001f4c:	03010413          	addi	s0,sp,48
80001f50:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80001f54:	00000793          	li	a5,0
80001f58:	00000813          	li	a6,0
80001f5c:	fef42423          	sw	a5,-24(s0)
80001f60:	ff042623          	sw	a6,-20(s0)
80001f64:	0340006f          	j	80001f98 <strlen+0x54>
80001f68:	fe842603          	lw	a2,-24(s0)
80001f6c:	fec42683          	lw	a3,-20(s0)
80001f70:	00100513          	li	a0,1
80001f74:	00000593          	li	a1,0
80001f78:	00a60733          	add	a4,a2,a0
80001f7c:	00070813          	mv	a6,a4
80001f80:	00c83833          	sltu	a6,a6,a2
80001f84:	00b687b3          	add	a5,a3,a1
80001f88:	00f806b3          	add	a3,a6,a5
80001f8c:	00068793          	mv	a5,a3
80001f90:	fee42423          	sw	a4,-24(s0)
80001f94:	fef42623          	sw	a5,-20(s0)
80001f98:	fe842783          	lw	a5,-24(s0)
80001f9c:	fdc42703          	lw	a4,-36(s0)
80001fa0:	00f707b3          	add	a5,a4,a5
80001fa4:	0007c783          	lbu	a5,0(a5)
80001fa8:	fc0790e3          	bnez	a5,80001f68 <strlen+0x24>
    
    return n;
80001fac:	fe842703          	lw	a4,-24(s0)
80001fb0:	fec42783          	lw	a5,-20(s0)
80001fb4:	00070513          	mv	a0,a4
80001fb8:	00078593          	mv	a1,a5
80001fbc:	02c12403          	lw	s0,44(sp)
80001fc0:	03010113          	addi	sp,sp,48
80001fc4:	00008067          	ret

80001fc8 <r_tp>:
static inline uint32 r_tp(){
80001fc8:	fe010113          	addi	sp,sp,-32
80001fcc:	00812e23          	sw	s0,28(sp)
80001fd0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001fd4:	00020793          	mv	a5,tp
80001fd8:	fef42623          	sw	a5,-20(s0)
    return x;
80001fdc:	fec42783          	lw	a5,-20(s0)
}
80001fe0:	00078513          	mv	a0,a5
80001fe4:	01c12403          	lw	s0,28(sp)
80001fe8:	02010113          	addi	sp,sp,32
80001fec:	00008067          	ret

80001ff0 <clintinit>:
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit(){
80001ff0:	fe010113          	addi	sp,sp,-32
80001ff4:	00112e23          	sw	ra,28(sp)
80001ff8:	00812c23          	sw	s0,24(sp)
80001ffc:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp 
    int hart=r_tp();
80002000:	fc9ff0ef          	jal	ra,80001fc8 <r_tp>
80002004:	00050793          	mv	a5,a0
80002008:	fef42623          	sw	a5,-20(s0)
    *(reg_t*)CLINT_MTIMECMP(hart)=*(reg_t*)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
8000200c:	fec42703          	lw	a4,-20(s0)
80002010:	004017b7          	lui	a5,0x401
80002014:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002018:	00f707b3          	add	a5,a4,a5
8000201c:	00379793          	slli	a5,a5,0x3
80002020:	0007a703          	lw	a4,0(a5)
80002024:	fec42683          	lw	a3,-20(s0)
80002028:	004017b7          	lui	a5,0x401
8000202c:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002030:	00f687b3          	add	a5,a3,a5
80002034:	00379793          	slli	a5,a5,0x3
80002038:	00078693          	mv	a3,a5
8000203c:	009897b7          	lui	a5,0x989
80002040:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80002044:	00f707b3          	add	a5,a4,a5
80002048:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
8000204c:	00000013          	nop
80002050:	01c12083          	lw	ra,28(sp)
80002054:	01812403          	lw	s0,24(sp)
80002058:	02010113          	addi	sp,sp,32
8000205c:	00008067          	ret

80002060 <r_mstatus>:
static inline uint32 r_mstatus(){
80002060:	fe010113          	addi	sp,sp,-32
80002064:	00812e23          	sw	s0,28(sp)
80002068:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus" : "=r" (x) );
8000206c:	300027f3          	csrr	a5,mstatus
80002070:	fef42623          	sw	a5,-20(s0)
    return x;
80002074:	fec42783          	lw	a5,-20(s0)
}
80002078:	00078513          	mv	a0,a5
8000207c:	01c12403          	lw	s0,28(sp)
80002080:	02010113          	addi	sp,sp,32
80002084:	00008067          	ret

80002088 <w_mstatus>:
static inline void w_mstatus(uint32 x){
80002088:	fe010113          	addi	sp,sp,-32
8000208c:	00812e23          	sw	s0,28(sp)
80002090:	02010413          	addi	s0,sp,32
80002094:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80002098:	fec42783          	lw	a5,-20(s0)
8000209c:	30079073          	csrw	mstatus,a5
}
800020a0:	00000013          	nop
800020a4:	01c12403          	lw	s0,28(sp)
800020a8:	02010113          	addi	sp,sp,32
800020ac:	00008067          	ret

800020b0 <w_mtvec>:
static inline void w_mtvec(uint32 x){
800020b0:	fe010113          	addi	sp,sp,-32
800020b4:	00812e23          	sw	s0,28(sp)
800020b8:	02010413          	addi	s0,sp,32
800020bc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0" : : "r"(x));
800020c0:	fec42783          	lw	a5,-20(s0)
800020c4:	30579073          	csrw	mtvec,a5
}
800020c8:	00000013          	nop
800020cc:	01c12403          	lw	s0,28(sp)
800020d0:	02010113          	addi	sp,sp,32
800020d4:	00008067          	ret

800020d8 <r_tp>:
static inline uint32 r_tp(){
800020d8:	fe010113          	addi	sp,sp,-32
800020dc:	00812e23          	sw	s0,28(sp)
800020e0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800020e4:	00020793          	mv	a5,tp
800020e8:	fef42623          	sw	a5,-20(s0)
    return x;
800020ec:	fec42783          	lw	a5,-20(s0)
}
800020f0:	00078513          	mv	a0,a5
800020f4:	01c12403          	lw	s0,28(sp)
800020f8:	02010113          	addi	sp,sp,32
800020fc:	00008067          	ret

80002100 <s_mstatus_intr>:
static inline void s_mstatus_intr(uint32 m){
80002100:	fd010113          	addi	sp,sp,-48
80002104:	02112623          	sw	ra,44(sp)
80002108:	02812423          	sw	s0,40(sp)
8000210c:	03010413          	addi	s0,sp,48
80002110:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80002114:	f4dff0ef          	jal	ra,80002060 <r_mstatus>
80002118:	fea42623          	sw	a0,-20(s0)
    switch (m)
8000211c:	fdc42703          	lw	a4,-36(s0)
80002120:	08000793          	li	a5,128
80002124:	04f70263          	beq	a4,a5,80002168 <s_mstatus_intr+0x68>
80002128:	fdc42703          	lw	a4,-36(s0)
8000212c:	08000793          	li	a5,128
80002130:	0ae7e463          	bltu	a5,a4,800021d8 <s_mstatus_intr+0xd8>
80002134:	fdc42703          	lw	a4,-36(s0)
80002138:	02000793          	li	a5,32
8000213c:	04f70463          	beq	a4,a5,80002184 <s_mstatus_intr+0x84>
80002140:	fdc42703          	lw	a4,-36(s0)
80002144:	02000793          	li	a5,32
80002148:	08e7e863          	bltu	a5,a4,800021d8 <s_mstatus_intr+0xd8>
8000214c:	fdc42703          	lw	a4,-36(s0)
80002150:	00200793          	li	a5,2
80002154:	06f70463          	beq	a4,a5,800021bc <s_mstatus_intr+0xbc>
80002158:	fdc42703          	lw	a4,-36(s0)
8000215c:	00800793          	li	a5,8
80002160:	04f70063          	beq	a4,a5,800021a0 <s_mstatus_intr+0xa0>
        break;
80002164:	0740006f          	j	800021d8 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
80002168:	fec42783          	lw	a5,-20(s0)
8000216c:	f7f7f793          	andi	a5,a5,-129
80002170:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
80002174:	fec42783          	lw	a5,-20(s0)
80002178:	0807e793          	ori	a5,a5,128
8000217c:	fef42623          	sw	a5,-20(s0)
        break;
80002180:	05c0006f          	j	800021dc <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
80002184:	fec42783          	lw	a5,-20(s0)
80002188:	fdf7f793          	andi	a5,a5,-33
8000218c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
80002190:	fec42783          	lw	a5,-20(s0)
80002194:	0207e793          	ori	a5,a5,32
80002198:	fef42623          	sw	a5,-20(s0)
        break;
8000219c:	0400006f          	j	800021dc <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
800021a0:	fec42783          	lw	a5,-20(s0)
800021a4:	ff77f793          	andi	a5,a5,-9
800021a8:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
800021ac:	fec42783          	lw	a5,-20(s0)
800021b0:	0087e793          	ori	a5,a5,8
800021b4:	fef42623          	sw	a5,-20(s0)
        break;
800021b8:	0240006f          	j	800021dc <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
800021bc:	fec42783          	lw	a5,-20(s0)
800021c0:	ffd7f793          	andi	a5,a5,-3
800021c4:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
800021c8:	fec42783          	lw	a5,-20(s0)
800021cc:	0027e793          	ori	a5,a5,2
800021d0:	fef42623          	sw	a5,-20(s0)
        break;
800021d4:	0080006f          	j	800021dc <s_mstatus_intr+0xdc>
        break;
800021d8:	00000013          	nop
    w_mstatus(x);
800021dc:	fec42503          	lw	a0,-20(s0)
800021e0:	ea9ff0ef          	jal	ra,80002088 <w_mstatus>
}
800021e4:	00000013          	nop
800021e8:	02c12083          	lw	ra,44(sp)
800021ec:	02812403          	lw	s0,40(sp)
800021f0:	03010113          	addi	sp,sp,48
800021f4:	00008067          	ret

800021f8 <r_sie>:
static inline uint32 r_sie(){
800021f8:	fe010113          	addi	sp,sp,-32
800021fc:	00812e23          	sw	s0,28(sp)
80002200:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie " : "=r"(x));
80002204:	104027f3          	csrr	a5,sie
80002208:	fef42623          	sw	a5,-20(s0)
    return x;
8000220c:	fec42783          	lw	a5,-20(s0)
}
80002210:	00078513          	mv	a0,a5
80002214:	01c12403          	lw	s0,28(sp)
80002218:	02010113          	addi	sp,sp,32
8000221c:	00008067          	ret

80002220 <w_sie>:
static inline void w_sie(uint32 x){
80002220:	fe010113          	addi	sp,sp,-32
80002224:	00812e23          	sw	s0,28(sp)
80002228:	02010413          	addi	s0,sp,32
8000222c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80002230:	fec42783          	lw	a5,-20(s0)
80002234:	10479073          	csrw	sie,a5
}
80002238:	00000013          	nop
8000223c:	01c12403          	lw	s0,28(sp)
80002240:	02010113          	addi	sp,sp,32
80002244:	00008067          	ret

80002248 <r_mie>:
#define MEIE (1<<11)
#define MTIE (1<<7)
#define MSIE (1<<3)
static inline uint32 r_mie(){
80002248:	fe010113          	addi	sp,sp,-32
8000224c:	00812e23          	sw	s0,28(sp)
80002250:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie " : "=r"(x));
80002254:	304027f3          	csrr	a5,mie
80002258:	fef42623          	sw	a5,-20(s0)
    return x;
8000225c:	fec42783          	lw	a5,-20(s0)
}
80002260:	00078513          	mv	a0,a5
80002264:	01c12403          	lw	s0,28(sp)
80002268:	02010113          	addi	sp,sp,32
8000226c:	00008067          	ret

80002270 <w_mie>:
static inline void w_mie(uint32 x){
80002270:	fe010113          	addi	sp,sp,-32
80002274:	00812e23          	sw	s0,28(sp)
80002278:	02010413          	addi	s0,sp,32
8000227c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"::"r"(x));
80002280:	fec42783          	lw	a5,-20(s0)
80002284:	30479073          	csrw	mie,a5
}
80002288:	00000013          	nop
8000228c:	01c12403          	lw	s0,28(sp)
80002290:	02010113          	addi	sp,sp,32
80002294:	00008067          	ret

80002298 <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x){
80002298:	fe010113          	addi	sp,sp,-32
8000229c:	00812e23          	sw	s0,28(sp)
800022a0:	02010413          	addi	s0,sp,32
800022a4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0" : :"r"(x));
800022a8:	fec42783          	lw	a5,-20(s0)
800022ac:	34079073          	csrw	mscratch,a5
800022b0:	00000013          	nop
800022b4:	01c12403          	lw	s0,28(sp)
800022b8:	02010113          	addi	sp,sp,32
800022bc:	00008067          	ret

800022c0 <timerinit>:

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit(){
800022c0:	fe010113          	addi	sp,sp,-32
800022c4:	00112e23          	sw	ra,28(sp)
800022c8:	00812c23          	sw	s0,24(sp)
800022cc:	01212a23          	sw	s2,20(sp)
800022d0:	01312823          	sw	s3,16(sp)
800022d4:	02010413          	addi	s0,sp,32
    uint hart=r_tp();
800022d8:	e01ff0ef          	jal	ra,800020d8 <r_tp>
800022dc:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
800022e0:	fec42703          	lw	a4,-20(s0)
800022e4:	00070793          	mv	a5,a4
800022e8:	00279793          	slli	a5,a5,0x2
800022ec:	00e787b3          	add	a5,a5,a4
800022f0:	00379793          	slli	a5,a5,0x3
800022f4:	8000e737          	lui	a4,0x8000e
800022f8:	8b070713          	addi	a4,a4,-1872 # 8000d8b0 <memend+0xf800d8b0>
800022fc:	00e787b3          	add	a5,a5,a4
80002300:	00078513          	mv	a0,a5
80002304:	f95ff0ef          	jal	ra,80002298 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
80002308:	fec42703          	lw	a4,-20(s0)
8000230c:	004017b7          	lui	a5,0x401
80002310:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002314:	00f707b3          	add	a5,a4,a5
80002318:	00379793          	slli	a5,a5,0x3
8000231c:	00078913          	mv	s2,a5
80002320:	00000993          	li	s3,0
80002324:	8000e7b7          	lui	a5,0x8000e
80002328:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
8000232c:	fec42703          	lw	a4,-20(s0)
80002330:	00070793          	mv	a5,a4
80002334:	00279793          	slli	a5,a5,0x2
80002338:	00e787b3          	add	a5,a5,a4
8000233c:	00379793          	slli	a5,a5,0x3
80002340:	00f687b3          	add	a5,a3,a5
80002344:	0127a023          	sw	s2,0(a5)
80002348:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;
8000234c:	8000e7b7          	lui	a5,0x8000e
80002350:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
80002354:	fec42703          	lw	a4,-20(s0)
80002358:	00070793          	mv	a5,a4
8000235c:	00279793          	slli	a5,a5,0x2
80002360:	00e787b3          	add	a5,a5,a4
80002364:	00379793          	slli	a5,a5,0x3
80002368:	00f686b3          	add	a3,a3,a5
8000236c:	00989737          	lui	a4,0x989
80002370:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002374:	00000793          	li	a5,0
80002378:	00e6a423          	sw	a4,8(a3)
8000237c:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数
80002380:	800007b7          	lui	a5,0x80000
80002384:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
80002388:	00078513          	mv	a0,a5
8000238c:	d25ff0ef          	jal	ra,800020b0 <w_mtvec>

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断
80002390:	00800513          	li	a0,8
80002394:	d6dff0ef          	jal	ra,80002100 <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
80002398:	e61ff0ef          	jal	ra,800021f8 <r_sie>
8000239c:	00050793          	mv	a5,a0
800023a0:	2227e793          	ori	a5,a5,546
800023a4:	00078513          	mv	a0,a5
800023a8:	e79ff0ef          	jal	ra,80002220 <w_sie>

    w_mie(r_mie() | MTIE );      // 开启 M-mode 时钟中断
800023ac:	e9dff0ef          	jal	ra,80002248 <r_mie>
800023b0:	00050793          	mv	a5,a0
800023b4:	0807e793          	ori	a5,a5,128
800023b8:	00078513          	mv	a0,a5
800023bc:	eb5ff0ef          	jal	ra,80002270 <w_mie>

    clintinit();                 // 初始化 CLINT           
800023c0:	c31ff0ef          	jal	ra,80001ff0 <clintinit>
800023c4:	00000013          	nop
800023c8:	01c12083          	lw	ra,28(sp)
800023cc:	01812403          	lw	s0,24(sp)
800023d0:	01412903          	lw	s2,20(sp)
800023d4:	01012983          	lw	s3,16(sp)
800023d8:	02010113          	addi	sp,sp,32
800023dc:	00008067          	ret

800023e0 <textend>:
	...
