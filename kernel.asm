
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
80000020:	6a40006f          	j	800006c4 <start>

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
800000ac:	6c9000ef          	jal	ra,80000f74 <trapvec>

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

    csrrw a0,sscratch,a0
80000298:	14051573          	csrrw	a0,sscratch,a0

    sw ra,16(a0)
8000029c:	00152823          	sw	ra,16(a0)
    sw sp,20(a0)
800002a0:	00252a23          	sw	sp,20(a0)
    sw gp,24(a0)
800002a4:	00352c23          	sw	gp,24(a0)
    sw tp,28(a0)
800002a8:	00452e23          	sw	tp,28(a0)
    sw a0,32(a0)
800002ac:	02a52023          	sw	a0,32(a0)
    sw a1,36(a0)
800002b0:	02b52223          	sw	a1,36(a0)
    sw a2,40(a0)
800002b4:	02c52423          	sw	a2,40(a0)
    sw a3,44(a0)
800002b8:	02d52623          	sw	a3,44(a0)
    sw a4,48(a0)
800002bc:	02e52823          	sw	a4,48(a0)
    sw a5,52(a0)
800002c0:	02f52a23          	sw	a5,52(a0)
    sw a6,56(a0)
800002c4:	03052c23          	sw	a6,56(a0)
    sw a5,52(a0)
800002c8:	02f52a23          	sw	a5,52(a0)
    sw a7,60(a0)
800002cc:	03152e23          	sw	a7,60(a0)
    sw s0,64(a0)
800002d0:	04852023          	sw	s0,64(a0)
    sw s1,68(a0)
800002d4:	04952223          	sw	s1,68(a0)
    sw s2,72(a0)
800002d8:	05252423          	sw	s2,72(a0)
    sw s3,76(a0)
800002dc:	05352623          	sw	s3,76(a0)
    sw s4,80(a0)
800002e0:	05452823          	sw	s4,80(a0)
    sw s5,84(a0)
800002e4:	05552a23          	sw	s5,84(a0)
    sw s6,88(a0)
800002e8:	05652c23          	sw	s6,88(a0)
    sw s7,92(a0)
800002ec:	05752e23          	sw	s7,92(a0)
    sw s8,96(a0)
800002f0:	07852023          	sw	s8,96(a0)
    sw s9,100(a0)
800002f4:	07952223          	sw	s9,100(a0)
    sw s10,104(a0)
800002f8:	07a52423          	sw	s10,104(a0)
    sw s11,108(a0)
800002fc:	07b52623          	sw	s11,108(a0)
    sw t0,112(a0)
80000300:	06552823          	sw	t0,112(a0)
    sw t1,116(a0)
80000304:	06652a23          	sw	t1,116(a0)
    sw t2,120(a0)
80000308:	06752c23          	sw	t2,120(a0)
    sw t3,124(a0)
8000030c:	07c52e23          	sw	t3,124(a0)
    sw t4,128(a0)
80000310:	09d52023          	sw	t4,128(a0)
    sw t5,132(a0)
80000314:	09e52223          	sw	t5,132(a0)
    sw t6,136(a0)
80000318:	09f52423          	sw	t6,136(a0)

    lw sp,8(a0)
8000031c:	00852103          	lw	sp,8(a0)

    lw t5,4(a0)
80000320:	00452f03          	lw	t5,4(a0)

    lw t6,0(a0)
80000324:	00052f83          	lw	t6,0(a0)
    csrw satp,t6
80000328:	180f9073          	csrw	satp,t6
    sfence.vma zero,zero
8000032c:	12000073          	sfence.vma

    jr t5
80000330:	000f0067          	jr	t5

80000334 <userret>:

.global userret
// userret( traoframe,satp )
userret:

    csrw satp,a1
80000334:	18059073          	csrw	satp,a1
    sfence.vma zero, zero
80000338:	12000073          	sfence.vma

    lw t0,32(a0)        // sscratch 暂存用户态 a0
8000033c:	02052283          	lw	t0,32(a0)
    csrrw t0,sscratch,t0
80000340:	140292f3          	csrrw	t0,sscratch,t0

    lw ra,16(a0)
80000344:	01052083          	lw	ra,16(a0)
    lw sp,20(a0)
80000348:	01452103          	lw	sp,20(a0)
    lw gp,24(a0)
8000034c:	01852183          	lw	gp,24(a0)
    lw tp,28(a0)
80000350:	01c52203          	lw	tp,28(a0)

    lw a1,36(a0)
80000354:	02452583          	lw	a1,36(a0)
    lw a2,40(a0)
80000358:	02852603          	lw	a2,40(a0)
    lw a3,44(a0)
8000035c:	02c52683          	lw	a3,44(a0)
    lw a4,48(a0)
80000360:	03052703          	lw	a4,48(a0)
    lw a5,52(a0)
80000364:	03452783          	lw	a5,52(a0)
    lw a6,56(a0)
80000368:	03852803          	lw	a6,56(a0)
    lw a5,52(a0)
8000036c:	03452783          	lw	a5,52(a0)
    lw a7,60(a0)
80000370:	03c52883          	lw	a7,60(a0)
    
    lw s0,64(a0)
80000374:	04052403          	lw	s0,64(a0)
    lw s1,68(a0)
80000378:	04452483          	lw	s1,68(a0)
    lw s2,72(a0)
8000037c:	04852903          	lw	s2,72(a0)
    lw s3,76(a0)
80000380:	04c52983          	lw	s3,76(a0)
    lw s4,80(a0)
80000384:	05052a03          	lw	s4,80(a0)
    lw s5,84(a0)
80000388:	05452a83          	lw	s5,84(a0)
    lw s6,88(a0)
8000038c:	05852b03          	lw	s6,88(a0)
    lw s7,92(a0)
80000390:	05c52b83          	lw	s7,92(a0)
    lw s8,96(a0)
80000394:	06052c03          	lw	s8,96(a0)
    lw s9,100(a0)
80000398:	06452c83          	lw	s9,100(a0)
    lw s10,104(a0)
8000039c:	06852d03          	lw	s10,104(a0)
    lw s11,108(a0)
800003a0:	06c52d83          	lw	s11,108(a0)

    lw t0,112(a0)
800003a4:	07052283          	lw	t0,112(a0)
    lw t1,116(a0)
800003a8:	07452303          	lw	t1,116(a0)
    lw t2,120(a0)
800003ac:	07852383          	lw	t2,120(a0)
    lw t3,124(a0)
800003b0:	07c52e03          	lw	t3,124(a0)
    lw t4,128(a0)
800003b4:	08052e83          	lw	t4,128(a0)
    lw t5,132(a0)
800003b8:	08452f03          	lw	t5,132(a0)
    lw t6,136(a0)
800003bc:	08852f83          	lw	t6,136(a0)

    csrrw a0,sscratch,a0
800003c0:	14051573          	csrrw	a0,sscratch,a0

800003c4:	10200073          	sret

800003c8 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
800003c8:	fe010113          	addi	sp,sp,-32
800003cc:	00812e23          	sw	s0,28(sp)
800003d0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
800003d4:	300027f3          	csrr	a5,mstatus
800003d8:	fef42623          	sw	a5,-20(s0)
    return x;
800003dc:	fec42783          	lw	a5,-20(s0)
}
800003e0:	00078513          	mv	a0,a5
800003e4:	01c12403          	lw	s0,28(sp)
800003e8:	02010113          	addi	sp,sp,32
800003ec:	00008067          	ret

800003f0 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
800003f0:	fe010113          	addi	sp,sp,-32
800003f4:	00812e23          	sw	s0,28(sp)
800003f8:	02010413          	addi	s0,sp,32
800003fc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80000400:	fec42783          	lw	a5,-20(s0)
80000404:	30079073          	csrw	mstatus,a5
}
80000408:	00000013          	nop
8000040c:	01c12403          	lw	s0,28(sp)
80000410:	02010113          	addi	sp,sp,32
80000414:	00008067          	ret

80000418 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000418:	fd010113          	addi	sp,sp,-48
8000041c:	02112623          	sw	ra,44(sp)
80000420:	02812423          	sw	s0,40(sp)
80000424:	03010413          	addi	s0,sp,48
80000428:	00050793          	mv	a5,a0
8000042c:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
80000430:	f99ff0ef          	jal	ra,800003c8 <r_mstatus>
80000434:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000438:	fdf44783          	lbu	a5,-33(s0)
8000043c:	00300713          	li	a4,3
80000440:	06e78063          	beq	a5,a4,800004a0 <s_mstatus_xpp+0x88>
80000444:	00300713          	li	a4,3
80000448:	08f74263          	blt	a4,a5,800004cc <s_mstatus_xpp+0xb4>
8000044c:	00078863          	beqz	a5,8000045c <s_mstatus_xpp+0x44>
80000450:	00100713          	li	a4,1
80000454:	02e78063          	beq	a5,a4,80000474 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= M_MPP_SET;
        break;
    default:
        break;
80000458:	0740006f          	j	800004cc <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
8000045c:	fec42703          	lw	a4,-20(s0)
80000460:	ffffe7b7          	lui	a5,0xffffe
80000464:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000468:	00f777b3          	and	a5,a4,a5
8000046c:	fef42623          	sw	a5,-20(s0)
        break;
80000470:	0600006f          	j	800004d0 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80000474:	fec42703          	lw	a4,-20(s0)
80000478:	ffffe7b7          	lui	a5,0xffffe
8000047c:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000480:	00f777b3          	and	a5,a4,a5
80000484:	fef42623          	sw	a5,-20(s0)
        x |= M_SPP_SET;
80000488:	fec42703          	lw	a4,-20(s0)
8000048c:	000017b7          	lui	a5,0x1
80000490:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
80000494:	00f767b3          	or	a5,a4,a5
80000498:	fef42623          	sw	a5,-20(s0)
        break;
8000049c:	0340006f          	j	800004d0 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800004a0:	fec42703          	lw	a4,-20(s0)
800004a4:	ffffe7b7          	lui	a5,0xffffe
800004a8:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800004ac:	00f777b3          	and	a5,a4,a5
800004b0:	fef42623          	sw	a5,-20(s0)
        x |= M_MPP_SET;
800004b4:	fec42703          	lw	a4,-20(s0)
800004b8:	000027b7          	lui	a5,0x2
800004bc:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
800004c0:	00f767b3          	or	a5,a4,a5
800004c4:	fef42623          	sw	a5,-20(s0)
        break;
800004c8:	0080006f          	j	800004d0 <s_mstatus_xpp+0xb8>
        break;
800004cc:	00000013          	nop
    }
    w_mstatus(x);
800004d0:	fec42503          	lw	a0,-20(s0)
800004d4:	f1dff0ef          	jal	ra,800003f0 <w_mstatus>
}
800004d8:	00000013          	nop
800004dc:	02c12083          	lw	ra,44(sp)
800004e0:	02812403          	lw	s0,40(sp)
800004e4:	03010113          	addi	sp,sp,48
800004e8:	00008067          	ret

800004ec <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
800004ec:	fe010113          	addi	sp,sp,-32
800004f0:	00812e23          	sw	s0,28(sp)
800004f4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
800004f8:	100027f3          	csrr	a5,sstatus
800004fc:	fef42623          	sw	a5,-20(s0)
    return x;
80000500:	fec42783          	lw	a5,-20(s0)
}
80000504:	00078513          	mv	a0,a5
80000508:	01c12403          	lw	s0,28(sp)
8000050c:	02010113          	addi	sp,sp,32
80000510:	00008067          	ret

80000514 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
80000514:	fe010113          	addi	sp,sp,-32
80000518:	00812e23          	sw	s0,28(sp)
8000051c:	02010413          	addi	s0,sp,32
80000520:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
80000524:	fec42783          	lw	a5,-20(s0)
80000528:	10079073          	csrw	sstatus,a5
}
8000052c:	00000013          	nop
80000530:	01c12403          	lw	s0,28(sp)
80000534:	02010113          	addi	sp,sp,32
80000538:	00008067          	ret

8000053c <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
8000053c:	fe010113          	addi	sp,sp,-32
80000540:	00812e23          	sw	s0,28(sp)
80000544:	02010413          	addi	s0,sp,32
80000548:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
8000054c:	fec42783          	lw	a5,-20(s0)
80000550:	34179073          	csrw	mepc,a5
}
80000554:	00000013          	nop
80000558:	01c12403          	lw	s0,28(sp)
8000055c:	02010113          	addi	sp,sp,32
80000560:	00008067          	ret

80000564 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80000564:	fe010113          	addi	sp,sp,-32
80000568:	00812e23          	sw	s0,28(sp)
8000056c:	02010413          	addi	s0,sp,32
80000570:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80000574:	fec42783          	lw	a5,-20(s0)
80000578:	10579073          	csrw	stvec,a5
}
8000057c:	00000013          	nop
80000580:	01c12403          	lw	s0,28(sp)
80000584:	02010113          	addi	sp,sp,32
80000588:	00008067          	ret

8000058c <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
8000058c:	fe010113          	addi	sp,sp,-32
80000590:	00812e23          	sw	s0,28(sp)
80000594:	02010413          	addi	s0,sp,32
80000598:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
8000059c:	fec42783          	lw	a5,-20(s0)
800005a0:	30379073          	csrw	mideleg,a5
}
800005a4:	00000013          	nop
800005a8:	01c12403          	lw	s0,28(sp)
800005ac:	02010113          	addi	sp,sp,32
800005b0:	00008067          	ret

800005b4 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
800005b4:	fe010113          	addi	sp,sp,-32
800005b8:	00812e23          	sw	s0,28(sp)
800005bc:	02010413          	addi	s0,sp,32
800005c0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
800005c4:	fec42783          	lw	a5,-20(s0)
800005c8:	30279073          	csrw	medeleg,a5
}
800005cc:	00000013          	nop
800005d0:	01c12403          	lw	s0,28(sp)
800005d4:	02010113          	addi	sp,sp,32
800005d8:	00008067          	ret

800005dc <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
800005dc:	fe010113          	addi	sp,sp,-32
800005e0:	00812e23          	sw	s0,28(sp)
800005e4:	02010413          	addi	s0,sp,32
800005e8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800005ec:	fec42783          	lw	a5,-20(s0)
800005f0:	18079073          	csrw	satp,a5
}
800005f4:	00000013          	nop
800005f8:	01c12403          	lw	s0,28(sp)
800005fc:	02010113          	addi	sp,sp,32
80000600:	00008067          	ret

80000604 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
80000604:	fd010113          	addi	sp,sp,-48
80000608:	02112623          	sw	ra,44(sp)
8000060c:	02812423          	sw	s0,40(sp)
80000610:	03010413          	addi	s0,sp,48
80000614:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
80000618:	ed5ff0ef          	jal	ra,800004ec <r_sstatus>
8000061c:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000620:	fdc42703          	lw	a4,-36(s0)
80000624:	ffd00793          	li	a5,-3
80000628:	06f70863          	beq	a4,a5,80000698 <s_sstatus_intr+0x94>
8000062c:	fdc42703          	lw	a4,-36(s0)
80000630:	ffd00793          	li	a5,-3
80000634:	06e7e863          	bltu	a5,a4,800006a4 <s_sstatus_intr+0xa0>
80000638:	fdc42703          	lw	a4,-36(s0)
8000063c:	fdf00793          	li	a5,-33
80000640:	02f70c63          	beq	a4,a5,80000678 <s_sstatus_intr+0x74>
80000644:	fdc42703          	lw	a4,-36(s0)
80000648:	fdf00793          	li	a5,-33
8000064c:	04e7ec63          	bltu	a5,a4,800006a4 <s_sstatus_intr+0xa0>
80000650:	fdc42703          	lw	a4,-36(s0)
80000654:	00200793          	li	a5,2
80000658:	02f70863          	beq	a4,a5,80000688 <s_sstatus_intr+0x84>
8000065c:	fdc42703          	lw	a4,-36(s0)
80000660:	02000793          	li	a5,32
80000664:	04f71063          	bne	a4,a5,800006a4 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
80000668:	fec42783          	lw	a5,-20(s0)
8000066c:	0207e793          	ori	a5,a5,32
80000670:	fef42623          	sw	a5,-20(s0)
        break;
80000674:	0340006f          	j	800006a8 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
80000678:	fec42783          	lw	a5,-20(s0)
8000067c:	fdf7f793          	andi	a5,a5,-33
80000680:	fef42623          	sw	a5,-20(s0)
        break;
80000684:	0240006f          	j	800006a8 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
80000688:	fec42783          	lw	a5,-20(s0)
8000068c:	0027e793          	ori	a5,a5,2
80000690:	fef42623          	sw	a5,-20(s0)
        break;
80000694:	0140006f          	j	800006a8 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
80000698:	fec42783          	lw	a5,-20(s0)
8000069c:	0027f793          	andi	a5,a5,2
800006a0:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
800006a4:	00000013          	nop
    }
    w_sstatus(x);
800006a8:	fec42503          	lw	a0,-20(s0)
800006ac:	e69ff0ef          	jal	ra,80000514 <w_sstatus>
}
800006b0:	00000013          	nop
800006b4:	02c12083          	lw	ra,44(sp)
800006b8:	02812403          	lw	s0,40(sp)
800006bc:	03010113          	addi	sp,sp,48
800006c0:	00008067          	ret

800006c4 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();     // 定义在main.c

void start(){
800006c4:	ff010113          	addi	sp,sp,-16
800006c8:	00112623          	sw	ra,12(sp)
800006cc:	00812423          	sw	s0,8(sp)
800006d0:	01010413          	addi	s0,sp,16
    uartinit();
800006d4:	07c000ef          	jal	ra,80000750 <uartinit>
    uartputs("Hello Los!\n");
800006d8:	8000c7b7          	lui	a5,0x8000c
800006dc:	00078513          	mv	a0,a5
800006e0:	164000ef          	jal	ra,80000844 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
800006e4:	00100513          	li	a0,1
800006e8:	d31ff0ef          	jal	ra,80000418 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
800006ec:	00000513          	li	a0,0
800006f0:	eedff0ef          	jal	ra,800005dc <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
800006f4:	000107b7          	lui	a5,0x10
800006f8:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
800006fc:	e91ff0ef          	jal	ra,8000058c <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80000700:	000107b7          	lui	a5,0x10
80000704:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000708:	eadff0ef          	jal	ra,800005b4 <w_medeleg>

    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
8000070c:	00200513          	li	a0,2
80000710:	ef5ff0ef          	jal	ra,80000604 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
80000714:	800007b7          	lui	a5,0x80000
80000718:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
8000071c:	00078513          	mv	a0,a5
80000720:	e45ff0ef          	jal	ra,80000564 <w_stvec>

    timerinit();                // 时钟定时器
80000724:	070020ef          	jal	ra,80002794 <timerinit>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
80000728:	800017b7          	lui	a5,0x80001
8000072c:	91078793          	addi	a5,a5,-1776 # 80000910 <memend+0xf8000910>
80000730:	00078513          	mv	a0,a5
80000734:	e09ff0ef          	jal	ra,8000053c <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
80000738:	30200073          	mret
8000073c:	00000013          	nop
80000740:	00c12083          	lw	ra,12(sp)
80000744:	00812403          	lw	s0,8(sp)
80000748:	01010113          	addi	sp,sp,16
8000074c:	00008067          	ret

80000750 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
80000750:	fe010113          	addi	sp,sp,-32
80000754:	00812e23          	sw	s0,28(sp)
80000758:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
8000075c:	100007b7          	lui	a5,0x10000
80000760:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000764:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
80000768:	100007b7          	lui	a5,0x10000
8000076c:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000770:	0007c783          	lbu	a5,0(a5)
80000774:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
80000778:	100007b7          	lui	a5,0x10000
8000077c:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000780:	fef44703          	lbu	a4,-17(s0)
80000784:	f8076713          	ori	a4,a4,-128
80000788:	0ff77713          	andi	a4,a4,255
8000078c:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
80000790:	100007b7          	lui	a5,0x10000
80000794:	00300713          	li	a4,3
80000798:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
8000079c:	100007b7          	lui	a5,0x10000
800007a0:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007a4:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
800007a8:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
800007ac:	100007b7          	lui	a5,0x10000
800007b0:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800007b4:	fef44703          	lbu	a4,-17(s0)
800007b8:	00376713          	ori	a4,a4,3
800007bc:	0ff77713          	andi	a4,a4,255
800007c0:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
800007c4:	100007b7          	lui	a5,0x10000
800007c8:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007cc:	0007c783          	lbu	a5,0(a5)
800007d0:	0ff7f713          	andi	a4,a5,255
800007d4:	100007b7          	lui	a5,0x10000
800007d8:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007dc:	00176713          	ori	a4,a4,1
800007e0:	0ff77713          	andi	a4,a4,255
800007e4:	00e78023          	sb	a4,0(a5)
}
800007e8:	00000013          	nop
800007ec:	01c12403          	lw	s0,28(sp)
800007f0:	02010113          	addi	sp,sp,32
800007f4:	00008067          	ret

