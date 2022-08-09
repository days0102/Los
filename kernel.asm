
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
80000010:	ff410113          	addi	sp,sp,-12 # 80004000 <datastart>
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
800000ac:	6d5000ef          	jal	ra,80000f80 <trapvec>

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
8000032c:	455000ef          	jal	ra,80000f80 <trapvec>

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
800006d4:	8000d7b7          	lui	a5,0x8000d
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
80000720:	430020ef          	jal	ra,80002b50 <timerinit>

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
#include "defs.h"
#include "swtch.h"
#include "virtio.h"

void main()
{
8000090c:	df010113          	addi	sp,sp,-528
80000910:	20112623          	sw	ra,524(sp)
80000914:	20812423          	sw	s0,520(sp)
80000918:	21010413          	addi	s0,sp,528
    printf("start run main()\n");
8000091c:	8000d7b7          	lui	a5,0x8000d
80000920:	00c78513          	addi	a0,a5,12 # 8000d00c <memend+0xf800d00c>
80000924:	119000ef          	jal	ra,8000123c <printf>

    minit();    // 物理内存管理
80000928:	521000ef          	jal	ra,80001648 <minit>
    plicinit(); // PLIC 中断处理
8000092c:	7a1000ef          	jal	ra,800018cc <plicinit>

    kvminit(); // 启动虚拟内存
80000930:	464010ef          	jal	ra,80001d94 <kvminit>
    
#ifdef DEBUG
    printf("usertrap: %p\n", usertrap);
80000934:	800007b7          	lui	a5,0x80000
80000938:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
8000093c:	8000d7b7          	lui	a5,0x8000d
80000940:	02078513          	addi	a0,a5,32 # 8000d020 <memend+0xf800d020>
80000944:	0f9000ef          	jal	ra,8000123c <printf>
#endif

    procinit();
80000948:	6dc010ef          	jal	ra,80002024 <procinit>

    userinit();
8000094c:	0b5010ef          	jal	ra,80002200 <userinit>

    mmioinit();
80000950:	3e8020ef          	jal	ra,80002d38 <mmioinit>

    char buf[512];
    diskrw(0,1,buf);
80000954:	df040793          	addi	a5,s0,-528
80000958:	00078613          	mv	a2,a5
8000095c:	00100593          	li	a1,1
80000960:	00000513          	li	a0,0
80000964:	079020ef          	jal	ra,800031dc <diskrw>
    printf("%s\n",buf);
80000968:	df040793          	addi	a5,s0,-528
8000096c:	00078593          	mv	a1,a5
80000970:	8000d7b7          	lui	a5,0x8000d
80000974:	03078513          	addi	a0,a5,48 # 8000d030 <memend+0xf800d030>
80000978:	0c5000ef          	jal	ra,8000123c <printf>
    // virtio_disk_init();
    // struct buf b;
    // virtio_disk_rw(&b, 1);

    printf("----------------------\n");
8000097c:	8000d7b7          	lui	a5,0x8000d
80000980:	03478513          	addi	a0,a5,52 # 8000d034 <memend+0xf800d034>
80000984:	0b9000ef          	jal	ra,8000123c <printf>
    schedule();
80000988:	2b5010ef          	jal	ra,8000243c <schedule>
}
8000098c:	00000013          	nop
80000990:	20c12083          	lw	ra,524(sp)
80000994:	20812403          	lw	s0,520(sp)
80000998:	21010113          	addi	sp,sp,528
8000099c:	00008067          	ret

800009a0 <r_sstatus>:
    w_mstatus(x);
}

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus()
{
800009a0:	fe010113          	addi	sp,sp,-32
800009a4:	00812e23          	sw	s0,28(sp)
800009a8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus"
800009ac:	100027f3          	csrr	a5,sstatus
800009b0:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
800009b4:	fec42783          	lw	a5,-20(s0)
}
800009b8:	00078513          	mv	a0,a5
800009bc:	01c12403          	lw	s0,28(sp)
800009c0:	02010113          	addi	sp,sp,32
800009c4:	00008067          	ret

800009c8 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x)
{
800009c8:	fe010113          	addi	sp,sp,-32
800009cc:	00812e23          	sw	s0,28(sp)
800009d0:	02010413          	addi	s0,sp,32
800009d4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0"
800009d8:	fec42783          	lw	a5,-20(s0)
800009dc:	10079073          	csrw	sstatus,a5
                 :
                 : "r"(x));
}
800009e0:	00000013          	nop
800009e4:	01c12403          	lw	s0,28(sp)
800009e8:	02010113          	addi	sp,sp,32
800009ec:	00008067          	ret

800009f0 <s_sstatus_xpp>:
    return x;
}
// 设置特权模式
#define S_SPP_SET (1 << 8)
static inline void s_sstatus_xpp(uint8 m)
{
800009f0:	fd010113          	addi	sp,sp,-48
800009f4:	02112623          	sw	ra,44(sp)
800009f8:	02812423          	sw	s0,40(sp)
800009fc:	03010413          	addi	s0,sp,48
80000a00:	00050793          	mv	a5,a0
80000a04:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x = r_sstatus();
80000a08:	f99ff0ef          	jal	ra,800009a0 <r_sstatus>
80000a0c:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000a10:	fdf44783          	lbu	a5,-33(s0)
80000a14:	00078863          	beqz	a5,80000a24 <s_sstatus_xpp+0x34>
80000a18:	00100713          	li	a4,1
80000a1c:	00e78c63          	beq	a5,a4,80000a34 <s_sstatus_xpp+0x44>
    case RISCV_S:
        x &= ~SPP_MASK;
        x |= S_SPP_SET;
        break;
    default:
        break;
80000a20:	0300006f          	j	80000a50 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
80000a24:	fec42783          	lw	a5,-20(s0)
80000a28:	eff7f793          	andi	a5,a5,-257
80000a2c:	fef42623          	sw	a5,-20(s0)
        break;
80000a30:	0200006f          	j	80000a50 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
80000a34:	fec42783          	lw	a5,-20(s0)
80000a38:	eff7f793          	andi	a5,a5,-257
80000a3c:	fef42623          	sw	a5,-20(s0)
        x |= S_SPP_SET;
80000a40:	fec42783          	lw	a5,-20(s0)
80000a44:	1007e793          	ori	a5,a5,256
80000a48:	fef42623          	sw	a5,-20(s0)
        break;
80000a4c:	00000013          	nop
    }
    w_sstatus(x);
80000a50:	fec42503          	lw	a0,-20(s0)
80000a54:	f75ff0ef          	jal	ra,800009c8 <w_sstatus>
}
80000a58:	00000013          	nop
80000a5c:	02c12083          	lw	ra,44(sp)
80000a60:	02812403          	lw	s0,40(sp)
80000a64:	03010113          	addi	sp,sp,48
80000a68:	00008067          	ret

80000a6c <w_sepc>:
                 : "=r"(x));
    return x;
}
// 写 sepc寄存器
static inline void w_sepc(uint32 x)
{
80000a6c:	fe010113          	addi	sp,sp,-32
80000a70:	00812e23          	sw	s0,28(sp)
80000a74:	02010413          	addi	s0,sp,32
80000a78:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0"
80000a7c:	fec42783          	lw	a5,-20(s0)
80000a80:	14179073          	csrw	sepc,a5
                 :
                 : "r"(x));
}
80000a84:	00000013          	nop
80000a88:	01c12403          	lw	s0,28(sp)
80000a8c:	02010113          	addi	sp,sp,32
80000a90:	00008067          	ret

80000a94 <w_stvec>:
    asm volatile("csrr %0 , stvec"
                 : "=r"(x));
    return x;
}
static inline void w_stvec(uint32 x)
{
80000a94:	fe010113          	addi	sp,sp,-32
80000a98:	00812e23          	sw	s0,28(sp)
80000a9c:	02010413          	addi	s0,sp,32
80000aa0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0"
80000aa4:	fec42783          	lw	a5,-20(s0)
80000aa8:	10579073          	csrw	stvec,a5
                 :
                 : "r"(x));
}
80000aac:	00000013          	nop
80000ab0:	01c12403          	lw	s0,28(sp)
80000ab4:	02010113          	addi	sp,sp,32
80000ab8:	00008067          	ret

80000abc <r_satp>:
 * asid = 地址空间标识
 * ppn  = 根页表物理页码(物理地址/4Kb)
 */
#define SATP_SV32 (1 << 31)
static inline uint32 r_satp()
{
80000abc:	fe010113          	addi	sp,sp,-32
80000ac0:	00812e23          	sw	s0,28(sp)
80000ac4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,satp"
80000ac8:	180027f3          	csrr	a5,satp
80000acc:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000ad0:	fec42783          	lw	a5,-20(s0)
}
80000ad4:	00078513          	mv	a0,a5
80000ad8:	01c12403          	lw	s0,28(sp)
80000adc:	02010113          	addi	sp,sp,32
80000ae0:	00008067          	ret

80000ae4 <r_scause>:
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常
 */
static inline uint32 r_scause()
{
80000ae4:	fe010113          	addi	sp,sp,-32
80000ae8:	00812e23          	sw	s0,28(sp)
80000aec:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause"
80000af0:	142027f3          	csrr	a5,scause
80000af4:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000af8:	fec42783          	lw	a5,-20(s0)
}
80000afc:	00078513          	mv	a0,a5
80000b00:	01c12403          	lw	s0,28(sp)
80000b04:	02010113          	addi	sp,sp,32
80000b08:	00008067          	ret

80000b0c <r_stval>:
/** 如果stval在指令获取、加载或存储发生断点、
 * 地址错位、访问错误或页面错误异常时使用非
 * 零值写入，则stval将包含出错的虚拟地址。
 */
static inline uint32 r_stval()
{
80000b0c:	fe010113          	addi	sp,sp,-32
80000b10:	00812e23          	sw	s0,28(sp)
80000b14:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,stval"
80000b18:	143027f3          	csrr	a5,stval
80000b1c:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000b20:	fec42783          	lw	a5,-20(s0)
}
80000b24:	00078513          	mv	a0,a5
80000b28:	01c12403          	lw	s0,28(sp)
80000b2c:	02010113          	addi	sp,sp,32
80000b30:	00008067          	ret

80000b34 <r_sip>:
/**
 * @description:
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip()
{
80000b34:	fe010113          	addi	sp,sp,-32
80000b38:	00812e23          	sw	s0,28(sp)
80000b3c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip"
80000b40:	144027f3          	csrr	a5,sip
80000b44:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000b48:	fec42783          	lw	a5,-20(s0)
}
80000b4c:	00078513          	mv	a0,a5
80000b50:	01c12403          	lw	s0,28(sp)
80000b54:	02010113          	addi	sp,sp,32
80000b58:	00008067          	ret

80000b5c <w_sip>:
static inline void w_sip(uint32 x)
{
80000b5c:	fe010113          	addi	sp,sp,-32
80000b60:	00812e23          	sw	s0,28(sp)
80000b64:	02010413          	addi	s0,sp,32
80000b68:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"
80000b6c:	fec42783          	lw	a5,-20(s0)
80000b70:	14479073          	csrw	sip,a5
                 :
                 : "r"(x));
}
80000b74:	00000013          	nop
80000b78:	01c12403          	lw	s0,28(sp)
80000b7c:	02010113          	addi	sp,sp,32
80000b80:	00008067          	ret

80000b84 <externinterrupt>:

/**
 * @description: 处理外部中断
 */
void externinterrupt()
{
80000b84:	fe010113          	addi	sp,sp,-32
80000b88:	00112e23          	sw	ra,28(sp)
80000b8c:	00812c23          	sw	s0,24(sp)
80000b90:	02010413          	addi	s0,sp,32
    uint32 irq = r_plicclaim();
80000b94:	60d000ef          	jal	ra,800019a0 <r_plicclaim>
80000b98:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n", irq);
80000b9c:	fec42583          	lw	a1,-20(s0)
80000ba0:	8000d7b7          	lui	a5,0x8000d
80000ba4:	04c78513          	addi	a0,a5,76 # 8000d04c <memend+0xf800d04c>
80000ba8:	694000ef          	jal	ra,8000123c <printf>
    switch (irq)
80000bac:	fec42703          	lw	a4,-20(s0)
80000bb0:	00100793          	li	a5,1
80000bb4:	02f70663          	beq	a4,a5,80000be0 <externinterrupt+0x5c>
80000bb8:	fec42703          	lw	a4,-20(s0)
80000bbc:	00a00793          	li	a5,10
80000bc0:	02f71863          	bne	a4,a5,80000bf0 <externinterrupt+0x6c>
    {
    case UART_IRQ: // uart 中断(键盘输入)
        printf("recived : %c\n", uartintr());
80000bc4:	d19ff0ef          	jal	ra,800008dc <uartintr>
80000bc8:	00050793          	mv	a5,a0
80000bcc:	00078593          	mv	a1,a5
80000bd0:	8000d7b7          	lui	a5,0x8000d
80000bd4:	05878513          	addi	a0,a5,88 # 8000d058 <memend+0xf800d058>
80000bd8:	664000ef          	jal	ra,8000123c <printf>
        break;
80000bdc:	0180006f          	j	80000bf4 <externinterrupt+0x70>
    case VIRTIO_IRQ:
        printf("virtio interrupt\n");
80000be0:	8000d7b7          	lui	a5,0x8000d
80000be4:	06878513          	addi	a0,a5,104 # 8000d068 <memend+0xf800d068>
80000be8:	654000ef          	jal	ra,8000123c <printf>
        break;
80000bec:	0080006f          	j	80000bf4 <externinterrupt+0x70>
    default:
        break;
80000bf0:	00000013          	nop
    }
    w_pliccomplete(irq);
80000bf4:	fec42503          	lw	a0,-20(s0)
80000bf8:	5e9000ef          	jal	ra,800019e0 <w_pliccomplete>
}
80000bfc:	00000013          	nop
80000c00:	01c12083          	lw	ra,28(sp)
80000c04:	01812403          	lw	s0,24(sp)
80000c08:	02010113          	addi	sp,sp,32
80000c0c:	00008067          	ret

80000c10 <ptf>:

void ptf(struct trapframe *tf)
{
80000c10:	fe010113          	addi	sp,sp,-32
80000c14:	00112e23          	sw	ra,28(sp)
80000c18:	00812c23          	sw	s0,24(sp)
80000c1c:	02010413          	addi	s0,sp,32
80000c20:	fea42623          	sw	a0,-20(s0)
    printf("kernel_sp: %d \n", tf->kernel_sp);
80000c24:	fec42783          	lw	a5,-20(s0)
80000c28:	0087a783          	lw	a5,8(a5)
80000c2c:	00078593          	mv	a1,a5
80000c30:	8000d7b7          	lui	a5,0x8000d
80000c34:	07c78513          	addi	a0,a5,124 # 8000d07c <memend+0xf800d07c>
80000c38:	604000ef          	jal	ra,8000123c <printf>
    printf("kernel_satp: %d \n", tf->kernel_satp);
80000c3c:	fec42783          	lw	a5,-20(s0)
80000c40:	0007a783          	lw	a5,0(a5)
80000c44:	00078593          	mv	a1,a5
80000c48:	8000d7b7          	lui	a5,0x8000d
80000c4c:	08c78513          	addi	a0,a5,140 # 8000d08c <memend+0xf800d08c>
80000c50:	5ec000ef          	jal	ra,8000123c <printf>
    printf("kernel_tvec: %d \n", tf->kernel_tvec);
80000c54:	fec42783          	lw	a5,-20(s0)
80000c58:	0047a783          	lw	a5,4(a5)
80000c5c:	00078593          	mv	a1,a5
80000c60:	8000d7b7          	lui	a5,0x8000d
80000c64:	0a078513          	addi	a0,a5,160 # 8000d0a0 <memend+0xf800d0a0>
80000c68:	5d4000ef          	jal	ra,8000123c <printf>

    printf("ra: %d \n", tf->ra);
80000c6c:	fec42783          	lw	a5,-20(s0)
80000c70:	0107a783          	lw	a5,16(a5)
80000c74:	00078593          	mv	a1,a5
80000c78:	8000d7b7          	lui	a5,0x8000d
80000c7c:	0b478513          	addi	a0,a5,180 # 8000d0b4 <memend+0xf800d0b4>
80000c80:	5bc000ef          	jal	ra,8000123c <printf>
    printf("sp: %d \n", tf->sp);
80000c84:	fec42783          	lw	a5,-20(s0)
80000c88:	0147a783          	lw	a5,20(a5)
80000c8c:	00078593          	mv	a1,a5
80000c90:	8000d7b7          	lui	a5,0x8000d
80000c94:	0c078513          	addi	a0,a5,192 # 8000d0c0 <memend+0xf800d0c0>
80000c98:	5a4000ef          	jal	ra,8000123c <printf>
    printf("tp: %d \n", tf->tp);
80000c9c:	fec42783          	lw	a5,-20(s0)
80000ca0:	01c7a783          	lw	a5,28(a5)
80000ca4:	00078593          	mv	a1,a5
80000ca8:	8000d7b7          	lui	a5,0x8000d
80000cac:	0cc78513          	addi	a0,a5,204 # 8000d0cc <memend+0xf800d0cc>
80000cb0:	58c000ef          	jal	ra,8000123c <printf>
    printf("t0: %d \n", tf->t0);
80000cb4:	fec42783          	lw	a5,-20(s0)
80000cb8:	0707a783          	lw	a5,112(a5)
80000cbc:	00078593          	mv	a1,a5
80000cc0:	8000d7b7          	lui	a5,0x8000d
80000cc4:	0d878513          	addi	a0,a5,216 # 8000d0d8 <memend+0xf800d0d8>
80000cc8:	574000ef          	jal	ra,8000123c <printf>
    printf("t1: %d \n", tf->t1);
80000ccc:	fec42783          	lw	a5,-20(s0)
80000cd0:	0747a783          	lw	a5,116(a5)
80000cd4:	00078593          	mv	a1,a5
80000cd8:	8000d7b7          	lui	a5,0x8000d
80000cdc:	0e478513          	addi	a0,a5,228 # 8000d0e4 <memend+0xf800d0e4>
80000ce0:	55c000ef          	jal	ra,8000123c <printf>
    printf("t2: %d \n", tf->t2);
80000ce4:	fec42783          	lw	a5,-20(s0)
80000ce8:	0787a783          	lw	a5,120(a5)
80000cec:	00078593          	mv	a1,a5
80000cf0:	8000d7b7          	lui	a5,0x8000d
80000cf4:	0f078513          	addi	a0,a5,240 # 8000d0f0 <memend+0xf800d0f0>
80000cf8:	544000ef          	jal	ra,8000123c <printf>
    printf("t3: %d \n", tf->t3);
80000cfc:	fec42783          	lw	a5,-20(s0)
80000d00:	07c7a783          	lw	a5,124(a5)
80000d04:	00078593          	mv	a1,a5
80000d08:	8000d7b7          	lui	a5,0x8000d
80000d0c:	0fc78513          	addi	a0,a5,252 # 8000d0fc <memend+0xf800d0fc>
80000d10:	52c000ef          	jal	ra,8000123c <printf>
    printf("t4: %d \n", tf->t4);
80000d14:	fec42783          	lw	a5,-20(s0)
80000d18:	0807a783          	lw	a5,128(a5)
80000d1c:	00078593          	mv	a1,a5
80000d20:	8000d7b7          	lui	a5,0x8000d
80000d24:	10878513          	addi	a0,a5,264 # 8000d108 <memend+0xf800d108>
80000d28:	514000ef          	jal	ra,8000123c <printf>
    printf("t5: %d \n", tf->t5);
80000d2c:	fec42783          	lw	a5,-20(s0)
80000d30:	0847a783          	lw	a5,132(a5)
80000d34:	00078593          	mv	a1,a5
80000d38:	8000d7b7          	lui	a5,0x8000d
80000d3c:	11478513          	addi	a0,a5,276 # 8000d114 <memend+0xf800d114>
80000d40:	4fc000ef          	jal	ra,8000123c <printf>
    printf("t6: %d \n", tf->t6);
80000d44:	fec42783          	lw	a5,-20(s0)
80000d48:	0887a783          	lw	a5,136(a5)
80000d4c:	00078593          	mv	a1,a5
80000d50:	8000d7b7          	lui	a5,0x8000d
80000d54:	12078513          	addi	a0,a5,288 # 8000d120 <memend+0xf800d120>
80000d58:	4e4000ef          	jal	ra,8000123c <printf>
    printf("a0: %d \n", tf->a0);
80000d5c:	fec42783          	lw	a5,-20(s0)
80000d60:	0207a783          	lw	a5,32(a5)
80000d64:	00078593          	mv	a1,a5
80000d68:	8000d7b7          	lui	a5,0x8000d
80000d6c:	12c78513          	addi	a0,a5,300 # 8000d12c <memend+0xf800d12c>
80000d70:	4cc000ef          	jal	ra,8000123c <printf>
    printf("a1: %d \n", tf->a1);
80000d74:	fec42783          	lw	a5,-20(s0)
80000d78:	0247a783          	lw	a5,36(a5)
80000d7c:	00078593          	mv	a1,a5
80000d80:	8000d7b7          	lui	a5,0x8000d
80000d84:	13878513          	addi	a0,a5,312 # 8000d138 <memend+0xf800d138>
80000d88:	4b4000ef          	jal	ra,8000123c <printf>
    printf("a2: %d \n", tf->a2);
80000d8c:	fec42783          	lw	a5,-20(s0)
80000d90:	0287a783          	lw	a5,40(a5)
80000d94:	00078593          	mv	a1,a5
80000d98:	8000d7b7          	lui	a5,0x8000d
80000d9c:	14478513          	addi	a0,a5,324 # 8000d144 <memend+0xf800d144>
80000da0:	49c000ef          	jal	ra,8000123c <printf>
    printf("a3: %d \n", tf->a3);
80000da4:	fec42783          	lw	a5,-20(s0)
80000da8:	02c7a783          	lw	a5,44(a5)
80000dac:	00078593          	mv	a1,a5
80000db0:	8000d7b7          	lui	a5,0x8000d
80000db4:	15078513          	addi	a0,a5,336 # 8000d150 <memend+0xf800d150>
80000db8:	484000ef          	jal	ra,8000123c <printf>
    printf("a4: %d \n", tf->a4);
80000dbc:	fec42783          	lw	a5,-20(s0)
80000dc0:	0307a783          	lw	a5,48(a5)
80000dc4:	00078593          	mv	a1,a5
80000dc8:	8000d7b7          	lui	a5,0x8000d
80000dcc:	15c78513          	addi	a0,a5,348 # 8000d15c <memend+0xf800d15c>
80000dd0:	46c000ef          	jal	ra,8000123c <printf>
    printf("a5: %d \n", tf->a5);
80000dd4:	fec42783          	lw	a5,-20(s0)
80000dd8:	0347a783          	lw	a5,52(a5)
80000ddc:	00078593          	mv	a1,a5
80000de0:	8000d7b7          	lui	a5,0x8000d
80000de4:	16878513          	addi	a0,a5,360 # 8000d168 <memend+0xf800d168>
80000de8:	454000ef          	jal	ra,8000123c <printf>
    printf("a6: %d \n", tf->a6);
80000dec:	fec42783          	lw	a5,-20(s0)
80000df0:	0387a783          	lw	a5,56(a5)
80000df4:	00078593          	mv	a1,a5
80000df8:	8000d7b7          	lui	a5,0x8000d
80000dfc:	17478513          	addi	a0,a5,372 # 8000d174 <memend+0xf800d174>
80000e00:	43c000ef          	jal	ra,8000123c <printf>
    printf("a7: %d \n", tf->a7);
80000e04:	fec42783          	lw	a5,-20(s0)
80000e08:	03c7a783          	lw	a5,60(a5)
80000e0c:	00078593          	mv	a1,a5
80000e10:	8000d7b7          	lui	a5,0x8000d
80000e14:	18078513          	addi	a0,a5,384 # 8000d180 <memend+0xf800d180>
80000e18:	424000ef          	jal	ra,8000123c <printf>
}
80000e1c:	00000013          	nop
80000e20:	01c12083          	lw	ra,28(sp)
80000e24:	01812403          	lw	s0,24(sp)
80000e28:	02010113          	addi	sp,sp,32
80000e2c:	00008067          	ret

80000e30 <usertrapret>:

