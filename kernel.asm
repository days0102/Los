
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
800000ac:	671000ef          	jal	ra,80000f1c <trapvec>

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
8000032c:	3f1000ef          	jal	ra,80000f1c <trapvec>

80000330 <userret>:

.global userret
// userret( trapframe,satp )
userret:
    // 修改页表
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
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus()
{
800003c4:	fe010113          	addi	sp,sp,-32
800003c8:	00812e23          	sw	s0,28(sp)
800003cc:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus"
800003d0:	300027f3          	csrr	a5,mstatus
800003d4:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
800003d8:	fec42783          	lw	a5,-20(s0)
}
800003dc:	00078513          	mv	a0,a5
800003e0:	01c12403          	lw	s0,28(sp)
800003e4:	02010113          	addi	sp,sp,32
800003e8:	00008067          	ret

800003ec <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x)
{
800003ec:	fe010113          	addi	sp,sp,-32
800003f0:	00812e23          	sw	s0,28(sp)
800003f4:	02010413          	addi	s0,sp,32
800003f8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0"
800003fc:	fec42783          	lw	a5,-20(s0)
80000400:	30079073          	csrw	mstatus,a5
                 :
                 : "r"(x));
}
80000404:	00000013          	nop
80000408:	01c12403          	lw	s0,28(sp)
8000040c:	02010113          	addi	sp,sp,32
80000410:	00008067          	ret

80000414 <s_mstatus_xpp>:
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m)
{
80000414:	fd010113          	addi	sp,sp,-48
80000418:	02112623          	sw	ra,44(sp)
8000041c:	02812423          	sw	s0,40(sp)
80000420:	03010413          	addi	s0,sp,48
80000424:	00050793          	mv	a5,a0
80000428:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x = r_mstatus();
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
static inline uint32 r_sstatus()
{
800004e8:	fe010113          	addi	sp,sp,-32
800004ec:	00812e23          	sw	s0,28(sp)
800004f0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus"
800004f4:	100027f3          	csrr	a5,sstatus
800004f8:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
800004fc:	fec42783          	lw	a5,-20(s0)
}
80000500:	00078513          	mv	a0,a5
80000504:	01c12403          	lw	s0,28(sp)
80000508:	02010113          	addi	sp,sp,32
8000050c:	00008067          	ret

80000510 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x)
{
80000510:	fe010113          	addi	sp,sp,-32
80000514:	00812e23          	sw	s0,28(sp)
80000518:	02010413          	addi	s0,sp,32
8000051c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0"
80000520:	fec42783          	lw	a5,-20(s0)
80000524:	10079073          	csrw	sstatus,a5
                 :
                 : "r"(x));
}
80000528:	00000013          	nop
8000052c:	01c12403          	lw	s0,28(sp)
80000530:	02010113          	addi	sp,sp,32
80000534:	00008067          	ret

80000538 <w_mepc>:
                 : "=r"(x));
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x)
{
80000538:	fe010113          	addi	sp,sp,-32
8000053c:	00812e23          	sw	s0,28(sp)
80000540:	02010413          	addi	s0,sp,32
80000544:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0"
80000548:	fec42783          	lw	a5,-20(s0)
8000054c:	34179073          	csrw	mepc,a5
                 :
                 : "r"(x));
}
80000550:	00000013          	nop
80000554:	01c12403          	lw	s0,28(sp)
80000558:	02010113          	addi	sp,sp,32
8000055c:	00008067          	ret

80000560 <w_stvec>:
    asm volatile("csrr %0 , stvec"
                 : "=r"(x));
    return x;
}
static inline void w_stvec(uint32 x)
{
80000560:	fe010113          	addi	sp,sp,-32
80000564:	00812e23          	sw	s0,28(sp)
80000568:	02010413          	addi	s0,sp,32
8000056c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0"
80000570:	fec42783          	lw	a5,-20(s0)
80000574:	10579073          	csrw	stvec,a5
                 :
                 : "r"(x));
}
80000578:	00000013          	nop
8000057c:	01c12403          	lw	s0,28(sp)
80000580:	02010113          	addi	sp,sp,32
80000584:	00008067          	ret

80000588 <w_mideleg>:
    asm volatile("csrr %0 , mideleg"
                 : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x)
{
80000588:	fe010113          	addi	sp,sp,-32
8000058c:	00812e23          	sw	s0,28(sp)
80000590:	02010413          	addi	s0,sp,32
80000594:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 "
80000598:	fec42783          	lw	a5,-20(s0)
8000059c:	30379073          	csrw	mideleg,a5
                 :
                 : "r"(x));
}
800005a0:	00000013          	nop
800005a4:	01c12403          	lw	s0,28(sp)
800005a8:	02010113          	addi	sp,sp,32
800005ac:	00008067          	ret

800005b0 <w_medeleg>:
    asm volatile("csrr %0 , medeleg"
                 : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x)
{
800005b0:	fe010113          	addi	sp,sp,-32
800005b4:	00812e23          	sw	s0,28(sp)
800005b8:	02010413          	addi	s0,sp,32
800005bc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 "
800005c0:	fec42783          	lw	a5,-20(s0)
800005c4:	30279073          	csrw	medeleg,a5
                 :
                 : "r"(x));
}
800005c8:	00000013          	nop
800005cc:	01c12403          	lw	s0,28(sp)
800005d0:	02010113          	addi	sp,sp,32
800005d4:	00008067          	ret

800005d8 <w_satp>:
    asm volatile("csrr %0,satp"
                 : "=r"(x));
    return x;
}
static inline void w_satp(uint32 x)
{
800005d8:	fe010113          	addi	sp,sp,-32
800005dc:	00812e23          	sw	s0,28(sp)
800005e0:	02010413          	addi	s0,sp,32
800005e4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"
800005e8:	fec42783          	lw	a5,-20(s0)
800005ec:	18079073          	csrw	satp,a5
                 :
                 : "r"(x));
}
800005f0:	00000013          	nop
800005f4:	01c12403          	lw	s0,28(sp)
800005f8:	02010113          	addi	sp,sp,32
800005fc:	00008067          	ret

80000600 <s_sstatus_intr>:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m)
{
80000600:	fd010113          	addi	sp,sp,-48
80000604:	02112623          	sw	ra,44(sp)
80000608:	02812423          	sw	s0,40(sp)
8000060c:	03010413          	addi	s0,sp,48
80000610:	fca42e23          	sw	a0,-36(s0)
    uint32 x = r_sstatus();
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
        x |= INTR_SPIE; // 开
80000664:	fec42783          	lw	a5,-20(s0)
80000668:	0207e793          	ori	a5,a5,32
8000066c:	fef42623          	sw	a5,-20(s0)
        break;
80000670:	0340006f          	j	800006a4 <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE; // 关
80000674:	fec42783          	lw	a5,-20(s0)
80000678:	fdf7f793          	andi	a5,a5,-33
8000067c:	fef42623          	sw	a5,-20(s0)
        break;
80000680:	0240006f          	j	800006a4 <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE; // 开
80000684:	fec42783          	lw	a5,-20(s0)
80000688:	0027e793          	ori	a5,a5,2
8000068c:	fef42623          	sw	a5,-20(s0)
        break;
80000690:	0140006f          	j	800006a4 <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE; // 关
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
#include "kernel/riscv.h"

extern void main(); // 定义在main.c

void start()
{
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

    s_mstatus_xpp(RISCV_S); // 设置特权模式为 S-mode
800006e0:	00100513          	li	a0,1
800006e4:	d31ff0ef          	jal	ra,80000414 <s_mstatus_xpp>

    w_satp((uint32)0); // 暂时禁用分页
800006e8:	00000513          	li	a0,0
800006ec:	eedff0ef          	jal	ra,800005d8 <w_satp>

    w_mideleg((uint32)0xffff); // 16项中断委托给S-mode
800006f0:	000107b7          	lui	a5,0x10
800006f4:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
800006f8:	e91ff0ef          	jal	ra,80000588 <w_mideleg>
    w_medeleg((uint32)0xffff); // 16项异常委托给S-mode
800006fc:	000107b7          	lui	a5,0x10
80000700:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80000704:	eadff0ef          	jal	ra,800005b0 <w_medeleg>

    s_sstatus_intr(INTR_SIE); // S-mode 开全局中断
80000708:	00200513          	li	a0,2
8000070c:	ef5ff0ef          	jal	ra,80000600 <s_sstatus_intr>

    w_stvec((uint32)kvec); // 设置 S-mode trap处理函数
80000710:	800007b7          	lui	a5,0x80000
80000714:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000718:	00078513          	mv	a0,a5
8000071c:	e45ff0ef          	jal	ra,80000560 <w_stvec>

    timerinit(); // 时钟定时器
80000720:	370020ef          	jal	ra,80002a90 <timerinit>

    w_mepc((uint32)main); // 设置 mepc 为 main 地址
80000724:	800017b7          	lui	a5,0x80001
80000728:	90c78793          	addi	a5,a5,-1780 # 8000090c <memend+0xf800090c>
8000072c:	00078513          	mv	a0,a5
80000730:	e09ff0ef          	jal	ra,80000538 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret"); // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
80000734:	30200073          	mret
80000738:	00000013          	nop
8000073c:	00c12083          	lw	ra,12(sp)
80000740:	00812403          	lw	s0,8(sp)
80000744:	01010113          	addi	sp,sp,16
80000748:	00008067          	ret

8000074c <uartinit>:
 */
#include "types.h"
#include "uart.h"

void uartinit()
{
8000074c:	fe010113          	addi	sp,sp,-32
80000750:	00812e23          	sw	s0,28(sp)
80000754:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER, 0x00);
80000758:	100007b7          	lui	a5,0x10000
8000075c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000760:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr = uart_read(UART_LCR);      // 读取LCR寄存器值
80000764:	100007b7          	lui	a5,0x10000
80000768:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
8000076c:	0007c783          	lbu	a5,0(a5)
80000770:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR, lcr | (1 << 7)); // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
80000774:	100007b7          	lui	a5,0x10000
80000778:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
8000077c:	fef44703          	lbu	a4,-17(s0)
80000780:	f8076713          	ori	a4,a4,-128
80000784:	0ff77713          	andi	a4,a4,255
80000788:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL, 0x03); // 设置低位
8000078c:	100007b7          	lui	a5,0x10000
80000790:	00300713          	li	a4,3
80000794:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM, 0x00); // 设置高位
80000798:	100007b7          	lui	a5,0x10000
8000079c:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007a0:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr = 0;
800007a4:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR, lcr | (3 << 0));
800007a8:	100007b7          	lui	a5,0x10000
800007ac:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800007b0:	fef44703          	lbu	a4,-17(s0)
800007b4:	00376713          	ori	a4,a4,3
800007b8:	0ff77713          	andi	a4,a4,255
800007bc:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER, uart_read(UART_IER) | (1 << 0));
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
char uartputc(char c)
{
800007f4:	fe010113          	addi	sp,sp,-32
800007f8:	00812e23          	sw	s0,28(sp)
800007fc:	02010413          	addi	s0,sp,32
80000800:	00050793          	mv	a5,a0
80000804:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while (((uart_read(UART_LSR)) & (1 << 5)) == 0)
80000808:	00000013          	nop
8000080c:	100007b7          	lui	a5,0x10000
80000810:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000814:	0007c783          	lbu	a5,0(a5)
80000818:	0ff7f793          	andi	a5,a5,255
8000081c:	0207f793          	andi	a5,a5,32
80000820:	fe0786e3          	beqz	a5,8000080c <uartputc+0x18>
        ; // 轮询
    return uart_write(UART_THR, c);
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
void uartputs(char *s)
{
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
int uartgetc()
{
80000894:	ff010113          	addi	sp,sp,-16
80000898:	00812623          	sw	s0,12(sp)
8000089c:	01010413          	addi	s0,sp,16
    if (uart_read(UART_LSR) & (1 << 0))
800008a0:	100007b7          	lui	a5,0x10000
800008a4:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
800008a8:	0007c783          	lbu	a5,0(a5)
800008ac:	0ff7f793          	andi	a5,a5,255
800008b0:	0017f793          	andi	a5,a5,1
800008b4:	00078a63          	beqz	a5,800008c8 <uartgetc+0x34>
    {
        return uart_read(UART_RHR);
800008b8:	100007b7          	lui	a5,0x10000
800008bc:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
800008c0:	0ff7f793          	andi	a5,a5,255
800008c4:	0080006f          	j	800008cc <uartgetc+0x38>
    }
    else
    {
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
char uartintr()
{
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
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

void main()
{
8000090c:	ff010113          	addi	sp,sp,-16
80000910:	00112623          	sw	ra,12(sp)
80000914:	00812423          	sw	s0,8(sp)
80000918:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
8000091c:	8000c7b7          	lui	a5,0x8000c
80000920:	00c78513          	addi	a0,a5,12 # 8000c00c <memend+0xf800c00c>
80000924:	085000ef          	jal	ra,800011a8 <printf>

    minit();    // 物理内存管理
80000928:	48d000ef          	jal	ra,800015b4 <minit>
    plicinit(); // PLIC 中断处理
8000092c:	70d000ef          	jal	ra,80001838 <plicinit>

    kvminit(); // 启动虚拟内存
80000930:	3c0010ef          	jal	ra,80001cf0 <kvminit>

    printf("usertrap: %p\n", usertrap);
80000934:	800007b7          	lui	a5,0x80000
80000938:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
8000093c:	8000c7b7          	lui	a5,0x8000c
80000940:	02078513          	addi	a0,a5,32 # 8000c020 <memend+0xf800c020>
80000944:	065000ef          	jal	ra,800011a8 <printf>

    procinit();
80000948:	618010ef          	jal	ra,80001f60 <procinit>

    userinit();
8000094c:	7fc010ef          	jal	ra,80002148 <userinit>

    mmioinit();
80000950:	328020ef          	jal	ra,80002c78 <mmioinit>

    printf("----------------------\n");
80000954:	8000c7b7          	lui	a5,0x8000c
80000958:	03078513          	addi	a0,a5,48 # 8000c030 <memend+0xf800c030>
8000095c:	04d000ef          	jal	ra,800011a8 <printf>
    schedule();
80000960:	225010ef          	jal	ra,80002384 <schedule>
}
80000964:	00000013          	nop
80000968:	00c12083          	lw	ra,12(sp)
8000096c:	00812403          	lw	s0,8(sp)
80000970:	01010113          	addi	sp,sp,16
80000974:	00008067          	ret

80000978 <r_sstatus>:
    w_mstatus(x);
}

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus()
{
80000978:	fe010113          	addi	sp,sp,-32
8000097c:	00812e23          	sw	s0,28(sp)
80000980:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus"
80000984:	100027f3          	csrr	a5,sstatus
80000988:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
8000098c:	fec42783          	lw	a5,-20(s0)
}
80000990:	00078513          	mv	a0,a5
80000994:	01c12403          	lw	s0,28(sp)
80000998:	02010113          	addi	sp,sp,32
8000099c:	00008067          	ret

800009a0 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x)
{
800009a0:	fe010113          	addi	sp,sp,-32
800009a4:	00812e23          	sw	s0,28(sp)
800009a8:	02010413          	addi	s0,sp,32
800009ac:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0"
800009b0:	fec42783          	lw	a5,-20(s0)
800009b4:	10079073          	csrw	sstatus,a5
                 :
                 : "r"(x));
}
800009b8:	00000013          	nop
800009bc:	01c12403          	lw	s0,28(sp)
800009c0:	02010113          	addi	sp,sp,32
800009c4:	00008067          	ret

800009c8 <s_sstatus_xpp>:
    return x;
}
// 设置特权模式
#define S_SPP_SET (1 << 8)
static inline void s_sstatus_xpp(uint8 m)
{
800009c8:	fd010113          	addi	sp,sp,-48
800009cc:	02112623          	sw	ra,44(sp)
800009d0:	02812423          	sw	s0,40(sp)
800009d4:	03010413          	addi	s0,sp,48
800009d8:	00050793          	mv	a5,a0
800009dc:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x = r_sstatus();
800009e0:	f99ff0ef          	jal	ra,80000978 <r_sstatus>
800009e4:	fea42623          	sw	a0,-20(s0)
    switch (m)
800009e8:	fdf44783          	lbu	a5,-33(s0)
800009ec:	00078863          	beqz	a5,800009fc <s_sstatus_xpp+0x34>
800009f0:	00100713          	li	a4,1
800009f4:	00e78c63          	beq	a5,a4,80000a0c <s_sstatus_xpp+0x44>
    case RISCV_S:
        x &= ~SPP_MASK;
        x |= S_SPP_SET;
        break;
    default:
        break;
800009f8:	0300006f          	j	80000a28 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
800009fc:	fec42783          	lw	a5,-20(s0)
80000a00:	eff7f793          	andi	a5,a5,-257
80000a04:	fef42623          	sw	a5,-20(s0)
        break;
80000a08:	0200006f          	j	80000a28 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
80000a0c:	fec42783          	lw	a5,-20(s0)
80000a10:	eff7f793          	andi	a5,a5,-257
80000a14:	fef42623          	sw	a5,-20(s0)
        x |= S_SPP_SET;
80000a18:	fec42783          	lw	a5,-20(s0)
80000a1c:	1007e793          	ori	a5,a5,256
80000a20:	fef42623          	sw	a5,-20(s0)
        break;
80000a24:	00000013          	nop
    }
    w_sstatus(x);
80000a28:	fec42503          	lw	a0,-20(s0)
80000a2c:	f75ff0ef          	jal	ra,800009a0 <w_sstatus>
}
80000a30:	00000013          	nop
80000a34:	02c12083          	lw	ra,44(sp)
80000a38:	02812403          	lw	s0,40(sp)
80000a3c:	03010113          	addi	sp,sp,48
80000a40:	00008067          	ret

80000a44 <w_sepc>:
                 : "=r"(x));
    return x;
}
// 写 sepc寄存器
static inline void w_sepc(uint32 x)
{
80000a44:	fe010113          	addi	sp,sp,-32
80000a48:	00812e23          	sw	s0,28(sp)
80000a4c:	02010413          	addi	s0,sp,32
80000a50:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0"
80000a54:	fec42783          	lw	a5,-20(s0)
80000a58:	14179073          	csrw	sepc,a5
                 :
                 : "r"(x));
}
80000a5c:	00000013          	nop
80000a60:	01c12403          	lw	s0,28(sp)
80000a64:	02010113          	addi	sp,sp,32
80000a68:	00008067          	ret

80000a6c <w_stvec>:
    asm volatile("csrr %0 , stvec"
                 : "=r"(x));
    return x;
}
static inline void w_stvec(uint32 x)
{
80000a6c:	fe010113          	addi	sp,sp,-32
80000a70:	00812e23          	sw	s0,28(sp)
80000a74:	02010413          	addi	s0,sp,32
80000a78:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0"
80000a7c:	fec42783          	lw	a5,-20(s0)
80000a80:	10579073          	csrw	stvec,a5
                 :
                 : "r"(x));
}
80000a84:	00000013          	nop
80000a88:	01c12403          	lw	s0,28(sp)
80000a8c:	02010113          	addi	sp,sp,32
80000a90:	00008067          	ret

80000a94 <r_satp>:
 * asid = 地址空间标识
 * ppn  = 根页表物理页码(物理地址/4Kb)
 */
#define SATP_SV32 (1 << 31)
static inline uint32 r_satp()
{
80000a94:	fe010113          	addi	sp,sp,-32
80000a98:	00812e23          	sw	s0,28(sp)
80000a9c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,satp"
80000aa0:	180027f3          	csrr	a5,satp
80000aa4:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000aa8:	fec42783          	lw	a5,-20(s0)
}
80000aac:	00078513          	mv	a0,a5
80000ab0:	01c12403          	lw	s0,28(sp)
80000ab4:	02010113          	addi	sp,sp,32
80000ab8:	00008067          	ret

80000abc <r_scause>:
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常
 */
static inline uint32 r_scause()
{
80000abc:	fe010113          	addi	sp,sp,-32
80000ac0:	00812e23          	sw	s0,28(sp)
80000ac4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause"
80000ac8:	142027f3          	csrr	a5,scause
80000acc:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000ad0:	fec42783          	lw	a5,-20(s0)
}
80000ad4:	00078513          	mv	a0,a5
80000ad8:	01c12403          	lw	s0,28(sp)
80000adc:	02010113          	addi	sp,sp,32
80000ae0:	00008067          	ret

80000ae4 <r_stval>:
/** 如果stval在指令获取、加载或存储发生断点、
 * 地址错位、访问错误或页面错误异常时使用非
 * 零值写入，则stval将包含出错的虚拟地址。
 */
static inline uint32 r_stval()
{
80000ae4:	fe010113          	addi	sp,sp,-32
80000ae8:	00812e23          	sw	s0,28(sp)
80000aec:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,stval"
80000af0:	143027f3          	csrr	a5,stval
80000af4:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000af8:	fec42783          	lw	a5,-20(s0)
}
80000afc:	00078513          	mv	a0,a5
80000b00:	01c12403          	lw	s0,28(sp)
80000b04:	02010113          	addi	sp,sp,32
80000b08:	00008067          	ret