800007f8 <uartputc>:

// 轮询处理数据
char uartputc(char c){
800007f8:	fe010113          	addi	sp,sp,-32
800007fc:	00812e23          	sw	s0,28(sp)
80000800:	02010413          	addi	s0,sp,32
80000804:	00050793          	mv	a5,a0
80000808:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
8000080c:	00000013          	nop
80000810:	100007b7          	lui	a5,0x10000
80000814:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000818:	0007c783          	lbu	a5,0(a5)
8000081c:	0ff7f793          	andi	a5,a5,255
80000820:	0207f793          	andi	a5,a5,32
80000824:	fe0786e3          	beqz	a5,80000810 <uartputc+0x18>
    return uart_write(UART_THR,c);
80000828:	10000737          	lui	a4,0x10000
8000082c:	fef44783          	lbu	a5,-17(s0)
80000830:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
80000834:	00078513          	mv	a0,a5
80000838:	01c12403          	lw	s0,28(sp)
8000083c:	02010113          	addi	sp,sp,32
80000840:	00008067          	ret

80000844 <uartputs>:

// 发送字符串
void uartputs(char* s){
80000844:	fe010113          	addi	sp,sp,-32
80000848:	00112e23          	sw	ra,28(sp)
8000084c:	00812c23          	sw	s0,24(sp)
80000850:	02010413          	addi	s0,sp,32
80000854:	fea42623          	sw	a0,-20(s0)
    while (*s)
80000858:	01c0006f          	j	80000874 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
8000085c:	fec42783          	lw	a5,-20(s0)
80000860:	00178713          	addi	a4,a5,1
80000864:	fee42623          	sw	a4,-20(s0)
80000868:	0007c783          	lbu	a5,0(a5)
8000086c:	00078513          	mv	a0,a5
80000870:	f89ff0ef          	jal	ra,800007f8 <uartputc>
    while (*s)
80000874:	fec42783          	lw	a5,-20(s0)
80000878:	0007c783          	lbu	a5,0(a5)
8000087c:	fe0790e3          	bnez	a5,8000085c <uartputs+0x18>
    }
    
}
80000880:	00000013          	nop
80000884:	00000013          	nop
80000888:	01c12083          	lw	ra,28(sp)
8000088c:	01812403          	lw	s0,24(sp)
80000890:	02010113          	addi	sp,sp,32
80000894:	00008067          	ret

80000898 <uartgetc>:

// 接收输入
int uartgetc(){
80000898:	ff010113          	addi	sp,sp,-16
8000089c:	00812623          	sw	s0,12(sp)
800008a0:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
800008a4:	100007b7          	lui	a5,0x10000
800008a8:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
800008ac:	0007c783          	lbu	a5,0(a5)
800008b0:	0ff7f793          	andi	a5,a5,255
800008b4:	0017f793          	andi	a5,a5,1
800008b8:	00078a63          	beqz	a5,800008cc <uartgetc+0x34>
        return uart_read(UART_RHR);
800008bc:	100007b7          	lui	a5,0x10000
800008c0:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
800008c4:	0ff7f793          	andi	a5,a5,255
800008c8:	0080006f          	j	800008d0 <uartgetc+0x38>
    }else{
        return -1;
800008cc:	fff00793          	li	a5,-1
    }
}
800008d0:	00078513          	mv	a0,a5
800008d4:	00c12403          	lw	s0,12(sp)
800008d8:	01010113          	addi	sp,sp,16
800008dc:	00008067          	ret

800008e0 <uartintr>:

// 键盘输入中断
char uartintr(){
800008e0:	ff010113          	addi	sp,sp,-16
800008e4:	00112623          	sw	ra,12(sp)
800008e8:	00812423          	sw	s0,8(sp)
800008ec:	01010413          	addi	s0,sp,16
    return uartgetc();
800008f0:	fa9ff0ef          	jal	ra,80000898 <uartgetc>
800008f4:	00050793          	mv	a5,a0
800008f8:	0ff7f793          	andi	a5,a5,255
800008fc:	00078513          	mv	a0,a5
80000900:	00c12083          	lw	ra,12(sp)
80000904:	00812403          	lw	s0,8(sp)
80000908:	01010113          	addi	sp,sp,16
8000090c:	00008067          	ret

80000910 <main>:
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

void main(){
80000910:	ff010113          	addi	sp,sp,-16
80000914:	00112623          	sw	ra,12(sp)
80000918:	00812423          	sw	s0,8(sp)
8000091c:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
80000920:	8000c7b7          	lui	a5,0x8000c
80000924:	00c78513          	addi	a0,a5,12 # 8000c00c <memend+0xf800c00c>
80000928:	065000ef          	jal	ra,8000118c <printf>

    minit();        // 物理内存管理
8000092c:	46d000ef          	jal	ra,80001598 <minit>
    plicinit();     // PLIC 中断处理
80000930:	6ed000ef          	jal	ra,8000181c <plicinit>
    
    kvminit();       // 启动虚拟内存
80000934:	3a0010ef          	jal	ra,80001cd4 <kvminit>

    printf("usertrap: %p\n",usertrap);
80000938:	800007b7          	lui	a5,0x80000
8000093c:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80000940:	8000c7b7          	lui	a5,0x8000c
80000944:	02078513          	addi	a0,a5,32 # 8000c020 <memend+0xf800c020>
80000948:	045000ef          	jal	ra,8000118c <printf>

    procinit();
8000094c:	5f8010ef          	jal	ra,80001f44 <procinit>

    userinit();
80000950:	798010ef          	jal	ra,800020e8 <userinit>
    asm volatile("ecall");
80000954:	00000073          	ecall

    printf("----------------------\n");
80000958:	8000c7b7          	lui	a5,0x8000c
8000095c:	03078513          	addi	a0,a5,48 # 8000c030 <memend+0xf800c030>
80000960:	02d000ef          	jal	ra,8000118c <printf>
    schedule();
80000964:	0ad010ef          	jal	ra,80002210 <schedule>
}
80000968:	00000013          	nop
8000096c:	00c12083          	lw	ra,12(sp)
80000970:	00812403          	lw	s0,8(sp)
80000974:	01010113          	addi	sp,sp,16
80000978:	00008067          	ret

8000097c <r_sstatus>:
    }
    w_mstatus(x);
}

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
8000097c:	fe010113          	addi	sp,sp,-32
80000980:	00812e23          	sw	s0,28(sp)
80000984:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000988:	100027f3          	csrr	a5,sstatus
8000098c:	fef42623          	sw	a5,-20(s0)
    return x;
80000990:	fec42783          	lw	a5,-20(s0)
}
80000994:	00078513          	mv	a0,a5
80000998:	01c12403          	lw	s0,28(sp)
8000099c:	02010113          	addi	sp,sp,32
800009a0:	00008067          	ret

800009a4 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
800009a4:	fe010113          	addi	sp,sp,-32
800009a8:	00812e23          	sw	s0,28(sp)
800009ac:	02010413          	addi	s0,sp,32
800009b0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
800009b4:	fec42783          	lw	a5,-20(s0)
800009b8:	10079073          	csrw	sstatus,a5
}
800009bc:	00000013          	nop
800009c0:	01c12403          	lw	s0,28(sp)
800009c4:	02010113          	addi	sp,sp,32
800009c8:	00008067          	ret

800009cc <s_sstatus_xpp>:
    }
    return x;
}
// 设置特权模式
#define S_SPP_SET (1<<8)
static inline void s_sstatus_xpp(uint8 m){
800009cc:	fd010113          	addi	sp,sp,-48
800009d0:	02112623          	sw	ra,44(sp)
800009d4:	02812423          	sw	s0,40(sp)
800009d8:	03010413          	addi	s0,sp,48
800009dc:	00050793          	mv	a5,a0
800009e0:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_sstatus();
800009e4:	f99ff0ef          	jal	ra,8000097c <r_sstatus>
800009e8:	fea42623          	sw	a0,-20(s0)
    switch (m)
800009ec:	fdf44783          	lbu	a5,-33(s0)
800009f0:	00078863          	beqz	a5,80000a00 <s_sstatus_xpp+0x34>
800009f4:	00100713          	li	a4,1
800009f8:	00e78c63          	beq	a5,a4,80000a10 <s_sstatus_xpp+0x44>
    case RISCV_S:
        x &= ~SPP_MASK;
        x |= S_SPP_SET;
        break;
    default:
        break;
800009fc:	0300006f          	j	80000a2c <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
80000a00:	fec42783          	lw	a5,-20(s0)
80000a04:	eff7f793          	andi	a5,a5,-257
80000a08:	fef42623          	sw	a5,-20(s0)
        break;
80000a0c:	0200006f          	j	80000a2c <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
80000a10:	fec42783          	lw	a5,-20(s0)
80000a14:	eff7f793          	andi	a5,a5,-257
80000a18:	fef42623          	sw	a5,-20(s0)
        x |= S_SPP_SET;
80000a1c:	fec42783          	lw	a5,-20(s0)
80000a20:	1007e793          	ori	a5,a5,256
80000a24:	fef42623          	sw	a5,-20(s0)
        break;
80000a28:	00000013          	nop
    }
    w_sstatus(x);
80000a2c:	fec42503          	lw	a0,-20(s0)
80000a30:	f75ff0ef          	jal	ra,800009a4 <w_sstatus>
}
80000a34:	00000013          	nop
80000a38:	02c12083          	lw	ra,44(sp)
80000a3c:	02812403          	lw	s0,40(sp)
80000a40:	03010113          	addi	sp,sp,48
80000a44:	00008067          	ret

80000a48 <r_sepc>:

/**
 * @description: 读取 sepc 寄存器
 * S-mode 返回时跳转到 pc = sepc指向的地址
 */
static inline uint32 r_sepc(){
80000a48:	fe010113          	addi	sp,sp,-32
80000a4c:	00812e23          	sw	s0,28(sp)
80000a50:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sepc" : "=r" (x) );
80000a54:	141027f3          	csrr	a5,sepc
80000a58:	fef42623          	sw	a5,-20(s0)
    return x;
80000a5c:	fec42783          	lw	a5,-20(s0)
}
80000a60:	00078513          	mv	a0,a5
80000a64:	01c12403          	lw	s0,28(sp)
80000a68:	02010113          	addi	sp,sp,32
80000a6c:	00008067          	ret

80000a70 <w_sepc>:
// 写 sepc寄存器
static inline void w_sepc(uint32 x){
80000a70:	fe010113          	addi	sp,sp,-32
80000a74:	00812e23          	sw	s0,28(sp)
80000a78:	02010413          	addi	s0,sp,32
80000a7c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
80000a80:	fec42783          	lw	a5,-20(s0)
80000a84:	14179073          	csrw	sepc,a5
}
80000a88:	00000013          	nop
80000a8c:	01c12403          	lw	s0,28(sp)
80000a90:	02010113          	addi	sp,sp,32
80000a94:	00008067          	ret

80000a98 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80000a98:	fe010113          	addi	sp,sp,-32
80000a9c:	00812e23          	sw	s0,28(sp)
80000aa0:	02010413          	addi	s0,sp,32
80000aa4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80000aa8:	fec42783          	lw	a5,-20(s0)
80000aac:	10579073          	csrw	stvec,a5
}
80000ab0:	00000013          	nop
80000ab4:	01c12403          	lw	s0,28(sp)
80000ab8:	02010113          	addi	sp,sp,32
80000abc:	00008067          	ret

80000ac0 <r_satp>:
 * mode = 地址转换方案 0=bare 1=SV32
 * asid = 地址空间标识
 * ppn  = 根页表物理页码(物理地址/4Kb)
 */
#define SATP_SV32 (1<<31)    
static inline uint32 r_satp(){
80000ac0:	fe010113          	addi	sp,sp,-32
80000ac4:	00812e23          	sw	s0,28(sp)
80000ac8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
80000acc:	180027f3          	csrr	a5,satp
80000ad0:	fef42623          	sw	a5,-20(s0)
    return x;
80000ad4:	fec42783          	lw	a5,-20(s0)
}
80000ad8:	00078513          	mv	a0,a5
80000adc:	01c12403          	lw	s0,28(sp)
80000ae0:	02010113          	addi	sp,sp,32
80000ae4:	00008067          	ret

80000ae8 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
80000ae8:	fe010113          	addi	sp,sp,-32
80000aec:	00812e23          	sw	s0,28(sp)
80000af0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
80000af4:	142027f3          	csrr	a5,scause
80000af8:	fef42623          	sw	a5,-20(s0)
    return x;
80000afc:	fec42783          	lw	a5,-20(s0)
}
80000b00:	00078513          	mv	a0,a5
80000b04:	01c12403          	lw	s0,28(sp)
80000b08:	02010113          	addi	sp,sp,32
80000b0c:	00008067          	ret

80000b10 <r_sip>:

/**
 * @description: 
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip(){
80000b10:	fe010113          	addi	sp,sp,-32
80000b14:	00812e23          	sw	s0,28(sp)
80000b18:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip":"=r"(x));
80000b1c:	144027f3          	csrr	a5,sip
80000b20:	fef42623          	sw	a5,-20(s0)
    return x;
80000b24:	fec42783          	lw	a5,-20(s0)
}
80000b28:	00078513          	mv	a0,a5
80000b2c:	01c12403          	lw	s0,28(sp)
80000b30:	02010113          	addi	sp,sp,32
80000b34:	00008067          	ret

80000b38 <w_sip>:
static inline void w_sip(uint32 x){
80000b38:	fe010113          	addi	sp,sp,-32
80000b3c:	00812e23          	sw	s0,28(sp)
80000b40:	02010413          	addi	s0,sp,32
80000b44:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"::"r"(x));
80000b48:	fec42783          	lw	a5,-20(s0)
80000b4c:	14479073          	csrw	sip,a5
}
80000b50:	00000013          	nop
80000b54:	01c12403          	lw	s0,28(sp)
80000b58:	02010113          	addi	sp,sp,32
80000b5c:	00008067          	ret

80000b60 <externinterrupt>:
#include "vm.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
80000b60:	fe010113          	addi	sp,sp,-32
80000b64:	00112e23          	sw	ra,28(sp)
80000b68:	00812c23          	sw	s0,24(sp)
80000b6c:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000b70:	571000ef          	jal	ra,800018e0 <r_plicclaim>
80000b74:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000b78:	fec42583          	lw	a1,-20(s0)
80000b7c:	8000c7b7          	lui	a5,0x8000c
80000b80:	04878513          	addi	a0,a5,72 # 8000c048 <memend+0xf800c048>
80000b84:	608000ef          	jal	ra,8000118c <printf>
    switch (irq)
80000b88:	fec42703          	lw	a4,-20(s0)
80000b8c:	00a00793          	li	a5,10
80000b90:	02f71063          	bne	a4,a5,80000bb0 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80000b94:	d4dff0ef          	jal	ra,800008e0 <uartintr>
80000b98:	00050793          	mv	a5,a0
80000b9c:	00078593          	mv	a1,a5
80000ba0:	8000c7b7          	lui	a5,0x8000c
80000ba4:	05478513          	addi	a0,a5,84 # 8000c054 <memend+0xf800c054>
80000ba8:	5e4000ef          	jal	ra,8000118c <printf>
        break;
80000bac:	0080006f          	j	80000bb4 <externinterrupt+0x54>
    default:
        break;
80000bb0:	00000013          	nop
    }
    w_pliccomplete(irq);
80000bb4:	fec42503          	lw	a0,-20(s0)
80000bb8:	569000ef          	jal	ra,80001920 <w_pliccomplete>
}
80000bbc:	00000013          	nop
80000bc0:	01c12083          	lw	ra,28(sp)
80000bc4:	01812403          	lw	s0,24(sp)
80000bc8:	02010113          	addi	sp,sp,32
80000bcc:	00008067          	ret

80000bd0 <ptf>:

void ptf(struct trapframe *tf){
80000bd0:	fe010113          	addi	sp,sp,-32
80000bd4:	00112e23          	sw	ra,28(sp)
80000bd8:	00812c23          	sw	s0,24(sp)
80000bdc:	02010413          	addi	s0,sp,32
80000be0:	fea42623          	sw	a0,-20(s0)
    printf("kernel_sp: %d \n",tf->kernel_sp);
80000be4:	fec42783          	lw	a5,-20(s0)
80000be8:	0087a783          	lw	a5,8(a5)
80000bec:	00078593          	mv	a1,a5
80000bf0:	8000c7b7          	lui	a5,0x8000c
80000bf4:	06478513          	addi	a0,a5,100 # 8000c064 <memend+0xf800c064>
80000bf8:	594000ef          	jal	ra,8000118c <printf>
    printf("kernel_satp: %d \n",tf->kernel_satp);
80000bfc:	fec42783          	lw	a5,-20(s0)
80000c00:	0007a783          	lw	a5,0(a5)
80000c04:	00078593          	mv	a1,a5
80000c08:	8000c7b7          	lui	a5,0x8000c
80000c0c:	07478513          	addi	a0,a5,116 # 8000c074 <memend+0xf800c074>
80000c10:	57c000ef          	jal	ra,8000118c <printf>
    printf("kernel_tvec: %d \n",tf->kernel_tvec);
80000c14:	fec42783          	lw	a5,-20(s0)
80000c18:	0047a783          	lw	a5,4(a5)
80000c1c:	00078593          	mv	a1,a5
80000c20:	8000c7b7          	lui	a5,0x8000c
80000c24:	08878513          	addi	a0,a5,136 # 8000c088 <memend+0xf800c088>
80000c28:	564000ef          	jal	ra,8000118c <printf>

    printf("ra: %d \n",tf->ra);
80000c2c:	fec42783          	lw	a5,-20(s0)
80000c30:	0107a783          	lw	a5,16(a5)
80000c34:	00078593          	mv	a1,a5
80000c38:	8000c7b7          	lui	a5,0x8000c
80000c3c:	09c78513          	addi	a0,a5,156 # 8000c09c <memend+0xf800c09c>
80000c40:	54c000ef          	jal	ra,8000118c <printf>
    printf("sp: %d \n",tf->sp);
80000c44:	fec42783          	lw	a5,-20(s0)
80000c48:	0147a783          	lw	a5,20(a5)
80000c4c:	00078593          	mv	a1,a5
80000c50:	8000c7b7          	lui	a5,0x8000c
80000c54:	0a878513          	addi	a0,a5,168 # 8000c0a8 <memend+0xf800c0a8>
80000c58:	534000ef          	jal	ra,8000118c <printf>
    printf("tp: %d \n",tf->tp);
80000c5c:	fec42783          	lw	a5,-20(s0)
80000c60:	01c7a783          	lw	a5,28(a5)
80000c64:	00078593          	mv	a1,a5
80000c68:	8000c7b7          	lui	a5,0x8000c
80000c6c:	0b478513          	addi	a0,a5,180 # 8000c0b4 <memend+0xf800c0b4>
80000c70:	51c000ef          	jal	ra,8000118c <printf>
    printf("t0: %d \n",tf->t0);
80000c74:	fec42783          	lw	a5,-20(s0)
80000c78:	0707a783          	lw	a5,112(a5)
80000c7c:	00078593          	mv	a1,a5
80000c80:	8000c7b7          	lui	a5,0x8000c
80000c84:	0c078513          	addi	a0,a5,192 # 8000c0c0 <memend+0xf800c0c0>
80000c88:	504000ef          	jal	ra,8000118c <printf>
    printf("t1: %d \n",tf->t1);
80000c8c:	fec42783          	lw	a5,-20(s0)
80000c90:	0747a783          	lw	a5,116(a5)
80000c94:	00078593          	mv	a1,a5
80000c98:	8000c7b7          	lui	a5,0x8000c
80000c9c:	0cc78513          	addi	a0,a5,204 # 8000c0cc <memend+0xf800c0cc>
80000ca0:	4ec000ef          	jal	ra,8000118c <printf>
    printf("t2: %d \n",tf->t2);
80000ca4:	fec42783          	lw	a5,-20(s0)
80000ca8:	0787a783          	lw	a5,120(a5)
80000cac:	00078593          	mv	a1,a5
80000cb0:	8000c7b7          	lui	a5,0x8000c
80000cb4:	0d878513          	addi	a0,a5,216 # 8000c0d8 <memend+0xf800c0d8>
80000cb8:	4d4000ef          	jal	ra,8000118c <printf>
    printf("t3: %d \n",tf->t3);
80000cbc:	fec42783          	lw	a5,-20(s0)
80000cc0:	07c7a783          	lw	a5,124(a5)
80000cc4:	00078593          	mv	a1,a5
80000cc8:	8000c7b7          	lui	a5,0x8000c
80000ccc:	0e478513          	addi	a0,a5,228 # 8000c0e4 <memend+0xf800c0e4>
80000cd0:	4bc000ef          	jal	ra,8000118c <printf>
    printf("t4: %d \n",tf->t4);
80000cd4:	fec42783          	lw	a5,-20(s0)
80000cd8:	0807a783          	lw	a5,128(a5)
80000cdc:	00078593          	mv	a1,a5
80000ce0:	8000c7b7          	lui	a5,0x8000c
80000ce4:	0f078513          	addi	a0,a5,240 # 8000c0f0 <memend+0xf800c0f0>
80000ce8:	4a4000ef          	jal	ra,8000118c <printf>
    printf("t5: %d \n",tf->t5);
80000cec:	fec42783          	lw	a5,-20(s0)
80000cf0:	0847a783          	lw	a5,132(a5)
80000cf4:	00078593          	mv	a1,a5
80000cf8:	8000c7b7          	lui	a5,0x8000c
80000cfc:	0fc78513          	addi	a0,a5,252 # 8000c0fc <memend+0xf800c0fc>
80000d00:	48c000ef          	jal	ra,8000118c <printf>
    printf("t6: %d \n",tf->t6);
80000d04:	fec42783          	lw	a5,-20(s0)
80000d08:	0887a783          	lw	a5,136(a5)
80000d0c:	00078593          	mv	a1,a5
80000d10:	8000c7b7          	lui	a5,0x8000c
80000d14:	10878513          	addi	a0,a5,264 # 8000c108 <memend+0xf800c108>
80000d18:	474000ef          	jal	ra,8000118c <printf>
    printf("a0: %d \n",tf->a0);
80000d1c:	fec42783          	lw	a5,-20(s0)
80000d20:	0207a783          	lw	a5,32(a5)
80000d24:	00078593          	mv	a1,a5
80000d28:	8000c7b7          	lui	a5,0x8000c
80000d2c:	11478513          	addi	a0,a5,276 # 8000c114 <memend+0xf800c114>
80000d30:	45c000ef          	jal	ra,8000118c <printf>
    printf("a1: %d \n",tf->a1);
80000d34:	fec42783          	lw	a5,-20(s0)
80000d38:	0247a783          	lw	a5,36(a5)
80000d3c:	00078593          	mv	a1,a5
80000d40:	8000c7b7          	lui	a5,0x8000c
80000d44:	12078513          	addi	a0,a5,288 # 8000c120 <memend+0xf800c120>
80000d48:	444000ef          	jal	ra,8000118c <printf>
    printf("a2: %d \n",tf->a2);
80000d4c:	fec42783          	lw	a5,-20(s0)
80000d50:	0287a783          	lw	a5,40(a5)
80000d54:	00078593          	mv	a1,a5
80000d58:	8000c7b7          	lui	a5,0x8000c
80000d5c:	12c78513          	addi	a0,a5,300 # 8000c12c <memend+0xf800c12c>
80000d60:	42c000ef          	jal	ra,8000118c <printf>
    printf("a3: %d \n",tf->a3);
80000d64:	fec42783          	lw	a5,-20(s0)
80000d68:	02c7a783          	lw	a5,44(a5)
80000d6c:	00078593          	mv	a1,a5
80000d70:	8000c7b7          	lui	a5,0x8000c
80000d74:	13878513          	addi	a0,a5,312 # 8000c138 <memend+0xf800c138>
80000d78:	414000ef          	jal	ra,8000118c <printf>
    printf("a4: %d \n",tf->a4);
80000d7c:	fec42783          	lw	a5,-20(s0)
80000d80:	0307a783          	lw	a5,48(a5)
80000d84:	00078593          	mv	a1,a5
80000d88:	8000c7b7          	lui	a5,0x8000c
80000d8c:	14478513          	addi	a0,a5,324 # 8000c144 <memend+0xf800c144>
80000d90:	3fc000ef          	jal	ra,8000118c <printf>
    printf("a5: %d \n",tf->a5);
80000d94:	fec42783          	lw	a5,-20(s0)
80000d98:	0347a783          	lw	a5,52(a5)
80000d9c:	00078593          	mv	a1,a5
80000da0:	8000c7b7          	lui	a5,0x8000c
80000da4:	15078513          	addi	a0,a5,336 # 8000c150 <memend+0xf800c150>
80000da8:	3e4000ef          	jal	ra,8000118c <printf>
    printf("a6: %d \n",tf->a6);
80000dac:	fec42783          	lw	a5,-20(s0)
80000db0:	0387a783          	lw	a5,56(a5)
80000db4:	00078593          	mv	a1,a5
80000db8:	8000c7b7          	lui	a5,0x8000c
80000dbc:	15c78513          	addi	a0,a5,348 # 8000c15c <memend+0xf800c15c>
80000dc0:	3cc000ef          	jal	ra,8000118c <printf>
    printf("a7: %d \n",tf->a7);
80000dc4:	fec42783          	lw	a5,-20(s0)
80000dc8:	03c7a783          	lw	a5,60(a5)
80000dcc:	00078593          	mv	a1,a5
80000dd0:	8000c7b7          	lui	a5,0x8000c
80000dd4:	16878513          	addi	a0,a5,360 # 8000c168 <memend+0xf800c168>
80000dd8:	3b4000ef          	jal	ra,8000118c <printf>
}
80000ddc:	00000013          	nop
80000de0:	01c12083          	lw	ra,28(sp)
80000de4:	01812403          	lw	s0,24(sp)
80000de8:	02010113          	addi	sp,sp,32
80000dec:	00008067          	ret

80000df0 <usertrapret>:

// 返回用户空间
void usertrapret(){
80000df0:	fe010113          	addi	sp,sp,-32
80000df4:	00112e23          	sw	ra,28(sp)
80000df8:	00812c23          	sw	s0,24(sp)
80000dfc:	00912a23          	sw	s1,20(sp)
80000e00:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80000e04:	1c0010ef          	jal	ra,80001fc4 <nowproc>
80000e08:	fea42623          	sw	a0,-20(s0)
    s_sstatus_xpp(RISCV_U);
80000e0c:	00000513          	li	a0,0
80000e10:	bbdff0ef          	jal	ra,800009cc <s_sstatus_xpp>
    w_stvec((uint32)usertrap);
80000e14:	800007b7          	lui	a5,0x80000
80000e18:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80000e1c:	00078513          	mv	a0,a5
80000e20:	c79ff0ef          	jal	ra,80000a98 <w_stvec>
    addr_t satp=(SATP_SV32|(addr_t)(p->pagetable)>>12);
80000e24:	fec42783          	lw	a5,-20(s0)
80000e28:	0887a783          	lw	a5,136(a5)
80000e2c:	00c7d713          	srli	a4,a5,0xc
80000e30:	800007b7          	lui	a5,0x80000
80000e34:	00f767b3          	or	a5,a4,a5
80000e38:	fef42423          	sw	a5,-24(s0)
    ptf(p->trapframe);
80000e3c:	fec42783          	lw	a5,-20(s0)
80000e40:	0087a783          	lw	a5,8(a5) # 80000008 <memend+0xf8000008>
80000e44:	00078513          	mv	a0,a5
80000e48:	d89ff0ef          	jal	ra,80000bd0 <ptf>
    printf("%p\n",p->trapframe);
80000e4c:	fec42783          	lw	a5,-20(s0)
80000e50:	0087a783          	lw	a5,8(a5)
80000e54:	00078593          	mv	a1,a5
80000e58:	8000c7b7          	lui	a5,0x8000c
80000e5c:	17478513          	addi	a0,a5,372 # 8000c174 <memend+0xf800c174>
80000e60:	32c000ef          	jal	ra,8000118c <printf>
    w_sepc((addr_t)p->trapframe->epc);
80000e64:	fec42783          	lw	a5,-20(s0)
80000e68:	0087a783          	lw	a5,8(a5)
80000e6c:	00c7a783          	lw	a5,12(a5)
80000e70:	00078513          	mv	a0,a5
80000e74:	bfdff0ef          	jal	ra,80000a70 <w_sepc>
    p->trapframe->kernel_satp=r_satp();
80000e78:	fec42783          	lw	a5,-20(s0)
80000e7c:	0087a483          	lw	s1,8(a5)
80000e80:	c41ff0ef          	jal	ra,80000ac0 <r_satp>
80000e84:	00050793          	mv	a5,a0
80000e88:	00f4a023          	sw	a5,0(s1)
    p->trapframe->kernel_tvec=(addr_t)trapvec;
80000e8c:	fec42783          	lw	a5,-20(s0)
80000e90:	0087a783          	lw	a5,8(a5)
80000e94:	80001737          	lui	a4,0x80001
80000e98:	f7470713          	addi	a4,a4,-140 # 80000f74 <memend+0xf8000f74>
80000e9c:	00e7a223          	sw	a4,4(a5)
    p->trapframe->kernel_sp=(addr_t)p->kernelstack;
80000ea0:	fec42783          	lw	a5,-20(s0)
80000ea4:	0087a783          	lw	a5,8(a5)
80000ea8:	fec42703          	lw	a4,-20(s0)
80000eac:	08c72703          	lw	a4,140(a4)
80000eb0:	00e7a423          	sw	a4,8(a5)
    printf("%p\n",p->kernelstack);
80000eb4:	fec42783          	lw	a5,-20(s0)
80000eb8:	08c7a783          	lw	a5,140(a5)
80000ebc:	00078593          	mv	a1,a5
80000ec0:	8000c7b7          	lui	a5,0x8000c
80000ec4:	17478513          	addi	a0,a5,372 # 8000c174 <memend+0xf800c174>
80000ec8:	2c4000ef          	jal	ra,8000118c <printf>
    userret((addr_t*)TRAPFRAME,satp);
80000ecc:	fe842583          	lw	a1,-24(s0)
80000ed0:	ffffe537          	lui	a0,0xffffe
80000ed4:	c60ff0ef          	jal	ra,80000334 <userret>
}
80000ed8:	00000013          	nop
80000edc:	01c12083          	lw	ra,28(sp)
80000ee0:	01812403          	lw	s0,24(sp)
80000ee4:	01412483          	lw	s1,20(sp)
80000ee8:	02010113          	addi	sp,sp,32
80000eec:	00008067          	ret

80000ef0 <zero>:

void zero(){
80000ef0:	fe010113          	addi	sp,sp,-32
80000ef4:	00112e23          	sw	ra,28(sp)
80000ef8:	00812c23          	sw	s0,24(sp)
80000efc:	02010413          	addi	s0,sp,32
    printf("zero\n");
80000f00:	8000c7b7          	lui	a5,0x8000c
80000f04:	17878513          	addi	a0,a5,376 # 8000c178 <memend+0xf800c178>
80000f08:	284000ef          	jal	ra,8000118c <printf>
    reg_t pc=r_sepc();
80000f0c:	b3dff0ef          	jal	ra,80000a48 <r_sepc>
80000f10:	fea42623          	sw	a0,-20(s0)
    w_sepc(pc+4);
80000f14:	fec42783          	lw	a5,-20(s0)
80000f18:	00478793          	addi	a5,a5,4
80000f1c:	00078513          	mv	a0,a5
80000f20:	b51ff0ef          	jal	ra,80000a70 <w_sepc>
    usertrapret();
80000f24:	ecdff0ef          	jal	ra,80000df0 <usertrapret>
}
80000f28:	00000013          	nop
80000f2c:	01c12083          	lw	ra,28(sp)
80000f30:	01812403          	lw	s0,24(sp)
80000f34:	02010113          	addi	sp,sp,32
80000f38:	00008067          	ret

80000f3c <timerintr>:

void timerintr(){
80000f3c:	ff010113          	addi	sp,sp,-16
80000f40:	00112623          	sw	ra,12(sp)
80000f44:	00812423          	sw	s0,8(sp)
80000f48:	01010413          	addi	s0,sp,16
    w_sip(r_sip()& ~2); // 清除中断
80000f4c:	bc5ff0ef          	jal	ra,80000b10 <r_sip>
80000f50:	00050793          	mv	a5,a0
80000f54:	ffd7f793          	andi	a5,a5,-3
80000f58:	00078513          	mv	a0,a5
80000f5c:	bddff0ef          	jal	ra,80000b38 <w_sip>
    // printf("timer interrupt\n");
}
80000f60:	00000013          	nop
80000f64:	00c12083          	lw	ra,12(sp)
80000f68:	00812403          	lw	s0,8(sp)
80000f6c:	01010113          	addi	sp,sp,16
80000f70:	00008067          	ret

80000f74 <trapvec>:

void trapvec(){
80000f74:	fe010113          	addi	sp,sp,-32
80000f78:	00112e23          	sw	ra,28(sp)
80000f7c:	00812c23          	sw	s0,24(sp)
80000f80:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000f84:	b65ff0ef          	jal	ra,80000ae8 <r_scause>
80000f88:	fea42423          	sw	a0,-24(s0)

    uint16 code= scause & 0xffff;
80000f8c:	fe842783          	lw	a5,-24(s0)
80000f90:	fef41323          	sh	a5,-26(s0)

    if(scause & (1<<31)){
80000f94:	fe842783          	lw	a5,-24(s0)
80000f98:	0607d463          	bgez	a5,80001000 <trapvec+0x8c>
    //     printf("Interrupt : ");
        switch (code)
80000f9c:	fe645783          	lhu	a5,-26(s0)
80000fa0:	00900713          	li	a4,9
80000fa4:	02e78c63          	beq	a5,a4,80000fdc <trapvec+0x68>
80000fa8:	00900713          	li	a4,9
80000fac:	04f74263          	blt	a4,a5,80000ff0 <trapvec+0x7c>
80000fb0:	00100713          	li	a4,1
80000fb4:	00e78863          	beq	a5,a4,80000fc4 <trapvec+0x50>
80000fb8:	00500713          	li	a4,5
80000fbc:	00e78863          	beq	a5,a4,80000fcc <trapvec+0x58>
80000fc0:	0300006f          	j	80000ff0 <trapvec+0x7c>
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
80000fc4:	f79ff0ef          	jal	ra,80000f3c <timerintr>
            break;
80000fc8:	1780006f          	j	80001140 <trapvec+0x1cc>
        case 5:
            printf("Supervisor timer interrupt\n");
80000fcc:	8000c7b7          	lui	a5,0x8000c
80000fd0:	18078513          	addi	a0,a5,384 # 8000c180 <memend+0xf800c180>
80000fd4:	1b8000ef          	jal	ra,8000118c <printf>
            break;
80000fd8:	1680006f          	j	80001140 <trapvec+0x1cc>
        case 9:
            printf("Supervisor external interrupt\n");
80000fdc:	8000c7b7          	lui	a5,0x8000c
80000fe0:	19c78513          	addi	a0,a5,412 # 8000c19c <memend+0xf800c19c>
80000fe4:	1a8000ef          	jal	ra,8000118c <printf>
            externinterrupt();
80000fe8:	b79ff0ef          	jal	ra,80000b60 <externinterrupt>
            break;
80000fec:	1540006f          	j	80001140 <trapvec+0x1cc>
        default:
            printf("Other interrupt\n");
80000ff0:	8000c7b7          	lui	a5,0x8000c
80000ff4:	1bc78513          	addi	a0,a5,444 # 8000c1bc <memend+0xf800c1bc>
80000ff8:	194000ef          	jal	ra,8000118c <printf>
            break;
80000ffc:	1440006f          	j	80001140 <trapvec+0x1cc>
        }
    }else{
        int ecall=0;
80001000:	fe042623          	sw	zero,-20(s0)
        printf("Exception : ");
80001004:	8000c7b7          	lui	a5,0x8000c
80001008:	1d078513          	addi	a0,a5,464 # 8000c1d0 <memend+0xf800c1d0>
8000100c:	180000ef          	jal	ra,8000118c <printf>
        switch (code)
80001010:	fe645783          	lhu	a5,-26(s0)
80001014:	00f00713          	li	a4,15
80001018:	0ef76c63          	bltu	a4,a5,80001110 <trapvec+0x19c>
8000101c:	00279713          	slli	a4,a5,0x2
80001020:	8000c7b7          	lui	a5,0x8000c
80001024:	34478793          	addi	a5,a5,836 # 8000c344 <memend+0xf800c344>
80001028:	00f707b3          	add	a5,a4,a5
8000102c:	0007a783          	lw	a5,0(a5)
80001030:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80001034:	8000c7b7          	lui	a5,0x8000c
80001038:	1e078513          	addi	a0,a5,480 # 8000c1e0 <memend+0xf800c1e0>
8000103c:	150000ef          	jal	ra,8000118c <printf>
            break;
80001040:	0e00006f          	j	80001120 <trapvec+0x1ac>
        case 1:
            printf("Instruction access fault\n");
80001044:	8000c7b7          	lui	a5,0x8000c
80001048:	20078513          	addi	a0,a5,512 # 8000c200 <memend+0xf800c200>
8000104c:	140000ef          	jal	ra,8000118c <printf>
            break;
80001050:	0d00006f          	j	80001120 <trapvec+0x1ac>
        case 2:
            printf("Illegal instruction\n");
80001054:	8000c7b7          	lui	a5,0x8000c
80001058:	21c78513          	addi	a0,a5,540 # 8000c21c <memend+0xf800c21c>
8000105c:	130000ef          	jal	ra,8000118c <printf>
            break;
80001060:	0c00006f          	j	80001120 <trapvec+0x1ac>
        case 3:
            printf("Breakpoint\n");
80001064:	8000c7b7          	lui	a5,0x8000c
80001068:	23478513          	addi	a0,a5,564 # 8000c234 <memend+0xf800c234>
8000106c:	120000ef          	jal	ra,8000118c <printf>
            break;
80001070:	0b00006f          	j	80001120 <trapvec+0x1ac>
        case 4:
            printf("Load address misaligned\n");
80001074:	8000c7b7          	lui	a5,0x8000c
80001078:	24078513          	addi	a0,a5,576 # 8000c240 <memend+0xf800c240>
8000107c:	110000ef          	jal	ra,8000118c <printf>
            break;
80001080:	0a00006f          	j	80001120 <trapvec+0x1ac>
        case 5:
            printf("Load access fault\n");
80001084:	8000c7b7          	lui	a5,0x8000c
80001088:	25c78513          	addi	a0,a5,604 # 8000c25c <memend+0xf800c25c>
8000108c:	100000ef          	jal	ra,8000118c <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80001090:	0900006f          	j	80001120 <trapvec+0x1ac>
        case 6:
            printf("Store/AMO address misaligned\n");
80001094:	8000c7b7          	lui	a5,0x8000c
80001098:	27078513          	addi	a0,a5,624 # 8000c270 <memend+0xf800c270>
8000109c:	0f0000ef          	jal	ra,8000118c <printf>
            break;
800010a0:	0800006f          	j	80001120 <trapvec+0x1ac>
        case 7:
            printf("Store/AMO access fault\n");
800010a4:	8000c7b7          	lui	a5,0x8000c
800010a8:	29078513          	addi	a0,a5,656 # 8000c290 <memend+0xf800c290>
800010ac:	0e0000ef          	jal	ra,8000118c <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
800010b0:	0700006f          	j	80001120 <trapvec+0x1ac>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
800010b4:	8000c7b7          	lui	a5,0x8000c
800010b8:	2a878513          	addi	a0,a5,680 # 8000c2a8 <memend+0xf800c2a8>
800010bc:	0d0000ef          	jal	ra,8000118c <printf>
            break;
800010c0:	0600006f          	j	80001120 <trapvec+0x1ac>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
800010c4:	8000c7b7          	lui	a5,0x8000c
800010c8:	2c878513          	addi	a0,a5,712 # 8000c2c8 <memend+0xf800c2c8>
800010cc:	0c0000ef          	jal	ra,8000118c <printf>
            zero();
800010d0:	e21ff0ef          	jal	ra,80000ef0 <zero>
            ecall=1;
800010d4:	00100793          	li	a5,1
800010d8:	fef42623          	sw	a5,-20(s0)
            break;
800010dc:	0440006f          	j	80001120 <trapvec+0x1ac>
        case 12:
            printf("Instruction page fault\n");
800010e0:	8000c7b7          	lui	a5,0x8000c
800010e4:	2e878513          	addi	a0,a5,744 # 8000c2e8 <memend+0xf800c2e8>
800010e8:	0a4000ef          	jal	ra,8000118c <printf>
            break;
800010ec:	0340006f          	j	80001120 <trapvec+0x1ac>
        case 13:
            printf("Load page fault\n");
800010f0:	8000c7b7          	lui	a5,0x8000c
800010f4:	30078513          	addi	a0,a5,768 # 8000c300 <memend+0xf800c300>
800010f8:	094000ef          	jal	ra,8000118c <printf>
            break;
800010fc:	0240006f          	j	80001120 <trapvec+0x1ac>
        case 15:
            printf("Store/AMO page fault\n");
80001100:	8000c7b7          	lui	a5,0x8000c
80001104:	31478513          	addi	a0,a5,788 # 8000c314 <memend+0xf800c314>
80001108:	084000ef          	jal	ra,8000118c <printf>
            break;
8000110c:	0140006f          	j	80001120 <trapvec+0x1ac>
        default:
            printf("Other\n");
80001110:	8000c7b7          	lui	a5,0x8000c
80001114:	32c78513          	addi	a0,a5,812 # 8000c32c <memend+0xf800c32c>
80001118:	074000ef          	jal	ra,8000118c <printf>
            break;
8000111c:	00000013          	nop
        }
        if(!ecall){
80001120:	fec42783          	lw	a5,-20(s0)
80001124:	00079e63          	bnez	a5,80001140 <trapvec+0x1cc>
            panic("Trap Exception");
80001128:	8000c7b7          	lui	a5,0x8000c
8000112c:	33478513          	addi	a0,a5,820 # 8000c334 <memend+0xf800c334>
80001130:	024000ef          	jal	ra,80001154 <panic>
            ecall=1;
80001134:	00100793          	li	a5,1
80001138:	fef42623          	sw	a5,-20(s0)
        }
    }
}
8000113c:	0040006f          	j	80001140 <trapvec+0x1cc>
80001140:	00000013          	nop
80001144:	01c12083          	lw	ra,28(sp)
80001148:	01812403          	lw	s0,24(sp)
8000114c:	02010113          	addi	sp,sp,32
80001150:	00008067          	ret

80001154 <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80001154:	fe010113          	addi	sp,sp,-32
80001158:	00112e23          	sw	ra,28(sp)
8000115c:	00812c23          	sw	s0,24(sp)
80001160:	02010413          	addi	s0,sp,32
80001164:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80001168:	8000c7b7          	lui	a5,0x8000c
8000116c:	38478513          	addi	a0,a5,900 # 8000c384 <memend+0xf800c384>
80001170:	ed4ff0ef          	jal	ra,80000844 <uartputs>
    uartputs(s);
80001174:	fec42503          	lw	a0,-20(s0)
80001178:	eccff0ef          	jal	ra,80000844 <uartputs>
	uartputs("\n");
8000117c:	8000c7b7          	lui	a5,0x8000c
80001180:	38c78513          	addi	a0,a5,908 # 8000c38c <memend+0xf800c38c>
80001184:	ec0ff0ef          	jal	ra,80000844 <uartputs>
    while(1);
80001188:	0000006f          	j	80001188 <panic+0x34>

8000118c <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
8000118c:	f8010113          	addi	sp,sp,-128
80001190:	04112e23          	sw	ra,92(sp)
80001194:	04812c23          	sw	s0,88(sp)
80001198:	06010413          	addi	s0,sp,96
8000119c:	faa42623          	sw	a0,-84(s0)
800011a0:	00b42223          	sw	a1,4(s0)
800011a4:	00c42423          	sw	a2,8(s0)
800011a8:	00d42623          	sw	a3,12(s0)
800011ac:	00e42823          	sw	a4,16(s0)
800011b0:	00f42a23          	sw	a5,20(s0)
800011b4:	01042c23          	sw	a6,24(s0)
800011b8:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
800011bc:	02040793          	addi	a5,s0,32
800011c0:	faf42423          	sw	a5,-88(s0)
800011c4:	fa842783          	lw	a5,-88(s0)
800011c8:	fe478793          	addi	a5,a5,-28
800011cc:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
800011d0:	fac42783          	lw	a5,-84(s0)
800011d4:	fef42623          	sw	a5,-20(s0)
	int tt=0;
800011d8:	fe042423          	sw	zero,-24(s0)
	int idx=0;
800011dc:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
800011e0:	36c0006f          	j	8000154c <printf+0x3c0>
		if(ch=='%'){
800011e4:	fbf44703          	lbu	a4,-65(s0)
800011e8:	02500793          	li	a5,37
800011ec:	04f71863          	bne	a4,a5,8000123c <printf+0xb0>
			if(tt==1){
800011f0:	fe842703          	lw	a4,-24(s0)
800011f4:	00100793          	li	a5,1
800011f8:	02f71663          	bne	a4,a5,80001224 <printf+0x98>
				outbuf[idx++]='%';
800011fc:	fe442783          	lw	a5,-28(s0)
80001200:	00178713          	addi	a4,a5,1
80001204:	fee42223          	sw	a4,-28(s0)
80001208:	8000d737          	lui	a4,0x8000d
8000120c:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001210:	00f707b3          	add	a5,a4,a5
80001214:	02500713          	li	a4,37
80001218:	00e78023          	sb	a4,0(a5)
				tt=0;
8000121c:	fe042423          	sw	zero,-24(s0)
80001220:	00c0006f          	j	8000122c <printf+0xa0>
			}else{
				tt=1;
80001224:	00100793          	li	a5,1
80001228:	fef42423          	sw	a5,-24(s0)
			}
			s++;
8000122c:	fec42783          	lw	a5,-20(s0)
80001230:	00178793          	addi	a5,a5,1
80001234:	fef42623          	sw	a5,-20(s0)
80001238:	3140006f          	j	8000154c <printf+0x3c0>
		}else{
			if(tt==1){
8000123c:	fe842703          	lw	a4,-24(s0)
80001240:	00100793          	li	a5,1
80001244:	2cf71e63          	bne	a4,a5,80001520 <printf+0x394>
				switch (ch)
80001248:	fbf44783          	lbu	a5,-65(s0)
8000124c:	fa878793          	addi	a5,a5,-88
80001250:	02000713          	li	a4,32
80001254:	2af76663          	bltu	a4,a5,80001500 <printf+0x374>
80001258:	00279713          	slli	a4,a5,0x2
8000125c:	8000c7b7          	lui	a5,0x8000c
80001260:	3a878793          	addi	a5,a5,936 # 8000c3a8 <memend+0xf800c3a8>
80001264:	00f707b3          	add	a5,a4,a5
80001268:	0007a783          	lw	a5,0(a5)
8000126c:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80001270:	fb842783          	lw	a5,-72(s0)
80001274:	00478713          	addi	a4,a5,4
80001278:	fae42c23          	sw	a4,-72(s0)
8000127c:	0007a783          	lw	a5,0(a5)
80001280:	fef42023          	sw	a5,-32(s0)
					int len=0;
80001284:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80001288:	fe042783          	lw	a5,-32(s0)
8000128c:	fcf42c23          	sw	a5,-40(s0)
80001290:	0100006f          	j	800012a0 <printf+0x114>
80001294:	fdc42783          	lw	a5,-36(s0)
80001298:	00178793          	addi	a5,a5,1
8000129c:	fcf42e23          	sw	a5,-36(s0)
800012a0:	fd842703          	lw	a4,-40(s0)
800012a4:	00a00793          	li	a5,10
800012a8:	02f747b3          	div	a5,a4,a5
800012ac:	fcf42c23          	sw	a5,-40(s0)
800012b0:	fd842783          	lw	a5,-40(s0)
800012b4:	fe0790e3          	bnez	a5,80001294 <printf+0x108>
					for(int i=len;i>=0;i--){
800012b8:	fdc42783          	lw	a5,-36(s0)
800012bc:	fcf42a23          	sw	a5,-44(s0)
800012c0:	0540006f          	j	80001314 <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
800012c4:	fe042703          	lw	a4,-32(s0)
800012c8:	00a00793          	li	a5,10
800012cc:	02f767b3          	rem	a5,a4,a5
800012d0:	0ff7f713          	andi	a4,a5,255
800012d4:	fe442683          	lw	a3,-28(s0)
800012d8:	fd442783          	lw	a5,-44(s0)
800012dc:	00f687b3          	add	a5,a3,a5
800012e0:	03070713          	addi	a4,a4,48
800012e4:	0ff77713          	andi	a4,a4,255
800012e8:	8000d6b7          	lui	a3,0x8000d
800012ec:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
800012f0:	00f687b3          	add	a5,a3,a5
800012f4:	00e78023          	sb	a4,0(a5)
						x/=10;
800012f8:	fe042703          	lw	a4,-32(s0)
800012fc:	00a00793          	li	a5,10
80001300:	02f747b3          	div	a5,a4,a5
80001304:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80001308:	fd442783          	lw	a5,-44(s0)
8000130c:	fff78793          	addi	a5,a5,-1
80001310:	fcf42a23          	sw	a5,-44(s0)
80001314:	fd442783          	lw	a5,-44(s0)
80001318:	fa07d6e3          	bgez	a5,800012c4 <printf+0x138>
					}
					idx+=(len+1);
8000131c:	fdc42783          	lw	a5,-36(s0)
80001320:	00178793          	addi	a5,a5,1
80001324:	fe442703          	lw	a4,-28(s0)
80001328:	00f707b3          	add	a5,a4,a5
8000132c:	fef42223          	sw	a5,-28(s0)
					tt=0;
80001330:	fe042423          	sw	zero,-24(s0)
					break;
80001334:	1dc0006f          	j	80001510 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80001338:	fe442783          	lw	a5,-28(s0)
8000133c:	00178713          	addi	a4,a5,1
80001340:	fee42223          	sw	a4,-28(s0)
80001344:	8000d737          	lui	a4,0x8000d
80001348:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
8000134c:	00f707b3          	add	a5,a4,a5
80001350:	03000713          	li	a4,48
80001354:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80001358:	fe442783          	lw	a5,-28(s0)
8000135c:	00178713          	addi	a4,a5,1
80001360:	fee42223          	sw	a4,-28(s0)
80001364:	8000d737          	lui	a4,0x8000d
80001368:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
8000136c:	00f707b3          	add	a5,a4,a5
80001370:	07800713          	li	a4,120
80001374:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80001378:	fb842783          	lw	a5,-72(s0)
8000137c:	00478713          	addi	a4,a5,4
80001380:	fae42c23          	sw	a4,-72(s0)
80001384:	0007a783          	lw	a5,0(a5)
80001388:	fcf42823          	sw	a5,-48(s0)
					int len=0;
8000138c:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80001390:	fd042783          	lw	a5,-48(s0)
80001394:	fcf42423          	sw	a5,-56(s0)
80001398:	0100006f          	j	800013a8 <printf+0x21c>
8000139c:	fcc42783          	lw	a5,-52(s0)
800013a0:	00178793          	addi	a5,a5,1
800013a4:	fcf42623          	sw	a5,-52(s0)
800013a8:	fc842783          	lw	a5,-56(s0)
800013ac:	0047d793          	srli	a5,a5,0x4
800013b0:	fcf42423          	sw	a5,-56(s0)
800013b4:	fc842783          	lw	a5,-56(s0)
800013b8:	fe0792e3          	bnez	a5,8000139c <printf+0x210>
					for(int i=len;i>=0;i--){
800013bc:	fcc42783          	lw	a5,-52(s0)
800013c0:	fcf42223          	sw	a5,-60(s0)
800013c4:	0840006f          	j	80001448 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
800013c8:	fd042783          	lw	a5,-48(s0)
800013cc:	00f7f713          	andi	a4,a5,15
800013d0:	00900793          	li	a5,9
800013d4:	02e7f063          	bgeu	a5,a4,800013f4 <printf+0x268>
800013d8:	fd042783          	lw	a5,-48(s0)
800013dc:	0ff7f793          	andi	a5,a5,255
800013e0:	00f7f793          	andi	a5,a5,15
800013e4:	0ff7f793          	andi	a5,a5,255
800013e8:	05778793          	addi	a5,a5,87
800013ec:	0ff7f793          	andi	a5,a5,255
800013f0:	01c0006f          	j	8000140c <printf+0x280>
800013f4:	fd042783          	lw	a5,-48(s0)
800013f8:	0ff7f793          	andi	a5,a5,255
800013fc:	00f7f793          	andi	a5,a5,15
80001400:	0ff7f793          	andi	a5,a5,255
80001404:	03078793          	addi	a5,a5,48
80001408:	0ff7f793          	andi	a5,a5,255
8000140c:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80001410:	fe442703          	lw	a4,-28(s0)
80001414:	fc442783          	lw	a5,-60(s0)
80001418:	00f707b3          	add	a5,a4,a5
8000141c:	8000d737          	lui	a4,0x8000d
80001420:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001424:	00f707b3          	add	a5,a4,a5
80001428:	fbe44703          	lbu	a4,-66(s0)
8000142c:	00e78023          	sb	a4,0(a5)
						x/=16;
80001430:	fd042783          	lw	a5,-48(s0)
80001434:	0047d793          	srli	a5,a5,0x4
80001438:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
8000143c:	fc442783          	lw	a5,-60(s0)
80001440:	fff78793          	addi	a5,a5,-1
80001444:	fcf42223          	sw	a5,-60(s0)
80001448:	fc442783          	lw	a5,-60(s0)
8000144c:	f607dee3          	bgez	a5,800013c8 <printf+0x23c>
					}
					idx+=(len+1);
80001450:	fcc42783          	lw	a5,-52(s0)
80001454:	00178793          	addi	a5,a5,1
80001458:	fe442703          	lw	a4,-28(s0)
8000145c:	00f707b3          	add	a5,a4,a5
80001460:	fef42223          	sw	a5,-28(s0)
					tt=0;
80001464:	fe042423          	sw	zero,-24(s0)
					break;
80001468:	0a80006f          	j	80001510 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
8000146c:	fb842783          	lw	a5,-72(s0)
80001470:	00478713          	addi	a4,a5,4
80001474:	fae42c23          	sw	a4,-72(s0)
80001478:	0007a783          	lw	a5,0(a5)
8000147c:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80001480:	fe442783          	lw	a5,-28(s0)
80001484:	00178713          	addi	a4,a5,1
80001488:	fee42223          	sw	a4,-28(s0)
8000148c:	8000d737          	lui	a4,0x8000d
80001490:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001494:	00f707b3          	add	a5,a4,a5
80001498:	fbf44703          	lbu	a4,-65(s0)
8000149c:	00e78023          	sb	a4,0(a5)
					tt=0;
800014a0:	fe042423          	sw	zero,-24(s0)
					break;
800014a4:	06c0006f          	j	80001510 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
800014a8:	fb842783          	lw	a5,-72(s0)
800014ac:	00478713          	addi	a4,a5,4
800014b0:	fae42c23          	sw	a4,-72(s0)
800014b4:	0007a783          	lw	a5,0(a5)
800014b8:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
800014bc:	0300006f          	j	800014ec <printf+0x360>
						outbuf[idx++]=*ss++;
800014c0:	fc042703          	lw	a4,-64(s0)
800014c4:	00170793          	addi	a5,a4,1
800014c8:	fcf42023          	sw	a5,-64(s0)
800014cc:	fe442783          	lw	a5,-28(s0)
800014d0:	00178693          	addi	a3,a5,1
800014d4:	fed42223          	sw	a3,-28(s0)
800014d8:	00074703          	lbu	a4,0(a4)
800014dc:	8000d6b7          	lui	a3,0x8000d
800014e0:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
800014e4:	00f687b3          	add	a5,a3,a5
800014e8:	00e78023          	sb	a4,0(a5)
					while(*ss){
800014ec:	fc042783          	lw	a5,-64(s0)
800014f0:	0007c783          	lbu	a5,0(a5)
800014f4:	fc0796e3          	bnez	a5,800014c0 <printf+0x334>
					}
					tt=0;
800014f8:	fe042423          	sw	zero,-24(s0)
					break;
800014fc:	0140006f          	j	80001510 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80001500:	8000c7b7          	lui	a5,0x8000c
80001504:	39078513          	addi	a0,a5,912 # 8000c390 <memend+0xf800c390>
80001508:	c4dff0ef          	jal	ra,80001154 <panic>
					break;
8000150c:	00000013          	nop
				}
				s++;
80001510:	fec42783          	lw	a5,-20(s0)
80001514:	00178793          	addi	a5,a5,1
80001518:	fef42623          	sw	a5,-20(s0)
8000151c:	0300006f          	j	8000154c <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80001520:	fe442783          	lw	a5,-28(s0)
80001524:	00178713          	addi	a4,a5,1
80001528:	fee42223          	sw	a4,-28(s0)
8000152c:	8000d737          	lui	a4,0x8000d
80001530:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001534:	00f707b3          	add	a5,a4,a5
80001538:	fbf44703          	lbu	a4,-65(s0)
8000153c:	00e78023          	sb	a4,0(a5)
				s++;
80001540:	fec42783          	lw	a5,-20(s0)
80001544:	00178793          	addi	a5,a5,1
80001548:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
8000154c:	fec42783          	lw	a5,-20(s0)
80001550:	0007c783          	lbu	a5,0(a5)
80001554:	faf40fa3          	sb	a5,-65(s0)
80001558:	fbf44783          	lbu	a5,-65(s0)
8000155c:	c80794e3          	bnez	a5,800011e4 <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80001560:	8000d7b7          	lui	a5,0x8000d
80001564:	00478713          	addi	a4,a5,4 # 8000d004 <memend+0xf800d004>
80001568:	fe442783          	lw	a5,-28(s0)
8000156c:	00f707b3          	add	a5,a4,a5
80001570:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
80001574:	8000d7b7          	lui	a5,0x8000d
80001578:	00478513          	addi	a0,a5,4 # 8000d004 <memend+0xf800d004>
8000157c:	ac8ff0ef          	jal	ra,80000844 <uartputs>
	return idx;
80001580:	fe442783          	lw	a5,-28(s0)
80001584:	00078513          	mv	a0,a5
80001588:	05c12083          	lw	ra,92(sp)
8000158c:	05812403          	lw	s0,88(sp)
80001590:	08010113          	addi	sp,sp,128
80001594:	00008067          	ret

80001598 <minit>:
struct
{
    struct pmp* freelist;
}mem;
#define _DEBUG
void minit(){
80001598:	fe010113          	addi	sp,sp,-32
8000159c:	00112e23          	sw	ra,28(sp)
800015a0:	00812c23          	sw	s0,24(sp)
800015a4:	02010413          	addi	s0,sp,32
    #ifdef _DEBUG
        printf("textstart:%p    ",textstart);
800015a8:	800007b7          	lui	a5,0x80000
800015ac:	00078593          	mv	a1,a5
800015b0:	8000c7b7          	lui	a5,0x8000c
800015b4:	42c78513          	addi	a0,a5,1068 # 8000c42c <memend+0xf800c42c>
800015b8:	bd5ff0ef          	jal	ra,8000118c <printf>
        printf("textend:%p\n",textend);
800015bc:	800037b7          	lui	a5,0x80003
800015c0:	8b478593          	addi	a1,a5,-1868 # 800028b4 <memend+0xf80028b4>
800015c4:	8000c7b7          	lui	a5,0x8000c
800015c8:	44078513          	addi	a0,a5,1088 # 8000c440 <memend+0xf800c440>
800015cc:	bc1ff0ef          	jal	ra,8000118c <printf>
        printf("datastart:%p    ",datastart);
800015d0:	800037b7          	lui	a5,0x80003
800015d4:	00078593          	mv	a1,a5
800015d8:	8000c7b7          	lui	a5,0x8000c
800015dc:	44c78513          	addi	a0,a5,1100 # 8000c44c <memend+0xf800c44c>
800015e0:	badff0ef          	jal	ra,8000118c <printf>
        printf("dataend:%p\n",dataend);
800015e4:	8000b7b7          	lui	a5,0x8000b
800015e8:	00878593          	addi	a1,a5,8 # 8000b008 <memend+0xf800b008>
800015ec:	8000c7b7          	lui	a5,0x8000c
800015f0:	46078513          	addi	a0,a5,1120 # 8000c460 <memend+0xf800c460>
800015f4:	b99ff0ef          	jal	ra,8000118c <printf>
        printf("rodatastart:%p  ",rodatastart);
800015f8:	8000c7b7          	lui	a5,0x8000c
800015fc:	00078593          	mv	a1,a5
80001600:	8000c7b7          	lui	a5,0x8000c
80001604:	46c78513          	addi	a0,a5,1132 # 8000c46c <memend+0xf800c46c>
80001608:	b85ff0ef          	jal	ra,8000118c <printf>
        printf("rodataend:%p\n",rodataend);
8000160c:	8000c7b7          	lui	a5,0x8000c
80001610:	51378593          	addi	a1,a5,1299 # 8000c513 <memend+0xf800c513>
80001614:	8000c7b7          	lui	a5,0x8000c
80001618:	48078513          	addi	a0,a5,1152 # 8000c480 <memend+0xf800c480>
8000161c:	b71ff0ef          	jal	ra,8000118c <printf>
        printf("bssstart:%p     ",bssstart);
80001620:	8000d7b7          	lui	a5,0x8000d
80001624:	00078593          	mv	a1,a5
80001628:	8000c7b7          	lui	a5,0x8000c
8000162c:	49078513          	addi	a0,a5,1168 # 8000c490 <memend+0xf800c490>
80001630:	b5dff0ef          	jal	ra,8000118c <printf>
        printf("bssend:%p\n",bssend);
80001634:	8000e7b7          	lui	a5,0x8000e
80001638:	9f078593          	addi	a1,a5,-1552 # 8000d9f0 <memend+0xf800d9f0>
8000163c:	8000c7b7          	lui	a5,0x8000c
80001640:	4a478513          	addi	a0,a5,1188 # 8000c4a4 <memend+0xf800c4a4>
80001644:	b49ff0ef          	jal	ra,8000118c <printf>
        printf("mstart:%p   ",mstart);
80001648:	8000e7b7          	lui	a5,0x8000e
8000164c:	00078593          	mv	a1,a5
80001650:	8000c7b7          	lui	a5,0x8000c
80001654:	4b078513          	addi	a0,a5,1200 # 8000c4b0 <memend+0xf800c4b0>
80001658:	b35ff0ef          	jal	ra,8000118c <printf>
        printf("mend:%p\n",mend);
8000165c:	880007b7          	lui	a5,0x88000
80001660:	00078593          	mv	a1,a5
80001664:	8000c7b7          	lui	a5,0x8000c
80001668:	4c078513          	addi	a0,a5,1216 # 8000c4c0 <memend+0xf800c4c0>
8000166c:	b21ff0ef          	jal	ra,8000118c <printf>
        printf("stack:%p\n",stacks);
80001670:	800037b7          	lui	a5,0x80003
80001674:	00878593          	addi	a1,a5,8 # 80003008 <memend+0xf8003008>
80001678:	8000c7b7          	lui	a5,0x8000c
8000167c:	4cc78513          	addi	a0,a5,1228 # 8000c4cc <memend+0xf800c4cc>
80001680:	b0dff0ef          	jal	ra,8000118c <printf>
    #endif

    char* p=(char*)mstart;
80001684:	8000e7b7          	lui	a5,0x8000e
80001688:	00078793          	mv	a5,a5
8000168c:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001690:	0380006f          	j	800016c8 <minit+0x130>
        m=(struct pmp*)p;
80001694:	fec42783          	lw	a5,-20(s0)
80001698:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
8000169c:	8000d7b7          	lui	a5,0x8000d
800016a0:	4447a703          	lw	a4,1092(a5) # 8000d444 <memend+0xf800d444>
800016a4:	fe842783          	lw	a5,-24(s0)
800016a8:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
800016ac:	8000d7b7          	lui	a5,0x8000d
800016b0:	fe842703          	lw	a4,-24(s0)
800016b4:	44e7a223          	sw	a4,1092(a5) # 8000d444 <memend+0xf800d444>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800016b8:	fec42703          	lw	a4,-20(s0)
800016bc:	000017b7          	lui	a5,0x1
800016c0:	00f707b3          	add	a5,a4,a5
800016c4:	fef42623          	sw	a5,-20(s0)
800016c8:	fec42703          	lw	a4,-20(s0)
800016cc:	000017b7          	lui	a5,0x1
800016d0:	00f70733          	add	a4,a4,a5
800016d4:	880007b7          	lui	a5,0x88000
800016d8:	00078793          	mv	a5,a5
800016dc:	fae7fce3          	bgeu	a5,a4,80001694 <minit+0xfc>
    }
}
800016e0:	00000013          	nop
800016e4:	00000013          	nop
800016e8:	01c12083          	lw	ra,28(sp)
800016ec:	01812403          	lw	s0,24(sp)
800016f0:	02010113          	addi	sp,sp,32
800016f4:	00008067          	ret

800016f8 <palloc>:

void* palloc(){
800016f8:	fe010113          	addi	sp,sp,-32
800016fc:	00112e23          	sw	ra,28(sp)
80001700:	00812c23          	sw	s0,24(sp)
80001704:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80001708:	8000d7b7          	lui	a5,0x8000d
8000170c:	4447a783          	lw	a5,1092(a5) # 8000d444 <memend+0xf800d444>
80001710:	fef42623          	sw	a5,-20(s0)
    if(p)
80001714:	fec42783          	lw	a5,-20(s0)
80001718:	00078c63          	beqz	a5,80001730 <palloc+0x38>
        mem.freelist=mem.freelist->next;
8000171c:	8000d7b7          	lui	a5,0x8000d
80001720:	4447a783          	lw	a5,1092(a5) # 8000d444 <memend+0xf800d444>
80001724:	0007a703          	lw	a4,0(a5)
80001728:	8000d7b7          	lui	a5,0x8000d
8000172c:	44e7a223          	sw	a4,1092(a5) # 8000d444 <memend+0xf800d444>
    if(p)
80001730:	fec42783          	lw	a5,-20(s0)
80001734:	00078a63          	beqz	a5,80001748 <palloc+0x50>
        memset(p,0,PGSIZE);
80001738:	00001637          	lui	a2,0x1
8000173c:	00000593          	li	a1,0
80001740:	fec42503          	lw	a0,-20(s0)
80001744:	309000ef          	jal	ra,8000224c <memset>
    return (void*)p;
80001748:	fec42783          	lw	a5,-20(s0)
}
8000174c:	00078513          	mv	a0,a5
80001750:	01c12083          	lw	ra,28(sp)
80001754:	01812403          	lw	s0,24(sp)
80001758:	02010113          	addi	sp,sp,32
8000175c:	00008067          	ret

80001760 <pfree>:

void pfree(void* addr){
80001760:	fd010113          	addi	sp,sp,-48
80001764:	02812623          	sw	s0,44(sp)
80001768:	03010413          	addi	s0,sp,48
8000176c:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80001770:	fdc42783          	lw	a5,-36(s0)
80001774:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
80001778:	8000d7b7          	lui	a5,0x8000d
8000177c:	4447a703          	lw	a4,1092(a5) # 8000d444 <memend+0xf800d444>
80001780:	fec42783          	lw	a5,-20(s0)
80001784:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
80001788:	8000d7b7          	lui	a5,0x8000d
8000178c:	fec42703          	lw	a4,-20(s0)
80001790:	44e7a223          	sw	a4,1092(a5) # 8000d444 <memend+0xf800d444>
80001794:	00000013          	nop
80001798:	02c12403          	lw	s0,44(sp)
8000179c:	03010113          	addi	sp,sp,48
800017a0:	00008067          	ret

800017a4 <r_tp>:
static inline uint32 r_tp(){
800017a4:	fe010113          	addi	sp,sp,-32
800017a8:	00812e23          	sw	s0,28(sp)
800017ac:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800017b0:	00020793          	mv	a5,tp
800017b4:	fef42623          	sw	a5,-20(s0)
    return x;
800017b8:	fec42783          	lw	a5,-20(s0)
}
800017bc:	00078513          	mv	a0,a5
800017c0:	01c12403          	lw	s0,28(sp)
800017c4:	02010113          	addi	sp,sp,32
800017c8:	00008067          	ret

800017cc <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
800017cc:	fe010113          	addi	sp,sp,-32
800017d0:	00812e23          	sw	s0,28(sp)
800017d4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
800017d8:	104027f3          	csrr	a5,sie
800017dc:	fef42623          	sw	a5,-20(s0)
    return x;
800017e0:	fec42783          	lw	a5,-20(s0)
}
800017e4:	00078513          	mv	a0,a5
800017e8:	01c12403          	lw	s0,28(sp)
800017ec:	02010113          	addi	sp,sp,32
800017f0:	00008067          	ret

800017f4 <w_sie>:
static inline void w_sie(uint32 x){
800017f4:	fe010113          	addi	sp,sp,-32
800017f8:	00812e23          	sw	s0,28(sp)
800017fc:	02010413          	addi	s0,sp,32
80001800:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80001804:	fec42783          	lw	a5,-20(s0)
80001808:	10479073          	csrw	sie,a5
}
8000180c:	00000013          	nop
80001810:	01c12403          	lw	s0,28(sp)
80001814:	02010113          	addi	sp,sp,32
80001818:	00008067          	ret

8000181c <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
8000181c:	ff010113          	addi	sp,sp,-16
80001820:	00112623          	sw	ra,12(sp)
80001824:	00812423          	sw	s0,8(sp)
80001828:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
8000182c:	0c0007b7          	lui	a5,0xc000
80001830:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001834:	00100713          	li	a4,1
80001838:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
8000183c:	f69ff0ef          	jal	ra,800017a4 <r_tp>
80001840:	00050793          	mv	a5,a0
80001844:	00879713          	slli	a4,a5,0x8
80001848:	0c0027b7          	lui	a5,0xc002
8000184c:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001850:	00f707b3          	add	a5,a4,a5
80001854:	00078713          	mv	a4,a5
80001858:	40000793          	li	a5,1024
8000185c:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001860:	f45ff0ef          	jal	ra,800017a4 <r_tp>
80001864:	00050713          	mv	a4,a0
80001868:	000c07b7          	lui	a5,0xc0
8000186c:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
80001870:	00f707b3          	add	a5,a4,a5
80001874:	00879793          	slli	a5,a5,0x8
80001878:	00078713          	mv	a4,a5
8000187c:	40000793          	li	a5,1024
80001880:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
80001884:	f21ff0ef          	jal	ra,800017a4 <r_tp>
80001888:	00050713          	mv	a4,a0
8000188c:	000067b7          	lui	a5,0x6
80001890:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
80001894:	00f707b3          	add	a5,a4,a5
80001898:	00d79793          	slli	a5,a5,0xd
8000189c:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800018a0:	f05ff0ef          	jal	ra,800017a4 <r_tp>
800018a4:	00050793          	mv	a5,a0
800018a8:	00d79713          	slli	a4,a5,0xd
800018ac:	0c2017b7          	lui	a5,0xc201
800018b0:	00f707b3          	add	a5,a4,a5
800018b4:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800018b8:	f15ff0ef          	jal	ra,800017cc <r_sie>
800018bc:	00050793          	mv	a5,a0
800018c0:	2227e793          	ori	a5,a5,546
800018c4:	00078513          	mv	a0,a5
800018c8:	f2dff0ef          	jal	ra,800017f4 <w_sie>
}
800018cc:	00000013          	nop
800018d0:	00c12083          	lw	ra,12(sp)
800018d4:	00812403          	lw	s0,8(sp)
800018d8:	01010113          	addi	sp,sp,16
800018dc:	00008067          	ret

800018e0 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
800018e0:	ff010113          	addi	sp,sp,-16
800018e4:	00112623          	sw	ra,12(sp)
800018e8:	00812423          	sw	s0,8(sp)
800018ec:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
800018f0:	eb5ff0ef          	jal	ra,800017a4 <r_tp>
800018f4:	00050793          	mv	a5,a0
800018f8:	00d79713          	slli	a4,a5,0xd
800018fc:	0c2017b7          	lui	a5,0xc201
80001900:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001904:	00f707b3          	add	a5,a4,a5
80001908:	0007a783          	lw	a5,0(a5)
}
8000190c:	00078513          	mv	a0,a5
80001910:	00c12083          	lw	ra,12(sp)
80001914:	00812403          	lw	s0,8(sp)
80001918:	01010113          	addi	sp,sp,16
8000191c:	00008067          	ret

80001920 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001920:	fe010113          	addi	sp,sp,-32
80001924:	00112e23          	sw	ra,28(sp)
80001928:	00812c23          	sw	s0,24(sp)
8000192c:	02010413          	addi	s0,sp,32
80001930:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80001934:	e71ff0ef          	jal	ra,800017a4 <r_tp>
80001938:	00050793          	mv	a5,a0
8000193c:	00d79713          	slli	a4,a5,0xd
80001940:	0c2007b7          	lui	a5,0xc200
80001944:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
80001948:	00f707b3          	add	a5,a4,a5
8000194c:	00078713          	mv	a4,a5
80001950:	fec42783          	lw	a5,-20(s0)
80001954:	00f72023          	sw	a5,0(a4)
80001958:	00000013          	nop
8000195c:	01c12083          	lw	ra,28(sp)
80001960:	01812403          	lw	s0,24(sp)
80001964:	02010113          	addi	sp,sp,32
80001968:	00008067          	ret

8000196c <w_satp>:
static inline void w_satp(uint32 x){
8000196c:	fe010113          	addi	sp,sp,-32
80001970:	00812e23          	sw	s0,28(sp)
80001974:	02010413          	addi	s0,sp,32
80001978:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
8000197c:	fec42783          	lw	a5,-20(s0)
80001980:	18079073          	csrw	satp,a5
}
80001984:	00000013          	nop
80001988:	01c12403          	lw	s0,28(sp)
8000198c:	02010113          	addi	sp,sp,32
80001990:	00008067          	ret

80001994 <sfence_vma>:
static inline void sfence_vma(){
80001994:	ff010113          	addi	sp,sp,-16
80001998:	00812623          	sw	s0,12(sp)
8000199c:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800019a0:	12000073          	sfence.vma
}
800019a4:	00000013          	nop
800019a8:	00c12403          	lw	s0,12(sp)
800019ac:	01010113          	addi	sp,sp,16
800019b0:	00008067          	ret

800019b4 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
800019b4:	fd010113          	addi	sp,sp,-48
800019b8:	02112623          	sw	ra,44(sp)
800019bc:	02812423          	sw	s0,40(sp)
800019c0:	03010413          	addi	s0,sp,48
800019c4:	fca42e23          	sw	a0,-36(s0)
800019c8:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
800019cc:	fd842783          	lw	a5,-40(s0)
800019d0:	0167d793          	srli	a5,a5,0x16
800019d4:	00279793          	slli	a5,a5,0x2
800019d8:	fdc42703          	lw	a4,-36(s0)
800019dc:	00f707b3          	add	a5,a4,a5
800019e0:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
800019e4:	fec42783          	lw	a5,-20(s0)
800019e8:	0007a783          	lw	a5,0(a5)
800019ec:	0017f793          	andi	a5,a5,1
800019f0:	00078e63          	beqz	a5,80001a0c <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
800019f4:	fec42783          	lw	a5,-20(s0)
800019f8:	0007a783          	lw	a5,0(a5)
800019fc:	00a7d793          	srli	a5,a5,0xa
80001a00:	00c79793          	slli	a5,a5,0xc
80001a04:	fcf42e23          	sw	a5,-36(s0)
80001a08:	0340006f          	j	80001a3c <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
80001a0c:	cedff0ef          	jal	ra,800016f8 <palloc>
80001a10:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001a14:	00001637          	lui	a2,0x1
80001a18:	00000593          	li	a1,0
80001a1c:	fdc42503          	lw	a0,-36(s0)
80001a20:	02d000ef          	jal	ra,8000224c <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001a24:	fdc42783          	lw	a5,-36(s0)
80001a28:	00c7d793          	srli	a5,a5,0xc
80001a2c:	00a79793          	slli	a5,a5,0xa
80001a30:	0017e713          	ori	a4,a5,1
80001a34:	fec42783          	lw	a5,-20(s0)
80001a38:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001a3c:	fd842783          	lw	a5,-40(s0)
80001a40:	00c7d793          	srli	a5,a5,0xc
80001a44:	3ff7f793          	andi	a5,a5,1023
80001a48:	00279793          	slli	a5,a5,0x2
80001a4c:	fdc42703          	lw	a4,-36(s0)
80001a50:	00f707b3          	add	a5,a4,a5
}
80001a54:	00078513          	mv	a0,a5
80001a58:	02c12083          	lw	ra,44(sp)
80001a5c:	02812403          	lw	s0,40(sp)
80001a60:	03010113          	addi	sp,sp,48
80001a64:	00008067          	ret

80001a68 <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
80001a68:	fc010113          	addi	sp,sp,-64
80001a6c:	02112e23          	sw	ra,60(sp)
80001a70:	02812c23          	sw	s0,56(sp)
80001a74:	04010413          	addi	s0,sp,64
80001a78:	fca42e23          	sw	a0,-36(s0)
80001a7c:	fcb42c23          	sw	a1,-40(s0)
80001a80:	fcc42a23          	sw	a2,-44(s0)
80001a84:	fcd42823          	sw	a3,-48(s0)
80001a88:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
80001a8c:	fd842703          	lw	a4,-40(s0)
80001a90:	fffff7b7          	lui	a5,0xfffff
80001a94:	00f777b3          	and	a5,a4,a5
80001a98:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
80001a9c:	fd042703          	lw	a4,-48(s0)
80001aa0:	fd842783          	lw	a5,-40(s0)
80001aa4:	00f707b3          	add	a5,a4,a5
80001aa8:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
80001aac:	fffff7b7          	lui	a5,0xfffff
80001ab0:	00f777b3          	and	a5,a4,a5
80001ab4:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
80001ab8:	fec42583          	lw	a1,-20(s0)
80001abc:	fdc42503          	lw	a0,-36(s0)
80001ac0:	ef5ff0ef          	jal	ra,800019b4 <acquriepte>
80001ac4:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
80001ac8:	fe442783          	lw	a5,-28(s0)
80001acc:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001ad0:	0017f793          	andi	a5,a5,1
80001ad4:	00078863          	beqz	a5,80001ae4 <vmmap+0x7c>
            panic("repeat map");
80001ad8:	8000c7b7          	lui	a5,0x8000c
80001adc:	4d878513          	addi	a0,a5,1240 # 8000c4d8 <memend+0xf800c4d8>
80001ae0:	e74ff0ef          	jal	ra,80001154 <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001ae4:	fd442783          	lw	a5,-44(s0)
80001ae8:	00c7d793          	srli	a5,a5,0xc
80001aec:	00a79713          	slli	a4,a5,0xa
80001af0:	fcc42783          	lw	a5,-52(s0)
80001af4:	00f767b3          	or	a5,a4,a5
80001af8:	0017e713          	ori	a4,a5,1
80001afc:	fe442783          	lw	a5,-28(s0)
80001b00:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001b04:	fec42703          	lw	a4,-20(s0)
80001b08:	fe842783          	lw	a5,-24(s0)
80001b0c:	02f70463          	beq	a4,a5,80001b34 <vmmap+0xcc>
        start += PGSIZE;
80001b10:	fec42703          	lw	a4,-20(s0)
80001b14:	000017b7          	lui	a5,0x1
80001b18:	00f707b3          	add	a5,a4,a5
80001b1c:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001b20:	fd442703          	lw	a4,-44(s0)
80001b24:	000017b7          	lui	a5,0x1
80001b28:	00f707b3          	add	a5,a4,a5
80001b2c:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001b30:	f89ff06f          	j	80001ab8 <vmmap+0x50>
        if(start==end)  break;
80001b34:	00000013          	nop
    }
}
80001b38:	00000013          	nop
80001b3c:	03c12083          	lw	ra,60(sp)
80001b40:	03812403          	lw	s0,56(sp)
80001b44:	04010113          	addi	sp,sp,64
80001b48:	00008067          	ret

80001b4c <printpgt>:

void printpgt(addr_t* pgt){
80001b4c:	fc010113          	addi	sp,sp,-64
80001b50:	02112e23          	sw	ra,60(sp)
80001b54:	02812c23          	sw	s0,56(sp)
80001b58:	04010413          	addi	s0,sp,64
80001b5c:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
80001b60:	fe042623          	sw	zero,-20(s0)
80001b64:	0c40006f          	j	80001c28 <printpgt+0xdc>
        pte_t pte=pgt[i];
80001b68:	fec42783          	lw	a5,-20(s0)
80001b6c:	00279793          	slli	a5,a5,0x2
80001b70:	fcc42703          	lw	a4,-52(s0)
80001b74:	00f707b3          	add	a5,a4,a5
80001b78:	0007a783          	lw	a5,0(a5) # 1000 <sz>
80001b7c:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
80001b80:	fe442783          	lw	a5,-28(s0)
80001b84:	0017f793          	andi	a5,a5,1
80001b88:	08078a63          	beqz	a5,80001c1c <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
80001b8c:	fe442783          	lw	a5,-28(s0)
80001b90:	00a7d793          	srli	a5,a5,0xa
80001b94:	00c79793          	slli	a5,a5,0xc
80001b98:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
80001b9c:	fe042683          	lw	a3,-32(s0)
80001ba0:	fe442603          	lw	a2,-28(s0)
80001ba4:	fec42583          	lw	a1,-20(s0)
80001ba8:	8000c7b7          	lui	a5,0x8000c
80001bac:	4e478513          	addi	a0,a5,1252 # 8000c4e4 <memend+0xf800c4e4>
80001bb0:	ddcff0ef          	jal	ra,8000118c <printf>
            for(int j=0;j<1024;j++){
80001bb4:	fe042423          	sw	zero,-24(s0)
80001bb8:	0580006f          	j	80001c10 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001bbc:	fe842783          	lw	a5,-24(s0)
80001bc0:	00279793          	slli	a5,a5,0x2
80001bc4:	fe042703          	lw	a4,-32(s0)
80001bc8:	00f707b3          	add	a5,a4,a5
80001bcc:	0007a783          	lw	a5,0(a5)
80001bd0:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001bd4:	fdc42783          	lw	a5,-36(s0)
80001bd8:	0017f793          	andi	a5,a5,1
80001bdc:	02078463          	beqz	a5,80001c04 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001be0:	fdc42783          	lw	a5,-36(s0)
80001be4:	00a7d793          	srli	a5,a5,0xa
80001be8:	00c79793          	slli	a5,a5,0xc
80001bec:	00078693          	mv	a3,a5
80001bf0:	fdc42603          	lw	a2,-36(s0)
80001bf4:	fe842583          	lw	a1,-24(s0)
80001bf8:	8000c7b7          	lui	a5,0x8000c
80001bfc:	4fc78513          	addi	a0,a5,1276 # 8000c4fc <memend+0xf800c4fc>
80001c00:	d8cff0ef          	jal	ra,8000118c <printf>
            for(int j=0;j<1024;j++){
80001c04:	fe842783          	lw	a5,-24(s0)
80001c08:	00178793          	addi	a5,a5,1
80001c0c:	fef42423          	sw	a5,-24(s0)
80001c10:	fe842703          	lw	a4,-24(s0)
80001c14:	3ff00793          	li	a5,1023
80001c18:	fae7d2e3          	bge	a5,a4,80001bbc <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001c1c:	fec42783          	lw	a5,-20(s0)
80001c20:	00178793          	addi	a5,a5,1
80001c24:	fef42623          	sw	a5,-20(s0)
80001c28:	fec42703          	lw	a4,-20(s0)
80001c2c:	3ff00793          	li	a5,1023
80001c30:	f2e7dce3          	bge	a5,a4,80001b68 <printpgt+0x1c>
                }
            }
        }
    }
}
80001c34:	00000013          	nop
80001c38:	00000013          	nop
80001c3c:	03c12083          	lw	ra,60(sp)
80001c40:	03812403          	lw	s0,56(sp)
80001c44:	04010113          	addi	sp,sp,64
80001c48:	00008067          	ret

80001c4c <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
80001c4c:	fd010113          	addi	sp,sp,-48
80001c50:	02112623          	sw	ra,44(sp)
80001c54:	02812423          	sw	s0,40(sp)
80001c58:	03010413          	addi	s0,sp,48
80001c5c:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
80001c60:	fe042623          	sw	zero,-20(s0)
80001c64:	04c0006f          	j	80001cb0 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
80001c68:	fec42783          	lw	a5,-20(s0)
80001c6c:	00d79793          	slli	a5,a5,0xd
80001c70:	00078713          	mv	a4,a5
80001c74:	c00017b7          	lui	a5,0xc0001
80001c78:	00f707b3          	add	a5,a4,a5
80001c7c:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
80001c80:	a79ff0ef          	jal	ra,800016f8 <palloc>
80001c84:	00050793          	mv	a5,a0
80001c88:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
80001c8c:	00600713          	li	a4,6
80001c90:	000016b7          	lui	a3,0x1
80001c94:	fe442603          	lw	a2,-28(s0)
80001c98:	fe842583          	lw	a1,-24(s0)
80001c9c:	fdc42503          	lw	a0,-36(s0)
80001ca0:	dc9ff0ef          	jal	ra,80001a68 <vmmap>
    for(int i=0;i<NPROC;i++){
80001ca4:	fec42783          	lw	a5,-20(s0)
80001ca8:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
80001cac:	fef42623          	sw	a5,-20(s0)
80001cb0:	fec42703          	lw	a4,-20(s0)
80001cb4:	00300793          	li	a5,3
80001cb8:	fae7d8e3          	bge	a5,a4,80001c68 <mkstack+0x1c>
    }
}
80001cbc:	00000013          	nop
80001cc0:	00000013          	nop
80001cc4:	02c12083          	lw	ra,44(sp)
80001cc8:	02812403          	lw	s0,40(sp)
80001ccc:	03010113          	addi	sp,sp,48
80001cd0:	00008067          	ret

80001cd4 <kvminit>:

// 初始化虚拟内存
void kvminit(){
80001cd4:	ff010113          	addi	sp,sp,-16
80001cd8:	00112623          	sw	ra,12(sp)
80001cdc:	00812423          	sw	s0,8(sp)
80001ce0:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001ce4:	a15ff0ef          	jal	ra,800016f8 <palloc>
80001ce8:	00050713          	mv	a4,a0
80001cec:	8000e7b7          	lui	a5,0x8000e
80001cf0:	8ae7a423          	sw	a4,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
    memset(kpgt,0,PGSIZE);
80001cf4:	8000e7b7          	lui	a5,0x8000e
80001cf8:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001cfc:	00001637          	lui	a2,0x1
80001d00:	00000593          	li	a1,0
80001d04:	00078513          	mv	a0,a5
80001d08:	544000ef          	jal	ra,8000224c <memset>

    // 映射 CLINT
    vmmap(kpgt,CLINT_BASE,CLINT_BASE,0xc000,PTE_R|PTE_W);
80001d0c:	8000e7b7          	lui	a5,0x8000e
80001d10:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001d14:	00600713          	li	a4,6
80001d18:	0000c6b7          	lui	a3,0xc
80001d1c:	02000637          	lui	a2,0x2000
80001d20:	020005b7          	lui	a1,0x2000
80001d24:	00078513          	mv	a0,a5
80001d28:	d41ff0ef          	jal	ra,80001a68 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
80001d2c:	8000e7b7          	lui	a5,0x8000e
80001d30:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001d34:	00600713          	li	a4,6
80001d38:	004006b7          	lui	a3,0x400
80001d3c:	0c000637          	lui	a2,0xc000
80001d40:	0c0005b7          	lui	a1,0xc000
80001d44:	00078513          	mv	a0,a5
80001d48:	d21ff0ef          	jal	ra,80001a68 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
80001d4c:	8000e7b7          	lui	a5,0x8000e
80001d50:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001d54:	00600713          	li	a4,6
80001d58:	000016b7          	lui	a3,0x1
80001d5c:	10000637          	lui	a2,0x10000
80001d60:	100005b7          	lui	a1,0x10000
80001d64:	00078513          	mv	a0,a5
80001d68:	d01ff0ef          	jal	ra,80001a68 <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
80001d6c:	8000e7b7          	lui	a5,0x8000e
80001d70:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001d74:	800007b7          	lui	a5,0x80000
80001d78:	00078593          	mv	a1,a5
80001d7c:	800007b7          	lui	a5,0x80000
80001d80:	00078613          	mv	a2,a5
80001d84:	800037b7          	lui	a5,0x80003
80001d88:	8b478713          	addi	a4,a5,-1868 # 800028b4 <memend+0xf80028b4>
80001d8c:	800007b7          	lui	a5,0x80000
80001d90:	00078793          	mv	a5,a5
80001d94:	40f707b3          	sub	a5,a4,a5
80001d98:	00a00713          	li	a4,10
80001d9c:	00078693          	mv	a3,a5
80001da0:	cc9ff0ef          	jal	ra,80001a68 <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001da4:	8000e7b7          	lui	a5,0x8000e
80001da8:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001dac:	800037b7          	lui	a5,0x80003
80001db0:	00078593          	mv	a1,a5
80001db4:	800037b7          	lui	a5,0x80003
80001db8:	00078613          	mv	a2,a5
80001dbc:	8000b7b7          	lui	a5,0x8000b
80001dc0:	00878713          	addi	a4,a5,8 # 8000b008 <memend+0xf800b008>
80001dc4:	800037b7          	lui	a5,0x80003
80001dc8:	00078793          	mv	a5,a5
80001dcc:	40f707b3          	sub	a5,a4,a5
80001dd0:	00600713          	li	a4,6
80001dd4:	00078693          	mv	a3,a5
80001dd8:	c91ff0ef          	jal	ra,80001a68 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001ddc:	8000e7b7          	lui	a5,0x8000e
80001de0:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001de4:	8000c7b7          	lui	a5,0x8000c
80001de8:	00078593          	mv	a1,a5
80001dec:	8000c7b7          	lui	a5,0x8000c
80001df0:	00078613          	mv	a2,a5
80001df4:	8000c7b7          	lui	a5,0x8000c
80001df8:	51378713          	addi	a4,a5,1299 # 8000c513 <memend+0xf800c513>
80001dfc:	8000c7b7          	lui	a5,0x8000c
80001e00:	00078793          	mv	a5,a5
80001e04:	40f707b3          	sub	a5,a4,a5
80001e08:	00200713          	li	a4,2
80001e0c:	00078693          	mv	a3,a5
80001e10:	c59ff0ef          	jal	ra,80001a68 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001e14:	8000e7b7          	lui	a5,0x8000e
80001e18:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001e1c:	8000d7b7          	lui	a5,0x8000d
80001e20:	00078593          	mv	a1,a5
80001e24:	8000d7b7          	lui	a5,0x8000d
80001e28:	00078613          	mv	a2,a5
80001e2c:	8000e7b7          	lui	a5,0x8000e
80001e30:	9f078713          	addi	a4,a5,-1552 # 8000d9f0 <memend+0xf800d9f0>
80001e34:	8000d7b7          	lui	a5,0x8000d
80001e38:	00078793          	mv	a5,a5
80001e3c:	40f707b3          	sub	a5,a4,a5
80001e40:	00600713          	li	a4,6
80001e44:	00078693          	mv	a3,a5
80001e48:	c21ff0ef          	jal	ra,80001a68 <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001e4c:	8000e7b7          	lui	a5,0x8000e
80001e50:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001e54:	8000e7b7          	lui	a5,0x8000e
80001e58:	00078593          	mv	a1,a5
80001e5c:	8000e7b7          	lui	a5,0x8000e
80001e60:	00078613          	mv	a2,a5
80001e64:	880007b7          	lui	a5,0x88000
80001e68:	00078713          	mv	a4,a5
80001e6c:	8000e7b7          	lui	a5,0x8000e
80001e70:	00078793          	mv	a5,a5
80001e74:	40f707b3          	sub	a5,a4,a5
80001e78:	00600713          	li	a4,6
80001e7c:	00078693          	mv	a3,a5
80001e80:	be9ff0ef          	jal	ra,80001a68 <vmmap>

    mkstack(kpgt);
80001e84:	8000e7b7          	lui	a5,0x8000e
80001e88:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001e8c:	00078513          	mv	a0,a5
80001e90:	dbdff0ef          	jal	ra,80001c4c <mkstack>

    // 映射 usertrap
    vmmap(kpgt,USERVEC,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
80001e94:	8000e7b7          	lui	a5,0x8000e
80001e98:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001e9c:	800007b7          	lui	a5,0x80000
80001ea0:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001ea4:	00a00713          	li	a4,10
80001ea8:	000016b7          	lui	a3,0x1
80001eac:	00078613          	mv	a2,a5
80001eb0:	fffff5b7          	lui	a1,0xfffff
80001eb4:	bb5ff0ef          	jal	ra,80001a68 <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001eb8:	8000e7b7          	lui	a5,0x8000e
80001ebc:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001ec0:	00c7d713          	srli	a4,a5,0xc
80001ec4:	800007b7          	lui	a5,0x80000
80001ec8:	00f767b3          	or	a5,a4,a5
80001ecc:	00078513          	mv	a0,a5
80001ed0:	a9dff0ef          	jal	ra,8000196c <w_satp>
    sfence_vma();       // 刷新页表
80001ed4:	ac1ff0ef          	jal	ra,80001994 <sfence_vma>
}
80001ed8:	00000013          	nop
80001edc:	00c12083          	lw	ra,12(sp)
80001ee0:	00812403          	lw	s0,8(sp)
80001ee4:	01010113          	addi	sp,sp,16
80001ee8:	00008067          	ret

80001eec <pgtcreate>:

addr_t* pgtcreate(){
80001eec:	fe010113          	addi	sp,sp,-32
80001ef0:	00112e23          	sw	ra,28(sp)
80001ef4:	00812c23          	sw	s0,24(sp)
80001ef8:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001efc:	ffcff0ef          	jal	ra,800016f8 <palloc>
80001f00:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001f04:	fec42783          	lw	a5,-20(s0)
}
80001f08:	00078513          	mv	a0,a5
80001f0c:	01c12083          	lw	ra,28(sp)
80001f10:	01812403          	lw	s0,24(sp)
80001f14:	02010113          	addi	sp,sp,32
80001f18:	00008067          	ret

80001f1c <r_tp>:
static inline uint32 r_tp(){
80001f1c:	fe010113          	addi	sp,sp,-32
80001f20:	00812e23          	sw	s0,28(sp)
80001f24:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001f28:	00020793          	mv	a5,tp
80001f2c:	fef42623          	sw	a5,-20(s0)
    return x;
80001f30:	fec42783          	lw	a5,-20(s0)
}
80001f34:	00078513          	mv	a0,a5
80001f38:	01c12403          	lw	s0,28(sp)
80001f3c:	02010113          	addi	sp,sp,32
80001f40:	00008067          	ret

80001f44 <procinit>:
#include "defs.h"
#include "riscv.h"

uint nextpid=0;

void procinit(){
80001f44:	fe010113          	addi	sp,sp,-32
80001f48:	00812e23          	sw	s0,28(sp)
80001f4c:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001f50:	fe042623          	sw	zero,-20(s0)
80001f54:	0500006f          	j	80001fa4 <procinit+0x60>
        p=&proc[i];
80001f58:	fec42703          	lw	a4,-20(s0)
80001f5c:	00070793          	mv	a5,a4
80001f60:	00379793          	slli	a5,a5,0x3
80001f64:	00e787b3          	add	a5,a5,a4
80001f68:	00479793          	slli	a5,a5,0x4
80001f6c:	8000d737          	lui	a4,0x8000d
80001f70:	44870713          	addi	a4,a4,1096 # 8000d448 <memend+0xf800d448>
80001f74:	00e787b3          	add	a5,a5,a4
80001f78:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
80001f7c:	fec42783          	lw	a5,-20(s0)
80001f80:	00d79793          	slli	a5,a5,0xd
80001f84:	00078713          	mv	a4,a5
80001f88:	c00027b7          	lui	a5,0xc0002
80001f8c:	00f70733          	add	a4,a4,a5
80001f90:	fe842783          	lw	a5,-24(s0)
80001f94:	08e7a623          	sw	a4,140(a5) # c000208c <memend+0x3800208c>
    for(int i=0;i<NPROC;i++){
80001f98:	fec42783          	lw	a5,-20(s0)
80001f9c:	00178793          	addi	a5,a5,1
80001fa0:	fef42623          	sw	a5,-20(s0)
80001fa4:	fec42703          	lw	a4,-20(s0)
80001fa8:	00300793          	li	a5,3
80001fac:	fae7d6e3          	bge	a5,a4,80001f58 <procinit+0x14>
    }
}
80001fb0:	00000013          	nop
80001fb4:	00000013          	nop
80001fb8:	01c12403          	lw	s0,28(sp)
80001fbc:	02010113          	addi	sp,sp,32
80001fc0:	00008067          	ret

80001fc4 <nowproc>:

struct pcb* nowproc(){
80001fc4:	fe010113          	addi	sp,sp,-32
80001fc8:	00112e23          	sw	ra,28(sp)
80001fcc:	00812c23          	sw	s0,24(sp)
80001fd0:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80001fd4:	f49ff0ef          	jal	ra,80001f1c <r_tp>
80001fd8:	00050793          	mv	a5,a0
80001fdc:	fef42623          	sw	a5,-20(s0)
    return cpu[hart].proc;
80001fe0:	8000d7b7          	lui	a5,0x8000d
80001fe4:	40478713          	addi	a4,a5,1028 # 8000d404 <memend+0xf800d404>
80001fe8:	fec42783          	lw	a5,-20(s0)
80001fec:	00379793          	slli	a5,a5,0x3
80001ff0:	00f707b3          	add	a5,a4,a5
80001ff4:	0007a783          	lw	a5,0(a5)
}
80001ff8:	00078513          	mv	a0,a5
80001ffc:	01c12083          	lw	ra,28(sp)
80002000:	01812403          	lw	s0,24(sp)
80002004:	02010113          	addi	sp,sp,32
80002008:	00008067          	ret

8000200c <pidalloc>:

uint pidalloc(){
8000200c:	ff010113          	addi	sp,sp,-16
80002010:	00812623          	sw	s0,12(sp)
80002014:	01010413          	addi	s0,sp,16
    return nextpid++;
80002018:	8000d7b7          	lui	a5,0x8000d
8000201c:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
80002020:	00178693          	addi	a3,a5,1
80002024:	8000d737          	lui	a4,0x8000d
80002028:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
} 
8000202c:	00078513          	mv	a0,a5
80002030:	00c12403          	lw	s0,12(sp)
80002034:	01010113          	addi	sp,sp,16
80002038:	00008067          	ret

8000203c <procalloc>:

struct pcb* procalloc(){
8000203c:	fe010113          	addi	sp,sp,-32
80002040:	00112e23          	sw	ra,28(sp)
80002044:	00812c23          	sw	s0,24(sp)
80002048:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
8000204c:	8000d7b7          	lui	a5,0x8000d
80002050:	44878793          	addi	a5,a5,1096 # 8000d448 <memend+0xf800d448>
80002054:	fef42623          	sw	a5,-20(s0)
80002058:	0680006f          	j	800020c0 <procalloc+0x84>
        if(p->status==UNUSED){
8000205c:	fec42783          	lw	a5,-20(s0)
80002060:	0047a783          	lw	a5,4(a5)
80002064:	04079863          	bnez	a5,800020b4 <procalloc+0x78>
            p->trapframe=(struct trapframe*)palloc(sizeof(struct trapframe));
80002068:	08c00513          	li	a0,140
8000206c:	e8cff0ef          	jal	ra,800016f8 <palloc>
80002070:	00050713          	mv	a4,a0
80002074:	fec42783          	lw	a5,-20(s0)
80002078:	00e7a423          	sw	a4,8(a5)
            
            p->pid=pidalloc();
8000207c:	f91ff0ef          	jal	ra,8000200c <pidalloc>
80002080:	00050793          	mv	a5,a0
80002084:	00078713          	mv	a4,a5
80002088:	fec42783          	lw	a5,-20(s0)
8000208c:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80002090:	fec42783          	lw	a5,-20(s0)
80002094:	00100713          	li	a4,1
80002098:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
8000209c:	e51ff0ef          	jal	ra,80001eec <pgtcreate>
800020a0:	00050713          	mv	a4,a0
800020a4:	fec42783          	lw	a5,-20(s0)
800020a8:	08e7a423          	sw	a4,136(a5)
            
            return p;
800020ac:	fec42783          	lw	a5,-20(s0)
800020b0:	0240006f          	j	800020d4 <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
800020b4:	fec42783          	lw	a5,-20(s0)
800020b8:	09078793          	addi	a5,a5,144
800020bc:	fef42623          	sw	a5,-20(s0)
800020c0:	fec42703          	lw	a4,-20(s0)
800020c4:	8000d7b7          	lui	a5,0x8000d
800020c8:	68878793          	addi	a5,a5,1672 # 8000d688 <memend+0xf800d688>
800020cc:	f8f768e3          	bltu	a4,a5,8000205c <procalloc+0x20>
        }
    }
    return 0;
800020d0:	00000793          	li	a5,0
}
800020d4:	00078513          	mv	a0,a5
800020d8:	01c12083          	lw	ra,28(sp)
800020dc:	01812403          	lw	s0,24(sp)
800020e0:	02010113          	addi	sp,sp,32
800020e4:	00008067          	ret

800020e8 <userinit>:
  0x93,0x08,0x10,0x00,
  0x73,0x00,0x00,0x00
  };

// 初始化第一个进程
void userinit(){
800020e8:	fe010113          	addi	sp,sp,-32
800020ec:	00112e23          	sw	ra,28(sp)
800020f0:	00812c23          	sw	s0,24(sp)
800020f4:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
800020f8:	f45ff0ef          	jal	ra,8000203c <procalloc>
800020fc:	fea42623          	sw	a0,-20(s0)
    
    p->trapframe->epc=0;
80002100:	fec42783          	lw	a5,-20(s0)
80002104:	0087a783          	lw	a5,8(a5)
80002108:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp=PGSIZE;
8000210c:	fec42783          	lw	a5,-20(s0)
80002110:	0087a783          	lw	a5,8(a5)
80002114:	00001737          	lui	a4,0x1
80002118:	00e7aa23          	sw	a4,20(a5)
    
    char* m=(char*)palloc();
8000211c:	ddcff0ef          	jal	ra,800016f8 <palloc>
80002120:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80002124:	00800613          	li	a2,8
80002128:	00000693          	li	a3,0
8000212c:	800037b7          	lui	a5,0x80003
80002130:	00078593          	mv	a1,a5
80002134:	fe842503          	lw	a0,-24(s0)
80002138:	180000ef          	jal	ra,800022b8 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X|PTE_U);
8000213c:	fec42783          	lw	a5,-20(s0)
80002140:	0887a783          	lw	a5,136(a5) # 80003088 <memend+0xf8003088>
80002144:	fe842603          	lw	a2,-24(s0)
80002148:	01e00713          	li	a4,30
8000214c:	000016b7          	lui	a3,0x1
80002150:	00000593          	li	a1,0
80002154:	00078513          	mv	a0,a5
80002158:	911ff0ef          	jal	ra,80001a68 <vmmap>
    vmmap(p->pagetable,(uint32)usertrap,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
8000215c:	fec42783          	lw	a5,-20(s0)
80002160:	0887a503          	lw	a0,136(a5)
80002164:	800007b7          	lui	a5,0x80000
80002168:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
8000216c:	800007b7          	lui	a5,0x80000
80002170:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80002174:	00a00713          	li	a4,10
80002178:	000016b7          	lui	a3,0x1
8000217c:	00078613          	mv	a2,a5
80002180:	8e9ff0ef          	jal	ra,80001a68 <vmmap>

    vmmap(p->pagetable,(addr_t)TRAPFRAME,(addr_t)p->trapframe,PGSIZE,PTE_R|PTE_W);
80002184:	fec42783          	lw	a5,-20(s0)
80002188:	0887a503          	lw	a0,136(a5)
8000218c:	fec42783          	lw	a5,-20(s0)
80002190:	0087a783          	lw	a5,8(a5)
80002194:	00600713          	li	a4,6
80002198:	000016b7          	lui	a3,0x1
8000219c:	00078613          	mv	a2,a5
800021a0:	ffffe5b7          	lui	a1,0xffffe
800021a4:	8c5ff0ef          	jal	ra,80001a68 <vmmap>

    p->pagetable=(addr_t*)p->pagetable;
800021a8:	fec42783          	lw	a5,-20(s0)
800021ac:	0887a703          	lw	a4,136(a5)
800021b0:	fec42783          	lw	a5,-20(s0)
800021b4:	08e7a423          	sw	a4,136(a5)

    p->status=RUNABLE;
800021b8:	fec42783          	lw	a5,-20(s0)
800021bc:	00200713          	li	a4,2
800021c0:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
800021c4:	fec42783          	lw	a5,-20(s0)
800021c8:	0887a783          	lw	a5,136(a5)
800021cc:	00078513          	mv	a0,a5
800021d0:	a7dff0ef          	jal	ra,80001c4c <mkstack>

    int id=r_tp();
800021d4:	d49ff0ef          	jal	ra,80001f1c <r_tp>
800021d8:	00050793          	mv	a5,a0
800021dc:	fef42223          	sw	a5,-28(s0)
    cpu[id].proc=p;
800021e0:	8000d7b7          	lui	a5,0x8000d
800021e4:	40478713          	addi	a4,a5,1028 # 8000d404 <memend+0xf800d404>
800021e8:	fe442783          	lw	a5,-28(s0)
800021ec:	00379793          	slli	a5,a5,0x3
800021f0:	00f707b3          	add	a5,a4,a5
800021f4:	fec42703          	lw	a4,-20(s0)
800021f8:	00e7a023          	sw	a4,0(a5)
}
800021fc:	00000013          	nop
80002200:	01c12083          	lw	ra,28(sp)
80002204:	01812403          	lw	s0,24(sp)
80002208:	02010113          	addi	sp,sp,32
8000220c:	00008067          	ret

80002210 <schedule>:

void schedule(){
80002210:	fe010113          	addi	sp,sp,-32
80002214:	00812e23          	sw	s0,28(sp)
80002218:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
8000221c:	8000d7b7          	lui	a5,0x8000d
80002220:	44878793          	addi	a5,a5,1096 # 8000d448 <memend+0xf800d448>
80002224:	fef42623          	sw	a5,-20(s0)
80002228:	0100006f          	j	80002238 <schedule+0x28>
8000222c:	fec42783          	lw	a5,-20(s0)
80002230:	09078793          	addi	a5,a5,144
80002234:	fef42623          	sw	a5,-20(s0)
80002238:	fec42703          	lw	a4,-20(s0)
8000223c:	8000d7b7          	lui	a5,0x8000d
80002240:	68878793          	addi	a5,a5,1672 # 8000d688 <memend+0xf800d688>
80002244:	fef764e3          	bltu	a4,a5,8000222c <schedule+0x1c>
    for(;;){
80002248:	fd5ff06f          	j	8000221c <schedule+0xc>

8000224c <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
8000224c:	fd010113          	addi	sp,sp,-48
80002250:	02812623          	sw	s0,44(sp)
80002254:	03010413          	addi	s0,sp,48
80002258:	fca42e23          	sw	a0,-36(s0)
8000225c:	fcb42c23          	sw	a1,-40(s0)
80002260:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
80002264:	fdc42783          	lw	a5,-36(s0)
80002268:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
8000226c:	fe042623          	sw	zero,-20(s0)
80002270:	0280006f          	j	80002298 <memset+0x4c>
        maddr[i] = (char)c;
80002274:	fe842703          	lw	a4,-24(s0)
80002278:	fec42783          	lw	a5,-20(s0)
8000227c:	00f707b3          	add	a5,a4,a5
80002280:	fd842703          	lw	a4,-40(s0)
80002284:	0ff77713          	andi	a4,a4,255
80002288:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
8000228c:	fec42783          	lw	a5,-20(s0)
80002290:	00178793          	addi	a5,a5,1
80002294:	fef42623          	sw	a5,-20(s0)
80002298:	fec42703          	lw	a4,-20(s0)
8000229c:	fd442783          	lw	a5,-44(s0)
800022a0:	fcf76ae3          	bltu	a4,a5,80002274 <memset+0x28>
    }
    return addr;
800022a4:	fdc42783          	lw	a5,-36(s0)
}
800022a8:	00078513          	mv	a0,a5
800022ac:	02c12403          	lw	s0,44(sp)
800022b0:	03010113          	addi	sp,sp,48
800022b4:	00008067          	ret

800022b8 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
800022b8:	fd010113          	addi	sp,sp,-48
800022bc:	02812623          	sw	s0,44(sp)
800022c0:	03010413          	addi	s0,sp,48
800022c4:	fca42e23          	sw	a0,-36(s0)
800022c8:	fcb42c23          	sw	a1,-40(s0)
800022cc:	fcc42823          	sw	a2,-48(s0)
800022d0:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
800022d4:	fd042783          	lw	a5,-48(s0)
800022d8:	fd442703          	lw	a4,-44(s0)
800022dc:	00e7e7b3          	or	a5,a5,a4
800022e0:	00079663          	bnez	a5,800022ec <memmove+0x34>
        return dst;
800022e4:	fdc42783          	lw	a5,-36(s0)
800022e8:	1200006f          	j	80002408 <memmove+0x150>
    }

    s = src;
800022ec:	fd842783          	lw	a5,-40(s0)
800022f0:	fef42623          	sw	a5,-20(s0)
    d = dst;
800022f4:	fdc42783          	lw	a5,-36(s0)
800022f8:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
800022fc:	fec42703          	lw	a4,-20(s0)
80002300:	fe842783          	lw	a5,-24(s0)
80002304:	0cf77263          	bgeu	a4,a5,800023c8 <memmove+0x110>
80002308:	fd042783          	lw	a5,-48(s0)
8000230c:	fec42703          	lw	a4,-20(s0)
80002310:	00f707b3          	add	a5,a4,a5
80002314:	fe842703          	lw	a4,-24(s0)
80002318:	0af77863          	bgeu	a4,a5,800023c8 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
8000231c:	fd042783          	lw	a5,-48(s0)
80002320:	fec42703          	lw	a4,-20(s0)
80002324:	00f707b3          	add	a5,a4,a5
80002328:	fef42623          	sw	a5,-20(s0)
        d += n;
8000232c:	fd042783          	lw	a5,-48(s0)
80002330:	fe842703          	lw	a4,-24(s0)
80002334:	00f707b3          	add	a5,a4,a5
80002338:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
8000233c:	02c0006f          	j	80002368 <memmove+0xb0>
            *--d = *--s;
80002340:	fec42783          	lw	a5,-20(s0)
80002344:	fff78793          	addi	a5,a5,-1
80002348:	fef42623          	sw	a5,-20(s0)
8000234c:	fe842783          	lw	a5,-24(s0)
80002350:	fff78793          	addi	a5,a5,-1
80002354:	fef42423          	sw	a5,-24(s0)
80002358:	fec42783          	lw	a5,-20(s0)
8000235c:	0007c703          	lbu	a4,0(a5)
80002360:	fe842783          	lw	a5,-24(s0)
80002364:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80002368:	fd042703          	lw	a4,-48(s0)
8000236c:	fd442783          	lw	a5,-44(s0)
80002370:	fff00513          	li	a0,-1
80002374:	fff00593          	li	a1,-1
80002378:	00a70633          	add	a2,a4,a0
8000237c:	00060813          	mv	a6,a2
80002380:	00e83833          	sltu	a6,a6,a4
80002384:	00b786b3          	add	a3,a5,a1
80002388:	00d805b3          	add	a1,a6,a3
8000238c:	00058693          	mv	a3,a1
80002390:	fcc42823          	sw	a2,-48(s0)
80002394:	fcd42a23          	sw	a3,-44(s0)
80002398:	00070693          	mv	a3,a4
8000239c:	00f6e6b3          	or	a3,a3,a5
800023a0:	fa0690e3          	bnez	a3,80002340 <memmove+0x88>
    if(s < d && s + n > d){     
800023a4:	0600006f          	j	80002404 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
800023a8:	fec42703          	lw	a4,-20(s0)
800023ac:	00170793          	addi	a5,a4,1 # 1001 <sz+0x1>
800023b0:	fef42623          	sw	a5,-20(s0)
800023b4:	fe842783          	lw	a5,-24(s0)
800023b8:	00178693          	addi	a3,a5,1
800023bc:	fed42423          	sw	a3,-24(s0)
800023c0:	00074703          	lbu	a4,0(a4)
800023c4:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
800023c8:	fd042703          	lw	a4,-48(s0)
800023cc:	fd442783          	lw	a5,-44(s0)
800023d0:	fff00513          	li	a0,-1
800023d4:	fff00593          	li	a1,-1
800023d8:	00a70633          	add	a2,a4,a0
800023dc:	00060813          	mv	a6,a2
800023e0:	00e83833          	sltu	a6,a6,a4
800023e4:	00b786b3          	add	a3,a5,a1
800023e8:	00d805b3          	add	a1,a6,a3
800023ec:	00058693          	mv	a3,a1
800023f0:	fcc42823          	sw	a2,-48(s0)
800023f4:	fcd42a23          	sw	a3,-44(s0)
800023f8:	00070693          	mv	a3,a4
800023fc:	00f6e6b3          	or	a3,a3,a5
80002400:	fa0694e3          	bnez	a3,800023a8 <memmove+0xf0>
        }
    }
    return dst;
80002404:	fdc42783          	lw	a5,-36(s0)
}
80002408:	00078513          	mv	a0,a5
8000240c:	02c12403          	lw	s0,44(sp)
80002410:	03010113          	addi	sp,sp,48
80002414:	00008067          	ret

80002418 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80002418:	fd010113          	addi	sp,sp,-48
8000241c:	02812623          	sw	s0,44(sp)
80002420:	03010413          	addi	s0,sp,48
80002424:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80002428:	00000793          	li	a5,0
8000242c:	00000813          	li	a6,0
80002430:	fef42423          	sw	a5,-24(s0)
80002434:	ff042623          	sw	a6,-20(s0)
80002438:	0340006f          	j	8000246c <strlen+0x54>
8000243c:	fe842603          	lw	a2,-24(s0)
80002440:	fec42683          	lw	a3,-20(s0)
80002444:	00100513          	li	a0,1
80002448:	00000593          	li	a1,0
8000244c:	00a60733          	add	a4,a2,a0
80002450:	00070813          	mv	a6,a4
80002454:	00c83833          	sltu	a6,a6,a2
80002458:	00b687b3          	add	a5,a3,a1
8000245c:	00f806b3          	add	a3,a6,a5
80002460:	00068793          	mv	a5,a3
80002464:	fee42423          	sw	a4,-24(s0)
80002468:	fef42623          	sw	a5,-20(s0)
8000246c:	fe842783          	lw	a5,-24(s0)
80002470:	fdc42703          	lw	a4,-36(s0)
80002474:	00f707b3          	add	a5,a4,a5
80002478:	0007c783          	lbu	a5,0(a5)
8000247c:	fc0790e3          	bnez	a5,8000243c <strlen+0x24>
    
    return n;
80002480:	fe842703          	lw	a4,-24(s0)
80002484:	fec42783          	lw	a5,-20(s0)
80002488:	00070513          	mv	a0,a4
8000248c:	00078593          	mv	a1,a5
80002490:	02c12403          	lw	s0,44(sp)
80002494:	03010113          	addi	sp,sp,48
80002498:	00008067          	ret

8000249c <r_tp>:
static inline uint32 r_tp(){
8000249c:	fe010113          	addi	sp,sp,-32
800024a0:	00812e23          	sw	s0,28(sp)
800024a4:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800024a8:	00020793          	mv	a5,tp
800024ac:	fef42623          	sw	a5,-20(s0)
    return x;
800024b0:	fec42783          	lw	a5,-20(s0)
}
800024b4:	00078513          	mv	a0,a5
800024b8:	01c12403          	lw	s0,28(sp)
800024bc:	02010113          	addi	sp,sp,32
800024c0:	00008067          	ret

800024c4 <clintinit>:
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit(){
800024c4:	fe010113          	addi	sp,sp,-32
800024c8:	00112e23          	sw	ra,28(sp)
800024cc:	00812c23          	sw	s0,24(sp)
800024d0:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp 
    int hart=r_tp();
800024d4:	fc9ff0ef          	jal	ra,8000249c <r_tp>
800024d8:	00050793          	mv	a5,a0
800024dc:	fef42623          	sw	a5,-20(s0)
    *(reg_t*)CLINT_MTIMECMP(hart)=*(reg_t*)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
800024e0:	fec42703          	lw	a4,-20(s0)
800024e4:	004017b7          	lui	a5,0x401
800024e8:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800024ec:	00f707b3          	add	a5,a4,a5
800024f0:	00379793          	slli	a5,a5,0x3
800024f4:	0007a703          	lw	a4,0(a5)
800024f8:	fec42683          	lw	a3,-20(s0)
800024fc:	004017b7          	lui	a5,0x401
80002500:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002504:	00f687b3          	add	a5,a3,a5
80002508:	00379793          	slli	a5,a5,0x3
8000250c:	00078693          	mv	a3,a5
80002510:	009897b7          	lui	a5,0x989
80002514:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80002518:	00f707b3          	add	a5,a4,a5
8000251c:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
80002520:	00000013          	nop
80002524:	01c12083          	lw	ra,28(sp)
80002528:	01812403          	lw	s0,24(sp)
8000252c:	02010113          	addi	sp,sp,32
80002530:	00008067          	ret

80002534 <r_mstatus>:
static inline uint32 r_mstatus(){
80002534:	fe010113          	addi	sp,sp,-32
80002538:	00812e23          	sw	s0,28(sp)
8000253c:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80002540:	300027f3          	csrr	a5,mstatus
80002544:	fef42623          	sw	a5,-20(s0)
    return x;
80002548:	fec42783          	lw	a5,-20(s0)
}
8000254c:	00078513          	mv	a0,a5
80002550:	01c12403          	lw	s0,28(sp)
80002554:	02010113          	addi	sp,sp,32
80002558:	00008067          	ret

8000255c <w_mstatus>:
static inline void w_mstatus(uint32 x){
8000255c:	fe010113          	addi	sp,sp,-32
80002560:	00812e23          	sw	s0,28(sp)
80002564:	02010413          	addi	s0,sp,32
80002568:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
8000256c:	fec42783          	lw	a5,-20(s0)
80002570:	30079073          	csrw	mstatus,a5
}
80002574:	00000013          	nop
80002578:	01c12403          	lw	s0,28(sp)
8000257c:	02010113          	addi	sp,sp,32
80002580:	00008067          	ret

80002584 <w_mtvec>:
static inline void w_mtvec(uint32 x){
80002584:	fe010113          	addi	sp,sp,-32
80002588:	00812e23          	sw	s0,28(sp)
8000258c:	02010413          	addi	s0,sp,32
80002590:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0" : : "r"(x));
80002594:	fec42783          	lw	a5,-20(s0)
80002598:	30579073          	csrw	mtvec,a5
}
8000259c:	00000013          	nop
800025a0:	01c12403          	lw	s0,28(sp)
800025a4:	02010113          	addi	sp,sp,32
800025a8:	00008067          	ret

800025ac <r_tp>:
static inline uint32 r_tp(){
800025ac:	fe010113          	addi	sp,sp,-32
800025b0:	00812e23          	sw	s0,28(sp)
800025b4:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800025b8:	00020793          	mv	a5,tp
800025bc:	fef42623          	sw	a5,-20(s0)
    return x;
800025c0:	fec42783          	lw	a5,-20(s0)
}
800025c4:	00078513          	mv	a0,a5
800025c8:	01c12403          	lw	s0,28(sp)
800025cc:	02010113          	addi	sp,sp,32
800025d0:	00008067          	ret

800025d4 <s_mstatus_intr>:
static inline void s_mstatus_intr(uint32 m){
800025d4:	fd010113          	addi	sp,sp,-48
800025d8:	02112623          	sw	ra,44(sp)
800025dc:	02812423          	sw	s0,40(sp)
800025e0:	03010413          	addi	s0,sp,48
800025e4:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
800025e8:	f4dff0ef          	jal	ra,80002534 <r_mstatus>
800025ec:	fea42623          	sw	a0,-20(s0)
    switch (m)
800025f0:	fdc42703          	lw	a4,-36(s0)
800025f4:	08000793          	li	a5,128
800025f8:	04f70263          	beq	a4,a5,8000263c <s_mstatus_intr+0x68>
800025fc:	fdc42703          	lw	a4,-36(s0)
80002600:	08000793          	li	a5,128
80002604:	0ae7e463          	bltu	a5,a4,800026ac <s_mstatus_intr+0xd8>
80002608:	fdc42703          	lw	a4,-36(s0)
8000260c:	02000793          	li	a5,32
80002610:	04f70463          	beq	a4,a5,80002658 <s_mstatus_intr+0x84>
80002614:	fdc42703          	lw	a4,-36(s0)
80002618:	02000793          	li	a5,32
8000261c:	08e7e863          	bltu	a5,a4,800026ac <s_mstatus_intr+0xd8>
80002620:	fdc42703          	lw	a4,-36(s0)
80002624:	00200793          	li	a5,2
80002628:	06f70463          	beq	a4,a5,80002690 <s_mstatus_intr+0xbc>
8000262c:	fdc42703          	lw	a4,-36(s0)
80002630:	00800793          	li	a5,8
80002634:	04f70063          	beq	a4,a5,80002674 <s_mstatus_intr+0xa0>
        break;
80002638:	0740006f          	j	800026ac <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
8000263c:	fec42783          	lw	a5,-20(s0)
80002640:	f7f7f793          	andi	a5,a5,-129
80002644:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
80002648:	fec42783          	lw	a5,-20(s0)
8000264c:	0807e793          	ori	a5,a5,128
80002650:	fef42623          	sw	a5,-20(s0)
        break;
80002654:	05c0006f          	j	800026b0 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
80002658:	fec42783          	lw	a5,-20(s0)
8000265c:	fdf7f793          	andi	a5,a5,-33
80002660:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
80002664:	fec42783          	lw	a5,-20(s0)
80002668:	0207e793          	ori	a5,a5,32
8000266c:	fef42623          	sw	a5,-20(s0)
        break;
80002670:	0400006f          	j	800026b0 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
80002674:	fec42783          	lw	a5,-20(s0)
80002678:	ff77f793          	andi	a5,a5,-9
8000267c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80002680:	fec42783          	lw	a5,-20(s0)
80002684:	0087e793          	ori	a5,a5,8
80002688:	fef42623          	sw	a5,-20(s0)
        break;
8000268c:	0240006f          	j	800026b0 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80002690:	fec42783          	lw	a5,-20(s0)
80002694:	ffd7f793          	andi	a5,a5,-3
80002698:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
8000269c:	fec42783          	lw	a5,-20(s0)
800026a0:	0027e793          	ori	a5,a5,2
800026a4:	fef42623          	sw	a5,-20(s0)
        break;
800026a8:	0080006f          	j	800026b0 <s_mstatus_intr+0xdc>
        break;
800026ac:	00000013          	nop
    w_mstatus(x);
800026b0:	fec42503          	lw	a0,-20(s0)
800026b4:	ea9ff0ef          	jal	ra,8000255c <w_mstatus>
}
800026b8:	00000013          	nop
800026bc:	02c12083          	lw	ra,44(sp)
800026c0:	02812403          	lw	s0,40(sp)
800026c4:	03010113          	addi	sp,sp,48
800026c8:	00008067          	ret

800026cc <r_sie>:
static inline uint32 r_sie(){
800026cc:	fe010113          	addi	sp,sp,-32
800026d0:	00812e23          	sw	s0,28(sp)
800026d4:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie " : "=r"(x));
800026d8:	104027f3          	csrr	a5,sie
800026dc:	fef42623          	sw	a5,-20(s0)
    return x;
800026e0:	fec42783          	lw	a5,-20(s0)
}
800026e4:	00078513          	mv	a0,a5
800026e8:	01c12403          	lw	s0,28(sp)
800026ec:	02010113          	addi	sp,sp,32
800026f0:	00008067          	ret

800026f4 <w_sie>:
static inline void w_sie(uint32 x){
800026f4:	fe010113          	addi	sp,sp,-32
800026f8:	00812e23          	sw	s0,28(sp)
800026fc:	02010413          	addi	s0,sp,32
80002700:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80002704:	fec42783          	lw	a5,-20(s0)
80002708:	10479073          	csrw	sie,a5
}
8000270c:	00000013          	nop
80002710:	01c12403          	lw	s0,28(sp)
80002714:	02010113          	addi	sp,sp,32
80002718:	00008067          	ret

8000271c <r_mie>:
#define MEIE (1<<11)
#define MTIE (1<<7)
#define MSIE (1<<3)
static inline uint32 r_mie(){
8000271c:	fe010113          	addi	sp,sp,-32
80002720:	00812e23          	sw	s0,28(sp)
80002724:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie " : "=r"(x));
80002728:	304027f3          	csrr	a5,mie
8000272c:	fef42623          	sw	a5,-20(s0)
    return x;
80002730:	fec42783          	lw	a5,-20(s0)
}
80002734:	00078513          	mv	a0,a5
80002738:	01c12403          	lw	s0,28(sp)
8000273c:	02010113          	addi	sp,sp,32
80002740:	00008067          	ret

80002744 <w_mie>:
static inline void w_mie(uint32 x){
80002744:	fe010113          	addi	sp,sp,-32
80002748:	00812e23          	sw	s0,28(sp)
8000274c:	02010413          	addi	s0,sp,32
80002750:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"::"r"(x));
80002754:	fec42783          	lw	a5,-20(s0)
80002758:	30479073          	csrw	mie,a5
}
8000275c:	00000013          	nop
80002760:	01c12403          	lw	s0,28(sp)
80002764:	02010113          	addi	sp,sp,32
80002768:	00008067          	ret

8000276c <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x){
8000276c:	fe010113          	addi	sp,sp,-32
80002770:	00812e23          	sw	s0,28(sp)
80002774:	02010413          	addi	s0,sp,32
80002778:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0" : :"r"(x));
8000277c:	fec42783          	lw	a5,-20(s0)
80002780:	34079073          	csrw	mscratch,a5
80002784:	00000013          	nop
80002788:	01c12403          	lw	s0,28(sp)
8000278c:	02010113          	addi	sp,sp,32
80002790:	00008067          	ret

80002794 <timerinit>:

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit(){
80002794:	fe010113          	addi	sp,sp,-32
80002798:	00112e23          	sw	ra,28(sp)
8000279c:	00812c23          	sw	s0,24(sp)
800027a0:	01212a23          	sw	s2,20(sp)
800027a4:	01312823          	sw	s3,16(sp)
800027a8:	02010413          	addi	s0,sp,32
    uint hart=r_tp();
800027ac:	e01ff0ef          	jal	ra,800025ac <r_tp>
800027b0:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
800027b4:	fec42703          	lw	a4,-20(s0)
800027b8:	00070793          	mv	a5,a4
800027bc:	00279793          	slli	a5,a5,0x2
800027c0:	00e787b3          	add	a5,a5,a4
800027c4:	00379793          	slli	a5,a5,0x3
800027c8:	8000e737          	lui	a4,0x8000e
800027cc:	8b070713          	addi	a4,a4,-1872 # 8000d8b0 <memend+0xf800d8b0>
800027d0:	00e787b3          	add	a5,a5,a4
800027d4:	00078513          	mv	a0,a5
800027d8:	f95ff0ef          	jal	ra,8000276c <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
800027dc:	fec42703          	lw	a4,-20(s0)
800027e0:	004017b7          	lui	a5,0x401
800027e4:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800027e8:	00f707b3          	add	a5,a4,a5
800027ec:	00379793          	slli	a5,a5,0x3
800027f0:	00078913          	mv	s2,a5
800027f4:	00000993          	li	s3,0
800027f8:	8000e7b7          	lui	a5,0x8000e
800027fc:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
80002800:	fec42703          	lw	a4,-20(s0)
80002804:	00070793          	mv	a5,a4
80002808:	00279793          	slli	a5,a5,0x2
8000280c:	00e787b3          	add	a5,a5,a4
80002810:	00379793          	slli	a5,a5,0x3
80002814:	00f687b3          	add	a5,a3,a5
80002818:	0127a023          	sw	s2,0(a5)
8000281c:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;
80002820:	8000e7b7          	lui	a5,0x8000e
80002824:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
80002828:	fec42703          	lw	a4,-20(s0)
8000282c:	00070793          	mv	a5,a4
80002830:	00279793          	slli	a5,a5,0x2
80002834:	00e787b3          	add	a5,a5,a4
80002838:	00379793          	slli	a5,a5,0x3
8000283c:	00f686b3          	add	a3,a3,a5
80002840:	00989737          	lui	a4,0x989
80002844:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002848:	00000793          	li	a5,0
8000284c:	00e6a423          	sw	a4,8(a3)
80002850:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数
80002854:	800007b7          	lui	a5,0x80000
80002858:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
8000285c:	00078513          	mv	a0,a5
80002860:	d25ff0ef          	jal	ra,80002584 <w_mtvec>

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断
80002864:	00800513          	li	a0,8
80002868:	d6dff0ef          	jal	ra,800025d4 <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
8000286c:	e61ff0ef          	jal	ra,800026cc <r_sie>
80002870:	00050793          	mv	a5,a0
80002874:	2227e793          	ori	a5,a5,546
80002878:	00078513          	mv	a0,a5
8000287c:	e79ff0ef          	jal	ra,800026f4 <w_sie>

    w_mie(r_mie() | MTIE );      // 开启 M-mode 时钟中断
80002880:	e9dff0ef          	jal	ra,8000271c <r_mie>
80002884:	00050793          	mv	a5,a0
80002888:	0807e793          	ori	a5,a5,128
8000288c:	00078513          	mv	a0,a5
80002890:	eb5ff0ef          	jal	ra,80002744 <w_mie>

    clintinit();                 // 初始化 CLINT           
80002894:	c31ff0ef          	jal	ra,800024c4 <clintinit>
80002898:	00000013          	nop
8000289c:	01c12083          	lw	ra,28(sp)
800028a0:	01812403          	lw	s0,24(sp)
800028a4:	01412903          	lw	s2,20(sp)
800028a8:	01012983          	lw	s3,16(sp)
800028ac:	02010113          	addi	sp,sp,32
800028b0:	00008067          	ret

800028b4 <textend>:
	...