// 返回用户空间
void usertrapret()
{
80000e30:	fe010113          	addi	sp,sp,-32
80000e34:	00112e23          	sw	ra,28(sp)
80000e38:	00812c23          	sw	s0,24(sp)
80000e3c:	00912a23          	sw	s1,20(sp)
80000e40:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80000e44:	2ac010ef          	jal	ra,800020f0 <nowproc>
80000e48:	fea42623          	sw	a0,-20(s0)
    s_sstatus_xpp(RISCV_U);
80000e4c:	00000513          	li	a0,0
80000e50:	ba1ff0ef          	jal	ra,800009f0 <s_sstatus_xpp>
    w_stvec((uint32)usertrap);
80000e54:	800007b7          	lui	a5,0x80000
80000e58:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80000e5c:	00078513          	mv	a0,a5
80000e60:	c35ff0ef          	jal	ra,80000a94 <w_stvec>
    addr_t satp = (SATP_SV32 | (addr_t)(p->pagetable) >> 12);
80000e64:	fec42783          	lw	a5,-20(s0)
80000e68:	0887a783          	lw	a5,136(a5)
80000e6c:	00c7d713          	srli	a4,a5,0xc
80000e70:	800007b7          	lui	a5,0x80000
80000e74:	00f767b3          	or	a5,a4,a5
80000e78:	fef42423          	sw	a5,-24(s0)
    // ptf(p->trapframe);

    // printf("%p\n",p->trapframe);
    // printf("sepc: %p\n",r_sepc());

    w_sepc((addr_t)p->trapframe->epc);
80000e7c:	fec42783          	lw	a5,-20(s0)
80000e80:	0087a783          	lw	a5,8(a5) # 80000008 <memend+0xf8000008>
80000e84:	00c7a783          	lw	a5,12(a5)
80000e88:	00078513          	mv	a0,a5
80000e8c:	be1ff0ef          	jal	ra,80000a6c <w_sepc>

    p->trapframe->kernel_satp = r_satp();
80000e90:	fec42783          	lw	a5,-20(s0)
80000e94:	0087a483          	lw	s1,8(a5)
80000e98:	c25ff0ef          	jal	ra,80000abc <r_satp>
80000e9c:	00050793          	mv	a5,a0
80000ea0:	00f4a023          	sw	a5,0(s1)
    p->trapframe->kernel_tvec = (addr_t)trapvec;
80000ea4:	fec42783          	lw	a5,-20(s0)
80000ea8:	0087a783          	lw	a5,8(a5)
80000eac:	80001737          	lui	a4,0x80001
80000eb0:	f8070713          	addi	a4,a4,-128 # 80000f80 <memend+0xf8000f80>
80000eb4:	00e7a223          	sw	a4,4(a5)
    p->trapframe->kernel_sp = (addr_t)p->kernelstack;
80000eb8:	fec42783          	lw	a5,-20(s0)
80000ebc:	0087a783          	lw	a5,8(a5)
80000ec0:	fec42703          	lw	a4,-20(s0)
80000ec4:	08c72703          	lw	a4,140(a4)
80000ec8:	00e7a423          	sw	a4,8(a5)

    // printf("%p\n",p->kernelstack);
    userret((addr_t *)TRAPFRAME, satp);
80000ecc:	fe842583          	lw	a1,-24(s0)
80000ed0:	ffffe537          	lui	a0,0xffffe
80000ed4:	c5cff0ef          	jal	ra,80000330 <userret>
}
80000ed8:	00000013          	nop
80000edc:	01c12083          	lw	ra,28(sp)
80000ee0:	01812403          	lw	s0,24(sp)
80000ee4:	01412483          	lw	s1,20(sp)
80000ee8:	02010113          	addi	sp,sp,32
80000eec:	00008067          	ret

80000ef0 <startproc>:

static int first = 0;
void startproc()
{
80000ef0:	ff010113          	addi	sp,sp,-16
80000ef4:	00112623          	sw	ra,12(sp)
80000ef8:	00812423          	sw	s0,8(sp)
80000efc:	01010413          	addi	s0,sp,16
    first = 1;
80000f00:	8000e7b7          	lui	a5,0x8000e
80000f04:	00100713          	li	a4,1
80000f08:	00e7a223          	sw	a4,4(a5) # 8000e004 <memend+0xf800e004>
    usertrapret();
80000f0c:	f25ff0ef          	jal	ra,80000e30 <usertrapret>
}
80000f10:	00000013          	nop
80000f14:	00c12083          	lw	ra,12(sp)
80000f18:	00812403          	lw	s0,8(sp)
80000f1c:	01010113          	addi	sp,sp,16
80000f20:	00008067          	ret

80000f24 <timerintr>:

void timerintr()
{
80000f24:	fe010113          	addi	sp,sp,-32
80000f28:	00112e23          	sw	ra,28(sp)
80000f2c:	00812c23          	sw	s0,24(sp)
80000f30:	02010413          	addi	s0,sp,32
    w_sip(r_sip() & ~2); // 清除中断
80000f34:	c01ff0ef          	jal	ra,80000b34 <r_sip>
80000f38:	00050793          	mv	a5,a0
80000f3c:	ffd7f793          	andi	a5,a5,-3
80000f40:	00078513          	mv	a0,a5
80000f44:	c19ff0ef          	jal	ra,80000b5c <w_sip>
    struct pcb *p = nowproc();
80000f48:	1a8010ef          	jal	ra,800020f0 <nowproc>
80000f4c:	fea42623          	sw	a0,-20(s0)
    if (p != 0 && p->status == RUNNING)
80000f50:	fec42783          	lw	a5,-20(s0)
80000f54:	00078c63          	beqz	a5,80000f6c <timerintr+0x48>
80000f58:	fec42783          	lw	a5,-20(s0)
80000f5c:	0047a703          	lw	a4,4(a5)
80000f60:	00300793          	li	a5,3
80000f64:	00f71463          	bne	a4,a5,80000f6c <timerintr+0x48>
        yield();
80000f68:	568010ef          	jal	ra,800024d0 <yield>
}
80000f6c:	00000013          	nop
80000f70:	01c12083          	lw	ra,28(sp)
80000f74:	01812403          	lw	s0,24(sp)
80000f78:	02010113          	addi	sp,sp,32
80000f7c:	00008067          	ret

80000f80 <trapvec>:

void trapvec()
{
80000f80:	fe010113          	addi	sp,sp,-32
80000f84:	00112e23          	sw	ra,28(sp)
80000f88:	00812c23          	sw	s0,24(sp)
80000f8c:	02010413          	addi	s0,sp,32
    int where = r_sstatus() & S_SPP_SET;
80000f90:	a11ff0ef          	jal	ra,800009a0 <r_sstatus>
80000f94:	00050793          	mv	a5,a0
80000f98:	1007f793          	andi	a5,a5,256
80000f9c:	fef42623          	sw	a5,-20(s0)
    w_stvec((reg_t)kvec);
80000fa0:	800007b7          	lui	a5,0x80000
80000fa4:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000fa8:	00078513          	mv	a0,a5
80000fac:	ae9ff0ef          	jal	ra,80000a94 <w_stvec>

    uint32 scause = r_scause();
80000fb0:	b35ff0ef          	jal	ra,80000ae4 <r_scause>
80000fb4:	fea42423          	sw	a0,-24(s0)

    uint16 code = scause & 0xffff;
80000fb8:	fe842783          	lw	a5,-24(s0)
80000fbc:	fef41323          	sh	a5,-26(s0)

    if (scause & (1 << 31))
80000fc0:	fe842783          	lw	a5,-24(s0)
80000fc4:	0607dc63          	bgez	a5,8000103c <trapvec+0xbc>
    {
        //     printf("Interrupt : ");
        switch (code)
80000fc8:	fe645783          	lhu	a5,-26(s0)
80000fcc:	00900713          	li	a4,9
80000fd0:	02e78c63          	beq	a5,a4,80001008 <trapvec+0x88>
80000fd4:	00900713          	li	a4,9
80000fd8:	04f74263          	blt	a4,a5,8000101c <trapvec+0x9c>
80000fdc:	00100713          	li	a4,1
80000fe0:	00e78863          	beq	a5,a4,80000ff0 <trapvec+0x70>
80000fe4:	00500713          	li	a4,5
80000fe8:	00e78863          	beq	a5,a4,80000ff8 <trapvec+0x78>
80000fec:	0300006f          	j	8000101c <trapvec+0x9c>
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
80000ff0:	f35ff0ef          	jal	ra,80000f24 <timerintr>
            break;
80000ff4:	0380006f          	j	8000102c <trapvec+0xac>
        case 5:
            printf("Supervisor timer interrupt\n");
80000ff8:	8000d7b7          	lui	a5,0x8000d
80000ffc:	18c78513          	addi	a0,a5,396 # 8000d18c <memend+0xf800d18c>
80001000:	23c000ef          	jal	ra,8000123c <printf>
            break;
80001004:	0280006f          	j	8000102c <trapvec+0xac>
        case 9:
            printf("Supervisor external interrupt\n");
80001008:	8000d7b7          	lui	a5,0x8000d
8000100c:	1a878513          	addi	a0,a5,424 # 8000d1a8 <memend+0xf800d1a8>
80001010:	22c000ef          	jal	ra,8000123c <printf>
            externinterrupt();
80001014:	b71ff0ef          	jal	ra,80000b84 <externinterrupt>
            break;
80001018:	0140006f          	j	8000102c <trapvec+0xac>
        default:
            printf("Other interrupt\n");
8000101c:	8000d7b7          	lui	a5,0x8000d
80001020:	1c878513          	addi	a0,a5,456 # 8000d1c8 <memend+0xf800d1c8>
80001024:	218000ef          	jal	ra,8000123c <printf>
            break;
80001028:	00000013          	nop
        }
        where ?: usertrapret();
8000102c:	fec42783          	lw	a5,-20(s0)
80001030:	1c079063          	bnez	a5,800011f0 <trapvec+0x270>
80001034:	dfdff0ef          	jal	ra,80000e30 <usertrapret>
            printf("Other\n");
            break;
        }
        panic("Trap Exception");
    }
}
80001038:	1b80006f          	j	800011f0 <trapvec+0x270>
        printf("Exception : ");
8000103c:	8000d7b7          	lui	a5,0x8000d
80001040:	1dc78513          	addi	a0,a5,476 # 8000d1dc <memend+0xf800d1dc>
80001044:	1f8000ef          	jal	ra,8000123c <printf>
        switch (code)
80001048:	fe645783          	lhu	a5,-26(s0)
8000104c:	00f00713          	li	a4,15
80001050:	18f76263          	bltu	a4,a5,800011d4 <trapvec+0x254>
80001054:	00279713          	slli	a4,a5,0x2
80001058:	8000d7b7          	lui	a5,0x8000d
8000105c:	36078793          	addi	a5,a5,864 # 8000d360 <memend+0xf800d360>
80001060:	00f707b3          	add	a5,a4,a5
80001064:	0007a783          	lw	a5,0(a5)
80001068:	00078067          	jr	a5
            printf("Instruction address misaligned\n");
8000106c:	8000d7b7          	lui	a5,0x8000d
80001070:	1ec78513          	addi	a0,a5,492 # 8000d1ec <memend+0xf800d1ec>
80001074:	1c8000ef          	jal	ra,8000123c <printf>
            break;
80001078:	16c0006f          	j	800011e4 <trapvec+0x264>
            printf("Instruction access fault\n");
8000107c:	8000d7b7          	lui	a5,0x8000d
80001080:	20c78513          	addi	a0,a5,524 # 8000d20c <memend+0xf800d20c>
80001084:	1b8000ef          	jal	ra,8000123c <printf>
            break;
80001088:	15c0006f          	j	800011e4 <trapvec+0x264>
            printf("Illegal instruction\n");
8000108c:	8000d7b7          	lui	a5,0x8000d
80001090:	22878513          	addi	a0,a5,552 # 8000d228 <memend+0xf800d228>
80001094:	1a8000ef          	jal	ra,8000123c <printf>
            break;
80001098:	14c0006f          	j	800011e4 <trapvec+0x264>
            printf("Breakpoint\n");
8000109c:	8000d7b7          	lui	a5,0x8000d
800010a0:	24078513          	addi	a0,a5,576 # 8000d240 <memend+0xf800d240>
800010a4:	198000ef          	jal	ra,8000123c <printf>
            break;
800010a8:	13c0006f          	j	800011e4 <trapvec+0x264>
            printf("Load address misaligned\n");
800010ac:	8000d7b7          	lui	a5,0x8000d
800010b0:	24c78513          	addi	a0,a5,588 # 8000d24c <memend+0xf800d24c>
800010b4:	188000ef          	jal	ra,8000123c <printf>
            break;
800010b8:	12c0006f          	j	800011e4 <trapvec+0x264>
            printf("Load access fault\n");
800010bc:	8000d7b7          	lui	a5,0x8000d
800010c0:	26878513          	addi	a0,a5,616 # 8000d268 <memend+0xf800d268>
800010c4:	178000ef          	jal	ra,8000123c <printf>
            printf("stval va: %p\n", r_stval());
800010c8:	a45ff0ef          	jal	ra,80000b0c <r_stval>
800010cc:	00050793          	mv	a5,a0
800010d0:	00078593          	mv	a1,a5
800010d4:	8000d7b7          	lui	a5,0x8000d
800010d8:	27c78513          	addi	a0,a5,636 # 8000d27c <memend+0xf800d27c>
800010dc:	160000ef          	jal	ra,8000123c <printf>
            break;
800010e0:	1040006f          	j	800011e4 <trapvec+0x264>
            printf("Store/AMO address misaligned\n");
800010e4:	8000d7b7          	lui	a5,0x8000d
800010e8:	28c78513          	addi	a0,a5,652 # 8000d28c <memend+0xf800d28c>
800010ec:	150000ef          	jal	ra,8000123c <printf>
            break;
800010f0:	0f40006f          	j	800011e4 <trapvec+0x264>
            printf("Store/AMO access fault\n");
800010f4:	8000d7b7          	lui	a5,0x8000d
800010f8:	2ac78513          	addi	a0,a5,684 # 8000d2ac <memend+0xf800d2ac>
800010fc:	140000ef          	jal	ra,8000123c <printf>
            printf("stval va: %p\n", r_stval());
80001100:	a0dff0ef          	jal	ra,80000b0c <r_stval>
80001104:	00050793          	mv	a5,a0
80001108:	00078593          	mv	a1,a5
8000110c:	8000d7b7          	lui	a5,0x8000d
80001110:	27c78513          	addi	a0,a5,636 # 8000d27c <memend+0xf800d27c>
80001114:	128000ef          	jal	ra,8000123c <printf>
            break;
80001118:	0cc0006f          	j	800011e4 <trapvec+0x264>
            printf("Environment call from U-mode\n");
8000111c:	8000d7b7          	lui	a5,0x8000d
80001120:	2c478513          	addi	a0,a5,708 # 8000d2c4 <memend+0xf800d2c4>
80001124:	118000ef          	jal	ra,8000123c <printf>
            syscall();
80001128:	371010ef          	jal	ra,80002c98 <syscall>
            usertrapret();
8000112c:	d05ff0ef          	jal	ra,80000e30 <usertrapret>
            break;
80001130:	0b40006f          	j	800011e4 <trapvec+0x264>
            printf("Environment call from S-mode\n");
80001134:	8000d7b7          	lui	a5,0x8000d
80001138:	2e478513          	addi	a0,a5,740 # 8000d2e4 <memend+0xf800d2e4>
8000113c:	100000ef          	jal	ra,8000123c <printf>
            first ? usertrapret() : startproc();
80001140:	8000e7b7          	lui	a5,0x8000e
80001144:	0047a783          	lw	a5,4(a5) # 8000e004 <memend+0xf800e004>
80001148:	00078663          	beqz	a5,80001154 <trapvec+0x1d4>
8000114c:	ce5ff0ef          	jal	ra,80000e30 <usertrapret>
            break;
80001150:	0940006f          	j	800011e4 <trapvec+0x264>
            first ? usertrapret() : startproc();
80001154:	d9dff0ef          	jal	ra,80000ef0 <startproc>
            break;
80001158:	08c0006f          	j	800011e4 <trapvec+0x264>
            printf("Instruction page fault\n");
8000115c:	8000d7b7          	lui	a5,0x8000d
80001160:	30478513          	addi	a0,a5,772 # 8000d304 <memend+0xf800d304>
80001164:	0d8000ef          	jal	ra,8000123c <printf>
            printf("stval va: %p\n", r_stval());
80001168:	9a5ff0ef          	jal	ra,80000b0c <r_stval>
8000116c:	00050793          	mv	a5,a0
80001170:	00078593          	mv	a1,a5
80001174:	8000d7b7          	lui	a5,0x8000d
80001178:	27c78513          	addi	a0,a5,636 # 8000d27c <memend+0xf800d27c>
8000117c:	0c0000ef          	jal	ra,8000123c <printf>
            break;
80001180:	0640006f          	j	800011e4 <trapvec+0x264>
            printf("Load page fault\n");
80001184:	8000d7b7          	lui	a5,0x8000d
80001188:	31c78513          	addi	a0,a5,796 # 8000d31c <memend+0xf800d31c>
8000118c:	0b0000ef          	jal	ra,8000123c <printf>
            printf("stval va: %p\n", r_stval());
80001190:	97dff0ef          	jal	ra,80000b0c <r_stval>
80001194:	00050793          	mv	a5,a0
80001198:	00078593          	mv	a1,a5
8000119c:	8000d7b7          	lui	a5,0x8000d
800011a0:	27c78513          	addi	a0,a5,636 # 8000d27c <memend+0xf800d27c>
800011a4:	098000ef          	jal	ra,8000123c <printf>
            break;
800011a8:	03c0006f          	j	800011e4 <trapvec+0x264>
            printf("Store/AMO page fault\n");
800011ac:	8000d7b7          	lui	a5,0x8000d
800011b0:	33078513          	addi	a0,a5,816 # 8000d330 <memend+0xf800d330>
800011b4:	088000ef          	jal	ra,8000123c <printf>
            printf("stval va: %p\n", r_stval());
800011b8:	955ff0ef          	jal	ra,80000b0c <r_stval>
800011bc:	00050793          	mv	a5,a0
800011c0:	00078593          	mv	a1,a5
800011c4:	8000d7b7          	lui	a5,0x8000d
800011c8:	27c78513          	addi	a0,a5,636 # 8000d27c <memend+0xf800d27c>
800011cc:	070000ef          	jal	ra,8000123c <printf>
            break;
800011d0:	0140006f          	j	800011e4 <trapvec+0x264>
            printf("Other\n");
800011d4:	8000d7b7          	lui	a5,0x8000d
800011d8:	34878513          	addi	a0,a5,840 # 8000d348 <memend+0xf800d348>
800011dc:	060000ef          	jal	ra,8000123c <printf>
            break;
800011e0:	00000013          	nop
        panic("Trap Exception");
800011e4:	8000d7b7          	lui	a5,0x8000d
800011e8:	35078513          	addi	a0,a5,848 # 8000d350 <memend+0xf800d350>
800011ec:	018000ef          	jal	ra,80001204 <panic>
}
800011f0:	00000013          	nop
800011f4:	01c12083          	lw	ra,28(sp)
800011f8:	01812403          	lw	s0,24(sp)
800011fc:	02010113          	addi	sp,sp,32
80001200:	00008067          	ret

