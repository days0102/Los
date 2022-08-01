
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
80000010:	ffc10113          	addi	sp,sp,-4 # 80003008 <stacks>
    li t1,sz
80000014:	00001337          	lui	t1,0x1
    mul t1,t1,t0
80000018:	02530333          	mul	t1,t1,t0
    add sp,sp,t1 # 栈指针指向栈顶
8000001c:	00610133          	add	sp,sp,t1
    
    # 跳转到start()
    j start
80000020:	6100006f          	j	80000630 <start>

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
800000ac:	359000ef          	jal	ra,80000c04 <trapvec>

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

80000298 <usertrap>:

.global uservec
uservec:
.global usertrap
usertrap:
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

8000031c <userret>:

.global userret
userret:
    lw sp,20(a0)
8000031c:	01452103          	lw	sp,20(a0)
    lw t0,12(a0)
80000320:	00c52283          	lw	t0,12(a0)

    csrw satp,a1
80000324:	18059073          	csrw	satp,a1
    sfence.vma zero, zero
80000328:	12000073          	sfence.vma

    csrw sepc,t0
8000032c:	14129073          	csrw	sepc,t0

    # lw a0,32(a0)
    # lw t6,12(a0)
    # csrw sepc,t6

80000330:	10200073          	sret

80000334 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80000334:	fe010113          	addi	sp,sp,-32
80000338:	00812e23          	sw	s0,28(sp)
8000033c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80000340:	300027f3          	csrr	a5,mstatus
80000344:	fef42623          	sw	a5,-20(s0)
    return x;
80000348:	fec42783          	lw	a5,-20(s0)
}
8000034c:	00078513          	mv	a0,a5
80000350:	01c12403          	lw	s0,28(sp)
80000354:	02010113          	addi	sp,sp,32
80000358:	00008067          	ret

8000035c <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
8000035c:	fe010113          	addi	sp,sp,-32
80000360:	00812e23          	sw	s0,28(sp)
80000364:	02010413          	addi	s0,sp,32
80000368:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
8000036c:	fec42783          	lw	a5,-20(s0)
80000370:	30079073          	csrw	mstatus,a5
}
80000374:	00000013          	nop
80000378:	01c12403          	lw	s0,28(sp)
8000037c:	02010113          	addi	sp,sp,32
80000380:	00008067          	ret

80000384 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000384:	fd010113          	addi	sp,sp,-48
80000388:	02112623          	sw	ra,44(sp)
8000038c:	02812423          	sw	s0,40(sp)
80000390:	03010413          	addi	s0,sp,48
80000394:	00050793          	mv	a5,a0
80000398:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
8000039c:	f99ff0ef          	jal	ra,80000334 <r_mstatus>
800003a0:	fea42623          	sw	a0,-20(s0)
    switch (m)
800003a4:	fdf44783          	lbu	a5,-33(s0)
800003a8:	00300713          	li	a4,3
800003ac:	06e78063          	beq	a5,a4,8000040c <s_mstatus_xpp+0x88>
800003b0:	00300713          	li	a4,3
800003b4:	08f74263          	blt	a4,a5,80000438 <s_mstatus_xpp+0xb4>
800003b8:	00078863          	beqz	a5,800003c8 <s_mstatus_xpp+0x44>
800003bc:	00100713          	li	a4,1
800003c0:	02e78063          	beq	a5,a4,800003e0 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= M_MPP_SET;
        break;
    default:
        break;
800003c4:	0740006f          	j	80000438 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800003c8:	fec42703          	lw	a4,-20(s0)
800003cc:	ffffe7b7          	lui	a5,0xffffe
800003d0:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800003d4:	00f777b3          	and	a5,a4,a5
800003d8:	fef42623          	sw	a5,-20(s0)
        break;
800003dc:	0600006f          	j	8000043c <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800003e0:	fec42703          	lw	a4,-20(s0)
800003e4:	ffffe7b7          	lui	a5,0xffffe
800003e8:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800003ec:	00f777b3          	and	a5,a4,a5
800003f0:	fef42623          	sw	a5,-20(s0)
        x |= M_SPP_SET;
800003f4:	fec42703          	lw	a4,-20(s0)
800003f8:	000017b7          	lui	a5,0x1
800003fc:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
80000400:	00f767b3          	or	a5,a4,a5
80000404:	fef42623          	sw	a5,-20(s0)
        break;
80000408:	0340006f          	j	8000043c <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
8000040c:	fec42703          	lw	a4,-20(s0)
80000410:	ffffe7b7          	lui	a5,0xffffe
80000414:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000418:	00f777b3          	and	a5,a4,a5
8000041c:	fef42623          	sw	a5,-20(s0)
        x |= M_MPP_SET;
80000420:	fec42703          	lw	a4,-20(s0)
80000424:	000027b7          	lui	a5,0x2
80000428:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
8000042c:	00f767b3          	or	a5,a4,a5
80000430:	fef42623          	sw	a5,-20(s0)
        break;
80000434:	0080006f          	j	8000043c <s_mstatus_xpp+0xb8>
        break;
80000438:	00000013          	nop
    }
    w_mstatus(x);
8000043c:	fec42503          	lw	a0,-20(s0)
80000440:	f1dff0ef          	jal	ra,8000035c <w_mstatus>
}
80000444:	00000013          	nop
80000448:	02c12083          	lw	ra,44(sp)
8000044c:	02812403          	lw	s0,40(sp)
80000450:	03010113          	addi	sp,sp,48
80000454:	00008067          	ret

80000458 <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
80000458:	fe010113          	addi	sp,sp,-32
8000045c:	00812e23          	sw	s0,28(sp)
80000460:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000464:	100027f3          	csrr	a5,sstatus
80000468:	fef42623          	sw	a5,-20(s0)
    return x;
8000046c:	fec42783          	lw	a5,-20(s0)
}
80000470:	00078513          	mv	a0,a5
80000474:	01c12403          	lw	s0,28(sp)
80000478:	02010113          	addi	sp,sp,32
8000047c:	00008067          	ret

80000480 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
80000480:	fe010113          	addi	sp,sp,-32
80000484:	00812e23          	sw	s0,28(sp)
80000488:	02010413          	addi	s0,sp,32
8000048c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
80000490:	fec42783          	lw	a5,-20(s0)
80000494:	10079073          	csrw	sstatus,a5
}
80000498:	00000013          	nop
8000049c:	01c12403          	lw	s0,28(sp)
800004a0:	02010113          	addi	sp,sp,32
800004a4:	00008067          	ret

800004a8 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
800004a8:	fe010113          	addi	sp,sp,-32
800004ac:	00812e23          	sw	s0,28(sp)
800004b0:	02010413          	addi	s0,sp,32
800004b4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
800004b8:	fec42783          	lw	a5,-20(s0)
800004bc:	34179073          	csrw	mepc,a5
}
800004c0:	00000013          	nop
800004c4:	01c12403          	lw	s0,28(sp)
800004c8:	02010113          	addi	sp,sp,32
800004cc:	00008067          	ret

800004d0 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
800004d0:	fe010113          	addi	sp,sp,-32
800004d4:	00812e23          	sw	s0,28(sp)
800004d8:	02010413          	addi	s0,sp,32
800004dc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
800004e0:	fec42783          	lw	a5,-20(s0)
800004e4:	10579073          	csrw	stvec,a5
}
800004e8:	00000013          	nop
800004ec:	01c12403          	lw	s0,28(sp)
800004f0:	02010113          	addi	sp,sp,32
800004f4:	00008067          	ret

800004f8 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
800004f8:	fe010113          	addi	sp,sp,-32
800004fc:	00812e23          	sw	s0,28(sp)
80000500:	02010413          	addi	s0,sp,32
80000504:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
80000508:	fec42783          	lw	a5,-20(s0)
8000050c:	30379073          	csrw	mideleg,a5
}
80000510:	00000013          	nop
80000514:	01c12403          	lw	s0,28(sp)
80000518:	02010113          	addi	sp,sp,32
8000051c:	00008067          	ret

80000520 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
80000520:	fe010113          	addi	sp,sp,-32
80000524:	00812e23          	sw	s0,28(sp)
80000528:	02010413          	addi	s0,sp,32
8000052c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
80000530:	fec42783          	lw	a5,-20(s0)
80000534:	30279073          	csrw	medeleg,a5
}
80000538:	00000013          	nop
8000053c:	01c12403          	lw	s0,28(sp)
80000540:	02010113          	addi	sp,sp,32
80000544:	00008067          	ret

80000548 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
80000548:	fe010113          	addi	sp,sp,-32
8000054c:	00812e23          	sw	s0,28(sp)
80000550:	02010413          	addi	s0,sp,32
80000554:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80000558:	fec42783          	lw	a5,-20(s0)
8000055c:	18079073          	csrw	satp,a5
}
80000560:	00000013          	nop
80000564:	01c12403          	lw	s0,28(sp)
80000568:	02010113          	addi	sp,sp,32
8000056c:	00008067          	ret

80000570 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
80000570:	fd010113          	addi	sp,sp,-48
80000574:	02112623          	sw	ra,44(sp)
80000578:	02812423          	sw	s0,40(sp)
8000057c:	03010413          	addi	s0,sp,48
80000580:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
80000584:	ed5ff0ef          	jal	ra,80000458 <r_sstatus>
80000588:	fea42623          	sw	a0,-20(s0)
    switch (m)
8000058c:	fdc42703          	lw	a4,-36(s0)
80000590:	ffd00793          	li	a5,-3
80000594:	06f70863          	beq	a4,a5,80000604 <s_sstatus_intr+0x94>
80000598:	fdc42703          	lw	a4,-36(s0)
8000059c:	ffd00793          	li	a5,-3
800005a0:	06e7e863          	bltu	a5,a4,80000610 <s_sstatus_intr+0xa0>
800005a4:	fdc42703          	lw	a4,-36(s0)
800005a8:	fdf00793          	li	a5,-33
800005ac:	02f70c63          	beq	a4,a5,800005e4 <s_sstatus_intr+0x74>
800005b0:	fdc42703          	lw	a4,-36(s0)
800005b4:	fdf00793          	li	a5,-33
800005b8:	04e7ec63          	bltu	a5,a4,80000610 <s_sstatus_intr+0xa0>
800005bc:	fdc42703          	lw	a4,-36(s0)
800005c0:	00200793          	li	a5,2
800005c4:	02f70863          	beq	a4,a5,800005f4 <s_sstatus_intr+0x84>
800005c8:	fdc42703          	lw	a4,-36(s0)
800005cc:	02000793          	li	a5,32
800005d0:	04f71063          	bne	a4,a5,80000610 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
800005d4:	fec42783          	lw	a5,-20(s0)
800005d8:	0207e793          	ori	a5,a5,32
800005dc:	fef42623          	sw	a5,-20(s0)
        break;
800005e0:	0340006f          	j	80000614 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
800005e4:	fec42783          	lw	a5,-20(s0)
800005e8:	fdf7f793          	andi	a5,a5,-33
800005ec:	fef42623          	sw	a5,-20(s0)
        break;
800005f0:	0240006f          	j	80000614 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
800005f4:	fec42783          	lw	a5,-20(s0)
800005f8:	0027e793          	ori	a5,a5,2
800005fc:	fef42623          	sw	a5,-20(s0)
        break;
80000600:	0140006f          	j	80000614 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
80000604:	fec42783          	lw	a5,-20(s0)
80000608:	0027f793          	andi	a5,a5,2
8000060c:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
80000610:	00000013          	nop
    }
    w_sstatus(x);
80000614:	fec42503          	lw	a0,-20(s0)
80000618:	e69ff0ef          	jal	ra,80000480 <w_sstatus>
}
8000061c:	00000013          	nop
80000620:	02c12083          	lw	ra,44(sp)
80000624:	02812403          	lw	s0,40(sp)
80000628:	03010113          	addi	sp,sp,48
8000062c:	00008067          	ret

80000630 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();     // 定义在main.c

void start(){
80000630:	ff010113          	addi	sp,sp,-16
80000634:	00112623          	sw	ra,12(sp)
80000638:	00812423          	sw	s0,8(sp)
8000063c:	01010413          	addi	s0,sp,16
    uartinit();
80000640:	07c000ef          	jal	ra,800006bc <uartinit>
    uartputs("Hello Los!\n");
80000644:	8000c7b7          	lui	a5,0x8000c
80000648:	00078513          	mv	a0,a5
8000064c:	164000ef          	jal	ra,800007b0 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
80000650:	00100513          	li	a0,1
80000654:	d31ff0ef          	jal	ra,80000384 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
80000658:	00000513          	li	a0,0
8000065c:	eedff0ef          	jal	ra,80000548 <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
80000660:	000107b7          	lui	a5,0x10
80000664:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000668:	e91ff0ef          	jal	ra,800004f8 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
8000066c:	000107b7          	lui	a5,0x10
80000670:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000674:	eadff0ef          	jal	ra,80000520 <w_medeleg>

    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
80000678:	00200513          	li	a0,2
8000067c:	ef5ff0ef          	jal	ra,80000570 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
80000680:	800007b7          	lui	a5,0x80000
80000684:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000688:	00078513          	mv	a0,a5
8000068c:	e45ff0ef          	jal	ra,800004d0 <w_stvec>

    timerinit();                // 时钟定时器
80000690:	565010ef          	jal	ra,800023f4 <timerinit>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
80000694:	800017b7          	lui	a5,0x80001
80000698:	87c78793          	addi	a5,a5,-1924 # 8000087c <memend+0xf800087c>
8000069c:	00078513          	mv	a0,a5
800006a0:	e09ff0ef          	jal	ra,800004a8 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
800006a4:	30200073          	mret
800006a8:	00000013          	nop
800006ac:	00c12083          	lw	ra,12(sp)
800006b0:	00812403          	lw	s0,8(sp)
800006b4:	01010113          	addi	sp,sp,16
800006b8:	00008067          	ret

800006bc <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
800006bc:	fe010113          	addi	sp,sp,-32
800006c0:	00812e23          	sw	s0,28(sp)
800006c4:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800006c8:	100007b7          	lui	a5,0x10000
800006cc:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800006d0:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800006d4:	100007b7          	lui	a5,0x10000
800006d8:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006dc:	0007c783          	lbu	a5,0(a5)
800006e0:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800006e4:	100007b7          	lui	a5,0x10000
800006e8:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800006ec:	fef44703          	lbu	a4,-17(s0)
800006f0:	f8076713          	ori	a4,a4,-128
800006f4:	0ff77713          	andi	a4,a4,255
800006f8:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
800006fc:	100007b7          	lui	a5,0x10000
80000700:	00300713          	li	a4,3
80000704:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
80000708:	100007b7          	lui	a5,0x10000
8000070c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000710:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
80000714:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80000718:	100007b7          	lui	a5,0x10000
8000071c:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000720:	fef44703          	lbu	a4,-17(s0)
80000724:	00376713          	ori	a4,a4,3
80000728:	0ff77713          	andi	a4,a4,255
8000072c:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
80000730:	100007b7          	lui	a5,0x10000
80000734:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000738:	0007c783          	lbu	a5,0(a5)
8000073c:	0ff7f713          	andi	a4,a5,255
80000740:	100007b7          	lui	a5,0x10000
80000744:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000748:	00176713          	ori	a4,a4,1
8000074c:	0ff77713          	andi	a4,a4,255
80000750:	00e78023          	sb	a4,0(a5)
}
80000754:	00000013          	nop
80000758:	01c12403          	lw	s0,28(sp)
8000075c:	02010113          	addi	sp,sp,32
80000760:	00008067          	ret

80000764 <uartputc>:

// 轮询处理数据
char uartputc(char c){
80000764:	fe010113          	addi	sp,sp,-32
80000768:	00812e23          	sw	s0,28(sp)
8000076c:	02010413          	addi	s0,sp,32
80000770:	00050793          	mv	a5,a0
80000774:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80000778:	00000013          	nop
8000077c:	100007b7          	lui	a5,0x10000
80000780:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000784:	0007c783          	lbu	a5,0(a5)
80000788:	0ff7f793          	andi	a5,a5,255
8000078c:	0207f793          	andi	a5,a5,32
80000790:	fe0786e3          	beqz	a5,8000077c <uartputc+0x18>
    return uart_write(UART_THR,c);
80000794:	10000737          	lui	a4,0x10000
80000798:	fef44783          	lbu	a5,-17(s0)
8000079c:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
800007a0:	00078513          	mv	a0,a5
800007a4:	01c12403          	lw	s0,28(sp)
800007a8:	02010113          	addi	sp,sp,32
800007ac:	00008067          	ret

800007b0 <uartputs>:

// 发送字符串
void uartputs(char* s){
800007b0:	fe010113          	addi	sp,sp,-32
800007b4:	00112e23          	sw	ra,28(sp)
800007b8:	00812c23          	sw	s0,24(sp)
800007bc:	02010413          	addi	s0,sp,32
800007c0:	fea42623          	sw	a0,-20(s0)
    while (*s)
800007c4:	01c0006f          	j	800007e0 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
800007c8:	fec42783          	lw	a5,-20(s0)
800007cc:	00178713          	addi	a4,a5,1
800007d0:	fee42623          	sw	a4,-20(s0)
800007d4:	0007c783          	lbu	a5,0(a5)
800007d8:	00078513          	mv	a0,a5
800007dc:	f89ff0ef          	jal	ra,80000764 <uartputc>
    while (*s)
800007e0:	fec42783          	lw	a5,-20(s0)
800007e4:	0007c783          	lbu	a5,0(a5)
800007e8:	fe0790e3          	bnez	a5,800007c8 <uartputs+0x18>
    }
    
}
800007ec:	00000013          	nop
800007f0:	00000013          	nop
800007f4:	01c12083          	lw	ra,28(sp)
800007f8:	01812403          	lw	s0,24(sp)
800007fc:	02010113          	addi	sp,sp,32
80000800:	00008067          	ret

80000804 <uartgetc>:

// 接收输入
int uartgetc(){
80000804:	ff010113          	addi	sp,sp,-16
80000808:	00812623          	sw	s0,12(sp)
8000080c:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
80000810:	100007b7          	lui	a5,0x10000
80000814:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000818:	0007c783          	lbu	a5,0(a5)
8000081c:	0ff7f793          	andi	a5,a5,255
80000820:	0017f793          	andi	a5,a5,1
80000824:	00078a63          	beqz	a5,80000838 <uartgetc+0x34>
        return uart_read(UART_RHR);
80000828:	100007b7          	lui	a5,0x10000
8000082c:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
80000830:	0ff7f793          	andi	a5,a5,255
80000834:	0080006f          	j	8000083c <uartgetc+0x38>
    }else{
        return -1;
80000838:	fff00793          	li	a5,-1
    }
}
8000083c:	00078513          	mv	a0,a5
80000840:	00c12403          	lw	s0,12(sp)
80000844:	01010113          	addi	sp,sp,16
80000848:	00008067          	ret

8000084c <uartintr>:

// 键盘输入中断
char uartintr(){
8000084c:	ff010113          	addi	sp,sp,-16
80000850:	00112623          	sw	ra,12(sp)
80000854:	00812423          	sw	s0,8(sp)
80000858:	01010413          	addi	s0,sp,16
    return uartgetc();
8000085c:	fa9ff0ef          	jal	ra,80000804 <uartgetc>
80000860:	00050793          	mv	a5,a0
80000864:	0ff7f793          	andi	a5,a5,255
80000868:	00078513          	mv	a0,a5
8000086c:	00c12083          	lw	ra,12(sp)
80000870:	00812403          	lw	s0,8(sp)
80000874:	01010113          	addi	sp,sp,16
80000878:	00008067          	ret

8000087c <main>:
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

void main(){
8000087c:	ff010113          	addi	sp,sp,-16
80000880:	00112623          	sw	ra,12(sp)
80000884:	00812423          	sw	s0,8(sp)
80000888:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
8000088c:	8000c7b7          	lui	a5,0x8000c
80000890:	00c78513          	addi	a0,a5,12 # 8000c00c <memend+0xf800c00c>
80000894:	588000ef          	jal	ra,80000e1c <printf>

    minit();        // 物理内存管理
80000898:	191000ef          	jal	ra,80001228 <minit>
    plicinit();     // PLIC 中断处理
8000089c:	411000ef          	jal	ra,800014ac <plicinit>
    
    kvminit();       // 启动虚拟内存
800008a0:	0c4010ef          	jal	ra,80001964 <kvminit>

    printf("usertrap: %p\n",usertrap);
800008a4:	800007b7          	lui	a5,0x80000
800008a8:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
800008ac:	8000c7b7          	lui	a5,0x8000c
800008b0:	02078513          	addi	a0,a5,32 # 8000c020 <memend+0xf800c020>
800008b4:	568000ef          	jal	ra,80000e1c <printf>

    userinit();
800008b8:	4b8010ef          	jal	ra,80001d70 <userinit>
    asm volatile("ecall");
800008bc:	00000073          	ecall

    printf("----------------------\n");
800008c0:	8000c7b7          	lui	a5,0x8000c
800008c4:	03078513          	addi	a0,a5,48 # 8000c030 <memend+0xf800c030>
800008c8:	554000ef          	jal	ra,80000e1c <printf>
    schedule();
800008cc:	5a4010ef          	jal	ra,80001e70 <schedule>
}
800008d0:	00000013          	nop
800008d4:	00c12083          	lw	ra,12(sp)
800008d8:	00812403          	lw	s0,8(sp)
800008dc:	01010113          	addi	sp,sp,16
800008e0:	00008067          	ret

800008e4 <r_sstatus>:
    }
    w_mstatus(x);
}

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
800008e4:	fe010113          	addi	sp,sp,-32
800008e8:	00812e23          	sw	s0,28(sp)
800008ec:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
800008f0:	100027f3          	csrr	a5,sstatus
800008f4:	fef42623          	sw	a5,-20(s0)
    return x;
800008f8:	fec42783          	lw	a5,-20(s0)
}
800008fc:	00078513          	mv	a0,a5
80000900:	01c12403          	lw	s0,28(sp)
80000904:	02010113          	addi	sp,sp,32
80000908:	00008067          	ret

8000090c <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
8000090c:	fe010113          	addi	sp,sp,-32
80000910:	00812e23          	sw	s0,28(sp)
80000914:	02010413          	addi	s0,sp,32
80000918:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
8000091c:	fec42783          	lw	a5,-20(s0)
80000920:	10079073          	csrw	sstatus,a5
}
80000924:	00000013          	nop
80000928:	01c12403          	lw	s0,28(sp)
8000092c:	02010113          	addi	sp,sp,32
80000930:	00008067          	ret

80000934 <s_sstatus_xpp>:
    }
    return x;
}
// 设置特权模式
#define S_SPP_SET (1<<8)
static inline void s_sstatus_xpp(uint8 m){
80000934:	fd010113          	addi	sp,sp,-48
80000938:	02112623          	sw	ra,44(sp)
8000093c:	02812423          	sw	s0,40(sp)
80000940:	03010413          	addi	s0,sp,48
80000944:	00050793          	mv	a5,a0
80000948:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_sstatus();
8000094c:	f99ff0ef          	jal	ra,800008e4 <r_sstatus>
80000950:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000954:	fdf44783          	lbu	a5,-33(s0)
80000958:	00078863          	beqz	a5,80000968 <s_sstatus_xpp+0x34>
8000095c:	00100713          	li	a4,1
80000960:	00e78c63          	beq	a5,a4,80000978 <s_sstatus_xpp+0x44>
    case RISCV_S:
        x &= ~SPP_MASK;
        x |= S_SPP_SET;
        break;
    default:
        break;
80000964:	0300006f          	j	80000994 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
80000968:	fec42783          	lw	a5,-20(s0)
8000096c:	eff7f793          	andi	a5,a5,-257
80000970:	fef42623          	sw	a5,-20(s0)
        break;
80000974:	0200006f          	j	80000994 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
80000978:	fec42783          	lw	a5,-20(s0)
8000097c:	eff7f793          	andi	a5,a5,-257
80000980:	fef42623          	sw	a5,-20(s0)
        x |= S_SPP_SET;
80000984:	fec42783          	lw	a5,-20(s0)
80000988:	1007e793          	ori	a5,a5,256
8000098c:	fef42623          	sw	a5,-20(s0)
        break;
80000990:	00000013          	nop
    }
    w_sstatus(x);
80000994:	fec42503          	lw	a0,-20(s0)
80000998:	f75ff0ef          	jal	ra,8000090c <w_sstatus>
}
8000099c:	00000013          	nop
800009a0:	02c12083          	lw	ra,44(sp)
800009a4:	02812403          	lw	s0,40(sp)
800009a8:	03010113          	addi	sp,sp,48
800009ac:	00008067          	ret

800009b0 <r_sepc>:

/**
 * @description: 读取 sepc 寄存器
 * S-mode 返回时跳转到 pc = sepc指向的地址
 */
static inline uint32 r_sepc(){
800009b0:	fe010113          	addi	sp,sp,-32
800009b4:	00812e23          	sw	s0,28(sp)
800009b8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sepc" : "=r" (x) );
800009bc:	141027f3          	csrr	a5,sepc
800009c0:	fef42623          	sw	a5,-20(s0)
    return x;
800009c4:	fec42783          	lw	a5,-20(s0)
}
800009c8:	00078513          	mv	a0,a5
800009cc:	01c12403          	lw	s0,28(sp)
800009d0:	02010113          	addi	sp,sp,32
800009d4:	00008067          	ret

800009d8 <w_sepc>:
// 写 sepc寄存器
static inline void w_sepc(uint32 x){
800009d8:	fe010113          	addi	sp,sp,-32
800009dc:	00812e23          	sw	s0,28(sp)
800009e0:	02010413          	addi	s0,sp,32
800009e4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
800009e8:	fec42783          	lw	a5,-20(s0)
800009ec:	14179073          	csrw	sepc,a5
}
800009f0:	00000013          	nop
800009f4:	01c12403          	lw	s0,28(sp)
800009f8:	02010113          	addi	sp,sp,32
800009fc:	00008067          	ret

80000a00 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80000a00:	fe010113          	addi	sp,sp,-32
80000a04:	00812e23          	sw	s0,28(sp)
80000a08:	02010413          	addi	s0,sp,32
80000a0c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80000a10:	fec42783          	lw	a5,-20(s0)
80000a14:	10579073          	csrw	stvec,a5
}
80000a18:	00000013          	nop
80000a1c:	01c12403          	lw	s0,28(sp)
80000a20:	02010113          	addi	sp,sp,32
80000a24:	00008067          	ret

80000a28 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
80000a28:	fe010113          	addi	sp,sp,-32
80000a2c:	00812e23          	sw	s0,28(sp)
80000a30:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
80000a34:	142027f3          	csrr	a5,scause
80000a38:	fef42623          	sw	a5,-20(s0)
    return x;
80000a3c:	fec42783          	lw	a5,-20(s0)
}
80000a40:	00078513          	mv	a0,a5
80000a44:	01c12403          	lw	s0,28(sp)
80000a48:	02010113          	addi	sp,sp,32
80000a4c:	00008067          	ret

80000a50 <r_sip>:

/**
 * @description: 
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip(){
80000a50:	fe010113          	addi	sp,sp,-32
80000a54:	00812e23          	sw	s0,28(sp)
80000a58:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip":"=r"(x));
80000a5c:	144027f3          	csrr	a5,sip
80000a60:	fef42623          	sw	a5,-20(s0)
    return x;
80000a64:	fec42783          	lw	a5,-20(s0)
}
80000a68:	00078513          	mv	a0,a5
80000a6c:	01c12403          	lw	s0,28(sp)
80000a70:	02010113          	addi	sp,sp,32
80000a74:	00008067          	ret

80000a78 <w_sip>:
static inline void w_sip(uint32 x){
80000a78:	fe010113          	addi	sp,sp,-32
80000a7c:	00812e23          	sw	s0,28(sp)
80000a80:	02010413          	addi	s0,sp,32
80000a84:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"::"r"(x));
80000a88:	fec42783          	lw	a5,-20(s0)
80000a8c:	14479073          	csrw	sip,a5
}
80000a90:	00000013          	nop
80000a94:	01c12403          	lw	s0,28(sp)
80000a98:	02010113          	addi	sp,sp,32
80000a9c:	00008067          	ret

80000aa0 <externinterrupt>:
#include "clint.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
80000aa0:	fe010113          	addi	sp,sp,-32
80000aa4:	00112e23          	sw	ra,28(sp)
80000aa8:	00812c23          	sw	s0,24(sp)
80000aac:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000ab0:	2c1000ef          	jal	ra,80001570 <r_plicclaim>
80000ab4:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000ab8:	fec42583          	lw	a1,-20(s0)
80000abc:	8000c7b7          	lui	a5,0x8000c
80000ac0:	04878513          	addi	a0,a5,72 # 8000c048 <memend+0xf800c048>
80000ac4:	358000ef          	jal	ra,80000e1c <printf>
    switch (irq)
80000ac8:	fec42703          	lw	a4,-20(s0)
80000acc:	00a00793          	li	a5,10
80000ad0:	02f71063          	bne	a4,a5,80000af0 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80000ad4:	d79ff0ef          	jal	ra,8000084c <uartintr>
80000ad8:	00050793          	mv	a5,a0
80000adc:	00078593          	mv	a1,a5
80000ae0:	8000c7b7          	lui	a5,0x8000c
80000ae4:	05478513          	addi	a0,a5,84 # 8000c054 <memend+0xf800c054>
80000ae8:	334000ef          	jal	ra,80000e1c <printf>
        break;
80000aec:	0080006f          	j	80000af4 <externinterrupt+0x54>
    default:
        break;
80000af0:	00000013          	nop
    }
    w_pliccomplete(irq);
80000af4:	fec42503          	lw	a0,-20(s0)
80000af8:	2b9000ef          	jal	ra,800015b0 <w_pliccomplete>
}
80000afc:	00000013          	nop
80000b00:	01c12083          	lw	ra,28(sp)
80000b04:	01812403          	lw	s0,24(sp)
80000b08:	02010113          	addi	sp,sp,32
80000b0c:	00008067          	ret

80000b10 <usertrapret>:

// 返回用户空间
void usertrapret(){
80000b10:	fe010113          	addi	sp,sp,-32
80000b14:	00112e23          	sw	ra,28(sp)
80000b18:	00812c23          	sw	s0,24(sp)
80000b1c:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80000b20:	12c010ef          	jal	ra,80001c4c <nowproc>
80000b24:	fea42623          	sw	a0,-20(s0)
    s_sstatus_xpp(RISCV_U);
80000b28:	00000513          	li	a0,0
80000b2c:	e09ff0ef          	jal	ra,80000934 <s_sstatus_xpp>
    w_stvec((uint32)usertrap);
80000b30:	800007b7          	lui	a5,0x80000
80000b34:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80000b38:	00078513          	mv	a0,a5
80000b3c:	ec5ff0ef          	jal	ra,80000a00 <w_stvec>
    addr_t satp=(SATP_SV32|(addr_t)(p->pagetable)>>12);
80000b40:	fec42783          	lw	a5,-20(s0)
80000b44:	1107a783          	lw	a5,272(a5)
80000b48:	00c7d713          	srli	a4,a5,0xc
80000b4c:	800007b7          	lui	a5,0x80000
80000b50:	00f767b3          	or	a5,a4,a5
80000b54:	fef42423          	sw	a5,-24(s0)
    userret(&p->trapframe,satp);
80000b58:	fec42783          	lw	a5,-20(s0)
80000b5c:	00878793          	addi	a5,a5,8 # 80000008 <memend+0xf8000008>
80000b60:	fe842583          	lw	a1,-24(s0)
80000b64:	00078513          	mv	a0,a5
80000b68:	fb4ff0ef          	jal	ra,8000031c <userret>
}
80000b6c:	00000013          	nop
80000b70:	01c12083          	lw	ra,28(sp)
80000b74:	01812403          	lw	s0,24(sp)
80000b78:	02010113          	addi	sp,sp,32
80000b7c:	00008067          	ret

80000b80 <zero>:

void zero(){
80000b80:	fe010113          	addi	sp,sp,-32
80000b84:	00112e23          	sw	ra,28(sp)
80000b88:	00812c23          	sw	s0,24(sp)
80000b8c:	02010413          	addi	s0,sp,32
    printf("zero\n");
80000b90:	8000c7b7          	lui	a5,0x8000c
80000b94:	06478513          	addi	a0,a5,100 # 8000c064 <memend+0xf800c064>
80000b98:	284000ef          	jal	ra,80000e1c <printf>
    reg_t pc=r_sepc();
80000b9c:	e15ff0ef          	jal	ra,800009b0 <r_sepc>
80000ba0:	fea42623          	sw	a0,-20(s0)
    w_sepc(pc+4);
80000ba4:	fec42783          	lw	a5,-20(s0)
80000ba8:	00478793          	addi	a5,a5,4
80000bac:	00078513          	mv	a0,a5
80000bb0:	e29ff0ef          	jal	ra,800009d8 <w_sepc>
    usertrapret();
80000bb4:	f5dff0ef          	jal	ra,80000b10 <usertrapret>
}
80000bb8:	00000013          	nop
80000bbc:	01c12083          	lw	ra,28(sp)
80000bc0:	01812403          	lw	s0,24(sp)
80000bc4:	02010113          	addi	sp,sp,32
80000bc8:	00008067          	ret

80000bcc <timerintr>:

void timerintr(){
80000bcc:	ff010113          	addi	sp,sp,-16
80000bd0:	00112623          	sw	ra,12(sp)
80000bd4:	00812423          	sw	s0,8(sp)
80000bd8:	01010413          	addi	s0,sp,16
    w_sip(r_sip()& ~2); // 清除中断
80000bdc:	e75ff0ef          	jal	ra,80000a50 <r_sip>
80000be0:	00050793          	mv	a5,a0
80000be4:	ffd7f793          	andi	a5,a5,-3
80000be8:	00078513          	mv	a0,a5
80000bec:	e8dff0ef          	jal	ra,80000a78 <w_sip>
    // printf("timer interrupt\n");
}
80000bf0:	00000013          	nop
80000bf4:	00c12083          	lw	ra,12(sp)
80000bf8:	00812403          	lw	s0,8(sp)
80000bfc:	01010113          	addi	sp,sp,16
80000c00:	00008067          	ret

80000c04 <trapvec>:

void trapvec(){
80000c04:	fe010113          	addi	sp,sp,-32
80000c08:	00112e23          	sw	ra,28(sp)
80000c0c:	00812c23          	sw	s0,24(sp)
80000c10:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000c14:	e15ff0ef          	jal	ra,80000a28 <r_scause>
80000c18:	fea42423          	sw	a0,-24(s0)

    uint16 code= scause & 0xffff;
80000c1c:	fe842783          	lw	a5,-24(s0)
80000c20:	fef41323          	sh	a5,-26(s0)

    if(scause & (1<<31)){
80000c24:	fe842783          	lw	a5,-24(s0)
80000c28:	0607d463          	bgez	a5,80000c90 <trapvec+0x8c>
    //     printf("Interrupt : ");
        switch (code)
80000c2c:	fe645783          	lhu	a5,-26(s0)
80000c30:	00900713          	li	a4,9
80000c34:	02e78c63          	beq	a5,a4,80000c6c <trapvec+0x68>
80000c38:	00900713          	li	a4,9
80000c3c:	04f74263          	blt	a4,a5,80000c80 <trapvec+0x7c>
80000c40:	00100713          	li	a4,1
80000c44:	00e78863          	beq	a5,a4,80000c54 <trapvec+0x50>
80000c48:	00500713          	li	a4,5
80000c4c:	00e78863          	beq	a5,a4,80000c5c <trapvec+0x58>
80000c50:	0300006f          	j	80000c80 <trapvec+0x7c>
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
80000c54:	f79ff0ef          	jal	ra,80000bcc <timerintr>
            break;
80000c58:	1780006f          	j	80000dd0 <trapvec+0x1cc>
        case 5:
            printf("Supervisor timer interrupt\n");
80000c5c:	8000c7b7          	lui	a5,0x8000c
80000c60:	06c78513          	addi	a0,a5,108 # 8000c06c <memend+0xf800c06c>
80000c64:	1b8000ef          	jal	ra,80000e1c <printf>
            break;
80000c68:	1680006f          	j	80000dd0 <trapvec+0x1cc>
        case 9:
            printf("Supervisor external interrupt\n");
80000c6c:	8000c7b7          	lui	a5,0x8000c
80000c70:	08878513          	addi	a0,a5,136 # 8000c088 <memend+0xf800c088>
80000c74:	1a8000ef          	jal	ra,80000e1c <printf>
            externinterrupt();
80000c78:	e29ff0ef          	jal	ra,80000aa0 <externinterrupt>
            break;
80000c7c:	1540006f          	j	80000dd0 <trapvec+0x1cc>
        default:
            printf("Other interrupt\n");
80000c80:	8000c7b7          	lui	a5,0x8000c
80000c84:	0a878513          	addi	a0,a5,168 # 8000c0a8 <memend+0xf800c0a8>
80000c88:	194000ef          	jal	ra,80000e1c <printf>
            break;
80000c8c:	1440006f          	j	80000dd0 <trapvec+0x1cc>
        }
    }else{
        int ecall=0;
80000c90:	fe042623          	sw	zero,-20(s0)
        printf("Exception : ");
80000c94:	8000c7b7          	lui	a5,0x8000c
80000c98:	0bc78513          	addi	a0,a5,188 # 8000c0bc <memend+0xf800c0bc>
80000c9c:	180000ef          	jal	ra,80000e1c <printf>
        switch (code)
80000ca0:	fe645783          	lhu	a5,-26(s0)
80000ca4:	00f00713          	li	a4,15
80000ca8:	0ef76c63          	bltu	a4,a5,80000da0 <trapvec+0x19c>
80000cac:	00279713          	slli	a4,a5,0x2
80000cb0:	8000c7b7          	lui	a5,0x8000c
80000cb4:	23078793          	addi	a5,a5,560 # 8000c230 <memend+0xf800c230>
80000cb8:	00f707b3          	add	a5,a4,a5
80000cbc:	0007a783          	lw	a5,0(a5)
80000cc0:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000cc4:	8000c7b7          	lui	a5,0x8000c
80000cc8:	0cc78513          	addi	a0,a5,204 # 8000c0cc <memend+0xf800c0cc>
80000ccc:	150000ef          	jal	ra,80000e1c <printf>
            break;
80000cd0:	0e00006f          	j	80000db0 <trapvec+0x1ac>
        case 1:
            printf("Instruction access fault\n");
80000cd4:	8000c7b7          	lui	a5,0x8000c
80000cd8:	0ec78513          	addi	a0,a5,236 # 8000c0ec <memend+0xf800c0ec>
80000cdc:	140000ef          	jal	ra,80000e1c <printf>
            break;
80000ce0:	0d00006f          	j	80000db0 <trapvec+0x1ac>
        case 2:
            printf("Illegal instruction\n");
80000ce4:	8000c7b7          	lui	a5,0x8000c
80000ce8:	10878513          	addi	a0,a5,264 # 8000c108 <memend+0xf800c108>
80000cec:	130000ef          	jal	ra,80000e1c <printf>
            break;
80000cf0:	0c00006f          	j	80000db0 <trapvec+0x1ac>
        case 3:
            printf("Breakpoint\n");
80000cf4:	8000c7b7          	lui	a5,0x8000c
80000cf8:	12078513          	addi	a0,a5,288 # 8000c120 <memend+0xf800c120>
80000cfc:	120000ef          	jal	ra,80000e1c <printf>
            break;
80000d00:	0b00006f          	j	80000db0 <trapvec+0x1ac>
        case 4:
            printf("Load address misaligned\n");
80000d04:	8000c7b7          	lui	a5,0x8000c
80000d08:	12c78513          	addi	a0,a5,300 # 8000c12c <memend+0xf800c12c>
80000d0c:	110000ef          	jal	ra,80000e1c <printf>
            break;
80000d10:	0a00006f          	j	80000db0 <trapvec+0x1ac>
        case 5:
            printf("Load access fault\n");
80000d14:	8000c7b7          	lui	a5,0x8000c
80000d18:	14878513          	addi	a0,a5,328 # 8000c148 <memend+0xf800c148>
80000d1c:	100000ef          	jal	ra,80000e1c <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000d20:	0900006f          	j	80000db0 <trapvec+0x1ac>
        case 6:
            printf("Store/AMO address misaligned\n");
80000d24:	8000c7b7          	lui	a5,0x8000c
80000d28:	15c78513          	addi	a0,a5,348 # 8000c15c <memend+0xf800c15c>
80000d2c:	0f0000ef          	jal	ra,80000e1c <printf>
            break;
80000d30:	0800006f          	j	80000db0 <trapvec+0x1ac>
        case 7:
            printf("Store/AMO access fault\n");
80000d34:	8000c7b7          	lui	a5,0x8000c
80000d38:	17c78513          	addi	a0,a5,380 # 8000c17c <memend+0xf800c17c>
80000d3c:	0e0000ef          	jal	ra,80000e1c <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000d40:	0700006f          	j	80000db0 <trapvec+0x1ac>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000d44:	8000c7b7          	lui	a5,0x8000c
80000d48:	19478513          	addi	a0,a5,404 # 8000c194 <memend+0xf800c194>
80000d4c:	0d0000ef          	jal	ra,80000e1c <printf>
            break;
80000d50:	0600006f          	j	80000db0 <trapvec+0x1ac>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000d54:	8000c7b7          	lui	a5,0x8000c
80000d58:	1b478513          	addi	a0,a5,436 # 8000c1b4 <memend+0xf800c1b4>
80000d5c:	0c0000ef          	jal	ra,80000e1c <printf>
            zero();
80000d60:	e21ff0ef          	jal	ra,80000b80 <zero>
            ecall=1;
80000d64:	00100793          	li	a5,1
80000d68:	fef42623          	sw	a5,-20(s0)
            break;
80000d6c:	0440006f          	j	80000db0 <trapvec+0x1ac>
        case 12:
            printf("Instruction page fault\n");
80000d70:	8000c7b7          	lui	a5,0x8000c
80000d74:	1d478513          	addi	a0,a5,468 # 8000c1d4 <memend+0xf800c1d4>
80000d78:	0a4000ef          	jal	ra,80000e1c <printf>
            break;
80000d7c:	0340006f          	j	80000db0 <trapvec+0x1ac>
        case 13:
            printf("Load page fault\n");
80000d80:	8000c7b7          	lui	a5,0x8000c
80000d84:	1ec78513          	addi	a0,a5,492 # 8000c1ec <memend+0xf800c1ec>
80000d88:	094000ef          	jal	ra,80000e1c <printf>
            break;
80000d8c:	0240006f          	j	80000db0 <trapvec+0x1ac>
        case 15:
            printf("Store/AMO page fault\n");
80000d90:	8000c7b7          	lui	a5,0x8000c
80000d94:	20078513          	addi	a0,a5,512 # 8000c200 <memend+0xf800c200>
80000d98:	084000ef          	jal	ra,80000e1c <printf>
            break;
80000d9c:	0140006f          	j	80000db0 <trapvec+0x1ac>
        default:
            printf("Other\n");
80000da0:	8000c7b7          	lui	a5,0x8000c
80000da4:	21878513          	addi	a0,a5,536 # 8000c218 <memend+0xf800c218>
80000da8:	074000ef          	jal	ra,80000e1c <printf>
            break;
80000dac:	00000013          	nop
        }
        if(!ecall){
80000db0:	fec42783          	lw	a5,-20(s0)
80000db4:	00079e63          	bnez	a5,80000dd0 <trapvec+0x1cc>
            panic("Trap Exception");
80000db8:	8000c7b7          	lui	a5,0x8000c
80000dbc:	22078513          	addi	a0,a5,544 # 8000c220 <memend+0xf800c220>
80000dc0:	024000ef          	jal	ra,80000de4 <panic>
            ecall=1;
80000dc4:	00100793          	li	a5,1
80000dc8:	fef42623          	sw	a5,-20(s0)
        }
    }
}
80000dcc:	0040006f          	j	80000dd0 <trapvec+0x1cc>
80000dd0:	00000013          	nop
80000dd4:	01c12083          	lw	ra,28(sp)
80000dd8:	01812403          	lw	s0,24(sp)
80000ddc:	02010113          	addi	sp,sp,32
80000de0:	00008067          	ret

80000de4 <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000de4:	fe010113          	addi	sp,sp,-32
80000de8:	00112e23          	sw	ra,28(sp)
80000dec:	00812c23          	sw	s0,24(sp)
80000df0:	02010413          	addi	s0,sp,32
80000df4:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000df8:	8000c7b7          	lui	a5,0x8000c
80000dfc:	27078513          	addi	a0,a5,624 # 8000c270 <memend+0xf800c270>
80000e00:	9b1ff0ef          	jal	ra,800007b0 <uartputs>
    uartputs(s);
80000e04:	fec42503          	lw	a0,-20(s0)
80000e08:	9a9ff0ef          	jal	ra,800007b0 <uartputs>
	uartputs("\n");
80000e0c:	8000c7b7          	lui	a5,0x8000c
80000e10:	27878513          	addi	a0,a5,632 # 8000c278 <memend+0xf800c278>
80000e14:	99dff0ef          	jal	ra,800007b0 <uartputs>
    while(1);
80000e18:	0000006f          	j	80000e18 <panic+0x34>

80000e1c <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000e1c:	f8010113          	addi	sp,sp,-128
80000e20:	04112e23          	sw	ra,92(sp)
80000e24:	04812c23          	sw	s0,88(sp)
80000e28:	06010413          	addi	s0,sp,96
80000e2c:	faa42623          	sw	a0,-84(s0)
80000e30:	00b42223          	sw	a1,4(s0)
80000e34:	00c42423          	sw	a2,8(s0)
80000e38:	00d42623          	sw	a3,12(s0)
80000e3c:	00e42823          	sw	a4,16(s0)
80000e40:	00f42a23          	sw	a5,20(s0)
80000e44:	01042c23          	sw	a6,24(s0)
80000e48:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000e4c:	02040793          	addi	a5,s0,32
80000e50:	faf42423          	sw	a5,-88(s0)
80000e54:	fa842783          	lw	a5,-88(s0)
80000e58:	fe478793          	addi	a5,a5,-28
80000e5c:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000e60:	fac42783          	lw	a5,-84(s0)
80000e64:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000e68:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000e6c:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
80000e70:	36c0006f          	j	800011dc <printf+0x3c0>
		if(ch=='%'){
80000e74:	fbf44703          	lbu	a4,-65(s0)
80000e78:	02500793          	li	a5,37
80000e7c:	04f71863          	bne	a4,a5,80000ecc <printf+0xb0>
			if(tt==1){
80000e80:	fe842703          	lw	a4,-24(s0)
80000e84:	00100793          	li	a5,1
80000e88:	02f71663          	bne	a4,a5,80000eb4 <printf+0x98>
				outbuf[idx++]='%';
80000e8c:	fe442783          	lw	a5,-28(s0)
80000e90:	00178713          	addi	a4,a5,1
80000e94:	fee42223          	sw	a4,-28(s0)
80000e98:	8000d737          	lui	a4,0x8000d
80000e9c:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000ea0:	00f707b3          	add	a5,a4,a5
80000ea4:	02500713          	li	a4,37
80000ea8:	00e78023          	sb	a4,0(a5)
				tt=0;
80000eac:	fe042423          	sw	zero,-24(s0)
80000eb0:	00c0006f          	j	80000ebc <printf+0xa0>
			}else{
				tt=1;
80000eb4:	00100793          	li	a5,1
80000eb8:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000ebc:	fec42783          	lw	a5,-20(s0)
80000ec0:	00178793          	addi	a5,a5,1
80000ec4:	fef42623          	sw	a5,-20(s0)
80000ec8:	3140006f          	j	800011dc <printf+0x3c0>
		}else{
			if(tt==1){
80000ecc:	fe842703          	lw	a4,-24(s0)
80000ed0:	00100793          	li	a5,1
80000ed4:	2cf71e63          	bne	a4,a5,800011b0 <printf+0x394>
				switch (ch)
80000ed8:	fbf44783          	lbu	a5,-65(s0)
80000edc:	fa878793          	addi	a5,a5,-88
80000ee0:	02000713          	li	a4,32
80000ee4:	2af76663          	bltu	a4,a5,80001190 <printf+0x374>
80000ee8:	00279713          	slli	a4,a5,0x2
80000eec:	8000c7b7          	lui	a5,0x8000c
80000ef0:	29478793          	addi	a5,a5,660 # 8000c294 <memend+0xf800c294>
80000ef4:	00f707b3          	add	a5,a4,a5
80000ef8:	0007a783          	lw	a5,0(a5)
80000efc:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000f00:	fb842783          	lw	a5,-72(s0)
80000f04:	00478713          	addi	a4,a5,4
80000f08:	fae42c23          	sw	a4,-72(s0)
80000f0c:	0007a783          	lw	a5,0(a5)
80000f10:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000f14:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000f18:	fe042783          	lw	a5,-32(s0)
80000f1c:	fcf42c23          	sw	a5,-40(s0)
80000f20:	0100006f          	j	80000f30 <printf+0x114>
80000f24:	fdc42783          	lw	a5,-36(s0)
80000f28:	00178793          	addi	a5,a5,1
80000f2c:	fcf42e23          	sw	a5,-36(s0)
80000f30:	fd842703          	lw	a4,-40(s0)
80000f34:	00a00793          	li	a5,10
80000f38:	02f747b3          	div	a5,a4,a5
80000f3c:	fcf42c23          	sw	a5,-40(s0)
80000f40:	fd842783          	lw	a5,-40(s0)
80000f44:	fe0790e3          	bnez	a5,80000f24 <printf+0x108>
					for(int i=len;i>=0;i--){
80000f48:	fdc42783          	lw	a5,-36(s0)
80000f4c:	fcf42a23          	sw	a5,-44(s0)
80000f50:	0540006f          	j	80000fa4 <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000f54:	fe042703          	lw	a4,-32(s0)
80000f58:	00a00793          	li	a5,10
80000f5c:	02f767b3          	rem	a5,a4,a5
80000f60:	0ff7f713          	andi	a4,a5,255
80000f64:	fe442683          	lw	a3,-28(s0)
80000f68:	fd442783          	lw	a5,-44(s0)
80000f6c:	00f687b3          	add	a5,a3,a5
80000f70:	03070713          	addi	a4,a4,48
80000f74:	0ff77713          	andi	a4,a4,255
80000f78:	8000d6b7          	lui	a3,0x8000d
80000f7c:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
80000f80:	00f687b3          	add	a5,a3,a5
80000f84:	00e78023          	sb	a4,0(a5)
						x/=10;
80000f88:	fe042703          	lw	a4,-32(s0)
80000f8c:	00a00793          	li	a5,10
80000f90:	02f747b3          	div	a5,a4,a5
80000f94:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000f98:	fd442783          	lw	a5,-44(s0)
80000f9c:	fff78793          	addi	a5,a5,-1
80000fa0:	fcf42a23          	sw	a5,-44(s0)
80000fa4:	fd442783          	lw	a5,-44(s0)
80000fa8:	fa07d6e3          	bgez	a5,80000f54 <printf+0x138>
					}
					idx+=(len+1);
80000fac:	fdc42783          	lw	a5,-36(s0)
80000fb0:	00178793          	addi	a5,a5,1
80000fb4:	fe442703          	lw	a4,-28(s0)
80000fb8:	00f707b3          	add	a5,a4,a5
80000fbc:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000fc0:	fe042423          	sw	zero,-24(s0)
					break;
80000fc4:	1dc0006f          	j	800011a0 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000fc8:	fe442783          	lw	a5,-28(s0)
80000fcc:	00178713          	addi	a4,a5,1
80000fd0:	fee42223          	sw	a4,-28(s0)
80000fd4:	8000d737          	lui	a4,0x8000d
80000fd8:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000fdc:	00f707b3          	add	a5,a4,a5
80000fe0:	03000713          	li	a4,48
80000fe4:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000fe8:	fe442783          	lw	a5,-28(s0)
80000fec:	00178713          	addi	a4,a5,1
80000ff0:	fee42223          	sw	a4,-28(s0)
80000ff4:	8000d737          	lui	a4,0x8000d
80000ff8:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000ffc:	00f707b3          	add	a5,a4,a5
80001000:	07800713          	li	a4,120
80001004:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80001008:	fb842783          	lw	a5,-72(s0)
8000100c:	00478713          	addi	a4,a5,4
80001010:	fae42c23          	sw	a4,-72(s0)
80001014:	0007a783          	lw	a5,0(a5)
80001018:	fcf42823          	sw	a5,-48(s0)
					int len=0;
8000101c:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80001020:	fd042783          	lw	a5,-48(s0)
80001024:	fcf42423          	sw	a5,-56(s0)
80001028:	0100006f          	j	80001038 <printf+0x21c>
8000102c:	fcc42783          	lw	a5,-52(s0)
80001030:	00178793          	addi	a5,a5,1
80001034:	fcf42623          	sw	a5,-52(s0)
80001038:	fc842783          	lw	a5,-56(s0)
8000103c:	0047d793          	srli	a5,a5,0x4
80001040:	fcf42423          	sw	a5,-56(s0)
80001044:	fc842783          	lw	a5,-56(s0)
80001048:	fe0792e3          	bnez	a5,8000102c <printf+0x210>
					for(int i=len;i>=0;i--){
8000104c:	fcc42783          	lw	a5,-52(s0)
80001050:	fcf42223          	sw	a5,-60(s0)
80001054:	0840006f          	j	800010d8 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80001058:	fd042783          	lw	a5,-48(s0)
8000105c:	00f7f713          	andi	a4,a5,15
80001060:	00900793          	li	a5,9
80001064:	02e7f063          	bgeu	a5,a4,80001084 <printf+0x268>
80001068:	fd042783          	lw	a5,-48(s0)
8000106c:	0ff7f793          	andi	a5,a5,255
80001070:	00f7f793          	andi	a5,a5,15
80001074:	0ff7f793          	andi	a5,a5,255
80001078:	05778793          	addi	a5,a5,87
8000107c:	0ff7f793          	andi	a5,a5,255
80001080:	01c0006f          	j	8000109c <printf+0x280>
80001084:	fd042783          	lw	a5,-48(s0)
80001088:	0ff7f793          	andi	a5,a5,255
8000108c:	00f7f793          	andi	a5,a5,15
80001090:	0ff7f793          	andi	a5,a5,255
80001094:	03078793          	addi	a5,a5,48
80001098:	0ff7f793          	andi	a5,a5,255
8000109c:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
800010a0:	fe442703          	lw	a4,-28(s0)
800010a4:	fc442783          	lw	a5,-60(s0)
800010a8:	00f707b3          	add	a5,a4,a5
800010ac:	8000d737          	lui	a4,0x8000d
800010b0:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
800010b4:	00f707b3          	add	a5,a4,a5
800010b8:	fbe44703          	lbu	a4,-66(s0)
800010bc:	00e78023          	sb	a4,0(a5)
						x/=16;
800010c0:	fd042783          	lw	a5,-48(s0)
800010c4:	0047d793          	srli	a5,a5,0x4
800010c8:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
800010cc:	fc442783          	lw	a5,-60(s0)
800010d0:	fff78793          	addi	a5,a5,-1
800010d4:	fcf42223          	sw	a5,-60(s0)
800010d8:	fc442783          	lw	a5,-60(s0)
800010dc:	f607dee3          	bgez	a5,80001058 <printf+0x23c>
					}
					idx+=(len+1);
800010e0:	fcc42783          	lw	a5,-52(s0)
800010e4:	00178793          	addi	a5,a5,1
800010e8:	fe442703          	lw	a4,-28(s0)
800010ec:	00f707b3          	add	a5,a4,a5
800010f0:	fef42223          	sw	a5,-28(s0)
					tt=0;
800010f4:	fe042423          	sw	zero,-24(s0)
					break;
800010f8:	0a80006f          	j	800011a0 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
800010fc:	fb842783          	lw	a5,-72(s0)
80001100:	00478713          	addi	a4,a5,4
80001104:	fae42c23          	sw	a4,-72(s0)
80001108:	0007a783          	lw	a5,0(a5)
8000110c:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80001110:	fe442783          	lw	a5,-28(s0)
80001114:	00178713          	addi	a4,a5,1
80001118:	fee42223          	sw	a4,-28(s0)
8000111c:	8000d737          	lui	a4,0x8000d
80001120:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001124:	00f707b3          	add	a5,a4,a5
80001128:	fbf44703          	lbu	a4,-65(s0)
8000112c:	00e78023          	sb	a4,0(a5)
					tt=0;
80001130:	fe042423          	sw	zero,-24(s0)
					break;
80001134:	06c0006f          	j	800011a0 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80001138:	fb842783          	lw	a5,-72(s0)
8000113c:	00478713          	addi	a4,a5,4
80001140:	fae42c23          	sw	a4,-72(s0)
80001144:	0007a783          	lw	a5,0(a5)
80001148:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
8000114c:	0300006f          	j	8000117c <printf+0x360>
						outbuf[idx++]=*ss++;
80001150:	fc042703          	lw	a4,-64(s0)
80001154:	00170793          	addi	a5,a4,1
80001158:	fcf42023          	sw	a5,-64(s0)
8000115c:	fe442783          	lw	a5,-28(s0)
80001160:	00178693          	addi	a3,a5,1
80001164:	fed42223          	sw	a3,-28(s0)
80001168:	00074703          	lbu	a4,0(a4)
8000116c:	8000d6b7          	lui	a3,0x8000d
80001170:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
80001174:	00f687b3          	add	a5,a3,a5
80001178:	00e78023          	sb	a4,0(a5)
					while(*ss){
8000117c:	fc042783          	lw	a5,-64(s0)
80001180:	0007c783          	lbu	a5,0(a5)
80001184:	fc0796e3          	bnez	a5,80001150 <printf+0x334>
					}
					tt=0;
80001188:	fe042423          	sw	zero,-24(s0)
					break;
8000118c:	0140006f          	j	800011a0 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80001190:	8000c7b7          	lui	a5,0x8000c
80001194:	27c78513          	addi	a0,a5,636 # 8000c27c <memend+0xf800c27c>
80001198:	c4dff0ef          	jal	ra,80000de4 <panic>
					break;
8000119c:	00000013          	nop
				}
				s++;
800011a0:	fec42783          	lw	a5,-20(s0)
800011a4:	00178793          	addi	a5,a5,1
800011a8:	fef42623          	sw	a5,-20(s0)
800011ac:	0300006f          	j	800011dc <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
800011b0:	fe442783          	lw	a5,-28(s0)
800011b4:	00178713          	addi	a4,a5,1
800011b8:	fee42223          	sw	a4,-28(s0)
800011bc:	8000d737          	lui	a4,0x8000d
800011c0:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
800011c4:	00f707b3          	add	a5,a4,a5
800011c8:	fbf44703          	lbu	a4,-65(s0)
800011cc:	00e78023          	sb	a4,0(a5)
				s++;
800011d0:	fec42783          	lw	a5,-20(s0)
800011d4:	00178793          	addi	a5,a5,1
800011d8:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
800011dc:	fec42783          	lw	a5,-20(s0)
800011e0:	0007c783          	lbu	a5,0(a5)
800011e4:	faf40fa3          	sb	a5,-65(s0)
800011e8:	fbf44783          	lbu	a5,-65(s0)
800011ec:	c80794e3          	bnez	a5,80000e74 <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
800011f0:	8000d7b7          	lui	a5,0x8000d
800011f4:	00478713          	addi	a4,a5,4 # 8000d004 <memend+0xf800d004>
800011f8:	fe442783          	lw	a5,-28(s0)
800011fc:	00f707b3          	add	a5,a4,a5
80001200:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
80001204:	8000d7b7          	lui	a5,0x8000d
80001208:	00478513          	addi	a0,a5,4 # 8000d004 <memend+0xf800d004>
8000120c:	da4ff0ef          	jal	ra,800007b0 <uartputs>
	return idx;
80001210:	fe442783          	lw	a5,-28(s0)
80001214:	00078513          	mv	a0,a5
80001218:	05c12083          	lw	ra,92(sp)
8000121c:	05812403          	lw	s0,88(sp)
80001220:	08010113          	addi	sp,sp,128
80001224:	00008067          	ret

80001228 <minit>:
struct
{
    struct pmp* freelist;
}mem;
#define _DEBUG
void minit(){
80001228:	fe010113          	addi	sp,sp,-32
8000122c:	00112e23          	sw	ra,28(sp)
80001230:	00812c23          	sw	s0,24(sp)
80001234:	02010413          	addi	s0,sp,32
    #ifdef _DEBUG
        printf("textstart:%p    ",textstart);
80001238:	800007b7          	lui	a5,0x80000
8000123c:	00078593          	mv	a1,a5
80001240:	8000c7b7          	lui	a5,0x8000c
80001244:	31878513          	addi	a0,a5,792 # 8000c318 <memend+0xf800c318>
80001248:	bd5ff0ef          	jal	ra,80000e1c <printf>
        printf("textend:%p\n",textend);
8000124c:	800027b7          	lui	a5,0x80002
80001250:	51478593          	addi	a1,a5,1300 # 80002514 <memend+0xf8002514>
80001254:	8000c7b7          	lui	a5,0x8000c
80001258:	32c78513          	addi	a0,a5,812 # 8000c32c <memend+0xf800c32c>
8000125c:	bc1ff0ef          	jal	ra,80000e1c <printf>
        printf("datastart:%p    ",datastart);
80001260:	800037b7          	lui	a5,0x80003
80001264:	00078593          	mv	a1,a5
80001268:	8000c7b7          	lui	a5,0x8000c
8000126c:	33878513          	addi	a0,a5,824 # 8000c338 <memend+0xf800c338>
80001270:	badff0ef          	jal	ra,80000e1c <printf>
        printf("dataend:%p\n",dataend);
80001274:	8000b7b7          	lui	a5,0x8000b
80001278:	00878593          	addi	a1,a5,8 # 8000b008 <memend+0xf800b008>
8000127c:	8000c7b7          	lui	a5,0x8000c
80001280:	34c78513          	addi	a0,a5,844 # 8000c34c <memend+0xf800c34c>
80001284:	b99ff0ef          	jal	ra,80000e1c <printf>
        printf("rodatastart:%p  ",rodatastart);
80001288:	8000c7b7          	lui	a5,0x8000c
8000128c:	00078593          	mv	a1,a5
80001290:	8000c7b7          	lui	a5,0x8000c
80001294:	35878513          	addi	a0,a5,856 # 8000c358 <memend+0xf800c358>
80001298:	b85ff0ef          	jal	ra,80000e1c <printf>
        printf("rodataend:%p\n",rodataend);
8000129c:	8000c7b7          	lui	a5,0x8000c
800012a0:	3ff78593          	addi	a1,a5,1023 # 8000c3ff <memend+0xf800c3ff>
800012a4:	8000c7b7          	lui	a5,0x8000c
800012a8:	36c78513          	addi	a0,a5,876 # 8000c36c <memend+0xf800c36c>
800012ac:	b71ff0ef          	jal	ra,80000e1c <printf>
        printf("bssstart:%p     ",bssstart);
800012b0:	8000d7b7          	lui	a5,0x8000d
800012b4:	00078593          	mv	a1,a5
800012b8:	8000c7b7          	lui	a5,0x8000c
800012bc:	37c78513          	addi	a0,a5,892 # 8000c37c <memend+0xf800c37c>
800012c0:	b5dff0ef          	jal	ra,80000e1c <printf>
        printf("bssend:%p\n",bssend);
800012c4:	8000e7b7          	lui	a5,0x8000e
800012c8:	9f078593          	addi	a1,a5,-1552 # 8000d9f0 <memend+0xf800d9f0>
800012cc:	8000c7b7          	lui	a5,0x8000c
800012d0:	39078513          	addi	a0,a5,912 # 8000c390 <memend+0xf800c390>
800012d4:	b49ff0ef          	jal	ra,80000e1c <printf>
        printf("mstart:%p   ",mstart);
800012d8:	8000e7b7          	lui	a5,0x8000e
800012dc:	00078593          	mv	a1,a5
800012e0:	8000c7b7          	lui	a5,0x8000c
800012e4:	39c78513          	addi	a0,a5,924 # 8000c39c <memend+0xf800c39c>
800012e8:	b35ff0ef          	jal	ra,80000e1c <printf>
        printf("mend:%p\n",mend);
800012ec:	880007b7          	lui	a5,0x88000
800012f0:	00078593          	mv	a1,a5
800012f4:	8000c7b7          	lui	a5,0x8000c
800012f8:	3ac78513          	addi	a0,a5,940 # 8000c3ac <memend+0xf800c3ac>
800012fc:	b21ff0ef          	jal	ra,80000e1c <printf>
        printf("stack:%p\n",stacks);
80001300:	800037b7          	lui	a5,0x80003
80001304:	00878593          	addi	a1,a5,8 # 80003008 <memend+0xf8003008>
80001308:	8000c7b7          	lui	a5,0x8000c
8000130c:	3b878513          	addi	a0,a5,952 # 8000c3b8 <memend+0xf800c3b8>
80001310:	b0dff0ef          	jal	ra,80000e1c <printf>
    #endif

    char* p=(char*)mstart;
80001314:	8000e7b7          	lui	a5,0x8000e
80001318:	00078793          	mv	a5,a5
8000131c:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001320:	0380006f          	j	80001358 <minit+0x130>
        m=(struct pmp*)p;
80001324:	fec42783          	lw	a5,-20(s0)
80001328:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
8000132c:	8000e7b7          	lui	a5,0x8000e
80001330:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001334:	fe842783          	lw	a5,-24(s0)
80001338:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
8000133c:	8000e7b7          	lui	a5,0x8000e
80001340:	fe842703          	lw	a4,-24(s0)
80001344:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001348:	fec42703          	lw	a4,-20(s0)
8000134c:	000017b7          	lui	a5,0x1
80001350:	00f707b3          	add	a5,a4,a5
80001354:	fef42623          	sw	a5,-20(s0)
80001358:	fec42703          	lw	a4,-20(s0)
8000135c:	000017b7          	lui	a5,0x1
80001360:	00f70733          	add	a4,a4,a5
80001364:	880007b7          	lui	a5,0x88000
80001368:	00078793          	mv	a5,a5
8000136c:	fae7fce3          	bgeu	a5,a4,80001324 <minit+0xfc>
    }
}
80001370:	00000013          	nop
80001374:	00000013          	nop
80001378:	01c12083          	lw	ra,28(sp)
8000137c:	01812403          	lw	s0,24(sp)
80001380:	02010113          	addi	sp,sp,32
80001384:	00008067          	ret

80001388 <palloc>:

void* palloc(){
80001388:	fe010113          	addi	sp,sp,-32
8000138c:	00112e23          	sw	ra,28(sp)
80001390:	00812c23          	sw	s0,24(sp)
80001394:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80001398:	8000e7b7          	lui	a5,0x8000e
8000139c:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800013a0:	fef42623          	sw	a5,-20(s0)
    if(p)
800013a4:	fec42783          	lw	a5,-20(s0)
800013a8:	00078c63          	beqz	a5,800013c0 <palloc+0x38>
        mem.freelist=mem.freelist->next;
800013ac:	8000e7b7          	lui	a5,0x8000e
800013b0:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800013b4:	0007a703          	lw	a4,0(a5)
800013b8:	8000e7b7          	lui	a5,0x8000e
800013bc:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    if(p)
800013c0:	fec42783          	lw	a5,-20(s0)
800013c4:	00078a63          	beqz	a5,800013d8 <palloc+0x50>
        memset(p,0,PGSIZE);
800013c8:	00001637          	lui	a2,0x1
800013cc:	00000593          	li	a1,0
800013d0:	fec42503          	lw	a0,-20(s0)
800013d4:	2d9000ef          	jal	ra,80001eac <memset>
    return (void*)p;
800013d8:	fec42783          	lw	a5,-20(s0)
}
800013dc:	00078513          	mv	a0,a5
800013e0:	01c12083          	lw	ra,28(sp)
800013e4:	01812403          	lw	s0,24(sp)
800013e8:	02010113          	addi	sp,sp,32
800013ec:	00008067          	ret

800013f0 <pfree>:

void pfree(void* addr){
800013f0:	fd010113          	addi	sp,sp,-48
800013f4:	02812623          	sw	s0,44(sp)
800013f8:	03010413          	addi	s0,sp,48
800013fc:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80001400:	fdc42783          	lw	a5,-36(s0)
80001404:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
80001408:	8000e7b7          	lui	a5,0x8000e
8000140c:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001410:	fec42783          	lw	a5,-20(s0)
80001414:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
80001418:	8000e7b7          	lui	a5,0x8000e
8000141c:	fec42703          	lw	a4,-20(s0)
80001420:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001424:	00000013          	nop
80001428:	02c12403          	lw	s0,44(sp)
8000142c:	03010113          	addi	sp,sp,48
80001430:	00008067          	ret

80001434 <r_tp>:
static inline uint32 r_tp(){
80001434:	fe010113          	addi	sp,sp,-32
80001438:	00812e23          	sw	s0,28(sp)
8000143c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001440:	00020793          	mv	a5,tp
80001444:	fef42623          	sw	a5,-20(s0)
    return x;
80001448:	fec42783          	lw	a5,-20(s0)
}
8000144c:	00078513          	mv	a0,a5
80001450:	01c12403          	lw	s0,28(sp)
80001454:	02010113          	addi	sp,sp,32
80001458:	00008067          	ret

8000145c <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
8000145c:	fe010113          	addi	sp,sp,-32
80001460:	00812e23          	sw	s0,28(sp)
80001464:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
80001468:	104027f3          	csrr	a5,sie
8000146c:	fef42623          	sw	a5,-20(s0)
    return x;
80001470:	fec42783          	lw	a5,-20(s0)
}
80001474:	00078513          	mv	a0,a5
80001478:	01c12403          	lw	s0,28(sp)
8000147c:	02010113          	addi	sp,sp,32
80001480:	00008067          	ret

80001484 <w_sie>:
static inline void w_sie(uint32 x){
80001484:	fe010113          	addi	sp,sp,-32
80001488:	00812e23          	sw	s0,28(sp)
8000148c:	02010413          	addi	s0,sp,32
80001490:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80001494:	fec42783          	lw	a5,-20(s0)
80001498:	10479073          	csrw	sie,a5
}
8000149c:	00000013          	nop
800014a0:	01c12403          	lw	s0,28(sp)
800014a4:	02010113          	addi	sp,sp,32
800014a8:	00008067          	ret

800014ac <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
800014ac:	ff010113          	addi	sp,sp,-16
800014b0:	00112623          	sw	ra,12(sp)
800014b4:	00812423          	sw	s0,8(sp)
800014b8:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
800014bc:	0c0007b7          	lui	a5,0xc000
800014c0:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
800014c4:	00100713          	li	a4,1
800014c8:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800014cc:	f69ff0ef          	jal	ra,80001434 <r_tp>
800014d0:	00050793          	mv	a5,a0
800014d4:	00879713          	slli	a4,a5,0x8
800014d8:	0c0027b7          	lui	a5,0xc002
800014dc:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
800014e0:	00f707b3          	add	a5,a4,a5
800014e4:	00078713          	mv	a4,a5
800014e8:	40000793          	li	a5,1024
800014ec:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800014f0:	f45ff0ef          	jal	ra,80001434 <r_tp>
800014f4:	00050713          	mv	a4,a0
800014f8:	000c07b7          	lui	a5,0xc0
800014fc:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
80001500:	00f707b3          	add	a5,a4,a5
80001504:	00879793          	slli	a5,a5,0x8
80001508:	00078713          	mv	a4,a5
8000150c:	40000793          	li	a5,1024
80001510:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
80001514:	f21ff0ef          	jal	ra,80001434 <r_tp>
80001518:	00050713          	mv	a4,a0
8000151c:	000067b7          	lui	a5,0x6
80001520:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
80001524:	00f707b3          	add	a5,a4,a5
80001528:	00d79793          	slli	a5,a5,0xd
8000152c:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
80001530:	f05ff0ef          	jal	ra,80001434 <r_tp>
80001534:	00050793          	mv	a5,a0
80001538:	00d79713          	slli	a4,a5,0xd
8000153c:	0c2017b7          	lui	a5,0xc201
80001540:	00f707b3          	add	a5,a4,a5
80001544:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
80001548:	f15ff0ef          	jal	ra,8000145c <r_sie>
8000154c:	00050793          	mv	a5,a0
80001550:	2227e793          	ori	a5,a5,546
80001554:	00078513          	mv	a0,a5
80001558:	f2dff0ef          	jal	ra,80001484 <w_sie>
}
8000155c:	00000013          	nop
80001560:	00c12083          	lw	ra,12(sp)
80001564:	00812403          	lw	s0,8(sp)
80001568:	01010113          	addi	sp,sp,16
8000156c:	00008067          	ret

80001570 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80001570:	ff010113          	addi	sp,sp,-16
80001574:	00112623          	sw	ra,12(sp)
80001578:	00812423          	sw	s0,8(sp)
8000157c:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001580:	eb5ff0ef          	jal	ra,80001434 <r_tp>
80001584:	00050793          	mv	a5,a0
80001588:	00d79713          	slli	a4,a5,0xd
8000158c:	0c2017b7          	lui	a5,0xc201
80001590:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001594:	00f707b3          	add	a5,a4,a5
80001598:	0007a783          	lw	a5,0(a5)
}
8000159c:	00078513          	mv	a0,a5
800015a0:	00c12083          	lw	ra,12(sp)
800015a4:	00812403          	lw	s0,8(sp)
800015a8:	01010113          	addi	sp,sp,16
800015ac:	00008067          	ret

800015b0 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
800015b0:	fe010113          	addi	sp,sp,-32
800015b4:	00112e23          	sw	ra,28(sp)
800015b8:	00812c23          	sw	s0,24(sp)
800015bc:	02010413          	addi	s0,sp,32
800015c0:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
800015c4:	e71ff0ef          	jal	ra,80001434 <r_tp>
800015c8:	00050793          	mv	a5,a0
800015cc:	00d79713          	slli	a4,a5,0xd
800015d0:	0c2007b7          	lui	a5,0xc200
800015d4:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
800015d8:	00f707b3          	add	a5,a4,a5
800015dc:	00078713          	mv	a4,a5
800015e0:	fec42783          	lw	a5,-20(s0)
800015e4:	00f72023          	sw	a5,0(a4)
800015e8:	00000013          	nop
800015ec:	01c12083          	lw	ra,28(sp)
800015f0:	01812403          	lw	s0,24(sp)
800015f4:	02010113          	addi	sp,sp,32
800015f8:	00008067          	ret

800015fc <w_satp>:
static inline void w_satp(uint32 x){
800015fc:	fe010113          	addi	sp,sp,-32
80001600:	00812e23          	sw	s0,28(sp)
80001604:	02010413          	addi	s0,sp,32
80001608:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
8000160c:	fec42783          	lw	a5,-20(s0)
80001610:	18079073          	csrw	satp,a5
}
80001614:	00000013          	nop
80001618:	01c12403          	lw	s0,28(sp)
8000161c:	02010113          	addi	sp,sp,32
80001620:	00008067          	ret

80001624 <sfence_vma>:
static inline void sfence_vma(){
80001624:	ff010113          	addi	sp,sp,-16
80001628:	00812623          	sw	s0,12(sp)
8000162c:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
80001630:	12000073          	sfence.vma
}
80001634:	00000013          	nop
80001638:	00c12403          	lw	s0,12(sp)
8000163c:	01010113          	addi	sp,sp,16
80001640:	00008067          	ret

80001644 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
80001644:	fd010113          	addi	sp,sp,-48
80001648:	02112623          	sw	ra,44(sp)
8000164c:	02812423          	sw	s0,40(sp)
80001650:	03010413          	addi	s0,sp,48
80001654:	fca42e23          	sw	a0,-36(s0)
80001658:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
8000165c:	fd842783          	lw	a5,-40(s0)
80001660:	0167d793          	srli	a5,a5,0x16
80001664:	00279793          	slli	a5,a5,0x2
80001668:	fdc42703          	lw	a4,-36(s0)
8000166c:	00f707b3          	add	a5,a4,a5
80001670:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001674:	fec42783          	lw	a5,-20(s0)
80001678:	0007a783          	lw	a5,0(a5)
8000167c:	0017f793          	andi	a5,a5,1
80001680:	00078e63          	beqz	a5,8000169c <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001684:	fec42783          	lw	a5,-20(s0)
80001688:	0007a783          	lw	a5,0(a5)
8000168c:	00a7d793          	srli	a5,a5,0xa
80001690:	00c79793          	slli	a5,a5,0xc
80001694:	fcf42e23          	sw	a5,-36(s0)
80001698:	0340006f          	j	800016cc <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
8000169c:	cedff0ef          	jal	ra,80001388 <palloc>
800016a0:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
800016a4:	00001637          	lui	a2,0x1
800016a8:	00000593          	li	a1,0
800016ac:	fdc42503          	lw	a0,-36(s0)
800016b0:	7fc000ef          	jal	ra,80001eac <memset>
        *pte = PA2PTE(pgt) | PTE_V;
800016b4:	fdc42783          	lw	a5,-36(s0)
800016b8:	00c7d793          	srli	a5,a5,0xc
800016bc:	00a79793          	slli	a5,a5,0xa
800016c0:	0017e713          	ori	a4,a5,1
800016c4:	fec42783          	lw	a5,-20(s0)
800016c8:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
800016cc:	fd842783          	lw	a5,-40(s0)
800016d0:	00c7d793          	srli	a5,a5,0xc
800016d4:	3ff7f793          	andi	a5,a5,1023
800016d8:	00279793          	slli	a5,a5,0x2
800016dc:	fdc42703          	lw	a4,-36(s0)
800016e0:	00f707b3          	add	a5,a4,a5
}
800016e4:	00078513          	mv	a0,a5
800016e8:	02c12083          	lw	ra,44(sp)
800016ec:	02812403          	lw	s0,40(sp)
800016f0:	03010113          	addi	sp,sp,48
800016f4:	00008067          	ret

800016f8 <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
800016f8:	fc010113          	addi	sp,sp,-64
800016fc:	02112e23          	sw	ra,60(sp)
80001700:	02812c23          	sw	s0,56(sp)
80001704:	04010413          	addi	s0,sp,64
80001708:	fca42e23          	sw	a0,-36(s0)
8000170c:	fcb42c23          	sw	a1,-40(s0)
80001710:	fcc42a23          	sw	a2,-44(s0)
80001714:	fcd42823          	sw	a3,-48(s0)
80001718:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
8000171c:	fd842703          	lw	a4,-40(s0)
80001720:	fffff7b7          	lui	a5,0xfffff
80001724:	00f777b3          	and	a5,a4,a5
80001728:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
8000172c:	fd042703          	lw	a4,-48(s0)
80001730:	fd842783          	lw	a5,-40(s0)
80001734:	00f707b3          	add	a5,a4,a5
80001738:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
8000173c:	fffff7b7          	lui	a5,0xfffff
80001740:	00f777b3          	and	a5,a4,a5
80001744:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
80001748:	fec42583          	lw	a1,-20(s0)
8000174c:	fdc42503          	lw	a0,-36(s0)
80001750:	ef5ff0ef          	jal	ra,80001644 <acquriepte>
80001754:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
80001758:	fe442783          	lw	a5,-28(s0)
8000175c:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001760:	0017f793          	andi	a5,a5,1
80001764:	00078863          	beqz	a5,80001774 <vmmap+0x7c>
            panic("repeat map");
80001768:	8000c7b7          	lui	a5,0x8000c
8000176c:	3c478513          	addi	a0,a5,964 # 8000c3c4 <memend+0xf800c3c4>
80001770:	e74ff0ef          	jal	ra,80000de4 <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001774:	fd442783          	lw	a5,-44(s0)
80001778:	00c7d793          	srli	a5,a5,0xc
8000177c:	00a79713          	slli	a4,a5,0xa
80001780:	fcc42783          	lw	a5,-52(s0)
80001784:	00f767b3          	or	a5,a4,a5
80001788:	0017e713          	ori	a4,a5,1
8000178c:	fe442783          	lw	a5,-28(s0)
80001790:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001794:	fec42703          	lw	a4,-20(s0)
80001798:	fe842783          	lw	a5,-24(s0)
8000179c:	02f70463          	beq	a4,a5,800017c4 <vmmap+0xcc>
        start += PGSIZE;
800017a0:	fec42703          	lw	a4,-20(s0)
800017a4:	000017b7          	lui	a5,0x1
800017a8:	00f707b3          	add	a5,a4,a5
800017ac:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
800017b0:	fd442703          	lw	a4,-44(s0)
800017b4:	000017b7          	lui	a5,0x1
800017b8:	00f707b3          	add	a5,a4,a5
800017bc:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
800017c0:	f89ff06f          	j	80001748 <vmmap+0x50>
        if(start==end)  break;
800017c4:	00000013          	nop
    }
}
800017c8:	00000013          	nop
800017cc:	03c12083          	lw	ra,60(sp)
800017d0:	03812403          	lw	s0,56(sp)
800017d4:	04010113          	addi	sp,sp,64
800017d8:	00008067          	ret

800017dc <printpgt>:

void printpgt(addr_t* pgt){
800017dc:	fc010113          	addi	sp,sp,-64
800017e0:	02112e23          	sw	ra,60(sp)
800017e4:	02812c23          	sw	s0,56(sp)
800017e8:	04010413          	addi	s0,sp,64
800017ec:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
800017f0:	fe042623          	sw	zero,-20(s0)
800017f4:	0c40006f          	j	800018b8 <printpgt+0xdc>
        pte_t pte=pgt[i];
800017f8:	fec42783          	lw	a5,-20(s0)
800017fc:	00279793          	slli	a5,a5,0x2
80001800:	fcc42703          	lw	a4,-52(s0)
80001804:	00f707b3          	add	a5,a4,a5
80001808:	0007a783          	lw	a5,0(a5) # 1000 <sz>
8000180c:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
80001810:	fe442783          	lw	a5,-28(s0)
80001814:	0017f793          	andi	a5,a5,1
80001818:	08078a63          	beqz	a5,800018ac <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
8000181c:	fe442783          	lw	a5,-28(s0)
80001820:	00a7d793          	srli	a5,a5,0xa
80001824:	00c79793          	slli	a5,a5,0xc
80001828:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
8000182c:	fe042683          	lw	a3,-32(s0)
80001830:	fe442603          	lw	a2,-28(s0)
80001834:	fec42583          	lw	a1,-20(s0)
80001838:	8000c7b7          	lui	a5,0x8000c
8000183c:	3d078513          	addi	a0,a5,976 # 8000c3d0 <memend+0xf800c3d0>
80001840:	ddcff0ef          	jal	ra,80000e1c <printf>
            for(int j=0;j<1024;j++){
80001844:	fe042423          	sw	zero,-24(s0)
80001848:	0580006f          	j	800018a0 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
8000184c:	fe842783          	lw	a5,-24(s0)
80001850:	00279793          	slli	a5,a5,0x2
80001854:	fe042703          	lw	a4,-32(s0)
80001858:	00f707b3          	add	a5,a4,a5
8000185c:	0007a783          	lw	a5,0(a5)
80001860:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001864:	fdc42783          	lw	a5,-36(s0)
80001868:	0017f793          	andi	a5,a5,1
8000186c:	02078463          	beqz	a5,80001894 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001870:	fdc42783          	lw	a5,-36(s0)
80001874:	00a7d793          	srli	a5,a5,0xa
80001878:	00c79793          	slli	a5,a5,0xc
8000187c:	00078693          	mv	a3,a5
80001880:	fdc42603          	lw	a2,-36(s0)
80001884:	fe842583          	lw	a1,-24(s0)
80001888:	8000c7b7          	lui	a5,0x8000c
8000188c:	3e878513          	addi	a0,a5,1000 # 8000c3e8 <memend+0xf800c3e8>
80001890:	d8cff0ef          	jal	ra,80000e1c <printf>
            for(int j=0;j<1024;j++){
80001894:	fe842783          	lw	a5,-24(s0)
80001898:	00178793          	addi	a5,a5,1
8000189c:	fef42423          	sw	a5,-24(s0)
800018a0:	fe842703          	lw	a4,-24(s0)
800018a4:	3ff00793          	li	a5,1023
800018a8:	fae7d2e3          	bge	a5,a4,8000184c <printpgt+0x70>
    for(int i=0;i<1024;i++){
800018ac:	fec42783          	lw	a5,-20(s0)
800018b0:	00178793          	addi	a5,a5,1
800018b4:	fef42623          	sw	a5,-20(s0)
800018b8:	fec42703          	lw	a4,-20(s0)
800018bc:	3ff00793          	li	a5,1023
800018c0:	f2e7dce3          	bge	a5,a4,800017f8 <printpgt+0x1c>
                }
            }
        }
    }
}
800018c4:	00000013          	nop
800018c8:	00000013          	nop
800018cc:	03c12083          	lw	ra,60(sp)
800018d0:	03812403          	lw	s0,56(sp)
800018d4:	04010113          	addi	sp,sp,64
800018d8:	00008067          	ret

800018dc <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
800018dc:	fd010113          	addi	sp,sp,-48
800018e0:	02112623          	sw	ra,44(sp)
800018e4:	02812423          	sw	s0,40(sp)
800018e8:	03010413          	addi	s0,sp,48
800018ec:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
800018f0:	fe042623          	sw	zero,-20(s0)
800018f4:	04c0006f          	j	80001940 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
800018f8:	fec42783          	lw	a5,-20(s0)
800018fc:	00d79793          	slli	a5,a5,0xd
80001900:	00078713          	mv	a4,a5
80001904:	c00017b7          	lui	a5,0xc0001
80001908:	00f707b3          	add	a5,a4,a5
8000190c:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
80001910:	a79ff0ef          	jal	ra,80001388 <palloc>
80001914:	00050793          	mv	a5,a0
80001918:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
8000191c:	00600713          	li	a4,6
80001920:	000016b7          	lui	a3,0x1
80001924:	fe442603          	lw	a2,-28(s0)
80001928:	fe842583          	lw	a1,-24(s0)
8000192c:	fdc42503          	lw	a0,-36(s0)
80001930:	dc9ff0ef          	jal	ra,800016f8 <vmmap>
    for(int i=0;i<NPROC;i++){
80001934:	fec42783          	lw	a5,-20(s0)
80001938:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
8000193c:	fef42623          	sw	a5,-20(s0)
80001940:	fec42703          	lw	a4,-20(s0)
80001944:	00300793          	li	a5,3
80001948:	fae7d8e3          	bge	a5,a4,800018f8 <mkstack+0x1c>
    }
}
8000194c:	00000013          	nop
80001950:	00000013          	nop
80001954:	02c12083          	lw	ra,44(sp)
80001958:	02812403          	lw	s0,40(sp)
8000195c:	03010113          	addi	sp,sp,48
80001960:	00008067          	ret

80001964 <kvminit>:

// 初始化虚拟内存
void kvminit(){
80001964:	ff010113          	addi	sp,sp,-16
80001968:	00112623          	sw	ra,12(sp)
8000196c:	00812423          	sw	s0,8(sp)
80001970:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001974:	a15ff0ef          	jal	ra,80001388 <palloc>
80001978:	00050713          	mv	a4,a0
8000197c:	8000e7b7          	lui	a5,0x8000e
80001980:	8ae7a423          	sw	a4,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
    memset(kpgt,0,PGSIZE);
80001984:	8000e7b7          	lui	a5,0x8000e
80001988:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
8000198c:	00001637          	lui	a2,0x1
80001990:	00000593          	li	a1,0
80001994:	00078513          	mv	a0,a5
80001998:	514000ef          	jal	ra,80001eac <memset>

    // 映射 CLINT
    vmmap(kpgt,CLINT_BASE,CLINT_BASE,0xc000,PTE_R|PTE_W);
8000199c:	8000e7b7          	lui	a5,0x8000e
800019a0:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019a4:	00600713          	li	a4,6
800019a8:	0000c6b7          	lui	a3,0xc
800019ac:	02000637          	lui	a2,0x2000
800019b0:	020005b7          	lui	a1,0x2000
800019b4:	00078513          	mv	a0,a5
800019b8:	d41ff0ef          	jal	ra,800016f8 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
800019bc:	8000e7b7          	lui	a5,0x8000e
800019c0:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019c4:	00600713          	li	a4,6
800019c8:	004006b7          	lui	a3,0x400
800019cc:	0c000637          	lui	a2,0xc000
800019d0:	0c0005b7          	lui	a1,0xc000
800019d4:	00078513          	mv	a0,a5
800019d8:	d21ff0ef          	jal	ra,800016f8 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
800019dc:	8000e7b7          	lui	a5,0x8000e
800019e0:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019e4:	00600713          	li	a4,6
800019e8:	000016b7          	lui	a3,0x1
800019ec:	10000637          	lui	a2,0x10000
800019f0:	100005b7          	lui	a1,0x10000
800019f4:	00078513          	mv	a0,a5
800019f8:	d01ff0ef          	jal	ra,800016f8 <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
800019fc:	8000e7b7          	lui	a5,0x8000e
80001a00:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001a04:	800007b7          	lui	a5,0x80000
80001a08:	00078593          	mv	a1,a5
80001a0c:	800007b7          	lui	a5,0x80000
80001a10:	00078613          	mv	a2,a5
80001a14:	800027b7          	lui	a5,0x80002
80001a18:	51478713          	addi	a4,a5,1300 # 80002514 <memend+0xf8002514>
80001a1c:	800007b7          	lui	a5,0x80000
80001a20:	00078793          	mv	a5,a5
80001a24:	40f707b3          	sub	a5,a4,a5
80001a28:	00a00713          	li	a4,10
80001a2c:	00078693          	mv	a3,a5
80001a30:	cc9ff0ef          	jal	ra,800016f8 <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001a34:	8000e7b7          	lui	a5,0x8000e
80001a38:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001a3c:	800037b7          	lui	a5,0x80003
80001a40:	00078593          	mv	a1,a5
80001a44:	800037b7          	lui	a5,0x80003
80001a48:	00078613          	mv	a2,a5
80001a4c:	8000b7b7          	lui	a5,0x8000b
80001a50:	00878713          	addi	a4,a5,8 # 8000b008 <memend+0xf800b008>
80001a54:	800037b7          	lui	a5,0x80003
80001a58:	00078793          	mv	a5,a5
80001a5c:	40f707b3          	sub	a5,a4,a5
80001a60:	00600713          	li	a4,6
80001a64:	00078693          	mv	a3,a5
80001a68:	c91ff0ef          	jal	ra,800016f8 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001a6c:	8000e7b7          	lui	a5,0x8000e
80001a70:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001a74:	8000c7b7          	lui	a5,0x8000c
80001a78:	00078593          	mv	a1,a5
80001a7c:	8000c7b7          	lui	a5,0x8000c
80001a80:	00078613          	mv	a2,a5
80001a84:	8000c7b7          	lui	a5,0x8000c
80001a88:	3ff78713          	addi	a4,a5,1023 # 8000c3ff <memend+0xf800c3ff>
80001a8c:	8000c7b7          	lui	a5,0x8000c
80001a90:	00078793          	mv	a5,a5
80001a94:	40f707b3          	sub	a5,a4,a5
80001a98:	00200713          	li	a4,2
80001a9c:	00078693          	mv	a3,a5
80001aa0:	c59ff0ef          	jal	ra,800016f8 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001aa4:	8000e7b7          	lui	a5,0x8000e
80001aa8:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001aac:	8000d7b7          	lui	a5,0x8000d
80001ab0:	00078593          	mv	a1,a5
80001ab4:	8000d7b7          	lui	a5,0x8000d
80001ab8:	00078613          	mv	a2,a5
80001abc:	8000e7b7          	lui	a5,0x8000e
80001ac0:	9f078713          	addi	a4,a5,-1552 # 8000d9f0 <memend+0xf800d9f0>
80001ac4:	8000d7b7          	lui	a5,0x8000d
80001ac8:	00078793          	mv	a5,a5
80001acc:	40f707b3          	sub	a5,a4,a5
80001ad0:	00600713          	li	a4,6
80001ad4:	00078693          	mv	a3,a5
80001ad8:	c21ff0ef          	jal	ra,800016f8 <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001adc:	8000e7b7          	lui	a5,0x8000e
80001ae0:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001ae4:	8000e7b7          	lui	a5,0x8000e
80001ae8:	00078593          	mv	a1,a5
80001aec:	8000e7b7          	lui	a5,0x8000e
80001af0:	00078613          	mv	a2,a5
80001af4:	880007b7          	lui	a5,0x88000
80001af8:	00078713          	mv	a4,a5
80001afc:	8000e7b7          	lui	a5,0x8000e
80001b00:	00078793          	mv	a5,a5
80001b04:	40f707b3          	sub	a5,a4,a5
80001b08:	00600713          	li	a4,6
80001b0c:	00078693          	mv	a3,a5
80001b10:	be9ff0ef          	jal	ra,800016f8 <vmmap>

    mkstack(kpgt);
80001b14:	8000e7b7          	lui	a5,0x8000e
80001b18:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001b1c:	00078513          	mv	a0,a5
80001b20:	dbdff0ef          	jal	ra,800018dc <mkstack>

    // 映射 usertrap
    vmmap(kpgt,USERTRAP,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
80001b24:	8000e7b7          	lui	a5,0x8000e
80001b28:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001b2c:	800007b7          	lui	a5,0x80000
80001b30:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001b34:	00a00713          	li	a4,10
80001b38:	000016b7          	lui	a3,0x1
80001b3c:	00078613          	mv	a2,a5
80001b40:	fffff5b7          	lui	a1,0xfffff
80001b44:	bb5ff0ef          	jal	ra,800016f8 <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001b48:	8000e7b7          	lui	a5,0x8000e
80001b4c:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001b50:	00c7d713          	srli	a4,a5,0xc
80001b54:	800007b7          	lui	a5,0x80000
80001b58:	00f767b3          	or	a5,a4,a5
80001b5c:	00078513          	mv	a0,a5
80001b60:	a9dff0ef          	jal	ra,800015fc <w_satp>
    sfence_vma();       // 刷新页表
80001b64:	ac1ff0ef          	jal	ra,80001624 <sfence_vma>
}
80001b68:	00000013          	nop
80001b6c:	00c12083          	lw	ra,12(sp)
80001b70:	00812403          	lw	s0,8(sp)
80001b74:	01010113          	addi	sp,sp,16
80001b78:	00008067          	ret

80001b7c <pgtcreate>:

addr_t* pgtcreate(){
80001b7c:	fe010113          	addi	sp,sp,-32
80001b80:	00112e23          	sw	ra,28(sp)
80001b84:	00812c23          	sw	s0,24(sp)
80001b88:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001b8c:	ffcff0ef          	jal	ra,80001388 <palloc>
80001b90:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001b94:	fec42783          	lw	a5,-20(s0)
}
80001b98:	00078513          	mv	a0,a5
80001b9c:	01c12083          	lw	ra,28(sp)
80001ba0:	01812403          	lw	s0,24(sp)
80001ba4:	02010113          	addi	sp,sp,32
80001ba8:	00008067          	ret

80001bac <r_tp>:
static inline uint32 r_tp(){
80001bac:	fe010113          	addi	sp,sp,-32
80001bb0:	00812e23          	sw	s0,28(sp)
80001bb4:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001bb8:	00020793          	mv	a5,tp
80001bbc:	fef42623          	sw	a5,-20(s0)
    return x;
80001bc0:	fec42783          	lw	a5,-20(s0)
}
80001bc4:	00078513          	mv	a0,a5
80001bc8:	01c12403          	lw	s0,28(sp)
80001bcc:	02010113          	addi	sp,sp,32
80001bd0:	00008067          	ret

80001bd4 <procinit>:
#include "defs.h"
#include "riscv.h"

uint nextpid=0;

void procinit(){
80001bd4:	fe010113          	addi	sp,sp,-32
80001bd8:	00812e23          	sw	s0,28(sp)
80001bdc:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001be0:	fe042623          	sw	zero,-20(s0)
80001be4:	0480006f          	j	80001c2c <procinit+0x58>
        p=&proc[i];
80001be8:	fec42703          	lw	a4,-20(s0)
80001bec:	11800793          	li	a5,280
80001bf0:	02f70733          	mul	a4,a4,a5
80001bf4:	8000d7b7          	lui	a5,0x8000d
80001bf8:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001bfc:	00f707b3          	add	a5,a4,a5
80001c00:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
80001c04:	fec42783          	lw	a5,-20(s0)
80001c08:	00d79793          	slli	a5,a5,0xd
80001c0c:	00078713          	mv	a4,a5
80001c10:	c00027b7          	lui	a5,0xc0002
80001c14:	00f70733          	add	a4,a4,a5
80001c18:	fe842783          	lw	a5,-24(s0)
80001c1c:	10e7aa23          	sw	a4,276(a5) # c0002114 <memend+0x38002114>
    for(int i=0;i<NPROC;i++){
80001c20:	fec42783          	lw	a5,-20(s0)
80001c24:	00178793          	addi	a5,a5,1
80001c28:	fef42623          	sw	a5,-20(s0)
80001c2c:	fec42703          	lw	a4,-20(s0)
80001c30:	00300793          	li	a5,3
80001c34:	fae7dae3          	bge	a5,a4,80001be8 <procinit+0x14>
    }
}
80001c38:	00000013          	nop
80001c3c:	00000013          	nop
80001c40:	01c12403          	lw	s0,28(sp)
80001c44:	02010113          	addi	sp,sp,32
80001c48:	00008067          	ret

80001c4c <nowproc>:

struct pcb* nowproc(){
80001c4c:	fe010113          	addi	sp,sp,-32
80001c50:	00112e23          	sw	ra,28(sp)
80001c54:	00812c23          	sw	s0,24(sp)
80001c58:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80001c5c:	f51ff0ef          	jal	ra,80001bac <r_tp>
80001c60:	00050793          	mv	a5,a0
80001c64:	fef42623          	sw	a5,-20(s0)
    return cpu[hart].proc;
80001c68:	8000e7b7          	lui	a5,0x8000e
80001c6c:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001c70:	fec42783          	lw	a5,-20(s0)
80001c74:	00379793          	slli	a5,a5,0x3
80001c78:	00f707b3          	add	a5,a4,a5
80001c7c:	0007a783          	lw	a5,0(a5)
}
80001c80:	00078513          	mv	a0,a5
80001c84:	01c12083          	lw	ra,28(sp)
80001c88:	01812403          	lw	s0,24(sp)
80001c8c:	02010113          	addi	sp,sp,32
80001c90:	00008067          	ret

80001c94 <pidalloc>:

uint pidalloc(){
80001c94:	ff010113          	addi	sp,sp,-16
80001c98:	00812623          	sw	s0,12(sp)
80001c9c:	01010413          	addi	s0,sp,16
    return nextpid++;
80001ca0:	8000d7b7          	lui	a5,0x8000d
80001ca4:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
80001ca8:	00178693          	addi	a3,a5,1
80001cac:	8000d737          	lui	a4,0x8000d
80001cb0:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
} 
80001cb4:	00078513          	mv	a0,a5
80001cb8:	00c12403          	lw	s0,12(sp)
80001cbc:	01010113          	addi	sp,sp,16
80001cc0:	00008067          	ret

80001cc4 <procalloc>:

struct pcb* procalloc(){
80001cc4:	fe010113          	addi	sp,sp,-32
80001cc8:	00112e23          	sw	ra,28(sp)
80001ccc:	00812c23          	sw	s0,24(sp)
80001cd0:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80001cd4:	8000d7b7          	lui	a5,0x8000d
80001cd8:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001cdc:	fef42623          	sw	a5,-20(s0)
80001ce0:	0680006f          	j	80001d48 <procalloc+0x84>
        if(p->status==UNUSED){
80001ce4:	fec42783          	lw	a5,-20(s0)
80001ce8:	0047a783          	lw	a5,4(a5)
80001cec:	04079863          	bnez	a5,80001d3c <procalloc+0x78>
            p->pid=pidalloc();
80001cf0:	fa5ff0ef          	jal	ra,80001c94 <pidalloc>
80001cf4:	00050793          	mv	a5,a0
80001cf8:	00078713          	mv	a4,a5
80001cfc:	fec42783          	lw	a5,-20(s0)
80001d00:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80001d04:	fec42783          	lw	a5,-20(s0)
80001d08:	00100713          	li	a4,1
80001d0c:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
80001d10:	e6dff0ef          	jal	ra,80001b7c <pgtcreate>
80001d14:	00050713          	mv	a4,a0
80001d18:	fec42783          	lw	a5,-20(s0)
80001d1c:	10e7a823          	sw	a4,272(a5)
            
            p->trapframe.epc=0;
80001d20:	fec42783          	lw	a5,-20(s0)
80001d24:	0007aa23          	sw	zero,20(a5)
            p->trapframe.sp=KSPACE;
80001d28:	fec42783          	lw	a5,-20(s0)
80001d2c:	c0000737          	lui	a4,0xc0000
80001d30:	00e7ae23          	sw	a4,28(a5)

            return p;
80001d34:	fec42783          	lw	a5,-20(s0)
80001d38:	0240006f          	j	80001d5c <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
80001d3c:	fec42783          	lw	a5,-20(s0)
80001d40:	11878793          	addi	a5,a5,280
80001d44:	fef42623          	sw	a5,-20(s0)
80001d48:	fec42703          	lw	a4,-20(s0)
80001d4c:	8000e7b7          	lui	a5,0x8000e
80001d50:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001d54:	f8f768e3          	bltu	a4,a5,80001ce4 <procalloc+0x20>
        }
    }
    return 0;
80001d58:	00000793          	li	a5,0
}
80001d5c:	00078513          	mv	a0,a5
80001d60:	01c12083          	lw	ra,28(sp)
80001d64:	01812403          	lw	s0,24(sp)
80001d68:	02010113          	addi	sp,sp,32
80001d6c:	00008067          	ret

80001d70 <userinit>:
  0x93,0x08,0x10,0x00,
  0x73,0x00,0x00,0x00
  };

// 初始化第一个进程
void userinit(){
80001d70:	fe010113          	addi	sp,sp,-32
80001d74:	00112e23          	sw	ra,28(sp)
80001d78:	00812c23          	sw	s0,24(sp)
80001d7c:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80001d80:	f45ff0ef          	jal	ra,80001cc4 <procalloc>
80001d84:	fea42623          	sw	a0,-20(s0)
    
    char* m=(char*)palloc();
80001d88:	e00ff0ef          	jal	ra,80001388 <palloc>
80001d8c:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80001d90:	00800613          	li	a2,8
80001d94:	00000693          	li	a3,0
80001d98:	800037b7          	lui	a5,0x80003
80001d9c:	00078593          	mv	a1,a5
80001da0:	fe842503          	lw	a0,-24(s0)
80001da4:	174000ef          	jal	ra,80001f18 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X|PTE_U);
80001da8:	fec42783          	lw	a5,-20(s0)
80001dac:	1107a783          	lw	a5,272(a5) # 80003110 <memend+0xf8003110>
80001db0:	fe842603          	lw	a2,-24(s0)
80001db4:	01e00713          	li	a4,30
80001db8:	000016b7          	lui	a3,0x1
80001dbc:	00000593          	li	a1,0
80001dc0:	00078513          	mv	a0,a5
80001dc4:	935ff0ef          	jal	ra,800016f8 <vmmap>
    vmmap(p->pagetable,(uint32)usertrap,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
80001dc8:	fec42783          	lw	a5,-20(s0)
80001dcc:	1107a503          	lw	a0,272(a5)
80001dd0:	800007b7          	lui	a5,0x80000
80001dd4:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80001dd8:	800007b7          	lui	a5,0x80000
80001ddc:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001de0:	00a00713          	li	a4,10
80001de4:	000016b7          	lui	a3,0x1
80001de8:	00078613          	mv	a2,a5
80001dec:	90dff0ef          	jal	ra,800016f8 <vmmap>

    p->context.sp=KSPACE;
80001df0:	fec42783          	lw	a5,-20(s0)
80001df4:	c0000737          	lui	a4,0xc0000
80001df8:	08e7ac23          	sw	a4,152(a5)

    p->pagetable=(addr_t*)p->pagetable;
80001dfc:	fec42783          	lw	a5,-20(s0)
80001e00:	1107a703          	lw	a4,272(a5)
80001e04:	fec42783          	lw	a5,-20(s0)
80001e08:	10e7a823          	sw	a4,272(a5)

    p->trapframe.sp=PGSIZE;
80001e0c:	fec42783          	lw	a5,-20(s0)
80001e10:	00001737          	lui	a4,0x1
80001e14:	00e7ae23          	sw	a4,28(a5)

    p->status=RUNABLE;
80001e18:	fec42783          	lw	a5,-20(s0)
80001e1c:	00200713          	li	a4,2
80001e20:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
80001e24:	fec42783          	lw	a5,-20(s0)
80001e28:	1107a783          	lw	a5,272(a5)
80001e2c:	00078513          	mv	a0,a5
80001e30:	aadff0ef          	jal	ra,800018dc <mkstack>

    int id=r_tp();
80001e34:	d79ff0ef          	jal	ra,80001bac <r_tp>
80001e38:	00050793          	mv	a5,a0
80001e3c:	fef42223          	sw	a5,-28(s0)
    cpu[id].proc=p;
80001e40:	8000e7b7          	lui	a5,0x8000e
80001e44:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001e48:	fe442783          	lw	a5,-28(s0)
80001e4c:	00379793          	slli	a5,a5,0x3
80001e50:	00f707b3          	add	a5,a4,a5
80001e54:	fec42703          	lw	a4,-20(s0)
80001e58:	00e7a023          	sw	a4,0(a5)
}
80001e5c:	00000013          	nop
80001e60:	01c12083          	lw	ra,28(sp)
80001e64:	01812403          	lw	s0,24(sp)
80001e68:	02010113          	addi	sp,sp,32
80001e6c:	00008067          	ret

80001e70 <schedule>:

void schedule(){
80001e70:	fe010113          	addi	sp,sp,-32
80001e74:	00812e23          	sw	s0,28(sp)
80001e78:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
80001e7c:	8000d7b7          	lui	a5,0x8000d
80001e80:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001e84:	fef42623          	sw	a5,-20(s0)
80001e88:	0100006f          	j	80001e98 <schedule+0x28>
80001e8c:	fec42783          	lw	a5,-20(s0)
80001e90:	11878793          	addi	a5,a5,280
80001e94:	fef42623          	sw	a5,-20(s0)
80001e98:	fec42703          	lw	a4,-20(s0)
80001e9c:	8000e7b7          	lui	a5,0x8000e
80001ea0:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001ea4:	fef764e3          	bltu	a4,a5,80001e8c <schedule+0x1c>
    for(;;){
80001ea8:	fd5ff06f          	j	80001e7c <schedule+0xc>

80001eac <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80001eac:	fd010113          	addi	sp,sp,-48
80001eb0:	02812623          	sw	s0,44(sp)
80001eb4:	03010413          	addi	s0,sp,48
80001eb8:	fca42e23          	sw	a0,-36(s0)
80001ebc:	fcb42c23          	sw	a1,-40(s0)
80001ec0:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
80001ec4:	fdc42783          	lw	a5,-36(s0)
80001ec8:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001ecc:	fe042623          	sw	zero,-20(s0)
80001ed0:	0280006f          	j	80001ef8 <memset+0x4c>
        maddr[i] = (char)c;
80001ed4:	fe842703          	lw	a4,-24(s0)
80001ed8:	fec42783          	lw	a5,-20(s0)
80001edc:	00f707b3          	add	a5,a4,a5
80001ee0:	fd842703          	lw	a4,-40(s0)
80001ee4:	0ff77713          	andi	a4,a4,255
80001ee8:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001eec:	fec42783          	lw	a5,-20(s0)
80001ef0:	00178793          	addi	a5,a5,1
80001ef4:	fef42623          	sw	a5,-20(s0)
80001ef8:	fec42703          	lw	a4,-20(s0)
80001efc:	fd442783          	lw	a5,-44(s0)
80001f00:	fcf76ae3          	bltu	a4,a5,80001ed4 <memset+0x28>
    }
    return addr;
80001f04:	fdc42783          	lw	a5,-36(s0)
}
80001f08:	00078513          	mv	a0,a5
80001f0c:	02c12403          	lw	s0,44(sp)
80001f10:	03010113          	addi	sp,sp,48
80001f14:	00008067          	ret

80001f18 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80001f18:	fd010113          	addi	sp,sp,-48
80001f1c:	02812623          	sw	s0,44(sp)
80001f20:	03010413          	addi	s0,sp,48
80001f24:	fca42e23          	sw	a0,-36(s0)
80001f28:	fcb42c23          	sw	a1,-40(s0)
80001f2c:	fcc42823          	sw	a2,-48(s0)
80001f30:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001f34:	fd042783          	lw	a5,-48(s0)
80001f38:	fd442703          	lw	a4,-44(s0)
80001f3c:	00e7e7b3          	or	a5,a5,a4
80001f40:	00079663          	bnez	a5,80001f4c <memmove+0x34>
        return dst;
80001f44:	fdc42783          	lw	a5,-36(s0)
80001f48:	1200006f          	j	80002068 <memmove+0x150>
    }

    s = src;
80001f4c:	fd842783          	lw	a5,-40(s0)
80001f50:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001f54:	fdc42783          	lw	a5,-36(s0)
80001f58:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001f5c:	fec42703          	lw	a4,-20(s0)
80001f60:	fe842783          	lw	a5,-24(s0)
80001f64:	0cf77263          	bgeu	a4,a5,80002028 <memmove+0x110>
80001f68:	fd042783          	lw	a5,-48(s0)
80001f6c:	fec42703          	lw	a4,-20(s0)
80001f70:	00f707b3          	add	a5,a4,a5
80001f74:	fe842703          	lw	a4,-24(s0)
80001f78:	0af77863          	bgeu	a4,a5,80002028 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80001f7c:	fd042783          	lw	a5,-48(s0)
80001f80:	fec42703          	lw	a4,-20(s0)
80001f84:	00f707b3          	add	a5,a4,a5
80001f88:	fef42623          	sw	a5,-20(s0)
        d += n;
80001f8c:	fd042783          	lw	a5,-48(s0)
80001f90:	fe842703          	lw	a4,-24(s0)
80001f94:	00f707b3          	add	a5,a4,a5
80001f98:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80001f9c:	02c0006f          	j	80001fc8 <memmove+0xb0>
            *--d = *--s;
80001fa0:	fec42783          	lw	a5,-20(s0)
80001fa4:	fff78793          	addi	a5,a5,-1
80001fa8:	fef42623          	sw	a5,-20(s0)
80001fac:	fe842783          	lw	a5,-24(s0)
80001fb0:	fff78793          	addi	a5,a5,-1
80001fb4:	fef42423          	sw	a5,-24(s0)
80001fb8:	fec42783          	lw	a5,-20(s0)
80001fbc:	0007c703          	lbu	a4,0(a5)
80001fc0:	fe842783          	lw	a5,-24(s0)
80001fc4:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80001fc8:	fd042703          	lw	a4,-48(s0)
80001fcc:	fd442783          	lw	a5,-44(s0)
80001fd0:	fff00513          	li	a0,-1
80001fd4:	fff00593          	li	a1,-1
80001fd8:	00a70633          	add	a2,a4,a0
80001fdc:	00060813          	mv	a6,a2
80001fe0:	00e83833          	sltu	a6,a6,a4
80001fe4:	00b786b3          	add	a3,a5,a1
80001fe8:	00d805b3          	add	a1,a6,a3
80001fec:	00058693          	mv	a3,a1
80001ff0:	fcc42823          	sw	a2,-48(s0)
80001ff4:	fcd42a23          	sw	a3,-44(s0)
80001ff8:	00070693          	mv	a3,a4
80001ffc:	00f6e6b3          	or	a3,a3,a5
80002000:	fa0690e3          	bnez	a3,80001fa0 <memmove+0x88>
    if(s < d && s + n > d){     
80002004:	0600006f          	j	80002064 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80002008:	fec42703          	lw	a4,-20(s0)
8000200c:	00170793          	addi	a5,a4,1 # 1001 <sz+0x1>
80002010:	fef42623          	sw	a5,-20(s0)
80002014:	fe842783          	lw	a5,-24(s0)
80002018:	00178693          	addi	a3,a5,1
8000201c:	fed42423          	sw	a3,-24(s0)
80002020:	00074703          	lbu	a4,0(a4)
80002024:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80002028:	fd042703          	lw	a4,-48(s0)
8000202c:	fd442783          	lw	a5,-44(s0)
80002030:	fff00513          	li	a0,-1
80002034:	fff00593          	li	a1,-1
80002038:	00a70633          	add	a2,a4,a0
8000203c:	00060813          	mv	a6,a2
80002040:	00e83833          	sltu	a6,a6,a4
80002044:	00b786b3          	add	a3,a5,a1
80002048:	00d805b3          	add	a1,a6,a3
8000204c:	00058693          	mv	a3,a1
80002050:	fcc42823          	sw	a2,-48(s0)
80002054:	fcd42a23          	sw	a3,-44(s0)
80002058:	00070693          	mv	a3,a4
8000205c:	00f6e6b3          	or	a3,a3,a5
80002060:	fa0694e3          	bnez	a3,80002008 <memmove+0xf0>
        }
    }
    return dst;
80002064:	fdc42783          	lw	a5,-36(s0)
}
80002068:	00078513          	mv	a0,a5
8000206c:	02c12403          	lw	s0,44(sp)
80002070:	03010113          	addi	sp,sp,48
80002074:	00008067          	ret

80002078 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80002078:	fd010113          	addi	sp,sp,-48
8000207c:	02812623          	sw	s0,44(sp)
80002080:	03010413          	addi	s0,sp,48
80002084:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80002088:	00000793          	li	a5,0
8000208c:	00000813          	li	a6,0
80002090:	fef42423          	sw	a5,-24(s0)
80002094:	ff042623          	sw	a6,-20(s0)
80002098:	0340006f          	j	800020cc <strlen+0x54>
8000209c:	fe842603          	lw	a2,-24(s0)
800020a0:	fec42683          	lw	a3,-20(s0)
800020a4:	00100513          	li	a0,1
800020a8:	00000593          	li	a1,0
800020ac:	00a60733          	add	a4,a2,a0
800020b0:	00070813          	mv	a6,a4
800020b4:	00c83833          	sltu	a6,a6,a2
800020b8:	00b687b3          	add	a5,a3,a1
800020bc:	00f806b3          	add	a3,a6,a5
800020c0:	00068793          	mv	a5,a3
800020c4:	fee42423          	sw	a4,-24(s0)
800020c8:	fef42623          	sw	a5,-20(s0)
800020cc:	fe842783          	lw	a5,-24(s0)
800020d0:	fdc42703          	lw	a4,-36(s0)
800020d4:	00f707b3          	add	a5,a4,a5
800020d8:	0007c783          	lbu	a5,0(a5)
800020dc:	fc0790e3          	bnez	a5,8000209c <strlen+0x24>
    
    return n;
800020e0:	fe842703          	lw	a4,-24(s0)
800020e4:	fec42783          	lw	a5,-20(s0)
800020e8:	00070513          	mv	a0,a4
800020ec:	00078593          	mv	a1,a5
800020f0:	02c12403          	lw	s0,44(sp)
800020f4:	03010113          	addi	sp,sp,48
800020f8:	00008067          	ret

800020fc <r_tp>:
static inline uint32 r_tp(){
800020fc:	fe010113          	addi	sp,sp,-32
80002100:	00812e23          	sw	s0,28(sp)
80002104:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80002108:	00020793          	mv	a5,tp
8000210c:	fef42623          	sw	a5,-20(s0)
    return x;
80002110:	fec42783          	lw	a5,-20(s0)
}
80002114:	00078513          	mv	a0,a5
80002118:	01c12403          	lw	s0,28(sp)
8000211c:	02010113          	addi	sp,sp,32
80002120:	00008067          	ret

80002124 <clintinit>:
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit(){
80002124:	fe010113          	addi	sp,sp,-32
80002128:	00112e23          	sw	ra,28(sp)
8000212c:	00812c23          	sw	s0,24(sp)
80002130:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp 
    int hart=r_tp();
80002134:	fc9ff0ef          	jal	ra,800020fc <r_tp>
80002138:	00050793          	mv	a5,a0
8000213c:	fef42623          	sw	a5,-20(s0)
    *(reg_t*)CLINT_MTIMECMP(hart)=*(reg_t*)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
80002140:	fec42703          	lw	a4,-20(s0)
80002144:	004017b7          	lui	a5,0x401
80002148:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
8000214c:	00f707b3          	add	a5,a4,a5
80002150:	00379793          	slli	a5,a5,0x3
80002154:	0007a703          	lw	a4,0(a5)
80002158:	fec42683          	lw	a3,-20(s0)
8000215c:	004017b7          	lui	a5,0x401
80002160:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002164:	00f687b3          	add	a5,a3,a5
80002168:	00379793          	slli	a5,a5,0x3
8000216c:	00078693          	mv	a3,a5
80002170:	009897b7          	lui	a5,0x989
80002174:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80002178:	00f707b3          	add	a5,a4,a5
8000217c:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
80002180:	00000013          	nop
80002184:	01c12083          	lw	ra,28(sp)
80002188:	01812403          	lw	s0,24(sp)
8000218c:	02010113          	addi	sp,sp,32
80002190:	00008067          	ret

80002194 <r_mstatus>:
static inline uint32 r_mstatus(){
80002194:	fe010113          	addi	sp,sp,-32
80002198:	00812e23          	sw	s0,28(sp)
8000219c:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus" : "=r" (x) );
800021a0:	300027f3          	csrr	a5,mstatus
800021a4:	fef42623          	sw	a5,-20(s0)
    return x;
800021a8:	fec42783          	lw	a5,-20(s0)
}
800021ac:	00078513          	mv	a0,a5
800021b0:	01c12403          	lw	s0,28(sp)
800021b4:	02010113          	addi	sp,sp,32
800021b8:	00008067          	ret

800021bc <w_mstatus>:
static inline void w_mstatus(uint32 x){
800021bc:	fe010113          	addi	sp,sp,-32
800021c0:	00812e23          	sw	s0,28(sp)
800021c4:	02010413          	addi	s0,sp,32
800021c8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
800021cc:	fec42783          	lw	a5,-20(s0)
800021d0:	30079073          	csrw	mstatus,a5
}
800021d4:	00000013          	nop
800021d8:	01c12403          	lw	s0,28(sp)
800021dc:	02010113          	addi	sp,sp,32
800021e0:	00008067          	ret

800021e4 <w_mtvec>:
static inline void w_mtvec(uint32 x){
800021e4:	fe010113          	addi	sp,sp,-32
800021e8:	00812e23          	sw	s0,28(sp)
800021ec:	02010413          	addi	s0,sp,32
800021f0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0" : : "r"(x));
800021f4:	fec42783          	lw	a5,-20(s0)
800021f8:	30579073          	csrw	mtvec,a5
}
800021fc:	00000013          	nop
80002200:	01c12403          	lw	s0,28(sp)
80002204:	02010113          	addi	sp,sp,32
80002208:	00008067          	ret

8000220c <r_tp>:
static inline uint32 r_tp(){
8000220c:	fe010113          	addi	sp,sp,-32
80002210:	00812e23          	sw	s0,28(sp)
80002214:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80002218:	00020793          	mv	a5,tp
8000221c:	fef42623          	sw	a5,-20(s0)
    return x;
80002220:	fec42783          	lw	a5,-20(s0)
}
80002224:	00078513          	mv	a0,a5
80002228:	01c12403          	lw	s0,28(sp)
8000222c:	02010113          	addi	sp,sp,32
80002230:	00008067          	ret

80002234 <s_mstatus_intr>:
static inline void s_mstatus_intr(uint32 m){
80002234:	fd010113          	addi	sp,sp,-48
80002238:	02112623          	sw	ra,44(sp)
8000223c:	02812423          	sw	s0,40(sp)
80002240:	03010413          	addi	s0,sp,48
80002244:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80002248:	f4dff0ef          	jal	ra,80002194 <r_mstatus>
8000224c:	fea42623          	sw	a0,-20(s0)
    switch (m)
80002250:	fdc42703          	lw	a4,-36(s0)
80002254:	08000793          	li	a5,128
80002258:	04f70263          	beq	a4,a5,8000229c <s_mstatus_intr+0x68>
8000225c:	fdc42703          	lw	a4,-36(s0)
80002260:	08000793          	li	a5,128
80002264:	0ae7e463          	bltu	a5,a4,8000230c <s_mstatus_intr+0xd8>
80002268:	fdc42703          	lw	a4,-36(s0)
8000226c:	02000793          	li	a5,32
80002270:	04f70463          	beq	a4,a5,800022b8 <s_mstatus_intr+0x84>
80002274:	fdc42703          	lw	a4,-36(s0)
80002278:	02000793          	li	a5,32
8000227c:	08e7e863          	bltu	a5,a4,8000230c <s_mstatus_intr+0xd8>
80002280:	fdc42703          	lw	a4,-36(s0)
80002284:	00200793          	li	a5,2
80002288:	06f70463          	beq	a4,a5,800022f0 <s_mstatus_intr+0xbc>
8000228c:	fdc42703          	lw	a4,-36(s0)
80002290:	00800793          	li	a5,8
80002294:	04f70063          	beq	a4,a5,800022d4 <s_mstatus_intr+0xa0>
        break;
80002298:	0740006f          	j	8000230c <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
8000229c:	fec42783          	lw	a5,-20(s0)
800022a0:	f7f7f793          	andi	a5,a5,-129
800022a4:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
800022a8:	fec42783          	lw	a5,-20(s0)
800022ac:	0807e793          	ori	a5,a5,128
800022b0:	fef42623          	sw	a5,-20(s0)
        break;
800022b4:	05c0006f          	j	80002310 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800022b8:	fec42783          	lw	a5,-20(s0)
800022bc:	fdf7f793          	andi	a5,a5,-33
800022c0:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
800022c4:	fec42783          	lw	a5,-20(s0)
800022c8:	0207e793          	ori	a5,a5,32
800022cc:	fef42623          	sw	a5,-20(s0)
        break;
800022d0:	0400006f          	j	80002310 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
800022d4:	fec42783          	lw	a5,-20(s0)
800022d8:	ff77f793          	andi	a5,a5,-9
800022dc:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
800022e0:	fec42783          	lw	a5,-20(s0)
800022e4:	0087e793          	ori	a5,a5,8
800022e8:	fef42623          	sw	a5,-20(s0)
        break;
800022ec:	0240006f          	j	80002310 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
800022f0:	fec42783          	lw	a5,-20(s0)
800022f4:	ffd7f793          	andi	a5,a5,-3
800022f8:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
800022fc:	fec42783          	lw	a5,-20(s0)
80002300:	0027e793          	ori	a5,a5,2
80002304:	fef42623          	sw	a5,-20(s0)
        break;
80002308:	0080006f          	j	80002310 <s_mstatus_intr+0xdc>
        break;
8000230c:	00000013          	nop
    w_mstatus(x);
80002310:	fec42503          	lw	a0,-20(s0)
80002314:	ea9ff0ef          	jal	ra,800021bc <w_mstatus>
}
80002318:	00000013          	nop
8000231c:	02c12083          	lw	ra,44(sp)
80002320:	02812403          	lw	s0,40(sp)
80002324:	03010113          	addi	sp,sp,48
80002328:	00008067          	ret

8000232c <r_sie>:
static inline uint32 r_sie(){
8000232c:	fe010113          	addi	sp,sp,-32
80002330:	00812e23          	sw	s0,28(sp)
80002334:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie " : "=r"(x));
80002338:	104027f3          	csrr	a5,sie
8000233c:	fef42623          	sw	a5,-20(s0)
    return x;
80002340:	fec42783          	lw	a5,-20(s0)
}
80002344:	00078513          	mv	a0,a5
80002348:	01c12403          	lw	s0,28(sp)
8000234c:	02010113          	addi	sp,sp,32
80002350:	00008067          	ret

80002354 <w_sie>:
static inline void w_sie(uint32 x){
80002354:	fe010113          	addi	sp,sp,-32
80002358:	00812e23          	sw	s0,28(sp)
8000235c:	02010413          	addi	s0,sp,32
80002360:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80002364:	fec42783          	lw	a5,-20(s0)
80002368:	10479073          	csrw	sie,a5
}
8000236c:	00000013          	nop
80002370:	01c12403          	lw	s0,28(sp)
80002374:	02010113          	addi	sp,sp,32
80002378:	00008067          	ret

8000237c <r_mie>:
#define MEIE (1<<11)
#define MTIE (1<<7)
#define MSIE (1<<3)
static inline uint32 r_mie(){
8000237c:	fe010113          	addi	sp,sp,-32
80002380:	00812e23          	sw	s0,28(sp)
80002384:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie " : "=r"(x));
80002388:	304027f3          	csrr	a5,mie
8000238c:	fef42623          	sw	a5,-20(s0)
    return x;
80002390:	fec42783          	lw	a5,-20(s0)
}
80002394:	00078513          	mv	a0,a5
80002398:	01c12403          	lw	s0,28(sp)
8000239c:	02010113          	addi	sp,sp,32
800023a0:	00008067          	ret

800023a4 <w_mie>:
static inline void w_mie(uint32 x){
800023a4:	fe010113          	addi	sp,sp,-32
800023a8:	00812e23          	sw	s0,28(sp)
800023ac:	02010413          	addi	s0,sp,32
800023b0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"::"r"(x));
800023b4:	fec42783          	lw	a5,-20(s0)
800023b8:	30479073          	csrw	mie,a5
}
800023bc:	00000013          	nop
800023c0:	01c12403          	lw	s0,28(sp)
800023c4:	02010113          	addi	sp,sp,32
800023c8:	00008067          	ret

800023cc <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x){
800023cc:	fe010113          	addi	sp,sp,-32
800023d0:	00812e23          	sw	s0,28(sp)
800023d4:	02010413          	addi	s0,sp,32
800023d8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0" : :"r"(x));
800023dc:	fec42783          	lw	a5,-20(s0)
800023e0:	34079073          	csrw	mscratch,a5
800023e4:	00000013          	nop
800023e8:	01c12403          	lw	s0,28(sp)
800023ec:	02010113          	addi	sp,sp,32
800023f0:	00008067          	ret

800023f4 <timerinit>:

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit(){
800023f4:	fe010113          	addi	sp,sp,-32
800023f8:	00112e23          	sw	ra,28(sp)
800023fc:	00812c23          	sw	s0,24(sp)
80002400:	01212a23          	sw	s2,20(sp)
80002404:	01312823          	sw	s3,16(sp)
80002408:	02010413          	addi	s0,sp,32
    uint hart=r_tp();
8000240c:	e01ff0ef          	jal	ra,8000220c <r_tp>
80002410:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
80002414:	fec42703          	lw	a4,-20(s0)
80002418:	00070793          	mv	a5,a4
8000241c:	00279793          	slli	a5,a5,0x2
80002420:	00e787b3          	add	a5,a5,a4
80002424:	00379793          	slli	a5,a5,0x3
80002428:	8000e737          	lui	a4,0x8000e
8000242c:	8b070713          	addi	a4,a4,-1872 # 8000d8b0 <memend+0xf800d8b0>
80002430:	00e787b3          	add	a5,a5,a4
80002434:	00078513          	mv	a0,a5
80002438:	f95ff0ef          	jal	ra,800023cc <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
8000243c:	fec42703          	lw	a4,-20(s0)
80002440:	004017b7          	lui	a5,0x401
80002444:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002448:	00f707b3          	add	a5,a4,a5
8000244c:	00379793          	slli	a5,a5,0x3
80002450:	00078913          	mv	s2,a5
80002454:	00000993          	li	s3,0
80002458:	8000e7b7          	lui	a5,0x8000e
8000245c:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
80002460:	fec42703          	lw	a4,-20(s0)
80002464:	00070793          	mv	a5,a4
80002468:	00279793          	slli	a5,a5,0x2
8000246c:	00e787b3          	add	a5,a5,a4
80002470:	00379793          	slli	a5,a5,0x3
80002474:	00f687b3          	add	a5,a3,a5
80002478:	0127a023          	sw	s2,0(a5)
8000247c:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;
80002480:	8000e7b7          	lui	a5,0x8000e
80002484:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
80002488:	fec42703          	lw	a4,-20(s0)
8000248c:	00070793          	mv	a5,a4
80002490:	00279793          	slli	a5,a5,0x2
80002494:	00e787b3          	add	a5,a5,a4
80002498:	00379793          	slli	a5,a5,0x3
8000249c:	00f686b3          	add	a3,a3,a5
800024a0:	00989737          	lui	a4,0x989
800024a4:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
800024a8:	00000793          	li	a5,0
800024ac:	00e6a423          	sw	a4,8(a3)
800024b0:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数
800024b4:	800007b7          	lui	a5,0x80000
800024b8:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
800024bc:	00078513          	mv	a0,a5
800024c0:	d25ff0ef          	jal	ra,800021e4 <w_mtvec>

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断
800024c4:	00800513          	li	a0,8
800024c8:	d6dff0ef          	jal	ra,80002234 <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
800024cc:	e61ff0ef          	jal	ra,8000232c <r_sie>
800024d0:	00050793          	mv	a5,a0
800024d4:	2227e793          	ori	a5,a5,546
800024d8:	00078513          	mv	a0,a5
800024dc:	e79ff0ef          	jal	ra,80002354 <w_sie>

    w_mie(r_mie() | MTIE );      // 开启 M-mode 时钟中断
800024e0:	e9dff0ef          	jal	ra,8000237c <r_mie>
800024e4:	00050793          	mv	a5,a0
800024e8:	0807e793          	ori	a5,a5,128
800024ec:	00078513          	mv	a0,a5
800024f0:	eb5ff0ef          	jal	ra,800023a4 <w_mie>

    clintinit();                 // 初始化 CLINT           
800024f4:	c31ff0ef          	jal	ra,80002124 <clintinit>
800024f8:	00000013          	nop
800024fc:	01c12083          	lw	ra,28(sp)
80002500:	01812403          	lw	s0,24(sp)
80002504:	01412903          	lw	s2,20(sp)
80002508:	01012983          	lw	s3,16(sp)
8000250c:	02010113          	addi	sp,sp,32
80002510:	00008067          	ret

80002514 <textend>:
	...
