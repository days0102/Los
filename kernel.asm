
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
80000020:	6a00006f          	j	800006c0 <start>

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
800000ac:	6c5000ef          	jal	ra,80000f70 <trapvec>

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
uservec:

.global usertrap
usertrap:
    // sscratch 指向 trapframe
    csrrw a0,sscratch,a0
80000298:	14051573          	csrrw	a0,sscratch,a0

    // 保存用户态寄存器
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

    lw sp,8(a0)    // 内核栈
8000031c:	00852103          	lw	sp,8(a0)

    lw t6,0(a0)    // 内核页表
80000320:	00052f83          	lw	t6,0(a0)
    csrw satp,t6
80000324:	180f9073          	csrw	satp,t6
    sfence.vma zero,zero
80000328:	12000073          	sfence.vma

    call trapvec    // 处理 trap 
8000032c:	445000ef          	jal	ra,80000f70 <trapvec>

80000330 <userret>:

.global userret
// userret( traoframe,satp )
userret:

    csrw satp,a1
80000330:	18059073          	csrw	satp,a1
    sfence.vma zero, zero
80000334:	12000073          	sfence.vma

    lw t0,32(a0)        // sscratch 暂存用户态 a0
80000338:	02052283          	lw	t0,32(a0)
    csrrw t0,sscratch,t0
8000033c:	140292f3          	csrrw	t0,sscratch,t0

    // 加载用户态寄存器
    lw ra,16(a0)
80000340:	01052083          	lw	ra,16(a0)
    lw sp,20(a0)
80000344:	01452103          	lw	sp,20(a0)
    lw gp,24(a0)
80000348:	01852183          	lw	gp,24(a0)
    lw tp,28(a0)
8000034c:	01c52203          	lw	tp,28(a0)

    lw a1,36(a0)
80000350:	02452583          	lw	a1,36(a0)
    lw a2,40(a0)
80000354:	02852603          	lw	a2,40(a0)
    lw a3,44(a0)
80000358:	02c52683          	lw	a3,44(a0)
    lw a4,48(a0)
8000035c:	03052703          	lw	a4,48(a0)
    lw a5,52(a0)
80000360:	03452783          	lw	a5,52(a0)
    lw a6,56(a0)
80000364:	03852803          	lw	a6,56(a0)
    lw a5,52(a0)
80000368:	03452783          	lw	a5,52(a0)
    lw a7,60(a0)
8000036c:	03c52883          	lw	a7,60(a0)
    
    lw s0,64(a0)
80000370:	04052403          	lw	s0,64(a0)
    lw s1,68(a0)
80000374:	04452483          	lw	s1,68(a0)
    lw s2,72(a0)
80000378:	04852903          	lw	s2,72(a0)
    lw s3,76(a0)
8000037c:	04c52983          	lw	s3,76(a0)
    lw s4,80(a0)
80000380:	05052a03          	lw	s4,80(a0)
    lw s5,84(a0)
80000384:	05452a83          	lw	s5,84(a0)
    lw s6,88(a0)
80000388:	05852b03          	lw	s6,88(a0)
    lw s7,92(a0)
8000038c:	05c52b83          	lw	s7,92(a0)
    lw s8,96(a0)
80000390:	06052c03          	lw	s8,96(a0)
    lw s9,100(a0)
80000394:	06452c83          	lw	s9,100(a0)
    lw s10,104(a0)
80000398:	06852d03          	lw	s10,104(a0)
    lw s11,108(a0)
8000039c:	06c52d83          	lw	s11,108(a0)

    lw t0,112(a0)
800003a0:	07052283          	lw	t0,112(a0)
    lw t1,116(a0)
800003a4:	07452303          	lw	t1,116(a0)
    lw t2,120(a0)
800003a8:	07852383          	lw	t2,120(a0)
    lw t3,124(a0)
800003ac:	07c52e03          	lw	t3,124(a0)
    lw t4,128(a0)
800003b0:	08052e83          	lw	t4,128(a0)
    lw t5,132(a0)
800003b4:	08452f03          	lw	t5,132(a0)
    lw t6,136(a0)
800003b8:	08852f83          	lw	t6,136(a0)

    csrrw a0,sscratch,a0
800003bc:	14051573          	csrrw	a0,sscratch,a0

    // 返回用户态
800003c0:	10200073          	sret

800003c4 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
800003c4:	fe010113          	addi	sp,sp,-32
800003c8:	00812e23          	sw	s0,28(sp)
800003cc:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
800003d0:	300027f3          	csrr	a5,mstatus
800003d4:	fef42623          	sw	a5,-20(s0)
    return x;
800003d8:	fec42783          	lw	a5,-20(s0)
}
800003dc:	00078513          	mv	a0,a5
800003e0:	01c12403          	lw	s0,28(sp)
800003e4:	02010113          	addi	sp,sp,32
800003e8:	00008067          	ret

800003ec <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
800003ec:	fe010113          	addi	sp,sp,-32
800003f0:	00812e23          	sw	s0,28(sp)
800003f4:	02010413          	addi	s0,sp,32
800003f8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
800003fc:	fec42783          	lw	a5,-20(s0)
80000400:	30079073          	csrw	mstatus,a5
}
80000404:	00000013          	nop
80000408:	01c12403          	lw	s0,28(sp)
8000040c:	02010113          	addi	sp,sp,32
80000410:	00008067          	ret

80000414 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80000414:	fd010113          	addi	sp,sp,-48
80000418:	02112623          	sw	ra,44(sp)
8000041c:	02812423          	sw	s0,40(sp)
80000420:	03010413          	addi	s0,sp,48
80000424:	00050793          	mv	a5,a0
80000428:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
8000042c:	f99ff0ef          	jal	ra,800003c4 <r_mstatus>
80000430:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000434:	fdf44783          	lbu	a5,-33(s0)
80000438:	00300713          	li	a4,3
8000043c:	06e78063          	beq	a5,a4,8000049c <s_mstatus_xpp+0x88>
80000440:	00300713          	li	a4,3
80000444:	08f74263          	blt	a4,a5,800004c8 <s_mstatus_xpp+0xb4>
80000448:	00078863          	beqz	a5,80000458 <s_mstatus_xpp+0x44>
8000044c:	00100713          	li	a4,1
80000450:	02e78063          	beq	a5,a4,80000470 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= M_MPP_SET;
        break;
    default:
        break;
80000454:	0740006f          	j	800004c8 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
80000458:	fec42703          	lw	a4,-20(s0)
8000045c:	ffffe7b7          	lui	a5,0xffffe
80000460:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000464:	00f777b3          	and	a5,a4,a5
80000468:	fef42623          	sw	a5,-20(s0)
        break;
8000046c:	0600006f          	j	800004cc <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80000470:	fec42703          	lw	a4,-20(s0)
80000474:	ffffe7b7          	lui	a5,0xffffe
80000478:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
8000047c:	00f777b3          	and	a5,a4,a5
80000480:	fef42623          	sw	a5,-20(s0)
        x |= M_SPP_SET;
80000484:	fec42703          	lw	a4,-20(s0)
80000488:	000017b7          	lui	a5,0x1
8000048c:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
80000490:	00f767b3          	or	a5,a4,a5
80000494:	fef42623          	sw	a5,-20(s0)
        break;
80000498:	0340006f          	j	800004cc <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
8000049c:	fec42703          	lw	a4,-20(s0)
800004a0:	ffffe7b7          	lui	a5,0xffffe
800004a4:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800004a8:	00f777b3          	and	a5,a4,a5
800004ac:	fef42623          	sw	a5,-20(s0)
        x |= M_MPP_SET;
800004b0:	fec42703          	lw	a4,-20(s0)
800004b4:	000027b7          	lui	a5,0x2
800004b8:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
800004bc:	00f767b3          	or	a5,a4,a5
800004c0:	fef42623          	sw	a5,-20(s0)
        break;
800004c4:	0080006f          	j	800004cc <s_mstatus_xpp+0xb8>
        break;
800004c8:	00000013          	nop
    }
    w_mstatus(x);
800004cc:	fec42503          	lw	a0,-20(s0)
800004d0:	f1dff0ef          	jal	ra,800003ec <w_mstatus>
}
800004d4:	00000013          	nop
800004d8:	02c12083          	lw	ra,44(sp)
800004dc:	02812403          	lw	s0,40(sp)
800004e0:	03010113          	addi	sp,sp,48
800004e4:	00008067          	ret

800004e8 <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
800004e8:	fe010113          	addi	sp,sp,-32
800004ec:	00812e23          	sw	s0,28(sp)
800004f0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
800004f4:	100027f3          	csrr	a5,sstatus
800004f8:	fef42623          	sw	a5,-20(s0)
    return x;
800004fc:	fec42783          	lw	a5,-20(s0)
}
80000500:	00078513          	mv	a0,a5
80000504:	01c12403          	lw	s0,28(sp)
80000508:	02010113          	addi	sp,sp,32
8000050c:	00008067          	ret

80000510 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
80000510:	fe010113          	addi	sp,sp,-32
80000514:	00812e23          	sw	s0,28(sp)
80000518:	02010413          	addi	s0,sp,32
8000051c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
80000520:	fec42783          	lw	a5,-20(s0)
80000524:	10079073          	csrw	sstatus,a5
}
80000528:	00000013          	nop
8000052c:	01c12403          	lw	s0,28(sp)
80000530:	02010113          	addi	sp,sp,32
80000534:	00008067          	ret

80000538 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
80000538:	fe010113          	addi	sp,sp,-32
8000053c:	00812e23          	sw	s0,28(sp)
80000540:	02010413          	addi	s0,sp,32
80000544:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
80000548:	fec42783          	lw	a5,-20(s0)
8000054c:	34179073          	csrw	mepc,a5
}
80000550:	00000013          	nop
80000554:	01c12403          	lw	s0,28(sp)
80000558:	02010113          	addi	sp,sp,32
8000055c:	00008067          	ret

80000560 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80000560:	fe010113          	addi	sp,sp,-32
80000564:	00812e23          	sw	s0,28(sp)
80000568:	02010413          	addi	s0,sp,32
8000056c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80000570:	fec42783          	lw	a5,-20(s0)
80000574:	10579073          	csrw	stvec,a5
}
80000578:	00000013          	nop
8000057c:	01c12403          	lw	s0,28(sp)
80000580:	02010113          	addi	sp,sp,32
80000584:	00008067          	ret

80000588 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
80000588:	fe010113          	addi	sp,sp,-32
8000058c:	00812e23          	sw	s0,28(sp)
80000590:	02010413          	addi	s0,sp,32
80000594:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
80000598:	fec42783          	lw	a5,-20(s0)
8000059c:	30379073          	csrw	mideleg,a5
}
800005a0:	00000013          	nop
800005a4:	01c12403          	lw	s0,28(sp)
800005a8:	02010113          	addi	sp,sp,32
800005ac:	00008067          	ret

800005b0 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
800005b0:	fe010113          	addi	sp,sp,-32
800005b4:	00812e23          	sw	s0,28(sp)
800005b8:	02010413          	addi	s0,sp,32
800005bc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
800005c0:	fec42783          	lw	a5,-20(s0)
800005c4:	30279073          	csrw	medeleg,a5
}
800005c8:	00000013          	nop
800005cc:	01c12403          	lw	s0,28(sp)
800005d0:	02010113          	addi	sp,sp,32
800005d4:	00008067          	ret

800005d8 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
800005d8:	fe010113          	addi	sp,sp,-32
800005dc:	00812e23          	sw	s0,28(sp)
800005e0:	02010413          	addi	s0,sp,32
800005e4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800005e8:	fec42783          	lw	a5,-20(s0)
800005ec:	18079073          	csrw	satp,a5
}
800005f0:	00000013          	nop
800005f4:	01c12403          	lw	s0,28(sp)
800005f8:	02010113          	addi	sp,sp,32
800005fc:	00008067          	ret

80000600 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
80000600:	fd010113          	addi	sp,sp,-48
80000604:	02112623          	sw	ra,44(sp)
80000608:	02812423          	sw	s0,40(sp)
8000060c:	03010413          	addi	s0,sp,48
80000610:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
80000614:	ed5ff0ef          	jal	ra,800004e8 <r_sstatus>
80000618:	fea42623          	sw	a0,-20(s0)
    switch (m)
8000061c:	fdc42703          	lw	a4,-36(s0)
80000620:	ffd00793          	li	a5,-3
80000624:	06f70863          	beq	a4,a5,80000694 <s_sstatus_intr+0x94>
80000628:	fdc42703          	lw	a4,-36(s0)
8000062c:	ffd00793          	li	a5,-3
80000630:	06e7e863          	bltu	a5,a4,800006a0 <s_sstatus_intr+0xa0>
80000634:	fdc42703          	lw	a4,-36(s0)
80000638:	fdf00793          	li	a5,-33
8000063c:	02f70c63          	beq	a4,a5,80000674 <s_sstatus_intr+0x74>
80000640:	fdc42703          	lw	a4,-36(s0)
80000644:	fdf00793          	li	a5,-33
80000648:	04e7ec63          	bltu	a5,a4,800006a0 <s_sstatus_intr+0xa0>
8000064c:	fdc42703          	lw	a4,-36(s0)
80000650:	00200793          	li	a5,2
80000654:	02f70863          	beq	a4,a5,80000684 <s_sstatus_intr+0x84>
80000658:	fdc42703          	lw	a4,-36(s0)
8000065c:	02000793          	li	a5,32
80000660:	04f71063          	bne	a4,a5,800006a0 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
80000664:	fec42783          	lw	a5,-20(s0)
80000668:	0207e793          	ori	a5,a5,32
8000066c:	fef42623          	sw	a5,-20(s0)
        break;
80000670:	0340006f          	j	800006a4 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
80000674:	fec42783          	lw	a5,-20(s0)
80000678:	fdf7f793          	andi	a5,a5,-33
8000067c:	fef42623          	sw	a5,-20(s0)
        break;
80000680:	0240006f          	j	800006a4 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
80000684:	fec42783          	lw	a5,-20(s0)
80000688:	0027e793          	ori	a5,a5,2
8000068c:	fef42623          	sw	a5,-20(s0)
        break;
80000690:	0140006f          	j	800006a4 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
80000694:	fec42783          	lw	a5,-20(s0)
80000698:	0027f793          	andi	a5,a5,2
8000069c:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
800006a0:	00000013          	nop
    }
    w_sstatus(x);
800006a4:	fec42503          	lw	a0,-20(s0)
800006a8:	e69ff0ef          	jal	ra,80000510 <w_sstatus>
}
800006ac:	00000013          	nop
800006b0:	02c12083          	lw	ra,44(sp)
800006b4:	02812403          	lw	s0,40(sp)
800006b8:	03010113          	addi	sp,sp,48
800006bc:	00008067          	ret

800006c0 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();     // 定义在main.c

void start(){
800006c0:	ff010113          	addi	sp,sp,-16
800006c4:	00112623          	sw	ra,12(sp)
800006c8:	00812423          	sw	s0,8(sp)
800006cc:	01010413          	addi	s0,sp,16
    uartinit();
800006d0:	07c000ef          	jal	ra,8000074c <uartinit>
    uartputs("Hello Los!\n");
800006d4:	8000c7b7          	lui	a5,0x8000c
800006d8:	00078513          	mv	a0,a5
800006dc:	164000ef          	jal	ra,80000840 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
800006e0:	00100513          	li	a0,1
800006e4:	d31ff0ef          	jal	ra,80000414 <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
800006e8:	00000513          	li	a0,0
800006ec:	eedff0ef          	jal	ra,800005d8 <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
800006f0:	000107b7          	lui	a5,0x10
800006f4:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
800006f8:	e91ff0ef          	jal	ra,80000588 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
800006fc:	000107b7          	lui	a5,0x10
80000700:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000704:	eadff0ef          	jal	ra,800005b0 <w_medeleg>

    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
80000708:	00200513          	li	a0,2
8000070c:	ef5ff0ef          	jal	ra,80000600 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
80000710:	800007b7          	lui	a5,0x80000
80000714:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000718:	00078513          	mv	a0,a5
8000071c:	e45ff0ef          	jal	ra,80000560 <w_stvec>

    timerinit();                // 时钟定时器
80000720:	13c020ef          	jal	ra,8000285c <timerinit>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
80000724:	800017b7          	lui	a5,0x80001
80000728:	90c78793          	addi	a5,a5,-1780 # 8000090c <memend+0xf800090c>
8000072c:	00078513          	mv	a0,a5
80000730:	e09ff0ef          	jal	ra,80000538 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
80000734:	30200073          	mret
80000738:	00000013          	nop
8000073c:	00c12083          	lw	ra,12(sp)
80000740:	00812403          	lw	s0,8(sp)
80000744:	01010113          	addi	sp,sp,16
80000748:	00008067          	ret

8000074c <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
8000074c:	fe010113          	addi	sp,sp,-32
80000750:	00812e23          	sw	s0,28(sp)
80000754:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
80000758:	100007b7          	lui	a5,0x10000
8000075c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000760:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
80000764:	100007b7          	lui	a5,0x10000
80000768:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
8000076c:	0007c783          	lbu	a5,0(a5)
80000770:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
80000774:	100007b7          	lui	a5,0x10000
80000778:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
8000077c:	fef44703          	lbu	a4,-17(s0)
80000780:	f8076713          	ori	a4,a4,-128
80000784:	0ff77713          	andi	a4,a4,255
80000788:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
8000078c:	100007b7          	lui	a5,0x10000
80000790:	00300713          	li	a4,3
80000794:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
80000798:	100007b7          	lui	a5,0x10000
8000079c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007a0:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
800007a4:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
800007a8:	100007b7          	lui	a5,0x10000
800007ac:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800007b0:	fef44703          	lbu	a4,-17(s0)
800007b4:	00376713          	ori	a4,a4,3
800007b8:	0ff77713          	andi	a4,a4,255
800007bc:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
800007c0:	100007b7          	lui	a5,0x10000
800007c4:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007c8:	0007c783          	lbu	a5,0(a5)
800007cc:	0ff7f713          	andi	a4,a5,255
800007d0:	100007b7          	lui	a5,0x10000
800007d4:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007d8:	00176713          	ori	a4,a4,1
800007dc:	0ff77713          	andi	a4,a4,255
800007e0:	00e78023          	sb	a4,0(a5)
}
800007e4:	00000013          	nop
800007e8:	01c12403          	lw	s0,28(sp)
800007ec:	02010113          	addi	sp,sp,32
800007f0:	00008067          	ret

800007f4 <uartputc>:

// 轮询处理数据
char uartputc(char c){
800007f4:	fe010113          	addi	sp,sp,-32
800007f8:	00812e23          	sw	s0,28(sp)
800007fc:	02010413          	addi	s0,sp,32
80000800:	00050793          	mv	a5,a0
80000804:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80000808:	00000013          	nop
8000080c:	100007b7          	lui	a5,0x10000
80000810:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000814:	0007c783          	lbu	a5,0(a5)
80000818:	0ff7f793          	andi	a5,a5,255
8000081c:	0207f793          	andi	a5,a5,32
80000820:	fe0786e3          	beqz	a5,8000080c <uartputc+0x18>
    return uart_write(UART_THR,c);
80000824:	10000737          	lui	a4,0x10000
80000828:	fef44783          	lbu	a5,-17(s0)
8000082c:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
80000830:	00078513          	mv	a0,a5
80000834:	01c12403          	lw	s0,28(sp)
80000838:	02010113          	addi	sp,sp,32
8000083c:	00008067          	ret

80000840 <uartputs>:

// 发送字符串
void uartputs(char* s){
80000840:	fe010113          	addi	sp,sp,-32
80000844:	00112e23          	sw	ra,28(sp)
80000848:	00812c23          	sw	s0,24(sp)
8000084c:	02010413          	addi	s0,sp,32
80000850:	fea42623          	sw	a0,-20(s0)
    while (*s)
80000854:	01c0006f          	j	80000870 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
80000858:	fec42783          	lw	a5,-20(s0)
8000085c:	00178713          	addi	a4,a5,1
80000860:	fee42623          	sw	a4,-20(s0)
80000864:	0007c783          	lbu	a5,0(a5)
80000868:	00078513          	mv	a0,a5
8000086c:	f89ff0ef          	jal	ra,800007f4 <uartputc>
    while (*s)
80000870:	fec42783          	lw	a5,-20(s0)
80000874:	0007c783          	lbu	a5,0(a5)
80000878:	fe0790e3          	bnez	a5,80000858 <uartputs+0x18>
    }
    
}
8000087c:	00000013          	nop
80000880:	00000013          	nop
80000884:	01c12083          	lw	ra,28(sp)
80000888:	01812403          	lw	s0,24(sp)
8000088c:	02010113          	addi	sp,sp,32
80000890:	00008067          	ret

80000894 <uartgetc>:

// 接收输入
int uartgetc(){
80000894:	ff010113          	addi	sp,sp,-16
80000898:	00812623          	sw	s0,12(sp)
8000089c:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
800008a0:	100007b7          	lui	a5,0x10000
800008a4:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
800008a8:	0007c783          	lbu	a5,0(a5)
800008ac:	0ff7f793          	andi	a5,a5,255
800008b0:	0017f793          	andi	a5,a5,1
800008b4:	00078a63          	beqz	a5,800008c8 <uartgetc+0x34>
        return uart_read(UART_RHR);
800008b8:	100007b7          	lui	a5,0x10000
800008bc:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
800008c0:	0ff7f793          	andi	a5,a5,255
800008c4:	0080006f          	j	800008cc <uartgetc+0x38>
    }else{
        return -1;
800008c8:	fff00793          	li	a5,-1
    }
}
800008cc:	00078513          	mv	a0,a5
800008d0:	00c12403          	lw	s0,12(sp)
800008d4:	01010113          	addi	sp,sp,16
800008d8:	00008067          	ret

800008dc <uartintr>:

// 键盘输入中断
char uartintr(){
800008dc:	ff010113          	addi	sp,sp,-16
800008e0:	00112623          	sw	ra,12(sp)
800008e4:	00812423          	sw	s0,8(sp)
800008e8:	01010413          	addi	s0,sp,16
    return uartgetc();
800008ec:	fa9ff0ef          	jal	ra,80000894 <uartgetc>
800008f0:	00050793          	mv	a5,a0
800008f4:	0ff7f793          	andi	a5,a5,255
800008f8:	00078513          	mv	a0,a5
800008fc:	00c12083          	lw	ra,12(sp)
80000900:	00812403          	lw	s0,8(sp)
80000904:	01010113          	addi	sp,sp,16
80000908:	00008067          	ret

8000090c <main>:
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

void main(){
8000090c:	ff010113          	addi	sp,sp,-16
80000910:	00112623          	sw	ra,12(sp)
80000914:	00812423          	sw	s0,8(sp)
80000918:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
8000091c:	8000c7b7          	lui	a5,0x8000c
80000920:	00c78513          	addi	a0,a5,12 # 8000c00c <memend+0xf800c00c>
80000924:	051000ef          	jal	ra,80001174 <printf>

    minit();        // 物理内存管理
80000928:	459000ef          	jal	ra,80001580 <minit>
    plicinit();     // PLIC 中断处理
8000092c:	6d9000ef          	jal	ra,80001804 <plicinit>
    
    kvminit();       // 启动虚拟内存
80000930:	38c010ef          	jal	ra,80001cbc <kvminit>

    printf("usertrap: %p\n",usertrap);
80000934:	800007b7          	lui	a5,0x80000
80000938:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
8000093c:	8000c7b7          	lui	a5,0x8000c
80000940:	02078513          	addi	a0,a5,32 # 8000c020 <memend+0xf800c020>
80000944:	031000ef          	jal	ra,80001174 <printf>

    procinit();
80000948:	5e4010ef          	jal	ra,80001f2c <procinit>

    userinit();
8000094c:	7c8010ef          	jal	ra,80002114 <userinit>

    printf("----------------------\n");
80000950:	8000c7b7          	lui	a5,0x8000c
80000954:	03078513          	addi	a0,a5,48 # 8000c030 <memend+0xf800c030>
80000958:	01d000ef          	jal	ra,80001174 <printf>
    schedule();
8000095c:	0d9010ef          	jal	ra,80002234 <schedule>
}
80000960:	00000013          	nop
80000964:	00c12083          	lw	ra,12(sp)
80000968:	00812403          	lw	s0,8(sp)
8000096c:	01010113          	addi	sp,sp,16
80000970:	00008067          	ret

80000974 <r_sstatus>:
    }
    w_mstatus(x);
}

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
80000974:	fe010113          	addi	sp,sp,-32
80000978:	00812e23          	sw	s0,28(sp)
8000097c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
80000980:	100027f3          	csrr	a5,sstatus
80000984:	fef42623          	sw	a5,-20(s0)
    return x;
80000988:	fec42783          	lw	a5,-20(s0)
}
8000098c:	00078513          	mv	a0,a5
80000990:	01c12403          	lw	s0,28(sp)
80000994:	02010113          	addi	sp,sp,32
80000998:	00008067          	ret

8000099c <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
8000099c:	fe010113          	addi	sp,sp,-32
800009a0:	00812e23          	sw	s0,28(sp)
800009a4:	02010413          	addi	s0,sp,32
800009a8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
800009ac:	fec42783          	lw	a5,-20(s0)
800009b0:	10079073          	csrw	sstatus,a5
}
800009b4:	00000013          	nop
800009b8:	01c12403          	lw	s0,28(sp)
800009bc:	02010113          	addi	sp,sp,32
800009c0:	00008067          	ret

800009c4 <s_sstatus_xpp>:
    }
    return x;
}
// 设置特权模式
#define S_SPP_SET (1<<8)
static inline void s_sstatus_xpp(uint8 m){
800009c4:	fd010113          	addi	sp,sp,-48
800009c8:	02112623          	sw	ra,44(sp)
800009cc:	02812423          	sw	s0,40(sp)
800009d0:	03010413          	addi	s0,sp,48
800009d4:	00050793          	mv	a5,a0
800009d8:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_sstatus();
800009dc:	f99ff0ef          	jal	ra,80000974 <r_sstatus>
800009e0:	fea42623          	sw	a0,-20(s0)
    switch (m)
800009e4:	fdf44783          	lbu	a5,-33(s0)
800009e8:	00078863          	beqz	a5,800009f8 <s_sstatus_xpp+0x34>
800009ec:	00100713          	li	a4,1
800009f0:	00e78c63          	beq	a5,a4,80000a08 <s_sstatus_xpp+0x44>
    case RISCV_S:
        x &= ~SPP_MASK;
        x |= S_SPP_SET;
        break;
    default:
        break;
800009f4:	0300006f          	j	80000a24 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
800009f8:	fec42783          	lw	a5,-20(s0)
800009fc:	eff7f793          	andi	a5,a5,-257
80000a00:	fef42623          	sw	a5,-20(s0)
        break;
80000a04:	0200006f          	j	80000a24 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
80000a08:	fec42783          	lw	a5,-20(s0)
80000a0c:	eff7f793          	andi	a5,a5,-257
80000a10:	fef42623          	sw	a5,-20(s0)
        x |= S_SPP_SET;
80000a14:	fec42783          	lw	a5,-20(s0)
80000a18:	1007e793          	ori	a5,a5,256
80000a1c:	fef42623          	sw	a5,-20(s0)
        break;
80000a20:	00000013          	nop
    }
    w_sstatus(x);
80000a24:	fec42503          	lw	a0,-20(s0)
80000a28:	f75ff0ef          	jal	ra,8000099c <w_sstatus>
}
80000a2c:	00000013          	nop
80000a30:	02c12083          	lw	ra,44(sp)
80000a34:	02812403          	lw	s0,40(sp)
80000a38:	03010113          	addi	sp,sp,48
80000a3c:	00008067          	ret

80000a40 <r_sepc>:

/**
 * @description: 读取 sepc 寄存器
 * S-mode 返回时跳转到 pc = sepc指向的地址
 */
static inline uint32 r_sepc(){
80000a40:	fe010113          	addi	sp,sp,-32
80000a44:	00812e23          	sw	s0,28(sp)
80000a48:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sepc" : "=r" (x) );
80000a4c:	141027f3          	csrr	a5,sepc
80000a50:	fef42623          	sw	a5,-20(s0)
    return x;
80000a54:	fec42783          	lw	a5,-20(s0)
}
80000a58:	00078513          	mv	a0,a5
80000a5c:	01c12403          	lw	s0,28(sp)
80000a60:	02010113          	addi	sp,sp,32
80000a64:	00008067          	ret

80000a68 <w_sepc>:
// 写 sepc寄存器
static inline void w_sepc(uint32 x){
80000a68:	fe010113          	addi	sp,sp,-32
80000a6c:	00812e23          	sw	s0,28(sp)
80000a70:	02010413          	addi	s0,sp,32
80000a74:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
80000a78:	fec42783          	lw	a5,-20(s0)
80000a7c:	14179073          	csrw	sepc,a5
}
80000a80:	00000013          	nop
80000a84:	01c12403          	lw	s0,28(sp)
80000a88:	02010113          	addi	sp,sp,32
80000a8c:	00008067          	ret

80000a90 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80000a90:	fe010113          	addi	sp,sp,-32
80000a94:	00812e23          	sw	s0,28(sp)
80000a98:	02010413          	addi	s0,sp,32
80000a9c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80000aa0:	fec42783          	lw	a5,-20(s0)
80000aa4:	10579073          	csrw	stvec,a5
}
80000aa8:	00000013          	nop
80000aac:	01c12403          	lw	s0,28(sp)
80000ab0:	02010113          	addi	sp,sp,32
80000ab4:	00008067          	ret

80000ab8 <r_satp>:
 * mode = 地址转换方案 0=bare 1=SV32
 * asid = 地址空间标识
 * ppn  = 根页表物理页码(物理地址/4Kb)
 */
#define SATP_SV32 (1<<31)    
static inline uint32 r_satp(){
80000ab8:	fe010113          	addi	sp,sp,-32
80000abc:	00812e23          	sw	s0,28(sp)
80000ac0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
80000ac4:	180027f3          	csrr	a5,satp
80000ac8:	fef42623          	sw	a5,-20(s0)
    return x;
80000acc:	fec42783          	lw	a5,-20(s0)
}
80000ad0:	00078513          	mv	a0,a5
80000ad4:	01c12403          	lw	s0,28(sp)
80000ad8:	02010113          	addi	sp,sp,32
80000adc:	00008067          	ret

80000ae0 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
80000ae0:	fe010113          	addi	sp,sp,-32
80000ae4:	00812e23          	sw	s0,28(sp)
80000ae8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
80000aec:	142027f3          	csrr	a5,scause
80000af0:	fef42623          	sw	a5,-20(s0)
    return x;
80000af4:	fec42783          	lw	a5,-20(s0)
}
80000af8:	00078513          	mv	a0,a5
80000afc:	01c12403          	lw	s0,28(sp)
80000b00:	02010113          	addi	sp,sp,32
80000b04:	00008067          	ret

80000b08 <r_sip>:

/**
 * @description: 
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip(){
80000b08:	fe010113          	addi	sp,sp,-32
80000b0c:	00812e23          	sw	s0,28(sp)
80000b10:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip":"=r"(x));
80000b14:	144027f3          	csrr	a5,sip
80000b18:	fef42623          	sw	a5,-20(s0)
    return x;
80000b1c:	fec42783          	lw	a5,-20(s0)
}
80000b20:	00078513          	mv	a0,a5
80000b24:	01c12403          	lw	s0,28(sp)
80000b28:	02010113          	addi	sp,sp,32
80000b2c:	00008067          	ret

80000b30 <w_sip>:
static inline void w_sip(uint32 x){
80000b30:	fe010113          	addi	sp,sp,-32
80000b34:	00812e23          	sw	s0,28(sp)
80000b38:	02010413          	addi	s0,sp,32
80000b3c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"::"r"(x));
80000b40:	fec42783          	lw	a5,-20(s0)
80000b44:	14479073          	csrw	sip,a5
}
80000b48:	00000013          	nop
80000b4c:	01c12403          	lw	s0,28(sp)
80000b50:	02010113          	addi	sp,sp,32
80000b54:	00008067          	ret

80000b58 <externinterrupt>:
#include "vm.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
80000b58:	fe010113          	addi	sp,sp,-32
80000b5c:	00112e23          	sw	ra,28(sp)
80000b60:	00812c23          	sw	s0,24(sp)
80000b64:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000b68:	561000ef          	jal	ra,800018c8 <r_plicclaim>
80000b6c:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000b70:	fec42583          	lw	a1,-20(s0)
80000b74:	8000c7b7          	lui	a5,0x8000c
80000b78:	04878513          	addi	a0,a5,72 # 8000c048 <memend+0xf800c048>
80000b7c:	5f8000ef          	jal	ra,80001174 <printf>
    switch (irq)
80000b80:	fec42703          	lw	a4,-20(s0)
80000b84:	00a00793          	li	a5,10
80000b88:	02f71063          	bne	a4,a5,80000ba8 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80000b8c:	d51ff0ef          	jal	ra,800008dc <uartintr>
80000b90:	00050793          	mv	a5,a0
80000b94:	00078593          	mv	a1,a5
80000b98:	8000c7b7          	lui	a5,0x8000c
80000b9c:	05478513          	addi	a0,a5,84 # 8000c054 <memend+0xf800c054>
80000ba0:	5d4000ef          	jal	ra,80001174 <printf>
        break;
80000ba4:	0080006f          	j	80000bac <externinterrupt+0x54>
    default:
        break;
80000ba8:	00000013          	nop
    }
    w_pliccomplete(irq);
80000bac:	fec42503          	lw	a0,-20(s0)
80000bb0:	559000ef          	jal	ra,80001908 <w_pliccomplete>
}
80000bb4:	00000013          	nop
80000bb8:	01c12083          	lw	ra,28(sp)
80000bbc:	01812403          	lw	s0,24(sp)
80000bc0:	02010113          	addi	sp,sp,32
80000bc4:	00008067          	ret

80000bc8 <ptf>:

void ptf(struct trapframe *tf){
80000bc8:	fe010113          	addi	sp,sp,-32
80000bcc:	00112e23          	sw	ra,28(sp)
80000bd0:	00812c23          	sw	s0,24(sp)
80000bd4:	02010413          	addi	s0,sp,32
80000bd8:	fea42623          	sw	a0,-20(s0)
    printf("kernel_sp: %d \n",tf->kernel_sp);
80000bdc:	fec42783          	lw	a5,-20(s0)
80000be0:	0087a783          	lw	a5,8(a5)
80000be4:	00078593          	mv	a1,a5
80000be8:	8000c7b7          	lui	a5,0x8000c
80000bec:	06478513          	addi	a0,a5,100 # 8000c064 <memend+0xf800c064>
80000bf0:	584000ef          	jal	ra,80001174 <printf>
    printf("kernel_satp: %d \n",tf->kernel_satp);
80000bf4:	fec42783          	lw	a5,-20(s0)
80000bf8:	0007a783          	lw	a5,0(a5)
80000bfc:	00078593          	mv	a1,a5
80000c00:	8000c7b7          	lui	a5,0x8000c
80000c04:	07478513          	addi	a0,a5,116 # 8000c074 <memend+0xf800c074>
80000c08:	56c000ef          	jal	ra,80001174 <printf>
    printf("kernel_tvec: %d \n",tf->kernel_tvec);
80000c0c:	fec42783          	lw	a5,-20(s0)
80000c10:	0047a783          	lw	a5,4(a5)
80000c14:	00078593          	mv	a1,a5
80000c18:	8000c7b7          	lui	a5,0x8000c
80000c1c:	08878513          	addi	a0,a5,136 # 8000c088 <memend+0xf800c088>
80000c20:	554000ef          	jal	ra,80001174 <printf>

    printf("ra: %d \n",tf->ra);
80000c24:	fec42783          	lw	a5,-20(s0)
80000c28:	0107a783          	lw	a5,16(a5)
80000c2c:	00078593          	mv	a1,a5
80000c30:	8000c7b7          	lui	a5,0x8000c
80000c34:	09c78513          	addi	a0,a5,156 # 8000c09c <memend+0xf800c09c>
80000c38:	53c000ef          	jal	ra,80001174 <printf>
    printf("sp: %d \n",tf->sp);
80000c3c:	fec42783          	lw	a5,-20(s0)
80000c40:	0147a783          	lw	a5,20(a5)
80000c44:	00078593          	mv	a1,a5
80000c48:	8000c7b7          	lui	a5,0x8000c
80000c4c:	0a878513          	addi	a0,a5,168 # 8000c0a8 <memend+0xf800c0a8>
80000c50:	524000ef          	jal	ra,80001174 <printf>
    printf("tp: %d \n",tf->tp);
80000c54:	fec42783          	lw	a5,-20(s0)
80000c58:	01c7a783          	lw	a5,28(a5)
80000c5c:	00078593          	mv	a1,a5
80000c60:	8000c7b7          	lui	a5,0x8000c
80000c64:	0b478513          	addi	a0,a5,180 # 8000c0b4 <memend+0xf800c0b4>
80000c68:	50c000ef          	jal	ra,80001174 <printf>
    printf("t0: %d \n",tf->t0);
80000c6c:	fec42783          	lw	a5,-20(s0)
80000c70:	0707a783          	lw	a5,112(a5)
80000c74:	00078593          	mv	a1,a5
80000c78:	8000c7b7          	lui	a5,0x8000c
80000c7c:	0c078513          	addi	a0,a5,192 # 8000c0c0 <memend+0xf800c0c0>
80000c80:	4f4000ef          	jal	ra,80001174 <printf>
    printf("t1: %d \n",tf->t1);
80000c84:	fec42783          	lw	a5,-20(s0)
80000c88:	0747a783          	lw	a5,116(a5)
80000c8c:	00078593          	mv	a1,a5
80000c90:	8000c7b7          	lui	a5,0x8000c
80000c94:	0cc78513          	addi	a0,a5,204 # 8000c0cc <memend+0xf800c0cc>
80000c98:	4dc000ef          	jal	ra,80001174 <printf>
    printf("t2: %d \n",tf->t2);
80000c9c:	fec42783          	lw	a5,-20(s0)
80000ca0:	0787a783          	lw	a5,120(a5)
80000ca4:	00078593          	mv	a1,a5
80000ca8:	8000c7b7          	lui	a5,0x8000c
80000cac:	0d878513          	addi	a0,a5,216 # 8000c0d8 <memend+0xf800c0d8>
80000cb0:	4c4000ef          	jal	ra,80001174 <printf>
    printf("t3: %d \n",tf->t3);
80000cb4:	fec42783          	lw	a5,-20(s0)
80000cb8:	07c7a783          	lw	a5,124(a5)
80000cbc:	00078593          	mv	a1,a5
80000cc0:	8000c7b7          	lui	a5,0x8000c
80000cc4:	0e478513          	addi	a0,a5,228 # 8000c0e4 <memend+0xf800c0e4>
80000cc8:	4ac000ef          	jal	ra,80001174 <printf>
    printf("t4: %d \n",tf->t4);
80000ccc:	fec42783          	lw	a5,-20(s0)
80000cd0:	0807a783          	lw	a5,128(a5)
80000cd4:	00078593          	mv	a1,a5
80000cd8:	8000c7b7          	lui	a5,0x8000c
80000cdc:	0f078513          	addi	a0,a5,240 # 8000c0f0 <memend+0xf800c0f0>
80000ce0:	494000ef          	jal	ra,80001174 <printf>
    printf("t5: %d \n",tf->t5);
80000ce4:	fec42783          	lw	a5,-20(s0)
80000ce8:	0847a783          	lw	a5,132(a5)
80000cec:	00078593          	mv	a1,a5
80000cf0:	8000c7b7          	lui	a5,0x8000c
80000cf4:	0fc78513          	addi	a0,a5,252 # 8000c0fc <memend+0xf800c0fc>
80000cf8:	47c000ef          	jal	ra,80001174 <printf>
    printf("t6: %d \n",tf->t6);
80000cfc:	fec42783          	lw	a5,-20(s0)
80000d00:	0887a783          	lw	a5,136(a5)
80000d04:	00078593          	mv	a1,a5
80000d08:	8000c7b7          	lui	a5,0x8000c
80000d0c:	10878513          	addi	a0,a5,264 # 8000c108 <memend+0xf800c108>
80000d10:	464000ef          	jal	ra,80001174 <printf>
    printf("a0: %d \n",tf->a0);
80000d14:	fec42783          	lw	a5,-20(s0)
80000d18:	0207a783          	lw	a5,32(a5)
80000d1c:	00078593          	mv	a1,a5
80000d20:	8000c7b7          	lui	a5,0x8000c
80000d24:	11478513          	addi	a0,a5,276 # 8000c114 <memend+0xf800c114>
80000d28:	44c000ef          	jal	ra,80001174 <printf>
    printf("a1: %d \n",tf->a1);
80000d2c:	fec42783          	lw	a5,-20(s0)
80000d30:	0247a783          	lw	a5,36(a5)
80000d34:	00078593          	mv	a1,a5
80000d38:	8000c7b7          	lui	a5,0x8000c
80000d3c:	12078513          	addi	a0,a5,288 # 8000c120 <memend+0xf800c120>
80000d40:	434000ef          	jal	ra,80001174 <printf>
    printf("a2: %d \n",tf->a2);
80000d44:	fec42783          	lw	a5,-20(s0)
80000d48:	0287a783          	lw	a5,40(a5)
80000d4c:	00078593          	mv	a1,a5
80000d50:	8000c7b7          	lui	a5,0x8000c
80000d54:	12c78513          	addi	a0,a5,300 # 8000c12c <memend+0xf800c12c>
80000d58:	41c000ef          	jal	ra,80001174 <printf>
    printf("a3: %d \n",tf->a3);
80000d5c:	fec42783          	lw	a5,-20(s0)
80000d60:	02c7a783          	lw	a5,44(a5)
80000d64:	00078593          	mv	a1,a5
80000d68:	8000c7b7          	lui	a5,0x8000c
80000d6c:	13878513          	addi	a0,a5,312 # 8000c138 <memend+0xf800c138>
80000d70:	404000ef          	jal	ra,80001174 <printf>
    printf("a4: %d \n",tf->a4);
80000d74:	fec42783          	lw	a5,-20(s0)
80000d78:	0307a783          	lw	a5,48(a5)
80000d7c:	00078593          	mv	a1,a5
80000d80:	8000c7b7          	lui	a5,0x8000c
80000d84:	14478513          	addi	a0,a5,324 # 8000c144 <memend+0xf800c144>
80000d88:	3ec000ef          	jal	ra,80001174 <printf>
    printf("a5: %d \n",tf->a5);
80000d8c:	fec42783          	lw	a5,-20(s0)
80000d90:	0347a783          	lw	a5,52(a5)
80000d94:	00078593          	mv	a1,a5
80000d98:	8000c7b7          	lui	a5,0x8000c
80000d9c:	15078513          	addi	a0,a5,336 # 8000c150 <memend+0xf800c150>
80000da0:	3d4000ef          	jal	ra,80001174 <printf>
    printf("a6: %d \n",tf->a6);
80000da4:	fec42783          	lw	a5,-20(s0)
80000da8:	0387a783          	lw	a5,56(a5)
80000dac:	00078593          	mv	a1,a5
80000db0:	8000c7b7          	lui	a5,0x8000c
80000db4:	15c78513          	addi	a0,a5,348 # 8000c15c <memend+0xf800c15c>
80000db8:	3bc000ef          	jal	ra,80001174 <printf>
    printf("a7: %d \n",tf->a7);
80000dbc:	fec42783          	lw	a5,-20(s0)
80000dc0:	03c7a783          	lw	a5,60(a5)
80000dc4:	00078593          	mv	a1,a5
80000dc8:	8000c7b7          	lui	a5,0x8000c
80000dcc:	16878513          	addi	a0,a5,360 # 8000c168 <memend+0xf800c168>
80000dd0:	3a4000ef          	jal	ra,80001174 <printf>
}
80000dd4:	00000013          	nop
80000dd8:	01c12083          	lw	ra,28(sp)
80000ddc:	01812403          	lw	s0,24(sp)
80000de0:	02010113          	addi	sp,sp,32
80000de4:	00008067          	ret

80000de8 <usertrapret>:

// 返回用户空间
void usertrapret(){
80000de8:	fe010113          	addi	sp,sp,-32
80000dec:	00112e23          	sw	ra,28(sp)
80000df0:	00812c23          	sw	s0,24(sp)
80000df4:	00912a23          	sw	s1,20(sp)
80000df8:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80000dfc:	1b0010ef          	jal	ra,80001fac <nowproc>
80000e00:	fea42623          	sw	a0,-20(s0)
    s_sstatus_xpp(RISCV_U);
80000e04:	00000513          	li	a0,0
80000e08:	bbdff0ef          	jal	ra,800009c4 <s_sstatus_xpp>
    w_stvec((uint32)usertrap);
80000e0c:	800007b7          	lui	a5,0x80000
80000e10:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80000e14:	00078513          	mv	a0,a5
80000e18:	c79ff0ef          	jal	ra,80000a90 <w_stvec>
    addr_t satp=(SATP_SV32|(addr_t)(p->pagetable)>>12);
80000e1c:	fec42783          	lw	a5,-20(s0)
80000e20:	0887a783          	lw	a5,136(a5)
80000e24:	00c7d713          	srli	a4,a5,0xc
80000e28:	800007b7          	lui	a5,0x80000
80000e2c:	00f767b3          	or	a5,a4,a5
80000e30:	fef42423          	sw	a5,-24(s0)
    ptf(p->trapframe);
80000e34:	fec42783          	lw	a5,-20(s0)
80000e38:	0087a783          	lw	a5,8(a5) # 80000008 <memend+0xf8000008>
80000e3c:	00078513          	mv	a0,a5
80000e40:	d89ff0ef          	jal	ra,80000bc8 <ptf>
    printf("%p\n",p->trapframe);
80000e44:	fec42783          	lw	a5,-20(s0)
80000e48:	0087a783          	lw	a5,8(a5)
80000e4c:	00078593          	mv	a1,a5
80000e50:	8000c7b7          	lui	a5,0x8000c
80000e54:	17478513          	addi	a0,a5,372 # 8000c174 <memend+0xf800c174>
80000e58:	31c000ef          	jal	ra,80001174 <printf>
    w_sepc((addr_t)p->trapframe->epc);
80000e5c:	fec42783          	lw	a5,-20(s0)
80000e60:	0087a783          	lw	a5,8(a5)
80000e64:	00c7a783          	lw	a5,12(a5)
80000e68:	00078513          	mv	a0,a5
80000e6c:	bfdff0ef          	jal	ra,80000a68 <w_sepc>
    p->trapframe->kernel_satp=r_satp();
80000e70:	fec42783          	lw	a5,-20(s0)
80000e74:	0087a483          	lw	s1,8(a5)
80000e78:	c41ff0ef          	jal	ra,80000ab8 <r_satp>
80000e7c:	00050793          	mv	a5,a0
80000e80:	00f4a023          	sw	a5,0(s1)
    p->trapframe->kernel_tvec=(addr_t)trapvec;
80000e84:	fec42783          	lw	a5,-20(s0)
80000e88:	0087a783          	lw	a5,8(a5)
80000e8c:	80001737          	lui	a4,0x80001
80000e90:	f7070713          	addi	a4,a4,-144 # 80000f70 <memend+0xf8000f70>
80000e94:	00e7a223          	sw	a4,4(a5)
    p->trapframe->kernel_sp=(addr_t)p->kernelstack;
80000e98:	fec42783          	lw	a5,-20(s0)
80000e9c:	0087a783          	lw	a5,8(a5)
80000ea0:	fec42703          	lw	a4,-20(s0)
80000ea4:	08c72703          	lw	a4,140(a4)
80000ea8:	00e7a423          	sw	a4,8(a5)
    printf("%p\n",p->kernelstack);
80000eac:	fec42783          	lw	a5,-20(s0)
80000eb0:	08c7a783          	lw	a5,140(a5)
80000eb4:	00078593          	mv	a1,a5
80000eb8:	8000c7b7          	lui	a5,0x8000c
80000ebc:	17478513          	addi	a0,a5,372 # 8000c174 <memend+0xf800c174>
80000ec0:	2b4000ef          	jal	ra,80001174 <printf>
    userret((addr_t*)TRAPFRAME,satp);
80000ec4:	fe842583          	lw	a1,-24(s0)
80000ec8:	ffffe537          	lui	a0,0xffffe
80000ecc:	c64ff0ef          	jal	ra,80000330 <userret>
}
80000ed0:	00000013          	nop
80000ed4:	01c12083          	lw	ra,28(sp)
80000ed8:	01812403          	lw	s0,24(sp)
80000edc:	01412483          	lw	s1,20(sp)
80000ee0:	02010113          	addi	sp,sp,32
80000ee4:	00008067          	ret

80000ee8 <zero>:

void zero(){
80000ee8:	fe010113          	addi	sp,sp,-32
80000eec:	00112e23          	sw	ra,28(sp)
80000ef0:	00812c23          	sw	s0,24(sp)
80000ef4:	02010413          	addi	s0,sp,32
    printf("zero\n");
80000ef8:	8000c7b7          	lui	a5,0x8000c
80000efc:	17878513          	addi	a0,a5,376 # 8000c178 <memend+0xf800c178>
80000f00:	274000ef          	jal	ra,80001174 <printf>
    reg_t pc=r_sepc();
80000f04:	b3dff0ef          	jal	ra,80000a40 <r_sepc>
80000f08:	fea42623          	sw	a0,-20(s0)
    w_sepc(pc+4);
80000f0c:	fec42783          	lw	a5,-20(s0)
80000f10:	00478793          	addi	a5,a5,4
80000f14:	00078513          	mv	a0,a5
80000f18:	b51ff0ef          	jal	ra,80000a68 <w_sepc>
    usertrapret();
80000f1c:	ecdff0ef          	jal	ra,80000de8 <usertrapret>
}
80000f20:	00000013          	nop
80000f24:	01c12083          	lw	ra,28(sp)
80000f28:	01812403          	lw	s0,24(sp)
80000f2c:	02010113          	addi	sp,sp,32
80000f30:	00008067          	ret

80000f34 <timerintr>:

void timerintr(){
80000f34:	ff010113          	addi	sp,sp,-16
80000f38:	00112623          	sw	ra,12(sp)
80000f3c:	00812423          	sw	s0,8(sp)
80000f40:	01010413          	addi	s0,sp,16
    w_sip(r_sip()& ~2); // 清除中断
80000f44:	bc5ff0ef          	jal	ra,80000b08 <r_sip>
80000f48:	00050793          	mv	a5,a0
80000f4c:	ffd7f793          	andi	a5,a5,-3
80000f50:	00078513          	mv	a0,a5
80000f54:	bddff0ef          	jal	ra,80000b30 <w_sip>
    yield();
80000f58:	368010ef          	jal	ra,800022c0 <yield>
}
80000f5c:	00000013          	nop
80000f60:	00c12083          	lw	ra,12(sp)
80000f64:	00812403          	lw	s0,8(sp)
80000f68:	01010113          	addi	sp,sp,16
80000f6c:	00008067          	ret

80000f70 <trapvec>:

void trapvec(){
80000f70:	fe010113          	addi	sp,sp,-32
80000f74:	00112e23          	sw	ra,28(sp)
80000f78:	00812c23          	sw	s0,24(sp)
80000f7c:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000f80:	b61ff0ef          	jal	ra,80000ae0 <r_scause>
80000f84:	fea42623          	sw	a0,-20(s0)

    uint16 code= scause & 0xffff;
80000f88:	fec42783          	lw	a5,-20(s0)
80000f8c:	fef41523          	sh	a5,-22(s0)

    if(scause & (1<<31)){
80000f90:	fec42783          	lw	a5,-20(s0)
80000f94:	0607d463          	bgez	a5,80000ffc <trapvec+0x8c>
    //     printf("Interrupt : ");
        switch (code)
80000f98:	fea45783          	lhu	a5,-22(s0)
80000f9c:	00900713          	li	a4,9
80000fa0:	02e78c63          	beq	a5,a4,80000fd8 <trapvec+0x68>
80000fa4:	00900713          	li	a4,9
80000fa8:	04f74263          	blt	a4,a5,80000fec <trapvec+0x7c>
80000fac:	00100713          	li	a4,1
80000fb0:	00e78863          	beq	a5,a4,80000fc0 <trapvec+0x50>
80000fb4:	00500713          	li	a4,5
80000fb8:	00e78863          	beq	a5,a4,80000fc8 <trapvec+0x58>
80000fbc:	0300006f          	j	80000fec <trapvec+0x7c>
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
80000fc0:	f75ff0ef          	jal	ra,80000f34 <timerintr>
            break;
80000fc4:	1640006f          	j	80001128 <trapvec+0x1b8>
        case 5:
            printf("Supervisor timer interrupt\n");
80000fc8:	8000c7b7          	lui	a5,0x8000c
80000fcc:	18078513          	addi	a0,a5,384 # 8000c180 <memend+0xf800c180>
80000fd0:	1a4000ef          	jal	ra,80001174 <printf>
            break;
80000fd4:	1540006f          	j	80001128 <trapvec+0x1b8>
        case 9:
            printf("Supervisor external interrupt\n");
80000fd8:	8000c7b7          	lui	a5,0x8000c
80000fdc:	19c78513          	addi	a0,a5,412 # 8000c19c <memend+0xf800c19c>
80000fe0:	194000ef          	jal	ra,80001174 <printf>
            externinterrupt();
80000fe4:	b75ff0ef          	jal	ra,80000b58 <externinterrupt>
            break;
80000fe8:	1400006f          	j	80001128 <trapvec+0x1b8>
        default:
            printf("Other interrupt\n");
80000fec:	8000c7b7          	lui	a5,0x8000c
80000ff0:	1bc78513          	addi	a0,a5,444 # 8000c1bc <memend+0xf800c1bc>
80000ff4:	180000ef          	jal	ra,80001174 <printf>
            break;
80000ff8:	1300006f          	j	80001128 <trapvec+0x1b8>
        }
    }else{
        printf("Exception : ");
80000ffc:	8000c7b7          	lui	a5,0x8000c
80001000:	1d078513          	addi	a0,a5,464 # 8000c1d0 <memend+0xf800c1d0>
80001004:	170000ef          	jal	ra,80001174 <printf>
        switch (code)
80001008:	fea45783          	lhu	a5,-22(s0)
8000100c:	00f00713          	li	a4,15
80001010:	0ef76c63          	bltu	a4,a5,80001108 <trapvec+0x198>
80001014:	00279713          	slli	a4,a5,0x2
80001018:	8000c7b7          	lui	a5,0x8000c
8000101c:	34478793          	addi	a5,a5,836 # 8000c344 <memend+0xf800c344>
80001020:	00f707b3          	add	a5,a4,a5
80001024:	0007a783          	lw	a5,0(a5)
80001028:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
8000102c:	8000c7b7          	lui	a5,0x8000c
80001030:	1e078513          	addi	a0,a5,480 # 8000c1e0 <memend+0xf800c1e0>
80001034:	140000ef          	jal	ra,80001174 <printf>
            break;
80001038:	0e00006f          	j	80001118 <trapvec+0x1a8>
        case 1:
            printf("Instruction access fault\n");
8000103c:	8000c7b7          	lui	a5,0x8000c
80001040:	20078513          	addi	a0,a5,512 # 8000c200 <memend+0xf800c200>
80001044:	130000ef          	jal	ra,80001174 <printf>
            break;
80001048:	0d00006f          	j	80001118 <trapvec+0x1a8>
        case 2:
            printf("Illegal instruction\n");
8000104c:	8000c7b7          	lui	a5,0x8000c
80001050:	21c78513          	addi	a0,a5,540 # 8000c21c <memend+0xf800c21c>
80001054:	120000ef          	jal	ra,80001174 <printf>
            break;
80001058:	0c00006f          	j	80001118 <trapvec+0x1a8>
        case 3:
            printf("Breakpoint\n");
8000105c:	8000c7b7          	lui	a5,0x8000c
80001060:	23478513          	addi	a0,a5,564 # 8000c234 <memend+0xf800c234>
80001064:	110000ef          	jal	ra,80001174 <printf>
            break;
80001068:	0b00006f          	j	80001118 <trapvec+0x1a8>
        case 4:
            printf("Load address misaligned\n");
8000106c:	8000c7b7          	lui	a5,0x8000c
80001070:	24078513          	addi	a0,a5,576 # 8000c240 <memend+0xf800c240>
80001074:	100000ef          	jal	ra,80001174 <printf>
            break;
80001078:	0a00006f          	j	80001118 <trapvec+0x1a8>
        case 5:
            printf("Load access fault\n");
8000107c:	8000c7b7          	lui	a5,0x8000c
80001080:	25c78513          	addi	a0,a5,604 # 8000c25c <memend+0xf800c25c>
80001084:	0f0000ef          	jal	ra,80001174 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80001088:	0900006f          	j	80001118 <trapvec+0x1a8>
        case 6:
            printf("Store/AMO address misaligned\n");
8000108c:	8000c7b7          	lui	a5,0x8000c
80001090:	27078513          	addi	a0,a5,624 # 8000c270 <memend+0xf800c270>
80001094:	0e0000ef          	jal	ra,80001174 <printf>
            break;
80001098:	0800006f          	j	80001118 <trapvec+0x1a8>
        case 7:
            printf("Store/AMO access fault\n");
8000109c:	8000c7b7          	lui	a5,0x8000c
800010a0:	29078513          	addi	a0,a5,656 # 8000c290 <memend+0xf800c290>
800010a4:	0d0000ef          	jal	ra,80001174 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
800010a8:	0700006f          	j	80001118 <trapvec+0x1a8>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
800010ac:	8000c7b7          	lui	a5,0x8000c
800010b0:	2a878513          	addi	a0,a5,680 # 8000c2a8 <memend+0xf800c2a8>
800010b4:	0c0000ef          	jal	ra,80001174 <printf>
            syscall();
800010b8:	115010ef          	jal	ra,800029cc <syscall>
            usertrapret();
800010bc:	d2dff0ef          	jal	ra,80000de8 <usertrapret>
            break;
800010c0:	0580006f          	j	80001118 <trapvec+0x1a8>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
800010c4:	8000c7b7          	lui	a5,0x8000c
800010c8:	2c878513          	addi	a0,a5,712 # 8000c2c8 <memend+0xf800c2c8>
800010cc:	0a8000ef          	jal	ra,80001174 <printf>
            zero();
800010d0:	e19ff0ef          	jal	ra,80000ee8 <zero>
            break;
800010d4:	0440006f          	j	80001118 <trapvec+0x1a8>
        case 12:
            printf("Instruction page fault\n");
800010d8:	8000c7b7          	lui	a5,0x8000c
800010dc:	2e878513          	addi	a0,a5,744 # 8000c2e8 <memend+0xf800c2e8>
800010e0:	094000ef          	jal	ra,80001174 <printf>
            break;
800010e4:	0340006f          	j	80001118 <trapvec+0x1a8>
        case 13:
            printf("Load page fault\n");
800010e8:	8000c7b7          	lui	a5,0x8000c
800010ec:	30078513          	addi	a0,a5,768 # 8000c300 <memend+0xf800c300>
800010f0:	084000ef          	jal	ra,80001174 <printf>
            break;
800010f4:	0240006f          	j	80001118 <trapvec+0x1a8>
        case 15:
            printf("Store/AMO page fault\n");
800010f8:	8000c7b7          	lui	a5,0x8000c
800010fc:	31478513          	addi	a0,a5,788 # 8000c314 <memend+0xf800c314>
80001100:	074000ef          	jal	ra,80001174 <printf>
            break;
80001104:	0140006f          	j	80001118 <trapvec+0x1a8>
        default:
            printf("Other\n");
80001108:	8000c7b7          	lui	a5,0x8000c
8000110c:	32c78513          	addi	a0,a5,812 # 8000c32c <memend+0xf800c32c>
80001110:	064000ef          	jal	ra,80001174 <printf>
            break;
80001114:	00000013          	nop
        }
        panic("Trap Exception");
80001118:	8000c7b7          	lui	a5,0x8000c
8000111c:	33478513          	addi	a0,a5,820 # 8000c334 <memend+0xf800c334>
80001120:	01c000ef          	jal	ra,8000113c <panic>
    }
}
80001124:	00000013          	nop
80001128:	00000013          	nop
8000112c:	01c12083          	lw	ra,28(sp)
80001130:	01812403          	lw	s0,24(sp)
80001134:	02010113          	addi	sp,sp,32
80001138:	00008067          	ret

8000113c <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
8000113c:	fe010113          	addi	sp,sp,-32
80001140:	00112e23          	sw	ra,28(sp)
80001144:	00812c23          	sw	s0,24(sp)
80001148:	02010413          	addi	s0,sp,32
8000114c:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80001150:	8000c7b7          	lui	a5,0x8000c
80001154:	38478513          	addi	a0,a5,900 # 8000c384 <memend+0xf800c384>
80001158:	ee8ff0ef          	jal	ra,80000840 <uartputs>
    uartputs(s);
8000115c:	fec42503          	lw	a0,-20(s0)
80001160:	ee0ff0ef          	jal	ra,80000840 <uartputs>
	uartputs("\n");
80001164:	8000c7b7          	lui	a5,0x8000c
80001168:	38c78513          	addi	a0,a5,908 # 8000c38c <memend+0xf800c38c>
8000116c:	ed4ff0ef          	jal	ra,80000840 <uartputs>
    while(1);
80001170:	0000006f          	j	80001170 <panic+0x34>

80001174 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80001174:	f8010113          	addi	sp,sp,-128
80001178:	04112e23          	sw	ra,92(sp)
8000117c:	04812c23          	sw	s0,88(sp)
80001180:	06010413          	addi	s0,sp,96
80001184:	faa42623          	sw	a0,-84(s0)
80001188:	00b42223          	sw	a1,4(s0)
8000118c:	00c42423          	sw	a2,8(s0)
80001190:	00d42623          	sw	a3,12(s0)
80001194:	00e42823          	sw	a4,16(s0)
80001198:	00f42a23          	sw	a5,20(s0)
8000119c:	01042c23          	sw	a6,24(s0)
800011a0:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
800011a4:	02040793          	addi	a5,s0,32
800011a8:	faf42423          	sw	a5,-88(s0)
800011ac:	fa842783          	lw	a5,-88(s0)
800011b0:	fe478793          	addi	a5,a5,-28
800011b4:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
800011b8:	fac42783          	lw	a5,-84(s0)
800011bc:	fef42623          	sw	a5,-20(s0)
	int tt=0;
800011c0:	fe042423          	sw	zero,-24(s0)
	int idx=0;
800011c4:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
800011c8:	36c0006f          	j	80001534 <printf+0x3c0>
		if(ch=='%'){
800011cc:	fbf44703          	lbu	a4,-65(s0)
800011d0:	02500793          	li	a5,37
800011d4:	04f71863          	bne	a4,a5,80001224 <printf+0xb0>
			if(tt==1){
800011d8:	fe842703          	lw	a4,-24(s0)
800011dc:	00100793          	li	a5,1
800011e0:	02f71663          	bne	a4,a5,8000120c <printf+0x98>
				outbuf[idx++]='%';
800011e4:	fe442783          	lw	a5,-28(s0)
800011e8:	00178713          	addi	a4,a5,1
800011ec:	fee42223          	sw	a4,-28(s0)
800011f0:	8000d737          	lui	a4,0x8000d
800011f4:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
800011f8:	00f707b3          	add	a5,a4,a5
800011fc:	02500713          	li	a4,37
80001200:	00e78023          	sb	a4,0(a5)
				tt=0;
80001204:	fe042423          	sw	zero,-24(s0)
80001208:	00c0006f          	j	80001214 <printf+0xa0>
			}else{
				tt=1;
8000120c:	00100793          	li	a5,1
80001210:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80001214:	fec42783          	lw	a5,-20(s0)
80001218:	00178793          	addi	a5,a5,1
8000121c:	fef42623          	sw	a5,-20(s0)
80001220:	3140006f          	j	80001534 <printf+0x3c0>
		}else{
			if(tt==1){
80001224:	fe842703          	lw	a4,-24(s0)
80001228:	00100793          	li	a5,1
8000122c:	2cf71e63          	bne	a4,a5,80001508 <printf+0x394>
				switch (ch)
80001230:	fbf44783          	lbu	a5,-65(s0)
80001234:	fa878793          	addi	a5,a5,-88
80001238:	02000713          	li	a4,32
8000123c:	2af76663          	bltu	a4,a5,800014e8 <printf+0x374>
80001240:	00279713          	slli	a4,a5,0x2
80001244:	8000c7b7          	lui	a5,0x8000c
80001248:	3a878793          	addi	a5,a5,936 # 8000c3a8 <memend+0xf800c3a8>
8000124c:	00f707b3          	add	a5,a4,a5
80001250:	0007a783          	lw	a5,0(a5)
80001254:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80001258:	fb842783          	lw	a5,-72(s0)
8000125c:	00478713          	addi	a4,a5,4
80001260:	fae42c23          	sw	a4,-72(s0)
80001264:	0007a783          	lw	a5,0(a5)
80001268:	fef42023          	sw	a5,-32(s0)
					int len=0;
8000126c:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80001270:	fe042783          	lw	a5,-32(s0)
80001274:	fcf42c23          	sw	a5,-40(s0)
80001278:	0100006f          	j	80001288 <printf+0x114>
8000127c:	fdc42783          	lw	a5,-36(s0)
80001280:	00178793          	addi	a5,a5,1
80001284:	fcf42e23          	sw	a5,-36(s0)
80001288:	fd842703          	lw	a4,-40(s0)
8000128c:	00a00793          	li	a5,10
80001290:	02f747b3          	div	a5,a4,a5
80001294:	fcf42c23          	sw	a5,-40(s0)
80001298:	fd842783          	lw	a5,-40(s0)
8000129c:	fe0790e3          	bnez	a5,8000127c <printf+0x108>
					for(int i=len;i>=0;i--){
800012a0:	fdc42783          	lw	a5,-36(s0)
800012a4:	fcf42a23          	sw	a5,-44(s0)
800012a8:	0540006f          	j	800012fc <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
800012ac:	fe042703          	lw	a4,-32(s0)
800012b0:	00a00793          	li	a5,10
800012b4:	02f767b3          	rem	a5,a4,a5
800012b8:	0ff7f713          	andi	a4,a5,255
800012bc:	fe442683          	lw	a3,-28(s0)
800012c0:	fd442783          	lw	a5,-44(s0)
800012c4:	00f687b3          	add	a5,a3,a5
800012c8:	03070713          	addi	a4,a4,48
800012cc:	0ff77713          	andi	a4,a4,255
800012d0:	8000d6b7          	lui	a3,0x8000d
800012d4:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
800012d8:	00f687b3          	add	a5,a3,a5
800012dc:	00e78023          	sb	a4,0(a5)
						x/=10;
800012e0:	fe042703          	lw	a4,-32(s0)
800012e4:	00a00793          	li	a5,10
800012e8:	02f747b3          	div	a5,a4,a5
800012ec:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
800012f0:	fd442783          	lw	a5,-44(s0)
800012f4:	fff78793          	addi	a5,a5,-1
800012f8:	fcf42a23          	sw	a5,-44(s0)
800012fc:	fd442783          	lw	a5,-44(s0)
80001300:	fa07d6e3          	bgez	a5,800012ac <printf+0x138>
					}
					idx+=(len+1);
80001304:	fdc42783          	lw	a5,-36(s0)
80001308:	00178793          	addi	a5,a5,1
8000130c:	fe442703          	lw	a4,-28(s0)
80001310:	00f707b3          	add	a5,a4,a5
80001314:	fef42223          	sw	a5,-28(s0)
					tt=0;
80001318:	fe042423          	sw	zero,-24(s0)
					break;
8000131c:	1dc0006f          	j	800014f8 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80001320:	fe442783          	lw	a5,-28(s0)
80001324:	00178713          	addi	a4,a5,1
80001328:	fee42223          	sw	a4,-28(s0)
8000132c:	8000d737          	lui	a4,0x8000d
80001330:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001334:	00f707b3          	add	a5,a4,a5
80001338:	03000713          	li	a4,48
8000133c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80001340:	fe442783          	lw	a5,-28(s0)
80001344:	00178713          	addi	a4,a5,1
80001348:	fee42223          	sw	a4,-28(s0)
8000134c:	8000d737          	lui	a4,0x8000d
80001350:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80001354:	00f707b3          	add	a5,a4,a5
80001358:	07800713          	li	a4,120
8000135c:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80001360:	fb842783          	lw	a5,-72(s0)
80001364:	00478713          	addi	a4,a5,4
80001368:	fae42c23          	sw	a4,-72(s0)
8000136c:	0007a783          	lw	a5,0(a5)
80001370:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80001374:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80001378:	fd042783          	lw	a5,-48(s0)
8000137c:	fcf42423          	sw	a5,-56(s0)
80001380:	0100006f          	j	80001390 <printf+0x21c>
80001384:	fcc42783          	lw	a5,-52(s0)
80001388:	00178793          	addi	a5,a5,1
8000138c:	fcf42623          	sw	a5,-52(s0)
80001390:	fc842783          	lw	a5,-56(s0)
80001394:	0047d793          	srli	a5,a5,0x4
80001398:	fcf42423          	sw	a5,-56(s0)
8000139c:	fc842783          	lw	a5,-56(s0)
800013a0:	fe0792e3          	bnez	a5,80001384 <printf+0x210>
					for(int i=len;i>=0;i--){
800013a4:	fcc42783          	lw	a5,-52(s0)
800013a8:	fcf42223          	sw	a5,-60(s0)
800013ac:	0840006f          	j	80001430 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
800013b0:	fd042783          	lw	a5,-48(s0)
800013b4:	00f7f713          	andi	a4,a5,15
800013b8:	00900793          	li	a5,9
800013bc:	02e7f063          	bgeu	a5,a4,800013dc <printf+0x268>
800013c0:	fd042783          	lw	a5,-48(s0)
800013c4:	0ff7f793          	andi	a5,a5,255
800013c8:	00f7f793          	andi	a5,a5,15
800013cc:	0ff7f793          	andi	a5,a5,255
800013d0:	05778793          	addi	a5,a5,87
800013d4:	0ff7f793          	andi	a5,a5,255
800013d8:	01c0006f          	j	800013f4 <printf+0x280>
800013dc:	fd042783          	lw	a5,-48(s0)
800013e0:	0ff7f793          	andi	a5,a5,255
800013e4:	00f7f793          	andi	a5,a5,15
800013e8:	0ff7f793          	andi	a5,a5,255
800013ec:	03078793          	addi	a5,a5,48
800013f0:	0ff7f793          	andi	a5,a5,255
800013f4:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
800013f8:	fe442703          	lw	a4,-28(s0)
800013fc:	fc442783          	lw	a5,-60(s0)
80001400:	00f707b3          	add	a5,a4,a5
80001404:	8000d737          	lui	a4,0x8000d
80001408:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
8000140c:	00f707b3          	add	a5,a4,a5
80001410:	fbe44703          	lbu	a4,-66(s0)
80001414:	00e78023          	sb	a4,0(a5)
						x/=16;
80001418:	fd042783          	lw	a5,-48(s0)
8000141c:	0047d793          	srli	a5,a5,0x4
80001420:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80001424:	fc442783          	lw	a5,-60(s0)
80001428:	fff78793          	addi	a5,a5,-1
8000142c:	fcf42223          	sw	a5,-60(s0)
80001430:	fc442783          	lw	a5,-60(s0)
80001434:	f607dee3          	bgez	a5,800013b0 <printf+0x23c>
					}
					idx+=(len+1);
80001438:	fcc42783          	lw	a5,-52(s0)
8000143c:	00178793          	addi	a5,a5,1
80001440:	fe442703          	lw	a4,-28(s0)
80001444:	00f707b3          	add	a5,a4,a5
80001448:	fef42223          	sw	a5,-28(s0)
					tt=0;
8000144c:	fe042423          	sw	zero,-24(s0)
					break;
80001450:	0a80006f          	j	800014f8 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80001454:	fb842783          	lw	a5,-72(s0)
80001458:	00478713          	addi	a4,a5,4
8000145c:	fae42c23          	sw	a4,-72(s0)
80001460:	0007a783          	lw	a5,0(a5)
80001464:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80001468:	fe442783          	lw	a5,-28(s0)
8000146c:	00178713          	addi	a4,a5,1
80001470:	fee42223          	sw	a4,-28(s0)
80001474:	8000d737          	lui	a4,0x8000d
80001478:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
8000147c:	00f707b3          	add	a5,a4,a5
80001480:	fbf44703          	lbu	a4,-65(s0)
80001484:	00e78023          	sb	a4,0(a5)
					tt=0;
80001488:	fe042423          	sw	zero,-24(s0)
					break;
8000148c:	06c0006f          	j	800014f8 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80001490:	fb842783          	lw	a5,-72(s0)
80001494:	00478713          	addi	a4,a5,4
80001498:	fae42c23          	sw	a4,-72(s0)
8000149c:	0007a783          	lw	a5,0(a5)
800014a0:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
800014a4:	0300006f          	j	800014d4 <printf+0x360>
						outbuf[idx++]=*ss++;
800014a8:	fc042703          	lw	a4,-64(s0)
800014ac:	00170793          	addi	a5,a4,1
800014b0:	fcf42023          	sw	a5,-64(s0)
800014b4:	fe442783          	lw	a5,-28(s0)
800014b8:	00178693          	addi	a3,a5,1
800014bc:	fed42223          	sw	a3,-28(s0)
800014c0:	00074703          	lbu	a4,0(a4)
800014c4:	8000d6b7          	lui	a3,0x8000d
800014c8:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
800014cc:	00f687b3          	add	a5,a3,a5
800014d0:	00e78023          	sb	a4,0(a5)
					while(*ss){
800014d4:	fc042783          	lw	a5,-64(s0)
800014d8:	0007c783          	lbu	a5,0(a5)
800014dc:	fc0796e3          	bnez	a5,800014a8 <printf+0x334>
					}
					tt=0;
800014e0:	fe042423          	sw	zero,-24(s0)
					break;
800014e4:	0140006f          	j	800014f8 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
800014e8:	8000c7b7          	lui	a5,0x8000c
800014ec:	39078513          	addi	a0,a5,912 # 8000c390 <memend+0xf800c390>
800014f0:	c4dff0ef          	jal	ra,8000113c <panic>
					break;
800014f4:	00000013          	nop
				}
				s++;
800014f8:	fec42783          	lw	a5,-20(s0)
800014fc:	00178793          	addi	a5,a5,1
80001500:	fef42623          	sw	a5,-20(s0)
80001504:	0300006f          	j	80001534 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80001508:	fe442783          	lw	a5,-28(s0)
8000150c:	00178713          	addi	a4,a5,1
80001510:	fee42223          	sw	a4,-28(s0)
80001514:	8000d737          	lui	a4,0x8000d
80001518:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
8000151c:	00f707b3          	add	a5,a4,a5
80001520:	fbf44703          	lbu	a4,-65(s0)
80001524:	00e78023          	sb	a4,0(a5)
				s++;
80001528:	fec42783          	lw	a5,-20(s0)
8000152c:	00178793          	addi	a5,a5,1
80001530:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
80001534:	fec42783          	lw	a5,-20(s0)
80001538:	0007c783          	lbu	a5,0(a5)
8000153c:	faf40fa3          	sb	a5,-65(s0)
80001540:	fbf44783          	lbu	a5,-65(s0)
80001544:	c80794e3          	bnez	a5,800011cc <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80001548:	8000d7b7          	lui	a5,0x8000d
8000154c:	00478713          	addi	a4,a5,4 # 8000d004 <memend+0xf800d004>
80001550:	fe442783          	lw	a5,-28(s0)
80001554:	00f707b3          	add	a5,a4,a5
80001558:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
8000155c:	8000d7b7          	lui	a5,0x8000d
80001560:	00478513          	addi	a0,a5,4 # 8000d004 <memend+0xf800d004>
80001564:	adcff0ef          	jal	ra,80000840 <uartputs>
	return idx;
80001568:	fe442783          	lw	a5,-28(s0)
8000156c:	00078513          	mv	a0,a5
80001570:	05c12083          	lw	ra,92(sp)
80001574:	05812403          	lw	s0,88(sp)
80001578:	08010113          	addi	sp,sp,128
8000157c:	00008067          	ret

80001580 <minit>:
struct
{
    struct pmp* freelist;
}mem;
#define _DEBUG
void minit(){
80001580:	fe010113          	addi	sp,sp,-32
80001584:	00112e23          	sw	ra,28(sp)
80001588:	00812c23          	sw	s0,24(sp)
8000158c:	02010413          	addi	s0,sp,32
    #ifdef _DEBUG
        printf("textstart:%p    ",textstart);
80001590:	800007b7          	lui	a5,0x80000
80001594:	00078593          	mv	a1,a5
80001598:	8000c7b7          	lui	a5,0x8000c
8000159c:	42c78513          	addi	a0,a5,1068 # 8000c42c <memend+0xf800c42c>
800015a0:	bd5ff0ef          	jal	ra,80001174 <printf>
        printf("textend:%p\n",textend);
800015a4:	800037b7          	lui	a5,0x80003
800015a8:	a0878593          	addi	a1,a5,-1528 # 80002a08 <memend+0xf8002a08>
800015ac:	8000c7b7          	lui	a5,0x8000c
800015b0:	44078513          	addi	a0,a5,1088 # 8000c440 <memend+0xf800c440>
800015b4:	bc1ff0ef          	jal	ra,80001174 <printf>
        printf("datastart:%p    ",datastart);
800015b8:	800037b7          	lui	a5,0x80003
800015bc:	00078593          	mv	a1,a5
800015c0:	8000c7b7          	lui	a5,0x8000c
800015c4:	44c78513          	addi	a0,a5,1100 # 8000c44c <memend+0xf800c44c>
800015c8:	badff0ef          	jal	ra,80001174 <printf>
        printf("dataend:%p\n",dataend);
800015cc:	8000b7b7          	lui	a5,0x8000b
800015d0:	00c78593          	addi	a1,a5,12 # 8000b00c <memend+0xf800b00c>
800015d4:	8000c7b7          	lui	a5,0x8000c
800015d8:	46078513          	addi	a0,a5,1120 # 8000c460 <memend+0xf800c460>
800015dc:	b99ff0ef          	jal	ra,80001174 <printf>
        printf("rodatastart:%p  ",rodatastart);
800015e0:	8000c7b7          	lui	a5,0x8000c
800015e4:	00078593          	mv	a1,a5
800015e8:	8000c7b7          	lui	a5,0x8000c
800015ec:	46c78513          	addi	a0,a5,1132 # 8000c46c <memend+0xf800c46c>
800015f0:	b85ff0ef          	jal	ra,80001174 <printf>
        printf("rodataend:%p\n",rodataend);
800015f4:	8000c7b7          	lui	a5,0x8000c
800015f8:	52678593          	addi	a1,a5,1318 # 8000c526 <memend+0xf800c526>
800015fc:	8000c7b7          	lui	a5,0x8000c
80001600:	48078513          	addi	a0,a5,1152 # 8000c480 <memend+0xf800c480>
80001604:	b71ff0ef          	jal	ra,80001174 <printf>
        printf("bssstart:%p     ",bssstart);
80001608:	8000d7b7          	lui	a5,0x8000d
8000160c:	00078593          	mv	a1,a5
80001610:	8000c7b7          	lui	a5,0x8000c
80001614:	49078513          	addi	a0,a5,1168 # 8000c490 <memend+0xf800c490>
80001618:	b5dff0ef          	jal	ra,80001174 <printf>
        printf("bssend:%p\n",bssend);
8000161c:	8000e7b7          	lui	a5,0x8000e
80001620:	b9078593          	addi	a1,a5,-1136 # 8000db90 <memend+0xf800db90>
80001624:	8000c7b7          	lui	a5,0x8000c
80001628:	4a478513          	addi	a0,a5,1188 # 8000c4a4 <memend+0xf800c4a4>
8000162c:	b49ff0ef          	jal	ra,80001174 <printf>
        printf("mstart:%p   ",mstart);
80001630:	8000e7b7          	lui	a5,0x8000e
80001634:	00078593          	mv	a1,a5
80001638:	8000c7b7          	lui	a5,0x8000c
8000163c:	4b078513          	addi	a0,a5,1200 # 8000c4b0 <memend+0xf800c4b0>
80001640:	b35ff0ef          	jal	ra,80001174 <printf>
        printf("mend:%p\n",mend);
80001644:	880007b7          	lui	a5,0x88000
80001648:	00078593          	mv	a1,a5
8000164c:	8000c7b7          	lui	a5,0x8000c
80001650:	4c078513          	addi	a0,a5,1216 # 8000c4c0 <memend+0xf800c4c0>
80001654:	b21ff0ef          	jal	ra,80001174 <printf>
        printf("stack:%p\n",stacks);
80001658:	800037b7          	lui	a5,0x80003
8000165c:	00078593          	mv	a1,a5
80001660:	8000c7b7          	lui	a5,0x8000c
80001664:	4cc78513          	addi	a0,a5,1228 # 8000c4cc <memend+0xf800c4cc>
80001668:	b0dff0ef          	jal	ra,80001174 <printf>
    #endif

    char* p=(char*)mstart;
8000166c:	8000e7b7          	lui	a5,0x8000e
80001670:	00078793          	mv	a5,a5
80001674:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001678:	0380006f          	j	800016b0 <minit+0x130>
        m=(struct pmp*)p;
8000167c:	fec42783          	lw	a5,-20(s0)
80001680:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
80001684:	8000e7b7          	lui	a5,0x8000e
80001688:	a447a703          	lw	a4,-1468(a5) # 8000da44 <memend+0xf800da44>
8000168c:	fe842783          	lw	a5,-24(s0)
80001690:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
80001694:	8000e7b7          	lui	a5,0x8000e
80001698:	fe842703          	lw	a4,-24(s0)
8000169c:	a4e7a223          	sw	a4,-1468(a5) # 8000da44 <memend+0xf800da44>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800016a0:	fec42703          	lw	a4,-20(s0)
800016a4:	000017b7          	lui	a5,0x1
800016a8:	00f707b3          	add	a5,a4,a5
800016ac:	fef42623          	sw	a5,-20(s0)
800016b0:	fec42703          	lw	a4,-20(s0)
800016b4:	000017b7          	lui	a5,0x1
800016b8:	00f70733          	add	a4,a4,a5
800016bc:	880007b7          	lui	a5,0x88000
800016c0:	00078793          	mv	a5,a5
800016c4:	fae7fce3          	bgeu	a5,a4,8000167c <minit+0xfc>
    }
}
800016c8:	00000013          	nop
800016cc:	00000013          	nop
800016d0:	01c12083          	lw	ra,28(sp)
800016d4:	01812403          	lw	s0,24(sp)
800016d8:	02010113          	addi	sp,sp,32
800016dc:	00008067          	ret

800016e0 <palloc>:

void* palloc(){
800016e0:	fe010113          	addi	sp,sp,-32
800016e4:	00112e23          	sw	ra,28(sp)
800016e8:	00812c23          	sw	s0,24(sp)
800016ec:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
800016f0:	8000e7b7          	lui	a5,0x8000e
800016f4:	a447a783          	lw	a5,-1468(a5) # 8000da44 <memend+0xf800da44>
800016f8:	fef42623          	sw	a5,-20(s0)
    if(p)
800016fc:	fec42783          	lw	a5,-20(s0)
80001700:	00078c63          	beqz	a5,80001718 <palloc+0x38>
        mem.freelist=mem.freelist->next;
80001704:	8000e7b7          	lui	a5,0x8000e
80001708:	a447a783          	lw	a5,-1468(a5) # 8000da44 <memend+0xf800da44>
8000170c:	0007a703          	lw	a4,0(a5)
80001710:	8000e7b7          	lui	a5,0x8000e
80001714:	a4e7a223          	sw	a4,-1468(a5) # 8000da44 <memend+0xf800da44>
    if(p)
80001718:	fec42783          	lw	a5,-20(s0)
8000171c:	00078a63          	beqz	a5,80001730 <palloc+0x50>
        memset(p,0,PGSIZE);
80001720:	00001637          	lui	a2,0x1
80001724:	00000593          	li	a1,0
80001728:	fec42503          	lw	a0,-20(s0)
8000172c:	3e9000ef          	jal	ra,80002314 <memset>
    return (void*)p;
80001730:	fec42783          	lw	a5,-20(s0)
}
80001734:	00078513          	mv	a0,a5
80001738:	01c12083          	lw	ra,28(sp)
8000173c:	01812403          	lw	s0,24(sp)
80001740:	02010113          	addi	sp,sp,32
80001744:	00008067          	ret

80001748 <pfree>:

void pfree(void* addr){
80001748:	fd010113          	addi	sp,sp,-48
8000174c:	02812623          	sw	s0,44(sp)
80001750:	03010413          	addi	s0,sp,48
80001754:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80001758:	fdc42783          	lw	a5,-36(s0)
8000175c:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
80001760:	8000e7b7          	lui	a5,0x8000e
80001764:	a447a703          	lw	a4,-1468(a5) # 8000da44 <memend+0xf800da44>
80001768:	fec42783          	lw	a5,-20(s0)
8000176c:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
80001770:	8000e7b7          	lui	a5,0x8000e
80001774:	fec42703          	lw	a4,-20(s0)
80001778:	a4e7a223          	sw	a4,-1468(a5) # 8000da44 <memend+0xf800da44>
8000177c:	00000013          	nop
80001780:	02c12403          	lw	s0,44(sp)
80001784:	03010113          	addi	sp,sp,48
80001788:	00008067          	ret

8000178c <r_tp>:
static inline uint32 r_tp(){
8000178c:	fe010113          	addi	sp,sp,-32
80001790:	00812e23          	sw	s0,28(sp)
80001794:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001798:	00020793          	mv	a5,tp
8000179c:	fef42623          	sw	a5,-20(s0)
    return x;
800017a0:	fec42783          	lw	a5,-20(s0)
}
800017a4:	00078513          	mv	a0,a5
800017a8:	01c12403          	lw	s0,28(sp)
800017ac:	02010113          	addi	sp,sp,32
800017b0:	00008067          	ret

800017b4 <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
800017b4:	fe010113          	addi	sp,sp,-32
800017b8:	00812e23          	sw	s0,28(sp)
800017bc:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
800017c0:	104027f3          	csrr	a5,sie
800017c4:	fef42623          	sw	a5,-20(s0)
    return x;
800017c8:	fec42783          	lw	a5,-20(s0)
}
800017cc:	00078513          	mv	a0,a5
800017d0:	01c12403          	lw	s0,28(sp)
800017d4:	02010113          	addi	sp,sp,32
800017d8:	00008067          	ret

800017dc <w_sie>:
static inline void w_sie(uint32 x){
800017dc:	fe010113          	addi	sp,sp,-32
800017e0:	00812e23          	sw	s0,28(sp)
800017e4:	02010413          	addi	s0,sp,32
800017e8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
800017ec:	fec42783          	lw	a5,-20(s0)
800017f0:	10479073          	csrw	sie,a5
}
800017f4:	00000013          	nop
800017f8:	01c12403          	lw	s0,28(sp)
800017fc:	02010113          	addi	sp,sp,32
80001800:	00008067          	ret

80001804 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
80001804:	ff010113          	addi	sp,sp,-16
80001808:	00112623          	sw	ra,12(sp)
8000180c:	00812423          	sw	s0,8(sp)
80001810:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
80001814:	0c0007b7          	lui	a5,0xc000
80001818:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
8000181c:	00100713          	li	a4,1
80001820:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001824:	f69ff0ef          	jal	ra,8000178c <r_tp>
80001828:	00050793          	mv	a5,a0
8000182c:	00879713          	slli	a4,a5,0x8
80001830:	0c0027b7          	lui	a5,0xc002
80001834:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001838:	00f707b3          	add	a5,a4,a5
8000183c:	00078713          	mv	a4,a5
80001840:	40000793          	li	a5,1024
80001844:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001848:	f45ff0ef          	jal	ra,8000178c <r_tp>
8000184c:	00050713          	mv	a4,a0
80001850:	000c07b7          	lui	a5,0xc0
80001854:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
80001858:	00f707b3          	add	a5,a4,a5
8000185c:	00879793          	slli	a5,a5,0x8
80001860:	00078713          	mv	a4,a5
80001864:	40000793          	li	a5,1024
80001868:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
8000186c:	f21ff0ef          	jal	ra,8000178c <r_tp>
80001870:	00050713          	mv	a4,a0
80001874:	000067b7          	lui	a5,0x6
80001878:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
8000187c:	00f707b3          	add	a5,a4,a5
80001880:	00d79793          	slli	a5,a5,0xd
80001884:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
80001888:	f05ff0ef          	jal	ra,8000178c <r_tp>
8000188c:	00050793          	mv	a5,a0
80001890:	00d79713          	slli	a4,a5,0xd
80001894:	0c2017b7          	lui	a5,0xc201
80001898:	00f707b3          	add	a5,a4,a5
8000189c:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800018a0:	f15ff0ef          	jal	ra,800017b4 <r_sie>
800018a4:	00050793          	mv	a5,a0
800018a8:	2227e793          	ori	a5,a5,546
800018ac:	00078513          	mv	a0,a5
800018b0:	f2dff0ef          	jal	ra,800017dc <w_sie>
}
800018b4:	00000013          	nop
800018b8:	00c12083          	lw	ra,12(sp)
800018bc:	00812403          	lw	s0,8(sp)
800018c0:	01010113          	addi	sp,sp,16
800018c4:	00008067          	ret

800018c8 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
800018c8:	ff010113          	addi	sp,sp,-16
800018cc:	00112623          	sw	ra,12(sp)
800018d0:	00812423          	sw	s0,8(sp)
800018d4:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
800018d8:	eb5ff0ef          	jal	ra,8000178c <r_tp>
800018dc:	00050793          	mv	a5,a0
800018e0:	00d79713          	slli	a4,a5,0xd
800018e4:	0c2017b7          	lui	a5,0xc201
800018e8:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
800018ec:	00f707b3          	add	a5,a4,a5
800018f0:	0007a783          	lw	a5,0(a5)
}
800018f4:	00078513          	mv	a0,a5
800018f8:	00c12083          	lw	ra,12(sp)
800018fc:	00812403          	lw	s0,8(sp)
80001900:	01010113          	addi	sp,sp,16
80001904:	00008067          	ret

80001908 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001908:	fe010113          	addi	sp,sp,-32
8000190c:	00112e23          	sw	ra,28(sp)
80001910:	00812c23          	sw	s0,24(sp)
80001914:	02010413          	addi	s0,sp,32
80001918:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
8000191c:	e71ff0ef          	jal	ra,8000178c <r_tp>
80001920:	00050793          	mv	a5,a0
80001924:	00d79713          	slli	a4,a5,0xd
80001928:	0c2007b7          	lui	a5,0xc200
8000192c:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
80001930:	00f707b3          	add	a5,a4,a5
80001934:	00078713          	mv	a4,a5
80001938:	fec42783          	lw	a5,-20(s0)
8000193c:	00f72023          	sw	a5,0(a4)
80001940:	00000013          	nop
80001944:	01c12083          	lw	ra,28(sp)
80001948:	01812403          	lw	s0,24(sp)
8000194c:	02010113          	addi	sp,sp,32
80001950:	00008067          	ret

80001954 <w_satp>:
static inline void w_satp(uint32 x){
80001954:	fe010113          	addi	sp,sp,-32
80001958:	00812e23          	sw	s0,28(sp)
8000195c:	02010413          	addi	s0,sp,32
80001960:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80001964:	fec42783          	lw	a5,-20(s0)
80001968:	18079073          	csrw	satp,a5
}
8000196c:	00000013          	nop
80001970:	01c12403          	lw	s0,28(sp)
80001974:	02010113          	addi	sp,sp,32
80001978:	00008067          	ret

8000197c <sfence_vma>:
static inline void sfence_vma(){
8000197c:	ff010113          	addi	sp,sp,-16
80001980:	00812623          	sw	s0,12(sp)
80001984:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
80001988:	12000073          	sfence.vma
}
8000198c:	00000013          	nop
80001990:	00c12403          	lw	s0,12(sp)
80001994:	01010113          	addi	sp,sp,16
80001998:	00008067          	ret

8000199c <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
8000199c:	fd010113          	addi	sp,sp,-48
800019a0:	02112623          	sw	ra,44(sp)
800019a4:	02812423          	sw	s0,40(sp)
800019a8:	03010413          	addi	s0,sp,48
800019ac:	fca42e23          	sw	a0,-36(s0)
800019b0:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
800019b4:	fd842783          	lw	a5,-40(s0)
800019b8:	0167d793          	srli	a5,a5,0x16
800019bc:	00279793          	slli	a5,a5,0x2
800019c0:	fdc42703          	lw	a4,-36(s0)
800019c4:	00f707b3          	add	a5,a4,a5
800019c8:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
800019cc:	fec42783          	lw	a5,-20(s0)
800019d0:	0007a783          	lw	a5,0(a5)
800019d4:	0017f793          	andi	a5,a5,1
800019d8:	00078e63          	beqz	a5,800019f4 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
800019dc:	fec42783          	lw	a5,-20(s0)
800019e0:	0007a783          	lw	a5,0(a5)
800019e4:	00a7d793          	srli	a5,a5,0xa
800019e8:	00c79793          	slli	a5,a5,0xc
800019ec:	fcf42e23          	sw	a5,-36(s0)
800019f0:	0340006f          	j	80001a24 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
800019f4:	cedff0ef          	jal	ra,800016e0 <palloc>
800019f8:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
800019fc:	00001637          	lui	a2,0x1
80001a00:	00000593          	li	a1,0
80001a04:	fdc42503          	lw	a0,-36(s0)
80001a08:	10d000ef          	jal	ra,80002314 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001a0c:	fdc42783          	lw	a5,-36(s0)
80001a10:	00c7d793          	srli	a5,a5,0xc
80001a14:	00a79793          	slli	a5,a5,0xa
80001a18:	0017e713          	ori	a4,a5,1
80001a1c:	fec42783          	lw	a5,-20(s0)
80001a20:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001a24:	fd842783          	lw	a5,-40(s0)
80001a28:	00c7d793          	srli	a5,a5,0xc
80001a2c:	3ff7f793          	andi	a5,a5,1023
80001a30:	00279793          	slli	a5,a5,0x2
80001a34:	fdc42703          	lw	a4,-36(s0)
80001a38:	00f707b3          	add	a5,a4,a5
}
80001a3c:	00078513          	mv	a0,a5
80001a40:	02c12083          	lw	ra,44(sp)
80001a44:	02812403          	lw	s0,40(sp)
80001a48:	03010113          	addi	sp,sp,48
80001a4c:	00008067          	ret

80001a50 <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
80001a50:	fc010113          	addi	sp,sp,-64
80001a54:	02112e23          	sw	ra,60(sp)
80001a58:	02812c23          	sw	s0,56(sp)
80001a5c:	04010413          	addi	s0,sp,64
80001a60:	fca42e23          	sw	a0,-36(s0)
80001a64:	fcb42c23          	sw	a1,-40(s0)
80001a68:	fcc42a23          	sw	a2,-44(s0)
80001a6c:	fcd42823          	sw	a3,-48(s0)
80001a70:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
80001a74:	fd842703          	lw	a4,-40(s0)
80001a78:	fffff7b7          	lui	a5,0xfffff
80001a7c:	00f777b3          	and	a5,a4,a5
80001a80:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
80001a84:	fd042703          	lw	a4,-48(s0)
80001a88:	fd842783          	lw	a5,-40(s0)
80001a8c:	00f707b3          	add	a5,a4,a5
80001a90:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
80001a94:	fffff7b7          	lui	a5,0xfffff
80001a98:	00f777b3          	and	a5,a4,a5
80001a9c:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
80001aa0:	fec42583          	lw	a1,-20(s0)
80001aa4:	fdc42503          	lw	a0,-36(s0)
80001aa8:	ef5ff0ef          	jal	ra,8000199c <acquriepte>
80001aac:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
80001ab0:	fe442783          	lw	a5,-28(s0)
80001ab4:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001ab8:	0017f793          	andi	a5,a5,1
80001abc:	00078863          	beqz	a5,80001acc <vmmap+0x7c>
            panic("repeat map");
80001ac0:	8000c7b7          	lui	a5,0x8000c
80001ac4:	4d878513          	addi	a0,a5,1240 # 8000c4d8 <memend+0xf800c4d8>
80001ac8:	e74ff0ef          	jal	ra,8000113c <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001acc:	fd442783          	lw	a5,-44(s0)
80001ad0:	00c7d793          	srli	a5,a5,0xc
80001ad4:	00a79713          	slli	a4,a5,0xa
80001ad8:	fcc42783          	lw	a5,-52(s0)
80001adc:	00f767b3          	or	a5,a4,a5
80001ae0:	0017e713          	ori	a4,a5,1
80001ae4:	fe442783          	lw	a5,-28(s0)
80001ae8:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001aec:	fec42703          	lw	a4,-20(s0)
80001af0:	fe842783          	lw	a5,-24(s0)
80001af4:	02f70463          	beq	a4,a5,80001b1c <vmmap+0xcc>
        start += PGSIZE;
80001af8:	fec42703          	lw	a4,-20(s0)
80001afc:	000017b7          	lui	a5,0x1
80001b00:	00f707b3          	add	a5,a4,a5
80001b04:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001b08:	fd442703          	lw	a4,-44(s0)
80001b0c:	000017b7          	lui	a5,0x1
80001b10:	00f707b3          	add	a5,a4,a5
80001b14:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001b18:	f89ff06f          	j	80001aa0 <vmmap+0x50>
        if(start==end)  break;
80001b1c:	00000013          	nop
    }
}
80001b20:	00000013          	nop
80001b24:	03c12083          	lw	ra,60(sp)
80001b28:	03812403          	lw	s0,56(sp)
80001b2c:	04010113          	addi	sp,sp,64
80001b30:	00008067          	ret

80001b34 <printpgt>:

void printpgt(addr_t* pgt){
80001b34:	fc010113          	addi	sp,sp,-64
80001b38:	02112e23          	sw	ra,60(sp)
80001b3c:	02812c23          	sw	s0,56(sp)
80001b40:	04010413          	addi	s0,sp,64
80001b44:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
80001b48:	fe042623          	sw	zero,-20(s0)
80001b4c:	0c40006f          	j	80001c10 <printpgt+0xdc>
        pte_t pte=pgt[i];
80001b50:	fec42783          	lw	a5,-20(s0)
80001b54:	00279793          	slli	a5,a5,0x2
80001b58:	fcc42703          	lw	a4,-52(s0)
80001b5c:	00f707b3          	add	a5,a4,a5
80001b60:	0007a783          	lw	a5,0(a5) # 1000 <sz>
80001b64:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
80001b68:	fe442783          	lw	a5,-28(s0)
80001b6c:	0017f793          	andi	a5,a5,1
80001b70:	08078a63          	beqz	a5,80001c04 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
80001b74:	fe442783          	lw	a5,-28(s0)
80001b78:	00a7d793          	srli	a5,a5,0xa
80001b7c:	00c79793          	slli	a5,a5,0xc
80001b80:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
80001b84:	fe042683          	lw	a3,-32(s0)
80001b88:	fe442603          	lw	a2,-28(s0)
80001b8c:	fec42583          	lw	a1,-20(s0)
80001b90:	8000c7b7          	lui	a5,0x8000c
80001b94:	4e478513          	addi	a0,a5,1252 # 8000c4e4 <memend+0xf800c4e4>
80001b98:	ddcff0ef          	jal	ra,80001174 <printf>
            for(int j=0;j<1024;j++){
80001b9c:	fe042423          	sw	zero,-24(s0)
80001ba0:	0580006f          	j	80001bf8 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001ba4:	fe842783          	lw	a5,-24(s0)
80001ba8:	00279793          	slli	a5,a5,0x2
80001bac:	fe042703          	lw	a4,-32(s0)
80001bb0:	00f707b3          	add	a5,a4,a5
80001bb4:	0007a783          	lw	a5,0(a5)
80001bb8:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001bbc:	fdc42783          	lw	a5,-36(s0)
80001bc0:	0017f793          	andi	a5,a5,1
80001bc4:	02078463          	beqz	a5,80001bec <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001bc8:	fdc42783          	lw	a5,-36(s0)
80001bcc:	00a7d793          	srli	a5,a5,0xa
80001bd0:	00c79793          	slli	a5,a5,0xc
80001bd4:	00078693          	mv	a3,a5
80001bd8:	fdc42603          	lw	a2,-36(s0)
80001bdc:	fe842583          	lw	a1,-24(s0)
80001be0:	8000c7b7          	lui	a5,0x8000c
80001be4:	4fc78513          	addi	a0,a5,1276 # 8000c4fc <memend+0xf800c4fc>
80001be8:	d8cff0ef          	jal	ra,80001174 <printf>
            for(int j=0;j<1024;j++){
80001bec:	fe842783          	lw	a5,-24(s0)
80001bf0:	00178793          	addi	a5,a5,1
80001bf4:	fef42423          	sw	a5,-24(s0)
80001bf8:	fe842703          	lw	a4,-24(s0)
80001bfc:	3ff00793          	li	a5,1023
80001c00:	fae7d2e3          	bge	a5,a4,80001ba4 <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001c04:	fec42783          	lw	a5,-20(s0)
80001c08:	00178793          	addi	a5,a5,1
80001c0c:	fef42623          	sw	a5,-20(s0)
80001c10:	fec42703          	lw	a4,-20(s0)
80001c14:	3ff00793          	li	a5,1023
80001c18:	f2e7dce3          	bge	a5,a4,80001b50 <printpgt+0x1c>
                }
            }
        }
    }
}
80001c1c:	00000013          	nop
80001c20:	00000013          	nop
80001c24:	03c12083          	lw	ra,60(sp)
80001c28:	03812403          	lw	s0,56(sp)
80001c2c:	04010113          	addi	sp,sp,64
80001c30:	00008067          	ret

80001c34 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
80001c34:	fd010113          	addi	sp,sp,-48
80001c38:	02112623          	sw	ra,44(sp)
80001c3c:	02812423          	sw	s0,40(sp)
80001c40:	03010413          	addi	s0,sp,48
80001c44:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
80001c48:	fe042623          	sw	zero,-20(s0)
80001c4c:	04c0006f          	j	80001c98 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
80001c50:	fec42783          	lw	a5,-20(s0)
80001c54:	00d79793          	slli	a5,a5,0xd
80001c58:	00078713          	mv	a4,a5
80001c5c:	c00017b7          	lui	a5,0xc0001
80001c60:	00f707b3          	add	a5,a4,a5
80001c64:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
80001c68:	a79ff0ef          	jal	ra,800016e0 <palloc>
80001c6c:	00050793          	mv	a5,a0
80001c70:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
80001c74:	00600713          	li	a4,6
80001c78:	000016b7          	lui	a3,0x1
80001c7c:	fe442603          	lw	a2,-28(s0)
80001c80:	fe842583          	lw	a1,-24(s0)
80001c84:	fdc42503          	lw	a0,-36(s0)
80001c88:	dc9ff0ef          	jal	ra,80001a50 <vmmap>
    for(int i=0;i<NPROC;i++){
80001c8c:	fec42783          	lw	a5,-20(s0)
80001c90:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
80001c94:	fef42623          	sw	a5,-20(s0)
80001c98:	fec42703          	lw	a4,-20(s0)
80001c9c:	00300793          	li	a5,3
80001ca0:	fae7d8e3          	bge	a5,a4,80001c50 <mkstack+0x1c>
    }
}
80001ca4:	00000013          	nop
80001ca8:	00000013          	nop
80001cac:	02c12083          	lw	ra,44(sp)
80001cb0:	02812403          	lw	s0,40(sp)
80001cb4:	03010113          	addi	sp,sp,48
80001cb8:	00008067          	ret

80001cbc <kvminit>:

// 初始化虚拟内存
void kvminit(){
80001cbc:	ff010113          	addi	sp,sp,-16
80001cc0:	00112623          	sw	ra,12(sp)
80001cc4:	00812423          	sw	s0,8(sp)
80001cc8:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001ccc:	a15ff0ef          	jal	ra,800016e0 <palloc>
80001cd0:	00050713          	mv	a4,a0
80001cd4:	8000e7b7          	lui	a5,0x8000e
80001cd8:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
    memset(kpgt,0,PGSIZE);
80001cdc:	8000e7b7          	lui	a5,0x8000e
80001ce0:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001ce4:	00001637          	lui	a2,0x1
80001ce8:	00000593          	li	a1,0
80001cec:	00078513          	mv	a0,a5
80001cf0:	624000ef          	jal	ra,80002314 <memset>

    // 映射 CLINT
    vmmap(kpgt,CLINT_BASE,CLINT_BASE,0xc000,PTE_R|PTE_W);
80001cf4:	8000e7b7          	lui	a5,0x8000e
80001cf8:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001cfc:	00600713          	li	a4,6
80001d00:	0000c6b7          	lui	a3,0xc
80001d04:	02000637          	lui	a2,0x2000
80001d08:	020005b7          	lui	a1,0x2000
80001d0c:	00078513          	mv	a0,a5
80001d10:	d41ff0ef          	jal	ra,80001a50 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
80001d14:	8000e7b7          	lui	a5,0x8000e
80001d18:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001d1c:	00600713          	li	a4,6
80001d20:	004006b7          	lui	a3,0x400
80001d24:	0c000637          	lui	a2,0xc000
80001d28:	0c0005b7          	lui	a1,0xc000
80001d2c:	00078513          	mv	a0,a5
80001d30:	d21ff0ef          	jal	ra,80001a50 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
80001d34:	8000e7b7          	lui	a5,0x8000e
80001d38:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001d3c:	00600713          	li	a4,6
80001d40:	000016b7          	lui	a3,0x1
80001d44:	10000637          	lui	a2,0x10000
80001d48:	100005b7          	lui	a1,0x10000
80001d4c:	00078513          	mv	a0,a5
80001d50:	d01ff0ef          	jal	ra,80001a50 <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
80001d54:	8000e7b7          	lui	a5,0x8000e
80001d58:	a487a503          	lw	a0,-1464(a5) # 8000da48 <memend+0xf800da48>
80001d5c:	800007b7          	lui	a5,0x80000
80001d60:	00078593          	mv	a1,a5
80001d64:	800007b7          	lui	a5,0x80000
80001d68:	00078613          	mv	a2,a5
80001d6c:	800037b7          	lui	a5,0x80003
80001d70:	a0878713          	addi	a4,a5,-1528 # 80002a08 <memend+0xf8002a08>
80001d74:	800007b7          	lui	a5,0x80000
80001d78:	00078793          	mv	a5,a5
80001d7c:	40f707b3          	sub	a5,a4,a5
80001d80:	00a00713          	li	a4,10
80001d84:	00078693          	mv	a3,a5
80001d88:	cc9ff0ef          	jal	ra,80001a50 <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001d8c:	8000e7b7          	lui	a5,0x8000e
80001d90:	a487a503          	lw	a0,-1464(a5) # 8000da48 <memend+0xf800da48>
80001d94:	800037b7          	lui	a5,0x80003
80001d98:	00078593          	mv	a1,a5
80001d9c:	800037b7          	lui	a5,0x80003
80001da0:	00078613          	mv	a2,a5
80001da4:	8000b7b7          	lui	a5,0x8000b
80001da8:	00c78713          	addi	a4,a5,12 # 8000b00c <memend+0xf800b00c>
80001dac:	800037b7          	lui	a5,0x80003
80001db0:	00078793          	mv	a5,a5
80001db4:	40f707b3          	sub	a5,a4,a5
80001db8:	00600713          	li	a4,6
80001dbc:	00078693          	mv	a3,a5
80001dc0:	c91ff0ef          	jal	ra,80001a50 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001dc4:	8000e7b7          	lui	a5,0x8000e
80001dc8:	a487a503          	lw	a0,-1464(a5) # 8000da48 <memend+0xf800da48>
80001dcc:	8000c7b7          	lui	a5,0x8000c
80001dd0:	00078593          	mv	a1,a5
80001dd4:	8000c7b7          	lui	a5,0x8000c
80001dd8:	00078613          	mv	a2,a5
80001ddc:	8000c7b7          	lui	a5,0x8000c
80001de0:	52678713          	addi	a4,a5,1318 # 8000c526 <memend+0xf800c526>
80001de4:	8000c7b7          	lui	a5,0x8000c
80001de8:	00078793          	mv	a5,a5
80001dec:	40f707b3          	sub	a5,a4,a5
80001df0:	00200713          	li	a4,2
80001df4:	00078693          	mv	a3,a5
80001df8:	c59ff0ef          	jal	ra,80001a50 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001dfc:	8000e7b7          	lui	a5,0x8000e
80001e00:	a487a503          	lw	a0,-1464(a5) # 8000da48 <memend+0xf800da48>
80001e04:	8000d7b7          	lui	a5,0x8000d
80001e08:	00078593          	mv	a1,a5
80001e0c:	8000d7b7          	lui	a5,0x8000d
80001e10:	00078613          	mv	a2,a5
80001e14:	8000e7b7          	lui	a5,0x8000e
80001e18:	b9078713          	addi	a4,a5,-1136 # 8000db90 <memend+0xf800db90>
80001e1c:	8000d7b7          	lui	a5,0x8000d
80001e20:	00078793          	mv	a5,a5
80001e24:	40f707b3          	sub	a5,a4,a5
80001e28:	00600713          	li	a4,6
80001e2c:	00078693          	mv	a3,a5
80001e30:	c21ff0ef          	jal	ra,80001a50 <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001e34:	8000e7b7          	lui	a5,0x8000e
80001e38:	a487a503          	lw	a0,-1464(a5) # 8000da48 <memend+0xf800da48>
80001e3c:	8000e7b7          	lui	a5,0x8000e
80001e40:	00078593          	mv	a1,a5
80001e44:	8000e7b7          	lui	a5,0x8000e
80001e48:	00078613          	mv	a2,a5
80001e4c:	880007b7          	lui	a5,0x88000
80001e50:	00078713          	mv	a4,a5
80001e54:	8000e7b7          	lui	a5,0x8000e
80001e58:	00078793          	mv	a5,a5
80001e5c:	40f707b3          	sub	a5,a4,a5
80001e60:	00600713          	li	a4,6
80001e64:	00078693          	mv	a3,a5
80001e68:	be9ff0ef          	jal	ra,80001a50 <vmmap>

    mkstack(kpgt);
80001e6c:	8000e7b7          	lui	a5,0x8000e
80001e70:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001e74:	00078513          	mv	a0,a5
80001e78:	dbdff0ef          	jal	ra,80001c34 <mkstack>

    // 映射 usertrap
    vmmap(kpgt,USERVEC,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
80001e7c:	8000e7b7          	lui	a5,0x8000e
80001e80:	a487a503          	lw	a0,-1464(a5) # 8000da48 <memend+0xf800da48>
80001e84:	800007b7          	lui	a5,0x80000
80001e88:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001e8c:	00a00713          	li	a4,10
80001e90:	000016b7          	lui	a3,0x1
80001e94:	00078613          	mv	a2,a5
80001e98:	fffff5b7          	lui	a1,0xfffff
80001e9c:	bb5ff0ef          	jal	ra,80001a50 <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001ea0:	8000e7b7          	lui	a5,0x8000e
80001ea4:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001ea8:	00c7d713          	srli	a4,a5,0xc
80001eac:	800007b7          	lui	a5,0x80000
80001eb0:	00f767b3          	or	a5,a4,a5
80001eb4:	00078513          	mv	a0,a5
80001eb8:	a9dff0ef          	jal	ra,80001954 <w_satp>
    sfence_vma();       // 刷新页表
80001ebc:	ac1ff0ef          	jal	ra,8000197c <sfence_vma>
}
80001ec0:	00000013          	nop
80001ec4:	00c12083          	lw	ra,12(sp)
80001ec8:	00812403          	lw	s0,8(sp)
80001ecc:	01010113          	addi	sp,sp,16
80001ed0:	00008067          	ret

80001ed4 <pgtcreate>:

addr_t* pgtcreate(){
80001ed4:	fe010113          	addi	sp,sp,-32
80001ed8:	00112e23          	sw	ra,28(sp)
80001edc:	00812c23          	sw	s0,24(sp)
80001ee0:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001ee4:	ffcff0ef          	jal	ra,800016e0 <palloc>
80001ee8:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001eec:	fec42783          	lw	a5,-20(s0)
}
80001ef0:	00078513          	mv	a0,a5
80001ef4:	01c12083          	lw	ra,28(sp)
80001ef8:	01812403          	lw	s0,24(sp)
80001efc:	02010113          	addi	sp,sp,32
80001f00:	00008067          	ret

80001f04 <r_tp>:
static inline uint32 r_tp(){
80001f04:	fe010113          	addi	sp,sp,-32
80001f08:	00812e23          	sw	s0,28(sp)
80001f0c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001f10:	00020793          	mv	a5,tp
80001f14:	fef42623          	sw	a5,-20(s0)
    return x;
80001f18:	fec42783          	lw	a5,-20(s0)
}
80001f1c:	00078513          	mv	a0,a5
80001f20:	01c12403          	lw	s0,28(sp)
80001f24:	02010113          	addi	sp,sp,32
80001f28:	00008067          	ret

80001f2c <procinit>:
#include "defs.h"
#include "riscv.h"

uint nextpid=0;

void procinit(){
80001f2c:	fe010113          	addi	sp,sp,-32
80001f30:	00812e23          	sw	s0,28(sp)
80001f34:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001f38:	fe042623          	sw	zero,-20(s0)
80001f3c:	0500006f          	j	80001f8c <procinit+0x60>
        p=&proc[i];
80001f40:	fec42703          	lw	a4,-20(s0)
80001f44:	00070793          	mv	a5,a4
80001f48:	00379793          	slli	a5,a5,0x3
80001f4c:	00e787b3          	add	a5,a5,a4
80001f50:	00479793          	slli	a5,a5,0x4
80001f54:	8000d737          	lui	a4,0x8000d
80001f58:	40470713          	addi	a4,a4,1028 # 8000d404 <memend+0xf800d404>
80001f5c:	00e787b3          	add	a5,a5,a4
80001f60:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
80001f64:	fec42783          	lw	a5,-20(s0)
80001f68:	00d79793          	slli	a5,a5,0xd
80001f6c:	00078713          	mv	a4,a5
80001f70:	c00027b7          	lui	a5,0xc0002
80001f74:	00f70733          	add	a4,a4,a5
80001f78:	fe842783          	lw	a5,-24(s0)
80001f7c:	08e7a623          	sw	a4,140(a5) # c000208c <memend+0x3800208c>
    for(int i=0;i<NPROC;i++){
80001f80:	fec42783          	lw	a5,-20(s0)
80001f84:	00178793          	addi	a5,a5,1
80001f88:	fef42623          	sw	a5,-20(s0)
80001f8c:	fec42703          	lw	a4,-20(s0)
80001f90:	00300793          	li	a5,3
80001f94:	fae7d6e3          	bge	a5,a4,80001f40 <procinit+0x14>
    }
}
80001f98:	00000013          	nop
80001f9c:	00000013          	nop
80001fa0:	01c12403          	lw	s0,28(sp)
80001fa4:	02010113          	addi	sp,sp,32
80001fa8:	00008067          	ret

80001fac <nowproc>:

struct pcb* nowproc(){
80001fac:	fe010113          	addi	sp,sp,-32
80001fb0:	00112e23          	sw	ra,28(sp)
80001fb4:	00812c23          	sw	s0,24(sp)
80001fb8:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80001fbc:	f49ff0ef          	jal	ra,80001f04 <r_tp>
80001fc0:	00050793          	mv	a5,a0
80001fc4:	fef42623          	sw	a5,-20(s0)
    return cpus[hart].proc;
80001fc8:	8000d7b7          	lui	a5,0x8000d
80001fcc:	64478713          	addi	a4,a5,1604 # 8000d644 <memend+0xf800d644>
80001fd0:	fec42783          	lw	a5,-20(s0)
80001fd4:	00779793          	slli	a5,a5,0x7
80001fd8:	00f707b3          	add	a5,a4,a5
80001fdc:	0007a783          	lw	a5,0(a5)
}
80001fe0:	00078513          	mv	a0,a5
80001fe4:	01c12083          	lw	ra,28(sp)
80001fe8:	01812403          	lw	s0,24(sp)
80001fec:	02010113          	addi	sp,sp,32
80001ff0:	00008067          	ret

80001ff4 <nowcpu>:

struct cpu* nowcpu(){
80001ff4:	fe010113          	addi	sp,sp,-32
80001ff8:	00112e23          	sw	ra,28(sp)
80001ffc:	00812c23          	sw	s0,24(sp)
80002000:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80002004:	f01ff0ef          	jal	ra,80001f04 <r_tp>
80002008:	00050793          	mv	a5,a0
8000200c:	fef42623          	sw	a5,-20(s0)
    return &cpus[hart];
80002010:	fec42783          	lw	a5,-20(s0)
80002014:	00779713          	slli	a4,a5,0x7
80002018:	8000d7b7          	lui	a5,0x8000d
8000201c:	64478793          	addi	a5,a5,1604 # 8000d644 <memend+0xf800d644>
80002020:	00f707b3          	add	a5,a4,a5
}
80002024:	00078513          	mv	a0,a5
80002028:	01c12083          	lw	ra,28(sp)
8000202c:	01812403          	lw	s0,24(sp)
80002030:	02010113          	addi	sp,sp,32
80002034:	00008067          	ret

80002038 <pidalloc>:

uint pidalloc(){
80002038:	ff010113          	addi	sp,sp,-16
8000203c:	00812623          	sw	s0,12(sp)
80002040:	01010413          	addi	s0,sp,16
    return nextpid++;
80002044:	8000d7b7          	lui	a5,0x8000d
80002048:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
8000204c:	00178693          	addi	a3,a5,1
80002050:	8000d737          	lui	a4,0x8000d
80002054:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
} 
80002058:	00078513          	mv	a0,a5
8000205c:	00c12403          	lw	s0,12(sp)
80002060:	01010113          	addi	sp,sp,16
80002064:	00008067          	ret

80002068 <procalloc>:

struct pcb* procalloc(){
80002068:	fe010113          	addi	sp,sp,-32
8000206c:	00112e23          	sw	ra,28(sp)
80002070:	00812c23          	sw	s0,24(sp)
80002074:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80002078:	8000d7b7          	lui	a5,0x8000d
8000207c:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80002080:	fef42623          	sw	a5,-20(s0)
80002084:	0680006f          	j	800020ec <procalloc+0x84>
        if(p->status==UNUSED){
80002088:	fec42783          	lw	a5,-20(s0)
8000208c:	0047a783          	lw	a5,4(a5)
80002090:	04079863          	bnez	a5,800020e0 <procalloc+0x78>
            p->trapframe=(struct trapframe*)palloc(sizeof(struct trapframe));
80002094:	08c00513          	li	a0,140
80002098:	e48ff0ef          	jal	ra,800016e0 <palloc>
8000209c:	00050713          	mv	a4,a0
800020a0:	fec42783          	lw	a5,-20(s0)
800020a4:	00e7a423          	sw	a4,8(a5)
            
            p->pid=pidalloc();
800020a8:	f91ff0ef          	jal	ra,80002038 <pidalloc>
800020ac:	00050793          	mv	a5,a0
800020b0:	00078713          	mv	a4,a5
800020b4:	fec42783          	lw	a5,-20(s0)
800020b8:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
800020bc:	fec42783          	lw	a5,-20(s0)
800020c0:	00100713          	li	a4,1
800020c4:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
800020c8:	e0dff0ef          	jal	ra,80001ed4 <pgtcreate>
800020cc:	00050713          	mv	a4,a0
800020d0:	fec42783          	lw	a5,-20(s0)
800020d4:	08e7a423          	sw	a4,136(a5)
            
            return p;
800020d8:	fec42783          	lw	a5,-20(s0)
800020dc:	0240006f          	j	80002100 <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
800020e0:	fec42783          	lw	a5,-20(s0)
800020e4:	09078793          	addi	a5,a5,144
800020e8:	fef42623          	sw	a5,-20(s0)
800020ec:	fec42703          	lw	a4,-20(s0)
800020f0:	8000d7b7          	lui	a5,0x8000d
800020f4:	64478793          	addi	a5,a5,1604 # 8000d644 <memend+0xf800d644>
800020f8:	f8f768e3          	bltu	a4,a5,80002088 <procalloc+0x20>
        }
    }
    return 0;
800020fc:	00000793          	li	a5,0
}
80002100:	00078513          	mv	a0,a5
80002104:	01c12083          	lw	ra,28(sp)
80002108:	01812403          	lw	s0,24(sp)
8000210c:	02010113          	addi	sp,sp,32
80002110:	00008067          	ret

80002114 <userinit>:
  0x73,0x00,0x00,0x00,
  0x6f,0x00,0x00,0x00
  };

// 初始化第一个进程
void userinit(){
80002114:	fe010113          	addi	sp,sp,-32
80002118:	00112e23          	sw	ra,28(sp)
8000211c:	00812c23          	sw	s0,24(sp)
80002120:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80002124:	f45ff0ef          	jal	ra,80002068 <procalloc>
80002128:	fea42623          	sw	a0,-20(s0)
    
    p->trapframe->epc=0;
8000212c:	fec42783          	lw	a5,-20(s0)
80002130:	0087a783          	lw	a5,8(a5)
80002134:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp=PGSIZE;
80002138:	fec42783          	lw	a5,-20(s0)
8000213c:	0087a783          	lw	a5,8(a5)
80002140:	00001737          	lui	a4,0x1
80002144:	00e7aa23          	sw	a4,20(a5)
    
    char* m=(char*)palloc();
80002148:	d98ff0ef          	jal	ra,800016e0 <palloc>
8000214c:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80002150:	00c00613          	li	a2,12
80002154:	00000693          	li	a3,0
80002158:	8000b7b7          	lui	a5,0x8000b
8000215c:	00078593          	mv	a1,a5
80002160:	fe842503          	lw	a0,-24(s0)
80002164:	21c000ef          	jal	ra,80002380 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X|PTE_U);
80002168:	fec42783          	lw	a5,-20(s0)
8000216c:	0887a783          	lw	a5,136(a5) # 8000b088 <memend+0xf800b088>
80002170:	fe842603          	lw	a2,-24(s0)
80002174:	01e00713          	li	a4,30
80002178:	000016b7          	lui	a3,0x1
8000217c:	00000593          	li	a1,0
80002180:	00078513          	mv	a0,a5
80002184:	8cdff0ef          	jal	ra,80001a50 <vmmap>
    vmmap(p->pagetable,(uint32)usertrap,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
80002188:	fec42783          	lw	a5,-20(s0)
8000218c:	0887a503          	lw	a0,136(a5)
80002190:	800007b7          	lui	a5,0x80000
80002194:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80002198:	800007b7          	lui	a5,0x80000
8000219c:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
800021a0:	00a00713          	li	a4,10
800021a4:	000016b7          	lui	a3,0x1
800021a8:	00078613          	mv	a2,a5
800021ac:	8a5ff0ef          	jal	ra,80001a50 <vmmap>

    vmmap(p->pagetable,(addr_t)TRAPFRAME,(addr_t)p->trapframe,PGSIZE,PTE_R|PTE_W);
800021b0:	fec42783          	lw	a5,-20(s0)
800021b4:	0887a503          	lw	a0,136(a5)
800021b8:	fec42783          	lw	a5,-20(s0)
800021bc:	0087a783          	lw	a5,8(a5)
800021c0:	00600713          	li	a4,6
800021c4:	000016b7          	lui	a3,0x1
800021c8:	00078613          	mv	a2,a5
800021cc:	ffffe5b7          	lui	a1,0xffffe
800021d0:	881ff0ef          	jal	ra,80001a50 <vmmap>

    p->pagetable=(addr_t*)p->pagetable;
800021d4:	fec42783          	lw	a5,-20(s0)
800021d8:	0887a703          	lw	a4,136(a5)
800021dc:	fec42783          	lw	a5,-20(s0)
800021e0:	08e7a423          	sw	a4,136(a5)

    p->status=RUNABLE;
800021e4:	fec42783          	lw	a5,-20(s0)
800021e8:	00200713          	li	a4,2
800021ec:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
800021f0:	fec42783          	lw	a5,-20(s0)
800021f4:	0887a783          	lw	a5,136(a5)
800021f8:	00078513          	mv	a0,a5
800021fc:	a39ff0ef          	jal	ra,80001c34 <mkstack>

    p->context.ra=(reg_t)usertrapret;
80002200:	800017b7          	lui	a5,0x80001
80002204:	de878713          	addi	a4,a5,-536 # 80000de8 <memend+0xf8000de8>
80002208:	fec42783          	lw	a5,-20(s0)
8000220c:	00e7a623          	sw	a4,12(a5)
    p->context.sp=p->kernelstack;
80002210:	fec42783          	lw	a5,-20(s0)
80002214:	08c7a703          	lw	a4,140(a5)
80002218:	fec42783          	lw	a5,-20(s0)
8000221c:	00e7a823          	sw	a4,16(a5)
}
80002220:	00000013          	nop
80002224:	01c12083          	lw	ra,28(sp)
80002228:	01812403          	lw	s0,24(sp)
8000222c:	02010113          	addi	sp,sp,32
80002230:	00008067          	ret

80002234 <schedule>:

void schedule(){
80002234:	fe010113          	addi	sp,sp,-32
80002238:	00112e23          	sw	ra,28(sp)
8000223c:	00812c23          	sw	s0,24(sp)
80002240:	02010413          	addi	s0,sp,32
    struct cpu* c=nowcpu();
80002244:	db1ff0ef          	jal	ra,80001ff4 <nowcpu>
80002248:	fea42423          	sw	a0,-24(s0)

    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
8000224c:	8000d7b7          	lui	a5,0x8000d
80002250:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80002254:	fef42623          	sw	a5,-20(s0)
80002258:	0540006f          	j	800022ac <schedule+0x78>
            if(p->status==RUNABLE){
8000225c:	fec42783          	lw	a5,-20(s0)
80002260:	0047a703          	lw	a4,4(a5)
80002264:	00200793          	li	a5,2
80002268:	02f71c63          	bne	a4,a5,800022a0 <schedule+0x6c>
                p->status=RUNNING;
8000226c:	fec42783          	lw	a5,-20(s0)
80002270:	00300713          	li	a4,3
80002274:	00e7a223          	sw	a4,4(a5)
                c->proc=p;
80002278:	fe842783          	lw	a5,-24(s0)
8000227c:	fec42703          	lw	a4,-20(s0)
80002280:	00e7a023          	sw	a4,0(a5)
                swtch(&c->context,&p->context);
80002284:	fe842783          	lw	a5,-24(s0)
80002288:	00478713          	addi	a4,a5,4
8000228c:	fec42783          	lw	a5,-20(s0)
80002290:	00c78793          	addi	a5,a5,12
80002294:	00078593          	mv	a1,a5
80002298:	00070513          	mv	a0,a4
8000229c:	f01fd0ef          	jal	ra,8000019c <swtch>
        for(p=proc;p<&proc[NPROC];p++){
800022a0:	fec42783          	lw	a5,-20(s0)
800022a4:	09078793          	addi	a5,a5,144
800022a8:	fef42623          	sw	a5,-20(s0)
800022ac:	fec42703          	lw	a4,-20(s0)
800022b0:	8000d7b7          	lui	a5,0x8000d
800022b4:	64478793          	addi	a5,a5,1604 # 8000d644 <memend+0xf800d644>
800022b8:	faf762e3          	bltu	a4,a5,8000225c <schedule+0x28>
    for(;;){
800022bc:	f91ff06f          	j	8000224c <schedule+0x18>

800022c0 <yield>:
            }
        }
    }
}

void yield(){
800022c0:	fe010113          	addi	sp,sp,-32
800022c4:	00112e23          	sw	ra,28(sp)
800022c8:	00812c23          	sw	s0,24(sp)
800022cc:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
800022d0:	cddff0ef          	jal	ra,80001fac <nowproc>
800022d4:	fea42623          	sw	a0,-20(s0)
    if(p->status!=RUNNING){
800022d8:	fec42783          	lw	a5,-20(s0)
800022dc:	0047a703          	lw	a4,4(a5)
800022e0:	00300793          	li	a5,3
800022e4:	00f70863          	beq	a4,a5,800022f4 <yield+0x34>
        panic("proc status error");
800022e8:	8000c7b7          	lui	a5,0x8000c
800022ec:	51478513          	addi	a0,a5,1300 # 8000c514 <memend+0xf800c514>
800022f0:	e4dfe0ef          	jal	ra,8000113c <panic>
    }
    p->status=RUNABLE;
800022f4:	fec42783          	lw	a5,-20(s0)
800022f8:	00200713          	li	a4,2
800022fc:	00e7a223          	sw	a4,4(a5)
80002300:	00000013          	nop
80002304:	01c12083          	lw	ra,28(sp)
80002308:	01812403          	lw	s0,24(sp)
8000230c:	02010113          	addi	sp,sp,32
80002310:	00008067          	ret

80002314 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80002314:	fd010113          	addi	sp,sp,-48
80002318:	02812623          	sw	s0,44(sp)
8000231c:	03010413          	addi	s0,sp,48
80002320:	fca42e23          	sw	a0,-36(s0)
80002324:	fcb42c23          	sw	a1,-40(s0)
80002328:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
8000232c:	fdc42783          	lw	a5,-36(s0)
80002330:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80002334:	fe042623          	sw	zero,-20(s0)
80002338:	0280006f          	j	80002360 <memset+0x4c>
        maddr[i] = (char)c;
8000233c:	fe842703          	lw	a4,-24(s0)
80002340:	fec42783          	lw	a5,-20(s0)
80002344:	00f707b3          	add	a5,a4,a5
80002348:	fd842703          	lw	a4,-40(s0)
8000234c:	0ff77713          	andi	a4,a4,255
80002350:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80002354:	fec42783          	lw	a5,-20(s0)
80002358:	00178793          	addi	a5,a5,1
8000235c:	fef42623          	sw	a5,-20(s0)
80002360:	fec42703          	lw	a4,-20(s0)
80002364:	fd442783          	lw	a5,-44(s0)
80002368:	fcf76ae3          	bltu	a4,a5,8000233c <memset+0x28>
    }
    return addr;
8000236c:	fdc42783          	lw	a5,-36(s0)
}
80002370:	00078513          	mv	a0,a5
80002374:	02c12403          	lw	s0,44(sp)
80002378:	03010113          	addi	sp,sp,48
8000237c:	00008067          	ret

80002380 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80002380:	fd010113          	addi	sp,sp,-48
80002384:	02812623          	sw	s0,44(sp)
80002388:	03010413          	addi	s0,sp,48
8000238c:	fca42e23          	sw	a0,-36(s0)
80002390:	fcb42c23          	sw	a1,-40(s0)
80002394:	fcc42823          	sw	a2,-48(s0)
80002398:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
8000239c:	fd042783          	lw	a5,-48(s0)
800023a0:	fd442703          	lw	a4,-44(s0)
800023a4:	00e7e7b3          	or	a5,a5,a4
800023a8:	00079663          	bnez	a5,800023b4 <memmove+0x34>
        return dst;
800023ac:	fdc42783          	lw	a5,-36(s0)
800023b0:	1200006f          	j	800024d0 <memmove+0x150>
    }

    s = src;
800023b4:	fd842783          	lw	a5,-40(s0)
800023b8:	fef42623          	sw	a5,-20(s0)
    d = dst;
800023bc:	fdc42783          	lw	a5,-36(s0)
800023c0:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
800023c4:	fec42703          	lw	a4,-20(s0)
800023c8:	fe842783          	lw	a5,-24(s0)
800023cc:	0cf77263          	bgeu	a4,a5,80002490 <memmove+0x110>
800023d0:	fd042783          	lw	a5,-48(s0)
800023d4:	fec42703          	lw	a4,-20(s0)
800023d8:	00f707b3          	add	a5,a4,a5
800023dc:	fe842703          	lw	a4,-24(s0)
800023e0:	0af77863          	bgeu	a4,a5,80002490 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
800023e4:	fd042783          	lw	a5,-48(s0)
800023e8:	fec42703          	lw	a4,-20(s0)
800023ec:	00f707b3          	add	a5,a4,a5
800023f0:	fef42623          	sw	a5,-20(s0)
        d += n;
800023f4:	fd042783          	lw	a5,-48(s0)
800023f8:	fe842703          	lw	a4,-24(s0)
800023fc:	00f707b3          	add	a5,a4,a5
80002400:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80002404:	02c0006f          	j	80002430 <memmove+0xb0>
            *--d = *--s;
80002408:	fec42783          	lw	a5,-20(s0)
8000240c:	fff78793          	addi	a5,a5,-1
80002410:	fef42623          	sw	a5,-20(s0)
80002414:	fe842783          	lw	a5,-24(s0)
80002418:	fff78793          	addi	a5,a5,-1
8000241c:	fef42423          	sw	a5,-24(s0)
80002420:	fec42783          	lw	a5,-20(s0)
80002424:	0007c703          	lbu	a4,0(a5)
80002428:	fe842783          	lw	a5,-24(s0)
8000242c:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80002430:	fd042703          	lw	a4,-48(s0)
80002434:	fd442783          	lw	a5,-44(s0)
80002438:	fff00513          	li	a0,-1
8000243c:	fff00593          	li	a1,-1
80002440:	00a70633          	add	a2,a4,a0
80002444:	00060813          	mv	a6,a2
80002448:	00e83833          	sltu	a6,a6,a4
8000244c:	00b786b3          	add	a3,a5,a1
80002450:	00d805b3          	add	a1,a6,a3
80002454:	00058693          	mv	a3,a1
80002458:	fcc42823          	sw	a2,-48(s0)
8000245c:	fcd42a23          	sw	a3,-44(s0)
80002460:	00070693          	mv	a3,a4
80002464:	00f6e6b3          	or	a3,a3,a5
80002468:	fa0690e3          	bnez	a3,80002408 <memmove+0x88>
    if(s < d && s + n > d){     
8000246c:	0600006f          	j	800024cc <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80002470:	fec42703          	lw	a4,-20(s0)
80002474:	00170793          	addi	a5,a4,1 # 1001 <sz+0x1>
80002478:	fef42623          	sw	a5,-20(s0)
8000247c:	fe842783          	lw	a5,-24(s0)
80002480:	00178693          	addi	a3,a5,1
80002484:	fed42423          	sw	a3,-24(s0)
80002488:	00074703          	lbu	a4,0(a4)
8000248c:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80002490:	fd042703          	lw	a4,-48(s0)
80002494:	fd442783          	lw	a5,-44(s0)
80002498:	fff00513          	li	a0,-1
8000249c:	fff00593          	li	a1,-1
800024a0:	00a70633          	add	a2,a4,a0
800024a4:	00060813          	mv	a6,a2
800024a8:	00e83833          	sltu	a6,a6,a4
800024ac:	00b786b3          	add	a3,a5,a1
800024b0:	00d805b3          	add	a1,a6,a3
800024b4:	00058693          	mv	a3,a1
800024b8:	fcc42823          	sw	a2,-48(s0)
800024bc:	fcd42a23          	sw	a3,-44(s0)
800024c0:	00070693          	mv	a3,a4
800024c4:	00f6e6b3          	or	a3,a3,a5
800024c8:	fa0694e3          	bnez	a3,80002470 <memmove+0xf0>
        }
    }
    return dst;
800024cc:	fdc42783          	lw	a5,-36(s0)
}
800024d0:	00078513          	mv	a0,a5
800024d4:	02c12403          	lw	s0,44(sp)
800024d8:	03010113          	addi	sp,sp,48
800024dc:	00008067          	ret

800024e0 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
800024e0:	fd010113          	addi	sp,sp,-48
800024e4:	02812623          	sw	s0,44(sp)
800024e8:	03010413          	addi	s0,sp,48
800024ec:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
800024f0:	00000793          	li	a5,0
800024f4:	00000813          	li	a6,0
800024f8:	fef42423          	sw	a5,-24(s0)
800024fc:	ff042623          	sw	a6,-20(s0)
80002500:	0340006f          	j	80002534 <strlen+0x54>
80002504:	fe842603          	lw	a2,-24(s0)
80002508:	fec42683          	lw	a3,-20(s0)
8000250c:	00100513          	li	a0,1
80002510:	00000593          	li	a1,0
80002514:	00a60733          	add	a4,a2,a0
80002518:	00070813          	mv	a6,a4
8000251c:	00c83833          	sltu	a6,a6,a2
80002520:	00b687b3          	add	a5,a3,a1
80002524:	00f806b3          	add	a3,a6,a5
80002528:	00068793          	mv	a5,a3
8000252c:	fee42423          	sw	a4,-24(s0)
80002530:	fef42623          	sw	a5,-20(s0)
80002534:	fe842783          	lw	a5,-24(s0)
80002538:	fdc42703          	lw	a4,-36(s0)
8000253c:	00f707b3          	add	a5,a4,a5
80002540:	0007c783          	lbu	a5,0(a5)
80002544:	fc0790e3          	bnez	a5,80002504 <strlen+0x24>
    
    return n;
80002548:	fe842703          	lw	a4,-24(s0)
8000254c:	fec42783          	lw	a5,-20(s0)
80002550:	00070513          	mv	a0,a4
80002554:	00078593          	mv	a1,a5
80002558:	02c12403          	lw	s0,44(sp)
8000255c:	03010113          	addi	sp,sp,48
80002560:	00008067          	ret

80002564 <r_tp>:
static inline uint32 r_tp(){
80002564:	fe010113          	addi	sp,sp,-32
80002568:	00812e23          	sw	s0,28(sp)
8000256c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80002570:	00020793          	mv	a5,tp
80002574:	fef42623          	sw	a5,-20(s0)
    return x;
80002578:	fec42783          	lw	a5,-20(s0)
}
8000257c:	00078513          	mv	a0,a5
80002580:	01c12403          	lw	s0,28(sp)
80002584:	02010113          	addi	sp,sp,32
80002588:	00008067          	ret

8000258c <clintinit>:
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit(){
8000258c:	fe010113          	addi	sp,sp,-32
80002590:	00112e23          	sw	ra,28(sp)
80002594:	00812c23          	sw	s0,24(sp)
80002598:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp 
    int hart=r_tp();
8000259c:	fc9ff0ef          	jal	ra,80002564 <r_tp>
800025a0:	00050793          	mv	a5,a0
800025a4:	fef42623          	sw	a5,-20(s0)
    *(reg_t*)CLINT_MTIMECMP(hart)=*(reg_t*)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
800025a8:	fec42703          	lw	a4,-20(s0)
800025ac:	004017b7          	lui	a5,0x401
800025b0:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800025b4:	00f707b3          	add	a5,a4,a5
800025b8:	00379793          	slli	a5,a5,0x3
800025bc:	0007a703          	lw	a4,0(a5)
800025c0:	fec42683          	lw	a3,-20(s0)
800025c4:	004017b7          	lui	a5,0x401
800025c8:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800025cc:	00f687b3          	add	a5,a3,a5
800025d0:	00379793          	slli	a5,a5,0x3
800025d4:	00078693          	mv	a3,a5
800025d8:	009897b7          	lui	a5,0x989
800025dc:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
800025e0:	00f707b3          	add	a5,a4,a5
800025e4:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
800025e8:	00000013          	nop
800025ec:	01c12083          	lw	ra,28(sp)
800025f0:	01812403          	lw	s0,24(sp)
800025f4:	02010113          	addi	sp,sp,32
800025f8:	00008067          	ret

800025fc <r_mstatus>:
static inline uint32 r_mstatus(){
800025fc:	fe010113          	addi	sp,sp,-32
80002600:	00812e23          	sw	s0,28(sp)
80002604:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80002608:	300027f3          	csrr	a5,mstatus
8000260c:	fef42623          	sw	a5,-20(s0)
    return x;
80002610:	fec42783          	lw	a5,-20(s0)
}
80002614:	00078513          	mv	a0,a5
80002618:	01c12403          	lw	s0,28(sp)
8000261c:	02010113          	addi	sp,sp,32
80002620:	00008067          	ret

80002624 <w_mstatus>:
static inline void w_mstatus(uint32 x){
80002624:	fe010113          	addi	sp,sp,-32
80002628:	00812e23          	sw	s0,28(sp)
8000262c:	02010413          	addi	s0,sp,32
80002630:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80002634:	fec42783          	lw	a5,-20(s0)
80002638:	30079073          	csrw	mstatus,a5
}
8000263c:	00000013          	nop
80002640:	01c12403          	lw	s0,28(sp)
80002644:	02010113          	addi	sp,sp,32
80002648:	00008067          	ret

8000264c <w_mtvec>:
static inline void w_mtvec(uint32 x){
8000264c:	fe010113          	addi	sp,sp,-32
80002650:	00812e23          	sw	s0,28(sp)
80002654:	02010413          	addi	s0,sp,32
80002658:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0" : : "r"(x));
8000265c:	fec42783          	lw	a5,-20(s0)
80002660:	30579073          	csrw	mtvec,a5
}
80002664:	00000013          	nop
80002668:	01c12403          	lw	s0,28(sp)
8000266c:	02010113          	addi	sp,sp,32
80002670:	00008067          	ret

80002674 <r_tp>:
static inline uint32 r_tp(){
80002674:	fe010113          	addi	sp,sp,-32
80002678:	00812e23          	sw	s0,28(sp)
8000267c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80002680:	00020793          	mv	a5,tp
80002684:	fef42623          	sw	a5,-20(s0)
    return x;
80002688:	fec42783          	lw	a5,-20(s0)
}
8000268c:	00078513          	mv	a0,a5
80002690:	01c12403          	lw	s0,28(sp)
80002694:	02010113          	addi	sp,sp,32
80002698:	00008067          	ret

8000269c <s_mstatus_intr>:
static inline void s_mstatus_intr(uint32 m){
8000269c:	fd010113          	addi	sp,sp,-48
800026a0:	02112623          	sw	ra,44(sp)
800026a4:	02812423          	sw	s0,40(sp)
800026a8:	03010413          	addi	s0,sp,48
800026ac:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
800026b0:	f4dff0ef          	jal	ra,800025fc <r_mstatus>
800026b4:	fea42623          	sw	a0,-20(s0)
    switch (m)
800026b8:	fdc42703          	lw	a4,-36(s0)
800026bc:	08000793          	li	a5,128
800026c0:	04f70263          	beq	a4,a5,80002704 <s_mstatus_intr+0x68>
800026c4:	fdc42703          	lw	a4,-36(s0)
800026c8:	08000793          	li	a5,128
800026cc:	0ae7e463          	bltu	a5,a4,80002774 <s_mstatus_intr+0xd8>
800026d0:	fdc42703          	lw	a4,-36(s0)
800026d4:	02000793          	li	a5,32
800026d8:	04f70463          	beq	a4,a5,80002720 <s_mstatus_intr+0x84>
800026dc:	fdc42703          	lw	a4,-36(s0)
800026e0:	02000793          	li	a5,32
800026e4:	08e7e863          	bltu	a5,a4,80002774 <s_mstatus_intr+0xd8>
800026e8:	fdc42703          	lw	a4,-36(s0)
800026ec:	00200793          	li	a5,2
800026f0:	06f70463          	beq	a4,a5,80002758 <s_mstatus_intr+0xbc>
800026f4:	fdc42703          	lw	a4,-36(s0)
800026f8:	00800793          	li	a5,8
800026fc:	04f70063          	beq	a4,a5,8000273c <s_mstatus_intr+0xa0>
        break;
80002700:	0740006f          	j	80002774 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
80002704:	fec42783          	lw	a5,-20(s0)
80002708:	f7f7f793          	andi	a5,a5,-129
8000270c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
80002710:	fec42783          	lw	a5,-20(s0)
80002714:	0807e793          	ori	a5,a5,128
80002718:	fef42623          	sw	a5,-20(s0)
        break;
8000271c:	05c0006f          	j	80002778 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
80002720:	fec42783          	lw	a5,-20(s0)
80002724:	fdf7f793          	andi	a5,a5,-33
80002728:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
8000272c:	fec42783          	lw	a5,-20(s0)
80002730:	0207e793          	ori	a5,a5,32
80002734:	fef42623          	sw	a5,-20(s0)
        break;
80002738:	0400006f          	j	80002778 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
8000273c:	fec42783          	lw	a5,-20(s0)
80002740:	ff77f793          	andi	a5,a5,-9
80002744:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80002748:	fec42783          	lw	a5,-20(s0)
8000274c:	0087e793          	ori	a5,a5,8
80002750:	fef42623          	sw	a5,-20(s0)
        break;
80002754:	0240006f          	j	80002778 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80002758:	fec42783          	lw	a5,-20(s0)
8000275c:	ffd7f793          	andi	a5,a5,-3
80002760:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80002764:	fec42783          	lw	a5,-20(s0)
80002768:	0027e793          	ori	a5,a5,2
8000276c:	fef42623          	sw	a5,-20(s0)
        break;
80002770:	0080006f          	j	80002778 <s_mstatus_intr+0xdc>
        break;
80002774:	00000013          	nop
    w_mstatus(x);
80002778:	fec42503          	lw	a0,-20(s0)
8000277c:	ea9ff0ef          	jal	ra,80002624 <w_mstatus>
}
80002780:	00000013          	nop
80002784:	02c12083          	lw	ra,44(sp)
80002788:	02812403          	lw	s0,40(sp)
8000278c:	03010113          	addi	sp,sp,48
80002790:	00008067          	ret

80002794 <r_sie>:
static inline uint32 r_sie(){
80002794:	fe010113          	addi	sp,sp,-32
80002798:	00812e23          	sw	s0,28(sp)
8000279c:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie " : "=r"(x));
800027a0:	104027f3          	csrr	a5,sie
800027a4:	fef42623          	sw	a5,-20(s0)
    return x;
800027a8:	fec42783          	lw	a5,-20(s0)
}
800027ac:	00078513          	mv	a0,a5
800027b0:	01c12403          	lw	s0,28(sp)
800027b4:	02010113          	addi	sp,sp,32
800027b8:	00008067          	ret

800027bc <w_sie>:
static inline void w_sie(uint32 x){
800027bc:	fe010113          	addi	sp,sp,-32
800027c0:	00812e23          	sw	s0,28(sp)
800027c4:	02010413          	addi	s0,sp,32
800027c8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
800027cc:	fec42783          	lw	a5,-20(s0)
800027d0:	10479073          	csrw	sie,a5
}
800027d4:	00000013          	nop
800027d8:	01c12403          	lw	s0,28(sp)
800027dc:	02010113          	addi	sp,sp,32
800027e0:	00008067          	ret

800027e4 <r_mie>:
#define MEIE (1<<11)
#define MTIE (1<<7)
#define MSIE (1<<3)
static inline uint32 r_mie(){
800027e4:	fe010113          	addi	sp,sp,-32
800027e8:	00812e23          	sw	s0,28(sp)
800027ec:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie " : "=r"(x));
800027f0:	304027f3          	csrr	a5,mie
800027f4:	fef42623          	sw	a5,-20(s0)
    return x;
800027f8:	fec42783          	lw	a5,-20(s0)
}
800027fc:	00078513          	mv	a0,a5
80002800:	01c12403          	lw	s0,28(sp)
80002804:	02010113          	addi	sp,sp,32
80002808:	00008067          	ret

8000280c <w_mie>:
static inline void w_mie(uint32 x){
8000280c:	fe010113          	addi	sp,sp,-32
80002810:	00812e23          	sw	s0,28(sp)
80002814:	02010413          	addi	s0,sp,32
80002818:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"::"r"(x));
8000281c:	fec42783          	lw	a5,-20(s0)
80002820:	30479073          	csrw	mie,a5
}
80002824:	00000013          	nop
80002828:	01c12403          	lw	s0,28(sp)
8000282c:	02010113          	addi	sp,sp,32
80002830:	00008067          	ret

80002834 <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x){
80002834:	fe010113          	addi	sp,sp,-32
80002838:	00812e23          	sw	s0,28(sp)
8000283c:	02010413          	addi	s0,sp,32
80002840:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0" : :"r"(x));
80002844:	fec42783          	lw	a5,-20(s0)
80002848:	34079073          	csrw	mscratch,a5
8000284c:	00000013          	nop
80002850:	01c12403          	lw	s0,28(sp)
80002854:	02010113          	addi	sp,sp,32
80002858:	00008067          	ret

8000285c <timerinit>:

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit(){
8000285c:	fe010113          	addi	sp,sp,-32
80002860:	00112e23          	sw	ra,28(sp)
80002864:	00812c23          	sw	s0,24(sp)
80002868:	01212a23          	sw	s2,20(sp)
8000286c:	01312823          	sw	s3,16(sp)
80002870:	02010413          	addi	s0,sp,32
    uint hart=r_tp();
80002874:	e01ff0ef          	jal	ra,80002674 <r_tp>
80002878:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
8000287c:	fec42703          	lw	a4,-20(s0)
80002880:	00070793          	mv	a5,a4
80002884:	00279793          	slli	a5,a5,0x2
80002888:	00e787b3          	add	a5,a5,a4
8000288c:	00379793          	slli	a5,a5,0x3
80002890:	8000e737          	lui	a4,0x8000e
80002894:	a5070713          	addi	a4,a4,-1456 # 8000da50 <memend+0xf800da50>
80002898:	00e787b3          	add	a5,a5,a4
8000289c:	00078513          	mv	a0,a5
800028a0:	f95ff0ef          	jal	ra,80002834 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
800028a4:	fec42703          	lw	a4,-20(s0)
800028a8:	004017b7          	lui	a5,0x401
800028ac:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800028b0:	00f707b3          	add	a5,a4,a5
800028b4:	00379793          	slli	a5,a5,0x3
800028b8:	00078913          	mv	s2,a5
800028bc:	00000993          	li	s3,0
800028c0:	8000e7b7          	lui	a5,0x8000e
800028c4:	a5078693          	addi	a3,a5,-1456 # 8000da50 <memend+0xf800da50>
800028c8:	fec42703          	lw	a4,-20(s0)
800028cc:	00070793          	mv	a5,a4
800028d0:	00279793          	slli	a5,a5,0x2
800028d4:	00e787b3          	add	a5,a5,a4
800028d8:	00379793          	slli	a5,a5,0x3
800028dc:	00f687b3          	add	a5,a3,a5
800028e0:	0127a023          	sw	s2,0(a5)
800028e4:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;
800028e8:	8000e7b7          	lui	a5,0x8000e
800028ec:	a5078693          	addi	a3,a5,-1456 # 8000da50 <memend+0xf800da50>
800028f0:	fec42703          	lw	a4,-20(s0)
800028f4:	00070793          	mv	a5,a4
800028f8:	00279793          	slli	a5,a5,0x2
800028fc:	00e787b3          	add	a5,a5,a4
80002900:	00379793          	slli	a5,a5,0x3
80002904:	00f686b3          	add	a3,a3,a5
80002908:	00989737          	lui	a4,0x989
8000290c:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002910:	00000793          	li	a5,0
80002914:	00e6a423          	sw	a4,8(a3)
80002918:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数
8000291c:	800007b7          	lui	a5,0x80000
80002920:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
80002924:	00078513          	mv	a0,a5
80002928:	d25ff0ef          	jal	ra,8000264c <w_mtvec>

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断
8000292c:	00800513          	li	a0,8
80002930:	d6dff0ef          	jal	ra,8000269c <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
80002934:	e61ff0ef          	jal	ra,80002794 <r_sie>
80002938:	00050793          	mv	a5,a0
8000293c:	2227e793          	ori	a5,a5,546
80002940:	00078513          	mv	a0,a5
80002944:	e79ff0ef          	jal	ra,800027bc <w_sie>

    w_mie(r_mie() | MTIE );      // 开启 M-mode 时钟中断
80002948:	e9dff0ef          	jal	ra,800027e4 <r_mie>
8000294c:	00050793          	mv	a5,a0
80002950:	0807e793          	ori	a5,a5,128
80002954:	00078513          	mv	a0,a5
80002958:	eb5ff0ef          	jal	ra,8000280c <w_mie>

    clintinit();                 // 初始化 CLINT           
8000295c:	c31ff0ef          	jal	ra,8000258c <clintinit>
80002960:	00000013          	nop
80002964:	01c12083          	lw	ra,28(sp)
80002968:	01812403          	lw	s0,24(sp)
8000296c:	01412903          	lw	s2,20(sp)
80002970:	01012983          	lw	s3,16(sp)
80002974:	02010113          	addi	sp,sp,32
80002978:	00008067          	ret

8000297c <r_sepc>:
static inline uint32 r_sepc(){
8000297c:	fe010113          	addi	sp,sp,-32
80002980:	00812e23          	sw	s0,28(sp)
80002984:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, sepc" : "=r" (x) );
80002988:	141027f3          	csrr	a5,sepc
8000298c:	fef42623          	sw	a5,-20(s0)
    return x;
80002990:	fec42783          	lw	a5,-20(s0)
}
80002994:	00078513          	mv	a0,a5
80002998:	01c12403          	lw	s0,28(sp)
8000299c:	02010113          	addi	sp,sp,32
800029a0:	00008067          	ret

800029a4 <w_sepc>:
static inline void w_sepc(uint32 x){
800029a4:	fe010113          	addi	sp,sp,-32
800029a8:	00812e23          	sw	s0,28(sp)
800029ac:	02010413          	addi	s0,sp,32
800029b0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
800029b4:	fec42783          	lw	a5,-20(s0)
800029b8:	14179073          	csrw	sepc,a5
}
800029bc:	00000013          	nop
800029c0:	01c12403          	lw	s0,28(sp)
800029c4:	02010113          	addi	sp,sp,32
800029c8:	00008067          	ret

800029cc <syscall>:
 * @FilePath: /los/kernel/syscall.c
 */
#include "types.h"
#include "riscv.h"

void syscall(){
800029cc:	fe010113          	addi	sp,sp,-32
800029d0:	00112e23          	sw	ra,28(sp)
800029d4:	00812c23          	sw	s0,24(sp)
800029d8:	02010413          	addi	s0,sp,32
    uint32 sepc=r_sepc();
800029dc:	fa1ff0ef          	jal	ra,8000297c <r_sepc>
800029e0:	fea42623          	sw	a0,-20(s0)
    w_sepc(sepc+4);
800029e4:	fec42783          	lw	a5,-20(s0)
800029e8:	00478793          	addi	a5,a5,4
800029ec:	00078513          	mv	a0,a5
800029f0:	fb5ff0ef          	jal	ra,800029a4 <w_sepc>
800029f4:	00000013          	nop
800029f8:	01c12083          	lw	ra,28(sp)
800029fc:	01812403          	lw	s0,24(sp)
80002a00:	02010113          	addi	sp,sp,32
80002a04:	00008067          	ret

80002a08 <textend>:
	...