80001204 <panic>:
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char *s)
{
80001204:	fe010113          	addi	sp,sp,-32
80001208:	00112e23          	sw	ra,28(sp)
8000120c:	00812c23          	sw	s0,24(sp)
80001210:	02010413          	addi	s0,sp,32
80001214:	fea42623          	sw	a0,-20(s0)
	uartputs("panic: ");
80001218:	8000d7b7          	lui	a5,0x8000d
8000121c:	3a078513          	addi	a0,a5,928 # 8000d3a0 <memend+0xf800d3a0>
80001220:	e20ff0ef          	jal	ra,80000840 <uartputs>
	uartputs(s);
80001224:	fec42503          	lw	a0,-20(s0)
80001228:	e18ff0ef          	jal	ra,80000840 <uartputs>
	uartputs("\n");
8000122c:	8000d7b7          	lui	a5,0x8000d
80001230:	3a878513          	addi	a0,a5,936 # 8000d3a8 <memend+0xf800d3a8>
80001234:	e0cff0ef          	jal	ra,80000840 <uartputs>
	while (1)
80001238:	0000006f          	j	80001238 <panic+0x34>

8000123c <printf>:

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char *fmt, ...)
{
8000123c:	f8010113          	addi	sp,sp,-128
80001240:	04112e23          	sw	ra,92(sp)
80001244:	04812c23          	sw	s0,88(sp)
80001248:	06010413          	addi	s0,sp,96
8000124c:	faa42623          	sw	a0,-84(s0)
80001250:	00b42223          	sw	a1,4(s0)
80001254:	00c42423          	sw	a2,8(s0)
80001258:	00d42623          	sw	a3,12(s0)
8000125c:	00e42823          	sw	a4,16(s0)
80001260:	00f42a23          	sw	a5,20(s0)
80001264:	01042c23          	sw	a6,24(s0)
80001268:	01142e23          	sw	a7,28(s0)
	va_list vl;		   // 保存参数的地址，定义在stdarg.h
	va_start(vl, fmt); // 将vl指向fmt后面的参数
8000126c:	02040793          	addi	a5,s0,32
80001270:	faf42423          	sw	a5,-88(s0)
80001274:	fa842783          	lw	a5,-88(s0)
80001278:	fe478793          	addi	a5,a5,-28
8000127c:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char *s = fmt;
80001280:	fac42783          	lw	a5,-84(s0)
80001284:	fef42623          	sw	a5,-20(s0)
	int tt = 0;
80001288:	fe042423          	sw	zero,-24(s0)
	int idx = 0;
8000128c:	fe042223          	sw	zero,-28(s0)
	while ((ch = *(s)))
80001290:	36c0006f          	j	800015fc <printf+0x3c0>
	{
		if (ch == '%')
80001294:	fbf44703          	lbu	a4,-65(s0)
80001298:	02500793          	li	a5,37
8000129c:	04f71863          	bne	a4,a5,800012ec <printf+0xb0>
		{
			if (tt == 1)
800012a0:	fe842703          	lw	a4,-24(s0)
800012a4:	00100793          	li	a5,1
800012a8:	02f71663          	bne	a4,a5,800012d4 <printf+0x98>
			{
				outbuf[idx++] = '%';
800012ac:	fe442783          	lw	a5,-28(s0)
800012b0:	00178713          	addi	a4,a5,1
800012b4:	fee42223          	sw	a4,-28(s0)
800012b8:	8000e737          	lui	a4,0x8000e
800012bc:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
800012c0:	00f707b3          	add	a5,a4,a5
800012c4:	02500713          	li	a4,37
800012c8:	00e78023          	sb	a4,0(a5)
				tt = 0;
800012cc:	fe042423          	sw	zero,-24(s0)
800012d0:	00c0006f          	j	800012dc <printf+0xa0>
			}
			else
			{
				tt = 1;
800012d4:	00100793          	li	a5,1
800012d8:	fef42423          	sw	a5,-24(s0)
			}
			s++;
800012dc:	fec42783          	lw	a5,-20(s0)
800012e0:	00178793          	addi	a5,a5,1
800012e4:	fef42623          	sw	a5,-20(s0)
800012e8:	3140006f          	j	800015fc <printf+0x3c0>
		}
		else
		{
			if (tt == 1)
800012ec:	fe842703          	lw	a4,-24(s0)
800012f0:	00100793          	li	a5,1
800012f4:	2cf71e63          	bne	a4,a5,800015d0 <printf+0x394>
			{
				switch (ch)
800012f8:	fbf44783          	lbu	a5,-65(s0)
800012fc:	fa878793          	addi	a5,a5,-88
80001300:	02000713          	li	a4,32
80001304:	2af76663          	bltu	a4,a5,800015b0 <printf+0x374>
80001308:	00279713          	slli	a4,a5,0x2
8000130c:	8000d7b7          	lui	a5,0x8000d
80001310:	3c478793          	addi	a5,a5,964 # 8000d3c4 <memend+0xf800d3c4>
80001314:	00f707b3          	add	a5,a4,a5
80001318:	0007a783          	lw	a5,0(a5)
8000131c:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x = va_arg(vl, int);
80001320:	fb842783          	lw	a5,-72(s0)
80001324:	00478713          	addi	a4,a5,4
80001328:	fae42c23          	sw	a4,-72(s0)
8000132c:	0007a783          	lw	a5,0(a5)
80001330:	fef42023          	sw	a5,-32(s0)
					int len = 0;
80001334:	fc042e23          	sw	zero,-36(s0)
					for (int n = x; n /= 10; len++)
80001338:	fe042783          	lw	a5,-32(s0)
8000133c:	fcf42c23          	sw	a5,-40(s0)
80001340:	0100006f          	j	80001350 <printf+0x114>
80001344:	fdc42783          	lw	a5,-36(s0)
80001348:	00178793          	addi	a5,a5,1
8000134c:	fcf42e23          	sw	a5,-36(s0)
80001350:	fd842703          	lw	a4,-40(s0)
80001354:	00a00793          	li	a5,10
80001358:	02f747b3          	div	a5,a4,a5
8000135c:	fcf42c23          	sw	a5,-40(s0)
80001360:	fd842783          	lw	a5,-40(s0)
80001364:	fe0790e3          	bnez	a5,80001344 <printf+0x108>
						;
					for (int i = len; i >= 0; i--)
80001368:	fdc42783          	lw	a5,-36(s0)
8000136c:	fcf42a23          	sw	a5,-44(s0)
80001370:	0540006f          	j	800013c4 <printf+0x188>
					{
						outbuf[idx + i] = '0' + (x % 10);
80001374:	fe042703          	lw	a4,-32(s0)
80001378:	00a00793          	li	a5,10
8000137c:	02f767b3          	rem	a5,a4,a5
80001380:	0ff7f713          	andi	a4,a5,255
80001384:	fe442683          	lw	a3,-28(s0)
80001388:	fd442783          	lw	a5,-44(s0)
8000138c:	00f687b3          	add	a5,a3,a5
80001390:	03070713          	addi	a4,a4,48
80001394:	0ff77713          	andi	a4,a4,255
80001398:	8000e6b7          	lui	a3,0x8000e
8000139c:	00868693          	addi	a3,a3,8 # 8000e008 <memend+0xf800e008>
800013a0:	00f687b3          	add	a5,a3,a5
800013a4:	00e78023          	sb	a4,0(a5)
						x /= 10;
800013a8:	fe042703          	lw	a4,-32(s0)
800013ac:	00a00793          	li	a5,10
800013b0:	02f747b3          	div	a5,a4,a5
800013b4:	fef42023          	sw	a5,-32(s0)
					for (int i = len; i >= 0; i--)
800013b8:	fd442783          	lw	a5,-44(s0)
800013bc:	fff78793          	addi	a5,a5,-1
800013c0:	fcf42a23          	sw	a5,-44(s0)
800013c4:	fd442783          	lw	a5,-44(s0)
800013c8:	fa07d6e3          	bgez	a5,80001374 <printf+0x138>
					}
					idx += (len + 1);
800013cc:	fdc42783          	lw	a5,-36(s0)
800013d0:	00178793          	addi	a5,a5,1
800013d4:	fe442703          	lw	a4,-28(s0)
800013d8:	00f707b3          	add	a5,a4,a5
800013dc:	fef42223          	sw	a5,-28(s0)
					tt = 0;
800013e0:	fe042423          	sw	zero,-24(s0)
					break;
800013e4:	1dc0006f          	j	800015c0 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++] = '0';
800013e8:	fe442783          	lw	a5,-28(s0)
800013ec:	00178713          	addi	a4,a5,1
800013f0:	fee42223          	sw	a4,-28(s0)
800013f4:	8000e737          	lui	a4,0x8000e
800013f8:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
800013fc:	00f707b3          	add	a5,a4,a5
80001400:	03000713          	li	a4,48
80001404:	00e78023          	sb	a4,0(a5)
					outbuf[idx++] = 'x';
80001408:	fe442783          	lw	a5,-28(s0)
8000140c:	00178713          	addi	a4,a5,1
80001410:	fee42223          	sw	a4,-28(s0)
80001414:	8000e737          	lui	a4,0x8000e
80001418:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
8000141c:	00f707b3          	add	a5,a4,a5
80001420:	07800713          	li	a4,120
80001424:	00e78023          	sb	a4,0(a5)
				} // 接着下面输出16进制数
				case 'x':
				case 'X': // 大小写一致
				{
					uint x = va_arg(vl, uint);
80001428:	fb842783          	lw	a5,-72(s0)
8000142c:	00478713          	addi	a4,a5,4
80001430:	fae42c23          	sw	a4,-72(s0)
80001434:	0007a783          	lw	a5,0(a5)
80001438:	fcf42823          	sw	a5,-48(s0)
					int len = 0;
8000143c:	fc042623          	sw	zero,-52(s0)
					for (unsigned int n = x; n /= 16; len++)
80001440:	fd042783          	lw	a5,-48(s0)
80001444:	fcf42423          	sw	a5,-56(s0)
80001448:	0100006f          	j	80001458 <printf+0x21c>
8000144c:	fcc42783          	lw	a5,-52(s0)
80001450:	00178793          	addi	a5,a5,1
80001454:	fcf42623          	sw	a5,-52(s0)
80001458:	fc842783          	lw	a5,-56(s0)
8000145c:	0047d793          	srli	a5,a5,0x4
80001460:	fcf42423          	sw	a5,-56(s0)
80001464:	fc842783          	lw	a5,-56(s0)
80001468:	fe0792e3          	bnez	a5,8000144c <printf+0x210>
						;
					for (int i = len; i >= 0; i--)
8000146c:	fcc42783          	lw	a5,-52(s0)
80001470:	fcf42223          	sw	a5,-60(s0)
80001474:	0840006f          	j	800014f8 <printf+0x2bc>
					{
						char c = (x % 16) >= 10 ? 'a' + ((x % 16) - 10) : '0' + (x % 16);
80001478:	fd042783          	lw	a5,-48(s0)
8000147c:	00f7f713          	andi	a4,a5,15
80001480:	00900793          	li	a5,9
80001484:	02e7f063          	bgeu	a5,a4,800014a4 <printf+0x268>
80001488:	fd042783          	lw	a5,-48(s0)
8000148c:	0ff7f793          	andi	a5,a5,255
80001490:	00f7f793          	andi	a5,a5,15
80001494:	0ff7f793          	andi	a5,a5,255
80001498:	05778793          	addi	a5,a5,87
8000149c:	0ff7f793          	andi	a5,a5,255
800014a0:	01c0006f          	j	800014bc <printf+0x280>
800014a4:	fd042783          	lw	a5,-48(s0)
800014a8:	0ff7f793          	andi	a5,a5,255
800014ac:	00f7f793          	andi	a5,a5,15
800014b0:	0ff7f793          	andi	a5,a5,255
800014b4:	03078793          	addi	a5,a5,48
800014b8:	0ff7f793          	andi	a5,a5,255
800014bc:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx + i] = c;
800014c0:	fe442703          	lw	a4,-28(s0)
800014c4:	fc442783          	lw	a5,-60(s0)
800014c8:	00f707b3          	add	a5,a4,a5
800014cc:	8000e737          	lui	a4,0x8000e
800014d0:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
800014d4:	00f707b3          	add	a5,a4,a5
800014d8:	fbe44703          	lbu	a4,-66(s0)
800014dc:	00e78023          	sb	a4,0(a5)
						x /= 16;
800014e0:	fd042783          	lw	a5,-48(s0)
800014e4:	0047d793          	srli	a5,a5,0x4
800014e8:	fcf42823          	sw	a5,-48(s0)
					for (int i = len; i >= 0; i--)
800014ec:	fc442783          	lw	a5,-60(s0)
800014f0:	fff78793          	addi	a5,a5,-1
800014f4:	fcf42223          	sw	a5,-60(s0)
800014f8:	fc442783          	lw	a5,-60(s0)
800014fc:	f607dee3          	bgez	a5,80001478 <printf+0x23c>
					}
					idx += (len + 1);
80001500:	fcc42783          	lw	a5,-52(s0)
80001504:	00178793          	addi	a5,a5,1
80001508:	fe442703          	lw	a4,-28(s0)
8000150c:	00f707b3          	add	a5,a4,a5
80001510:	fef42223          	sw	a5,-28(s0)
					tt = 0;
80001514:	fe042423          	sw	zero,-24(s0)
					break;
80001518:	0a80006f          	j	800015c0 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch = va_arg(vl, int);
8000151c:	fb842783          	lw	a5,-72(s0)
80001520:	00478713          	addi	a4,a5,4
80001524:	fae42c23          	sw	a4,-72(s0)
80001528:	0007a783          	lw	a5,0(a5)
8000152c:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++] = ch;
80001530:	fe442783          	lw	a5,-28(s0)
80001534:	00178713          	addi	a4,a5,1
80001538:	fee42223          	sw	a4,-28(s0)
8000153c:	8000e737          	lui	a4,0x8000e
80001540:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
80001544:	00f707b3          	add	a5,a4,a5
80001548:	fbf44703          	lbu	a4,-65(s0)
8000154c:	00e78023          	sb	a4,0(a5)
					tt = 0;
80001550:	fe042423          	sw	zero,-24(s0)
					break;
80001554:	06c0006f          	j	800015c0 <printf+0x384>
				case 's':
				{
					char *ss = va_arg(vl, char *);
80001558:	fb842783          	lw	a5,-72(s0)
8000155c:	00478713          	addi	a4,a5,4
80001560:	fae42c23          	sw	a4,-72(s0)
80001564:	0007a783          	lw	a5,0(a5)
80001568:	fcf42023          	sw	a5,-64(s0)
					while (*ss)
8000156c:	0300006f          	j	8000159c <printf+0x360>
					{
						outbuf[idx++] = *ss++;
80001570:	fc042703          	lw	a4,-64(s0)
80001574:	00170793          	addi	a5,a4,1
80001578:	fcf42023          	sw	a5,-64(s0)
8000157c:	fe442783          	lw	a5,-28(s0)
80001580:	00178693          	addi	a3,a5,1
80001584:	fed42223          	sw	a3,-28(s0)
80001588:	00074703          	lbu	a4,0(a4)
8000158c:	8000e6b7          	lui	a3,0x8000e
80001590:	00868693          	addi	a3,a3,8 # 8000e008 <memend+0xf800e008>
80001594:	00f687b3          	add	a5,a3,a5
80001598:	00e78023          	sb	a4,0(a5)
					while (*ss)
8000159c:	fc042783          	lw	a5,-64(s0)
800015a0:	0007c783          	lbu	a5,0(a5)
800015a4:	fc0796e3          	bnez	a5,80001570 <printf+0x334>
					}
					tt = 0;
800015a8:	fe042423          	sw	zero,-24(s0)
					break;
800015ac:	0140006f          	j	800015c0 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
800015b0:	8000d7b7          	lui	a5,0x8000d
800015b4:	3ac78513          	addi	a0,a5,940 # 8000d3ac <memend+0xf800d3ac>
800015b8:	c4dff0ef          	jal	ra,80001204 <panic>
					break;
800015bc:	00000013          	nop
				}
				s++;
800015c0:	fec42783          	lw	a5,-20(s0)
800015c4:	00178793          	addi	a5,a5,1
800015c8:	fef42623          	sw	a5,-20(s0)
800015cc:	0300006f          	j	800015fc <printf+0x3c0>
			}
			else
			{
				outbuf[idx++] = ch;
800015d0:	fe442783          	lw	a5,-28(s0)
800015d4:	00178713          	addi	a4,a5,1
800015d8:	fee42223          	sw	a4,-28(s0)
800015dc:	8000e737          	lui	a4,0x8000e
800015e0:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
800015e4:	00f707b3          	add	a5,a4,a5
800015e8:	fbf44703          	lbu	a4,-65(s0)
800015ec:	00e78023          	sb	a4,0(a5)
				s++;
800015f0:	fec42783          	lw	a5,-20(s0)
800015f4:	00178793          	addi	a5,a5,1
800015f8:	fef42623          	sw	a5,-20(s0)
	while ((ch = *(s)))
800015fc:	fec42783          	lw	a5,-20(s0)
80001600:	0007c783          	lbu	a5,0(a5)
80001604:	faf40fa3          	sb	a5,-65(s0)
80001608:	fbf44783          	lbu	a5,-65(s0)
8000160c:	c80794e3          	bnez	a5,80001294 <printf+0x58>
			}
		}
	}
	va_end(vl); // 释法参数
	outbuf[idx] = '\0';
80001610:	8000e7b7          	lui	a5,0x8000e
80001614:	00878713          	addi	a4,a5,8 # 8000e008 <memend+0xf800e008>
80001618:	fe442783          	lw	a5,-28(s0)
8000161c:	00f707b3          	add	a5,a4,a5
80001620:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
80001624:	8000e7b7          	lui	a5,0x8000e
80001628:	00878513          	addi	a0,a5,8 # 8000e008 <memend+0xf800e008>
8000162c:	a14ff0ef          	jal	ra,80000840 <uartputs>
	return idx;
80001630:	fe442783          	lw	a5,-28(s0)
80001634:	00078513          	mv	a0,a5
80001638:	05c12083          	lw	ra,92(sp)
8000163c:	05812403          	lw	s0,88(sp)
80001640:	08010113          	addi	sp,sp,128
80001644:	00008067          	ret

80001648 <minit>:
{
    struct pmp *freelist;
} mem;

void minit()
{
80001648:	fe010113          	addi	sp,sp,-32
8000164c:	00112e23          	sw	ra,28(sp)
80001650:	00812c23          	sw	s0,24(sp)
80001654:	02010413          	addi	s0,sp,32
#ifdef DEBUG
    printf("textstart:%p    ", textstart);
80001658:	800007b7          	lui	a5,0x80000
8000165c:	00078593          	mv	a1,a5
80001660:	8000d7b7          	lui	a5,0x8000d
80001664:	44878513          	addi	a0,a5,1096 # 8000d448 <memend+0xf800d448>
80001668:	bd5ff0ef          	jal	ra,8000123c <printf>
    printf("textend:%p\n", textend);
8000166c:	800037b7          	lui	a5,0x80003
80001670:	6c878593          	addi	a1,a5,1736 # 800036c8 <memend+0xf80036c8>
80001674:	8000d7b7          	lui	a5,0x8000d
80001678:	45c78513          	addi	a0,a5,1116 # 8000d45c <memend+0xf800d45c>
8000167c:	bc1ff0ef          	jal	ra,8000123c <printf>
    printf("datastart:%p    ", datastart);
80001680:	800047b7          	lui	a5,0x80004
80001684:	00078593          	mv	a1,a5
80001688:	8000d7b7          	lui	a5,0x8000d
8000168c:	46878513          	addi	a0,a5,1128 # 8000d468 <memend+0xf800d468>
80001690:	badff0ef          	jal	ra,8000123c <printf>
    printf("dataend:%p\n", dataend);
80001694:	8000c7b7          	lui	a5,0x8000c
80001698:	02478593          	addi	a1,a5,36 # 8000c024 <memend+0xf800c024>
8000169c:	8000d7b7          	lui	a5,0x8000d
800016a0:	47c78513          	addi	a0,a5,1148 # 8000d47c <memend+0xf800d47c>
800016a4:	b99ff0ef          	jal	ra,8000123c <printf>
    printf("rodatastart:%p  ", rodatastart);
800016a8:	8000d7b7          	lui	a5,0x8000d
800016ac:	00078593          	mv	a1,a5
800016b0:	8000d7b7          	lui	a5,0x8000d
800016b4:	48878513          	addi	a0,a5,1160 # 8000d488 <memend+0xf800d488>
800016b8:	b85ff0ef          	jal	ra,8000123c <printf>
    printf("rodataend:%p\n", rodataend);
800016bc:	8000d7b7          	lui	a5,0x8000d
800016c0:	62878593          	addi	a1,a5,1576 # 8000d628 <memend+0xf800d628>
800016c4:	8000d7b7          	lui	a5,0x8000d
800016c8:	49c78513          	addi	a0,a5,1180 # 8000d49c <memend+0xf800d49c>
800016cc:	b71ff0ef          	jal	ra,8000123c <printf>
    printf("bssstart:%p     ", bssstart);
800016d0:	8000e7b7          	lui	a5,0x8000e
800016d4:	00078593          	mv	a1,a5
800016d8:	8000d7b7          	lui	a5,0x8000d
800016dc:	4ac78513          	addi	a0,a5,1196 # 8000d4ac <memend+0xf800d4ac>
800016e0:	b5dff0ef          	jal	ra,8000123c <printf>
    printf("bssend:%p\n", bssend);
800016e4:	800127b7          	lui	a5,0x80012
800016e8:	00078593          	mv	a1,a5
800016ec:	8000d7b7          	lui	a5,0x8000d
800016f0:	4c078513          	addi	a0,a5,1216 # 8000d4c0 <memend+0xf800d4c0>
800016f4:	b49ff0ef          	jal	ra,8000123c <printf>
    printf("mstart:%p   ", mstart);
800016f8:	800127b7          	lui	a5,0x80012
800016fc:	00078593          	mv	a1,a5
80001700:	8000d7b7          	lui	a5,0x8000d
80001704:	4cc78513          	addi	a0,a5,1228 # 8000d4cc <memend+0xf800d4cc>
80001708:	b35ff0ef          	jal	ra,8000123c <printf>
    printf("mend:%p\n", mend);
8000170c:	880007b7          	lui	a5,0x88000
80001710:	00078593          	mv	a1,a5
80001714:	8000d7b7          	lui	a5,0x8000d
80001718:	4dc78513          	addi	a0,a5,1244 # 8000d4dc <memend+0xf800d4dc>
8000171c:	b21ff0ef          	jal	ra,8000123c <printf>
    printf("stack:%p\n", stacks);
80001720:	800047b7          	lui	a5,0x80004
80001724:	00078593          	mv	a1,a5
80001728:	8000d7b7          	lui	a5,0x8000d
8000172c:	4e878513          	addi	a0,a5,1256 # 8000d4e8 <memend+0xf800d4e8>
80001730:	b0dff0ef          	jal	ra,8000123c <printf>
#endif

    char *p = (char *)mstart;
80001734:	800127b7          	lui	a5,0x80012
80001738:	00078793          	mv	a5,a5
8000173c:	fef42623          	sw	a5,-20(s0)
    struct pmp *m;
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
80001740:	0380006f          	j	80001778 <minit+0x130>
    {
        m = (struct pmp *)p;
80001744:	fec42783          	lw	a5,-20(s0)
80001748:	fef42423          	sw	a5,-24(s0)
        m->next = mem.freelist;
8000174c:	8000f7b7          	lui	a5,0x8000f
80001750:	a487a703          	lw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
80001754:	fe842783          	lw	a5,-24(s0)
80001758:	00e7a023          	sw	a4,0(a5)
        mem.freelist = m;
8000175c:	8000f7b7          	lui	a5,0x8000f
80001760:	fe842703          	lw	a4,-24(s0)
80001764:	a4e7a423          	sw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
80001768:	fec42703          	lw	a4,-20(s0)
8000176c:	000017b7          	lui	a5,0x1
80001770:	00f707b3          	add	a5,a4,a5
80001774:	fef42623          	sw	a5,-20(s0)
80001778:	fec42703          	lw	a4,-20(s0)
8000177c:	000017b7          	lui	a5,0x1
80001780:	00f70733          	add	a4,a4,a5
80001784:	880007b7          	lui	a5,0x88000
80001788:	00078793          	mv	a5,a5
8000178c:	fae7fce3          	bgeu	a5,a4,80001744 <minit+0xfc>
    }
}
80001790:	00000013          	nop
80001794:	00000013          	nop
80001798:	01c12083          	lw	ra,28(sp)
8000179c:	01812403          	lw	s0,24(sp)
800017a0:	02010113          	addi	sp,sp,32
800017a4:	00008067          	ret

800017a8 <palloc>:

void *palloc()
{
800017a8:	fe010113          	addi	sp,sp,-32
800017ac:	00112e23          	sw	ra,28(sp)
800017b0:	00812c23          	sw	s0,24(sp)
800017b4:	02010413          	addi	s0,sp,32
    struct pmp *p = (struct pmp *)mem.freelist;
800017b8:	8000f7b7          	lui	a5,0x8000f
800017bc:	a487a783          	lw	a5,-1464(a5) # 8000ea48 <memend+0xf800ea48>
800017c0:	fef42623          	sw	a5,-20(s0)
    if (p)
800017c4:	fec42783          	lw	a5,-20(s0)
800017c8:	00078c63          	beqz	a5,800017e0 <palloc+0x38>
        mem.freelist = mem.freelist->next;
800017cc:	8000f7b7          	lui	a5,0x8000f
800017d0:	a487a783          	lw	a5,-1464(a5) # 8000ea48 <memend+0xf800ea48>
800017d4:	0007a703          	lw	a4,0(a5)
800017d8:	8000f7b7          	lui	a5,0x8000f
800017dc:	a4e7a423          	sw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
    if (p)
800017e0:	fec42783          	lw	a5,-20(s0)
800017e4:	00078a63          	beqz	a5,800017f8 <palloc+0x50>
        memset(p, 0, PGSIZE);
800017e8:	00001637          	lui	a2,0x1
800017ec:	00000593          	li	a1,0
800017f0:	fec42503          	lw	a0,-20(s0)
800017f4:	615000ef          	jal	ra,80002608 <memset>
    return (void *)p;
800017f8:	fec42783          	lw	a5,-20(s0)
}
800017fc:	00078513          	mv	a0,a5
80001800:	01c12083          	lw	ra,28(sp)
80001804:	01812403          	lw	s0,24(sp)
80001808:	02010113          	addi	sp,sp,32
8000180c:	00008067          	ret

80001810 <pfree>:

void pfree(void *addr)
{
80001810:	fd010113          	addi	sp,sp,-48
80001814:	02812623          	sw	s0,44(sp)
80001818:	03010413          	addi	s0,sp,48
8000181c:	fca42e23          	sw	a0,-36(s0)
    struct pmp *p = (struct pmp *)addr;
80001820:	fdc42783          	lw	a5,-36(s0)
80001824:	fef42623          	sw	a5,-20(s0)
    p->next = mem.freelist;
80001828:	8000f7b7          	lui	a5,0x8000f
8000182c:	a487a703          	lw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
80001830:	fec42783          	lw	a5,-20(s0)
80001834:	00e7a023          	sw	a4,0(a5)
    mem.freelist = p;
80001838:	8000f7b7          	lui	a5,0x8000f
8000183c:	fec42703          	lw	a4,-20(s0)
80001840:	a4e7a423          	sw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
80001844:	00000013          	nop
80001848:	02c12403          	lw	s0,44(sp)
8000184c:	03010113          	addi	sp,sp,48
80001850:	00008067          	ret

80001854 <r_tp>:
{
80001854:	fe010113          	addi	sp,sp,-32
80001858:	00812e23          	sw	s0,28(sp)
8000185c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80001860:	00020793          	mv	a5,tp
80001864:	fef42623          	sw	a5,-20(s0)
    return x;
80001868:	fec42783          	lw	a5,-20(s0)
}
8000186c:	00078513          	mv	a0,a5
80001870:	01c12403          	lw	s0,28(sp)
80001874:	02010113          	addi	sp,sp,32
80001878:	00008067          	ret

8000187c <r_sie>:
 */
#define SEIE (1 << 9)
#define STIE (1 << 5)
#define SSIE (1 << 1)
static inline uint32 r_sie()
{
8000187c:	fe010113          	addi	sp,sp,-32
80001880:	00812e23          	sw	s0,28(sp)
80001884:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie "
80001888:	104027f3          	csrr	a5,sie
8000188c:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80001890:	fec42783          	lw	a5,-20(s0)
}
80001894:	00078513          	mv	a0,a5
80001898:	01c12403          	lw	s0,28(sp)
8000189c:	02010113          	addi	sp,sp,32
800018a0:	00008067          	ret

800018a4 <w_sie>:
static inline void w_sie(uint32 x)
{
800018a4:	fe010113          	addi	sp,sp,-32
800018a8:	00812e23          	sw	s0,28(sp)
800018ac:	02010413          	addi	s0,sp,32
800018b0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"
800018b4:	fec42783          	lw	a5,-20(s0)
800018b8:	10479073          	csrw	sie,a5
                 :
                 : "r"(x));
}
800018bc:	00000013          	nop
800018c0:	01c12403          	lw	s0,28(sp)
800018c4:	02010113          	addi	sp,sp,32
800018c8:	00008067          	ret

800018cc <plicinit>:
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit()
{
800018cc:	ff010113          	addi	sp,sp,-16
800018d0:	00112623          	sw	ra,12(sp)
800018d4:	00812423          	sw	s0,8(sp)
800018d8:	01010413          	addi	s0,sp,16
    *(uint32 *)PLIC_PRIORITY(UART_IRQ) = 1;   // uart 设置优先级(1~7)，0为关中断
800018dc:	0c0007b7          	lui	a5,0xc000
800018e0:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
800018e4:	00100713          	li	a4,1
800018e8:	00e7a023          	sw	a4,0(a5)
    *(uint32 *)PLIC_PRIORITY(VIRTIO_IRQ) = 1; // virtio 设置优先级(1~7)，0为关中断
800018ec:	0c0007b7          	lui	a5,0xc000
800018f0:	00478793          	addi	a5,a5,4 # c000004 <sz+0xbfff004>
800018f4:	00100713          	li	a4,1
800018f8:	00e7a023          	sw	a4,0(a5)

    *(uint32 *)PLIC_SENABLE(r_tp()) = (1 << UART_IRQ) | (1 << VIRTIO_IRQ); // uart, virtio 开中断
800018fc:	f59ff0ef          	jal	ra,80001854 <r_tp>
80001900:	00050793          	mv	a5,a0
80001904:	00879713          	slli	a4,a5,0x8
80001908:	0c0027b7          	lui	a5,0xc002
8000190c:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001910:	00f707b3          	add	a5,a4,a5
80001914:	00078713          	mv	a4,a5
80001918:	40200793          	li	a5,1026
8000191c:	00f72023          	sw	a5,0(a4)
    *(uint32 *)PLIC_MENABLE(r_tp()) = (1 << UART_IRQ) | (1 << VIRTIO_IRQ); // uart, virtio d开中断
80001920:	f35ff0ef          	jal	ra,80001854 <r_tp>
80001924:	00050713          	mv	a4,a0
80001928:	000c07b7          	lui	a5,0xc0
8000192c:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
80001930:	00f707b3          	add	a5,a4,a5
80001934:	00879793          	slli	a5,a5,0x8
80001938:	00078713          	mv	a4,a5
8000193c:	40200793          	li	a5,1026
80001940:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32 *)PLIC_MPRIORITY(r_tp()) = 0;
80001944:	f11ff0ef          	jal	ra,80001854 <r_tp>
80001948:	00050713          	mv	a4,a0
8000194c:	000067b7          	lui	a5,0x6
80001950:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
80001954:	00f707b3          	add	a5,a4,a5
80001958:	00d79793          	slli	a5,a5,0xd
8000195c:	0007a023          	sw	zero,0(a5)
    *(uint32 *)PLIC_SPRIORITY(r_tp()) = 0;