80000b0c <r_sip>:
/**
 * @description:
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip()
{
80000b0c:	fe010113          	addi	sp,sp,-32
80000b10:	00812e23          	sw	s0,28(sp)
80000b14:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip"
80000b18:	144027f3          	csrr	a5,sip
80000b1c:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000b20:	fec42783          	lw	a5,-20(s0)
}
80000b24:	00078513          	mv	a0,a5
80000b28:	01c12403          	lw	s0,28(sp)
80000b2c:	02010113          	addi	sp,sp,32
80000b30:	00008067          	ret

80000b34 <w_sip>:
static inline void w_sip(uint32 x)
{
80000b34:	fe010113          	addi	sp,sp,-32
80000b38:	00812e23          	sw	s0,28(sp)
80000b3c:	02010413          	addi	s0,sp,32
80000b40:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"
80000b44:	fec42783          	lw	a5,-20(s0)
80000b48:	14479073          	csrw	sip,a5
                 :
                 : "r"(x));
}
80000b4c:	00000013          	nop
80000b50:	01c12403          	lw	s0,28(sp)
80000b54:	02010113          	addi	sp,sp,32
80000b58:	00008067          	ret

80000b5c <externinterrupt>:

/**
 * @description: 处理外部中断
 */
void externinterrupt()
{
80000b5c:	fe010113          	addi	sp,sp,-32
80000b60:	00112e23          	sw	ra,28(sp)
80000b64:	00812c23          	sw	s0,24(sp)
80000b68:	02010413          	addi	s0,sp,32
    uint32 irq = r_plicclaim();
80000b6c:	591000ef          	jal	ra,800018fc <r_plicclaim>
80000b70:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n", irq);
80000b74:	fec42583          	lw	a1,-20(s0)
80000b78:	8000c7b7          	lui	a5,0x8000c
80000b7c:	04878513          	addi	a0,a5,72 # 8000c048 <memend+0xf800c048>
80000b80:	628000ef          	jal	ra,800011a8 <printf>
    switch (irq)
80000b84:	fec42703          	lw	a4,-20(s0)
80000b88:	00a00793          	li	a5,10
80000b8c:	02f71063          	bne	a4,a5,80000bac <externinterrupt+0x50>
    {
    case UART_IRQ: // uart 中断(键盘输入)
        printf("recived : %c\n", uartintr());
80000b90:	d4dff0ef          	jal	ra,800008dc <uartintr>
80000b94:	00050793          	mv	a5,a0
80000b98:	00078593          	mv	a1,a5
80000b9c:	8000c7b7          	lui	a5,0x8000c
80000ba0:	05478513          	addi	a0,a5,84 # 8000c054 <memend+0xf800c054>
80000ba4:	604000ef          	jal	ra,800011a8 <printf>
        break;
80000ba8:	0080006f          	j	80000bb0 <externinterrupt+0x54>
    default:
        break;
80000bac:	00000013          	nop
    }
    w_pliccomplete(irq);
80000bb0:	fec42503          	lw	a0,-20(s0)
80000bb4:	589000ef          	jal	ra,8000193c <w_pliccomplete>
}
80000bb8:	00000013          	nop
80000bbc:	01c12083          	lw	ra,28(sp)
80000bc0:	01812403          	lw	s0,24(sp)
80000bc4:	02010113          	addi	sp,sp,32
80000bc8:	00008067          	ret

80000bcc <ptf>:

void ptf(struct trapframe *tf)
{
80000bcc:	fe010113          	addi	sp,sp,-32
80000bd0:	00112e23          	sw	ra,28(sp)
80000bd4:	00812c23          	sw	s0,24(sp)
80000bd8:	02010413          	addi	s0,sp,32
80000bdc:	fea42623          	sw	a0,-20(s0)
    printf("kernel_sp: %d \n", tf->kernel_sp);
80000be0:	fec42783          	lw	a5,-20(s0)
80000be4:	0087a783          	lw	a5,8(a5)
80000be8:	00078593          	mv	a1,a5
80000bec:	8000c7b7          	lui	a5,0x8000c
80000bf0:	06478513          	addi	a0,a5,100 # 8000c064 <memend+0xf800c064>
80000bf4:	5b4000ef          	jal	ra,800011a8 <printf>
    printf("kernel_satp: %d \n", tf->kernel_satp);
80000bf8:	fec42783          	lw	a5,-20(s0)
80000bfc:	0007a783          	lw	a5,0(a5)
80000c00:	00078593          	mv	a1,a5
80000c04:	8000c7b7          	lui	a5,0x8000c
80000c08:	07478513          	addi	a0,a5,116 # 8000c074 <memend+0xf800c074>
80000c0c:	59c000ef          	jal	ra,800011a8 <printf>
    printf("kernel_tvec: %d \n", tf->kernel_tvec);
80000c10:	fec42783          	lw	a5,-20(s0)
80000c14:	0047a783          	lw	a5,4(a5)
80000c18:	00078593          	mv	a1,a5
80000c1c:	8000c7b7          	lui	a5,0x8000c
80000c20:	08878513          	addi	a0,a5,136 # 8000c088 <memend+0xf800c088>
80000c24:	584000ef          	jal	ra,800011a8 <printf>

    printf("ra: %d \n", tf->ra);
80000c28:	fec42783          	lw	a5,-20(s0)
80000c2c:	0107a783          	lw	a5,16(a5)
80000c30:	00078593          	mv	a1,a5
80000c34:	8000c7b7          	lui	a5,0x8000c
80000c38:	09c78513          	addi	a0,a5,156 # 8000c09c <memend+0xf800c09c>
80000c3c:	56c000ef          	jal	ra,800011a8 <printf>
    printf("sp: %d \n", tf->sp);
80000c40:	fec42783          	lw	a5,-20(s0)
80000c44:	0147a783          	lw	a5,20(a5)
80000c48:	00078593          	mv	a1,a5
80000c4c:	8000c7b7          	lui	a5,0x8000c
80000c50:	0a878513          	addi	a0,a5,168 # 8000c0a8 <memend+0xf800c0a8>
80000c54:	554000ef          	jal	ra,800011a8 <printf>
    printf("tp: %d \n", tf->tp);
80000c58:	fec42783          	lw	a5,-20(s0)
80000c5c:	01c7a783          	lw	a5,28(a5)
80000c60:	00078593          	mv	a1,a5
80000c64:	8000c7b7          	lui	a5,0x8000c
80000c68:	0b478513          	addi	a0,a5,180 # 8000c0b4 <memend+0xf800c0b4>
80000c6c:	53c000ef          	jal	ra,800011a8 <printf>
    printf("t0: %d \n", tf->t0);
80000c70:	fec42783          	lw	a5,-20(s0)
80000c74:	0707a783          	lw	a5,112(a5)
80000c78:	00078593          	mv	a1,a5
80000c7c:	8000c7b7          	lui	a5,0x8000c
80000c80:	0c078513          	addi	a0,a5,192 # 8000c0c0 <memend+0xf800c0c0>
80000c84:	524000ef          	jal	ra,800011a8 <printf>
    printf("t1: %d \n", tf->t1);
80000c88:	fec42783          	lw	a5,-20(s0)
80000c8c:	0747a783          	lw	a5,116(a5)
80000c90:	00078593          	mv	a1,a5
80000c94:	8000c7b7          	lui	a5,0x8000c
80000c98:	0cc78513          	addi	a0,a5,204 # 8000c0cc <memend+0xf800c0cc>
80000c9c:	50c000ef          	jal	ra,800011a8 <printf>
    printf("t2: %d \n", tf->t2);
80000ca0:	fec42783          	lw	a5,-20(s0)
80000ca4:	0787a783          	lw	a5,120(a5)
80000ca8:	00078593          	mv	a1,a5
80000cac:	8000c7b7          	lui	a5,0x8000c
80000cb0:	0d878513          	addi	a0,a5,216 # 8000c0d8 <memend+0xf800c0d8>
80000cb4:	4f4000ef          	jal	ra,800011a8 <printf>
    printf("t3: %d \n", tf->t3);
80000cb8:	fec42783          	lw	a5,-20(s0)
80000cbc:	07c7a783          	lw	a5,124(a5)
80000cc0:	00078593          	mv	a1,a5
80000cc4:	8000c7b7          	lui	a5,0x8000c
80000cc8:	0e478513          	addi	a0,a5,228 # 8000c0e4 <memend+0xf800c0e4>
80000ccc:	4dc000ef          	jal	ra,800011a8 <printf>
    printf("t4: %d \n", tf->t4);
80000cd0:	fec42783          	lw	a5,-20(s0)
80000cd4:	0807a783          	lw	a5,128(a5)
80000cd8:	00078593          	mv	a1,a5
80000cdc:	8000c7b7          	lui	a5,0x8000c
80000ce0:	0f078513          	addi	a0,a5,240 # 8000c0f0 <memend+0xf800c0f0>
80000ce4:	4c4000ef          	jal	ra,800011a8 <printf>
    printf("t5: %d \n", tf->t5);
80000ce8:	fec42783          	lw	a5,-20(s0)
80000cec:	0847a783          	lw	a5,132(a5)
80000cf0:	00078593          	mv	a1,a5
80000cf4:	8000c7b7          	lui	a5,0x8000c
80000cf8:	0fc78513          	addi	a0,a5,252 # 8000c0fc <memend+0xf800c0fc>
80000cfc:	4ac000ef          	jal	ra,800011a8 <printf>
    printf("t6: %d \n", tf->t6);
80000d00:	fec42783          	lw	a5,-20(s0)
80000d04:	0887a783          	lw	a5,136(a5)
80000d08:	00078593          	mv	a1,a5
80000d0c:	8000c7b7          	lui	a5,0x8000c
80000d10:	10878513          	addi	a0,a5,264 # 8000c108 <memend+0xf800c108>
80000d14:	494000ef          	jal	ra,800011a8 <printf>
    printf("a0: %d \n", tf->a0);
80000d18:	fec42783          	lw	a5,-20(s0)
80000d1c:	0207a783          	lw	a5,32(a5)
80000d20:	00078593          	mv	a1,a5
80000d24:	8000c7b7          	lui	a5,0x8000c
80000d28:	11478513          	addi	a0,a5,276 # 8000c114 <memend+0xf800c114>
80000d2c:	47c000ef          	jal	ra,800011a8 <printf>
    printf("a1: %d \n", tf->a1);
80000d30:	fec42783          	lw	a5,-20(s0)
80000d34:	0247a783          	lw	a5,36(a5)
80000d38:	00078593          	mv	a1,a5
80000d3c:	8000c7b7          	lui	a5,0x8000c
80000d40:	12078513          	addi	a0,a5,288 # 8000c120 <memend+0xf800c120>
80000d44:	464000ef          	jal	ra,800011a8 <printf>
    printf("a2: %d \n", tf->a2);
80000d48:	fec42783          	lw	a5,-20(s0)
80000d4c:	0287a783          	lw	a5,40(a5)
80000d50:	00078593          	mv	a1,a5
80000d54:	8000c7b7          	lui	a5,0x8000c
80000d58:	12c78513          	addi	a0,a5,300 # 8000c12c <memend+0xf800c12c>
80000d5c:	44c000ef          	jal	ra,800011a8 <printf>
    printf("a3: %d \n", tf->a3);
80000d60:	fec42783          	lw	a5,-20(s0)
80000d64:	02c7a783          	lw	a5,44(a5)
80000d68:	00078593          	mv	a1,a5
80000d6c:	8000c7b7          	lui	a5,0x8000c
80000d70:	13878513          	addi	a0,a5,312 # 8000c138 <memend+0xf800c138>
80000d74:	434000ef          	jal	ra,800011a8 <printf>
    printf("a4: %d \n", tf->a4);
80000d78:	fec42783          	lw	a5,-20(s0)
80000d7c:	0307a783          	lw	a5,48(a5)
80000d80:	00078593          	mv	a1,a5
80000d84:	8000c7b7          	lui	a5,0x8000c
80000d88:	14478513          	addi	a0,a5,324 # 8000c144 <memend+0xf800c144>
80000d8c:	41c000ef          	jal	ra,800011a8 <printf>
    printf("a5: %d \n", tf->a5);
80000d90:	fec42783          	lw	a5,-20(s0)
80000d94:	0347a783          	lw	a5,52(a5)
80000d98:	00078593          	mv	a1,a5
80000d9c:	8000c7b7          	lui	a5,0x8000c
80000da0:	15078513          	addi	a0,a5,336 # 8000c150 <memend+0xf800c150>
80000da4:	404000ef          	jal	ra,800011a8 <printf>
    printf("a6: %d \n", tf->a6);
80000da8:	fec42783          	lw	a5,-20(s0)
80000dac:	0387a783          	lw	a5,56(a5)
80000db0:	00078593          	mv	a1,a5
80000db4:	8000c7b7          	lui	a5,0x8000c
80000db8:	15c78513          	addi	a0,a5,348 # 8000c15c <memend+0xf800c15c>
80000dbc:	3ec000ef          	jal	ra,800011a8 <printf>
    printf("a7: %d \n", tf->a7);
80000dc0:	fec42783          	lw	a5,-20(s0)
80000dc4:	03c7a783          	lw	a5,60(a5)
80000dc8:	00078593          	mv	a1,a5
80000dcc:	8000c7b7          	lui	a5,0x8000c
80000dd0:	16878513          	addi	a0,a5,360 # 8000c168 <memend+0xf800c168>
80000dd4:	3d4000ef          	jal	ra,800011a8 <printf>
}
80000dd8:	00000013          	nop
80000ddc:	01c12083          	lw	ra,28(sp)
80000de0:	01812403          	lw	s0,24(sp)
80000de4:	02010113          	addi	sp,sp,32
80000de8:	00008067          	ret

80000dec <usertrapret>:

// 返回用户空间
void usertrapret()
{
80000dec:	fe010113          	addi	sp,sp,-32
80000df0:	00112e23          	sw	ra,28(sp)
80000df4:	00812c23          	sw	s0,24(sp)
80000df8:	00912a23          	sw	s1,20(sp)
80000dfc:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80000e00:	1e0010ef          	jal	ra,80001fe0 <nowproc>
80000e04:	fea42623          	sw	a0,-20(s0)
    s_sstatus_xpp(RISCV_U);
80000e08:	00000513          	li	a0,0
80000e0c:	bbdff0ef          	jal	ra,800009c8 <s_sstatus_xpp>
    w_stvec((uint32)usertrap);
80000e10:	800007b7          	lui	a5,0x80000
80000e14:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80000e18:	00078513          	mv	a0,a5
80000e1c:	c51ff0ef          	jal	ra,80000a6c <w_stvec>
    addr_t satp = (SATP_SV32 | (addr_t)(p->pagetable) >> 12);
80000e20:	fec42783          	lw	a5,-20(s0)
80000e24:	0887a783          	lw	a5,136(a5)
80000e28:	00c7d713          	srli	a4,a5,0xc
80000e2c:	800007b7          	lui	a5,0x80000
80000e30:	00f767b3          	or	a5,a4,a5
80000e34:	fef42423          	sw	a5,-24(s0)
    // ptf(p->trapframe);

    // printf("%p\n",p->trapframe);
    // printf("sepc: %p\n",r_sepc());

    w_sepc((addr_t)p->trapframe->epc);
80000e38:	fec42783          	lw	a5,-20(s0)
80000e3c:	0087a783          	lw	a5,8(a5) # 80000008 <memend+0xf8000008>
80000e40:	00c7a783          	lw	a5,12(a5)
80000e44:	00078513          	mv	a0,a5
80000e48:	bfdff0ef          	jal	ra,80000a44 <w_sepc>

    p->trapframe->kernel_satp = r_satp();
80000e4c:	fec42783          	lw	a5,-20(s0)
80000e50:	0087a483          	lw	s1,8(a5)
80000e54:	c41ff0ef          	jal	ra,80000a94 <r_satp>
80000e58:	00050793          	mv	a5,a0
80000e5c:	00f4a023          	sw	a5,0(s1)
    p->trapframe->kernel_tvec = (addr_t)trapvec;
80000e60:	fec42783          	lw	a5,-20(s0)
80000e64:	0087a783          	lw	a5,8(a5)
80000e68:	80001737          	lui	a4,0x80001
80000e6c:	f1c70713          	addi	a4,a4,-228 # 80000f1c <memend+0xf8000f1c>
80000e70:	00e7a223          	sw	a4,4(a5)
    p->trapframe->kernel_sp = (addr_t)p->kernelstack;
80000e74:	fec42783          	lw	a5,-20(s0)
80000e78:	0087a783          	lw	a5,8(a5)
80000e7c:	fec42703          	lw	a4,-20(s0)
80000e80:	08c72703          	lw	a4,140(a4)
80000e84:	00e7a423          	sw	a4,8(a5)

    // printf("%p\n",p->kernelstack);
    userret((addr_t *)TRAPFRAME, satp);
80000e88:	fe842583          	lw	a1,-24(s0)
80000e8c:	ffffe537          	lui	a0,0xffffe
80000e90:	ca0ff0ef          	jal	ra,80000330 <userret>
}
80000e94:	00000013          	nop
80000e98:	01c12083          	lw	ra,28(sp)
80000e9c:	01812403          	lw	s0,24(sp)
80000ea0:	01412483          	lw	s1,20(sp)
80000ea4:	02010113          	addi	sp,sp,32
80000ea8:	00008067          	ret

80000eac <startproc>:

static int first = 0;
void startproc()
{
80000eac:	ff010113          	addi	sp,sp,-16
80000eb0:	00112623          	sw	ra,12(sp)
80000eb4:	00812423          	sw	s0,8(sp)
80000eb8:	01010413          	addi	s0,sp,16
    first = 1;
80000ebc:	8000d7b7          	lui	a5,0x8000d
80000ec0:	00100713          	li	a4,1
80000ec4:	00e7a223          	sw	a4,4(a5) # 8000d004 <memend+0xf800d004>
    usertrapret();
80000ec8:	f25ff0ef          	jal	ra,80000dec <usertrapret>
}
80000ecc:	00000013          	nop
80000ed0:	00c12083          	lw	ra,12(sp)
80000ed4:	00812403          	lw	s0,8(sp)
80000ed8:	01010113          	addi	sp,sp,16
80000edc:	00008067          	ret

80000ee0 <timerintr>:

void timerintr()
{
80000ee0:	ff010113          	addi	sp,sp,-16
80000ee4:	00112623          	sw	ra,12(sp)
80000ee8:	00812423          	sw	s0,8(sp)
80000eec:	01010413          	addi	s0,sp,16
    w_sip(r_sip() & ~2); // 清除中断
80000ef0:	c1dff0ef          	jal	ra,80000b0c <r_sip>
80000ef4:	00050793          	mv	a5,a0
80000ef8:	ffd7f793          	andi	a5,a5,-3
80000efc:	00078513          	mv	a0,a5
80000f00:	c35ff0ef          	jal	ra,80000b34 <w_sip>
    yield();
80000f04:	514010ef          	jal	ra,80002418 <yield>
}
80000f08:	00000013          	nop
80000f0c:	00c12083          	lw	ra,12(sp)
80000f10:	00812403          	lw	s0,8(sp)
80000f14:	01010113          	addi	sp,sp,16
80000f18:	00008067          	ret

80000f1c <trapvec>:

void trapvec()
{
80000f1c:	fe010113          	addi	sp,sp,-32
80000f20:	00112e23          	sw	ra,28(sp)
80000f24:	00812c23          	sw	s0,24(sp)
80000f28:	02010413          	addi	s0,sp,32
    int where = r_sstatus() & S_SPP_SET;
80000f2c:	a4dff0ef          	jal	ra,80000978 <r_sstatus>
80000f30:	00050793          	mv	a5,a0
80000f34:	1007f793          	andi	a5,a5,256
80000f38:	fef42623          	sw	a5,-20(s0)
    w_stvec((reg_t)kvec);
80000f3c:	800007b7          	lui	a5,0x80000
80000f40:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000f44:	00078513          	mv	a0,a5
80000f48:	b25ff0ef          	jal	ra,80000a6c <w_stvec>

    uint32 scause = r_scause();
80000f4c:	b71ff0ef          	jal	ra,80000abc <r_scause>
80000f50:	fea42423          	sw	a0,-24(s0)

    uint16 code = scause & 0xffff;
80000f54:	fe842783          	lw	a5,-24(s0)
80000f58:	fef41323          	sh	a5,-26(s0)

    if (scause & (1 << 31))
80000f5c:	fe842783          	lw	a5,-24(s0)
80000f60:	0607dc63          	bgez	a5,80000fd8 <trapvec+0xbc>
    {
        //     printf("Interrupt : ");
        switch (code)
80000f64:	fe645783          	lhu	a5,-26(s0)
80000f68:	00900713          	li	a4,9
80000f6c:	02e78c63          	beq	a5,a4,80000fa4 <trapvec+0x88>
80000f70:	00900713          	li	a4,9
80000f74:	04f74263          	blt	a4,a5,80000fb8 <trapvec+0x9c>
80000f78:	00100713          	li	a4,1
80000f7c:	00e78863          	beq	a5,a4,80000f8c <trapvec+0x70>
80000f80:	00500713          	li	a4,5
80000f84:	00e78863          	beq	a5,a4,80000f94 <trapvec+0x78>
80000f88:	0300006f          	j	80000fb8 <trapvec+0x9c>
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
80000f8c:	f55ff0ef          	jal	ra,80000ee0 <timerintr>
            break;
80000f90:	0380006f          	j	80000fc8 <trapvec+0xac>
        case 5:
            printf("Supervisor timer interrupt\n");
80000f94:	8000c7b7          	lui	a5,0x8000c
80000f98:	17478513          	addi	a0,a5,372 # 8000c174 <memend+0xf800c174>
80000f9c:	20c000ef          	jal	ra,800011a8 <printf>
            break;
80000fa0:	0280006f          	j	80000fc8 <trapvec+0xac>
        case 9:
            printf("Supervisor external interrupt\n");
80000fa4:	8000c7b7          	lui	a5,0x8000c
80000fa8:	19078513          	addi	a0,a5,400 # 8000c190 <memend+0xf800c190>
80000fac:	1fc000ef          	jal	ra,800011a8 <printf>
            externinterrupt();
80000fb0:	badff0ef          	jal	ra,80000b5c <externinterrupt>
            break;
80000fb4:	0140006f          	j	80000fc8 <trapvec+0xac>
        default:
            printf("Other interrupt\n");
80000fb8:	8000c7b7          	lui	a5,0x8000c
80000fbc:	1b078513          	addi	a0,a5,432 # 8000c1b0 <memend+0xf800c1b0>
80000fc0:	1e8000ef          	jal	ra,800011a8 <printf>
            break;
80000fc4:	00000013          	nop
        }
        where ?: usertrapret();
80000fc8:	fec42783          	lw	a5,-20(s0)
80000fcc:	18079863          	bnez	a5,8000115c <trapvec+0x240>
80000fd0:	e1dff0ef          	jal	ra,80000dec <usertrapret>
            printf("Other\n");
            break;
        }
        panic("Trap Exception");
    }
}
80000fd4:	1880006f          	j	8000115c <trapvec+0x240>
        printf("Exception : ");
80000fd8:	8000c7b7          	lui	a5,0x8000c
80000fdc:	1c478513          	addi	a0,a5,452 # 8000c1c4 <memend+0xf800c1c4>
80000fe0:	1c8000ef          	jal	ra,800011a8 <printf>
        switch (code)
80000fe4:	fe645783          	lhu	a5,-26(s0)
80000fe8:	00f00713          	li	a4,15
80000fec:	14f76a63          	bltu	a4,a5,80001140 <trapvec+0x224>
80000ff0:	00279713          	slli	a4,a5,0x2
80000ff4:	8000c7b7          	lui	a5,0x8000c
80000ff8:	34878793          	addi	a5,a5,840 # 8000c348 <memend+0xf800c348>
80000ffc:	00f707b3          	add	a5,a4,a5
80001000:	0007a783          	lw	a5,0(a5)
80001004:	00078067          	jr	a5
            printf("Instruction address misaligned\n");
80001008:	8000c7b7          	lui	a5,0x8000c
8000100c:	1d478513          	addi	a0,a5,468 # 8000c1d4 <memend+0xf800c1d4>
80001010:	198000ef          	jal	ra,800011a8 <printf>
            break;
80001014:	13c0006f          	j	80001150 <trapvec+0x234>
            printf("Instruction access fault\n");
80001018:	8000c7b7          	lui	a5,0x8000c
8000101c:	1f478513          	addi	a0,a5,500 # 8000c1f4 <memend+0xf800c1f4>
80001020:	188000ef          	jal	ra,800011a8 <printf>
            break;
80001024:	12c0006f          	j	80001150 <trapvec+0x234>
            printf("Illegal instruction\n");
80001028:	8000c7b7          	lui	a5,0x8000c
8000102c:	21078513          	addi	a0,a5,528 # 8000c210 <memend+0xf800c210>
80001030:	178000ef          	jal	ra,800011a8 <printf>
            break;
80001034:	11c0006f          	j	80001150 <trapvec+0x234>
            printf("Breakpoint\n");
80001038:	8000c7b7          	lui	a5,0x8000c
8000103c:	22878513          	addi	a0,a5,552 # 8000c228 <memend+0xf800c228>
80001040:	168000ef          	jal	ra,800011a8 <printf>
            break;
80001044:	10c0006f          	j	80001150 <trapvec+0x234>
            printf("Load address misaligned\n");
80001048:	8000c7b7          	lui	a5,0x8000c
8000104c:	23478513          	addi	a0,a5,564 # 8000c234 <memend+0xf800c234>
80001050:	158000ef          	jal	ra,800011a8 <printf>
            break;
80001054:	0fc0006f          	j	80001150 <trapvec+0x234>
            printf("Load access fault\n");
80001058:	8000c7b7          	lui	a5,0x8000c
8000105c:	25078513          	addi	a0,a5,592 # 8000c250 <memend+0xf800c250>
80001060:	148000ef          	jal	ra,800011a8 <printf>
            printf("stval va: %p\n", r_stval());
80001064:	a81ff0ef          	jal	ra,80000ae4 <r_stval>
80001068:	00050793          	mv	a5,a0
8000106c:	00078593          	mv	a1,a5
80001070:	8000c7b7          	lui	a5,0x8000c
80001074:	26478513          	addi	a0,a5,612 # 8000c264 <memend+0xf800c264>
80001078:	130000ef          	jal	ra,800011a8 <printf>
            break;
8000107c:	0d40006f          	j	80001150 <trapvec+0x234>
            printf("Store/AMO address misaligned\n");
80001080:	8000c7b7          	lui	a5,0x8000c
80001084:	27478513          	addi	a0,a5,628 # 8000c274 <memend+0xf800c274>
80001088:	120000ef          	jal	ra,800011a8 <printf>
            break;
8000108c:	0c40006f          	j	80001150 <trapvec+0x234>
            printf("Store/AMO access fault\n");
80001090:	8000c7b7          	lui	a5,0x8000c
80001094:	29478513          	addi	a0,a5,660 # 8000c294 <memend+0xf800c294>
80001098:	110000ef          	jal	ra,800011a8 <printf>
            printf("stval va: %p\n", r_stval());
8000109c:	a49ff0ef          	jal	ra,80000ae4 <r_stval>
800010a0:	00050793          	mv	a5,a0
800010a4:	00078593          	mv	a1,a5
800010a8:	8000c7b7          	lui	a5,0x8000c
800010ac:	26478513          	addi	a0,a5,612 # 8000c264 <memend+0xf800c264>
800010b0:	0f8000ef          	jal	ra,800011a8 <printf>
            break;
800010b4:	09c0006f          	j	80001150 <trapvec+0x234>
            printf("Environment call from U-mode\n");
800010b8:	8000c7b7          	lui	a5,0x8000c
800010bc:	2ac78513          	addi	a0,a5,684 # 8000c2ac <memend+0xf800c2ac>
800010c0:	0e8000ef          	jal	ra,800011a8 <printf>
            syscall();
800010c4:	315010ef          	jal	ra,80002bd8 <syscall>
            usertrapret();
800010c8:	d25ff0ef          	jal	ra,80000dec <usertrapret>
            break;
800010cc:	0840006f          	j	80001150 <trapvec+0x234>
            printf("Environment call from S-mode\n");
800010d0:	8000c7b7          	lui	a5,0x8000c
800010d4:	2cc78513          	addi	a0,a5,716 # 8000c2cc <memend+0xf800c2cc>
800010d8:	0d0000ef          	jal	ra,800011a8 <printf>
            first ? usertrapret() : startproc();
800010dc:	8000d7b7          	lui	a5,0x8000d
800010e0:	0047a783          	lw	a5,4(a5) # 8000d004 <memend+0xf800d004>
800010e4:	00078663          	beqz	a5,800010f0 <trapvec+0x1d4>
800010e8:	d05ff0ef          	jal	ra,80000dec <usertrapret>
            break;
800010ec:	0640006f          	j	80001150 <trapvec+0x234>
            first ? usertrapret() : startproc();
800010f0:	dbdff0ef          	jal	ra,80000eac <startproc>
            break;
800010f4:	05c0006f          	j	80001150 <trapvec+0x234>
            printf("Instruction page fault\n");
800010f8:	8000c7b7          	lui	a5,0x8000c
800010fc:	2ec78513          	addi	a0,a5,748 # 8000c2ec <memend+0xf800c2ec>
80001100:	0a8000ef          	jal	ra,800011a8 <printf>
            printf("stval va: %p\n", r_stval());
80001104:	9e1ff0ef          	jal	ra,80000ae4 <r_stval>
80001108:	00050793          	mv	a5,a0
8000110c:	00078593          	mv	a1,a5
80001110:	8000c7b7          	lui	a5,0x8000c
80001114:	26478513          	addi	a0,a5,612 # 8000c264 <memend+0xf800c264>
80001118:	090000ef          	jal	ra,800011a8 <printf>
            break;
8000111c:	0340006f          	j	80001150 <trapvec+0x234>
            printf("Load page fault\n");
80001120:	8000c7b7          	lui	a5,0x8000c
80001124:	30478513          	addi	a0,a5,772 # 8000c304 <memend+0xf800c304>
80001128:	080000ef          	jal	ra,800011a8 <printf>
            break;
8000112c:	0240006f          	j	80001150 <trapvec+0x234>
            printf("Store/AMO page fault\n");
80001130:	8000c7b7          	lui	a5,0x8000c
80001134:	31878513          	addi	a0,a5,792 # 8000c318 <memend+0xf800c318>
80001138:	070000ef          	jal	ra,800011a8 <printf>
            break;
8000113c:	0140006f          	j	80001150 <trapvec+0x234>
            printf("Other\n");
80001140:	8000c7b7          	lui	a5,0x8000c
80001144:	33078513          	addi	a0,a5,816 # 8000c330 <memend+0xf800c330>
80001148:	060000ef          	jal	ra,800011a8 <printf>
            break;
8000114c:	00000013          	nop
        panic("Trap Exception");
80001150:	8000c7b7          	lui	a5,0x8000c
80001154:	33878513          	addi	a0,a5,824 # 8000c338 <memend+0xf800c338>
80001158:	018000ef          	jal	ra,80001170 <panic>
}
8000115c:	00000013          	nop
80001160:	01c12083          	lw	ra,28(sp)
80001164:	01812403          	lw	s0,24(sp)
80001168:	02010113          	addi	sp,sp,32
8000116c:	00008067          	ret

80001170 <panic>:
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char *s)
{
80001170:	fe010113          	addi	sp,sp,-32
80001174:	00112e23          	sw	ra,28(sp)
80001178:	00812c23          	sw	s0,24(sp)
8000117c:	02010413          	addi	s0,sp,32
80001180:	fea42623          	sw	a0,-20(s0)
	uartputs("panic: ");
80001184:	8000c7b7          	lui	a5,0x8000c
80001188:	38878513          	addi	a0,a5,904 # 8000c388 <memend+0xf800c388>
8000118c:	eb4ff0ef          	jal	ra,80000840 <uartputs>
	uartputs(s);
80001190:	fec42503          	lw	a0,-20(s0)
80001194:	eacff0ef          	jal	ra,80000840 <uartputs>
	uartputs("\n");
80001198:	8000c7b7          	lui	a5,0x8000c
8000119c:	39078513          	addi	a0,a5,912 # 8000c390 <memend+0xf800c390>
800011a0:	ea0ff0ef          	jal	ra,80000840 <uartputs>
	while (1)
800011a4:	0000006f          	j	800011a4 <panic+0x34>

800011a8 <printf>:

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char *fmt, ...)
{
800011a8:	f8010113          	addi	sp,sp,-128
800011ac:	04112e23          	sw	ra,92(sp)
800011b0:	04812c23          	sw	s0,88(sp)
800011b4:	06010413          	addi	s0,sp,96
800011b8:	faa42623          	sw	a0,-84(s0)
800011bc:	00b42223          	sw	a1,4(s0)
800011c0:	00c42423          	sw	a2,8(s0)
800011c4:	00d42623          	sw	a3,12(s0)
800011c8:	00e42823          	sw	a4,16(s0)
800011cc:	00f42a23          	sw	a5,20(s0)
800011d0:	01042c23          	sw	a6,24(s0)
800011d4:	01142e23          	sw	a7,28(s0)
	va_list vl;		   // 保存参数的地址，定义在stdarg.h
	va_start(vl, fmt); // 将vl指向fmt后面的参数
800011d8:	02040793          	addi	a5,s0,32
800011dc:	faf42423          	sw	a5,-88(s0)
800011e0:	fa842783          	lw	a5,-88(s0)
800011e4:	fe478793          	addi	a5,a5,-28
800011e8:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char *s = fmt;
800011ec:	fac42783          	lw	a5,-84(s0)
800011f0:	fef42623          	sw	a5,-20(s0)
	int tt = 0;
800011f4:	fe042423          	sw	zero,-24(s0)
	int idx = 0;
800011f8:	fe042223          	sw	zero,-28(s0)
	while ((ch = *(s)))
800011fc:	36c0006f          	j	80001568 <printf+0x3c0>
	{
		if (ch == '%')
80001200:	fbf44703          	lbu	a4,-65(s0)
80001204:	02500793          	li	a5,37
80001208:	04f71863          	bne	a4,a5,80001258 <printf+0xb0>
		{
			if (tt == 1)
8000120c:	fe842703          	lw	a4,-24(s0)
80001210:	00100793          	li	a5,1
80001214:	02f71663          	bne	a4,a5,80001240 <printf+0x98>
			{
				outbuf[idx++] = '%';
80001218:	fe442783          	lw	a5,-28(s0)
8000121c:	00178713          	addi	a4,a5,1
80001220:	fee42223          	sw	a4,-28(s0)
80001224:	8000d737          	lui	a4,0x8000d
80001228:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
8000122c:	00f707b3          	add	a5,a4,a5
80001230:	02500713          	li	a4,37
80001234:	00e78023          	sb	a4,0(a5)
				tt = 0;
80001238:	fe042423          	sw	zero,-24(s0)
8000123c:	00c0006f          	j	80001248 <printf+0xa0>
			}
			else
			{
				tt = 1;
80001240:	00100793          	li	a5,1
80001244:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80001248:	fec42783          	lw	a5,-20(s0)
8000124c:	00178793          	addi	a5,a5,1
80001250:	fef42623          	sw	a5,-20(s0)
80001254:	3140006f          	j	80001568 <printf+0x3c0>
		}
		else
		{
			if (tt == 1)
80001258:	fe842703          	lw	a4,-24(s0)
8000125c:	00100793          	li	a5,1
80001260:	2cf71e63          	bne	a4,a5,8000153c <printf+0x394>
			{
				switch (ch)
80001264:	fbf44783          	lbu	a5,-65(s0)
80001268:	fa878793          	addi	a5,a5,-88
8000126c:	02000713          	li	a4,32
80001270:	2af76663          	bltu	a4,a5,8000151c <printf+0x374>
80001274:	00279713          	slli	a4,a5,0x2
80001278:	8000c7b7          	lui	a5,0x8000c
8000127c:	3ac78793          	addi	a5,a5,940 # 8000c3ac <memend+0xf800c3ac>
80001280:	00f707b3          	add	a5,a4,a5
80001284:	0007a783          	lw	a5,0(a5)
80001288:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x = va_arg(vl, int);
8000128c:	fb842783          	lw	a5,-72(s0)
80001290:	00478713          	addi	a4,a5,4
80001294:	fae42c23          	sw	a4,-72(s0)
80001298:	0007a783          	lw	a5,0(a5)
8000129c:	fef42023          	sw	a5,-32(s0)
					int len = 0;
800012a0:	fc042e23          	sw	zero,-36(s0)
					for (int n = x; n /= 10; len++)
800012a4:	fe042783          	lw	a5,-32(s0)
800012a8:	fcf42c23          	sw	a5,-40(s0)
800012ac:	0100006f          	j	800012bc <printf+0x114>
800012b0:	fdc42783          	lw	a5,-36(s0)
800012b4:	00178793          	addi	a5,a5,1
800012b8:	fcf42e23          	sw	a5,-36(s0)
800012bc:	fd842703          	lw	a4,-40(s0)
800012c0:	00a00793          	li	a5,10
800012c4:	02f747b3          	div	a5,a4,a5
800012c8:	fcf42c23          	sw	a5,-40(s0)
800012cc:	fd842783          	lw	a5,-40(s0)
800012d0:	fe0790e3          	bnez	a5,800012b0 <printf+0x108>
						;
					for (int i = len; i >= 0; i--)
800012d4:	fdc42783          	lw	a5,-36(s0)
800012d8:	fcf42a23          	sw	a5,-44(s0)
800012dc:	0540006f          	j	80001330 <printf+0x188>
					{
						outbuf[idx + i] = '0' + (x % 10);
800012e0:	fe042703          	lw	a4,-32(s0)
800012e4:	00a00793          	li	a5,10
800012e8:	02f767b3          	rem	a5,a4,a5
800012ec:	0ff7f713          	andi	a4,a5,255
800012f0:	fe442683          	lw	a3,-28(s0)
800012f4:	fd442783          	lw	a5,-44(s0)
800012f8:	00f687b3          	add	a5,a3,a5
800012fc:	03070713          	addi	a4,a4,48
80001300:	0ff77713          	andi	a4,a4,255
80001304:	8000d6b7          	lui	a3,0x8000d
80001308:	00868693          	addi	a3,a3,8 # 8000d008 <memend+0xf800d008>
8000130c:	00f687b3          	add	a5,a3,a5
80001310:	00e78023          	sb	a4,0(a5)
						x /= 10;
80001314:	fe042703          	lw	a4,-32(s0)
80001318:	00a00793          	li	a5,10
8000131c:	02f747b3          	div	a5,a4,a5
80001320:	fef42023          	sw	a5,-32(s0)
					for (int i = len; i >= 0; i--)
80001324:	fd442783          	lw	a5,-44(s0)
80001328:	fff78793          	addi	a5,a5,-1
8000132c:	fcf42a23          	sw	a5,-44(s0)
80001330:	fd442783          	lw	a5,-44(s0)
80001334:	fa07d6e3          	bgez	a5,800012e0 <printf+0x138>
					}
					idx += (len + 1);
80001338:	fdc42783          	lw	a5,-36(s0)
8000133c:	00178793          	addi	a5,a5,1
80001340:	fe442703          	lw	a4,-28(s0)
80001344:	00f707b3          	add	a5,a4,a5
80001348:	fef42223          	sw	a5,-28(s0)
					tt = 0;
8000134c:	fe042423          	sw	zero,-24(s0)
					break;
80001350:	1dc0006f          	j	8000152c <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++] = '0';
80001354:	fe442783          	lw	a5,-28(s0)
80001358:	00178713          	addi	a4,a5,1
8000135c:	fee42223          	sw	a4,-28(s0)
80001360:	8000d737          	lui	a4,0x8000d
80001364:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001368:	00f707b3          	add	a5,a4,a5
8000136c:	03000713          	li	a4,48
80001370:	00e78023          	sb	a4,0(a5)
					outbuf[idx++] = 'x';
80001374:	fe442783          	lw	a5,-28(s0)
80001378:	00178713          	addi	a4,a5,1
8000137c:	fee42223          	sw	a4,-28(s0)
80001380:	8000d737          	lui	a4,0x8000d
80001384:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001388:	00f707b3          	add	a5,a4,a5
8000138c:	07800713          	li	a4,120
80001390:	00e78023          	sb	a4,0(a5)
				} // 接着下面输出16进制数
				case 'x':
				case 'X': // 大小写一致
				{
					uint x = va_arg(vl, uint);
80001394:	fb842783          	lw	a5,-72(s0)
80001398:	00478713          	addi	a4,a5,4
8000139c:	fae42c23          	sw	a4,-72(s0)
800013a0:	0007a783          	lw	a5,0(a5)
800013a4:	fcf42823          	sw	a5,-48(s0)
					int len = 0;
800013a8:	fc042623          	sw	zero,-52(s0)
					for (unsigned int n = x; n /= 16; len++)
800013ac:	fd042783          	lw	a5,-48(s0)
800013b0:	fcf42423          	sw	a5,-56(s0)
800013b4:	0100006f          	j	800013c4 <printf+0x21c>
800013b8:	fcc42783          	lw	a5,-52(s0)
800013bc:	00178793          	addi	a5,a5,1
800013c0:	fcf42623          	sw	a5,-52(s0)
800013c4:	fc842783          	lw	a5,-56(s0)
800013c8:	0047d793          	srli	a5,a5,0x4
800013cc:	fcf42423          	sw	a5,-56(s0)
800013d0:	fc842783          	lw	a5,-56(s0)
800013d4:	fe0792e3          	bnez	a5,800013b8 <printf+0x210>
						;
					for (int i = len; i >= 0; i--)
800013d8:	fcc42783          	lw	a5,-52(s0)
800013dc:	fcf42223          	sw	a5,-60(s0)
800013e0:	0840006f          	j	80001464 <printf+0x2bc>
					{
						char c = (x % 16) >= 10 ? 'a' + ((x % 16) - 10) : '0' + (x % 16);
800013e4:	fd042783          	lw	a5,-48(s0)
800013e8:	00f7f713          	andi	a4,a5,15
800013ec:	00900793          	li	a5,9
800013f0:	02e7f063          	bgeu	a5,a4,80001410 <printf+0x268>
800013f4:	fd042783          	lw	a5,-48(s0)
800013f8:	0ff7f793          	andi	a5,a5,255
800013fc:	00f7f793          	andi	a5,a5,15
80001400:	0ff7f793          	andi	a5,a5,255
80001404:	05778793          	addi	a5,a5,87
80001408:	0ff7f793          	andi	a5,a5,255
8000140c:	01c0006f          	j	80001428 <printf+0x280>
80001410:	fd042783          	lw	a5,-48(s0)
80001414:	0ff7f793          	andi	a5,a5,255
80001418:	00f7f793          	andi	a5,a5,15
8000141c:	0ff7f793          	andi	a5,a5,255
80001420:	03078793          	addi	a5,a5,48
80001424:	0ff7f793          	andi	a5,a5,255
80001428:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx + i] = c;
8000142c:	fe442703          	lw	a4,-28(s0)
80001430:	fc442783          	lw	a5,-60(s0)
80001434:	00f707b3          	add	a5,a4,a5
80001438:	8000d737          	lui	a4,0x8000d
8000143c:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001440:	00f707b3          	add	a5,a4,a5
80001444:	fbe44703          	lbu	a4,-66(s0)
80001448:	00e78023          	sb	a4,0(a5)
						x /= 16;
8000144c:	fd042783          	lw	a5,-48(s0)
80001450:	0047d793          	srli	a5,a5,0x4
80001454:	fcf42823          	sw	a5,-48(s0)
					for (int i = len; i >= 0; i--)
80001458:	fc442783          	lw	a5,-60(s0)
8000145c:	fff78793          	addi	a5,a5,-1
80001460:	fcf42223          	sw	a5,-60(s0)
80001464:	fc442783          	lw	a5,-60(s0)
80001468:	f607dee3          	bgez	a5,800013e4 <printf+0x23c>
					}
					idx += (len + 1);
8000146c:	fcc42783          	lw	a5,-52(s0)
80001470:	00178793          	addi	a5,a5,1
80001474:	fe442703          	lw	a4,-28(s0)
80001478:	00f707b3          	add	a5,a4,a5
8000147c:	fef42223          	sw	a5,-28(s0)
					tt = 0;
80001480:	fe042423          	sw	zero,-24(s0)
					break;
80001484:	0a80006f          	j	8000152c <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch = va_arg(vl, int);
80001488:	fb842783          	lw	a5,-72(s0)
8000148c:	00478713          	addi	a4,a5,4
80001490:	fae42c23          	sw	a4,-72(s0)
80001494:	0007a783          	lw	a5,0(a5)
80001498:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++] = ch;
8000149c:	fe442783          	lw	a5,-28(s0)
800014a0:	00178713          	addi	a4,a5,1
800014a4:	fee42223          	sw	a4,-28(s0)
800014a8:	8000d737          	lui	a4,0x8000d
800014ac:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
800014b0:	00f707b3          	add	a5,a4,a5
800014b4:	fbf44703          	lbu	a4,-65(s0)
800014b8:	00e78023          	sb	a4,0(a5)
					tt = 0;
800014bc:	fe042423          	sw	zero,-24(s0)
					break;
800014c0:	06c0006f          	j	8000152c <printf+0x384>
				case 's':
				{
					char *ss = va_arg(vl, char *);
800014c4:	fb842783          	lw	a5,-72(s0)
800014c8:	00478713          	addi	a4,a5,4
800014cc:	fae42c23          	sw	a4,-72(s0)
800014d0:	0007a783          	lw	a5,0(a5)
800014d4:	fcf42023          	sw	a5,-64(s0)
					while (*ss)
800014d8:	0300006f          	j	80001508 <printf+0x360>
					{
						outbuf[idx++] = *ss++;
800014dc:	fc042703          	lw	a4,-64(s0)
800014e0:	00170793          	addi	a5,a4,1
800014e4:	fcf42023          	sw	a5,-64(s0)
800014e8:	fe442783          	lw	a5,-28(s0)
800014ec:	00178693          	addi	a3,a5,1
800014f0:	fed42223          	sw	a3,-28(s0)
800014f4:	00074703          	lbu	a4,0(a4)
800014f8:	8000d6b7          	lui	a3,0x8000d
800014fc:	00868693          	addi	a3,a3,8 # 8000d008 <memend+0xf800d008>
80001500:	00f687b3          	add	a5,a3,a5
80001504:	00e78023          	sb	a4,0(a5)
					while (*ss)
80001508:	fc042783          	lw	a5,-64(s0)
8000150c:	0007c783          	lbu	a5,0(a5)
80001510:	fc0796e3          	bnez	a5,800014dc <printf+0x334>
					}
					tt = 0;
80001514:	fe042423          	sw	zero,-24(s0)
					break;
80001518:	0140006f          	j	8000152c <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
8000151c:	8000c7b7          	lui	a5,0x8000c
80001520:	39478513          	addi	a0,a5,916 # 8000c394 <memend+0xf800c394>
80001524:	c4dff0ef          	jal	ra,80001170 <panic>
					break;
80001528:	00000013          	nop
				}
				s++;
8000152c:	fec42783          	lw	a5,-20(s0)
80001530:	00178793          	addi	a5,a5,1
80001534:	fef42623          	sw	a5,-20(s0)
80001538:	0300006f          	j	80001568 <printf+0x3c0>
			}
			else
			{
				outbuf[idx++] = ch;
8000153c:	fe442783          	lw	a5,-28(s0)
80001540:	00178713          	addi	a4,a5,1
80001544:	fee42223          	sw	a4,-28(s0)
80001548:	8000d737          	lui	a4,0x8000d
8000154c:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001550:	00f707b3          	add	a5,a4,a5
80001554:	fbf44703          	lbu	a4,-65(s0)
80001558:	00e78023          	sb	a4,0(a5)
				s++;
8000155c:	fec42783          	lw	a5,-20(s0)
80001560:	00178793          	addi	a5,a5,1
80001564:	fef42623          	sw	a5,-20(s0)
	while ((ch = *(s)))
80001568:	fec42783          	lw	a5,-20(s0)
8000156c:	0007c783          	lbu	a5,0(a5)
80001570:	faf40fa3          	sb	a5,-65(s0)
80001574:	fbf44783          	lbu	a5,-65(s0)
80001578:	c80794e3          	bnez	a5,80001200 <printf+0x58>
			}
		}
	}
	va_end(vl); // 释法参数
	outbuf[idx] = '\0';