80001960:	ef5ff0ef          	jal	ra,80001854 <r_tp>
80001964:	00050793          	mv	a5,a0
80001968:	00d79713          	slli	a4,a5,0xd
8000196c:	0c2017b7          	lui	a5,0xc201
80001970:	00f707b3          	add	a5,a4,a5
80001974:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开S-mode中断
80001978:	f05ff0ef          	jal	ra,8000187c <r_sie>
8000197c:	00050793          	mv	a5,a0
80001980:	2227e793          	ori	a5,a5,546
80001984:	00078513          	mv	a0,a5
80001988:	f1dff0ef          	jal	ra,800018a4 <w_sie>
}
8000198c:	00000013          	nop
80001990:	00c12083          	lw	ra,12(sp)
80001994:	00812403          	lw	s0,8(sp)
80001998:	01010113          	addi	sp,sp,16
8000199c:	00008067          	ret

800019a0 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim()
{
800019a0:	ff010113          	addi	sp,sp,-16
800019a4:	00112623          	sw	ra,12(sp)
800019a8:	00812423          	sw	s0,8(sp)
800019ac:	01010413          	addi	s0,sp,16
    return *(uint32 *)PLIC_SCLAIM(r_tp());
800019b0:	ea5ff0ef          	jal	ra,80001854 <r_tp>
800019b4:	00050793          	mv	a5,a0
800019b8:	00d79713          	slli	a4,a5,0xd
800019bc:	0c2017b7          	lui	a5,0xc201
800019c0:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
800019c4:	00f707b3          	add	a5,a4,a5
800019c8:	0007a783          	lw	a5,0(a5)
}
800019cc:	00078513          	mv	a0,a5
800019d0:	00c12083          	lw	ra,12(sp)
800019d4:	00812403          	lw	s0,8(sp)
800019d8:	01010113          	addi	sp,sp,16
800019dc:	00008067          	ret

800019e0 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq)
{
800019e0:	fe010113          	addi	sp,sp,-32
800019e4:	00112e23          	sw	ra,28(sp)
800019e8:	00812c23          	sw	s0,24(sp)
800019ec:	02010413          	addi	s0,sp,32
800019f0:	fea42623          	sw	a0,-20(s0)
    *(uint32 *)PLIC_MCOMPLETE(r_tp()) = irq;
800019f4:	e61ff0ef          	jal	ra,80001854 <r_tp>
800019f8:	00050793          	mv	a5,a0
800019fc:	00d79713          	slli	a4,a5,0xd
80001a00:	0c2007b7          	lui	a5,0xc200
80001a04:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
80001a08:	00f707b3          	add	a5,a4,a5
80001a0c:	00078713          	mv	a4,a5
80001a10:	fec42783          	lw	a5,-20(s0)
80001a14:	00f72023          	sw	a5,0(a4)
80001a18:	00000013          	nop
80001a1c:	01c12083          	lw	ra,28(sp)
80001a20:	01812403          	lw	s0,24(sp)
80001a24:	02010113          	addi	sp,sp,32
80001a28:	00008067          	ret

80001a2c <w_satp>:
{
80001a2c:	fe010113          	addi	sp,sp,-32
80001a30:	00812e23          	sw	s0,28(sp)
80001a34:	02010413          	addi	s0,sp,32
80001a38:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"
80001a3c:	fec42783          	lw	a5,-20(s0)
80001a40:	18079073          	csrw	satp,a5
}
80001a44:	00000013          	nop
80001a48:	01c12403          	lw	s0,28(sp)
80001a4c:	02010113          	addi	sp,sp,32
80001a50:	00008067          	ret

80001a54 <sfence_vma>:
{
80001a54:	ff010113          	addi	sp,sp,-16
80001a58:	00812623          	sw	s0,12(sp)
80001a5c:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
80001a60:	12000073          	sfence.vma
}
80001a64:	00000013          	nop
80001a68:	00c12403          	lw	s0,12(sp)
80001a6c:	01010113          	addi	sp,sp,16
80001a70:	00008067          	ret

80001a74 <acquriepte>:
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t *acquriepte(addr_t *pgt, addr_t va)
{
80001a74:	fd010113          	addi	sp,sp,-48
80001a78:	02112623          	sw	ra,44(sp)
80001a7c:	02812423          	sw	s0,40(sp)
80001a80:	03010413          	addi	s0,sp,48
80001a84:	fca42e23          	sw	a0,-36(s0)
80001a88:	fcb42c23          	sw	a1,-40(s0)
    pte_t *pte;
    pte = &pgt[VPN(1, va)]; // 获取一级页表 PTE
80001a8c:	fd842783          	lw	a5,-40(s0)
80001a90:	0167d793          	srli	a5,a5,0x16
80001a94:	00279793          	slli	a5,a5,0x2
80001a98:	fdc42703          	lw	a4,-36(s0)
80001a9c:	00f707b3          	add	a5,a4,a5
80001aa0:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if (*pte & PTE_V)
80001aa4:	fec42783          	lw	a5,-20(s0)
80001aa8:	0007a783          	lw	a5,0(a5)
80001aac:	0017f793          	andi	a5,a5,1
80001ab0:	00078e63          	beqz	a5,80001acc <acquriepte+0x58>
    { // 已分配页
        pgt = (addr_t *)PTE2PA(*pte);
80001ab4:	fec42783          	lw	a5,-20(s0)
80001ab8:	0007a783          	lw	a5,0(a5)
80001abc:	00a7d793          	srli	a5,a5,0xa
80001ac0:	00c79793          	slli	a5,a5,0xc
80001ac4:	fcf42e23          	sw	a5,-36(s0)
80001ac8:	0340006f          	j	80001afc <acquriepte+0x88>
    }
    else
    {                             // 未分配页
        pgt = (addr_t *)palloc(); // 二级页表
80001acc:	cddff0ef          	jal	ra,800017a8 <palloc>
80001ad0:	fca42e23          	sw	a0,-36(s0)
        memset(pgt, 0, PGSIZE);
80001ad4:	00001637          	lui	a2,0x1
80001ad8:	00000593          	li	a1,0
80001adc:	fdc42503          	lw	a0,-36(s0)
80001ae0:	329000ef          	jal	ra,80002608 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001ae4:	fdc42783          	lw	a5,-36(s0)
80001ae8:	00c7d793          	srli	a5,a5,0xc
80001aec:	00a79793          	slli	a5,a5,0xa
80001af0:	0017e713          	ori	a4,a5,1
80001af4:	fec42783          	lw	a5,-20(s0)
80001af8:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0, va)]; // 返回二级页表 PTE
80001afc:	fd842783          	lw	a5,-40(s0)
80001b00:	00c7d793          	srli	a5,a5,0xc
80001b04:	3ff7f793          	andi	a5,a5,1023
80001b08:	00279793          	slli	a5,a5,0x2
80001b0c:	fdc42703          	lw	a4,-36(s0)
80001b10:	00f707b3          	add	a5,a4,a5
}
80001b14:	00078513          	mv	a0,a5
80001b18:	02c12083          	lw	ra,44(sp)
80001b1c:	02812403          	lw	s0,40(sp)
80001b20:	03010113          	addi	sp,sp,48
80001b24:	00008067          	ret

80001b28 <vmmap>:
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t *pgt, addr_t va, addr_t pa, uint size, uint mode)
{
80001b28:	fc010113          	addi	sp,sp,-64
80001b2c:	02112e23          	sw	ra,60(sp)
80001b30:	02812c23          	sw	s0,56(sp)
80001b34:	04010413          	addi	s0,sp,64
80001b38:	fca42e23          	sw	a0,-36(s0)
80001b3c:	fcb42c23          	sw	a1,-40(s0)
80001b40:	fcc42a23          	sw	a2,-44(s0)
80001b44:	fcd42823          	sw	a3,-48(s0)
80001b48:	fce42623          	sw	a4,-52(s0)
    pte_t *pte;

    // PPN
    addr_t start = ((va >> 12) << 12);
80001b4c:	fd842703          	lw	a4,-40(s0)
80001b50:	fffff7b7          	lui	a5,0xfffff
80001b54:	00f777b3          	and	a5,a4,a5
80001b58:	fef42623          	sw	a5,-20(s0)
    addr_t end = (((va + (size - 1)) >> 12) << 12);
80001b5c:	fd042703          	lw	a4,-48(s0)
80001b60:	fd842783          	lw	a5,-40(s0)
80001b64:	00f707b3          	add	a5,a4,a5
80001b68:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
80001b6c:	fffff7b7          	lui	a5,0xfffff
80001b70:	00f777b3          	and	a5,a4,a5
80001b74:	fef42423          	sw	a5,-24(s0)

    while (1)
    {
        pte = acquriepte(pgt, start);
80001b78:	fec42583          	lw	a1,-20(s0)
80001b7c:	fdc42503          	lw	a0,-36(s0)
80001b80:	ef5ff0ef          	jal	ra,80001a74 <acquriepte>
80001b84:	fea42223          	sw	a0,-28(s0)
        if (*pte & PTE_V)
80001b88:	fe442783          	lw	a5,-28(s0)
80001b8c:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001b90:	0017f793          	andi	a5,a5,1
80001b94:	00078863          	beqz	a5,80001ba4 <vmmap+0x7c>
            panic("repeat map");
80001b98:	8000d7b7          	lui	a5,0x8000d
80001b9c:	4f478513          	addi	a0,a5,1268 # 8000d4f4 <memend+0xf800d4f4>
80001ba0:	e64ff0ef          	jal	ra,80001204 <panic>
        *pte = PA2PTE(pa) | mode | PTE_V;
80001ba4:	fd442783          	lw	a5,-44(s0)
80001ba8:	00c7d793          	srli	a5,a5,0xc
80001bac:	00a79713          	slli	a4,a5,0xa
80001bb0:	fcc42783          	lw	a5,-52(s0)
80001bb4:	00f767b3          	or	a5,a4,a5
80001bb8:	0017e713          	ori	a4,a5,1
80001bbc:	fe442783          	lw	a5,-28(s0)
80001bc0:	00e7a023          	sw	a4,0(a5)
        if (start == end)
80001bc4:	fec42703          	lw	a4,-20(s0)
80001bc8:	fe842783          	lw	a5,-24(s0)
80001bcc:	02f70463          	beq	a4,a5,80001bf4 <vmmap+0xcc>
            break;
        start += PGSIZE;
80001bd0:	fec42703          	lw	a4,-20(s0)
80001bd4:	000017b7          	lui	a5,0x1
80001bd8:	00f707b3          	add	a5,a4,a5
80001bdc:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001be0:	fd442703          	lw	a4,-44(s0)
80001be4:	000017b7          	lui	a5,0x1
80001be8:	00f707b3          	add	a5,a4,a5
80001bec:	fcf42a23          	sw	a5,-44(s0)
        pte = acquriepte(pgt, start);
80001bf0:	f89ff06f          	j	80001b78 <vmmap+0x50>
            break;
80001bf4:	00000013          	nop
    }
}
80001bf8:	00000013          	nop
80001bfc:	03c12083          	lw	ra,60(sp)
80001c00:	03812403          	lw	s0,56(sp)
80001c04:	04010113          	addi	sp,sp,64
80001c08:	00008067          	ret

80001c0c <printpgt>:

void printpgt(addr_t *pgt)
{
80001c0c:	fc010113          	addi	sp,sp,-64
80001c10:	02112e23          	sw	ra,60(sp)
80001c14:	02812c23          	sw	s0,56(sp)
80001c18:	04010413          	addi	s0,sp,64
80001c1c:	fca42623          	sw	a0,-52(s0)
    for (int i = 0; i < 1024; i++)
80001c20:	fe042623          	sw	zero,-20(s0)
80001c24:	0c40006f          	j	80001ce8 <printpgt+0xdc>
    {
        pte_t pte = pgt[i];
80001c28:	fec42783          	lw	a5,-20(s0)
80001c2c:	00279793          	slli	a5,a5,0x2
80001c30:	fcc42703          	lw	a4,-52(s0)
80001c34:	00f707b3          	add	a5,a4,a5
80001c38:	0007a783          	lw	a5,0(a5) # 1000 <sz>
80001c3c:	fef42223          	sw	a5,-28(s0)
        if (pte & PTE_V)
80001c40:	fe442783          	lw	a5,-28(s0)
80001c44:	0017f793          	andi	a5,a5,1
80001c48:	08078a63          	beqz	a5,80001cdc <printpgt+0xd0>
        {
            addr_t *pgt2 = (addr_t *)PTE2PA(pte);
80001c4c:	fe442783          	lw	a5,-28(s0)
80001c50:	00a7d793          	srli	a5,a5,0xa
80001c54:	00c79793          	slli	a5,a5,0xc
80001c58:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n", i, pte, pgt2);
80001c5c:	fe042683          	lw	a3,-32(s0)
80001c60:	fe442603          	lw	a2,-28(s0)
80001c64:	fec42583          	lw	a1,-20(s0)
80001c68:	8000d7b7          	lui	a5,0x8000d
80001c6c:	50078513          	addi	a0,a5,1280 # 8000d500 <memend+0xf800d500>
80001c70:	dccff0ef          	jal	ra,8000123c <printf>
            for (int j = 0; j < 1024; j++)
80001c74:	fe042423          	sw	zero,-24(s0)
80001c78:	0580006f          	j	80001cd0 <printpgt+0xc4>
            {
                pte_t pte2 = pgt2[j];
80001c7c:	fe842783          	lw	a5,-24(s0)
80001c80:	00279793          	slli	a5,a5,0x2
80001c84:	fe042703          	lw	a4,-32(s0)
80001c88:	00f707b3          	add	a5,a4,a5
80001c8c:	0007a783          	lw	a5,0(a5)
80001c90:	fcf42e23          	sw	a5,-36(s0)
                if (pte2 & PTE_V)
80001c94:	fdc42783          	lw	a5,-36(s0)
80001c98:	0017f793          	andi	a5,a5,1
80001c9c:	02078463          	beqz	a5,80001cc4 <printpgt+0xb8>
                {
                    printf(".. ..%d: pte %p pa %p\n", j, pte2, PTE2PA(pte2));
80001ca0:	fdc42783          	lw	a5,-36(s0)
80001ca4:	00a7d793          	srli	a5,a5,0xa
80001ca8:	00c79793          	slli	a5,a5,0xc
80001cac:	00078693          	mv	a3,a5
80001cb0:	fdc42603          	lw	a2,-36(s0)
80001cb4:	fe842583          	lw	a1,-24(s0)
80001cb8:	8000d7b7          	lui	a5,0x8000d
80001cbc:	51878513          	addi	a0,a5,1304 # 8000d518 <memend+0xf800d518>
80001cc0:	d7cff0ef          	jal	ra,8000123c <printf>
            for (int j = 0; j < 1024; j++)
80001cc4:	fe842783          	lw	a5,-24(s0)
80001cc8:	00178793          	addi	a5,a5,1
80001ccc:	fef42423          	sw	a5,-24(s0)
80001cd0:	fe842703          	lw	a4,-24(s0)
80001cd4:	3ff00793          	li	a5,1023
80001cd8:	fae7d2e3          	bge	a5,a4,80001c7c <printpgt+0x70>
    for (int i = 0; i < 1024; i++)
80001cdc:	fec42783          	lw	a5,-20(s0)
80001ce0:	00178793          	addi	a5,a5,1
80001ce4:	fef42623          	sw	a5,-20(s0)
80001ce8:	fec42703          	lw	a4,-20(s0)
80001cec:	3ff00793          	li	a5,1023
80001cf0:	f2e7dce3          	bge	a5,a4,80001c28 <printpgt+0x1c>
                }
            }
        }
    }
}
80001cf4:	00000013          	nop
80001cf8:	00000013          	nop
80001cfc:	03c12083          	lw	ra,60(sp)
80001d00:	03812403          	lw	s0,56(sp)
80001d04:	04010113          	addi	sp,sp,64
80001d08:	00008067          	ret

80001d0c <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t *pgt)
{
80001d0c:	fd010113          	addi	sp,sp,-48
80001d10:	02112623          	sw	ra,44(sp)
80001d14:	02812423          	sw	s0,40(sp)
80001d18:	03010413          	addi	s0,sp,48
80001d1c:	fca42e23          	sw	a0,-36(s0)
    for (int i = 0; i < NPROC; i++)
80001d20:	fe042623          	sw	zero,-20(s0)
80001d24:	04c0006f          	j	80001d70 <mkstack+0x64>
    {
        addr_t va = (addr_t)(KSPACE + PGSIZE + (i)*2 * PGSIZE);
80001d28:	fec42783          	lw	a5,-20(s0)
80001d2c:	00d79793          	slli	a5,a5,0xd
80001d30:	00078713          	mv	a4,a5
80001d34:	c00017b7          	lui	a5,0xc0001
80001d38:	00f707b3          	add	a5,a4,a5
80001d3c:	fef42423          	sw	a5,-24(s0)
        addr_t pa = (addr_t)palloc(); //! 待处理
80001d40:	a69ff0ef          	jal	ra,800017a8 <palloc>
80001d44:	00050793          	mv	a5,a0
80001d48:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt, va, pa, PGSIZE, PTE_R | PTE_W);
80001d4c:	00600713          	li	a4,6
80001d50:	000016b7          	lui	a3,0x1
80001d54:	fe442603          	lw	a2,-28(s0)
80001d58:	fe842583          	lw	a1,-24(s0)
80001d5c:	fdc42503          	lw	a0,-36(s0)
80001d60:	dc9ff0ef          	jal	ra,80001b28 <vmmap>
    for (int i = 0; i < NPROC; i++)
80001d64:	fec42783          	lw	a5,-20(s0)
80001d68:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
80001d6c:	fef42623          	sw	a5,-20(s0)
80001d70:	fec42703          	lw	a4,-20(s0)
80001d74:	00300793          	li	a5,3
80001d78:	fae7d8e3          	bge	a5,a4,80001d28 <mkstack+0x1c>
    }
}
80001d7c:	00000013          	nop
80001d80:	00000013          	nop
80001d84:	02c12083          	lw	ra,44(sp)
80001d88:	02812403          	lw	s0,40(sp)
80001d8c:	03010113          	addi	sp,sp,48
80001d90:	00008067          	ret

80001d94 <kvminit>:

// 初始化虚拟内存
void kvminit()
{
80001d94:	ff010113          	addi	sp,sp,-16
80001d98:	00112623          	sw	ra,12(sp)
80001d9c:	00812423          	sw	s0,8(sp)
80001da0:	01010413          	addi	s0,sp,16
    kpgt = (addr_t *)palloc();
80001da4:	a05ff0ef          	jal	ra,800017a8 <palloc>
80001da8:	00050713          	mv	a4,a0
80001dac:	8000f7b7          	lui	a5,0x8000f
80001db0:	a4e7a623          	sw	a4,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
    memset(kpgt, 0, PGSIZE);
80001db4:	8000f7b7          	lui	a5,0x8000f
80001db8:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001dbc:	00001637          	lui	a2,0x1
80001dc0:	00000593          	li	a1,0
80001dc4:	00078513          	mv	a0,a5
80001dc8:	041000ef          	jal	ra,80002608 <memset>

    // 映射 CLINT
    vmmap(kpgt, CLINT_BASE, CLINT_BASE, 0xc000, PTE_R | PTE_W);
80001dcc:	8000f7b7          	lui	a5,0x8000f
80001dd0:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001dd4:	00600713          	li	a4,6
80001dd8:	0000c6b7          	lui	a3,0xc
80001ddc:	02000637          	lui	a2,0x2000
80001de0:	020005b7          	lui	a1,0x2000
80001de4:	00078513          	mv	a0,a5
80001de8:	d41ff0ef          	jal	ra,80001b28 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt, PLIC_BASE, PLIC_BASE, 0x400000, PTE_R | PTE_W);
80001dec:	8000f7b7          	lui	a5,0x8000f
80001df0:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001df4:	00600713          	li	a4,6
80001df8:	004006b7          	lui	a3,0x400
80001dfc:	0c000637          	lui	a2,0xc000
80001e00:	0c0005b7          	lui	a1,0xc000
80001e04:	00078513          	mv	a0,a5
80001e08:	d21ff0ef          	jal	ra,80001b28 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt, UART_BASE, UART_BASE, PGSIZE, PTE_R | PTE_W);
80001e0c:	8000f7b7          	lui	a5,0x8000f
80001e10:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001e14:	00600713          	li	a4,6
80001e18:	000016b7          	lui	a3,0x1
80001e1c:	10000637          	lui	a2,0x10000
80001e20:	100005b7          	lui	a1,0x10000
80001e24:	00078513          	mv	a0,a5
80001e28:	d01ff0ef          	jal	ra,80001b28 <vmmap>

    // 映射 VIRTIO_MMIO
    vmmap(kpgt, VIRTIO_BASE, VIRTIO_BASE, PGSIZE, PTE_R | PTE_W);
80001e2c:	8000f7b7          	lui	a5,0x8000f
80001e30:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001e34:	00600713          	li	a4,6
80001e38:	000016b7          	lui	a3,0x1
80001e3c:	10001637          	lui	a2,0x10001
80001e40:	100015b7          	lui	a1,0x10001
80001e44:	00078513          	mv	a0,a5
80001e48:	ce1ff0ef          	jal	ra,80001b28 <vmmap>

    // 映射 内核 指令区
    vmmap(kpgt, (addr_t)textstart, (addr_t)textstart, (textend - textstart), PTE_R | PTE_X);
80001e4c:	8000f7b7          	lui	a5,0x8000f
80001e50:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001e54:	800007b7          	lui	a5,0x80000
80001e58:	00078593          	mv	a1,a5
80001e5c:	800007b7          	lui	a5,0x80000
80001e60:	00078613          	mv	a2,a5
80001e64:	800037b7          	lui	a5,0x80003
80001e68:	6c878713          	addi	a4,a5,1736 # 800036c8 <memend+0xf80036c8>
80001e6c:	800007b7          	lui	a5,0x80000
80001e70:	00078793          	mv	a5,a5
80001e74:	40f707b3          	sub	a5,a4,a5
80001e78:	00a00713          	li	a4,10
80001e7c:	00078693          	mv	a3,a5
80001e80:	ca9ff0ef          	jal	ra,80001b28 <vmmap>
    // 映射 数据区
    vmmap(kpgt, (addr_t)datastart, (addr_t)datastart, dataend - datastart, PTE_R | PTE_W);
80001e84:	8000f7b7          	lui	a5,0x8000f
80001e88:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001e8c:	800047b7          	lui	a5,0x80004
80001e90:	00078593          	mv	a1,a5
80001e94:	800047b7          	lui	a5,0x80004
80001e98:	00078613          	mv	a2,a5
80001e9c:	8000c7b7          	lui	a5,0x8000c
80001ea0:	02478713          	addi	a4,a5,36 # 8000c024 <memend+0xf800c024>
80001ea4:	800047b7          	lui	a5,0x80004
80001ea8:	00078793          	mv	a5,a5
80001eac:	40f707b3          	sub	a5,a4,a5
80001eb0:	00600713          	li	a4,6
80001eb4:	00078693          	mv	a3,a5
80001eb8:	c71ff0ef          	jal	ra,80001b28 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt, (addr_t)rodatastart, (addr_t)rodatastart, (rodataend - rodatastart), PTE_R);
80001ebc:	8000f7b7          	lui	a5,0x8000f
80001ec0:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001ec4:	8000d7b7          	lui	a5,0x8000d
80001ec8:	00078593          	mv	a1,a5
80001ecc:	8000d7b7          	lui	a5,0x8000d
80001ed0:	00078613          	mv	a2,a5
80001ed4:	8000d7b7          	lui	a5,0x8000d
80001ed8:	62878713          	addi	a4,a5,1576 # 8000d628 <memend+0xf800d628>
80001edc:	8000d7b7          	lui	a5,0x8000d
80001ee0:	00078793          	mv	a5,a5
80001ee4:	40f707b3          	sub	a5,a4,a5
80001ee8:	00200713          	li	a4,2
80001eec:	00078693          	mv	a3,a5
80001ef0:	c39ff0ef          	jal	ra,80001b28 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt, (addr_t)bssstart, (addr_t)bssstart, bssend - bssstart, PTE_R | PTE_W);
80001ef4:	8000f7b7          	lui	a5,0x8000f
80001ef8:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001efc:	8000e7b7          	lui	a5,0x8000e
80001f00:	00078593          	mv	a1,a5
80001f04:	8000e7b7          	lui	a5,0x8000e
80001f08:	00078613          	mv	a2,a5
80001f0c:	800127b7          	lui	a5,0x80012
80001f10:	00078713          	mv	a4,a5
80001f14:	8000e7b7          	lui	a5,0x8000e
80001f18:	00078793          	mv	a5,a5
80001f1c:	40f707b3          	sub	a5,a4,a5
80001f20:	00600713          	li	a4,6
80001f24:	00078693          	mv	a3,a5
80001f28:	c01ff0ef          	jal	ra,80001b28 <vmmap>

    // 映射空闲内存区
    vmmap(kpgt, (addr_t)mstart, (addr_t)mstart, mend - mstart, PTE_W | PTE_R);