8000157c:	8000d7b7          	lui	a5,0x8000d
80001580:	00878713          	addi	a4,a5,8 # 8000d008 <memend+0xf800d008>
80001584:	fe442783          	lw	a5,-28(s0)
80001588:	00f707b3          	add	a5,a4,a5
8000158c:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
80001590:	8000d7b7          	lui	a5,0x8000d
80001594:	00878513          	addi	a0,a5,8 # 8000d008 <memend+0xf800d008>
80001598:	aa8ff0ef          	jal	ra,80000840 <uartputs>
	return idx;
8000159c:	fe442783          	lw	a5,-28(s0)
800015a0:	00078513          	mv	a0,a5
800015a4:	05c12083          	lw	ra,92(sp)
800015a8:	05812403          	lw	s0,88(sp)
800015ac:	08010113          	addi	sp,sp,128
800015b0:	00008067          	ret

800015b4 <minit>:
{
    struct pmp *freelist;
} mem;
#define _DEBUG
void minit()
{
800015b4:	fe010113          	addi	sp,sp,-32
800015b8:	00112e23          	sw	ra,28(sp)
800015bc:	00812c23          	sw	s0,24(sp)
800015c0:	02010413          	addi	s0,sp,32
#ifdef _DEBUG
    printf("textstart:%p    ", textstart);
800015c4:	800007b7          	lui	a5,0x80000
800015c8:	00078593          	mv	a1,a5
800015cc:	8000c7b7          	lui	a5,0x8000c
800015d0:	43078513          	addi	a0,a5,1072 # 8000c430 <memend+0xf800c430>
800015d4:	bd5ff0ef          	jal	ra,800011a8 <printf>
    printf("textend:%p\n", textend);
800015d8:	800037b7          	lui	a5,0x80003
800015dc:	cb478593          	addi	a1,a5,-844 # 80002cb4 <memend+0xf8002cb4>
800015e0:	8000c7b7          	lui	a5,0x8000c
800015e4:	44478513          	addi	a0,a5,1092 # 8000c444 <memend+0xf800c444>
800015e8:	bc1ff0ef          	jal	ra,800011a8 <printf>
    printf("datastart:%p    ", datastart);
800015ec:	800037b7          	lui	a5,0x80003
800015f0:	00078593          	mv	a1,a5
800015f4:	8000c7b7          	lui	a5,0x8000c
800015f8:	45078513          	addi	a0,a5,1104 # 8000c450 <memend+0xf800c450>
800015fc:	badff0ef          	jal	ra,800011a8 <printf>
    printf("dataend:%p\n", dataend);
80001600:	8000b7b7          	lui	a5,0x8000b
80001604:	02478593          	addi	a1,a5,36 # 8000b024 <memend+0xf800b024>
80001608:	8000c7b7          	lui	a5,0x8000c
8000160c:	46478513          	addi	a0,a5,1124 # 8000c464 <memend+0xf800c464>
80001610:	b99ff0ef          	jal	ra,800011a8 <printf>
    printf("rodatastart:%p  ", rodatastart);
80001614:	8000c7b7          	lui	a5,0x8000c
80001618:	00078593          	mv	a1,a5
8000161c:	8000c7b7          	lui	a5,0x8000c
80001620:	47078513          	addi	a0,a5,1136 # 8000c470 <memend+0xf800c470>
80001624:	b85ff0ef          	jal	ra,800011a8 <printf>
    printf("rodataend:%p\n", rodataend);
80001628:	8000c7b7          	lui	a5,0x8000c
8000162c:	56078593          	addi	a1,a5,1376 # 8000c560 <memend+0xf800c560>
80001630:	8000c7b7          	lui	a5,0x8000c
80001634:	48478513          	addi	a0,a5,1156 # 8000c484 <memend+0xf800c484>
80001638:	b71ff0ef          	jal	ra,800011a8 <printf>
    printf("bssstart:%p     ", bssstart);
8000163c:	8000d7b7          	lui	a5,0x8000d
80001640:	00078593          	mv	a1,a5
80001644:	8000c7b7          	lui	a5,0x8000c
80001648:	49478513          	addi	a0,a5,1172 # 8000c494 <memend+0xf800c494>
8000164c:	b5dff0ef          	jal	ra,800011a8 <printf>
    printf("bssend:%p\n", bssend);
80001650:	8000e7b7          	lui	a5,0x8000e
80001654:	b9078593          	addi	a1,a5,-1136 # 8000db90 <memend+0xf800db90>
80001658:	8000c7b7          	lui	a5,0x8000c
8000165c:	4a878513          	addi	a0,a5,1192 # 8000c4a8 <memend+0xf800c4a8>
80001660:	b49ff0ef          	jal	ra,800011a8 <printf>
    printf("mstart:%p   ", mstart);
80001664:	8000e7b7          	lui	a5,0x8000e
80001668:	00078593          	mv	a1,a5
8000166c:	8000c7b7          	lui	a5,0x8000c
80001670:	4b478513          	addi	a0,a5,1204 # 8000c4b4 <memend+0xf800c4b4>
80001674:	b35ff0ef          	jal	ra,800011a8 <printf>
    printf("mend:%p\n", mend);
80001678:	880007b7          	lui	a5,0x88000
8000167c:	00078593          	mv	a1,a5
80001680:	8000c7b7          	lui	a5,0x8000c
80001684:	4c478513          	addi	a0,a5,1220 # 8000c4c4 <memend+0xf800c4c4>
80001688:	b21ff0ef          	jal	ra,800011a8 <printf>
    printf("stack:%p\n", stacks);
8000168c:	800037b7          	lui	a5,0x80003
80001690:	00078593          	mv	a1,a5
80001694:	8000c7b7          	lui	a5,0x8000c
80001698:	4d078513          	addi	a0,a5,1232 # 8000c4d0 <memend+0xf800c4d0>
8000169c:	b0dff0ef          	jal	ra,800011a8 <printf>
#endif

    char *p = (char *)mstart;
800016a0:	8000e7b7          	lui	a5,0x8000e
800016a4:	00078793          	mv	a5,a5
800016a8:	fef42623          	sw	a5,-20(s0)
    struct pmp *m;
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
800016ac:	0380006f          	j	800016e4 <minit+0x130>
    {
        m = (struct pmp *)p;
800016b0:	fec42783          	lw	a5,-20(s0)
800016b4:	fef42423          	sw	a5,-24(s0)
        m->next = mem.freelist;
800016b8:	8000e7b7          	lui	a5,0x8000e
800016bc:	a487a703          	lw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
800016c0:	fe842783          	lw	a5,-24(s0)
800016c4:	00e7a023          	sw	a4,0(a5)
        mem.freelist = m;
800016c8:	8000e7b7          	lui	a5,0x8000e
800016cc:	fe842703          	lw	a4,-24(s0)
800016d0:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
800016d4:	fec42703          	lw	a4,-20(s0)
800016d8:	000017b7          	lui	a5,0x1
800016dc:	00f707b3          	add	a5,a4,a5
800016e0:	fef42623          	sw	a5,-20(s0)
800016e4:	fec42703          	lw	a4,-20(s0)
800016e8:	000017b7          	lui	a5,0x1
800016ec:	00f70733          	add	a4,a4,a5
800016f0:	880007b7          	lui	a5,0x88000
800016f4:	00078793          	mv	a5,a5
800016f8:	fae7fce3          	bgeu	a5,a4,800016b0 <minit+0xfc>
    }
}
800016fc:	00000013          	nop
80001700:	00000013          	nop
80001704:	01c12083          	lw	ra,28(sp)
80001708:	01812403          	lw	s0,24(sp)
8000170c:	02010113          	addi	sp,sp,32
80001710:	00008067          	ret

80001714 <palloc>:

void *palloc()
{
80001714:	fe010113          	addi	sp,sp,-32
80001718:	00112e23          	sw	ra,28(sp)
8000171c:	00812c23          	sw	s0,24(sp)
80001720:	02010413          	addi	s0,sp,32
    struct pmp *p = (struct pmp *)mem.freelist;
80001724:	8000e7b7          	lui	a5,0x8000e
80001728:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
8000172c:	fef42623          	sw	a5,-20(s0)
    if (p)
80001730:	fec42783          	lw	a5,-20(s0)
80001734:	00078c63          	beqz	a5,8000174c <palloc+0x38>
        mem.freelist = mem.freelist->next;
80001738:	8000e7b7          	lui	a5,0x8000e
8000173c:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001740:	0007a703          	lw	a4,0(a5)
80001744:	8000e7b7          	lui	a5,0x8000e
80001748:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
    if (p)
8000174c:	fec42783          	lw	a5,-20(s0)
80001750:	00078a63          	beqz	a5,80001764 <palloc+0x50>
        memset(p, 0, PGSIZE);
80001754:	00001637          	lui	a2,0x1
80001758:	00000593          	li	a1,0
8000175c:	fec42503          	lw	a0,-20(s0)
80001760:	5e9000ef          	jal	ra,80002548 <memset>
    return (void *)p;
80001764:	fec42783          	lw	a5,-20(s0)
}
80001768:	00078513          	mv	a0,a5
8000176c:	01c12083          	lw	ra,28(sp)
80001770:	01812403          	lw	s0,24(sp)
80001774:	02010113          	addi	sp,sp,32
80001778:	00008067          	ret

8000177c <pfree>:

void pfree(void *addr)
{
8000177c:	fd010113          	addi	sp,sp,-48
80001780:	02812623          	sw	s0,44(sp)
80001784:	03010413          	addi	s0,sp,48
80001788:	fca42e23          	sw	a0,-36(s0)
    struct pmp *p = (struct pmp *)addr;
8000178c:	fdc42783          	lw	a5,-36(s0)
80001790:	fef42623          	sw	a5,-20(s0)
    p->next = mem.freelist;
80001794:	8000e7b7          	lui	a5,0x8000e
80001798:	a487a703          	lw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
8000179c:	fec42783          	lw	a5,-20(s0)
800017a0:	00e7a023          	sw	a4,0(a5)
    mem.freelist = p;
800017a4:	8000e7b7          	lui	a5,0x8000e
800017a8:	fec42703          	lw	a4,-20(s0)
800017ac:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
800017b0:	00000013          	nop
800017b4:	02c12403          	lw	s0,44(sp)
800017b8:	03010113          	addi	sp,sp,48
800017bc:	00008067          	ret

800017c0 <r_tp>:
{
800017c0:	fe010113          	addi	sp,sp,-32
800017c4:	00812e23          	sw	s0,28(sp)
800017c8:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
800017cc:	00020793          	mv	a5,tp
800017d0:	fef42623          	sw	a5,-20(s0)
    return x;
800017d4:	fec42783          	lw	a5,-20(s0)
}
800017d8:	00078513          	mv	a0,a5
800017dc:	01c12403          	lw	s0,28(sp)
800017e0:	02010113          	addi	sp,sp,32
800017e4:	00008067          	ret

800017e8 <r_sie>:
 */
#define SEIE (1 << 9)
#define STIE (1 << 5)
#define SSIE (1 << 1)
static inline uint32 r_sie()
{
800017e8:	fe010113          	addi	sp,sp,-32
800017ec:	00812e23          	sw	s0,28(sp)
800017f0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie "
800017f4:	104027f3          	csrr	a5,sie
800017f8:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
800017fc:	fec42783          	lw	a5,-20(s0)
}
80001800:	00078513          	mv	a0,a5
80001804:	01c12403          	lw	s0,28(sp)
80001808:	02010113          	addi	sp,sp,32
8000180c:	00008067          	ret

80001810 <w_sie>:
static inline void w_sie(uint32 x)
{
80001810:	fe010113          	addi	sp,sp,-32
80001814:	00812e23          	sw	s0,28(sp)
80001818:	02010413          	addi	s0,sp,32
8000181c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"
80001820:	fec42783          	lw	a5,-20(s0)
80001824:	10479073          	csrw	sie,a5
                 :
                 : "r"(x));
}
80001828:	00000013          	nop
8000182c:	01c12403          	lw	s0,28(sp)
80001830:	02010113          	addi	sp,sp,32
80001834:	00008067          	ret

80001838 <plicinit>:
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit()
{
80001838:	ff010113          	addi	sp,sp,-16
8000183c:	00112623          	sw	ra,12(sp)
80001840:	00812423          	sw	s0,8(sp)
80001844:	01010413          	addi	s0,sp,16
    *(uint32 *)PLIC_PRIORITY(UART_IRQ) = 1; // uart 设置优先级(1~7)，0为关中断
80001848:	0c0007b7          	lui	a5,0xc000
8000184c:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001850:	00100713          	li	a4,1
80001854:	00e7a023          	sw	a4,0(a5)

    *(uint32 *)PLIC_SENABLE(r_tp()) = (1 << UART_IRQ); // uart 开中断
80001858:	f69ff0ef          	jal	ra,800017c0 <r_tp>
8000185c:	00050793          	mv	a5,a0
80001860:	00879713          	slli	a4,a5,0x8
80001864:	0c0027b7          	lui	a5,0xc002
80001868:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
8000186c:	00f707b3          	add	a5,a4,a5
80001870:	00078713          	mv	a4,a5
80001874:	40000793          	li	a5,1024
80001878:	00f72023          	sw	a5,0(a4)
    *(uint32 *)PLIC_MENABLE(r_tp()) = (1 << UART_IRQ); // uart 开中断
8000187c:	f45ff0ef          	jal	ra,800017c0 <r_tp>
80001880:	00050713          	mv	a4,a0
80001884:	000c07b7          	lui	a5,0xc0
80001888:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
8000188c:	00f707b3          	add	a5,a4,a5
80001890:	00879793          	slli	a5,a5,0x8
80001894:	00078713          	mv	a4,a5
80001898:	40000793          	li	a5,1024
8000189c:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32 *)PLIC_MPRIORITY(r_tp()) = 0;
800018a0:	f21ff0ef          	jal	ra,800017c0 <r_tp>
800018a4:	00050713          	mv	a4,a0
800018a8:	000067b7          	lui	a5,0x6
800018ac:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800018b0:	00f707b3          	add	a5,a4,a5
800018b4:	00d79793          	slli	a5,a5,0xd
800018b8:	0007a023          	sw	zero,0(a5)
    *(uint32 *)PLIC_SPRIORITY(r_tp()) = 0;
800018bc:	f05ff0ef          	jal	ra,800017c0 <r_tp>
800018c0:	00050793          	mv	a5,a0
800018c4:	00d79713          	slli	a4,a5,0xd
800018c8:	0c2017b7          	lui	a5,0xc201
800018cc:	00f707b3          	add	a5,a4,a5
800018d0:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开S-mode中断
800018d4:	f15ff0ef          	jal	ra,800017e8 <r_sie>
800018d8:	00050793          	mv	a5,a0
800018dc:	2227e793          	ori	a5,a5,546
800018e0:	00078513          	mv	a0,a5
800018e4:	f2dff0ef          	jal	ra,80001810 <w_sie>
}
800018e8:	00000013          	nop
800018ec:	00c12083          	lw	ra,12(sp)
800018f0:	00812403          	lw	s0,8(sp)
800018f4:	01010113          	addi	sp,sp,16
800018f8:	00008067          	ret

800018fc <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim()
{
800018fc:	ff010113          	addi	sp,sp,-16
80001900:	00112623          	sw	ra,12(sp)
80001904:	00812423          	sw	s0,8(sp)
80001908:	01010413          	addi	s0,sp,16
    return *(uint32 *)PLIC_SCLAIM(r_tp());
8000190c:	eb5ff0ef          	jal	ra,800017c0 <r_tp>
80001910:	00050793          	mv	a5,a0
80001914:	00d79713          	slli	a4,a5,0xd
80001918:	0c2017b7          	lui	a5,0xc201
8000191c:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001920:	00f707b3          	add	a5,a4,a5
80001924:	0007a783          	lw	a5,0(a5)
}
80001928:	00078513          	mv	a0,a5
8000192c:	00c12083          	lw	ra,12(sp)
80001930:	00812403          	lw	s0,8(sp)
80001934:	01010113          	addi	sp,sp,16
80001938:	00008067          	ret

8000193c <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq)
{
8000193c:	fe010113          	addi	sp,sp,-32
80001940:	00112e23          	sw	ra,28(sp)
80001944:	00812c23          	sw	s0,24(sp)
80001948:	02010413          	addi	s0,sp,32
8000194c:	fea42623          	sw	a0,-20(s0)
    *(uint32 *)PLIC_MCOMPLETE(r_tp()) = irq;
80001950:	e71ff0ef          	jal	ra,800017c0 <r_tp>
80001954:	00050793          	mv	a5,a0
80001958:	00d79713          	slli	a4,a5,0xd
8000195c:	0c2007b7          	lui	a5,0xc200
80001960:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
80001964:	00f707b3          	add	a5,a4,a5
80001968:	00078713          	mv	a4,a5
8000196c:	fec42783          	lw	a5,-20(s0)
80001970:	00f72023          	sw	a5,0(a4)
80001974:	00000013          	nop
80001978:	01c12083          	lw	ra,28(sp)
8000197c:	01812403          	lw	s0,24(sp)
80001980:	02010113          	addi	sp,sp,32
80001984:	00008067          	ret

80001988 <w_satp>:
{
80001988:	fe010113          	addi	sp,sp,-32
8000198c:	00812e23          	sw	s0,28(sp)
80001990:	02010413          	addi	s0,sp,32
80001994:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"
80001998:	fec42783          	lw	a5,-20(s0)
8000199c:	18079073          	csrw	satp,a5
}
800019a0:	00000013          	nop
800019a4:	01c12403          	lw	s0,28(sp)
800019a8:	02010113          	addi	sp,sp,32
800019ac:	00008067          	ret

800019b0 <sfence_vma>:
{
800019b0:	ff010113          	addi	sp,sp,-16
800019b4:	00812623          	sw	s0,12(sp)
800019b8:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800019bc:	12000073          	sfence.vma
}
800019c0:	00000013          	nop
800019c4:	00c12403          	lw	s0,12(sp)
800019c8:	01010113          	addi	sp,sp,16
800019cc:	00008067          	ret

800019d0 <acquriepte>:
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t *acquriepte(addr_t *pgt, addr_t va)
{
800019d0:	fd010113          	addi	sp,sp,-48
800019d4:	02112623          	sw	ra,44(sp)
800019d8:	02812423          	sw	s0,40(sp)
800019dc:	03010413          	addi	s0,sp,48
800019e0:	fca42e23          	sw	a0,-36(s0)
800019e4:	fcb42c23          	sw	a1,-40(s0)
    pte_t *pte;
    pte = &pgt[VPN(1, va)]; // 获取一级页表 PTE
800019e8:	fd842783          	lw	a5,-40(s0)
800019ec:	0167d793          	srli	a5,a5,0x16
800019f0:	00279793          	slli	a5,a5,0x2
800019f4:	fdc42703          	lw	a4,-36(s0)
800019f8:	00f707b3          	add	a5,a4,a5
800019fc:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if (*pte & PTE_V)
80001a00:	fec42783          	lw	a5,-20(s0)
80001a04:	0007a783          	lw	a5,0(a5)
80001a08:	0017f793          	andi	a5,a5,1
80001a0c:	00078e63          	beqz	a5,80001a28 <acquriepte+0x58>
    { // 已分配页
        pgt = (addr_t *)PTE2PA(*pte);
80001a10:	fec42783          	lw	a5,-20(s0)
80001a14:	0007a783          	lw	a5,0(a5)
80001a18:	00a7d793          	srli	a5,a5,0xa
80001a1c:	00c79793          	slli	a5,a5,0xc
80001a20:	fcf42e23          	sw	a5,-36(s0)
80001a24:	0340006f          	j	80001a58 <acquriepte+0x88>
    }
    else
    {                             // 未分配页
        pgt = (addr_t *)palloc(); // 二级页表
80001a28:	cedff0ef          	jal	ra,80001714 <palloc>
80001a2c:	fca42e23          	sw	a0,-36(s0)
        memset(pgt, 0, PGSIZE);
80001a30:	00001637          	lui	a2,0x1
80001a34:	00000593          	li	a1,0
80001a38:	fdc42503          	lw	a0,-36(s0)
80001a3c:	30d000ef          	jal	ra,80002548 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001a40:	fdc42783          	lw	a5,-36(s0)
80001a44:	00c7d793          	srli	a5,a5,0xc
80001a48:	00a79793          	slli	a5,a5,0xa
80001a4c:	0017e713          	ori	a4,a5,1
80001a50:	fec42783          	lw	a5,-20(s0)
80001a54:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0, va)]; // 返回二级页表 PTE
80001a58:	fd842783          	lw	a5,-40(s0)
80001a5c:	00c7d793          	srli	a5,a5,0xc
80001a60:	3ff7f793          	andi	a5,a5,1023
80001a64:	00279793          	slli	a5,a5,0x2
80001a68:	fdc42703          	lw	a4,-36(s0)
80001a6c:	00f707b3          	add	a5,a4,a5
}
80001a70:	00078513          	mv	a0,a5
80001a74:	02c12083          	lw	ra,44(sp)
80001a78:	02812403          	lw	s0,40(sp)
80001a7c:	03010113          	addi	sp,sp,48
80001a80:	00008067          	ret

80001a84 <vmmap>:
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t *pgt, addr_t va, addr_t pa, uint size, uint mode)
{
80001a84:	fc010113          	addi	sp,sp,-64
80001a88:	02112e23          	sw	ra,60(sp)
80001a8c:	02812c23          	sw	s0,56(sp)
80001a90:	04010413          	addi	s0,sp,64
80001a94:	fca42e23          	sw	a0,-36(s0)
80001a98:	fcb42c23          	sw	a1,-40(s0)
80001a9c:	fcc42a23          	sw	a2,-44(s0)
80001aa0:	fcd42823          	sw	a3,-48(s0)
80001aa4:	fce42623          	sw	a4,-52(s0)
    pte_t *pte;

    // PPN
    addr_t start = ((va >> 12) << 12);
80001aa8:	fd842703          	lw	a4,-40(s0)
80001aac:	fffff7b7          	lui	a5,0xfffff
80001ab0:	00f777b3          	and	a5,a4,a5
80001ab4:	fef42623          	sw	a5,-20(s0)
    addr_t end = (((va + (size - 1)) >> 12) << 12);
80001ab8:	fd042703          	lw	a4,-48(s0)
80001abc:	fd842783          	lw	a5,-40(s0)
80001ac0:	00f707b3          	add	a5,a4,a5
80001ac4:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
80001ac8:	fffff7b7          	lui	a5,0xfffff
80001acc:	00f777b3          	and	a5,a4,a5
80001ad0:	fef42423          	sw	a5,-24(s0)

    while (1)
    {
        pte = acquriepte(pgt, start);
80001ad4:	fec42583          	lw	a1,-20(s0)
80001ad8:	fdc42503          	lw	a0,-36(s0)
80001adc:	ef5ff0ef          	jal	ra,800019d0 <acquriepte>
80001ae0:	fea42223          	sw	a0,-28(s0)
        if (*pte & PTE_V)
80001ae4:	fe442783          	lw	a5,-28(s0)
80001ae8:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001aec:	0017f793          	andi	a5,a5,1
80001af0:	00078863          	beqz	a5,80001b00 <vmmap+0x7c>
            panic("repeat map");
80001af4:	8000c7b7          	lui	a5,0x8000c
80001af8:	4dc78513          	addi	a0,a5,1244 # 8000c4dc <memend+0xf800c4dc>
80001afc:	e74ff0ef          	jal	ra,80001170 <panic>
        *pte = PA2PTE(pa) | mode | PTE_V;
80001b00:	fd442783          	lw	a5,-44(s0)
80001b04:	00c7d793          	srli	a5,a5,0xc
80001b08:	00a79713          	slli	a4,a5,0xa
80001b0c:	fcc42783          	lw	a5,-52(s0)
80001b10:	00f767b3          	or	a5,a4,a5
80001b14:	0017e713          	ori	a4,a5,1
80001b18:	fe442783          	lw	a5,-28(s0)
80001b1c:	00e7a023          	sw	a4,0(a5)
        if (start == end)
80001b20:	fec42703          	lw	a4,-20(s0)
80001b24:	fe842783          	lw	a5,-24(s0)
80001b28:	02f70463          	beq	a4,a5,80001b50 <vmmap+0xcc>
            break;
        start += PGSIZE;
80001b2c:	fec42703          	lw	a4,-20(s0)
80001b30:	000017b7          	lui	a5,0x1
80001b34:	00f707b3          	add	a5,a4,a5
80001b38:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001b3c:	fd442703          	lw	a4,-44(s0)
80001b40:	000017b7          	lui	a5,0x1
80001b44:	00f707b3          	add	a5,a4,a5
80001b48:	fcf42a23          	sw	a5,-44(s0)
        pte = acquriepte(pgt, start);
80001b4c:	f89ff06f          	j	80001ad4 <vmmap+0x50>
            break;
80001b50:	00000013          	nop
    }
}
80001b54:	00000013          	nop
80001b58:	03c12083          	lw	ra,60(sp)
80001b5c:	03812403          	lw	s0,56(sp)
80001b60:	04010113          	addi	sp,sp,64
80001b64:	00008067          	ret

80001b68 <printpgt>:

void printpgt(addr_t *pgt)
{
80001b68:	fc010113          	addi	sp,sp,-64
80001b6c:	02112e23          	sw	ra,60(sp)
80001b70:	02812c23          	sw	s0,56(sp)
80001b74:	04010413          	addi	s0,sp,64
80001b78:	fca42623          	sw	a0,-52(s0)
    for (int i = 0; i < 1024; i++)
80001b7c:	fe042623          	sw	zero,-20(s0)
80001b80:	0c40006f          	j	80001c44 <printpgt+0xdc>
    {
        pte_t pte = pgt[i];
80001b84:	fec42783          	lw	a5,-20(s0)
80001b88:	00279793          	slli	a5,a5,0x2
80001b8c:	fcc42703          	lw	a4,-52(s0)
80001b90:	00f707b3          	add	a5,a4,a5
80001b94:	0007a783          	lw	a5,0(a5) # 1000 <sz>
80001b98:	fef42223          	sw	a5,-28(s0)
        if (pte & PTE_V)
80001b9c:	fe442783          	lw	a5,-28(s0)
80001ba0:	0017f793          	andi	a5,a5,1
80001ba4:	08078a63          	beqz	a5,80001c38 <printpgt+0xd0>
        {
            addr_t *pgt2 = (addr_t *)PTE2PA(pte);
80001ba8:	fe442783          	lw	a5,-28(s0)
80001bac:	00a7d793          	srli	a5,a5,0xa
80001bb0:	00c79793          	slli	a5,a5,0xc
80001bb4:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n", i, pte, pgt2);
80001bb8:	fe042683          	lw	a3,-32(s0)
80001bbc:	fe442603          	lw	a2,-28(s0)
80001bc0:	fec42583          	lw	a1,-20(s0)
80001bc4:	8000c7b7          	lui	a5,0x8000c
80001bc8:	4e878513          	addi	a0,a5,1256 # 8000c4e8 <memend+0xf800c4e8>
80001bcc:	ddcff0ef          	jal	ra,800011a8 <printf>
            for (int j = 0; j < 1024; j++)
80001bd0:	fe042423          	sw	zero,-24(s0)
80001bd4:	0580006f          	j	80001c2c <printpgt+0xc4>
            {
                pte_t pte2 = pgt2[j];
80001bd8:	fe842783          	lw	a5,-24(s0)
80001bdc:	00279793          	slli	a5,a5,0x2
80001be0:	fe042703          	lw	a4,-32(s0)
80001be4:	00f707b3          	add	a5,a4,a5
80001be8:	0007a783          	lw	a5,0(a5)
80001bec:	fcf42e23          	sw	a5,-36(s0)
                if (pte2 & PTE_V)
80001bf0:	fdc42783          	lw	a5,-36(s0)
80001bf4:	0017f793          	andi	a5,a5,1
80001bf8:	02078463          	beqz	a5,80001c20 <printpgt+0xb8>
                {
                    printf(".. ..%d: pte %p pa %p\n", j, pte2, PTE2PA(pte2));
80001bfc:	fdc42783          	lw	a5,-36(s0)
80001c00:	00a7d793          	srli	a5,a5,0xa
80001c04:	00c79793          	slli	a5,a5,0xc
80001c08:	00078693          	mv	a3,a5
80001c0c:	fdc42603          	lw	a2,-36(s0)
80001c10:	fe842583          	lw	a1,-24(s0)
80001c14:	8000c7b7          	lui	a5,0x8000c
80001c18:	50078513          	addi	a0,a5,1280 # 8000c500 <memend+0xf800c500>
80001c1c:	d8cff0ef          	jal	ra,800011a8 <printf>
            for (int j = 0; j < 1024; j++)
80001c20:	fe842783          	lw	a5,-24(s0)
80001c24:	00178793          	addi	a5,a5,1
80001c28:	fef42423          	sw	a5,-24(s0)
80001c2c:	fe842703          	lw	a4,-24(s0)
80001c30:	3ff00793          	li	a5,1023
80001c34:	fae7d2e3          	bge	a5,a4,80001bd8 <printpgt+0x70>
    for (int i = 0; i < 1024; i++)
80001c38:	fec42783          	lw	a5,-20(s0)
80001c3c:	00178793          	addi	a5,a5,1
80001c40:	fef42623          	sw	a5,-20(s0)
80001c44:	fec42703          	lw	a4,-20(s0)
80001c48:	3ff00793          	li	a5,1023
80001c4c:	f2e7dce3          	bge	a5,a4,80001b84 <printpgt+0x1c>
                }
            }
        }
    }
}
80001c50:	00000013          	nop
80001c54:	00000013          	nop
80001c58:	03c12083          	lw	ra,60(sp)
80001c5c:	03812403          	lw	s0,56(sp)
80001c60:	04010113          	addi	sp,sp,64
80001c64:	00008067          	ret

80001c68 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t *pgt)
{
80001c68:	fd010113          	addi	sp,sp,-48
80001c6c:	02112623          	sw	ra,44(sp)
80001c70:	02812423          	sw	s0,40(sp)
80001c74:	03010413          	addi	s0,sp,48
80001c78:	fca42e23          	sw	a0,-36(s0)
    for (int i = 0; i < NPROC; i++)
80001c7c:	fe042623          	sw	zero,-20(s0)
80001c80:	04c0006f          	j	80001ccc <mkstack+0x64>
    {
        addr_t va = (addr_t)(KSPACE + PGSIZE + (i)*2 * PGSIZE);
80001c84:	fec42783          	lw	a5,-20(s0)
80001c88:	00d79793          	slli	a5,a5,0xd
80001c8c:	00078713          	mv	a4,a5
80001c90:	c00017b7          	lui	a5,0xc0001
80001c94:	00f707b3          	add	a5,a4,a5
80001c98:	fef42423          	sw	a5,-24(s0)
        addr_t pa = (addr_t)palloc(); //! 待处理
80001c9c:	a79ff0ef          	jal	ra,80001714 <palloc>
80001ca0:	00050793          	mv	a5,a0
80001ca4:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt, va, pa, PGSIZE, PTE_R | PTE_W);
80001ca8:	00600713          	li	a4,6
80001cac:	000016b7          	lui	a3,0x1
80001cb0:	fe442603          	lw	a2,-28(s0)
80001cb4:	fe842583          	lw	a1,-24(s0)
80001cb8:	fdc42503          	lw	a0,-36(s0)
80001cbc:	dc9ff0ef          	jal	ra,80001a84 <vmmap>
    for (int i = 0; i < NPROC; i++)
80001cc0:	fec42783          	lw	a5,-20(s0)
80001cc4:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
80001cc8:	fef42623          	sw	a5,-20(s0)
80001ccc:	fec42703          	lw	a4,-20(s0)
80001cd0:	00300793          	li	a5,3
80001cd4:	fae7d8e3          	bge	a5,a4,80001c84 <mkstack+0x1c>
    }
}
80001cd8:	00000013          	nop
80001cdc:	00000013          	nop
80001ce0:	02c12083          	lw	ra,44(sp)
80001ce4:	02812403          	lw	s0,40(sp)
80001ce8:	03010113          	addi	sp,sp,48
80001cec:	00008067          	ret

80001cf0 <kvminit>:

// 初始化虚拟内存
void kvminit()
{
80001cf0:	ff010113          	addi	sp,sp,-16
80001cf4:	00112623          	sw	ra,12(sp)
80001cf8:	00812423          	sw	s0,8(sp)
80001cfc:	01010413          	addi	s0,sp,16
    kpgt = (addr_t *)palloc();
80001d00:	a15ff0ef          	jal	ra,80001714 <palloc>
80001d04:	00050713          	mv	a4,a0
80001d08:	8000e7b7          	lui	a5,0x8000e
80001d0c:	a4e7a623          	sw	a4,-1460(a5) # 8000da4c <memend+0xf800da4c>
    memset(kpgt, 0, PGSIZE);
80001d10:	8000e7b7          	lui	a5,0x8000e
80001d14:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d18:	00001637          	lui	a2,0x1
80001d1c:	00000593          	li	a1,0
80001d20:	00078513          	mv	a0,a5
80001d24:	025000ef          	jal	ra,80002548 <memset>

    // 映射 CLINT
    vmmap(kpgt, CLINT_BASE, CLINT_BASE, 0xc000, PTE_R | PTE_W);
80001d28:	8000e7b7          	lui	a5,0x8000e
80001d2c:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d30:	00600713          	li	a4,6
80001d34:	0000c6b7          	lui	a3,0xc
80001d38:	02000637          	lui	a2,0x2000
80001d3c:	020005b7          	lui	a1,0x2000
80001d40:	00078513          	mv	a0,a5
80001d44:	d41ff0ef          	jal	ra,80001a84 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt, PLIC_BASE, PLIC_BASE, 0x400000, PTE_R | PTE_W);
80001d48:	8000e7b7          	lui	a5,0x8000e
80001d4c:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d50:	00600713          	li	a4,6
80001d54:	004006b7          	lui	a3,0x400
80001d58:	0c000637          	lui	a2,0xc000
80001d5c:	0c0005b7          	lui	a1,0xc000
80001d60:	00078513          	mv	a0,a5
80001d64:	d21ff0ef          	jal	ra,80001a84 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt, UART_BASE, UART_BASE, PGSIZE, PTE_R | PTE_W);
80001d68:	8000e7b7          	lui	a5,0x8000e
80001d6c:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d70:	00600713          	li	a4,6
80001d74:	000016b7          	lui	a3,0x1
80001d78:	10000637          	lui	a2,0x10000
80001d7c:	100005b7          	lui	a1,0x10000
80001d80:	00078513          	mv	a0,a5
80001d84:	d01ff0ef          	jal	ra,80001a84 <vmmap>

    // 映射 内核 指令区
    vmmap(kpgt, (addr_t)textstart, (addr_t)textstart, (textend - textstart), PTE_R | PTE_X);