80001f2c:	8000f7b7          	lui	a5,0x8000f
80001f30:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001f34:	800127b7          	lui	a5,0x80012
80001f38:	00078593          	mv	a1,a5
80001f3c:	800127b7          	lui	a5,0x80012
80001f40:	00078613          	mv	a2,a5
80001f44:	880007b7          	lui	a5,0x88000
80001f48:	00078713          	mv	a4,a5
80001f4c:	800127b7          	lui	a5,0x80012
80001f50:	00078793          	mv	a5,a5
80001f54:	40f707b3          	sub	a5,a4,a5
80001f58:	00600713          	li	a4,6
80001f5c:	00078693          	mv	a3,a5
80001f60:	bc9ff0ef          	jal	ra,80001b28 <vmmap>

    mkstack(kpgt);
80001f64:	8000f7b7          	lui	a5,0x8000f
80001f68:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001f6c:	00078513          	mv	a0,a5
80001f70:	d9dff0ef          	jal	ra,80001d0c <mkstack>

    // 映射 usertrap
    vmmap(kpgt, USERVEC, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80001f74:	8000f7b7          	lui	a5,0x8000f
80001f78:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001f7c:	800007b7          	lui	a5,0x80000
80001f80:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001f84:	00a00713          	li	a4,10
80001f88:	000016b7          	lui	a3,0x1
80001f8c:	00078613          	mv	a2,a5
80001f90:	fffff5b7          	lui	a1,0xfffff
80001f94:	b95ff0ef          	jal	ra,80001b28 <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32 | (((uint32)kpgt) >> 12)); // 页表 PPN 写入Satp
80001f98:	8000f7b7          	lui	a5,0x8000f
80001f9c:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001fa0:	00c7d713          	srli	a4,a5,0xc
80001fa4:	800007b7          	lui	a5,0x80000
80001fa8:	00f767b3          	or	a5,a4,a5
80001fac:	00078513          	mv	a0,a5
80001fb0:	a7dff0ef          	jal	ra,80001a2c <w_satp>
    sfence_vma();                               // 刷新页表
80001fb4:	aa1ff0ef          	jal	ra,80001a54 <sfence_vma>
}
80001fb8:	00000013          	nop
80001fbc:	00c12083          	lw	ra,12(sp)
80001fc0:	00812403          	lw	s0,8(sp)
80001fc4:	01010113          	addi	sp,sp,16
80001fc8:	00008067          	ret

80001fcc <pgtcreate>:

addr_t *pgtcreate()
{
80001fcc:	fe010113          	addi	sp,sp,-32
80001fd0:	00112e23          	sw	ra,28(sp)
80001fd4:	00812c23          	sw	s0,24(sp)
80001fd8:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t *pgt = (addr_t *)palloc();
80001fdc:	fccff0ef          	jal	ra,800017a8 <palloc>
80001fe0:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001fe4:	fec42783          	lw	a5,-20(s0)
}
80001fe8:	00078513          	mv	a0,a5
80001fec:	01c12083          	lw	ra,28(sp)
80001ff0:	01812403          	lw	s0,24(sp)
80001ff4:	02010113          	addi	sp,sp,32
80001ff8:	00008067          	ret

80001ffc <r_tp>:
{
80001ffc:	fe010113          	addi	sp,sp,-32
80002000:	00812e23          	sw	s0,28(sp)
80002004:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80002008:	00020793          	mv	a5,tp
8000200c:	fef42623          	sw	a5,-20(s0)
    return x;
80002010:	fec42783          	lw	a5,-20(s0)
}
80002014:	00078513          	mv	a0,a5
80002018:	01c12403          	lw	s0,28(sp)
8000201c:	02010113          	addi	sp,sp,32
80002020:	00008067          	ret

80002024 <procinit>:
#include "syscall.h"

uint nextpid = 0;

void procinit()
{
80002024:	fe010113          	addi	sp,sp,-32
80002028:	00812e23          	sw	s0,28(sp)
8000202c:	02010413          	addi	s0,sp,32
    struct pcb *p;
    for (int i = 0; i < NPROC; i++)
80002030:	fe042623          	sw	zero,-20(s0)
80002034:	0500006f          	j	80002084 <procinit+0x60>
    {
        p = &proc[i];
80002038:	fec42703          	lw	a4,-20(s0)
8000203c:	00070793          	mv	a5,a4
80002040:	00379793          	slli	a5,a5,0x3
80002044:	00e787b3          	add	a5,a5,a4
80002048:	00479793          	slli	a5,a5,0x4
8000204c:	8000e737          	lui	a4,0x8000e
80002050:	40870713          	addi	a4,a4,1032 # 8000e408 <memend+0xf800e408>
80002054:	00e787b3          	add	a5,a5,a4
80002058:	fef42423          	sw	a5,-24(s0)
        p->kernelstack = (addr_t)(KSTACK + (i)*2 * PGSIZE);
8000205c:	fec42783          	lw	a5,-20(s0)
80002060:	00d79793          	slli	a5,a5,0xd
80002064:	00078713          	mv	a4,a5
80002068:	c00027b7          	lui	a5,0xc0002
8000206c:	00f70733          	add	a4,a4,a5
80002070:	fe842783          	lw	a5,-24(s0)
80002074:	08e7a623          	sw	a4,140(a5) # c000208c <memend+0x3800208c>
    for (int i = 0; i < NPROC; i++)
80002078:	fec42783          	lw	a5,-20(s0)
8000207c:	00178793          	addi	a5,a5,1
80002080:	fef42623          	sw	a5,-20(s0)
80002084:	fec42703          	lw	a4,-20(s0)
80002088:	00300793          	li	a5,3
8000208c:	fae7d6e3          	bge	a5,a4,80002038 <procinit+0x14>
    }
}
80002090:	00000013          	nop
80002094:	00000013          	nop
80002098:	01c12403          	lw	s0,28(sp)
8000209c:	02010113          	addi	sp,sp,32
800020a0:	00008067          	ret

800020a4 <nowcpu>:

struct cpu *nowcpu()
{
800020a4:	fe010113          	addi	sp,sp,-32
800020a8:	00112e23          	sw	ra,28(sp)
800020ac:	00812c23          	sw	s0,24(sp)
800020b0:	02010413          	addi	s0,sp,32
    int hart = r_tp();
800020b4:	f49ff0ef          	jal	ra,80001ffc <r_tp>
800020b8:	00050793          	mv	a5,a0
800020bc:	fef42623          	sw	a5,-20(s0)
    struct cpu *c = &cpus[hart];
800020c0:	fec42783          	lw	a5,-20(s0)
800020c4:	00779713          	slli	a4,a5,0x7
800020c8:	8000e7b7          	lui	a5,0x8000e
800020cc:	64878793          	addi	a5,a5,1608 # 8000e648 <memend+0xf800e648>
800020d0:	00f707b3          	add	a5,a4,a5
800020d4:	fef42423          	sw	a5,-24(s0)
    return c;
800020d8:	fe842783          	lw	a5,-24(s0)
}
800020dc:	00078513          	mv	a0,a5
800020e0:	01c12083          	lw	ra,28(sp)
800020e4:	01812403          	lw	s0,24(sp)
800020e8:	02010113          	addi	sp,sp,32
800020ec:	00008067          	ret

800020f0 <nowproc>:
struct pcb *nowproc()
{
800020f0:	fe010113          	addi	sp,sp,-32
800020f4:	00112e23          	sw	ra,28(sp)
800020f8:	00812c23          	sw	s0,24(sp)
800020fc:	02010413          	addi	s0,sp,32
    struct cpu *c = nowcpu();
80002100:	fa5ff0ef          	jal	ra,800020a4 <nowcpu>
80002104:	fea42623          	sw	a0,-20(s0)
    return c->proc;
80002108:	fec42783          	lw	a5,-20(s0)
8000210c:	0007a783          	lw	a5,0(a5)
}
80002110:	00078513          	mv	a0,a5
80002114:	01c12083          	lw	ra,28(sp)
80002118:	01812403          	lw	s0,24(sp)
8000211c:	02010113          	addi	sp,sp,32
80002120:	00008067          	ret

80002124 <pidalloc>:

uint pidalloc()
{
80002124:	ff010113          	addi	sp,sp,-16
80002128:	00812623          	sw	s0,12(sp)
8000212c:	01010413          	addi	s0,sp,16
    return nextpid++;
80002130:	8000e7b7          	lui	a5,0x8000e
80002134:	0007a783          	lw	a5,0(a5) # 8000e000 <memend+0xf800e000>
80002138:	00178693          	addi	a3,a5,1
8000213c:	8000e737          	lui	a4,0x8000e
80002140:	00d72023          	sw	a3,0(a4) # 8000e000 <memend+0xf800e000>
}
80002144:	00078513          	mv	a0,a5
80002148:	00c12403          	lw	s0,12(sp)
8000214c:	01010113          	addi	sp,sp,16
80002150:	00008067          	ret

80002154 <procalloc>:

struct pcb *procalloc()
{
80002154:	fe010113          	addi	sp,sp,-32
80002158:	00112e23          	sw	ra,28(sp)
8000215c:	00812c23          	sw	s0,24(sp)
80002160:	02010413          	addi	s0,sp,32
    struct pcb *p;
    for (p = proc; p < &proc[NPROC]; p++)
80002164:	8000e7b7          	lui	a5,0x8000e
80002168:	40878793          	addi	a5,a5,1032 # 8000e408 <memend+0xf800e408>
8000216c:	fef42623          	sw	a5,-20(s0)
80002170:	0680006f          	j	800021d8 <procalloc+0x84>
    {
        if (p->status == UNUSED)
80002174:	fec42783          	lw	a5,-20(s0)
80002178:	0047a783          	lw	a5,4(a5)
8000217c:	04079863          	bnez	a5,800021cc <procalloc+0x78>
        {
            p->trapframe = (struct trapframe *)palloc(sizeof(struct trapframe));
80002180:	08c00513          	li	a0,140
80002184:	e24ff0ef          	jal	ra,800017a8 <palloc>
80002188:	00050713          	mv	a4,a0
8000218c:	fec42783          	lw	a5,-20(s0)
80002190:	00e7a423          	sw	a4,8(a5)

            p->pid = pidalloc();
80002194:	f91ff0ef          	jal	ra,80002124 <pidalloc>
80002198:	00050793          	mv	a5,a0
8000219c:	00078713          	mv	a4,a5
800021a0:	fec42783          	lw	a5,-20(s0)
800021a4:	00e7a023          	sw	a4,0(a5)
            p->status = USED;
800021a8:	fec42783          	lw	a5,-20(s0)
800021ac:	00100713          	li	a4,1
800021b0:	00e7a223          	sw	a4,4(a5)

            p->pagetable = pgtcreate();
800021b4:	e19ff0ef          	jal	ra,80001fcc <pgtcreate>
800021b8:	00050713          	mv	a4,a0
800021bc:	fec42783          	lw	a5,-20(s0)
800021c0:	08e7a423          	sw	a4,136(a5)

            return p;
800021c4:	fec42783          	lw	a5,-20(s0)
800021c8:	0240006f          	j	800021ec <procalloc+0x98>
    for (p = proc; p < &proc[NPROC]; p++)
800021cc:	fec42783          	lw	a5,-20(s0)
800021d0:	09078793          	addi	a5,a5,144
800021d4:	fef42623          	sw	a5,-20(s0)
800021d8:	fec42703          	lw	a4,-20(s0)
800021dc:	8000e7b7          	lui	a5,0x8000e
800021e0:	64878793          	addi	a5,a5,1608 # 8000e648 <memend+0xf800e648>
800021e4:	f8f768e3          	bltu	a4,a5,80002174 <procalloc+0x20>
        }
    }
    return 0;
800021e8:	00000793          	li	a5,0
}
800021ec:	00078513          	mv	a0,a5
800021f0:	01c12083          	lw	ra,28(sp)
800021f4:	01812403          	lw	s0,24(sp)
800021f8:	02010113          	addi	sp,sp,32
800021fc:	00008067          	ret

80002200 <userinit>:
    0x73, 0x00, 0x00, 0x00,
    0x6f, 0x00, 0x00, 0x00};

// 初始化第一个进程
void userinit()
{
80002200:	fe010113          	addi	sp,sp,-32
80002204:	00112e23          	sw	ra,28(sp)
80002208:	00812c23          	sw	s0,24(sp)
8000220c:	02010413          	addi	s0,sp,32
    struct pcb *p = procalloc();
80002210:	f45ff0ef          	jal	ra,80002154 <procalloc>
80002214:	fea42623          	sw	a0,-20(s0)

    p->trapframe->epc = 0;
80002218:	fec42783          	lw	a5,-20(s0)
8000221c:	0087a783          	lw	a5,8(a5)
80002220:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp = PGSIZE;
80002224:	fec42783          	lw	a5,-20(s0)
80002228:	0087a783          	lw	a5,8(a5)
8000222c:	00001737          	lui	a4,0x1
80002230:	00e7aa23          	sw	a4,20(a5)

    char *m = (char *)palloc();
80002234:	d74ff0ef          	jal	ra,800017a8 <palloc>
80002238:	fea42423          	sw	a0,-24(s0)
    memmove(m, zeroproc, sizeof(zeroproc));
8000223c:	00c00613          	li	a2,12
80002240:	00000693          	li	a3,0
80002244:	8000c7b7          	lui	a5,0x8000c
80002248:	00078593          	mv	a1,a5
8000224c:	fe842503          	lw	a0,-24(s0)
80002250:	424000ef          	jal	ra,80002674 <memmove>

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
80002254:	fec42783          	lw	a5,-20(s0)
80002258:	0887a783          	lw	a5,136(a5) # 8000c088 <memend+0xf800c088>
8000225c:	fe842603          	lw	a2,-24(s0)
80002260:	01e00713          	li	a4,30
80002264:	000016b7          	lui	a3,0x1
80002268:	00000593          	li	a1,0
8000226c:	00078513          	mv	a0,a5
80002270:	8b9ff0ef          	jal	ra,80001b28 <vmmap>
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80002274:	fec42783          	lw	a5,-20(s0)
80002278:	0887a503          	lw	a0,136(a5)
8000227c:	800007b7          	lui	a5,0x80000
80002280:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80002284:	800007b7          	lui	a5,0x80000
80002288:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
8000228c:	00a00713          	li	a4,10
80002290:	000016b7          	lui	a3,0x1
80002294:	00078613          	mv	a2,a5
80002298:	891ff0ef          	jal	ra,80001b28 <vmmap>

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
8000229c:	fec42783          	lw	a5,-20(s0)
800022a0:	0887a503          	lw	a0,136(a5)
800022a4:	fec42783          	lw	a5,-20(s0)
800022a8:	0087a783          	lw	a5,8(a5)
800022ac:	00600713          	li	a4,6
800022b0:	000016b7          	lui	a3,0x1
800022b4:	00078613          	mv	a2,a5
800022b8:	ffffe5b7          	lui	a1,0xffffe
800022bc:	86dff0ef          	jal	ra,80001b28 <vmmap>

    p->pagetable = (addr_t *)p->pagetable;
800022c0:	fec42783          	lw	a5,-20(s0)
800022c4:	0887a703          	lw	a4,136(a5)
800022c8:	fec42783          	lw	a5,-20(s0)
800022cc:	08e7a423          	sw	a4,136(a5)

    p->status = RUNABLE;
800022d0:	fec42783          	lw	a5,-20(s0)
800022d4:	00200713          	li	a4,2
800022d8:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
800022dc:	fec42783          	lw	a5,-20(s0)
800022e0:	0887a783          	lw	a5,136(a5)
800022e4:	00078513          	mv	a0,a5
800022e8:	a25ff0ef          	jal	ra,80001d0c <mkstack>

    p->context.ra = (reg_t)usertrapret;
800022ec:	800017b7          	lui	a5,0x80001
800022f0:	e3078713          	addi	a4,a5,-464 # 80000e30 <memend+0xf8000e30>
800022f4:	fec42783          	lw	a5,-20(s0)
800022f8:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
800022fc:	fec42783          	lw	a5,-20(s0)
80002300:	08c7a703          	lw	a4,140(a5)
80002304:	fec42783          	lw	a5,-20(s0)
80002308:	00e7a823          	sw	a4,16(a5)

    p = procalloc();
8000230c:	e49ff0ef          	jal	ra,80002154 <procalloc>
80002310:	fea42623          	sw	a0,-20(s0)
    p->context.ra = (reg_t)usertrapret;
80002314:	800017b7          	lui	a5,0x80001
80002318:	e3078713          	addi	a4,a5,-464 # 80000e30 <memend+0xf8000e30>
8000231c:	fec42783          	lw	a5,-20(s0)
80002320:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
80002324:	fec42783          	lw	a5,-20(s0)
80002328:	08c7a703          	lw	a4,140(a5)
8000232c:	fec42783          	lw	a5,-20(s0)
80002330:	00e7a823          	sw	a4,16(a5)

    p->trapframe->epc = 0;
80002334:	fec42783          	lw	a5,-20(s0)
80002338:	0087a783          	lw	a5,8(a5)
8000233c:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp = PGSIZE;
80002340:	fec42783          	lw	a5,-20(s0)
80002344:	0087a783          	lw	a5,8(a5)
80002348:	00001737          	lui	a4,0x1
8000234c:	00e7aa23          	sw	a4,20(a5)

    m = (char *)palloc();
80002350:	c58ff0ef          	jal	ra,800017a8 <palloc>
80002354:	fea42423          	sw	a0,-24(s0)
    memmove(m, firstproc, sizeof(zeroproc));
80002358:	00c00613          	li	a2,12
8000235c:	00000693          	li	a3,0
80002360:	8000c7b7          	lui	a5,0x8000c
80002364:	00c78593          	addi	a1,a5,12 # 8000c00c <memend+0xf800c00c>
80002368:	fe842503          	lw	a0,-24(s0)
8000236c:	308000ef          	jal	ra,80002674 <memmove>

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
80002370:	fec42783          	lw	a5,-20(s0)
80002374:	0887a783          	lw	a5,136(a5)
80002378:	fe842603          	lw	a2,-24(s0)
8000237c:	01e00713          	li	a4,30
80002380:	000016b7          	lui	a3,0x1
80002384:	00000593          	li	a1,0
80002388:	00078513          	mv	a0,a5
8000238c:	f9cff0ef          	jal	ra,80001b28 <vmmap>
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80002390:	fec42783          	lw	a5,-20(s0)
80002394:	0887a503          	lw	a0,136(a5)
80002398:	800007b7          	lui	a5,0x80000
8000239c:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
800023a0:	800007b7          	lui	a5,0x80000
800023a4:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
800023a8:	00a00713          	li	a4,10
800023ac:	000016b7          	lui	a3,0x1
800023b0:	00078613          	mv	a2,a5
800023b4:	f74ff0ef          	jal	ra,80001b28 <vmmap>

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
800023b8:	fec42783          	lw	a5,-20(s0)
800023bc:	0887a503          	lw	a0,136(a5)
800023c0:	fec42783          	lw	a5,-20(s0)
800023c4:	0087a783          	lw	a5,8(a5)
800023c8:	00600713          	li	a4,6
800023cc:	000016b7          	lui	a3,0x1
800023d0:	00078613          	mv	a2,a5
800023d4:	ffffe5b7          	lui	a1,0xffffe
800023d8:	f50ff0ef          	jal	ra,80001b28 <vmmap>

    p->pagetable = (addr_t *)p->pagetable;
800023dc:	fec42783          	lw	a5,-20(s0)
800023e0:	0887a703          	lw	a4,136(a5)
800023e4:	fec42783          	lw	a5,-20(s0)
800023e8:	08e7a423          	sw	a4,136(a5)

    p->status = RUNABLE;
800023ec:	fec42783          	lw	a5,-20(s0)
800023f0:	00200713          	li	a4,2
800023f4:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
800023f8:	fec42783          	lw	a5,-20(s0)
800023fc:	0887a783          	lw	a5,136(a5)
80002400:	00078513          	mv	a0,a5
80002404:	909ff0ef          	jal	ra,80001d0c <mkstack>

    p->context.ra = (reg_t)usertrapret;
80002408:	800017b7          	lui	a5,0x80001
8000240c:	e3078713          	addi	a4,a5,-464 # 80000e30 <memend+0xf8000e30>
80002410:	fec42783          	lw	a5,-20(s0)
80002414:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
80002418:	fec42783          	lw	a5,-20(s0)
8000241c:	08c7a703          	lw	a4,140(a5)
80002420:	fec42783          	lw	a5,-20(s0)
80002424:	00e7a823          	sw	a4,16(a5)
}
80002428:	00000013          	nop
8000242c:	01c12083          	lw	ra,28(sp)
80002430:	01812403          	lw	s0,24(sp)
80002434:	02010113          	addi	sp,sp,32
80002438:	00008067          	ret

8000243c <schedule>:

void schedule()
{
8000243c:	fe010113          	addi	sp,sp,-32
80002440:	00112e23          	sw	ra,28(sp)
80002444:	00812c23          	sw	s0,24(sp)
80002448:	02010413          	addi	s0,sp,32
    struct cpu *c = nowcpu();
8000244c:	c59ff0ef          	jal	ra,800020a4 <nowcpu>
80002450:	fea42423          	sw	a0,-24(s0)
    struct pcb *p;

    for (;;)
    {
        for (p = proc; p < &proc[NPROC]; p++)
80002454:	8000e7b7          	lui	a5,0x8000e
80002458:	40878793          	addi	a5,a5,1032 # 8000e408 <memend+0xf800e408>
8000245c:	fef42623          	sw	a5,-20(s0)
80002460:	05c0006f          	j	800024bc <schedule+0x80>
        {
            if (p->status == RUNABLE)
80002464:	fec42783          	lw	a5,-20(s0)
80002468:	0047a703          	lw	a4,4(a5)
8000246c:	00200793          	li	a5,2
80002470:	04f71063          	bne	a4,a5,800024b0 <schedule+0x74>
            {
                p->status = RUNNING;
80002474:	fec42783          	lw	a5,-20(s0)
80002478:	00300713          	li	a4,3
8000247c:	00e7a223          	sw	a4,4(a5)
                c->proc = p;
80002480:	fe842783          	lw	a5,-24(s0)
80002484:	fec42703          	lw	a4,-20(s0)
80002488:	00e7a023          	sw	a4,0(a5)
                // 保存当前的上下文到cpu->context中
                swtch(&c->context, &p->context);
8000248c:	fe842783          	lw	a5,-24(s0)
80002490:	00478713          	addi	a4,a5,4
80002494:	fec42783          	lw	a5,-20(s0)
80002498:	00c78793          	addi	a5,a5,12
8000249c:	00078593          	mv	a1,a5
800024a0:	00070513          	mv	a0,a4
800024a4:	cf9fd0ef          	jal	ra,8000019c <swtch>
                // swtch ret后跳转到p->context.ra

                c->proc = 0; // cpu->context.ra 指向这里
800024a8:	fe842783          	lw	a5,-24(s0)
800024ac:	0007a023          	sw	zero,0(a5)
        for (p = proc; p < &proc[NPROC]; p++)
800024b0:	fec42783          	lw	a5,-20(s0)
800024b4:	09078793          	addi	a5,a5,144
800024b8:	fef42623          	sw	a5,-20(s0)
800024bc:	fec42703          	lw	a4,-20(s0)
800024c0:	8000e7b7          	lui	a5,0x8000e
800024c4:	64878793          	addi	a5,a5,1608 # 8000e648 <memend+0xf800e648>
800024c8:	f8f76ee3          	bltu	a4,a5,80002464 <schedule+0x28>
800024cc:	f89ff06f          	j	80002454 <schedule+0x18>

800024d0 <yield>:

/**
 * @description: 进程放弃 CPU
 */
void yield()
{
800024d0:	fe010113          	addi	sp,sp,-32
800024d4:	00112e23          	sw	ra,28(sp)
800024d8:	00812c23          	sw	s0,24(sp)
800024dc:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
800024e0:	c11ff0ef          	jal	ra,800020f0 <nowproc>
800024e4:	fea42623          	sw	a0,-20(s0)
    if (p == 0 || p->status != RUNNING)
800024e8:	fec42783          	lw	a5,-20(s0)
800024ec:	00078a63          	beqz	a5,80002500 <yield+0x30>
800024f0:	fec42783          	lw	a5,-20(s0)
800024f4:	0047a703          	lw	a4,4(a5)
800024f8:	00300793          	li	a5,3
800024fc:	00f70863          	beq	a4,a5,8000250c <yield+0x3c>
    {
        panic("proc status error");
80002500:	8000d7b7          	lui	a5,0x8000d
80002504:	53078513          	addi	a0,a5,1328 # 8000d530 <memend+0xf800d530>
80002508:	cfdfe0ef          	jal	ra,80001204 <panic>
    }
    p->status = RUNABLE;
8000250c:	fec42783          	lw	a5,-20(s0)
80002510:	00200713          	li	a4,2
80002514:	00e7a223          	sw	a4,4(a5)
    sched();
80002518:	018000ef          	jal	ra,80002530 <sched>
}
8000251c:	00000013          	nop
80002520:	01c12083          	lw	ra,28(sp)
80002524:	01812403          	lw	s0,24(sp)
80002528:	02010113          	addi	sp,sp,32
8000252c:	00008067          	ret

80002530 <sched>:

/**
 * @description:
 */
void sched()
{
80002530:	fe010113          	addi	sp,sp,-32
80002534:	00112e23          	sw	ra,28(sp)
80002538:	00812c23          	sw	s0,24(sp)
8000253c:	00912a23          	sw	s1,20(sp)
80002540:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002544:	badff0ef          	jal	ra,800020f0 <nowproc>
80002548:	fea42623          	sw	a0,-20(s0)
    if (p->status == RUNNING)
8000254c:	fec42783          	lw	a5,-20(s0)
80002550:	0047a703          	lw	a4,4(a5)
80002554:	00300793          	li	a5,3
80002558:	00f71863          	bne	a4,a5,80002568 <sched+0x38>
    {
        panic("proc is running");
8000255c:	8000d7b7          	lui	a5,0x8000d
80002560:	54478513          	addi	a0,a5,1348 # 8000d544 <memend+0xf800d544>
80002564:	ca1fe0ef          	jal	ra,80001204 <panic>
    }
    swtch(&p->context, &nowcpu()->context); //跳转到cpu->context.ra ( schedule() )
80002568:	fec42783          	lw	a5,-20(s0)
8000256c:	00c78493          	addi	s1,a5,12
80002570:	b35ff0ef          	jal	ra,800020a4 <nowcpu>
80002574:	00050793          	mv	a5,a0
80002578:	00478793          	addi	a5,a5,4
8000257c:	00078593          	mv	a1,a5
80002580:	00048513          	mv	a0,s1
80002584:	c19fd0ef          	jal	ra,8000019c <swtch>
}
80002588:	00000013          	nop
8000258c:	01c12083          	lw	ra,28(sp)
80002590:	01812403          	lw	s0,24(sp)
80002594:	01412483          	lw	s1,20(sp)
80002598:	02010113          	addi	sp,sp,32
8000259c:	00008067          	ret

800025a0 <sys_fork>:

uint32 sys_fork(void)
{
800025a0:	ff010113          	addi	sp,sp,-16
800025a4:	00112623          	sw	ra,12(sp)
800025a8:	00812423          	sw	s0,8(sp)
800025ac:	01010413          	addi	s0,sp,16
    printf("syscall fork\n");
800025b0:	8000d7b7          	lui	a5,0x8000d
800025b4:	55478513          	addi	a0,a5,1364 # 8000d554 <memend+0xf800d554>
800025b8:	c85fe0ef          	jal	ra,8000123c <printf>
    return SYS_fork;
800025bc:	00100793          	li	a5,1
}
800025c0:	00078513          	mv	a0,a5
800025c4:	00c12083          	lw	ra,12(sp)
800025c8:	00812403          	lw	s0,8(sp)
800025cc:	01010113          	addi	sp,sp,16
800025d0:	00008067          	ret

800025d4 <sys_exec>:

uint32 sys_exec(void)
{
800025d4:	ff010113          	addi	sp,sp,-16
800025d8:	00112623          	sw	ra,12(sp)
800025dc:	00812423          	sw	s0,8(sp)
800025e0:	01010413          	addi	s0,sp,16
    printf("syscall exec\n");
800025e4:	8000d7b7          	lui	a5,0x8000d
800025e8:	56478513          	addi	a0,a5,1380 # 8000d564 <memend+0xf800d564>
800025ec:	c51fe0ef          	jal	ra,8000123c <printf>
    return SYS_exec;
800025f0:	00200793          	li	a5,2
800025f4:	00078513          	mv	a0,a5
800025f8:	00c12083          	lw	ra,12(sp)
800025fc:	00812403          	lw	s0,8(sp)
80002600:	01010113          	addi	sp,sp,16
80002604:	00008067          	ret

80002608 <memset>:
 */
#include "types.h"

// 初始化内存区域
void *memset(void *addr, int c, uint n)
{
80002608:	fd010113          	addi	sp,sp,-48
8000260c:	02812623          	sw	s0,44(sp)
80002610:	03010413          	addi	s0,sp,48
80002614:	fca42e23          	sw	a0,-36(s0)
80002618:	fcb42c23          	sw	a1,-40(s0)
8000261c:	fcc42a23          	sw	a2,-44(s0)
    char *maddr = (char *)addr;
80002620:	fdc42783          	lw	a5,-36(s0)
80002624:	fef42423          	sw	a5,-24(s0)
    for (uint i = 0; i < n; i++)
80002628:	fe042623          	sw	zero,-20(s0)
8000262c:	0280006f          	j	80002654 <memset+0x4c>
    {
        maddr[i] = (char)c;
80002630:	fe842703          	lw	a4,-24(s0)
80002634:	fec42783          	lw	a5,-20(s0)
80002638:	00f707b3          	add	a5,a4,a5
8000263c:	fd842703          	lw	a4,-40(s0)
80002640:	0ff77713          	andi	a4,a4,255
80002644:	00e78023          	sb	a4,0(a5)
    for (uint i = 0; i < n; i++)
80002648:	fec42783          	lw	a5,-20(s0)
8000264c:	00178793          	addi	a5,a5,1
80002650:	fef42623          	sw	a5,-20(s0)
80002654:	fec42703          	lw	a4,-20(s0)
80002658:	fd442783          	lw	a5,-44(s0)
8000265c:	fcf76ae3          	bltu	a4,a5,80002630 <memset+0x28>
    }
    return addr;
80002660:	fdc42783          	lw	a5,-36(s0)
}
80002664:	00078513          	mv	a0,a5
80002668:	02c12403          	lw	s0,44(sp)
8000266c:	03010113          	addi	sp,sp,48
80002670:	00008067          	ret

80002674 <memmove>:

// 安全的 memcpy
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void *memmove(void *dst, const void *src, size_t n)
{
80002674:	fd010113          	addi	sp,sp,-48
80002678:	02812623          	sw	s0,44(sp)
8000267c:	03010413          	addi	s0,sp,48
80002680:	fca42e23          	sw	a0,-36(s0)
80002684:	fcb42c23          	sw	a1,-40(s0)
80002688:	fcc42823          	sw	a2,-48(s0)
8000268c:	fcd42a23          	sw	a3,-44(s0)
    const char *s;
    char *d;
    if (n == 0)
80002690:	fd042783          	lw	a5,-48(s0)
80002694:	fd442703          	lw	a4,-44(s0)
80002698:	00e7e7b3          	or	a5,a5,a4
8000269c:	00079663          	bnez	a5,800026a8 <memmove+0x34>
    {
        return dst;
800026a0:	fdc42783          	lw	a5,-36(s0)
800026a4:	1200006f          	j	800027c4 <memmove+0x150>
    }

    s = src;
800026a8:	fd842783          	lw	a5,-40(s0)
800026ac:	fef42623          	sw	a5,-20(s0)
    d = dst;
800026b0:	fdc42783          	lw	a5,-36(s0)
800026b4:	fef42423          	sw	a5,-24(s0)
    if (s < d && s + n > d)
800026b8:	fec42703          	lw	a4,-20(s0)
800026bc:	fe842783          	lw	a5,-24(s0)
800026c0:	0cf77263          	bgeu	a4,a5,80002784 <memmove+0x110>
800026c4:	fd042783          	lw	a5,-48(s0)
800026c8:	fec42703          	lw	a4,-20(s0)
800026cc:	00f707b3          	add	a5,a4,a5
800026d0:	fe842703          	lw	a4,-24(s0)
800026d4:	0af77863          	bgeu	a4,a5,80002784 <memmove+0x110>
    {
        // 有重叠区域,从后往前复制
        s += n;
800026d8:	fd042783          	lw	a5,-48(s0)
800026dc:	fec42703          	lw	a4,-20(s0)
800026e0:	00f707b3          	add	a5,a4,a5
800026e4:	fef42623          	sw	a5,-20(s0)
        d += n;
800026e8:	fd042783          	lw	a5,-48(s0)
800026ec:	fe842703          	lw	a4,-24(s0)
800026f0:	00f707b3          	add	a5,a4,a5
800026f4:	fef42423          	sw	a5,-24(s0)
        while (n-- > 0)
800026f8:	02c0006f          	j	80002724 <memmove+0xb0>
        {
            *--d = *--s;
800026fc:	fec42783          	lw	a5,-20(s0)
80002700:	fff78793          	addi	a5,a5,-1
80002704:	fef42623          	sw	a5,-20(s0)
80002708:	fe842783          	lw	a5,-24(s0)
8000270c:	fff78793          	addi	a5,a5,-1
80002710:	fef42423          	sw	a5,-24(s0)
80002714:	fec42783          	lw	a5,-20(s0)
80002718:	0007c703          	lbu	a4,0(a5)
8000271c:	fe842783          	lw	a5,-24(s0)
80002720:	00e78023          	sb	a4,0(a5)
        while (n-- > 0)
80002724:	fd042703          	lw	a4,-48(s0)
80002728:	fd442783          	lw	a5,-44(s0)
8000272c:	fff00513          	li	a0,-1
80002730:	fff00593          	li	a1,-1
80002734:	00a70633          	add	a2,a4,a0
80002738:	00060813          	mv	a6,a2
8000273c:	00e83833          	sltu	a6,a6,a4
80002740:	00b786b3          	add	a3,a5,a1
80002744:	00d805b3          	add	a1,a6,a3
80002748:	00058693          	mv	a3,a1
8000274c:	fcc42823          	sw	a2,-48(s0)
80002750:	fcd42a23          	sw	a3,-44(s0)
80002754:	00070693          	mv	a3,a4
80002758:	00f6e6b3          	or	a3,a3,a5
8000275c:	fa0690e3          	bnez	a3,800026fc <memmove+0x88>
    if (s < d && s + n > d)
80002760:	0600006f          	j	800027c0 <memmove+0x14c>
    else
    {
        // 无重叠区域,从前往后复制
        while (n-- > 0)
        {
            *d++ = *s++;
80002764:	fec42703          	lw	a4,-20(s0)
80002768:	00170793          	addi	a5,a4,1 # 1001 <sz+0x1>
8000276c:	fef42623          	sw	a5,-20(s0)
80002770:	fe842783          	lw	a5,-24(s0)
80002774:	00178693          	addi	a3,a5,1
80002778:	fed42423          	sw	a3,-24(s0)
8000277c:	00074703          	lbu	a4,0(a4)
80002780:	00e78023          	sb	a4,0(a5)
        while (n-- > 0)
80002784:	fd042703          	lw	a4,-48(s0)
80002788:	fd442783          	lw	a5,-44(s0)
8000278c:	fff00513          	li	a0,-1
80002790:	fff00593          	li	a1,-1
80002794:	00a70633          	add	a2,a4,a0
80002798:	00060813          	mv	a6,a2
8000279c:	00e83833          	sltu	a6,a6,a4
800027a0:	00b786b3          	add	a3,a5,a1
800027a4:	00d805b3          	add	a1,a6,a3
800027a8:	00058693          	mv	a3,a1
800027ac:	fcc42823          	sw	a2,-48(s0)
800027b0:	fcd42a23          	sw	a3,-44(s0)
800027b4:	00070693          	mv	a3,a4
800027b8:	00f6e6b3          	or	a3,a3,a5
800027bc:	fa0694e3          	bnez	a3,80002764 <memmove+0xf0>
        }
    }
    return dst;
800027c0:	fdc42783          	lw	a5,-36(s0)
}
800027c4:	00078513          	mv	a0,a5
800027c8:	02c12403          	lw	s0,44(sp)
800027cc:	03010113          	addi	sp,sp,48
800027d0:	00008067          	ret

800027d4 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char *s)
{
800027d4:	fd010113          	addi	sp,sp,-48
800027d8:	02812623          	sw	s0,44(sp)
800027dc:	03010413          	addi	s0,sp,48
800027e0:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for (n = 0; s[n]; n++)
800027e4:	00000793          	li	a5,0
800027e8:	00000813          	li	a6,0
800027ec:	fef42423          	sw	a5,-24(s0)
800027f0:	ff042623          	sw	a6,-20(s0)
800027f4:	0340006f          	j	80002828 <strlen+0x54>
800027f8:	fe842603          	lw	a2,-24(s0)
800027fc:	fec42683          	lw	a3,-20(s0)
80002800:	00100513          	li	a0,1
80002804:	00000593          	li	a1,0
80002808:	00a60733          	add	a4,a2,a0
8000280c:	00070813          	mv	a6,a4
80002810:	00c83833          	sltu	a6,a6,a2
80002814:	00b687b3          	add	a5,a3,a1
80002818:	00f806b3          	add	a3,a6,a5
8000281c:	00068793          	mv	a5,a3
80002820:	fee42423          	sw	a4,-24(s0)
80002824:	fef42623          	sw	a5,-20(s0)
80002828:	fe842783          	lw	a5,-24(s0)
8000282c:	fdc42703          	lw	a4,-36(s0)
80002830:	00f707b3          	add	a5,a4,a5
80002834:	0007c783          	lbu	a5,0(a5)
80002838:	fc0790e3          	bnez	a5,800027f8 <strlen+0x24>
        ;

    return n;
8000283c:	fe842703          	lw	a4,-24(s0)
80002840:	fec42783          	lw	a5,-20(s0)
80002844:	00070513          	mv	a0,a4
80002848:	00078593          	mv	a1,a5
8000284c:	02c12403          	lw	s0,44(sp)
80002850:	03010113          	addi	sp,sp,48
80002854:	00008067          	ret

80002858 <r_tp>:
{
80002858:	fe010113          	addi	sp,sp,-32
8000285c:	00812e23          	sw	s0,28(sp)
80002860:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80002864:	00020793          	mv	a5,tp
80002868:	fef42623          	sw	a5,-20(s0)
    return x;
8000286c:	fec42783          	lw	a5,-20(s0)
}
80002870:	00078513          	mv	a0,a5
80002874:	01c12403          	lw	s0,28(sp)
80002878:	02010113          	addi	sp,sp,32
8000287c:	00008067          	ret

80002880 <clintinit>:
 */
#include "clint.h"
#include "riscv.h"

void clintinit()
{
80002880:	fe010113          	addi	sp,sp,-32
80002884:	00112e23          	sw	ra,28(sp)
80002888:	00812c23          	sw	s0,24(sp)
8000288c:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp
    int hart = r_tp();
80002890:	fc9ff0ef          	jal	ra,80002858 <r_tp>
80002894:	00050793          	mv	a5,a0
80002898:	fef42623          	sw	a5,-20(s0)
    *(reg_t *)CLINT_MTIMECMP(hart) = *(reg_t *)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
8000289c:	fec42703          	lw	a4,-20(s0)
800028a0:	004017b7          	lui	a5,0x401
800028a4:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800028a8:	00f707b3          	add	a5,a4,a5
800028ac:	00379793          	slli	a5,a5,0x3
800028b0:	0007a703          	lw	a4,0(a5)
800028b4:	fec42683          	lw	a3,-20(s0)
800028b8:	004017b7          	lui	a5,0x401
800028bc:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800028c0:	00f687b3          	add	a5,a3,a5
800028c4:	00379793          	slli	a5,a5,0x3
800028c8:	00078693          	mv	a3,a5
800028cc:	009897b7          	lui	a5,0x989
800028d0:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
800028d4:	00f707b3          	add	a5,a4,a5
800028d8:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
800028dc:	00000013          	nop
800028e0:	01c12083          	lw	ra,28(sp)
800028e4:	01812403          	lw	s0,24(sp)
800028e8:	02010113          	addi	sp,sp,32
800028ec:	00008067          	ret

800028f0 <r_mstatus>:
{
800028f0:	fe010113          	addi	sp,sp,-32
800028f4:	00812e23          	sw	s0,28(sp)
800028f8:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus"
800028fc:	300027f3          	csrr	a5,mstatus
80002900:	fef42623          	sw	a5,-20(s0)
    return x;
80002904:	fec42783          	lw	a5,-20(s0)
}
80002908:	00078513          	mv	a0,a5
8000290c:	01c12403          	lw	s0,28(sp)
80002910:	02010113          	addi	sp,sp,32
80002914:	00008067          	ret

80002918 <w_mstatus>:
{
80002918:	fe010113          	addi	sp,sp,-32
8000291c:	00812e23          	sw	s0,28(sp)
80002920:	02010413          	addi	s0,sp,32
80002924:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0"
80002928:	fec42783          	lw	a5,-20(s0)
8000292c:	30079073          	csrw	mstatus,a5
}
80002930:	00000013          	nop
80002934:	01c12403          	lw	s0,28(sp)
80002938:	02010113          	addi	sp,sp,32
8000293c:	00008067          	ret

80002940 <w_mtvec>:
{
80002940:	fe010113          	addi	sp,sp,-32
80002944:	00812e23          	sw	s0,28(sp)
80002948:	02010413          	addi	s0,sp,32
8000294c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0"
80002950:	fec42783          	lw	a5,-20(s0)
80002954:	30579073          	csrw	mtvec,a5
}
80002958:	00000013          	nop
8000295c:	01c12403          	lw	s0,28(sp)
80002960:	02010113          	addi	sp,sp,32
80002964:	00008067          	ret

80002968 <r_tp>:
{
80002968:	fe010113          	addi	sp,sp,-32
8000296c:	00812e23          	sw	s0,28(sp)
80002970:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80002974:	00020793          	mv	a5,tp
80002978:	fef42623          	sw	a5,-20(s0)
    return x;
8000297c:	fec42783          	lw	a5,-20(s0)
}
80002980:	00078513          	mv	a0,a5
80002984:	01c12403          	lw	s0,28(sp)
80002988:	02010113          	addi	sp,sp,32
8000298c:	00008067          	ret

80002990 <s_mstatus_intr>:
{
80002990:	fd010113          	addi	sp,sp,-48
80002994:	02112623          	sw	ra,44(sp)
80002998:	02812423          	sw	s0,40(sp)
8000299c:	03010413          	addi	s0,sp,48
800029a0:	fca42e23          	sw	a0,-36(s0)
    uint32 x = r_mstatus();
800029a4:	f4dff0ef          	jal	ra,800028f0 <r_mstatus>
800029a8:	fea42623          	sw	a0,-20(s0)
    switch (m)
800029ac:	fdc42703          	lw	a4,-36(s0)
800029b0:	08000793          	li	a5,128
800029b4:	04f70263          	beq	a4,a5,800029f8 <s_mstatus_intr+0x68>
800029b8:	fdc42703          	lw	a4,-36(s0)
800029bc:	08000793          	li	a5,128
800029c0:	0ae7e463          	bltu	a5,a4,80002a68 <s_mstatus_intr+0xd8>
800029c4:	fdc42703          	lw	a4,-36(s0)
800029c8:	02000793          	li	a5,32
800029cc:	04f70463          	beq	a4,a5,80002a14 <s_mstatus_intr+0x84>
800029d0:	fdc42703          	lw	a4,-36(s0)
800029d4:	02000793          	li	a5,32
800029d8:	08e7e863          	bltu	a5,a4,80002a68 <s_mstatus_intr+0xd8>
800029dc:	fdc42703          	lw	a4,-36(s0)
800029e0:	00200793          	li	a5,2
800029e4:	06f70463          	beq	a4,a5,80002a4c <s_mstatus_intr+0xbc>
800029e8:	fdc42703          	lw	a4,-36(s0)
800029ec:	00800793          	li	a5,8
800029f0:	04f70063          	beq	a4,a5,80002a30 <s_mstatus_intr+0xa0>
        break;
800029f4:	0740006f          	j	80002a68 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
800029f8:	fec42783          	lw	a5,-20(s0)
800029fc:	f7f7f793          	andi	a5,a5,-129
80002a00:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
80002a04:	fec42783          	lw	a5,-20(s0)
80002a08:	0807e793          	ori	a5,a5,128
80002a0c:	fef42623          	sw	a5,-20(s0)
        break;
80002a10:	05c0006f          	j	80002a6c <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
80002a14:	fec42783          	lw	a5,-20(s0)
80002a18:	fdf7f793          	andi	a5,a5,-33
80002a1c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
80002a20:	fec42783          	lw	a5,-20(s0)
80002a24:	0207e793          	ori	a5,a5,32
80002a28:	fef42623          	sw	a5,-20(s0)
        break;
80002a2c:	0400006f          	j	80002a6c <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
80002a30:	fec42783          	lw	a5,-20(s0)
80002a34:	ff77f793          	andi	a5,a5,-9
80002a38:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80002a3c:	fec42783          	lw	a5,-20(s0)
80002a40:	0087e793          	ori	a5,a5,8
80002a44:	fef42623          	sw	a5,-20(s0)
        break;
80002a48:	0240006f          	j	80002a6c <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80002a4c:	fec42783          	lw	a5,-20(s0)
80002a50:	ffd7f793          	andi	a5,a5,-3
80002a54:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80002a58:	fec42783          	lw	a5,-20(s0)
80002a5c:	0027e793          	ori	a5,a5,2
80002a60:	fef42623          	sw	a5,-20(s0)
        break;
80002a64:	0080006f          	j	80002a6c <s_mstatus_intr+0xdc>
        break;
80002a68:	00000013          	nop
    w_mstatus(x);
80002a6c:	fec42503          	lw	a0,-20(s0)
80002a70:	ea9ff0ef          	jal	ra,80002918 <w_mstatus>
}
80002a74:	00000013          	nop
80002a78:	02c12083          	lw	ra,44(sp)
80002a7c:	02812403          	lw	s0,40(sp)
80002a80:	03010113          	addi	sp,sp,48
80002a84:	00008067          	ret

80002a88 <r_sie>:
{
80002a88:	fe010113          	addi	sp,sp,-32
80002a8c:	00812e23          	sw	s0,28(sp)
80002a90:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie "
80002a94:	104027f3          	csrr	a5,sie
80002a98:	fef42623          	sw	a5,-20(s0)
    return x;
80002a9c:	fec42783          	lw	a5,-20(s0)
}
80002aa0:	00078513          	mv	a0,a5
80002aa4:	01c12403          	lw	s0,28(sp)
80002aa8:	02010113          	addi	sp,sp,32
80002aac:	00008067          	ret

80002ab0 <w_sie>:
{
80002ab0:	fe010113          	addi	sp,sp,-32
80002ab4:	00812e23          	sw	s0,28(sp)
80002ab8:	02010413          	addi	s0,sp,32
80002abc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"
80002ac0:	fec42783          	lw	a5,-20(s0)
80002ac4:	10479073          	csrw	sie,a5
}
80002ac8:	00000013          	nop
80002acc:	01c12403          	lw	s0,28(sp)
80002ad0:	02010113          	addi	sp,sp,32
80002ad4:	00008067          	ret

80002ad8 <r_mie>:
#define MEIE (1 << 11)
#define MTIE (1 << 7)
#define MSIE (1 << 3)
static inline uint32 r_mie()
{
80002ad8:	fe010113          	addi	sp,sp,-32
80002adc:	00812e23          	sw	s0,28(sp)
80002ae0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie "
80002ae4:	304027f3          	csrr	a5,mie
80002ae8:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80002aec:	fec42783          	lw	a5,-20(s0)
}
80002af0:	00078513          	mv	a0,a5
80002af4:	01c12403          	lw	s0,28(sp)
80002af8:	02010113          	addi	sp,sp,32
80002afc:	00008067          	ret

80002b00 <w_mie>:
static inline void w_mie(uint32 x)
{
80002b00:	fe010113          	addi	sp,sp,-32
80002b04:	00812e23          	sw	s0,28(sp)
80002b08:	02010413          	addi	s0,sp,32
80002b0c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"
80002b10:	fec42783          	lw	a5,-20(s0)
80002b14:	30479073          	csrw	mie,a5
                 :
                 : "r"(x));
}
80002b18:	00000013          	nop
80002b1c:	01c12403          	lw	s0,28(sp)
80002b20:	02010113          	addi	sp,sp,32
80002b24:	00008067          	ret

80002b28 <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x)
{
80002b28:	fe010113          	addi	sp,sp,-32
80002b2c:	00812e23          	sw	s0,28(sp)
80002b30:	02010413          	addi	s0,sp,32
80002b34:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0"
80002b38:	fec42783          	lw	a5,-20(s0)
80002b3c:	34079073          	csrw	mscratch,a5
                 :
                 : "r"(x));
80002b40:	00000013          	nop
80002b44:	01c12403          	lw	s0,28(sp)
80002b48:	02010113          	addi	sp,sp,32
80002b4c:	00008067          	ret

80002b50 <timerinit>:
// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit()
{
80002b50:	fe010113          	addi	sp,sp,-32
80002b54:	00112e23          	sw	ra,28(sp)
80002b58:	00812c23          	sw	s0,24(sp)
80002b5c:	01212a23          	sw	s2,20(sp)
80002b60:	01312823          	sw	s3,16(sp)
80002b64:	02010413          	addi	s0,sp,32
    uint hart = r_tp();
80002b68:	e01ff0ef          	jal	ra,80002968 <r_tp>
80002b6c:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
80002b70:	fec42703          	lw	a4,-20(s0)
80002b74:	00070793          	mv	a5,a4
80002b78:	00279793          	slli	a5,a5,0x2
80002b7c:	00e787b3          	add	a5,a5,a4
80002b80:	00379793          	slli	a5,a5,0x3
80002b84:	8000f737          	lui	a4,0x8000f
80002b88:	a5070713          	addi	a4,a4,-1456 # 8000ea50 <memend+0xf800ea50>
80002b8c:	00e787b3          	add	a5,a5,a4
80002b90:	00078513          	mv	a0,a5
80002b94:	f95ff0ef          	jal	ra,80002b28 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0] = CLINT_MTIMECMP(hart);
80002b98:	fec42703          	lw	a4,-20(s0)
80002b9c:	004017b7          	lui	a5,0x401
80002ba0:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002ba4:	00f707b3          	add	a5,a4,a5
80002ba8:	00379793          	slli	a5,a5,0x3
80002bac:	00078913          	mv	s2,a5
80002bb0:	00000993          	li	s3,0
80002bb4:	8000f7b7          	lui	a5,0x8000f
80002bb8:	a5078693          	addi	a3,a5,-1456 # 8000ea50 <memend+0xf800ea50>
80002bbc:	fec42703          	lw	a4,-20(s0)
80002bc0:	00070793          	mv	a5,a4
80002bc4:	00279793          	slli	a5,a5,0x2
80002bc8:	00e787b3          	add	a5,a5,a4
80002bcc:	00379793          	slli	a5,a5,0x3
80002bd0:	00f687b3          	add	a5,a3,a5
80002bd4:	0127a023          	sw	s2,0(a5)
80002bd8:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1] = CLINT_INTERVAL;
80002bdc:	8000f7b7          	lui	a5,0x8000f
80002be0:	a5078693          	addi	a3,a5,-1456 # 8000ea50 <memend+0xf800ea50>
80002be4:	fec42703          	lw	a4,-20(s0)
80002be8:	00070793          	mv	a5,a4
80002bec:	00279793          	slli	a5,a5,0x2
80002bf0:	00e787b3          	add	a5,a5,a4
80002bf4:	00379793          	slli	a5,a5,0x3
80002bf8:	00f686b3          	add	a3,a3,a5
80002bfc:	00989737          	lui	a4,0x989
80002c00:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002c04:	00000793          	li	a5,0
80002c08:	00e6a423          	sw	a4,8(a3)
80002c0c:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec); // 设置 M-mode time trap处理函数
80002c10:	800007b7          	lui	a5,0x80000
80002c14:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
80002c18:	00078513          	mv	a0,a5
80002c1c:	d25ff0ef          	jal	ra,80002940 <w_mtvec>

    s_mstatus_intr(INTR_MIE); // 开启 M-mode 全局中断
80002c20:	00800513          	li	a0,8
80002c24:	d6dff0ef          	jal	ra,80002990 <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
80002c28:	e61ff0ef          	jal	ra,80002a88 <r_sie>
80002c2c:	00050793          	mv	a5,a0
80002c30:	2227e793          	ori	a5,a5,546
80002c34:	00078513          	mv	a0,a5
80002c38:	e79ff0ef          	jal	ra,80002ab0 <w_sie>

    w_mie(r_mie() | MTIE); // 开启 M-mode 时钟中断
80002c3c:	e9dff0ef          	jal	ra,80002ad8 <r_mie>
80002c40:	00050793          	mv	a5,a0
80002c44:	0807e793          	ori	a5,a5,128
80002c48:	00078513          	mv	a0,a5
80002c4c:	eb5ff0ef          	jal	ra,80002b00 <w_mie>

    clintinit(); // 初始化 CLINT
80002c50:	c31ff0ef          	jal	ra,80002880 <clintinit>
80002c54:	00000013          	nop
80002c58:	01c12083          	lw	ra,28(sp)
80002c5c:	01812403          	lw	s0,24(sp)
80002c60:	01412903          	lw	s2,20(sp)
80002c64:	01012983          	lw	s3,16(sp)
80002c68:	02010113          	addi	sp,sp,32
80002c6c:	00008067          	ret

80002c70 <r_sepc>:
{
80002c70:	fe010113          	addi	sp,sp,-32
80002c74:	00812e23          	sw	s0,28(sp)
80002c78:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, sepc"
80002c7c:	141027f3          	csrr	a5,sepc
80002c80:	fef42623          	sw	a5,-20(s0)
    return x;
80002c84:	fec42783          	lw	a5,-20(s0)
}
80002c88:	00078513          	mv	a0,a5
80002c8c:	01c12403          	lw	s0,28(sp)
80002c90:	02010113          	addi	sp,sp,32
80002c94:	00008067          	ret

80002c98 <syscall>:
    [SYS_fork] sys_fork,
    [SYS_exec] sys_exec,
};

void syscall()
{
80002c98:	fe010113          	addi	sp,sp,-32
80002c9c:	00112e23          	sw	ra,28(sp)
80002ca0:	00812c23          	sw	s0,24(sp)
80002ca4:	00912a23          	sw	s1,20(sp)
80002ca8:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002cac:	c44ff0ef          	jal	ra,800020f0 <nowproc>
80002cb0:	fea42623          	sw	a0,-20(s0)
    p->trapframe->epc = r_sepc();
80002cb4:	fec42783          	lw	a5,-20(s0)
80002cb8:	0087a483          	lw	s1,8(a5)
80002cbc:	fb5ff0ef          	jal	ra,80002c70 <r_sepc>
80002cc0:	00050793          	mv	a5,a0
80002cc4:	00f4a623          	sw	a5,12(s1)
    p->trapframe->epc += 4;
80002cc8:	fec42783          	lw	a5,-20(s0)
80002ccc:	0087a783          	lw	a5,8(a5)
80002cd0:	00c7a703          	lw	a4,12(a5)
80002cd4:	fec42783          	lw	a5,-20(s0)
80002cd8:	0087a783          	lw	a5,8(a5)
80002cdc:	00470713          	addi	a4,a4,4
80002ce0:	00e7a623          	sw	a4,12(a5)

    uint32 sysnum = p->trapframe->a7;
80002ce4:	fec42783          	lw	a5,-20(s0)
80002ce8:	0087a783          	lw	a5,8(a5)
80002cec:	03c7a783          	lw	a5,60(a5)
80002cf0:	fef42423          	sw	a5,-24(s0)
    p->trapframe->a0 = syscalls[sysnum]();
80002cf4:	8000c7b7          	lui	a5,0x8000c
80002cf8:	01878713          	addi	a4,a5,24 # 8000c018 <memend+0xf800c018>
80002cfc:	fe842783          	lw	a5,-24(s0)
80002d00:	00279793          	slli	a5,a5,0x2
80002d04:	00f707b3          	add	a5,a4,a5
80002d08:	0007a703          	lw	a4,0(a5)
80002d0c:	fec42783          	lw	a5,-20(s0)
80002d10:	0087a483          	lw	s1,8(a5)
80002d14:	000700e7          	jalr	a4
80002d18:	00050793          	mv	a5,a0
80002d1c:	02f4a023          	sw	a5,32(s1)
80002d20:	00000013          	nop
80002d24:	01c12083          	lw	ra,28(sp)
80002d28:	01812403          	lw	s0,24(sp)
80002d2c:	01412483          	lw	s1,20(sp)
80002d30:	02010113          	addi	sp,sp,32
80002d34:	00008067          	ret

80002d38 <mmioinit>:
    } info[DNUM];

} __attribute__((aligned(PGSIZE))) disk;

void mmioinit()
{
80002d38:	fe010113          	addi	sp,sp,-32
80002d3c:	00112e23          	sw	ra,28(sp)
80002d40:	00812c23          	sw	s0,24(sp)
80002d44:	02010413          	addi	s0,sp,32
#ifdef DEBUG
    printf("mmio_magicvalue: %x\n", mmio_read(MMIO_MagicValue));
80002d48:	100017b7          	lui	a5,0x10001
80002d4c:	0007a783          	lw	a5,0(a5) # 10001000 <sz+0x10000000>
80002d50:	00078593          	mv	a1,a5
80002d54:	8000d7b7          	lui	a5,0x8000d
80002d58:	57478513          	addi	a0,a5,1396 # 8000d574 <memend+0xf800d574>
80002d5c:	ce0fe0ef          	jal	ra,8000123c <printf>
    printf("mmio_version: %x\n", mmio_read(MMIO_Version));
80002d60:	100017b7          	lui	a5,0x10001
80002d64:	00478793          	addi	a5,a5,4 # 10001004 <sz+0x10000004>
80002d68:	0007a783          	lw	a5,0(a5)
80002d6c:	00078593          	mv	a1,a5
80002d70:	8000d7b7          	lui	a5,0x8000d
80002d74:	58c78513          	addi	a0,a5,1420 # 8000d58c <memend+0xf800d58c>
80002d78:	cc4fe0ef          	jal	ra,8000123c <printf>
    printf("mmio_vendorID: %x\n", mmio_read(MMIO_VendorID));
80002d7c:	100017b7          	lui	a5,0x10001
80002d80:	00c78793          	addi	a5,a5,12 # 1000100c <sz+0x1000000c>
80002d84:	0007a783          	lw	a5,0(a5)
80002d88:	00078593          	mv	a1,a5
80002d8c:	8000d7b7          	lui	a5,0x8000d
80002d90:	5a078513          	addi	a0,a5,1440 # 8000d5a0 <memend+0xf800d5a0>
80002d94:	ca8fe0ef          	jal	ra,8000123c <printf>
    printf("mmio_deviceID: %x\n", mmio_read(MMIO_DeviceID));
80002d98:	100017b7          	lui	a5,0x10001
80002d9c:	00878793          	addi	a5,a5,8 # 10001008 <sz+0x10000008>
80002da0:	0007a783          	lw	a5,0(a5)
80002da4:	00078593          	mv	a1,a5
80002da8:	8000d7b7          	lui	a5,0x8000d
80002dac:	5b478513          	addi	a0,a5,1460 # 8000d5b4 <memend+0xf800d5b4>
80002db0:	c8cfe0ef          	jal	ra,8000123c <printf>
    printf("mmio_disk.pages: %x\n", &disk);
80002db4:	8000f7b7          	lui	a5,0x8000f
80002db8:	00078593          	mv	a1,a5
80002dbc:	8000d7b7          	lui	a5,0x8000d
80002dc0:	5c878513          	addi	a0,a5,1480 # 8000d5c8 <memend+0xf800d5c8>
80002dc4:	c78fe0ef          	jal	ra,8000123c <printf>
#endif

    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
80002dc8:	100017b7          	lui	a5,0x10001
80002dcc:	0007a703          	lw	a4,0(a5) # 10001000 <sz+0x10000000>
80002dd0:	747277b7          	lui	a5,0x74727
80002dd4:	97678793          	addi	a5,a5,-1674 # 74726976 <sz+0x74725976>
80002dd8:	04f71263          	bne	a4,a5,80002e1c <mmioinit+0xe4>
        mmio_read(MMIO_Version) != 0x01 ||
80002ddc:	100017b7          	lui	a5,0x10001
80002de0:	00478793          	addi	a5,a5,4 # 10001004 <sz+0x10000004>
80002de4:	0007a703          	lw	a4,0(a5)
    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
80002de8:	00100793          	li	a5,1
80002dec:	02f71863          	bne	a4,a5,80002e1c <mmioinit+0xe4>
        mmio_read(MMIO_DeviceID) != 0x02 ||
80002df0:	100017b7          	lui	a5,0x10001
80002df4:	00878793          	addi	a5,a5,8 # 10001008 <sz+0x10000008>
80002df8:	0007a703          	lw	a4,0(a5)
        mmio_read(MMIO_Version) != 0x01 ||
80002dfc:	00200793          	li	a5,2
80002e00:	00f71e63          	bne	a4,a5,80002e1c <mmioinit+0xe4>
        mmio_read(MMIO_VendorID) != 0x554d4551)
80002e04:	100017b7          	lui	a5,0x10001
80002e08:	00c78793          	addi	a5,a5,12 # 1000100c <sz+0x1000000c>
80002e0c:	0007a703          	lw	a4,0(a5)
        mmio_read(MMIO_DeviceID) != 0x02 ||
80002e10:	554d47b7          	lui	a5,0x554d4
80002e14:	55178793          	addi	a5,a5,1361 # 554d4551 <sz+0x554d3551>
80002e18:	00f70863          	beq	a4,a5,80002e28 <mmioinit+0xf0>
    {
        panic("virtio mmio disk!");
80002e1c:	8000d7b7          	lui	a5,0x8000d
80002e20:	5e078513          	addi	a0,a5,1504 # 8000d5e0 <memend+0xf800d5e0>
80002e24:	be0fe0ef          	jal	ra,80001204 <panic>
    }

    uint32 status = 0;
80002e28:	fe042423          	sw	zero,-24(s0)
    status |= MMIO_STATUS_ACKNOWLEDGE; // 表明当前已经识别到了设备
80002e2c:	fe842783          	lw	a5,-24(s0)
80002e30:	0017e793          	ori	a5,a5,1
80002e34:	fef42423          	sw	a5,-24(s0)
    mmio_write(MMIO_Status, status);
80002e38:	100017b7          	lui	a5,0x10001
80002e3c:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002e40:	fe842703          	lw	a4,-24(s0)
80002e44:	00e7a023          	sw	a4,0(a5)

    status |= MMIO_STATUS_DRIVER; // 表明驱动程序知道如何驱动当前设备
80002e48:	fe842783          	lw	a5,-24(s0)
80002e4c:	0027e793          	ori	a5,a5,2
80002e50:	fef42423          	sw	a5,-24(s0)
    mmio_write(MMIO_Status, status);
80002e54:	100017b7          	lui	a5,0x10001
80002e58:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002e5c:	fe842703          	lw	a4,-24(s0)
80002e60:	00e7a023          	sw	a4,0(a5)

    uint32 features = mmio_read(MMIO_DeviceFeatures);
80002e64:	100017b7          	lui	a5,0x10001
80002e68:	01078793          	addi	a5,a5,16 # 10001010 <sz+0x10000010>
80002e6c:	0007a783          	lw	a5,0(a5)
80002e70:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_RO);   // 不支持只读
80002e74:	fe442783          	lw	a5,-28(s0)
80002e78:	fdf7f793          	andi	a5,a5,-33
80002e7c:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_SCSI); // 不支持 SCSI
80002e80:	fe442783          	lw	a5,-28(s0)
80002e84:	f7f7f793          	andi	a5,a5,-129
80002e88:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_CONFIG_WCE);
80002e8c:	fe442703          	lw	a4,-28(s0)
80002e90:	fffff7b7          	lui	a5,0xfffff
80002e94:	7ff78793          	addi	a5,a5,2047 # fffff7ff <memend+0x77fff7ff>
80002e98:	00f777b3          	and	a5,a4,a5
80002e9c:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_MQ);
80002ea0:	fe442703          	lw	a4,-28(s0)
80002ea4:	fffff7b7          	lui	a5,0xfffff
80002ea8:	fff78793          	addi	a5,a5,-1 # ffffefff <memend+0x77ffefff>
80002eac:	00f777b3          	and	a5,a4,a5
80002eb0:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_ANY_LAYOUT);
80002eb4:	fe442703          	lw	a4,-28(s0)
80002eb8:	f80007b7          	lui	a5,0xf8000
80002ebc:	fff78793          	addi	a5,a5,-1 # f7ffffff <memend+0x6fffffff>
80002ec0:	00f777b3          	and	a5,a4,a5
80002ec4:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_RING_FEATURES_INDIRECT_DESC);
80002ec8:	fe442703          	lw	a4,-28(s0)
80002ecc:	f00007b7          	lui	a5,0xf0000
80002ed0:	fff78793          	addi	a5,a5,-1 # efffffff <memend+0x67ffffff>
80002ed4:	00f777b3          	and	a5,a4,a5
80002ed8:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_RING_FEATURES_EVENT_IDX);
80002edc:	fe442703          	lw	a4,-28(s0)
80002ee0:	e00007b7          	lui	a5,0xe0000
80002ee4:	fff78793          	addi	a5,a5,-1 # dfffffff <memend+0x57ffffff>
80002ee8:	00f777b3          	and	a5,a4,a5
80002eec:	fef42223          	sw	a5,-28(s0)
    mmio_write(MMIO_DeviceFeatures, features);