80001d88:	8000e7b7          	lui	a5,0x8000e
80001d8c:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d90:	800007b7          	lui	a5,0x80000
80001d94:	00078593          	mv	a1,a5
80001d98:	800007b7          	lui	a5,0x80000
80001d9c:	00078613          	mv	a2,a5
80001da0:	800037b7          	lui	a5,0x80003
80001da4:	cb478713          	addi	a4,a5,-844 # 80002cb4 <memend+0xf8002cb4>
80001da8:	800007b7          	lui	a5,0x80000
80001dac:	00078793          	mv	a5,a5
80001db0:	40f707b3          	sub	a5,a4,a5
80001db4:	00a00713          	li	a4,10
80001db8:	00078693          	mv	a3,a5
80001dbc:	cc9ff0ef          	jal	ra,80001a84 <vmmap>
    // 映射 数据区
    vmmap(kpgt, (addr_t)datastart, (addr_t)datastart, dataend - datastart, PTE_R | PTE_W);
80001dc0:	8000e7b7          	lui	a5,0x8000e
80001dc4:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001dc8:	800037b7          	lui	a5,0x80003
80001dcc:	00078593          	mv	a1,a5
80001dd0:	800037b7          	lui	a5,0x80003
80001dd4:	00078613          	mv	a2,a5
80001dd8:	8000b7b7          	lui	a5,0x8000b
80001ddc:	02478713          	addi	a4,a5,36 # 8000b024 <memend+0xf800b024>
80001de0:	800037b7          	lui	a5,0x80003
80001de4:	00078793          	mv	a5,a5
80001de8:	40f707b3          	sub	a5,a4,a5
80001dec:	00600713          	li	a4,6
80001df0:	00078693          	mv	a3,a5
80001df4:	c91ff0ef          	jal	ra,80001a84 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt, (addr_t)rodatastart, (addr_t)rodatastart, (rodataend - rodatastart), PTE_R);
80001df8:	8000e7b7          	lui	a5,0x8000e
80001dfc:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001e00:	8000c7b7          	lui	a5,0x8000c
80001e04:	00078593          	mv	a1,a5
80001e08:	8000c7b7          	lui	a5,0x8000c
80001e0c:	00078613          	mv	a2,a5
80001e10:	8000c7b7          	lui	a5,0x8000c
80001e14:	56078713          	addi	a4,a5,1376 # 8000c560 <memend+0xf800c560>
80001e18:	8000c7b7          	lui	a5,0x8000c
80001e1c:	00078793          	mv	a5,a5
80001e20:	40f707b3          	sub	a5,a4,a5
80001e24:	00200713          	li	a4,2
80001e28:	00078693          	mv	a3,a5
80001e2c:	c59ff0ef          	jal	ra,80001a84 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt, (addr_t)bssstart, (addr_t)bssstart, bssend - bssstart, PTE_R | PTE_W);
80001e30:	8000e7b7          	lui	a5,0x8000e
80001e34:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001e38:	8000d7b7          	lui	a5,0x8000d
80001e3c:	00078593          	mv	a1,a5
80001e40:	8000d7b7          	lui	a5,0x8000d
80001e44:	00078613          	mv	a2,a5
80001e48:	8000e7b7          	lui	a5,0x8000e
80001e4c:	b9078713          	addi	a4,a5,-1136 # 8000db90 <memend+0xf800db90>
80001e50:	8000d7b7          	lui	a5,0x8000d
80001e54:	00078793          	mv	a5,a5
80001e58:	40f707b3          	sub	a5,a4,a5
80001e5c:	00600713          	li	a4,6
80001e60:	00078693          	mv	a3,a5
80001e64:	c21ff0ef          	jal	ra,80001a84 <vmmap>

    // 映射空闲内存区
    vmmap(kpgt, (addr_t)mstart, (addr_t)mstart, mend - mstart, PTE_W | PTE_R);
80001e68:	8000e7b7          	lui	a5,0x8000e
80001e6c:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001e70:	8000e7b7          	lui	a5,0x8000e
80001e74:	00078593          	mv	a1,a5
80001e78:	8000e7b7          	lui	a5,0x8000e
80001e7c:	00078613          	mv	a2,a5
80001e80:	880007b7          	lui	a5,0x88000
80001e84:	00078713          	mv	a4,a5
80001e88:	8000e7b7          	lui	a5,0x8000e
80001e8c:	00078793          	mv	a5,a5
80001e90:	40f707b3          	sub	a5,a4,a5
80001e94:	00600713          	li	a4,6
80001e98:	00078693          	mv	a3,a5
80001e9c:	be9ff0ef          	jal	ra,80001a84 <vmmap>

    mkstack(kpgt);
80001ea0:	8000e7b7          	lui	a5,0x8000e
80001ea4:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001ea8:	00078513          	mv	a0,a5
80001eac:	dbdff0ef          	jal	ra,80001c68 <mkstack>

    // 映射 usertrap
    vmmap(kpgt, USERVEC, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80001eb0:	8000e7b7          	lui	a5,0x8000e
80001eb4:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001eb8:	800007b7          	lui	a5,0x80000
80001ebc:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001ec0:	00a00713          	li	a4,10
80001ec4:	000016b7          	lui	a3,0x1
80001ec8:	00078613          	mv	a2,a5
80001ecc:	fffff5b7          	lui	a1,0xfffff
80001ed0:	bb5ff0ef          	jal	ra,80001a84 <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32 | (((uint32)kpgt) >> 12)); // 页表 PPN 写入Satp
80001ed4:	8000e7b7          	lui	a5,0x8000e
80001ed8:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001edc:	00c7d713          	srli	a4,a5,0xc
80001ee0:	800007b7          	lui	a5,0x80000
80001ee4:	00f767b3          	or	a5,a4,a5
80001ee8:	00078513          	mv	a0,a5
80001eec:	a9dff0ef          	jal	ra,80001988 <w_satp>
    sfence_vma();                               // 刷新页表
80001ef0:	ac1ff0ef          	jal	ra,800019b0 <sfence_vma>
}
80001ef4:	00000013          	nop
80001ef8:	00c12083          	lw	ra,12(sp)
80001efc:	00812403          	lw	s0,8(sp)
80001f00:	01010113          	addi	sp,sp,16
80001f04:	00008067          	ret

80001f08 <pgtcreate>:

addr_t *pgtcreate()
{
80001f08:	fe010113          	addi	sp,sp,-32
80001f0c:	00112e23          	sw	ra,28(sp)
80001f10:	00812c23          	sw	s0,24(sp)
80001f14:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t *pgt = (addr_t *)palloc();
80001f18:	ffcff0ef          	jal	ra,80001714 <palloc>
80001f1c:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001f20:	fec42783          	lw	a5,-20(s0)
}
80001f24:	00078513          	mv	a0,a5
80001f28:	01c12083          	lw	ra,28(sp)
80001f2c:	01812403          	lw	s0,24(sp)
80001f30:	02010113          	addi	sp,sp,32
80001f34:	00008067          	ret

80001f38 <r_tp>:
{
80001f38:	fe010113          	addi	sp,sp,-32
80001f3c:	00812e23          	sw	s0,28(sp)
80001f40:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80001f44:	00020793          	mv	a5,tp
80001f48:	fef42623          	sw	a5,-20(s0)
    return x;
80001f4c:	fec42783          	lw	a5,-20(s0)
}
80001f50:	00078513          	mv	a0,a5
80001f54:	01c12403          	lw	s0,28(sp)
80001f58:	02010113          	addi	sp,sp,32
80001f5c:	00008067          	ret

80001f60 <procinit>:
#include "syscall.h"

uint nextpid = 0;

void procinit()
{
80001f60:	fe010113          	addi	sp,sp,-32
80001f64:	00812e23          	sw	s0,28(sp)
80001f68:	02010413          	addi	s0,sp,32
    struct pcb *p;
    for (int i = 0; i < NPROC; i++)
80001f6c:	fe042623          	sw	zero,-20(s0)
80001f70:	0500006f          	j	80001fc0 <procinit+0x60>
    {
        p = &proc[i];
80001f74:	fec42703          	lw	a4,-20(s0)
80001f78:	00070793          	mv	a5,a4
80001f7c:	00379793          	slli	a5,a5,0x3
80001f80:	00e787b3          	add	a5,a5,a4
80001f84:	00479793          	slli	a5,a5,0x4
80001f88:	8000d737          	lui	a4,0x8000d
80001f8c:	40870713          	addi	a4,a4,1032 # 8000d408 <memend+0xf800d408>
80001f90:	00e787b3          	add	a5,a5,a4
80001f94:	fef42423          	sw	a5,-24(s0)
        p->kernelstack = (addr_t)(KSTACK + (i)*2 * PGSIZE);
80001f98:	fec42783          	lw	a5,-20(s0)
80001f9c:	00d79793          	slli	a5,a5,0xd
80001fa0:	00078713          	mv	a4,a5
80001fa4:	c00027b7          	lui	a5,0xc0002
80001fa8:	00f70733          	add	a4,a4,a5
80001fac:	fe842783          	lw	a5,-24(s0)
80001fb0:	08e7a623          	sw	a4,140(a5) # c000208c <memend+0x3800208c>
    for (int i = 0; i < NPROC; i++)
80001fb4:	fec42783          	lw	a5,-20(s0)
80001fb8:	00178793          	addi	a5,a5,1
80001fbc:	fef42623          	sw	a5,-20(s0)
80001fc0:	fec42703          	lw	a4,-20(s0)
80001fc4:	00300793          	li	a5,3
80001fc8:	fae7d6e3          	bge	a5,a4,80001f74 <procinit+0x14>
    }
}
80001fcc:	00000013          	nop
80001fd0:	00000013          	nop
80001fd4:	01c12403          	lw	s0,28(sp)
80001fd8:	02010113          	addi	sp,sp,32
80001fdc:	00008067          	ret

80001fe0 <nowproc>:

struct pcb *nowproc()
{
80001fe0:	fe010113          	addi	sp,sp,-32
80001fe4:	00112e23          	sw	ra,28(sp)
80001fe8:	00812c23          	sw	s0,24(sp)
80001fec:	02010413          	addi	s0,sp,32
    int hart = r_tp();
80001ff0:	f49ff0ef          	jal	ra,80001f38 <r_tp>
80001ff4:	00050793          	mv	a5,a0
80001ff8:	fef42623          	sw	a5,-20(s0)
    return cpus[hart].proc;
80001ffc:	8000d7b7          	lui	a5,0x8000d
80002000:	64878713          	addi	a4,a5,1608 # 8000d648 <memend+0xf800d648>
80002004:	fec42783          	lw	a5,-20(s0)
80002008:	00779793          	slli	a5,a5,0x7
8000200c:	00f707b3          	add	a5,a4,a5
80002010:	0007a783          	lw	a5,0(a5)
}
80002014:	00078513          	mv	a0,a5
80002018:	01c12083          	lw	ra,28(sp)
8000201c:	01812403          	lw	s0,24(sp)
80002020:	02010113          	addi	sp,sp,32
80002024:	00008067          	ret

80002028 <nowcpu>:

struct cpu *nowcpu()
{
80002028:	fe010113          	addi	sp,sp,-32
8000202c:	00112e23          	sw	ra,28(sp)
80002030:	00812c23          	sw	s0,24(sp)
80002034:	02010413          	addi	s0,sp,32
    int hart = r_tp();
80002038:	f01ff0ef          	jal	ra,80001f38 <r_tp>
8000203c:	00050793          	mv	a5,a0
80002040:	fef42623          	sw	a5,-20(s0)
    return &cpus[hart];
80002044:	fec42783          	lw	a5,-20(s0)
80002048:	00779713          	slli	a4,a5,0x7
8000204c:	8000d7b7          	lui	a5,0x8000d
80002050:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
80002054:	00f707b3          	add	a5,a4,a5
}
80002058:	00078513          	mv	a0,a5
8000205c:	01c12083          	lw	ra,28(sp)
80002060:	01812403          	lw	s0,24(sp)
80002064:	02010113          	addi	sp,sp,32
80002068:	00008067          	ret

8000206c <pidalloc>:

uint pidalloc()
{
8000206c:	ff010113          	addi	sp,sp,-16
80002070:	00812623          	sw	s0,12(sp)
80002074:	01010413          	addi	s0,sp,16
    return nextpid++;
80002078:	8000d7b7          	lui	a5,0x8000d
8000207c:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
80002080:	00178693          	addi	a3,a5,1
80002084:	8000d737          	lui	a4,0x8000d
80002088:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
}
8000208c:	00078513          	mv	a0,a5
80002090:	00c12403          	lw	s0,12(sp)
80002094:	01010113          	addi	sp,sp,16
80002098:	00008067          	ret

8000209c <procalloc>:

struct pcb *procalloc()
{
8000209c:	fe010113          	addi	sp,sp,-32
800020a0:	00112e23          	sw	ra,28(sp)
800020a4:	00812c23          	sw	s0,24(sp)
800020a8:	02010413          	addi	s0,sp,32
    struct pcb *p;
    for (p = proc; p < &proc[NPROC]; p++)
800020ac:	8000d7b7          	lui	a5,0x8000d
800020b0:	40878793          	addi	a5,a5,1032 # 8000d408 <memend+0xf800d408>
800020b4:	fef42623          	sw	a5,-20(s0)
800020b8:	0680006f          	j	80002120 <procalloc+0x84>
    {
        if (p->status == UNUSED)
800020bc:	fec42783          	lw	a5,-20(s0)
800020c0:	0047a783          	lw	a5,4(a5)
800020c4:	04079863          	bnez	a5,80002114 <procalloc+0x78>
        {
            p->trapframe = (struct trapframe *)palloc(sizeof(struct trapframe));
800020c8:	08c00513          	li	a0,140
800020cc:	e48ff0ef          	jal	ra,80001714 <palloc>
800020d0:	00050713          	mv	a4,a0
800020d4:	fec42783          	lw	a5,-20(s0)
800020d8:	00e7a423          	sw	a4,8(a5)

            p->pid = pidalloc();
800020dc:	f91ff0ef          	jal	ra,8000206c <pidalloc>
800020e0:	00050793          	mv	a5,a0
800020e4:	00078713          	mv	a4,a5
800020e8:	fec42783          	lw	a5,-20(s0)
800020ec:	00e7a023          	sw	a4,0(a5)
            p->status = USED;
800020f0:	fec42783          	lw	a5,-20(s0)
800020f4:	00100713          	li	a4,1
800020f8:	00e7a223          	sw	a4,4(a5)

            p->pagetable = pgtcreate();
800020fc:	e0dff0ef          	jal	ra,80001f08 <pgtcreate>
80002100:	00050713          	mv	a4,a0
80002104:	fec42783          	lw	a5,-20(s0)
80002108:	08e7a423          	sw	a4,136(a5)

            return p;
8000210c:	fec42783          	lw	a5,-20(s0)
80002110:	0240006f          	j	80002134 <procalloc+0x98>
    for (p = proc; p < &proc[NPROC]; p++)
80002114:	fec42783          	lw	a5,-20(s0)
80002118:	09078793          	addi	a5,a5,144
8000211c:	fef42623          	sw	a5,-20(s0)
80002120:	fec42703          	lw	a4,-20(s0)
80002124:	8000d7b7          	lui	a5,0x8000d
80002128:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
8000212c:	f8f768e3          	bltu	a4,a5,800020bc <procalloc+0x20>
        }
    }
    return 0;
80002130:	00000793          	li	a5,0
}
80002134:	00078513          	mv	a0,a5
80002138:	01c12083          	lw	ra,28(sp)
8000213c:	01812403          	lw	s0,24(sp)
80002140:	02010113          	addi	sp,sp,32
80002144:	00008067          	ret

80002148 <userinit>:
    0x73, 0x00, 0x00, 0x00,
    0x6f, 0x00, 0x00, 0x00};

// 初始化第一个进程
void userinit()
{
80002148:	fe010113          	addi	sp,sp,-32
8000214c:	00112e23          	sw	ra,28(sp)
80002150:	00812c23          	sw	s0,24(sp)
80002154:	02010413          	addi	s0,sp,32
    struct pcb *p = procalloc();
80002158:	f45ff0ef          	jal	ra,8000209c <procalloc>
8000215c:	fea42623          	sw	a0,-20(s0)

    p->trapframe->epc = 0;
80002160:	fec42783          	lw	a5,-20(s0)
80002164:	0087a783          	lw	a5,8(a5)
80002168:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp = PGSIZE;
8000216c:	fec42783          	lw	a5,-20(s0)
80002170:	0087a783          	lw	a5,8(a5)
80002174:	00001737          	lui	a4,0x1
80002178:	00e7aa23          	sw	a4,20(a5)

    char *m = (char *)palloc();
8000217c:	d98ff0ef          	jal	ra,80001714 <palloc>
80002180:	fea42423          	sw	a0,-24(s0)
    memmove(m, zeroproc, sizeof(zeroproc));
80002184:	00c00613          	li	a2,12
80002188:	00000693          	li	a3,0
8000218c:	8000b7b7          	lui	a5,0x8000b
80002190:	00078593          	mv	a1,a5
80002194:	fe842503          	lw	a0,-24(s0)
80002198:	41c000ef          	jal	ra,800025b4 <memmove>

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
8000219c:	fec42783          	lw	a5,-20(s0)
800021a0:	0887a783          	lw	a5,136(a5) # 8000b088 <memend+0xf800b088>
800021a4:	fe842603          	lw	a2,-24(s0)
800021a8:	01e00713          	li	a4,30
800021ac:	000016b7          	lui	a3,0x1
800021b0:	00000593          	li	a1,0
800021b4:	00078513          	mv	a0,a5
800021b8:	8cdff0ef          	jal	ra,80001a84 <vmmap>
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
800021bc:	fec42783          	lw	a5,-20(s0)
800021c0:	0887a503          	lw	a0,136(a5)
800021c4:	800007b7          	lui	a5,0x80000
800021c8:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
800021cc:	800007b7          	lui	a5,0x80000
800021d0:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
800021d4:	00a00713          	li	a4,10
800021d8:	000016b7          	lui	a3,0x1
800021dc:	00078613          	mv	a2,a5
800021e0:	8a5ff0ef          	jal	ra,80001a84 <vmmap>

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
800021e4:	fec42783          	lw	a5,-20(s0)
800021e8:	0887a503          	lw	a0,136(a5)
800021ec:	fec42783          	lw	a5,-20(s0)
800021f0:	0087a783          	lw	a5,8(a5)
800021f4:	00600713          	li	a4,6
800021f8:	000016b7          	lui	a3,0x1
800021fc:	00078613          	mv	a2,a5
80002200:	ffffe5b7          	lui	a1,0xffffe
80002204:	881ff0ef          	jal	ra,80001a84 <vmmap>

    p->pagetable = (addr_t *)p->pagetable;
80002208:	fec42783          	lw	a5,-20(s0)
8000220c:	0887a703          	lw	a4,136(a5)
80002210:	fec42783          	lw	a5,-20(s0)
80002214:	08e7a423          	sw	a4,136(a5)

    p->status = RUNABLE;
80002218:	fec42783          	lw	a5,-20(s0)
8000221c:	00200713          	li	a4,2
80002220:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
80002224:	fec42783          	lw	a5,-20(s0)
80002228:	0887a783          	lw	a5,136(a5)
8000222c:	00078513          	mv	a0,a5
80002230:	a39ff0ef          	jal	ra,80001c68 <mkstack>

    p->context.ra = (reg_t)usertrapret;
80002234:	800017b7          	lui	a5,0x80001
80002238:	dec78713          	addi	a4,a5,-532 # 80000dec <memend+0xf8000dec>
8000223c:	fec42783          	lw	a5,-20(s0)
80002240:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
80002244:	fec42783          	lw	a5,-20(s0)
80002248:	08c7a703          	lw	a4,140(a5)
8000224c:	fec42783          	lw	a5,-20(s0)
80002250:	00e7a823          	sw	a4,16(a5)

    p = procalloc();
80002254:	e49ff0ef          	jal	ra,8000209c <procalloc>
80002258:	fea42623          	sw	a0,-20(s0)
    p->context.ra = (reg_t)usertrapret;
8000225c:	800017b7          	lui	a5,0x80001
80002260:	dec78713          	addi	a4,a5,-532 # 80000dec <memend+0xf8000dec>
80002264:	fec42783          	lw	a5,-20(s0)
80002268:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
8000226c:	fec42783          	lw	a5,-20(s0)
80002270:	08c7a703          	lw	a4,140(a5)
80002274:	fec42783          	lw	a5,-20(s0)
80002278:	00e7a823          	sw	a4,16(a5)

    p->trapframe->epc = 0;
8000227c:	fec42783          	lw	a5,-20(s0)
80002280:	0087a783          	lw	a5,8(a5)
80002284:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp = PGSIZE;
80002288:	fec42783          	lw	a5,-20(s0)
8000228c:	0087a783          	lw	a5,8(a5)
80002290:	00001737          	lui	a4,0x1
80002294:	00e7aa23          	sw	a4,20(a5)

    m = (char *)palloc();
80002298:	c7cff0ef          	jal	ra,80001714 <palloc>
8000229c:	fea42423          	sw	a0,-24(s0)
    memmove(m, firstproc, sizeof(zeroproc));
800022a0:	00c00613          	li	a2,12
800022a4:	00000693          	li	a3,0
800022a8:	8000b7b7          	lui	a5,0x8000b
800022ac:	00c78593          	addi	a1,a5,12 # 8000b00c <memend+0xf800b00c>
800022b0:	fe842503          	lw	a0,-24(s0)
800022b4:	300000ef          	jal	ra,800025b4 <memmove>

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
800022b8:	fec42783          	lw	a5,-20(s0)
800022bc:	0887a783          	lw	a5,136(a5)
800022c0:	fe842603          	lw	a2,-24(s0)
800022c4:	01e00713          	li	a4,30
800022c8:	000016b7          	lui	a3,0x1
800022cc:	00000593          	li	a1,0
800022d0:	00078513          	mv	a0,a5
800022d4:	fb0ff0ef          	jal	ra,80001a84 <vmmap>
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
800022d8:	fec42783          	lw	a5,-20(s0)
800022dc:	0887a503          	lw	a0,136(a5)
800022e0:	800007b7          	lui	a5,0x80000
800022e4:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
800022e8:	800007b7          	lui	a5,0x80000
800022ec:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
800022f0:	00a00713          	li	a4,10
800022f4:	000016b7          	lui	a3,0x1
800022f8:	00078613          	mv	a2,a5
800022fc:	f88ff0ef          	jal	ra,80001a84 <vmmap>

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
80002300:	fec42783          	lw	a5,-20(s0)
80002304:	0887a503          	lw	a0,136(a5)
80002308:	fec42783          	lw	a5,-20(s0)
8000230c:	0087a783          	lw	a5,8(a5)
80002310:	00600713          	li	a4,6
80002314:	000016b7          	lui	a3,0x1
80002318:	00078613          	mv	a2,a5
8000231c:	ffffe5b7          	lui	a1,0xffffe
80002320:	f64ff0ef          	jal	ra,80001a84 <vmmap>

    p->pagetable = (addr_t *)p->pagetable;
80002324:	fec42783          	lw	a5,-20(s0)
80002328:	0887a703          	lw	a4,136(a5)
8000232c:	fec42783          	lw	a5,-20(s0)
80002330:	08e7a423          	sw	a4,136(a5)

    p->status = RUNABLE;
80002334:	fec42783          	lw	a5,-20(s0)
80002338:	00200713          	li	a4,2
8000233c:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
80002340:	fec42783          	lw	a5,-20(s0)
80002344:	0887a783          	lw	a5,136(a5)
80002348:	00078513          	mv	a0,a5
8000234c:	91dff0ef          	jal	ra,80001c68 <mkstack>

    p->context.ra = (reg_t)usertrapret;
80002350:	800017b7          	lui	a5,0x80001
80002354:	dec78713          	addi	a4,a5,-532 # 80000dec <memend+0xf8000dec>
80002358:	fec42783          	lw	a5,-20(s0)
8000235c:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
80002360:	fec42783          	lw	a5,-20(s0)
80002364:	08c7a703          	lw	a4,140(a5)
80002368:	fec42783          	lw	a5,-20(s0)
8000236c:	00e7a823          	sw	a4,16(a5)
}
80002370:	00000013          	nop
80002374:	01c12083          	lw	ra,28(sp)
80002378:	01812403          	lw	s0,24(sp)
8000237c:	02010113          	addi	sp,sp,32
80002380:	00008067          	ret