80002ef0:	100017b7          	lui	a5,0x10001
80002ef4:	01078793          	addi	a5,a5,16 # 10001010 <sz+0x10000010>
80002ef8:	fe442703          	lw	a4,-28(s0)
80002efc:	00e7a023          	sw	a4,0(a5)

    status |= MMIO_STATUS_FEATURES_OK; // 特征设置成功
80002f00:	fe842783          	lw	a5,-24(s0)
80002f04:	0087e793          	ori	a5,a5,8
80002f08:	fef42423          	sw	a5,-24(s0)
    mmio_write(MMIO_Status, status);
80002f0c:	100017b7          	lui	a5,0x10001
80002f10:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002f14:	fe842703          	lw	a4,-24(s0)
80002f18:	00e7a023          	sw	a4,0(a5)

    status |= MMIO_STATUS_DRIVER_OK; // 驱动准备完毕
80002f1c:	fe842783          	lw	a5,-24(s0)
80002f20:	0047e793          	ori	a5,a5,4
80002f24:	fef42423          	sw	a5,-24(s0)
    mmio_write(MMIO_Status, status);
80002f28:	100017b7          	lui	a5,0x10001
80002f2c:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002f30:	fe842703          	lw	a4,-24(s0)
80002f34:	00e7a023          	sw	a4,0(a5)

    mmio_write(MMIO_GusetPAGESIZE, PGSIZE);
80002f38:	100017b7          	lui	a5,0x10001
80002f3c:	02878793          	addi	a5,a5,40 # 10001028 <sz+0x10000028>
80002f40:	00001737          	lui	a4,0x1
80002f44:	00e7a023          	sw	a4,0(a5)

    mmio_write(MMIO_QueueSel, 0);
80002f48:	100017b7          	lui	a5,0x10001
80002f4c:	03078793          	addi	a5,a5,48 # 10001030 <sz+0x10000030>
80002f50:	0007a023          	sw	zero,0(a5)
    if (mmio_read(MMIO_QueueNumMax) < DNUM)
80002f54:	100017b7          	lui	a5,0x10001
80002f58:	03478793          	addi	a5,a5,52 # 10001034 <sz+0x10000034>
80002f5c:	0007a703          	lw	a4,0(a5)
80002f60:	00700793          	li	a5,7
80002f64:	00e7e863          	bltu	a5,a4,80002f74 <mmioinit+0x23c>
        panic("mmio : QueueNumMax");
80002f68:	8000d7b7          	lui	a5,0x8000d
80002f6c:	5f478513          	addi	a0,a5,1524 # 8000d5f4 <memend+0xf800d5f4>
80002f70:	a94fe0ef          	jal	ra,80001204 <panic>
    mmio_write(MMIO_QueueNum, DNUM); // 设置队列大小
80002f74:	100017b7          	lui	a5,0x10001
80002f78:	03878793          	addi	a5,a5,56 # 10001038 <sz+0x10000038>
80002f7c:	00800713          	li	a4,8
80002f80:	00e7a023          	sw	a4,0(a5)

    memset(disk.pages, 0, sizeof(disk.pages));
80002f84:	00002637          	lui	a2,0x2
80002f88:	00000593          	li	a1,0
80002f8c:	8000f7b7          	lui	a5,0x8000f
80002f90:	00078513          	mv	a0,a5
80002f94:	e74ff0ef          	jal	ra,80002608 <memset>
    mmio_write(MMIO_QueuePFN, ((uint32)disk.pages) >> 12);
80002f98:	8000f7b7          	lui	a5,0x8000f
80002f9c:	00078713          	mv	a4,a5
80002fa0:	100017b7          	lui	a5,0x10001
80002fa4:	04078793          	addi	a5,a5,64 # 10001040 <sz+0x10000040>
80002fa8:	00c75713          	srli	a4,a4,0xc
80002fac:	00e7a023          	sw	a4,0(a5)

    disk.desc = (struct virtq_desc *)disk.pages;
80002fb0:	8000f7b7          	lui	a5,0x8000f
80002fb4:	00078713          	mv	a4,a5
80002fb8:	000027b7          	lui	a5,0x2
80002fbc:	00f707b3          	add	a5,a4,a5
80002fc0:	8000f737          	lui	a4,0x8000f
80002fc4:	00070713          	mv	a4,a4
80002fc8:	00e7a023          	sw	a4,0(a5) # 2000 <sz+0x1000>
    disk.avail = (struct virtq_avail *)(disk.pages + DNUM * sizeof(struct virtq_desc));
80002fcc:	8000f7b7          	lui	a5,0x8000f
80002fd0:	08078713          	addi	a4,a5,128 # 8000f080 <memend+0xf800f080>
80002fd4:	8000f7b7          	lui	a5,0x8000f
80002fd8:	00078693          	mv	a3,a5
80002fdc:	000027b7          	lui	a5,0x2
80002fe0:	00f687b3          	add	a5,a3,a5
80002fe4:	00e7a223          	sw	a4,4(a5) # 2004 <sz+0x1004>
    disk.used = (struct virtq_used *)(disk.pages + PGSIZE);
80002fe8:	800107b7          	lui	a5,0x80010
80002fec:	00078713          	mv	a4,a5
80002ff0:	8000f7b7          	lui	a5,0x8000f
80002ff4:	00078693          	mv	a3,a5
80002ff8:	000027b7          	lui	a5,0x2
80002ffc:	00f687b3          	add	a5,a3,a5
80003000:	00e7a423          	sw	a4,8(a5) # 2008 <sz+0x1008>

    for (int i = 0; i < DNUM; i++)
80003004:	fe042623          	sw	zero,-20(s0)
80003008:	0300006f          	j	80003038 <mmioinit+0x300>
        disk.free[i] = 1;
8000300c:	8000f7b7          	lui	a5,0x8000f
80003010:	00078713          	mv	a4,a5
80003014:	fec42783          	lw	a5,-20(s0)
80003018:	00f707b3          	add	a5,a4,a5
8000301c:	00002737          	lui	a4,0x2
80003020:	00f707b3          	add	a5,a4,a5
80003024:	00100713          	li	a4,1
80003028:	08e78823          	sb	a4,144(a5) # 8000f090 <memend+0xf800f090>
    for (int i = 0; i < DNUM; i++)
8000302c:	fec42783          	lw	a5,-20(s0)
80003030:	00178793          	addi	a5,a5,1
80003034:	fef42623          	sw	a5,-20(s0)
80003038:	fec42703          	lw	a4,-20(s0)
8000303c:	00700793          	li	a5,7
80003040:	fce7d6e3          	bge	a5,a4,8000300c <mmioinit+0x2d4>

#ifdef DEBUG
    printf("mmio_disk.pages: %x\n", disk.desc);
80003044:	8000f7b7          	lui	a5,0x8000f
80003048:	00078713          	mv	a4,a5
8000304c:	000027b7          	lui	a5,0x2
80003050:	00f707b3          	add	a5,a4,a5
80003054:	0007a783          	lw	a5,0(a5) # 2000 <sz+0x1000>
80003058:	00078593          	mv	a1,a5
8000305c:	8000d7b7          	lui	a5,0x8000d
80003060:	5c878513          	addi	a0,a5,1480 # 8000d5c8 <memend+0xf800d5c8>
80003064:	9d8fe0ef          	jal	ra,8000123c <printf>
    printf("mmio_disk.pages: %x\n", disk.avail);
80003068:	8000f7b7          	lui	a5,0x8000f
8000306c:	00078713          	mv	a4,a5
80003070:	000027b7          	lui	a5,0x2
80003074:	00f707b3          	add	a5,a4,a5
80003078:	0047a783          	lw	a5,4(a5) # 2004 <sz+0x1004>
8000307c:	00078593          	mv	a1,a5
80003080:	8000d7b7          	lui	a5,0x8000d
80003084:	5c878513          	addi	a0,a5,1480 # 8000d5c8 <memend+0xf800d5c8>
80003088:	9b4fe0ef          	jal	ra,8000123c <printf>
    printf("mmio_disk.pages: %x\n", disk.used);
8000308c:	8000f7b7          	lui	a5,0x8000f
80003090:	00078713          	mv	a4,a5
80003094:	000027b7          	lui	a5,0x2
80003098:	00f707b3          	add	a5,a4,a5
8000309c:	0087a783          	lw	a5,8(a5) # 2008 <sz+0x1008>
800030a0:	00078593          	mv	a1,a5
800030a4:	8000d7b7          	lui	a5,0x8000d
800030a8:	5c878513          	addi	a0,a5,1480 # 8000d5c8 <memend+0xf800d5c8>
800030ac:	990fe0ef          	jal	ra,8000123c <printf>
#endif
}
800030b0:	00000013          	nop
800030b4:	01c12083          	lw	ra,28(sp)
800030b8:	01812403          	lw	s0,24(sp)
800030bc:	02010113          	addi	sp,sp,32
800030c0:	00008067          	ret

800030c4 <alloc_desc>:

uint8 alloc_desc()
{
800030c4:	fe010113          	addi	sp,sp,-32
800030c8:	00812e23          	sw	s0,28(sp)
800030cc:	02010413          	addi	s0,sp,32
    for (int i = 0; i < DNUM; i++)
800030d0:	fe042623          	sw	zero,-20(s0)
800030d4:	0580006f          	j	8000312c <alloc_desc+0x68>
        if (disk.free[i])
800030d8:	8000f7b7          	lui	a5,0x8000f
800030dc:	00078713          	mv	a4,a5
800030e0:	fec42783          	lw	a5,-20(s0)
800030e4:	00f707b3          	add	a5,a4,a5
800030e8:	00002737          	lui	a4,0x2
800030ec:	00f707b3          	add	a5,a4,a5
800030f0:	0907c783          	lbu	a5,144(a5) # 8000f090 <memend+0xf800f090>
800030f4:	02078663          	beqz	a5,80003120 <alloc_desc+0x5c>
        {
            disk.free[i] = 0;
800030f8:	8000f7b7          	lui	a5,0x8000f
800030fc:	00078713          	mv	a4,a5
80003100:	fec42783          	lw	a5,-20(s0)
80003104:	00f707b3          	add	a5,a4,a5
80003108:	00002737          	lui	a4,0x2
8000310c:	00f707b3          	add	a5,a4,a5
80003110:	08078823          	sb	zero,144(a5) # 8000f090 <memend+0xf800f090>
            return i;
80003114:	fec42783          	lw	a5,-20(s0)
80003118:	0ff7f793          	andi	a5,a5,255
8000311c:	0200006f          	j	8000313c <alloc_desc+0x78>
    for (int i = 0; i < DNUM; i++)
80003120:	fec42783          	lw	a5,-20(s0)
80003124:	00178793          	addi	a5,a5,1
80003128:	fef42623          	sw	a5,-20(s0)
8000312c:	fec42703          	lw	a4,-20(s0)
80003130:	00700793          	li	a5,7
80003134:	fae7d2e3          	bge	a5,a4,800030d8 <alloc_desc+0x14>
        }
    return -1;
80003138:	0ff00793          	li	a5,255
}
8000313c:	00078513          	mv	a0,a5
80003140:	01c12403          	lw	s0,28(sp)
80003144:	02010113          	addi	sp,sp,32
80003148:	00008067          	ret

8000314c <alloc3_desc>:

uint8 alloc3_desc(int idx[])
{
8000314c:	fd010113          	addi	sp,sp,-48
80003150:	02112623          	sw	ra,44(sp)
80003154:	02812423          	sw	s0,40(sp)
80003158:	03010413          	addi	s0,sp,48
8000315c:	fca42e23          	sw	a0,-36(s0)
    for (int i = 0; i < 3; i++)
80003160:	fe042623          	sw	zero,-20(s0)
80003164:	0540006f          	j	800031b8 <alloc3_desc+0x6c>
    {
        idx[i] = alloc_desc();
80003168:	f5dff0ef          	jal	ra,800030c4 <alloc_desc>
8000316c:	00050793          	mv	a5,a0
80003170:	00078693          	mv	a3,a5
80003174:	fec42783          	lw	a5,-20(s0)
80003178:	00279793          	slli	a5,a5,0x2
8000317c:	fdc42703          	lw	a4,-36(s0)
80003180:	00f707b3          	add	a5,a4,a5
80003184:	00068713          	mv	a4,a3
80003188:	00e7a023          	sw	a4,0(a5)
        if (idx[i] < 0)
8000318c:	fec42783          	lw	a5,-20(s0)
80003190:	00279793          	slli	a5,a5,0x2
80003194:	fdc42703          	lw	a4,-36(s0)
80003198:	00f707b3          	add	a5,a4,a5
8000319c:	0007a783          	lw	a5,0(a5)
800031a0:	0007d663          	bgez	a5,800031ac <alloc3_desc+0x60>
            return -1;
800031a4:	0ff00793          	li	a5,255
800031a8:	0200006f          	j	800031c8 <alloc3_desc+0x7c>
    for (int i = 0; i < 3; i++)
800031ac:	fec42783          	lw	a5,-20(s0)
800031b0:	00178793          	addi	a5,a5,1
800031b4:	fef42623          	sw	a5,-20(s0)
800031b8:	fec42703          	lw	a4,-20(s0)
800031bc:	00200793          	li	a5,2
800031c0:	fae7d4e3          	bge	a5,a4,80003168 <alloc3_desc+0x1c>
    }
    return 0;
800031c4:	00000793          	li	a5,0
}
800031c8:	00078513          	mv	a0,a5
800031cc:	02c12083          	lw	ra,44(sp)
800031d0:	02812403          	lw	s0,40(sp)
800031d4:	03010113          	addi	sp,sp,48
800031d8:	00008067          	ret

800031dc <diskrw>:

void diskrw(uint32 sector, uint8 rw, char *b)
{
800031dc:	fa010113          	addi	sp,sp,-96
800031e0:	04112e23          	sw	ra,92(sp)
800031e4:	04812c23          	sw	s0,88(sp)
800031e8:	05212a23          	sw	s2,84(sp)
800031ec:	05312823          	sw	s3,80(sp)
800031f0:	05412623          	sw	s4,76(sp)
800031f4:	05512423          	sw	s5,72(sp)
800031f8:	05612223          	sw	s6,68(sp)
800031fc:	05712023          	sw	s7,64(sp)
80003200:	03812e23          	sw	s8,60(sp)
80003204:	03912c23          	sw	s9,56(sp)
80003208:	06010413          	addi	s0,sp,96
8000320c:	faa42623          	sw	a0,-84(s0)
80003210:	00058793          	mv	a5,a1
80003214:	fac42223          	sw	a2,-92(s0)
80003218:	faf405a3          	sb	a5,-85(s0)
    int idx[3];
    alloc3_desc(idx);
8000321c:	fbc40793          	addi	a5,s0,-68
80003220:	00078513          	mv	a0,a5
80003224:	f29ff0ef          	jal	ra,8000314c <alloc3_desc>

#ifdef DEBUG
    printf("disk.desc[3]: ");
80003228:	8000d7b7          	lui	a5,0x8000d
8000322c:	60878513          	addi	a0,a5,1544 # 8000d608 <memend+0xf800d608>
80003230:	80cfe0ef          	jal	ra,8000123c <printf>
    for (int i = 0; i < 3; i++)
80003234:	fc042623          	sw	zero,-52(s0)
80003238:	0340006f          	j	8000326c <diskrw+0x90>
        printf("%d ", idx[i]);
8000323c:	fcc42783          	lw	a5,-52(s0)
80003240:	00279793          	slli	a5,a5,0x2
80003244:	fd040713          	addi	a4,s0,-48
80003248:	00f707b3          	add	a5,a4,a5
8000324c:	fec7a783          	lw	a5,-20(a5)
80003250:	00078593          	mv	a1,a5
80003254:	8000d7b7          	lui	a5,0x8000d
80003258:	61878513          	addi	a0,a5,1560 # 8000d618 <memend+0xf800d618>
8000325c:	fe1fd0ef          	jal	ra,8000123c <printf>
    for (int i = 0; i < 3; i++)
80003260:	fcc42783          	lw	a5,-52(s0)
80003264:	00178793          	addi	a5,a5,1
80003268:	fcf42623          	sw	a5,-52(s0)
8000326c:	fcc42703          	lw	a4,-52(s0)
80003270:	00200793          	li	a5,2
80003274:	fce7d4e3          	bge	a5,a4,8000323c <diskrw+0x60>
    printf("\n");
80003278:	8000d7b7          	lui	a5,0x8000d
8000327c:	61c78513          	addi	a0,a5,1564 # 8000d61c <memend+0xf800d61c>
80003280:	fbdfd0ef          	jal	ra,8000123c <printf>
#endif

    struct virtio_blk_req *buf = &disk.req[idx[0]];
80003284:	fbc42783          	lw	a5,-68(s0)
80003288:	20078793          	addi	a5,a5,512
8000328c:	00479713          	slli	a4,a5,0x4
80003290:	8000f7b7          	lui	a5,0x8000f
80003294:	00078793          	mv	a5,a5
80003298:	00f707b3          	add	a5,a4,a5
8000329c:	01078793          	addi	a5,a5,16 # 8000f010 <memend+0xf800f010>
800032a0:	fcf42423          	sw	a5,-56(s0)

    if (rw)
800032a4:	fab44783          	lbu	a5,-85(s0)
800032a8:	00078a63          	beqz	a5,800032bc <diskrw+0xe0>
        buf->type = VIRTIO_BLK_T_OUT; // 写磁盘
800032ac:	fc842783          	lw	a5,-56(s0)
800032b0:	00100713          	li	a4,1
800032b4:	00e7a023          	sw	a4,0(a5)
800032b8:	00c0006f          	j	800032c4 <diskrw+0xe8>
    else
        buf->type = VIRTIO_BLK_T_IN; // 读磁盘
800032bc:	fc842783          	lw	a5,-56(s0)
800032c0:	0007a023          	sw	zero,0(a5)
    buf->reserved = 0;
800032c4:	fc842783          	lw	a5,-56(s0)
800032c8:	0007a223          	sw	zero,4(a5)
    buf->sector = sector;
800032cc:	fac42783          	lw	a5,-84(s0)
800032d0:	00078c13          	mv	s8,a5
800032d4:	00000c93          	li	s9,0
800032d8:	fc842783          	lw	a5,-56(s0)
800032dc:	0187a423          	sw	s8,8(a5)
800032e0:	0197a623          	sw	s9,12(a5)

    disk.desc[idx[0]].addr = (uint32)buf;
800032e4:	fc842683          	lw	a3,-56(s0)
800032e8:	8000f7b7          	lui	a5,0x8000f
800032ec:	00078713          	mv	a4,a5
800032f0:	000027b7          	lui	a5,0x2
800032f4:	00f707b3          	add	a5,a4,a5
800032f8:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
800032fc:	fbc42783          	lw	a5,-68(s0)
80003300:	00479793          	slli	a5,a5,0x4
80003304:	00f707b3          	add	a5,a4,a5
80003308:	00068b13          	mv	s6,a3
8000330c:	00000b93          	li	s7,0
80003310:	0167a023          	sw	s6,0(a5)
80003314:	0177a223          	sw	s7,4(a5)
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
80003318:	8000f7b7          	lui	a5,0x8000f
8000331c:	00078713          	mv	a4,a5
80003320:	000027b7          	lui	a5,0x2
80003324:	00f707b3          	add	a5,a4,a5
80003328:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
8000332c:	fbc42783          	lw	a5,-68(s0)
80003330:	00479793          	slli	a5,a5,0x4
80003334:	00f707b3          	add	a5,a4,a5
80003338:	01000713          	li	a4,16
8000333c:	00e7a423          	sw	a4,8(a5)
    disk.desc[idx[0]].flags = VIRTQ_DESC_F_NEXT;
80003340:	8000f7b7          	lui	a5,0x8000f
80003344:	00078713          	mv	a4,a5
80003348:	000027b7          	lui	a5,0x2
8000334c:	00f707b3          	add	a5,a4,a5
80003350:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
80003354:	fbc42783          	lw	a5,-68(s0)
80003358:	00479793          	slli	a5,a5,0x4
8000335c:	00f707b3          	add	a5,a4,a5
80003360:	00100713          	li	a4,1
80003364:	00e79623          	sh	a4,12(a5)
    disk.desc[idx[0]].next = idx[1];
80003368:	fc042683          	lw	a3,-64(s0)
8000336c:	8000f7b7          	lui	a5,0x8000f
80003370:	00078713          	mv	a4,a5
80003374:	000027b7          	lui	a5,0x2
80003378:	00f707b3          	add	a5,a4,a5
8000337c:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
80003380:	fbc42783          	lw	a5,-68(s0)
80003384:	00479793          	slli	a5,a5,0x4
80003388:	00f707b3          	add	a5,a4,a5
8000338c:	01069713          	slli	a4,a3,0x10
80003390:	01075713          	srli	a4,a4,0x10
80003394:	00e79723          	sh	a4,14(a5)

    disk.desc[idx[1]].addr = (uint32)b;
80003398:	fa442683          	lw	a3,-92(s0)
8000339c:	8000f7b7          	lui	a5,0x8000f
800033a0:	00078713          	mv	a4,a5
800033a4:	000027b7          	lui	a5,0x2
800033a8:	00f707b3          	add	a5,a4,a5
800033ac:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
800033b0:	fc042783          	lw	a5,-64(s0)
800033b4:	00479793          	slli	a5,a5,0x4
800033b8:	00f707b3          	add	a5,a4,a5
800033bc:	00068a13          	mv	s4,a3
800033c0:	00000a93          	li	s5,0
800033c4:	0147a023          	sw	s4,0(a5)
800033c8:	0157a223          	sw	s5,4(a5)
    disk.desc[idx[1]].len = 512;
800033cc:	8000f7b7          	lui	a5,0x8000f
800033d0:	00078713          	mv	a4,a5
800033d4:	000027b7          	lui	a5,0x2
800033d8:	00f707b3          	add	a5,a4,a5
800033dc:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
800033e0:	fc042783          	lw	a5,-64(s0)
800033e4:	00479793          	slli	a5,a5,0x4
800033e8:	00f707b3          	add	a5,a4,a5
800033ec:	20000713          	li	a4,512
800033f0:	00e7a423          	sw	a4,8(a5)
    if (rw)
800033f4:	fab44783          	lbu	a5,-85(s0)
800033f8:	02078663          	beqz	a5,80003424 <diskrw+0x248>
        disk.desc[idx[1]].flags = 0;
800033fc:	8000f7b7          	lui	a5,0x8000f
80003400:	00078713          	mv	a4,a5
80003404:	000027b7          	lui	a5,0x2
80003408:	00f707b3          	add	a5,a4,a5
8000340c:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
80003410:	fc042783          	lw	a5,-64(s0)
80003414:	00479793          	slli	a5,a5,0x4
80003418:	00f707b3          	add	a5,a4,a5
8000341c:	00079623          	sh	zero,12(a5)
80003420:	02c0006f          	j	8000344c <diskrw+0x270>
    else
        disk.desc[idx[1]].flags = VIRTQ_DESC_F_WRITE;
80003424:	8000f7b7          	lui	a5,0x8000f
80003428:	00078713          	mv	a4,a5
8000342c:	000027b7          	lui	a5,0x2
80003430:	00f707b3          	add	a5,a4,a5
80003434:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
80003438:	fc042783          	lw	a5,-64(s0)
8000343c:	00479793          	slli	a5,a5,0x4
80003440:	00f707b3          	add	a5,a4,a5
80003444:	00200713          	li	a4,2
80003448:	00e79623          	sh	a4,12(a5)
    disk.desc[idx[1]].flags |= VIRTQ_DESC_F_NEXT;
8000344c:	8000f7b7          	lui	a5,0x8000f
80003450:	00078713          	mv	a4,a5
80003454:	000027b7          	lui	a5,0x2
80003458:	00f707b3          	add	a5,a4,a5
8000345c:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
80003460:	fc042783          	lw	a5,-64(s0)
80003464:	00479793          	slli	a5,a5,0x4
80003468:	00f707b3          	add	a5,a4,a5
8000346c:	00c7d703          	lhu	a4,12(a5)
80003470:	8000f7b7          	lui	a5,0x8000f
80003474:	00078693          	mv	a3,a5
80003478:	000027b7          	lui	a5,0x2
8000347c:	00f687b3          	add	a5,a3,a5
80003480:	0007a683          	lw	a3,0(a5) # 2000 <sz+0x1000>
80003484:	fc042783          	lw	a5,-64(s0)
80003488:	00479793          	slli	a5,a5,0x4
8000348c:	00f687b3          	add	a5,a3,a5
80003490:	00176713          	ori	a4,a4,1
80003494:	01071713          	slli	a4,a4,0x10
80003498:	01075713          	srli	a4,a4,0x10
8000349c:	00e79623          	sh	a4,12(a5)
    disk.desc[idx[1]].next = idx[2];
800034a0:	fc442683          	lw	a3,-60(s0)
800034a4:	8000f7b7          	lui	a5,0x8000f
800034a8:	00078713          	mv	a4,a5
800034ac:	000027b7          	lui	a5,0x2
800034b0:	00f707b3          	add	a5,a4,a5
800034b4:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
800034b8:	fc042783          	lw	a5,-64(s0)
800034bc:	00479793          	slli	a5,a5,0x4
800034c0:	00f707b3          	add	a5,a4,a5
800034c4:	01069713          	slli	a4,a3,0x10
800034c8:	01075713          	srli	a4,a4,0x10
800034cc:	00e79723          	sh	a4,14(a5)

    disk.info[idx[0]].status = 0xff;
800034d0:	fbc42783          	lw	a5,-68(s0)
800034d4:	8000f737          	lui	a4,0x8000f
800034d8:	00070713          	mv	a4,a4
800034dc:	40078793          	addi	a5,a5,1024
800034e0:	00379793          	slli	a5,a5,0x3
800034e4:	00f707b3          	add	a5,a4,a5
800034e8:	fff00713          	li	a4,-1
800034ec:	08e78e23          	sb	a4,156(a5)

    disk.desc[idx[2]].addr = (uint32)&disk.info[idx[0]].status;
800034f0:	fbc42783          	lw	a5,-68(s0)
800034f4:	40078793          	addi	a5,a5,1024
800034f8:	00379713          	slli	a4,a5,0x3
800034fc:	8000f7b7          	lui	a5,0x8000f
80003500:	00078793          	mv	a5,a5
80003504:	00f707b3          	add	a5,a4,a5
80003508:	09c78793          	addi	a5,a5,156 # 8000f09c <memend+0xf800f09c>
8000350c:	00078693          	mv	a3,a5
80003510:	8000f7b7          	lui	a5,0x8000f
80003514:	00078713          	mv	a4,a5
80003518:	000027b7          	lui	a5,0x2
8000351c:	00f707b3          	add	a5,a4,a5
80003520:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
80003524:	fc442783          	lw	a5,-60(s0)
80003528:	00479793          	slli	a5,a5,0x4
8000352c:	00f707b3          	add	a5,a4,a5
80003530:	00068913          	mv	s2,a3
80003534:	00000993          	li	s3,0
80003538:	0127a023          	sw	s2,0(a5)
8000353c:	0137a223          	sw	s3,4(a5)
    disk.desc[idx[2]].len = 1;
80003540:	8000f7b7          	lui	a5,0x8000f
80003544:	00078713          	mv	a4,a5
80003548:	000027b7          	lui	a5,0x2
8000354c:	00f707b3          	add	a5,a4,a5
80003550:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
80003554:	fc442783          	lw	a5,-60(s0)
80003558:	00479793          	slli	a5,a5,0x4
8000355c:	00f707b3          	add	a5,a4,a5
80003560:	00100713          	li	a4,1
80003564:	00e7a423          	sw	a4,8(a5)
    disk.desc[idx[2]].flags = VIRTQ_DESC_F_WRITE; // device writes the status
80003568:	8000f7b7          	lui	a5,0x8000f
8000356c:	00078713          	mv	a4,a5
80003570:	000027b7          	lui	a5,0x2
80003574:	00f707b3          	add	a5,a4,a5
80003578:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
8000357c:	fc442783          	lw	a5,-60(s0)
80003580:	00479793          	slli	a5,a5,0x4
80003584:	00f707b3          	add	a5,a4,a5
80003588:	00200713          	li	a4,2
8000358c:	00e79623          	sh	a4,12(a5)
    disk.desc[idx[2]].next = 0;
80003590:	8000f7b7          	lui	a5,0x8000f
80003594:	00078713          	mv	a4,a5
80003598:	000027b7          	lui	a5,0x2
8000359c:	00f707b3          	add	a5,a4,a5
800035a0:	0007a703          	lw	a4,0(a5) # 2000 <sz+0x1000>
800035a4:	fc442783          	lw	a5,-60(s0)
800035a8:	00479793          	slli	a5,a5,0x4
800035ac:	00f707b3          	add	a5,a4,a5
800035b0:	00079723          	sh	zero,14(a5)

    disk.info[idx[0]].data = (char *)b;
800035b4:	fbc42783          	lw	a5,-68(s0)
800035b8:	8000f737          	lui	a4,0x8000f
800035bc:	00070713          	mv	a4,a4
800035c0:	40078793          	addi	a5,a5,1024
800035c4:	00379793          	slli	a5,a5,0x3
800035c8:	00f707b3          	add	a5,a4,a5
800035cc:	fa442703          	lw	a4,-92(s0)
800035d0:	08e7ac23          	sw	a4,152(a5)

    disk.avail->ring[disk.avail->idx % DNUM] = idx[0];
800035d4:	fbc42603          	lw	a2,-68(s0)
800035d8:	8000f7b7          	lui	a5,0x8000f
800035dc:	00078713          	mv	a4,a5
800035e0:	000027b7          	lui	a5,0x2
800035e4:	00f707b3          	add	a5,a4,a5
800035e8:	0047a683          	lw	a3,4(a5) # 2004 <sz+0x1004>
800035ec:	8000f7b7          	lui	a5,0x8000f
800035f0:	00078713          	mv	a4,a5
800035f4:	000027b7          	lui	a5,0x2
800035f8:	00f707b3          	add	a5,a4,a5
800035fc:	0047a783          	lw	a5,4(a5) # 2004 <sz+0x1004>
80003600:	0027d783          	lhu	a5,2(a5)
80003604:	0077f793          	andi	a5,a5,7
80003608:	01061713          	slli	a4,a2,0x10
8000360c:	01075713          	srli	a4,a4,0x10
80003610:	00179793          	slli	a5,a5,0x1
80003614:	00f687b3          	add	a5,a3,a5
80003618:	00e79223          	sh	a4,4(a5)

    // tell the device another avail ring entry is available.
    disk.avail->idx += 1; // not % NUM ...
8000361c:	8000f7b7          	lui	a5,0x8000f
80003620:	00078713          	mv	a4,a5
80003624:	000027b7          	lui	a5,0x2
80003628:	00f707b3          	add	a5,a4,a5
8000362c:	0047a783          	lw	a5,4(a5) # 2004 <sz+0x1004>
80003630:	0027d703          	lhu	a4,2(a5)
80003634:	8000f7b7          	lui	a5,0x8000f
80003638:	00078693          	mv	a3,a5
8000363c:	000027b7          	lui	a5,0x2
80003640:	00f687b3          	add	a5,a3,a5
80003644:	0047a783          	lw	a5,4(a5) # 2004 <sz+0x1004>
80003648:	00170713          	addi	a4,a4,1 # 8000f001 <memend+0xf800f001>
8000364c:	01071713          	slli	a4,a4,0x10
80003650:	01075713          	srli	a4,a4,0x10
80003654:	00e79123          	sh	a4,2(a5)

    mmio_write(MMIO_QueueNotify, 0); // value is queue number
80003658:	100017b7          	lui	a5,0x10001
8000365c:	05078793          	addi	a5,a5,80 # 10001050 <sz+0x10000050>
80003660:	0007a023          	sw	zero,0(a5)

    while (disk.info[idx[0]].status != 0)
80003664:	00000013          	nop
80003668:	fbc42783          	lw	a5,-68(s0)
8000366c:	8000f737          	lui	a4,0x8000f
80003670:	00070713          	mv	a4,a4
80003674:	40078793          	addi	a5,a5,1024
80003678:	00379793          	slli	a5,a5,0x3
8000367c:	00f707b3          	add	a5,a4,a5
80003680:	09c7c783          	lbu	a5,156(a5)
80003684:	fe0792e3          	bnez	a5,80003668 <diskrw+0x48c>
        ;
    printf("finish\n");
80003688:	8000d7b7          	lui	a5,0x8000d
8000368c:	62078513          	addi	a0,a5,1568 # 8000d620 <memend+0xf800d620>
80003690:	badfd0ef          	jal	ra,8000123c <printf>
80003694:	00000013          	nop
80003698:	05c12083          	lw	ra,92(sp)
8000369c:	05812403          	lw	s0,88(sp)
800036a0:	05412903          	lw	s2,84(sp)
800036a4:	05012983          	lw	s3,80(sp)
800036a8:	04c12a03          	lw	s4,76(sp)
800036ac:	04812a83          	lw	s5,72(sp)
800036b0:	04412b03          	lw	s6,68(sp)
800036b4:	04012b83          	lw	s7,64(sp)
800036b8:	03c12c03          	lw	s8,60(sp)
800036bc:	03812c83          	lw	s9,56(sp)
800036c0:	06010113          	addi	sp,sp,96
800036c4:	00008067          	ret

800036c8 <textend>:
	...