80002384 <schedule>:

void schedule()
{
80002384:	fe010113          	addi	sp,sp,-32
80002388:	00112e23          	sw	ra,28(sp)
8000238c:	00812c23          	sw	s0,24(sp)
80002390:	02010413          	addi	s0,sp,32
    struct cpu *c = nowcpu();
80002394:	c95ff0ef          	jal	ra,80002028 <nowcpu>
80002398:	fea42423          	sw	a0,-24(s0)
    struct pcb *p;

    for (;;)
    {
        for (p = proc; p < &proc[NPROC]; p++)
8000239c:	8000d7b7          	lui	a5,0x8000d
800023a0:	40878793          	addi	a5,a5,1032 # 8000d408 <memend+0xf800d408>
800023a4:	fef42623          	sw	a5,-20(s0)
800023a8:	05c0006f          	j	80002404 <schedule+0x80>
        {
            if (p->status == RUNABLE)
800023ac:	fec42783          	lw	a5,-20(s0)
800023b0:	0047a703          	lw	a4,4(a5)
800023b4:	00200793          	li	a5,2
800023b8:	04f71063          	bne	a4,a5,800023f8 <schedule+0x74>
            {
                p->status = RUNNING;
800023bc:	fec42783          	lw	a5,-20(s0)
800023c0:	00300713          	li	a4,3
800023c4:	00e7a223          	sw	a4,4(a5)
                c->proc = p;
800023c8:	fe842783          	lw	a5,-24(s0)
800023cc:	fec42703          	lw	a4,-20(s0)
800023d0:	00e7a023          	sw	a4,0(a5)
                // 保存当前的上下文到cpu->context中
                swtch(&c->context, &p->context);
800023d4:	fe842783          	lw	a5,-24(s0)
800023d8:	00478713          	addi	a4,a5,4
800023dc:	fec42783          	lw	a5,-20(s0)
800023e0:	00c78793          	addi	a5,a5,12
800023e4:	00078593          	mv	a1,a5
800023e8:	00070513          	mv	a0,a4
800023ec:	db1fd0ef          	jal	ra,8000019c <swtch>
                // swtch ret后跳转到p->context.ra

                c->proc = 0; // cpu->context.ra 指向这里
800023f0:	fe842783          	lw	a5,-24(s0)
800023f4:	0007a023          	sw	zero,0(a5)
        for (p = proc; p < &proc[NPROC]; p++)
800023f8:	fec42783          	lw	a5,-20(s0)
800023fc:	09078793          	addi	a5,a5,144
80002400:	fef42623          	sw	a5,-20(s0)
80002404:	fec42703          	lw	a4,-20(s0)
80002408:	8000d7b7          	lui	a5,0x8000d
8000240c:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
80002410:	f8f76ee3          	bltu	a4,a5,800023ac <schedule+0x28>
80002414:	f89ff06f          	j	8000239c <schedule+0x18>

80002418 <yield>:

/**
 * @description: 进程放弃 CPU
 */
void yield()
{
80002418:	fe010113          	addi	sp,sp,-32
8000241c:	00112e23          	sw	ra,28(sp)
80002420:	00812c23          	sw	s0,24(sp)
80002424:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002428:	bb9ff0ef          	jal	ra,80001fe0 <nowproc>
8000242c:	fea42623          	sw	a0,-20(s0)
    if (p->status != RUNNING)
80002430:	fec42783          	lw	a5,-20(s0)
80002434:	0047a703          	lw	a4,4(a5)
80002438:	00300793          	li	a5,3
8000243c:	00f70863          	beq	a4,a5,8000244c <yield+0x34>
    {
        panic("proc status error");
80002440:	8000c7b7          	lui	a5,0x8000c
80002444:	51878513          	addi	a0,a5,1304 # 8000c518 <memend+0xf800c518>
80002448:	d29fe0ef          	jal	ra,80001170 <panic>
    }
    p->status = RUNABLE;
8000244c:	fec42783          	lw	a5,-20(s0)
80002450:	00200713          	li	a4,2
80002454:	00e7a223          	sw	a4,4(a5)
    sched();
80002458:	018000ef          	jal	ra,80002470 <sched>
}
8000245c:	00000013          	nop
80002460:	01c12083          	lw	ra,28(sp)
80002464:	01812403          	lw	s0,24(sp)
80002468:	02010113          	addi	sp,sp,32
8000246c:	00008067          	ret

80002470 <sched>:

/**
 * @description:
 */
void sched()
{
80002470:	fe010113          	addi	sp,sp,-32
80002474:	00112e23          	sw	ra,28(sp)
80002478:	00812c23          	sw	s0,24(sp)
8000247c:	00912a23          	sw	s1,20(sp)
80002480:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002484:	b5dff0ef          	jal	ra,80001fe0 <nowproc>
80002488:	fea42623          	sw	a0,-20(s0)
    if (p->status == RUNNING)
8000248c:	fec42783          	lw	a5,-20(s0)
80002490:	0047a703          	lw	a4,4(a5)
80002494:	00300793          	li	a5,3
80002498:	00f71863          	bne	a4,a5,800024a8 <sched+0x38>
    {
        panic("proc is running");
8000249c:	8000c7b7          	lui	a5,0x8000c
800024a0:	52c78513          	addi	a0,a5,1324 # 8000c52c <memend+0xf800c52c>
800024a4:	ccdfe0ef          	jal	ra,80001170 <panic>
    }
    swtch(&p->context, &nowcpu()->context); //跳转到cpu->context.ra ( schedule() )
800024a8:	fec42783          	lw	a5,-20(s0)
800024ac:	00c78493          	addi	s1,a5,12
800024b0:	b79ff0ef          	jal	ra,80002028 <nowcpu>
800024b4:	00050793          	mv	a5,a0
800024b8:	00478793          	addi	a5,a5,4
800024bc:	00078593          	mv	a1,a5
800024c0:	00048513          	mv	a0,s1
800024c4:	cd9fd0ef          	jal	ra,8000019c <swtch>
}
800024c8:	00000013          	nop
800024cc:	01c12083          	lw	ra,28(sp)
800024d0:	01812403          	lw	s0,24(sp)
800024d4:	01412483          	lw	s1,20(sp)
800024d8:	02010113          	addi	sp,sp,32
800024dc:	00008067          	ret

800024e0 <sys_fork>:

uint32 sys_fork(void)
{
800024e0:	ff010113          	addi	sp,sp,-16
800024e4:	00112623          	sw	ra,12(sp)
800024e8:	00812423          	sw	s0,8(sp)
800024ec:	01010413          	addi	s0,sp,16
    printf("syscall fork\n");
800024f0:	8000c7b7          	lui	a5,0x8000c
800024f4:	53c78513          	addi	a0,a5,1340 # 8000c53c <memend+0xf800c53c>
800024f8:	cb1fe0ef          	jal	ra,800011a8 <printf>
    return SYS_fork;
800024fc:	00100793          	li	a5,1
}
80002500:	00078513          	mv	a0,a5
80002504:	00c12083          	lw	ra,12(sp)
80002508:	00812403          	lw	s0,8(sp)
8000250c:	01010113          	addi	sp,sp,16
80002510:	00008067          	ret

80002514 <sys_exec>:

uint32 sys_exec(void)
{
80002514:	ff010113          	addi	sp,sp,-16
80002518:	00112623          	sw	ra,12(sp)
8000251c:	00812423          	sw	s0,8(sp)
80002520:	01010413          	addi	s0,sp,16
    printf("syscall exec\n");
80002524:	8000c7b7          	lui	a5,0x8000c
80002528:	54c78513          	addi	a0,a5,1356 # 8000c54c <memend+0xf800c54c>
8000252c:	c7dfe0ef          	jal	ra,800011a8 <printf>
    return SYS_exec;
80002530:	00200793          	li	a5,2
80002534:	00078513          	mv	a0,a5
80002538:	00c12083          	lw	ra,12(sp)
8000253c:	00812403          	lw	s0,8(sp)
80002540:	01010113          	addi	sp,sp,16
80002544:	00008067          	ret

80002548 <memset>:
 */
#include "types.h"

// 初始化内存区域
void *memset(void *addr, int c, uint n)
{
80002548:	fd010113          	addi	sp,sp,-48
8000254c:	02812623          	sw	s0,44(sp)
80002550:	03010413          	addi	s0,sp,48
80002554:	fca42e23          	sw	a0,-36(s0)
80002558:	fcb42c23          	sw	a1,-40(s0)
8000255c:	fcc42a23          	sw	a2,-44(s0)
    char *maddr = (char *)addr;
80002560:	fdc42783          	lw	a5,-36(s0)
80002564:	fef42423          	sw	a5,-24(s0)
    for (uint i = 0; i < n; i++)
80002568:	fe042623          	sw	zero,-20(s0)
8000256c:	0280006f          	j	80002594 <memset+0x4c>
    {
        maddr[i] = (char)c;
80002570:	fe842703          	lw	a4,-24(s0)
80002574:	fec42783          	lw	a5,-20(s0)
80002578:	00f707b3          	add	a5,a4,a5
8000257c:	fd842703          	lw	a4,-40(s0)
80002580:	0ff77713          	andi	a4,a4,255
80002584:	00e78023          	sb	a4,0(a5)
    for (uint i = 0; i < n; i++)
80002588:	fec42783          	lw	a5,-20(s0)
8000258c:	00178793          	addi	a5,a5,1
80002590:	fef42623          	sw	a5,-20(s0)
80002594:	fec42703          	lw	a4,-20(s0)
80002598:	fd442783          	lw	a5,-44(s0)
8000259c:	fcf76ae3          	bltu	a4,a5,80002570 <memset+0x28>
    }
    return addr;
800025a0:	fdc42783          	lw	a5,-36(s0)
}
800025a4:	00078513          	mv	a0,a5
800025a8:	02c12403          	lw	s0,44(sp)
800025ac:	03010113          	addi	sp,sp,48
800025b0:	00008067          	ret

800025b4 <memmove>:

// 安全的 memcpy
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void *memmove(void *dst, const void *src, size_t n)
{
800025b4:	fd010113          	addi	sp,sp,-48
800025b8:	02812623          	sw	s0,44(sp)
800025bc:	03010413          	addi	s0,sp,48
800025c0:	fca42e23          	sw	a0,-36(s0)
800025c4:	fcb42c23          	sw	a1,-40(s0)
800025c8:	fcc42823          	sw	a2,-48(s0)
800025cc:	fcd42a23          	sw	a3,-44(s0)
    const char *s;
    char *d;
    if (n == 0)
800025d0:	fd042783          	lw	a5,-48(s0)
800025d4:	fd442703          	lw	a4,-44(s0)
800025d8:	00e7e7b3          	or	a5,a5,a4
800025dc:	00079663          	bnez	a5,800025e8 <memmove+0x34>
    {
        return dst;
800025e0:	fdc42783          	lw	a5,-36(s0)
800025e4:	1200006f          	j	80002704 <memmove+0x150>
    }

    s = src;
800025e8:	fd842783          	lw	a5,-40(s0)
800025ec:	fef42623          	sw	a5,-20(s0)
    d = dst;
800025f0:	fdc42783          	lw	a5,-36(s0)
800025f4:	fef42423          	sw	a5,-24(s0)
    if (s < d && s + n > d)
800025f8:	fec42703          	lw	a4,-20(s0)
800025fc:	fe842783          	lw	a5,-24(s0)
80002600:	0cf77263          	bgeu	a4,a5,800026c4 <memmove+0x110>
80002604:	fd042783          	lw	a5,-48(s0)
80002608:	fec42703          	lw	a4,-20(s0)
8000260c:	00f707b3          	add	a5,a4,a5
80002610:	fe842703          	lw	a4,-24(s0)
80002614:	0af77863          	bgeu	a4,a5,800026c4 <memmove+0x110>
    {
        // 有重叠区域,从后往前复制
        s += n;
80002618:	fd042783          	lw	a5,-48(s0)
8000261c:	fec42703          	lw	a4,-20(s0)
80002620:	00f707b3          	add	a5,a4,a5
80002624:	fef42623          	sw	a5,-20(s0)
        d += n;
80002628:	fd042783          	lw	a5,-48(s0)
8000262c:	fe842703          	lw	a4,-24(s0)
80002630:	00f707b3          	add	a5,a4,a5
80002634:	fef42423          	sw	a5,-24(s0)
        while (n-- > 0)
80002638:	02c0006f          	j	80002664 <memmove+0xb0>
        {
            *--d = *--s;
8000263c:	fec42783          	lw	a5,-20(s0)
80002640:	fff78793          	addi	a5,a5,-1
80002644:	fef42623          	sw	a5,-20(s0)
80002648:	fe842783          	lw	a5,-24(s0)
8000264c:	fff78793          	addi	a5,a5,-1
80002650:	fef42423          	sw	a5,-24(s0)
80002654:	fec42783          	lw	a5,-20(s0)
80002658:	0007c703          	lbu	a4,0(a5)
8000265c:	fe842783          	lw	a5,-24(s0)
80002660:	00e78023          	sb	a4,0(a5)
        while (n-- > 0)
80002664:	fd042703          	lw	a4,-48(s0)
80002668:	fd442783          	lw	a5,-44(s0)
8000266c:	fff00513          	li	a0,-1
80002670:	fff00593          	li	a1,-1
80002674:	00a70633          	add	a2,a4,a0
80002678:	00060813          	mv	a6,a2
8000267c:	00e83833          	sltu	a6,a6,a4
80002680:	00b786b3          	add	a3,a5,a1
80002684:	00d805b3          	add	a1,a6,a3
80002688:	00058693          	mv	a3,a1
8000268c:	fcc42823          	sw	a2,-48(s0)
80002690:	fcd42a23          	sw	a3,-44(s0)
80002694:	00070693          	mv	a3,a4
80002698:	00f6e6b3          	or	a3,a3,a5
8000269c:	fa0690e3          	bnez	a3,8000263c <memmove+0x88>
    if (s < d && s + n > d)
800026a0:	0600006f          	j	80002700 <memmove+0x14c>
    else
    {
        // 无重叠区域,从前往后复制
        while (n-- > 0)
        {
            *d++ = *s++;
800026a4:	fec42703          	lw	a4,-20(s0)
800026a8:	00170793          	addi	a5,a4,1 # 1001 <sz+0x1>
800026ac:	fef42623          	sw	a5,-20(s0)
800026b0:	fe842783          	lw	a5,-24(s0)
800026b4:	00178693          	addi	a3,a5,1
800026b8:	fed42423          	sw	a3,-24(s0)
800026bc:	00074703          	lbu	a4,0(a4)
800026c0:	00e78023          	sb	a4,0(a5)
        while (n-- > 0)
800026c4:	fd042703          	lw	a4,-48(s0)
800026c8:	fd442783          	lw	a5,-44(s0)
800026cc:	fff00513          	li	a0,-1
800026d0:	fff00593          	li	a1,-1
800026d4:	00a70633          	add	a2,a4,a0
800026d8:	00060813          	mv	a6,a2
800026dc:	00e83833          	sltu	a6,a6,a4
800026e0:	00b786b3          	add	a3,a5,a1
800026e4:	00d805b3          	add	a1,a6,a3
800026e8:	00058693          	mv	a3,a1
800026ec:	fcc42823          	sw	a2,-48(s0)
800026f0:	fcd42a23          	sw	a3,-44(s0)
800026f4:	00070693          	mv	a3,a4
800026f8:	00f6e6b3          	or	a3,a3,a5
800026fc:	fa0694e3          	bnez	a3,800026a4 <memmove+0xf0>
        }
    }
    return dst;
80002700:	fdc42783          	lw	a5,-36(s0)
}
80002704:	00078513          	mv	a0,a5
80002708:	02c12403          	lw	s0,44(sp)
8000270c:	03010113          	addi	sp,sp,48
80002710:	00008067          	ret

80002714 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char *s)
{
80002714:	fd010113          	addi	sp,sp,-48
80002718:	02812623          	sw	s0,44(sp)
8000271c:	03010413          	addi	s0,sp,48
80002720:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for (n = 0; s[n]; n++)
80002724:	00000793          	li	a5,0
80002728:	00000813          	li	a6,0
8000272c:	fef42423          	sw	a5,-24(s0)
80002730:	ff042623          	sw	a6,-20(s0)
80002734:	0340006f          	j	80002768 <strlen+0x54>
80002738:	fe842603          	lw	a2,-24(s0)
8000273c:	fec42683          	lw	a3,-20(s0)
80002740:	00100513          	li	a0,1
80002744:	00000593          	li	a1,0
80002748:	00a60733          	add	a4,a2,a0
8000274c:	00070813          	mv	a6,a4
80002750:	00c83833          	sltu	a6,a6,a2
80002754:	00b687b3          	add	a5,a3,a1
80002758:	00f806b3          	add	a3,a6,a5
8000275c:	00068793          	mv	a5,a3
80002760:	fee42423          	sw	a4,-24(s0)
80002764:	fef42623          	sw	a5,-20(s0)
80002768:	fe842783          	lw	a5,-24(s0)
8000276c:	fdc42703          	lw	a4,-36(s0)
80002770:	00f707b3          	add	a5,a4,a5
80002774:	0007c783          	lbu	a5,0(a5)
80002778:	fc0790e3          	bnez	a5,80002738 <strlen+0x24>
        ;

    return n;
8000277c:	fe842703          	lw	a4,-24(s0)
80002780:	fec42783          	lw	a5,-20(s0)
80002784:	00070513          	mv	a0,a4
80002788:	00078593          	mv	a1,a5
8000278c:	02c12403          	lw	s0,44(sp)
80002790:	03010113          	addi	sp,sp,48
80002794:	00008067          	ret

80002798 <r_tp>:
{
80002798:	fe010113          	addi	sp,sp,-32
8000279c:	00812e23          	sw	s0,28(sp)
800027a0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
800027a4:	00020793          	mv	a5,tp
800027a8:	fef42623          	sw	a5,-20(s0)
    return x;
800027ac:	fec42783          	lw	a5,-20(s0)
}
800027b0:	00078513          	mv	a0,a5
800027b4:	01c12403          	lw	s0,28(sp)
800027b8:	02010113          	addi	sp,sp,32
800027bc:	00008067          	ret

800027c0 <clintinit>:
 */
#include "clint.h"
#include "riscv.h"

void clintinit()
{
800027c0:	fe010113          	addi	sp,sp,-32
800027c4:	00112e23          	sw	ra,28(sp)
800027c8:	00812c23          	sw	s0,24(sp)
800027cc:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp
    int hart = r_tp();
800027d0:	fc9ff0ef          	jal	ra,80002798 <r_tp>
800027d4:	00050793          	mv	a5,a0
800027d8:	fef42623          	sw	a5,-20(s0)
    *(reg_t *)CLINT_MTIMECMP(hart) = *(reg_t *)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
800027dc:	fec42703          	lw	a4,-20(s0)
800027e0:	004017b7          	lui	a5,0x401
800027e4:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800027e8:	00f707b3          	add	a5,a4,a5
800027ec:	00379793          	slli	a5,a5,0x3
800027f0:	0007a703          	lw	a4,0(a5)
800027f4:	fec42683          	lw	a3,-20(s0)
800027f8:	004017b7          	lui	a5,0x401
800027fc:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002800:	00f687b3          	add	a5,a3,a5
80002804:	00379793          	slli	a5,a5,0x3
80002808:	00078693          	mv	a3,a5
8000280c:	009897b7          	lui	a5,0x989
80002810:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80002814:	00f707b3          	add	a5,a4,a5
80002818:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
8000281c:	00000013          	nop
80002820:	01c12083          	lw	ra,28(sp)
80002824:	01812403          	lw	s0,24(sp)
80002828:	02010113          	addi	sp,sp,32
8000282c:	00008067          	ret

80002830 <r_mstatus>:
{
80002830:	fe010113          	addi	sp,sp,-32
80002834:	00812e23          	sw	s0,28(sp)
80002838:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus"
8000283c:	300027f3          	csrr	a5,mstatus
80002840:	fef42623          	sw	a5,-20(s0)
    return x;
80002844:	fec42783          	lw	a5,-20(s0)
}
80002848:	00078513          	mv	a0,a5
8000284c:	01c12403          	lw	s0,28(sp)
80002850:	02010113          	addi	sp,sp,32
80002854:	00008067          	ret

80002858 <w_mstatus>:
{
80002858:	fe010113          	addi	sp,sp,-32
8000285c:	00812e23          	sw	s0,28(sp)
80002860:	02010413          	addi	s0,sp,32
80002864:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0"
80002868:	fec42783          	lw	a5,-20(s0)
8000286c:	30079073          	csrw	mstatus,a5
}
80002870:	00000013          	nop
80002874:	01c12403          	lw	s0,28(sp)
80002878:	02010113          	addi	sp,sp,32
8000287c:	00008067          	ret

80002880 <w_mtvec>:
{
80002880:	fe010113          	addi	sp,sp,-32
80002884:	00812e23          	sw	s0,28(sp)
80002888:	02010413          	addi	s0,sp,32
8000288c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0"
80002890:	fec42783          	lw	a5,-20(s0)
80002894:	30579073          	csrw	mtvec,a5
}
80002898:	00000013          	nop
8000289c:	01c12403          	lw	s0,28(sp)
800028a0:	02010113          	addi	sp,sp,32
800028a4:	00008067          	ret

800028a8 <r_tp>:
{
800028a8:	fe010113          	addi	sp,sp,-32
800028ac:	00812e23          	sw	s0,28(sp)
800028b0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
800028b4:	00020793          	mv	a5,tp
800028b8:	fef42623          	sw	a5,-20(s0)
    return x;
800028bc:	fec42783          	lw	a5,-20(s0)
}
800028c0:	00078513          	mv	a0,a5
800028c4:	01c12403          	lw	s0,28(sp)
800028c8:	02010113          	addi	sp,sp,32
800028cc:	00008067          	ret

800028d0 <s_mstatus_intr>:
{
800028d0:	fd010113          	addi	sp,sp,-48
800028d4:	02112623          	sw	ra,44(sp)
800028d8:	02812423          	sw	s0,40(sp)
800028dc:	03010413          	addi	s0,sp,48
800028e0:	fca42e23          	sw	a0,-36(s0)
    uint32 x = r_mstatus();
800028e4:	f4dff0ef          	jal	ra,80002830 <r_mstatus>
800028e8:	fea42623          	sw	a0,-20(s0)
    switch (m)
800028ec:	fdc42703          	lw	a4,-36(s0)
800028f0:	08000793          	li	a5,128
800028f4:	04f70263          	beq	a4,a5,80002938 <s_mstatus_intr+0x68>
800028f8:	fdc42703          	lw	a4,-36(s0)
800028fc:	08000793          	li	a5,128
80002900:	0ae7e463          	bltu	a5,a4,800029a8 <s_mstatus_intr+0xd8>
80002904:	fdc42703          	lw	a4,-36(s0)
80002908:	02000793          	li	a5,32
8000290c:	04f70463          	beq	a4,a5,80002954 <s_mstatus_intr+0x84>
80002910:	fdc42703          	lw	a4,-36(s0)
80002914:	02000793          	li	a5,32
80002918:	08e7e863          	bltu	a5,a4,800029a8 <s_mstatus_intr+0xd8>
8000291c:	fdc42703          	lw	a4,-36(s0)
80002920:	00200793          	li	a5,2
80002924:	06f70463          	beq	a4,a5,8000298c <s_mstatus_intr+0xbc>
80002928:	fdc42703          	lw	a4,-36(s0)
8000292c:	00800793          	li	a5,8
80002930:	04f70063          	beq	a4,a5,80002970 <s_mstatus_intr+0xa0>
        break;
80002934:	0740006f          	j	800029a8 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
80002938:	fec42783          	lw	a5,-20(s0)
8000293c:	f7f7f793          	andi	a5,a5,-129
80002940:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
80002944:	fec42783          	lw	a5,-20(s0)
80002948:	0807e793          	ori	a5,a5,128
8000294c:	fef42623          	sw	a5,-20(s0)
        break;
80002950:	05c0006f          	j	800029ac <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
80002954:	fec42783          	lw	a5,-20(s0)
80002958:	fdf7f793          	andi	a5,a5,-33
8000295c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
80002960:	fec42783          	lw	a5,-20(s0)
80002964:	0207e793          	ori	a5,a5,32
80002968:	fef42623          	sw	a5,-20(s0)
        break;
8000296c:	0400006f          	j	800029ac <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
80002970:	fec42783          	lw	a5,-20(s0)
80002974:	ff77f793          	andi	a5,a5,-9
80002978:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
8000297c:	fec42783          	lw	a5,-20(s0)
80002980:	0087e793          	ori	a5,a5,8
80002984:	fef42623          	sw	a5,-20(s0)
        break;
80002988:	0240006f          	j	800029ac <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
8000298c:	fec42783          	lw	a5,-20(s0)
80002990:	ffd7f793          	andi	a5,a5,-3
80002994:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80002998:	fec42783          	lw	a5,-20(s0)
8000299c:	0027e793          	ori	a5,a5,2
800029a0:	fef42623          	sw	a5,-20(s0)
        break;
800029a4:	0080006f          	j	800029ac <s_mstatus_intr+0xdc>
        break;
800029a8:	00000013          	nop
    w_mstatus(x);
800029ac:	fec42503          	lw	a0,-20(s0)
800029b0:	ea9ff0ef          	jal	ra,80002858 <w_mstatus>
}
800029b4:	00000013          	nop
800029b8:	02c12083          	lw	ra,44(sp)
800029bc:	02812403          	lw	s0,40(sp)
800029c0:	03010113          	addi	sp,sp,48
800029c4:	00008067          	ret

800029c8 <r_sie>:
{
800029c8:	fe010113          	addi	sp,sp,-32
800029cc:	00812e23          	sw	s0,28(sp)
800029d0:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie "
800029d4:	104027f3          	csrr	a5,sie
800029d8:	fef42623          	sw	a5,-20(s0)
    return x;
800029dc:	fec42783          	lw	a5,-20(s0)
}
800029e0:	00078513          	mv	a0,a5
800029e4:	01c12403          	lw	s0,28(sp)
800029e8:	02010113          	addi	sp,sp,32
800029ec:	00008067          	ret

800029f0 <w_sie>:
{
800029f0:	fe010113          	addi	sp,sp,-32
800029f4:	00812e23          	sw	s0,28(sp)
800029f8:	02010413          	addi	s0,sp,32
800029fc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"
80002a00:	fec42783          	lw	a5,-20(s0)
80002a04:	10479073          	csrw	sie,a5
}
80002a08:	00000013          	nop
80002a0c:	01c12403          	lw	s0,28(sp)
80002a10:	02010113          	addi	sp,sp,32
80002a14:	00008067          	ret

80002a18 <r_mie>:
#define MEIE (1 << 11)
#define MTIE (1 << 7)
#define MSIE (1 << 3)
static inline uint32 r_mie()
{
80002a18:	fe010113          	addi	sp,sp,-32
80002a1c:	00812e23          	sw	s0,28(sp)
80002a20:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie "
80002a24:	304027f3          	csrr	a5,mie
80002a28:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80002a2c:	fec42783          	lw	a5,-20(s0)
}
80002a30:	00078513          	mv	a0,a5
80002a34:	01c12403          	lw	s0,28(sp)
80002a38:	02010113          	addi	sp,sp,32
80002a3c:	00008067          	ret

80002a40 <w_mie>:
static inline void w_mie(uint32 x)
{
80002a40:	fe010113          	addi	sp,sp,-32
80002a44:	00812e23          	sw	s0,28(sp)
80002a48:	02010413          	addi	s0,sp,32
80002a4c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"
80002a50:	fec42783          	lw	a5,-20(s0)
80002a54:	30479073          	csrw	mie,a5
                 :
                 : "r"(x));
}
80002a58:	00000013          	nop
80002a5c:	01c12403          	lw	s0,28(sp)
80002a60:	02010113          	addi	sp,sp,32
80002a64:	00008067          	ret

80002a68 <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x)
{
80002a68:	fe010113          	addi	sp,sp,-32
80002a6c:	00812e23          	sw	s0,28(sp)
80002a70:	02010413          	addi	s0,sp,32
80002a74:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0"
80002a78:	fec42783          	lw	a5,-20(s0)
80002a7c:	34079073          	csrw	mscratch,a5
                 :
                 : "r"(x));
80002a80:	00000013          	nop
80002a84:	01c12403          	lw	s0,28(sp)
80002a88:	02010113          	addi	sp,sp,32
80002a8c:	00008067          	ret

80002a90 <timerinit>:
// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit()
{
80002a90:	fe010113          	addi	sp,sp,-32
80002a94:	00112e23          	sw	ra,28(sp)
80002a98:	00812c23          	sw	s0,24(sp)
80002a9c:	01212a23          	sw	s2,20(sp)
80002aa0:	01312823          	sw	s3,16(sp)
80002aa4:	02010413          	addi	s0,sp,32
    uint hart = r_tp();
80002aa8:	e01ff0ef          	jal	ra,800028a8 <r_tp>
80002aac:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
80002ab0:	fec42703          	lw	a4,-20(s0)
80002ab4:	00070793          	mv	a5,a4
80002ab8:	00279793          	slli	a5,a5,0x2
80002abc:	00e787b3          	add	a5,a5,a4
80002ac0:	00379793          	slli	a5,a5,0x3
80002ac4:	8000e737          	lui	a4,0x8000e
80002ac8:	a5070713          	addi	a4,a4,-1456 # 8000da50 <memend+0xf800da50>
80002acc:	00e787b3          	add	a5,a5,a4
80002ad0:	00078513          	mv	a0,a5
80002ad4:	f95ff0ef          	jal	ra,80002a68 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0] = CLINT_MTIMECMP(hart);
80002ad8:	fec42703          	lw	a4,-20(s0)
80002adc:	004017b7          	lui	a5,0x401
80002ae0:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002ae4:	00f707b3          	add	a5,a4,a5
80002ae8:	00379793          	slli	a5,a5,0x3
80002aec:	00078913          	mv	s2,a5
80002af0:	00000993          	li	s3,0
80002af4:	8000e7b7          	lui	a5,0x8000e
80002af8:	a5078693          	addi	a3,a5,-1456 # 8000da50 <memend+0xf800da50>
80002afc:	fec42703          	lw	a4,-20(s0)
80002b00:	00070793          	mv	a5,a4
80002b04:	00279793          	slli	a5,a5,0x2
80002b08:	00e787b3          	add	a5,a5,a4
80002b0c:	00379793          	slli	a5,a5,0x3
80002b10:	00f687b3          	add	a5,a3,a5
80002b14:	0127a023          	sw	s2,0(a5)
80002b18:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1] = CLINT_INTERVAL;
80002b1c:	8000e7b7          	lui	a5,0x8000e
80002b20:	a5078693          	addi	a3,a5,-1456 # 8000da50 <memend+0xf800da50>
80002b24:	fec42703          	lw	a4,-20(s0)
80002b28:	00070793          	mv	a5,a4
80002b2c:	00279793          	slli	a5,a5,0x2
80002b30:	00e787b3          	add	a5,a5,a4
80002b34:	00379793          	slli	a5,a5,0x3
80002b38:	00f686b3          	add	a3,a3,a5
80002b3c:	00989737          	lui	a4,0x989
80002b40:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002b44:	00000793          	li	a5,0
80002b48:	00e6a423          	sw	a4,8(a3)
80002b4c:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec); // 设置 M-mode time trap处理函数
80002b50:	800007b7          	lui	a5,0x80000
80002b54:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
80002b58:	00078513          	mv	a0,a5
80002b5c:	d25ff0ef          	jal	ra,80002880 <w_mtvec>

    s_mstatus_intr(INTR_MIE); // 开启 M-mode 全局中断
80002b60:	00800513          	li	a0,8
80002b64:	d6dff0ef          	jal	ra,800028d0 <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
80002b68:	e61ff0ef          	jal	ra,800029c8 <r_sie>
80002b6c:	00050793          	mv	a5,a0
80002b70:	2227e793          	ori	a5,a5,546
80002b74:	00078513          	mv	a0,a5
80002b78:	e79ff0ef          	jal	ra,800029f0 <w_sie>

    w_mie(r_mie() | MTIE); // 开启 M-mode 时钟中断
80002b7c:	e9dff0ef          	jal	ra,80002a18 <r_mie>
80002b80:	00050793          	mv	a5,a0
80002b84:	0807e793          	ori	a5,a5,128
80002b88:	00078513          	mv	a0,a5
80002b8c:	eb5ff0ef          	jal	ra,80002a40 <w_mie>

    clintinit(); // 初始化 CLINT
80002b90:	c31ff0ef          	jal	ra,800027c0 <clintinit>
80002b94:	00000013          	nop
80002b98:	01c12083          	lw	ra,28(sp)
80002b9c:	01812403          	lw	s0,24(sp)
80002ba0:	01412903          	lw	s2,20(sp)
80002ba4:	01012983          	lw	s3,16(sp)
80002ba8:	02010113          	addi	sp,sp,32
80002bac:	00008067          	ret

80002bb0 <r_sepc>:
{
80002bb0:	fe010113          	addi	sp,sp,-32
80002bb4:	00812e23          	sw	s0,28(sp)
80002bb8:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, sepc"
80002bbc:	141027f3          	csrr	a5,sepc
80002bc0:	fef42623          	sw	a5,-20(s0)
    return x;
80002bc4:	fec42783          	lw	a5,-20(s0)
}
80002bc8:	00078513          	mv	a0,a5
80002bcc:	01c12403          	lw	s0,28(sp)
80002bd0:	02010113          	addi	sp,sp,32
80002bd4:	00008067          	ret

80002bd8 <syscall>:
    [SYS_fork] sys_fork,
    [SYS_exec] sys_exec,
};

void syscall()
{
80002bd8:	fe010113          	addi	sp,sp,-32
80002bdc:	00112e23          	sw	ra,28(sp)
80002be0:	00812c23          	sw	s0,24(sp)
80002be4:	00912a23          	sw	s1,20(sp)
80002be8:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002bec:	bf4ff0ef          	jal	ra,80001fe0 <nowproc>
80002bf0:	fea42623          	sw	a0,-20(s0)
    p->trapframe->epc = r_sepc();
80002bf4:	fec42783          	lw	a5,-20(s0)
80002bf8:	0087a483          	lw	s1,8(a5)
80002bfc:	fb5ff0ef          	jal	ra,80002bb0 <r_sepc>
80002c00:	00050793          	mv	a5,a0
80002c04:	00f4a623          	sw	a5,12(s1)
    p->trapframe->epc += 4;
80002c08:	fec42783          	lw	a5,-20(s0)
80002c0c:	0087a783          	lw	a5,8(a5)
80002c10:	00c7a703          	lw	a4,12(a5)
80002c14:	fec42783          	lw	a5,-20(s0)
80002c18:	0087a783          	lw	a5,8(a5)
80002c1c:	00470713          	addi	a4,a4,4
80002c20:	00e7a623          	sw	a4,12(a5)

    uint32 sysnum = p->trapframe->a7;
80002c24:	fec42783          	lw	a5,-20(s0)
80002c28:	0087a783          	lw	a5,8(a5)
80002c2c:	03c7a783          	lw	a5,60(a5)
80002c30:	fef42423          	sw	a5,-24(s0)
    p->trapframe->a0 = syscalls[sysnum]();
80002c34:	8000b7b7          	lui	a5,0x8000b
80002c38:	01878713          	addi	a4,a5,24 # 8000b018 <memend+0xf800b018>
80002c3c:	fe842783          	lw	a5,-24(s0)
80002c40:	00279793          	slli	a5,a5,0x2
80002c44:	00f707b3          	add	a5,a4,a5
80002c48:	0007a703          	lw	a4,0(a5)
80002c4c:	fec42783          	lw	a5,-20(s0)
80002c50:	0087a483          	lw	s1,8(a5)
80002c54:	000700e7          	jalr	a4
80002c58:	00050793          	mv	a5,a0
80002c5c:	02f4a023          	sw	a5,32(s1)
80002c60:	00000013          	nop
80002c64:	01c12083          	lw	ra,28(sp)
80002c68:	01812403          	lw	s0,24(sp)
80002c6c:	01412483          	lw	s1,20(sp)
80002c70:	02010113          	addi	sp,sp,32
80002c74:	00008067          	ret

80002c78 <mmioinit>:
#include "types.h"
#include "defs.h"
#include "mmio.h"

void mmioinit()
{
80002c78:	ff010113          	addi	sp,sp,-16
80002c7c:	00112623          	sw	ra,12(sp)
80002c80:	00812423          	sw	s0,8(sp)
80002c84:	01010413          	addi	s0,sp,16
    printf("%x\n",mmio_read(MMIO_MagicValue));
80002c88:	100017b7          	lui	a5,0x10001
80002c8c:	0007a783          	lw	a5,0(a5) # 10001000 <sz+0x10000000>
80002c90:	00078593          	mv	a1,a5
80002c94:	8000c7b7          	lui	a5,0x8000c
80002c98:	55c78513          	addi	a0,a5,1372 # 8000c55c <memend+0xf800c55c>
80002c9c:	d0cfe0ef          	jal	ra,800011a8 <printf>
80002ca0:	00000013          	nop
80002ca4:	00c12083          	lw	ra,12(sp)
80002ca8:	00812403          	lw	s0,8(sp)
80002cac:	01010113          	addi	sp,sp,16
80002cb0:	00008067          	ret

80002cb4 <textend>:
	...
