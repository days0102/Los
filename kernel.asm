
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
80000720:	2dc020ef          	jal	ra,800029fc <timerinit>

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
8000090c:	df010113          	addi	sp,sp,-528
80000910:	20112623          	sw	ra,524(sp)
80000914:	20812423          	sw	s0,520(sp)
80000918:	21010413          	addi	s0,sp,528
    printf("start run main()\n");
8000091c:	8000d7b7          	lui	a5,0x8000d
80000920:	00c78513          	addi	a0,a5,12 # 8000d00c <memend+0xf800d00c>
80000924:	0b5000ef          	jal	ra,800011d8 <printf>

    minit();    // 物理内存管理
80000928:	4bd000ef          	jal	ra,800015e4 <minit>
    plicinit(); // PLIC 中断处理
8000092c:	659000ef          	jal	ra,80001784 <plicinit>

    kvminit(); // 启动虚拟内存
80000930:	30c010ef          	jal	ra,80001c3c <kvminit>
    
#ifdef DEBUG
    printf("usertrap: %p\n", usertrap);
#endif

    procinit();
80000934:	598010ef          	jal	ra,80001ecc <procinit>

    userinit();
80000938:	77c010ef          	jal	ra,800020b4 <userinit>

    mmioinit();
8000093c:	2a8020ef          	jal	ra,80002be4 <mmioinit>

    char buf[512];
    diskrw(0,1,buf);
80000940:	df040793          	addi	a5,s0,-528
80000944:	00078613          	mv	a2,a5
80000948:	00100593          	li	a1,1
8000094c:	00000513          	li	a0,0
80000950:	6a8020ef          	jal	ra,80002ff8 <diskrw>

    printf("----------------------\n");
80000954:	8000d7b7          	lui	a5,0x8000d
80000958:	02078513          	addi	a0,a5,32 # 8000d020 <memend+0xf800d020>
8000095c:	07d000ef          	jal	ra,800011d8 <printf>
    schedule();
80000960:	191010ef          	jal	ra,800022f0 <schedule>
}
80000964:	00000013          	nop
80000968:	20c12083          	lw	ra,524(sp)
8000096c:	20812403          	lw	s0,520(sp)
80000970:	21010113          	addi	sp,sp,528
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
80000b6c:	4dd000ef          	jal	ra,80001848 <r_plicclaim>
80000b70:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n", irq);
80000b74:	fec42583          	lw	a1,-20(s0)
80000b78:	8000d7b7          	lui	a5,0x8000d
80000b7c:	03878513          	addi	a0,a5,56 # 8000d038 <memend+0xf800d038>
80000b80:	658000ef          	jal	ra,800011d8 <printf>
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
80000b9c:	8000d7b7          	lui	a5,0x8000d
80000ba0:	04478513          	addi	a0,a5,68 # 8000d044 <memend+0xf800d044>
80000ba4:	634000ef          	jal	ra,800011d8 <printf>
        break;
80000ba8:	0080006f          	j	80000bb0 <externinterrupt+0x54>
    default:
        break;
80000bac:	00000013          	nop
    }
    w_pliccomplete(irq);
80000bb0:	fec42503          	lw	a0,-20(s0)
80000bb4:	4d5000ef          	jal	ra,80001888 <w_pliccomplete>
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
80000bec:	8000d7b7          	lui	a5,0x8000d
80000bf0:	05478513          	addi	a0,a5,84 # 8000d054 <memend+0xf800d054>
80000bf4:	5e4000ef          	jal	ra,800011d8 <printf>
    printf("kernel_satp: %d \n", tf->kernel_satp);
80000bf8:	fec42783          	lw	a5,-20(s0)
80000bfc:	0007a783          	lw	a5,0(a5)
80000c00:	00078593          	mv	a1,a5
80000c04:	8000d7b7          	lui	a5,0x8000d
80000c08:	06478513          	addi	a0,a5,100 # 8000d064 <memend+0xf800d064>
80000c0c:	5cc000ef          	jal	ra,800011d8 <printf>
    printf("kernel_tvec: %d \n", tf->kernel_tvec);
80000c10:	fec42783          	lw	a5,-20(s0)
80000c14:	0047a783          	lw	a5,4(a5)
80000c18:	00078593          	mv	a1,a5
80000c1c:	8000d7b7          	lui	a5,0x8000d
80000c20:	07878513          	addi	a0,a5,120 # 8000d078 <memend+0xf800d078>
80000c24:	5b4000ef          	jal	ra,800011d8 <printf>

    printf("ra: %d \n", tf->ra);
80000c28:	fec42783          	lw	a5,-20(s0)
80000c2c:	0107a783          	lw	a5,16(a5)
80000c30:	00078593          	mv	a1,a5
80000c34:	8000d7b7          	lui	a5,0x8000d
80000c38:	08c78513          	addi	a0,a5,140 # 8000d08c <memend+0xf800d08c>
80000c3c:	59c000ef          	jal	ra,800011d8 <printf>
    printf("sp: %d \n", tf->sp);
80000c40:	fec42783          	lw	a5,-20(s0)
80000c44:	0147a783          	lw	a5,20(a5)
80000c48:	00078593          	mv	a1,a5
80000c4c:	8000d7b7          	lui	a5,0x8000d
80000c50:	09878513          	addi	a0,a5,152 # 8000d098 <memend+0xf800d098>
80000c54:	584000ef          	jal	ra,800011d8 <printf>
    printf("tp: %d \n", tf->tp);
80000c58:	fec42783          	lw	a5,-20(s0)
80000c5c:	01c7a783          	lw	a5,28(a5)
80000c60:	00078593          	mv	a1,a5
80000c64:	8000d7b7          	lui	a5,0x8000d
80000c68:	0a478513          	addi	a0,a5,164 # 8000d0a4 <memend+0xf800d0a4>
80000c6c:	56c000ef          	jal	ra,800011d8 <printf>
    printf("t0: %d \n", tf->t0);
80000c70:	fec42783          	lw	a5,-20(s0)
80000c74:	0707a783          	lw	a5,112(a5)
80000c78:	00078593          	mv	a1,a5
80000c7c:	8000d7b7          	lui	a5,0x8000d
80000c80:	0b078513          	addi	a0,a5,176 # 8000d0b0 <memend+0xf800d0b0>
80000c84:	554000ef          	jal	ra,800011d8 <printf>
    printf("t1: %d \n", tf->t1);
80000c88:	fec42783          	lw	a5,-20(s0)
80000c8c:	0747a783          	lw	a5,116(a5)
80000c90:	00078593          	mv	a1,a5
80000c94:	8000d7b7          	lui	a5,0x8000d
80000c98:	0bc78513          	addi	a0,a5,188 # 8000d0bc <memend+0xf800d0bc>
80000c9c:	53c000ef          	jal	ra,800011d8 <printf>
    printf("t2: %d \n", tf->t2);
80000ca0:	fec42783          	lw	a5,-20(s0)
80000ca4:	0787a783          	lw	a5,120(a5)
80000ca8:	00078593          	mv	a1,a5
80000cac:	8000d7b7          	lui	a5,0x8000d
80000cb0:	0c878513          	addi	a0,a5,200 # 8000d0c8 <memend+0xf800d0c8>
80000cb4:	524000ef          	jal	ra,800011d8 <printf>
    printf("t3: %d \n", tf->t3);
80000cb8:	fec42783          	lw	a5,-20(s0)
80000cbc:	07c7a783          	lw	a5,124(a5)
80000cc0:	00078593          	mv	a1,a5
80000cc4:	8000d7b7          	lui	a5,0x8000d
80000cc8:	0d478513          	addi	a0,a5,212 # 8000d0d4 <memend+0xf800d0d4>
80000ccc:	50c000ef          	jal	ra,800011d8 <printf>
    printf("t4: %d \n", tf->t4);
80000cd0:	fec42783          	lw	a5,-20(s0)
80000cd4:	0807a783          	lw	a5,128(a5)
80000cd8:	00078593          	mv	a1,a5
80000cdc:	8000d7b7          	lui	a5,0x8000d
80000ce0:	0e078513          	addi	a0,a5,224 # 8000d0e0 <memend+0xf800d0e0>
80000ce4:	4f4000ef          	jal	ra,800011d8 <printf>
    printf("t5: %d \n", tf->t5);
80000ce8:	fec42783          	lw	a5,-20(s0)
80000cec:	0847a783          	lw	a5,132(a5)
80000cf0:	00078593          	mv	a1,a5
80000cf4:	8000d7b7          	lui	a5,0x8000d
80000cf8:	0ec78513          	addi	a0,a5,236 # 8000d0ec <memend+0xf800d0ec>
80000cfc:	4dc000ef          	jal	ra,800011d8 <printf>
    printf("t6: %d \n", tf->t6);
80000d00:	fec42783          	lw	a5,-20(s0)
80000d04:	0887a783          	lw	a5,136(a5)
80000d08:	00078593          	mv	a1,a5
80000d0c:	8000d7b7          	lui	a5,0x8000d
80000d10:	0f878513          	addi	a0,a5,248 # 8000d0f8 <memend+0xf800d0f8>
80000d14:	4c4000ef          	jal	ra,800011d8 <printf>
    printf("a0: %d \n", tf->a0);
80000d18:	fec42783          	lw	a5,-20(s0)
80000d1c:	0207a783          	lw	a5,32(a5)
80000d20:	00078593          	mv	a1,a5
80000d24:	8000d7b7          	lui	a5,0x8000d
80000d28:	10478513          	addi	a0,a5,260 # 8000d104 <memend+0xf800d104>
80000d2c:	4ac000ef          	jal	ra,800011d8 <printf>
    printf("a1: %d \n", tf->a1);
80000d30:	fec42783          	lw	a5,-20(s0)
80000d34:	0247a783          	lw	a5,36(a5)
80000d38:	00078593          	mv	a1,a5
80000d3c:	8000d7b7          	lui	a5,0x8000d
80000d40:	11078513          	addi	a0,a5,272 # 8000d110 <memend+0xf800d110>
80000d44:	494000ef          	jal	ra,800011d8 <printf>
    printf("a2: %d \n", tf->a2);
80000d48:	fec42783          	lw	a5,-20(s0)
80000d4c:	0287a783          	lw	a5,40(a5)
80000d50:	00078593          	mv	a1,a5
80000d54:	8000d7b7          	lui	a5,0x8000d
80000d58:	11c78513          	addi	a0,a5,284 # 8000d11c <memend+0xf800d11c>
80000d5c:	47c000ef          	jal	ra,800011d8 <printf>
    printf("a3: %d \n", tf->a3);
80000d60:	fec42783          	lw	a5,-20(s0)
80000d64:	02c7a783          	lw	a5,44(a5)
80000d68:	00078593          	mv	a1,a5
80000d6c:	8000d7b7          	lui	a5,0x8000d
80000d70:	12878513          	addi	a0,a5,296 # 8000d128 <memend+0xf800d128>
80000d74:	464000ef          	jal	ra,800011d8 <printf>
    printf("a4: %d \n", tf->a4);
80000d78:	fec42783          	lw	a5,-20(s0)
80000d7c:	0307a783          	lw	a5,48(a5)
80000d80:	00078593          	mv	a1,a5
80000d84:	8000d7b7          	lui	a5,0x8000d
80000d88:	13478513          	addi	a0,a5,308 # 8000d134 <memend+0xf800d134>
80000d8c:	44c000ef          	jal	ra,800011d8 <printf>
    printf("a5: %d \n", tf->a5);
80000d90:	fec42783          	lw	a5,-20(s0)
80000d94:	0347a783          	lw	a5,52(a5)
80000d98:	00078593          	mv	a1,a5
80000d9c:	8000d7b7          	lui	a5,0x8000d
80000da0:	14078513          	addi	a0,a5,320 # 8000d140 <memend+0xf800d140>
80000da4:	434000ef          	jal	ra,800011d8 <printf>
    printf("a6: %d \n", tf->a6);
80000da8:	fec42783          	lw	a5,-20(s0)
80000dac:	0387a783          	lw	a5,56(a5)
80000db0:	00078593          	mv	a1,a5
80000db4:	8000d7b7          	lui	a5,0x8000d
80000db8:	14c78513          	addi	a0,a5,332 # 8000d14c <memend+0xf800d14c>
80000dbc:	41c000ef          	jal	ra,800011d8 <printf>
    printf("a7: %d \n", tf->a7);
80000dc0:	fec42783          	lw	a5,-20(s0)
80000dc4:	03c7a783          	lw	a5,60(a5)
80000dc8:	00078593          	mv	a1,a5
80000dcc:	8000d7b7          	lui	a5,0x8000d
80000dd0:	15878513          	addi	a0,a5,344 # 8000d158 <memend+0xf800d158>
80000dd4:	404000ef          	jal	ra,800011d8 <printf>
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
80000e00:	14c010ef          	jal	ra,80001f4c <nowproc>
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
80000ebc:	8000e7b7          	lui	a5,0x8000e
80000ec0:	00100713          	li	a4,1
80000ec4:	00e7a223          	sw	a4,4(a5) # 8000e004 <memend+0xf800e004>
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
80000f04:	480010ef          	jal	ra,80002384 <yield>
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
80000f94:	8000d7b7          	lui	a5,0x8000d
80000f98:	16478513          	addi	a0,a5,356 # 8000d164 <memend+0xf800d164>
80000f9c:	23c000ef          	jal	ra,800011d8 <printf>
            break;
80000fa0:	0280006f          	j	80000fc8 <trapvec+0xac>
        case 9:
            printf("Supervisor external interrupt\n");
80000fa4:	8000d7b7          	lui	a5,0x8000d
80000fa8:	18078513          	addi	a0,a5,384 # 8000d180 <memend+0xf800d180>
80000fac:	22c000ef          	jal	ra,800011d8 <printf>
            externinterrupt();
80000fb0:	badff0ef          	jal	ra,80000b5c <externinterrupt>
            break;
80000fb4:	0140006f          	j	80000fc8 <trapvec+0xac>
        default:
            printf("Other interrupt\n");
80000fb8:	8000d7b7          	lui	a5,0x8000d
80000fbc:	1a078513          	addi	a0,a5,416 # 8000d1a0 <memend+0xf800d1a0>
80000fc0:	218000ef          	jal	ra,800011d8 <printf>
            break;
80000fc4:	00000013          	nop
        }
        where ?: usertrapret();
80000fc8:	fec42783          	lw	a5,-20(s0)
80000fcc:	1c079063          	bnez	a5,8000118c <trapvec+0x270>
80000fd0:	e1dff0ef          	jal	ra,80000dec <usertrapret>
            printf("Other\n");
            break;
        }
        panic("Trap Exception");
    }
}
80000fd4:	1b80006f          	j	8000118c <trapvec+0x270>
        printf("Exception : ");
80000fd8:	8000d7b7          	lui	a5,0x8000d
80000fdc:	1b478513          	addi	a0,a5,436 # 8000d1b4 <memend+0xf800d1b4>
80000fe0:	1f8000ef          	jal	ra,800011d8 <printf>
        switch (code)
80000fe4:	fe645783          	lhu	a5,-26(s0)
80000fe8:	00f00713          	li	a4,15
80000fec:	18f76263          	bltu	a4,a5,80001170 <trapvec+0x254>
80000ff0:	00279713          	slli	a4,a5,0x2
80000ff4:	8000d7b7          	lui	a5,0x8000d
80000ff8:	33878793          	addi	a5,a5,824 # 8000d338 <memend+0xf800d338>
80000ffc:	00f707b3          	add	a5,a4,a5
80001000:	0007a783          	lw	a5,0(a5)
80001004:	00078067          	jr	a5
            printf("Instruction address misaligned\n");
80001008:	8000d7b7          	lui	a5,0x8000d
8000100c:	1c478513          	addi	a0,a5,452 # 8000d1c4 <memend+0xf800d1c4>
80001010:	1c8000ef          	jal	ra,800011d8 <printf>
            break;
80001014:	16c0006f          	j	80001180 <trapvec+0x264>
            printf("Instruction access fault\n");
80001018:	8000d7b7          	lui	a5,0x8000d
8000101c:	1e478513          	addi	a0,a5,484 # 8000d1e4 <memend+0xf800d1e4>
80001020:	1b8000ef          	jal	ra,800011d8 <printf>
            break;
80001024:	15c0006f          	j	80001180 <trapvec+0x264>
            printf("Illegal instruction\n");
80001028:	8000d7b7          	lui	a5,0x8000d
8000102c:	20078513          	addi	a0,a5,512 # 8000d200 <memend+0xf800d200>
80001030:	1a8000ef          	jal	ra,800011d8 <printf>
            break;
80001034:	14c0006f          	j	80001180 <trapvec+0x264>
            printf("Breakpoint\n");
80001038:	8000d7b7          	lui	a5,0x8000d
8000103c:	21878513          	addi	a0,a5,536 # 8000d218 <memend+0xf800d218>
80001040:	198000ef          	jal	ra,800011d8 <printf>
            break;
80001044:	13c0006f          	j	80001180 <trapvec+0x264>
            printf("Load address misaligned\n");
80001048:	8000d7b7          	lui	a5,0x8000d
8000104c:	22478513          	addi	a0,a5,548 # 8000d224 <memend+0xf800d224>
80001050:	188000ef          	jal	ra,800011d8 <printf>
            break;
80001054:	12c0006f          	j	80001180 <trapvec+0x264>
            printf("Load access fault\n");
80001058:	8000d7b7          	lui	a5,0x8000d
8000105c:	24078513          	addi	a0,a5,576 # 8000d240 <memend+0xf800d240>
80001060:	178000ef          	jal	ra,800011d8 <printf>
            printf("stval va: %p\n", r_stval());
80001064:	a81ff0ef          	jal	ra,80000ae4 <r_stval>
80001068:	00050793          	mv	a5,a0
8000106c:	00078593          	mv	a1,a5
80001070:	8000d7b7          	lui	a5,0x8000d
80001074:	25478513          	addi	a0,a5,596 # 8000d254 <memend+0xf800d254>
80001078:	160000ef          	jal	ra,800011d8 <printf>
            break;
8000107c:	1040006f          	j	80001180 <trapvec+0x264>
            printf("Store/AMO address misaligned\n");
80001080:	8000d7b7          	lui	a5,0x8000d
80001084:	26478513          	addi	a0,a5,612 # 8000d264 <memend+0xf800d264>
80001088:	150000ef          	jal	ra,800011d8 <printf>
            break;
8000108c:	0f40006f          	j	80001180 <trapvec+0x264>
            printf("Store/AMO access fault\n");
80001090:	8000d7b7          	lui	a5,0x8000d
80001094:	28478513          	addi	a0,a5,644 # 8000d284 <memend+0xf800d284>
80001098:	140000ef          	jal	ra,800011d8 <printf>
            printf("stval va: %p\n", r_stval());
8000109c:	a49ff0ef          	jal	ra,80000ae4 <r_stval>
800010a0:	00050793          	mv	a5,a0
800010a4:	00078593          	mv	a1,a5
800010a8:	8000d7b7          	lui	a5,0x8000d
800010ac:	25478513          	addi	a0,a5,596 # 8000d254 <memend+0xf800d254>
800010b0:	128000ef          	jal	ra,800011d8 <printf>
            break;
800010b4:	0cc0006f          	j	80001180 <trapvec+0x264>
            printf("Environment call from U-mode\n");
800010b8:	8000d7b7          	lui	a5,0x8000d
800010bc:	29c78513          	addi	a0,a5,668 # 8000d29c <memend+0xf800d29c>
800010c0:	118000ef          	jal	ra,800011d8 <printf>
            syscall();
800010c4:	281010ef          	jal	ra,80002b44 <syscall>
            usertrapret();
800010c8:	d25ff0ef          	jal	ra,80000dec <usertrapret>
            break;
800010cc:	0b40006f          	j	80001180 <trapvec+0x264>
            printf("Environment call from S-mode\n");
800010d0:	8000d7b7          	lui	a5,0x8000d
800010d4:	2bc78513          	addi	a0,a5,700 # 8000d2bc <memend+0xf800d2bc>
800010d8:	100000ef          	jal	ra,800011d8 <printf>
            first ? usertrapret() : startproc();
800010dc:	8000e7b7          	lui	a5,0x8000e
800010e0:	0047a783          	lw	a5,4(a5) # 8000e004 <memend+0xf800e004>
800010e4:	00078663          	beqz	a5,800010f0 <trapvec+0x1d4>
800010e8:	d05ff0ef          	jal	ra,80000dec <usertrapret>
            break;
800010ec:	0940006f          	j	80001180 <trapvec+0x264>
            first ? usertrapret() : startproc();
800010f0:	dbdff0ef          	jal	ra,80000eac <startproc>
            break;
800010f4:	08c0006f          	j	80001180 <trapvec+0x264>
            printf("Instruction page fault\n");
800010f8:	8000d7b7          	lui	a5,0x8000d
800010fc:	2dc78513          	addi	a0,a5,732 # 8000d2dc <memend+0xf800d2dc>
80001100:	0d8000ef          	jal	ra,800011d8 <printf>
            printf("stval va: %p\n", r_stval());
80001104:	9e1ff0ef          	jal	ra,80000ae4 <r_stval>
80001108:	00050793          	mv	a5,a0
8000110c:	00078593          	mv	a1,a5
80001110:	8000d7b7          	lui	a5,0x8000d
80001114:	25478513          	addi	a0,a5,596 # 8000d254 <memend+0xf800d254>
80001118:	0c0000ef          	jal	ra,800011d8 <printf>
            break;
8000111c:	0640006f          	j	80001180 <trapvec+0x264>
            printf("Load page fault\n");
80001120:	8000d7b7          	lui	a5,0x8000d
80001124:	2f478513          	addi	a0,a5,756 # 8000d2f4 <memend+0xf800d2f4>
80001128:	0b0000ef          	jal	ra,800011d8 <printf>
            printf("stval va: %p\n", r_stval());
8000112c:	9b9ff0ef          	jal	ra,80000ae4 <r_stval>
80001130:	00050793          	mv	a5,a0
80001134:	00078593          	mv	a1,a5
80001138:	8000d7b7          	lui	a5,0x8000d
8000113c:	25478513          	addi	a0,a5,596 # 8000d254 <memend+0xf800d254>
80001140:	098000ef          	jal	ra,800011d8 <printf>
            break;
80001144:	03c0006f          	j	80001180 <trapvec+0x264>
            printf("Store/AMO page fault\n");
80001148:	8000d7b7          	lui	a5,0x8000d
8000114c:	30878513          	addi	a0,a5,776 # 8000d308 <memend+0xf800d308>
80001150:	088000ef          	jal	ra,800011d8 <printf>
            printf("stval va: %p\n", r_stval());
80001154:	991ff0ef          	jal	ra,80000ae4 <r_stval>
80001158:	00050793          	mv	a5,a0
8000115c:	00078593          	mv	a1,a5
80001160:	8000d7b7          	lui	a5,0x8000d
80001164:	25478513          	addi	a0,a5,596 # 8000d254 <memend+0xf800d254>
80001168:	070000ef          	jal	ra,800011d8 <printf>
            break;
8000116c:	0140006f          	j	80001180 <trapvec+0x264>
            printf("Other\n");
80001170:	8000d7b7          	lui	a5,0x8000d
80001174:	32078513          	addi	a0,a5,800 # 8000d320 <memend+0xf800d320>
80001178:	060000ef          	jal	ra,800011d8 <printf>
            break;
8000117c:	00000013          	nop
        panic("Trap Exception");
80001180:	8000d7b7          	lui	a5,0x8000d
80001184:	32878513          	addi	a0,a5,808 # 8000d328 <memend+0xf800d328>
80001188:	018000ef          	jal	ra,800011a0 <panic>
}
8000118c:	00000013          	nop
80001190:	01c12083          	lw	ra,28(sp)
80001194:	01812403          	lw	s0,24(sp)
80001198:	02010113          	addi	sp,sp,32
8000119c:	00008067          	ret

800011a0 <panic>:
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char *s)
{
800011a0:	fe010113          	addi	sp,sp,-32
800011a4:	00112e23          	sw	ra,28(sp)
800011a8:	00812c23          	sw	s0,24(sp)
800011ac:	02010413          	addi	s0,sp,32
800011b0:	fea42623          	sw	a0,-20(s0)
	uartputs("panic: ");
800011b4:	8000d7b7          	lui	a5,0x8000d
800011b8:	37878513          	addi	a0,a5,888 # 8000d378 <memend+0xf800d378>
800011bc:	e84ff0ef          	jal	ra,80000840 <uartputs>
	uartputs(s);
800011c0:	fec42503          	lw	a0,-20(s0)
800011c4:	e7cff0ef          	jal	ra,80000840 <uartputs>
	uartputs("\n");
800011c8:	8000d7b7          	lui	a5,0x8000d
800011cc:	38078513          	addi	a0,a5,896 # 8000d380 <memend+0xf800d380>
800011d0:	e70ff0ef          	jal	ra,80000840 <uartputs>
	while (1)
800011d4:	0000006f          	j	800011d4 <panic+0x34>

800011d8 <printf>:

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char *fmt, ...)
{
800011d8:	f8010113          	addi	sp,sp,-128
800011dc:	04112e23          	sw	ra,92(sp)
800011e0:	04812c23          	sw	s0,88(sp)
800011e4:	06010413          	addi	s0,sp,96
800011e8:	faa42623          	sw	a0,-84(s0)
800011ec:	00b42223          	sw	a1,4(s0)
800011f0:	00c42423          	sw	a2,8(s0)
800011f4:	00d42623          	sw	a3,12(s0)
800011f8:	00e42823          	sw	a4,16(s0)
800011fc:	00f42a23          	sw	a5,20(s0)
80001200:	01042c23          	sw	a6,24(s0)
80001204:	01142e23          	sw	a7,28(s0)
	va_list vl;		   // 保存参数的地址，定义在stdarg.h
	va_start(vl, fmt); // 将vl指向fmt后面的参数
80001208:	02040793          	addi	a5,s0,32
8000120c:	faf42423          	sw	a5,-88(s0)
80001210:	fa842783          	lw	a5,-88(s0)
80001214:	fe478793          	addi	a5,a5,-28
80001218:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char *s = fmt;
8000121c:	fac42783          	lw	a5,-84(s0)
80001220:	fef42623          	sw	a5,-20(s0)
	int tt = 0;
80001224:	fe042423          	sw	zero,-24(s0)
	int idx = 0;
80001228:	fe042223          	sw	zero,-28(s0)
	while ((ch = *(s)))
8000122c:	36c0006f          	j	80001598 <printf+0x3c0>
	{
		if (ch == '%')
80001230:	fbf44703          	lbu	a4,-65(s0)
80001234:	02500793          	li	a5,37
80001238:	04f71863          	bne	a4,a5,80001288 <printf+0xb0>
		{
			if (tt == 1)
8000123c:	fe842703          	lw	a4,-24(s0)
80001240:	00100793          	li	a5,1
80001244:	02f71663          	bne	a4,a5,80001270 <printf+0x98>
			{
				outbuf[idx++] = '%';
80001248:	fe442783          	lw	a5,-28(s0)
8000124c:	00178713          	addi	a4,a5,1
80001250:	fee42223          	sw	a4,-28(s0)
80001254:	8000e737          	lui	a4,0x8000e
80001258:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
8000125c:	00f707b3          	add	a5,a4,a5
80001260:	02500713          	li	a4,37
80001264:	00e78023          	sb	a4,0(a5)
				tt = 0;
80001268:	fe042423          	sw	zero,-24(s0)
8000126c:	00c0006f          	j	80001278 <printf+0xa0>
			}
			else
			{
				tt = 1;
80001270:	00100793          	li	a5,1
80001274:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80001278:	fec42783          	lw	a5,-20(s0)
8000127c:	00178793          	addi	a5,a5,1
80001280:	fef42623          	sw	a5,-20(s0)
80001284:	3140006f          	j	80001598 <printf+0x3c0>
		}
		else
		{
			if (tt == 1)
80001288:	fe842703          	lw	a4,-24(s0)
8000128c:	00100793          	li	a5,1
80001290:	2cf71e63          	bne	a4,a5,8000156c <printf+0x394>
			{
				switch (ch)
80001294:	fbf44783          	lbu	a5,-65(s0)
80001298:	fa878793          	addi	a5,a5,-88
8000129c:	02000713          	li	a4,32
800012a0:	2af76663          	bltu	a4,a5,8000154c <printf+0x374>
800012a4:	00279713          	slli	a4,a5,0x2
800012a8:	8000d7b7          	lui	a5,0x8000d
800012ac:	39c78793          	addi	a5,a5,924 # 8000d39c <memend+0xf800d39c>
800012b0:	00f707b3          	add	a5,a4,a5
800012b4:	0007a783          	lw	a5,0(a5)
800012b8:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x = va_arg(vl, int);
800012bc:	fb842783          	lw	a5,-72(s0)
800012c0:	00478713          	addi	a4,a5,4
800012c4:	fae42c23          	sw	a4,-72(s0)
800012c8:	0007a783          	lw	a5,0(a5)
800012cc:	fef42023          	sw	a5,-32(s0)
					int len = 0;
800012d0:	fc042e23          	sw	zero,-36(s0)
					for (int n = x; n /= 10; len++)
800012d4:	fe042783          	lw	a5,-32(s0)
800012d8:	fcf42c23          	sw	a5,-40(s0)
800012dc:	0100006f          	j	800012ec <printf+0x114>
800012e0:	fdc42783          	lw	a5,-36(s0)
800012e4:	00178793          	addi	a5,a5,1
800012e8:	fcf42e23          	sw	a5,-36(s0)
800012ec:	fd842703          	lw	a4,-40(s0)
800012f0:	00a00793          	li	a5,10
800012f4:	02f747b3          	div	a5,a4,a5
800012f8:	fcf42c23          	sw	a5,-40(s0)
800012fc:	fd842783          	lw	a5,-40(s0)
80001300:	fe0790e3          	bnez	a5,800012e0 <printf+0x108>
						;
					for (int i = len; i >= 0; i--)
80001304:	fdc42783          	lw	a5,-36(s0)
80001308:	fcf42a23          	sw	a5,-44(s0)
8000130c:	0540006f          	j	80001360 <printf+0x188>
					{
						outbuf[idx + i] = '0' + (x % 10);
80001310:	fe042703          	lw	a4,-32(s0)
80001314:	00a00793          	li	a5,10
80001318:	02f767b3          	rem	a5,a4,a5
8000131c:	0ff7f713          	andi	a4,a5,255
80001320:	fe442683          	lw	a3,-28(s0)
80001324:	fd442783          	lw	a5,-44(s0)
80001328:	00f687b3          	add	a5,a3,a5
8000132c:	03070713          	addi	a4,a4,48
80001330:	0ff77713          	andi	a4,a4,255
80001334:	8000e6b7          	lui	a3,0x8000e
80001338:	00868693          	addi	a3,a3,8 # 8000e008 <memend+0xf800e008>
8000133c:	00f687b3          	add	a5,a3,a5
80001340:	00e78023          	sb	a4,0(a5)
						x /= 10;
80001344:	fe042703          	lw	a4,-32(s0)
80001348:	00a00793          	li	a5,10
8000134c:	02f747b3          	div	a5,a4,a5
80001350:	fef42023          	sw	a5,-32(s0)
					for (int i = len; i >= 0; i--)
80001354:	fd442783          	lw	a5,-44(s0)
80001358:	fff78793          	addi	a5,a5,-1
8000135c:	fcf42a23          	sw	a5,-44(s0)
80001360:	fd442783          	lw	a5,-44(s0)
80001364:	fa07d6e3          	bgez	a5,80001310 <printf+0x138>
					}
					idx += (len + 1);
80001368:	fdc42783          	lw	a5,-36(s0)
8000136c:	00178793          	addi	a5,a5,1
80001370:	fe442703          	lw	a4,-28(s0)
80001374:	00f707b3          	add	a5,a4,a5
80001378:	fef42223          	sw	a5,-28(s0)
					tt = 0;
8000137c:	fe042423          	sw	zero,-24(s0)
					break;
80001380:	1dc0006f          	j	8000155c <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++] = '0';
80001384:	fe442783          	lw	a5,-28(s0)
80001388:	00178713          	addi	a4,a5,1
8000138c:	fee42223          	sw	a4,-28(s0)
80001390:	8000e737          	lui	a4,0x8000e
80001394:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
80001398:	00f707b3          	add	a5,a4,a5
8000139c:	03000713          	li	a4,48
800013a0:	00e78023          	sb	a4,0(a5)
					outbuf[idx++] = 'x';
800013a4:	fe442783          	lw	a5,-28(s0)
800013a8:	00178713          	addi	a4,a5,1
800013ac:	fee42223          	sw	a4,-28(s0)
800013b0:	8000e737          	lui	a4,0x8000e
800013b4:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
800013b8:	00f707b3          	add	a5,a4,a5
800013bc:	07800713          	li	a4,120
800013c0:	00e78023          	sb	a4,0(a5)
				} // 接着下面输出16进制数
				case 'x':
				case 'X': // 大小写一致
				{
					uint x = va_arg(vl, uint);
800013c4:	fb842783          	lw	a5,-72(s0)
800013c8:	00478713          	addi	a4,a5,4
800013cc:	fae42c23          	sw	a4,-72(s0)
800013d0:	0007a783          	lw	a5,0(a5)
800013d4:	fcf42823          	sw	a5,-48(s0)
					int len = 0;
800013d8:	fc042623          	sw	zero,-52(s0)
					for (unsigned int n = x; n /= 16; len++)
800013dc:	fd042783          	lw	a5,-48(s0)
800013e0:	fcf42423          	sw	a5,-56(s0)
800013e4:	0100006f          	j	800013f4 <printf+0x21c>
800013e8:	fcc42783          	lw	a5,-52(s0)
800013ec:	00178793          	addi	a5,a5,1
800013f0:	fcf42623          	sw	a5,-52(s0)
800013f4:	fc842783          	lw	a5,-56(s0)
800013f8:	0047d793          	srli	a5,a5,0x4
800013fc:	fcf42423          	sw	a5,-56(s0)
80001400:	fc842783          	lw	a5,-56(s0)
80001404:	fe0792e3          	bnez	a5,800013e8 <printf+0x210>
						;
					for (int i = len; i >= 0; i--)
80001408:	fcc42783          	lw	a5,-52(s0)
8000140c:	fcf42223          	sw	a5,-60(s0)
80001410:	0840006f          	j	80001494 <printf+0x2bc>
					{
						char c = (x % 16) >= 10 ? 'a' + ((x % 16) - 10) : '0' + (x % 16);
80001414:	fd042783          	lw	a5,-48(s0)
80001418:	00f7f713          	andi	a4,a5,15
8000141c:	00900793          	li	a5,9
80001420:	02e7f063          	bgeu	a5,a4,80001440 <printf+0x268>
80001424:	fd042783          	lw	a5,-48(s0)
80001428:	0ff7f793          	andi	a5,a5,255
8000142c:	00f7f793          	andi	a5,a5,15
80001430:	0ff7f793          	andi	a5,a5,255
80001434:	05778793          	addi	a5,a5,87
80001438:	0ff7f793          	andi	a5,a5,255
8000143c:	01c0006f          	j	80001458 <printf+0x280>
80001440:	fd042783          	lw	a5,-48(s0)
80001444:	0ff7f793          	andi	a5,a5,255
80001448:	00f7f793          	andi	a5,a5,15
8000144c:	0ff7f793          	andi	a5,a5,255
80001450:	03078793          	addi	a5,a5,48
80001454:	0ff7f793          	andi	a5,a5,255
80001458:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx + i] = c;
8000145c:	fe442703          	lw	a4,-28(s0)
80001460:	fc442783          	lw	a5,-60(s0)
80001464:	00f707b3          	add	a5,a4,a5
80001468:	8000e737          	lui	a4,0x8000e
8000146c:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
80001470:	00f707b3          	add	a5,a4,a5
80001474:	fbe44703          	lbu	a4,-66(s0)
80001478:	00e78023          	sb	a4,0(a5)
						x /= 16;
8000147c:	fd042783          	lw	a5,-48(s0)
80001480:	0047d793          	srli	a5,a5,0x4
80001484:	fcf42823          	sw	a5,-48(s0)
					for (int i = len; i >= 0; i--)
80001488:	fc442783          	lw	a5,-60(s0)
8000148c:	fff78793          	addi	a5,a5,-1
80001490:	fcf42223          	sw	a5,-60(s0)
80001494:	fc442783          	lw	a5,-60(s0)
80001498:	f607dee3          	bgez	a5,80001414 <printf+0x23c>
					}
					idx += (len + 1);
8000149c:	fcc42783          	lw	a5,-52(s0)
800014a0:	00178793          	addi	a5,a5,1
800014a4:	fe442703          	lw	a4,-28(s0)
800014a8:	00f707b3          	add	a5,a4,a5
800014ac:	fef42223          	sw	a5,-28(s0)
					tt = 0;
800014b0:	fe042423          	sw	zero,-24(s0)
					break;
800014b4:	0a80006f          	j	8000155c <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch = va_arg(vl, int);
800014b8:	fb842783          	lw	a5,-72(s0)
800014bc:	00478713          	addi	a4,a5,4
800014c0:	fae42c23          	sw	a4,-72(s0)
800014c4:	0007a783          	lw	a5,0(a5)
800014c8:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++] = ch;
800014cc:	fe442783          	lw	a5,-28(s0)
800014d0:	00178713          	addi	a4,a5,1
800014d4:	fee42223          	sw	a4,-28(s0)
800014d8:	8000e737          	lui	a4,0x8000e
800014dc:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
800014e0:	00f707b3          	add	a5,a4,a5
800014e4:	fbf44703          	lbu	a4,-65(s0)
800014e8:	00e78023          	sb	a4,0(a5)
					tt = 0;
800014ec:	fe042423          	sw	zero,-24(s0)
					break;
800014f0:	06c0006f          	j	8000155c <printf+0x384>
				case 's':
				{
					char *ss = va_arg(vl, char *);
800014f4:	fb842783          	lw	a5,-72(s0)
800014f8:	00478713          	addi	a4,a5,4
800014fc:	fae42c23          	sw	a4,-72(s0)
80001500:	0007a783          	lw	a5,0(a5)
80001504:	fcf42023          	sw	a5,-64(s0)
					while (*ss)
80001508:	0300006f          	j	80001538 <printf+0x360>
					{
						outbuf[idx++] = *ss++;
8000150c:	fc042703          	lw	a4,-64(s0)
80001510:	00170793          	addi	a5,a4,1
80001514:	fcf42023          	sw	a5,-64(s0)
80001518:	fe442783          	lw	a5,-28(s0)
8000151c:	00178693          	addi	a3,a5,1
80001520:	fed42223          	sw	a3,-28(s0)
80001524:	00074703          	lbu	a4,0(a4)
80001528:	8000e6b7          	lui	a3,0x8000e
8000152c:	00868693          	addi	a3,a3,8 # 8000e008 <memend+0xf800e008>
80001530:	00f687b3          	add	a5,a3,a5
80001534:	00e78023          	sb	a4,0(a5)
					while (*ss)
80001538:	fc042783          	lw	a5,-64(s0)
8000153c:	0007c783          	lbu	a5,0(a5)
80001540:	fc0796e3          	bnez	a5,8000150c <printf+0x334>
					}
					tt = 0;
80001544:	fe042423          	sw	zero,-24(s0)
					break;
80001548:	0140006f          	j	8000155c <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
8000154c:	8000d7b7          	lui	a5,0x8000d
80001550:	38478513          	addi	a0,a5,900 # 8000d384 <memend+0xf800d384>
80001554:	c4dff0ef          	jal	ra,800011a0 <panic>
					break;
80001558:	00000013          	nop
				}
				s++;
8000155c:	fec42783          	lw	a5,-20(s0)
80001560:	00178793          	addi	a5,a5,1
80001564:	fef42623          	sw	a5,-20(s0)
80001568:	0300006f          	j	80001598 <printf+0x3c0>
			}
			else
			{
				outbuf[idx++] = ch;
8000156c:	fe442783          	lw	a5,-28(s0)
80001570:	00178713          	addi	a4,a5,1
80001574:	fee42223          	sw	a4,-28(s0)
80001578:	8000e737          	lui	a4,0x8000e
8000157c:	00870713          	addi	a4,a4,8 # 8000e008 <memend+0xf800e008>
80001580:	00f707b3          	add	a5,a4,a5
80001584:	fbf44703          	lbu	a4,-65(s0)
80001588:	00e78023          	sb	a4,0(a5)
				s++;
8000158c:	fec42783          	lw	a5,-20(s0)
80001590:	00178793          	addi	a5,a5,1
80001594:	fef42623          	sw	a5,-20(s0)
	while ((ch = *(s)))
80001598:	fec42783          	lw	a5,-20(s0)
8000159c:	0007c783          	lbu	a5,0(a5)
800015a0:	faf40fa3          	sb	a5,-65(s0)
800015a4:	fbf44783          	lbu	a5,-65(s0)
800015a8:	c80794e3          	bnez	a5,80001230 <printf+0x58>
			}
		}
	}
	va_end(vl); // 释法参数
	outbuf[idx] = '\0';
800015ac:	8000e7b7          	lui	a5,0x8000e
800015b0:	00878713          	addi	a4,a5,8 # 8000e008 <memend+0xf800e008>
800015b4:	fe442783          	lw	a5,-28(s0)
800015b8:	00f707b3          	add	a5,a4,a5
800015bc:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
800015c0:	8000e7b7          	lui	a5,0x8000e
800015c4:	00878513          	addi	a0,a5,8 # 8000e008 <memend+0xf800e008>
800015c8:	a78ff0ef          	jal	ra,80000840 <uartputs>
	return idx;
800015cc:	fe442783          	lw	a5,-28(s0)
800015d0:	00078513          	mv	a0,a5
800015d4:	05c12083          	lw	ra,92(sp)
800015d8:	05812403          	lw	s0,88(sp)
800015dc:	08010113          	addi	sp,sp,128
800015e0:	00008067          	ret

800015e4 <minit>:
{
    struct pmp *freelist;
} mem;

void minit()
{
800015e4:	fe010113          	addi	sp,sp,-32
800015e8:	00812e23          	sw	s0,28(sp)
800015ec:	02010413          	addi	s0,sp,32
    printf("mstart:%p   ", mstart);
    printf("mend:%p\n", mend);
    printf("stack:%p\n", stacks);
#endif

    char *p = (char *)mstart;
800015f0:	800137b7          	lui	a5,0x80013
800015f4:	00078793          	mv	a5,a5
800015f8:	fef42623          	sw	a5,-20(s0)
    struct pmp *m;
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
800015fc:	0380006f          	j	80001634 <minit+0x50>
    {
        m = (struct pmp *)p;
80001600:	fec42783          	lw	a5,-20(s0)
80001604:	fef42423          	sw	a5,-24(s0)
        m->next = mem.freelist;
80001608:	8000f7b7          	lui	a5,0x8000f
8000160c:	a487a703          	lw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
80001610:	fe842783          	lw	a5,-24(s0)
80001614:	00e7a023          	sw	a4,0(a5)
        mem.freelist = m;
80001618:	8000f7b7          	lui	a5,0x8000f
8000161c:	fe842703          	lw	a4,-24(s0)
80001620:	a4e7a423          	sw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
80001624:	fec42703          	lw	a4,-20(s0)
80001628:	000017b7          	lui	a5,0x1
8000162c:	00f707b3          	add	a5,a4,a5
80001630:	fef42623          	sw	a5,-20(s0)
80001634:	fec42703          	lw	a4,-20(s0)
80001638:	000017b7          	lui	a5,0x1
8000163c:	00f70733          	add	a4,a4,a5
80001640:	880007b7          	lui	a5,0x88000
80001644:	00078793          	mv	a5,a5
80001648:	fae7fce3          	bgeu	a5,a4,80001600 <minit+0x1c>
    }
}
8000164c:	00000013          	nop
80001650:	00000013          	nop
80001654:	01c12403          	lw	s0,28(sp)
80001658:	02010113          	addi	sp,sp,32
8000165c:	00008067          	ret

80001660 <palloc>:

void *palloc()
{
80001660:	fe010113          	addi	sp,sp,-32
80001664:	00112e23          	sw	ra,28(sp)
80001668:	00812c23          	sw	s0,24(sp)
8000166c:	02010413          	addi	s0,sp,32
    struct pmp *p = (struct pmp *)mem.freelist;
80001670:	8000f7b7          	lui	a5,0x8000f
80001674:	a487a783          	lw	a5,-1464(a5) # 8000ea48 <memend+0xf800ea48>
80001678:	fef42623          	sw	a5,-20(s0)
    if (p)
8000167c:	fec42783          	lw	a5,-20(s0)
80001680:	00078c63          	beqz	a5,80001698 <palloc+0x38>
        mem.freelist = mem.freelist->next;
80001684:	8000f7b7          	lui	a5,0x8000f
80001688:	a487a783          	lw	a5,-1464(a5) # 8000ea48 <memend+0xf800ea48>
8000168c:	0007a703          	lw	a4,0(a5)
80001690:	8000f7b7          	lui	a5,0x8000f
80001694:	a4e7a423          	sw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
    if (p)
80001698:	fec42783          	lw	a5,-20(s0)
8000169c:	00078a63          	beqz	a5,800016b0 <palloc+0x50>
        memset(p, 0, PGSIZE);
800016a0:	00001637          	lui	a2,0x1
800016a4:	00000593          	li	a1,0
800016a8:	fec42503          	lw	a0,-20(s0)
800016ac:	609000ef          	jal	ra,800024b4 <memset>
    return (void *)p;
800016b0:	fec42783          	lw	a5,-20(s0)
}
800016b4:	00078513          	mv	a0,a5
800016b8:	01c12083          	lw	ra,28(sp)
800016bc:	01812403          	lw	s0,24(sp)
800016c0:	02010113          	addi	sp,sp,32
800016c4:	00008067          	ret

800016c8 <pfree>:

void pfree(void *addr)
{
800016c8:	fd010113          	addi	sp,sp,-48
800016cc:	02812623          	sw	s0,44(sp)
800016d0:	03010413          	addi	s0,sp,48
800016d4:	fca42e23          	sw	a0,-36(s0)
    struct pmp *p = (struct pmp *)addr;
800016d8:	fdc42783          	lw	a5,-36(s0)
800016dc:	fef42623          	sw	a5,-20(s0)
    p->next = mem.freelist;
800016e0:	8000f7b7          	lui	a5,0x8000f
800016e4:	a487a703          	lw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
800016e8:	fec42783          	lw	a5,-20(s0)
800016ec:	00e7a023          	sw	a4,0(a5)
    mem.freelist = p;
800016f0:	8000f7b7          	lui	a5,0x8000f
800016f4:	fec42703          	lw	a4,-20(s0)
800016f8:	a4e7a423          	sw	a4,-1464(a5) # 8000ea48 <memend+0xf800ea48>
800016fc:	00000013          	nop
80001700:	02c12403          	lw	s0,44(sp)
80001704:	03010113          	addi	sp,sp,48
80001708:	00008067          	ret

8000170c <r_tp>:
{
8000170c:	fe010113          	addi	sp,sp,-32
80001710:	00812e23          	sw	s0,28(sp)
80001714:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80001718:	00020793          	mv	a5,tp
8000171c:	fef42623          	sw	a5,-20(s0)
    return x;
80001720:	fec42783          	lw	a5,-20(s0)
}
80001724:	00078513          	mv	a0,a5
80001728:	01c12403          	lw	s0,28(sp)
8000172c:	02010113          	addi	sp,sp,32
80001730:	00008067          	ret

80001734 <r_sie>:
 */
#define SEIE (1 << 9)
#define STIE (1 << 5)
#define SSIE (1 << 1)
static inline uint32 r_sie()
{
80001734:	fe010113          	addi	sp,sp,-32
80001738:	00812e23          	sw	s0,28(sp)
8000173c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie "
80001740:	104027f3          	csrr	a5,sie
80001744:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80001748:	fec42783          	lw	a5,-20(s0)
}
8000174c:	00078513          	mv	a0,a5
80001750:	01c12403          	lw	s0,28(sp)
80001754:	02010113          	addi	sp,sp,32
80001758:	00008067          	ret

8000175c <w_sie>:
static inline void w_sie(uint32 x)
{
8000175c:	fe010113          	addi	sp,sp,-32
80001760:	00812e23          	sw	s0,28(sp)
80001764:	02010413          	addi	s0,sp,32
80001768:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"
8000176c:	fec42783          	lw	a5,-20(s0)
80001770:	10479073          	csrw	sie,a5
                 :
                 : "r"(x));
}
80001774:	00000013          	nop
80001778:	01c12403          	lw	s0,28(sp)
8000177c:	02010113          	addi	sp,sp,32
80001780:	00008067          	ret

80001784 <plicinit>:
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit()
{
80001784:	ff010113          	addi	sp,sp,-16
80001788:	00112623          	sw	ra,12(sp)
8000178c:	00812423          	sw	s0,8(sp)
80001790:	01010413          	addi	s0,sp,16
    *(uint32 *)PLIC_PRIORITY(UART_IRQ) = 1; // uart 设置优先级(1~7)，0为关中断
80001794:	0c0007b7          	lui	a5,0xc000
80001798:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
8000179c:	00100713          	li	a4,1
800017a0:	00e7a023          	sw	a4,0(a5)

    *(uint32 *)PLIC_SENABLE(r_tp()) = (1 << UART_IRQ); // uart 开中断
800017a4:	f69ff0ef          	jal	ra,8000170c <r_tp>
800017a8:	00050793          	mv	a5,a0
800017ac:	00879713          	slli	a4,a5,0x8
800017b0:	0c0027b7          	lui	a5,0xc002
800017b4:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
800017b8:	00f707b3          	add	a5,a4,a5
800017bc:	00078713          	mv	a4,a5
800017c0:	40000793          	li	a5,1024
800017c4:	00f72023          	sw	a5,0(a4)
    *(uint32 *)PLIC_MENABLE(r_tp()) = (1 << UART_IRQ); // uart 开中断
800017c8:	f45ff0ef          	jal	ra,8000170c <r_tp>
800017cc:	00050713          	mv	a4,a0
800017d0:	000c07b7          	lui	a5,0xc0
800017d4:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800017d8:	00f707b3          	add	a5,a4,a5
800017dc:	00879793          	slli	a5,a5,0x8
800017e0:	00078713          	mv	a4,a5
800017e4:	40000793          	li	a5,1024
800017e8:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32 *)PLIC_MPRIORITY(r_tp()) = 0;
800017ec:	f21ff0ef          	jal	ra,8000170c <r_tp>
800017f0:	00050713          	mv	a4,a0
800017f4:	000067b7          	lui	a5,0x6
800017f8:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800017fc:	00f707b3          	add	a5,a4,a5
80001800:	00d79793          	slli	a5,a5,0xd
80001804:	0007a023          	sw	zero,0(a5)
    *(uint32 *)PLIC_SPRIORITY(r_tp()) = 0;
80001808:	f05ff0ef          	jal	ra,8000170c <r_tp>
8000180c:	00050793          	mv	a5,a0
80001810:	00d79713          	slli	a4,a5,0xd
80001814:	0c2017b7          	lui	a5,0xc201
80001818:	00f707b3          	add	a5,a4,a5
8000181c:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开S-mode中断
80001820:	f15ff0ef          	jal	ra,80001734 <r_sie>
80001824:	00050793          	mv	a5,a0
80001828:	2227e793          	ori	a5,a5,546
8000182c:	00078513          	mv	a0,a5
80001830:	f2dff0ef          	jal	ra,8000175c <w_sie>
}
80001834:	00000013          	nop
80001838:	00c12083          	lw	ra,12(sp)
8000183c:	00812403          	lw	s0,8(sp)
80001840:	01010113          	addi	sp,sp,16
80001844:	00008067          	ret

80001848 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim()
{
80001848:	ff010113          	addi	sp,sp,-16
8000184c:	00112623          	sw	ra,12(sp)
80001850:	00812423          	sw	s0,8(sp)
80001854:	01010413          	addi	s0,sp,16
    return *(uint32 *)PLIC_SCLAIM(r_tp());
80001858:	eb5ff0ef          	jal	ra,8000170c <r_tp>
8000185c:	00050793          	mv	a5,a0
80001860:	00d79713          	slli	a4,a5,0xd
80001864:	0c2017b7          	lui	a5,0xc201
80001868:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
8000186c:	00f707b3          	add	a5,a4,a5
80001870:	0007a783          	lw	a5,0(a5)
}
80001874:	00078513          	mv	a0,a5
80001878:	00c12083          	lw	ra,12(sp)
8000187c:	00812403          	lw	s0,8(sp)
80001880:	01010113          	addi	sp,sp,16
80001884:	00008067          	ret

80001888 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq)
{
80001888:	fe010113          	addi	sp,sp,-32
8000188c:	00112e23          	sw	ra,28(sp)
80001890:	00812c23          	sw	s0,24(sp)
80001894:	02010413          	addi	s0,sp,32
80001898:	fea42623          	sw	a0,-20(s0)
    *(uint32 *)PLIC_MCOMPLETE(r_tp()) = irq;
8000189c:	e71ff0ef          	jal	ra,8000170c <r_tp>
800018a0:	00050793          	mv	a5,a0
800018a4:	00d79713          	slli	a4,a5,0xd
800018a8:	0c2007b7          	lui	a5,0xc200
800018ac:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
800018b0:	00f707b3          	add	a5,a4,a5
800018b4:	00078713          	mv	a4,a5
800018b8:	fec42783          	lw	a5,-20(s0)
800018bc:	00f72023          	sw	a5,0(a4)
800018c0:	00000013          	nop
800018c4:	01c12083          	lw	ra,28(sp)
800018c8:	01812403          	lw	s0,24(sp)
800018cc:	02010113          	addi	sp,sp,32
800018d0:	00008067          	ret

800018d4 <w_satp>:
{
800018d4:	fe010113          	addi	sp,sp,-32
800018d8:	00812e23          	sw	s0,28(sp)
800018dc:	02010413          	addi	s0,sp,32
800018e0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"
800018e4:	fec42783          	lw	a5,-20(s0)
800018e8:	18079073          	csrw	satp,a5
}
800018ec:	00000013          	nop
800018f0:	01c12403          	lw	s0,28(sp)
800018f4:	02010113          	addi	sp,sp,32
800018f8:	00008067          	ret

800018fc <sfence_vma>:
{
800018fc:	ff010113          	addi	sp,sp,-16
80001900:	00812623          	sw	s0,12(sp)
80001904:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
80001908:	12000073          	sfence.vma
}
8000190c:	00000013          	nop
80001910:	00c12403          	lw	s0,12(sp)
80001914:	01010113          	addi	sp,sp,16
80001918:	00008067          	ret

8000191c <acquriepte>:
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t *acquriepte(addr_t *pgt, addr_t va)
{
8000191c:	fd010113          	addi	sp,sp,-48
80001920:	02112623          	sw	ra,44(sp)
80001924:	02812423          	sw	s0,40(sp)
80001928:	03010413          	addi	s0,sp,48
8000192c:	fca42e23          	sw	a0,-36(s0)
80001930:	fcb42c23          	sw	a1,-40(s0)
    pte_t *pte;
    pte = &pgt[VPN(1, va)]; // 获取一级页表 PTE
80001934:	fd842783          	lw	a5,-40(s0)
80001938:	0167d793          	srli	a5,a5,0x16
8000193c:	00279793          	slli	a5,a5,0x2
80001940:	fdc42703          	lw	a4,-36(s0)
80001944:	00f707b3          	add	a5,a4,a5
80001948:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if (*pte & PTE_V)
8000194c:	fec42783          	lw	a5,-20(s0)
80001950:	0007a783          	lw	a5,0(a5)
80001954:	0017f793          	andi	a5,a5,1
80001958:	00078e63          	beqz	a5,80001974 <acquriepte+0x58>
    { // 已分配页
        pgt = (addr_t *)PTE2PA(*pte);
8000195c:	fec42783          	lw	a5,-20(s0)
80001960:	0007a783          	lw	a5,0(a5)
80001964:	00a7d793          	srli	a5,a5,0xa
80001968:	00c79793          	slli	a5,a5,0xc
8000196c:	fcf42e23          	sw	a5,-36(s0)
80001970:	0340006f          	j	800019a4 <acquriepte+0x88>
    }
    else
    {                             // 未分配页
        pgt = (addr_t *)palloc(); // 二级页表
80001974:	cedff0ef          	jal	ra,80001660 <palloc>
80001978:	fca42e23          	sw	a0,-36(s0)
        memset(pgt, 0, PGSIZE);
8000197c:	00001637          	lui	a2,0x1
80001980:	00000593          	li	a1,0
80001984:	fdc42503          	lw	a0,-36(s0)
80001988:	32d000ef          	jal	ra,800024b4 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
8000198c:	fdc42783          	lw	a5,-36(s0)
80001990:	00c7d793          	srli	a5,a5,0xc
80001994:	00a79793          	slli	a5,a5,0xa
80001998:	0017e713          	ori	a4,a5,1
8000199c:	fec42783          	lw	a5,-20(s0)
800019a0:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0, va)]; // 返回二级页表 PTE
800019a4:	fd842783          	lw	a5,-40(s0)
800019a8:	00c7d793          	srli	a5,a5,0xc
800019ac:	3ff7f793          	andi	a5,a5,1023
800019b0:	00279793          	slli	a5,a5,0x2
800019b4:	fdc42703          	lw	a4,-36(s0)
800019b8:	00f707b3          	add	a5,a4,a5
}
800019bc:	00078513          	mv	a0,a5
800019c0:	02c12083          	lw	ra,44(sp)
800019c4:	02812403          	lw	s0,40(sp)
800019c8:	03010113          	addi	sp,sp,48
800019cc:	00008067          	ret

800019d0 <vmmap>:
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t *pgt, addr_t va, addr_t pa, uint size, uint mode)
{
800019d0:	fc010113          	addi	sp,sp,-64
800019d4:	02112e23          	sw	ra,60(sp)
800019d8:	02812c23          	sw	s0,56(sp)
800019dc:	04010413          	addi	s0,sp,64
800019e0:	fca42e23          	sw	a0,-36(s0)
800019e4:	fcb42c23          	sw	a1,-40(s0)
800019e8:	fcc42a23          	sw	a2,-44(s0)
800019ec:	fcd42823          	sw	a3,-48(s0)
800019f0:	fce42623          	sw	a4,-52(s0)
    pte_t *pte;

    // PPN
    addr_t start = ((va >> 12) << 12);
800019f4:	fd842703          	lw	a4,-40(s0)
800019f8:	fffff7b7          	lui	a5,0xfffff
800019fc:	00f777b3          	and	a5,a4,a5
80001a00:	fef42623          	sw	a5,-20(s0)
    addr_t end = (((va + (size - 1)) >> 12) << 12);
80001a04:	fd042703          	lw	a4,-48(s0)
80001a08:	fd842783          	lw	a5,-40(s0)
80001a0c:	00f707b3          	add	a5,a4,a5
80001a10:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
80001a14:	fffff7b7          	lui	a5,0xfffff
80001a18:	00f777b3          	and	a5,a4,a5
80001a1c:	fef42423          	sw	a5,-24(s0)

    while (1)
    {
        pte = acquriepte(pgt, start);
80001a20:	fec42583          	lw	a1,-20(s0)
80001a24:	fdc42503          	lw	a0,-36(s0)
80001a28:	ef5ff0ef          	jal	ra,8000191c <acquriepte>
80001a2c:	fea42223          	sw	a0,-28(s0)
        if (*pte & PTE_V)
80001a30:	fe442783          	lw	a5,-28(s0)
80001a34:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001a38:	0017f793          	andi	a5,a5,1
80001a3c:	00078863          	beqz	a5,80001a4c <vmmap+0x7c>
            panic("repeat map");
80001a40:	8000d7b7          	lui	a5,0x8000d
80001a44:	42078513          	addi	a0,a5,1056 # 8000d420 <memend+0xf800d420>
80001a48:	f58ff0ef          	jal	ra,800011a0 <panic>
        *pte = PA2PTE(pa) | mode | PTE_V;
80001a4c:	fd442783          	lw	a5,-44(s0)
80001a50:	00c7d793          	srli	a5,a5,0xc
80001a54:	00a79713          	slli	a4,a5,0xa
80001a58:	fcc42783          	lw	a5,-52(s0)
80001a5c:	00f767b3          	or	a5,a4,a5
80001a60:	0017e713          	ori	a4,a5,1
80001a64:	fe442783          	lw	a5,-28(s0)
80001a68:	00e7a023          	sw	a4,0(a5)
        if (start == end)
80001a6c:	fec42703          	lw	a4,-20(s0)
80001a70:	fe842783          	lw	a5,-24(s0)
80001a74:	02f70463          	beq	a4,a5,80001a9c <vmmap+0xcc>
            break;
        start += PGSIZE;
80001a78:	fec42703          	lw	a4,-20(s0)
80001a7c:	000017b7          	lui	a5,0x1
80001a80:	00f707b3          	add	a5,a4,a5
80001a84:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001a88:	fd442703          	lw	a4,-44(s0)
80001a8c:	000017b7          	lui	a5,0x1
80001a90:	00f707b3          	add	a5,a4,a5
80001a94:	fcf42a23          	sw	a5,-44(s0)
        pte = acquriepte(pgt, start);
80001a98:	f89ff06f          	j	80001a20 <vmmap+0x50>
            break;
80001a9c:	00000013          	nop
    }
}
80001aa0:	00000013          	nop
80001aa4:	03c12083          	lw	ra,60(sp)
80001aa8:	03812403          	lw	s0,56(sp)
80001aac:	04010113          	addi	sp,sp,64
80001ab0:	00008067          	ret

80001ab4 <printpgt>:

void printpgt(addr_t *pgt)
{
80001ab4:	fc010113          	addi	sp,sp,-64
80001ab8:	02112e23          	sw	ra,60(sp)
80001abc:	02812c23          	sw	s0,56(sp)
80001ac0:	04010413          	addi	s0,sp,64
80001ac4:	fca42623          	sw	a0,-52(s0)
    for (int i = 0; i < 1024; i++)
80001ac8:	fe042623          	sw	zero,-20(s0)
80001acc:	0c40006f          	j	80001b90 <printpgt+0xdc>
    {
        pte_t pte = pgt[i];
80001ad0:	fec42783          	lw	a5,-20(s0)
80001ad4:	00279793          	slli	a5,a5,0x2
80001ad8:	fcc42703          	lw	a4,-52(s0)
80001adc:	00f707b3          	add	a5,a4,a5
80001ae0:	0007a783          	lw	a5,0(a5) # 1000 <sz>
80001ae4:	fef42223          	sw	a5,-28(s0)
        if (pte & PTE_V)
80001ae8:	fe442783          	lw	a5,-28(s0)
80001aec:	0017f793          	andi	a5,a5,1
80001af0:	08078a63          	beqz	a5,80001b84 <printpgt+0xd0>
        {
            addr_t *pgt2 = (addr_t *)PTE2PA(pte);
80001af4:	fe442783          	lw	a5,-28(s0)
80001af8:	00a7d793          	srli	a5,a5,0xa
80001afc:	00c79793          	slli	a5,a5,0xc
80001b00:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n", i, pte, pgt2);
80001b04:	fe042683          	lw	a3,-32(s0)
80001b08:	fe442603          	lw	a2,-28(s0)
80001b0c:	fec42583          	lw	a1,-20(s0)
80001b10:	8000d7b7          	lui	a5,0x8000d
80001b14:	42c78513          	addi	a0,a5,1068 # 8000d42c <memend+0xf800d42c>
80001b18:	ec0ff0ef          	jal	ra,800011d8 <printf>
            for (int j = 0; j < 1024; j++)
80001b1c:	fe042423          	sw	zero,-24(s0)
80001b20:	0580006f          	j	80001b78 <printpgt+0xc4>
            {
                pte_t pte2 = pgt2[j];
80001b24:	fe842783          	lw	a5,-24(s0)
80001b28:	00279793          	slli	a5,a5,0x2
80001b2c:	fe042703          	lw	a4,-32(s0)
80001b30:	00f707b3          	add	a5,a4,a5
80001b34:	0007a783          	lw	a5,0(a5)
80001b38:	fcf42e23          	sw	a5,-36(s0)
                if (pte2 & PTE_V)
80001b3c:	fdc42783          	lw	a5,-36(s0)
80001b40:	0017f793          	andi	a5,a5,1
80001b44:	02078463          	beqz	a5,80001b6c <printpgt+0xb8>
                {
                    printf(".. ..%d: pte %p pa %p\n", j, pte2, PTE2PA(pte2));
80001b48:	fdc42783          	lw	a5,-36(s0)
80001b4c:	00a7d793          	srli	a5,a5,0xa
80001b50:	00c79793          	slli	a5,a5,0xc
80001b54:	00078693          	mv	a3,a5
80001b58:	fdc42603          	lw	a2,-36(s0)
80001b5c:	fe842583          	lw	a1,-24(s0)
80001b60:	8000d7b7          	lui	a5,0x8000d
80001b64:	44478513          	addi	a0,a5,1092 # 8000d444 <memend+0xf800d444>
80001b68:	e70ff0ef          	jal	ra,800011d8 <printf>
            for (int j = 0; j < 1024; j++)
80001b6c:	fe842783          	lw	a5,-24(s0)
80001b70:	00178793          	addi	a5,a5,1
80001b74:	fef42423          	sw	a5,-24(s0)
80001b78:	fe842703          	lw	a4,-24(s0)
80001b7c:	3ff00793          	li	a5,1023
80001b80:	fae7d2e3          	bge	a5,a4,80001b24 <printpgt+0x70>
    for (int i = 0; i < 1024; i++)
80001b84:	fec42783          	lw	a5,-20(s0)
80001b88:	00178793          	addi	a5,a5,1
80001b8c:	fef42623          	sw	a5,-20(s0)
80001b90:	fec42703          	lw	a4,-20(s0)
80001b94:	3ff00793          	li	a5,1023
80001b98:	f2e7dce3          	bge	a5,a4,80001ad0 <printpgt+0x1c>
                }
            }
        }
    }
}
80001b9c:	00000013          	nop
80001ba0:	00000013          	nop
80001ba4:	03c12083          	lw	ra,60(sp)
80001ba8:	03812403          	lw	s0,56(sp)
80001bac:	04010113          	addi	sp,sp,64
80001bb0:	00008067          	ret

80001bb4 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t *pgt)
{
80001bb4:	fd010113          	addi	sp,sp,-48
80001bb8:	02112623          	sw	ra,44(sp)
80001bbc:	02812423          	sw	s0,40(sp)
80001bc0:	03010413          	addi	s0,sp,48
80001bc4:	fca42e23          	sw	a0,-36(s0)
    for (int i = 0; i < NPROC; i++)
80001bc8:	fe042623          	sw	zero,-20(s0)
80001bcc:	04c0006f          	j	80001c18 <mkstack+0x64>
    {
        addr_t va = (addr_t)(KSPACE + PGSIZE + (i)*2 * PGSIZE);
80001bd0:	fec42783          	lw	a5,-20(s0)
80001bd4:	00d79793          	slli	a5,a5,0xd
80001bd8:	00078713          	mv	a4,a5
80001bdc:	c00017b7          	lui	a5,0xc0001
80001be0:	00f707b3          	add	a5,a4,a5
80001be4:	fef42423          	sw	a5,-24(s0)
        addr_t pa = (addr_t)palloc(); //! 待处理
80001be8:	a79ff0ef          	jal	ra,80001660 <palloc>
80001bec:	00050793          	mv	a5,a0
80001bf0:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt, va, pa, PGSIZE, PTE_R | PTE_W);
80001bf4:	00600713          	li	a4,6
80001bf8:	000016b7          	lui	a3,0x1
80001bfc:	fe442603          	lw	a2,-28(s0)
80001c00:	fe842583          	lw	a1,-24(s0)
80001c04:	fdc42503          	lw	a0,-36(s0)
80001c08:	dc9ff0ef          	jal	ra,800019d0 <vmmap>
    for (int i = 0; i < NPROC; i++)
80001c0c:	fec42783          	lw	a5,-20(s0)
80001c10:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
80001c14:	fef42623          	sw	a5,-20(s0)
80001c18:	fec42703          	lw	a4,-20(s0)
80001c1c:	00300793          	li	a5,3
80001c20:	fae7d8e3          	bge	a5,a4,80001bd0 <mkstack+0x1c>
    }
}
80001c24:	00000013          	nop
80001c28:	00000013          	nop
80001c2c:	02c12083          	lw	ra,44(sp)
80001c30:	02812403          	lw	s0,40(sp)
80001c34:	03010113          	addi	sp,sp,48
80001c38:	00008067          	ret

80001c3c <kvminit>:

// 初始化虚拟内存
void kvminit()
{
80001c3c:	ff010113          	addi	sp,sp,-16
80001c40:	00112623          	sw	ra,12(sp)
80001c44:	00812423          	sw	s0,8(sp)
80001c48:	01010413          	addi	s0,sp,16
    kpgt = (addr_t *)palloc();
80001c4c:	a15ff0ef          	jal	ra,80001660 <palloc>
80001c50:	00050713          	mv	a4,a0
80001c54:	8000f7b7          	lui	a5,0x8000f
80001c58:	a4e7a623          	sw	a4,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
    memset(kpgt, 0, PGSIZE);
80001c5c:	8000f7b7          	lui	a5,0x8000f
80001c60:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001c64:	00001637          	lui	a2,0x1
80001c68:	00000593          	li	a1,0
80001c6c:	00078513          	mv	a0,a5
80001c70:	045000ef          	jal	ra,800024b4 <memset>

    // 映射 CLINT
    vmmap(kpgt, CLINT_BASE, CLINT_BASE, 0xc000, PTE_R | PTE_W);
80001c74:	8000f7b7          	lui	a5,0x8000f
80001c78:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001c7c:	00600713          	li	a4,6
80001c80:	0000c6b7          	lui	a3,0xc
80001c84:	02000637          	lui	a2,0x2000
80001c88:	020005b7          	lui	a1,0x2000
80001c8c:	00078513          	mv	a0,a5
80001c90:	d41ff0ef          	jal	ra,800019d0 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt, PLIC_BASE, PLIC_BASE, 0x400000, PTE_R | PTE_W);
80001c94:	8000f7b7          	lui	a5,0x8000f
80001c98:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001c9c:	00600713          	li	a4,6
80001ca0:	004006b7          	lui	a3,0x400
80001ca4:	0c000637          	lui	a2,0xc000
80001ca8:	0c0005b7          	lui	a1,0xc000
80001cac:	00078513          	mv	a0,a5
80001cb0:	d21ff0ef          	jal	ra,800019d0 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt, UART_BASE, UART_BASE, PGSIZE, PTE_R | PTE_W);
80001cb4:	8000f7b7          	lui	a5,0x8000f
80001cb8:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001cbc:	00600713          	li	a4,6
80001cc0:	000016b7          	lui	a3,0x1
80001cc4:	10000637          	lui	a2,0x10000
80001cc8:	100005b7          	lui	a1,0x10000
80001ccc:	00078513          	mv	a0,a5
80001cd0:	d01ff0ef          	jal	ra,800019d0 <vmmap>

    // 映射 VIRTIO_MMIO
    vmmap(kpgt, VIRTIO_BASE, VIRTIO_BASE, PGSIZE, PTE_R | PTE_W);
80001cd4:	8000f7b7          	lui	a5,0x8000f
80001cd8:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001cdc:	00600713          	li	a4,6
80001ce0:	000016b7          	lui	a3,0x1
80001ce4:	10001637          	lui	a2,0x10001
80001ce8:	100015b7          	lui	a1,0x10001
80001cec:	00078513          	mv	a0,a5
80001cf0:	ce1ff0ef          	jal	ra,800019d0 <vmmap>

    // 映射 内核 指令区
    vmmap(kpgt, (addr_t)textstart, (addr_t)textstart, (textend - textstart), PTE_R | PTE_X);
80001cf4:	8000f7b7          	lui	a5,0x8000f
80001cf8:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001cfc:	800007b7          	lui	a5,0x80000
80001d00:	00078593          	mv	a1,a5
80001d04:	800007b7          	lui	a5,0x80000
80001d08:	00078613          	mv	a2,a5
80001d0c:	800037b7          	lui	a5,0x80003
80001d10:	48878713          	addi	a4,a5,1160 # 80003488 <memend+0xf8003488>
80001d14:	800007b7          	lui	a5,0x80000
80001d18:	00078793          	mv	a5,a5
80001d1c:	40f707b3          	sub	a5,a4,a5
80001d20:	00a00713          	li	a4,10
80001d24:	00078693          	mv	a3,a5
80001d28:	ca9ff0ef          	jal	ra,800019d0 <vmmap>
    // 映射 数据区
    vmmap(kpgt, (addr_t)datastart, (addr_t)datastart, dataend - datastart, PTE_R | PTE_W);
80001d2c:	8000f7b7          	lui	a5,0x8000f
80001d30:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001d34:	800047b7          	lui	a5,0x80004
80001d38:	00078593          	mv	a1,a5
80001d3c:	800047b7          	lui	a5,0x80004
80001d40:	00078613          	mv	a2,a5
80001d44:	8000c7b7          	lui	a5,0x8000c
80001d48:	02478713          	addi	a4,a5,36 # 8000c024 <memend+0xf800c024>
80001d4c:	800047b7          	lui	a5,0x80004
80001d50:	00078793          	mv	a5,a5
80001d54:	40f707b3          	sub	a5,a4,a5
80001d58:	00600713          	li	a4,6
80001d5c:	00078693          	mv	a3,a5
80001d60:	c71ff0ef          	jal	ra,800019d0 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt, (addr_t)rodatastart, (addr_t)rodatastart, (rodataend - rodatastart), PTE_R);
80001d64:	8000f7b7          	lui	a5,0x8000f
80001d68:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001d6c:	8000d7b7          	lui	a5,0x8000d
80001d70:	00078593          	mv	a1,a5
80001d74:	8000d7b7          	lui	a5,0x8000d
80001d78:	00078613          	mv	a2,a5
80001d7c:	8000d7b7          	lui	a5,0x8000d
80001d80:	53a78713          	addi	a4,a5,1338 # 8000d53a <memend+0xf800d53a>
80001d84:	8000d7b7          	lui	a5,0x8000d
80001d88:	00078793          	mv	a5,a5
80001d8c:	40f707b3          	sub	a5,a4,a5
80001d90:	00200713          	li	a4,2
80001d94:	00078693          	mv	a3,a5
80001d98:	c39ff0ef          	jal	ra,800019d0 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt, (addr_t)bssstart, (addr_t)bssstart, bssend - bssstart, PTE_R | PTE_W);
80001d9c:	8000f7b7          	lui	a5,0x8000f
80001da0:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001da4:	8000e7b7          	lui	a5,0x8000e
80001da8:	00078593          	mv	a1,a5
80001dac:	8000e7b7          	lui	a5,0x8000e
80001db0:	00078613          	mv	a2,a5
80001db4:	800137b7          	lui	a5,0x80013
80001db8:	c6878713          	addi	a4,a5,-920 # 80012c68 <memend+0xf8012c68>
80001dbc:	8000e7b7          	lui	a5,0x8000e
80001dc0:	00078793          	mv	a5,a5
80001dc4:	40f707b3          	sub	a5,a4,a5
80001dc8:	00600713          	li	a4,6
80001dcc:	00078693          	mv	a3,a5
80001dd0:	c01ff0ef          	jal	ra,800019d0 <vmmap>

    // 映射空闲内存区
    vmmap(kpgt, (addr_t)mstart, (addr_t)mstart, mend - mstart, PTE_W | PTE_R);
80001dd4:	8000f7b7          	lui	a5,0x8000f
80001dd8:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001ddc:	800137b7          	lui	a5,0x80013
80001de0:	00078593          	mv	a1,a5
80001de4:	800137b7          	lui	a5,0x80013
80001de8:	00078613          	mv	a2,a5
80001dec:	880007b7          	lui	a5,0x88000
80001df0:	00078713          	mv	a4,a5
80001df4:	800137b7          	lui	a5,0x80013
80001df8:	00078793          	mv	a5,a5
80001dfc:	40f707b3          	sub	a5,a4,a5
80001e00:	00600713          	li	a4,6
80001e04:	00078693          	mv	a3,a5
80001e08:	bc9ff0ef          	jal	ra,800019d0 <vmmap>

    mkstack(kpgt);
80001e0c:	8000f7b7          	lui	a5,0x8000f
80001e10:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001e14:	00078513          	mv	a0,a5
80001e18:	d9dff0ef          	jal	ra,80001bb4 <mkstack>

    // 映射 usertrap
    vmmap(kpgt, USERVEC, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80001e1c:	8000f7b7          	lui	a5,0x8000f
80001e20:	a4c7a503          	lw	a0,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001e24:	800007b7          	lui	a5,0x80000
80001e28:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001e2c:	00a00713          	li	a4,10
80001e30:	000016b7          	lui	a3,0x1
80001e34:	00078613          	mv	a2,a5
80001e38:	fffff5b7          	lui	a1,0xfffff
80001e3c:	b95ff0ef          	jal	ra,800019d0 <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32 | (((uint32)kpgt) >> 12)); // 页表 PPN 写入Satp
80001e40:	8000f7b7          	lui	a5,0x8000f
80001e44:	a4c7a783          	lw	a5,-1460(a5) # 8000ea4c <memend+0xf800ea4c>
80001e48:	00c7d713          	srli	a4,a5,0xc
80001e4c:	800007b7          	lui	a5,0x80000
80001e50:	00f767b3          	or	a5,a4,a5
80001e54:	00078513          	mv	a0,a5
80001e58:	a7dff0ef          	jal	ra,800018d4 <w_satp>
    sfence_vma();                               // 刷新页表
80001e5c:	aa1ff0ef          	jal	ra,800018fc <sfence_vma>
}
80001e60:	00000013          	nop
80001e64:	00c12083          	lw	ra,12(sp)
80001e68:	00812403          	lw	s0,8(sp)
80001e6c:	01010113          	addi	sp,sp,16
80001e70:	00008067          	ret

80001e74 <pgtcreate>:

addr_t *pgtcreate()
{
80001e74:	fe010113          	addi	sp,sp,-32
80001e78:	00112e23          	sw	ra,28(sp)
80001e7c:	00812c23          	sw	s0,24(sp)
80001e80:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t *pgt = (addr_t *)palloc();
80001e84:	fdcff0ef          	jal	ra,80001660 <palloc>
80001e88:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001e8c:	fec42783          	lw	a5,-20(s0)
}
80001e90:	00078513          	mv	a0,a5
80001e94:	01c12083          	lw	ra,28(sp)
80001e98:	01812403          	lw	s0,24(sp)
80001e9c:	02010113          	addi	sp,sp,32
80001ea0:	00008067          	ret

80001ea4 <r_tp>:
{
80001ea4:	fe010113          	addi	sp,sp,-32
80001ea8:	00812e23          	sw	s0,28(sp)
80001eac:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80001eb0:	00020793          	mv	a5,tp
80001eb4:	fef42623          	sw	a5,-20(s0)
    return x;
80001eb8:	fec42783          	lw	a5,-20(s0)
}
80001ebc:	00078513          	mv	a0,a5
80001ec0:	01c12403          	lw	s0,28(sp)
80001ec4:	02010113          	addi	sp,sp,32
80001ec8:	00008067          	ret

80001ecc <procinit>:
#include "syscall.h"

uint nextpid = 0;

void procinit()
{
80001ecc:	fe010113          	addi	sp,sp,-32
80001ed0:	00812e23          	sw	s0,28(sp)
80001ed4:	02010413          	addi	s0,sp,32
    struct pcb *p;
    for (int i = 0; i < NPROC; i++)
80001ed8:	fe042623          	sw	zero,-20(s0)
80001edc:	0500006f          	j	80001f2c <procinit+0x60>
    {
        p = &proc[i];
80001ee0:	fec42703          	lw	a4,-20(s0)
80001ee4:	00070793          	mv	a5,a4
80001ee8:	00379793          	slli	a5,a5,0x3
80001eec:	00e787b3          	add	a5,a5,a4
80001ef0:	00479793          	slli	a5,a5,0x4
80001ef4:	8000e737          	lui	a4,0x8000e
80001ef8:	40870713          	addi	a4,a4,1032 # 8000e408 <memend+0xf800e408>
80001efc:	00e787b3          	add	a5,a5,a4
80001f00:	fef42423          	sw	a5,-24(s0)
        p->kernelstack = (addr_t)(KSTACK + (i)*2 * PGSIZE);
80001f04:	fec42783          	lw	a5,-20(s0)
80001f08:	00d79793          	slli	a5,a5,0xd
80001f0c:	00078713          	mv	a4,a5
80001f10:	c00027b7          	lui	a5,0xc0002
80001f14:	00f70733          	add	a4,a4,a5
80001f18:	fe842783          	lw	a5,-24(s0)
80001f1c:	08e7a623          	sw	a4,140(a5) # c000208c <memend+0x3800208c>
    for (int i = 0; i < NPROC; i++)
80001f20:	fec42783          	lw	a5,-20(s0)
80001f24:	00178793          	addi	a5,a5,1
80001f28:	fef42623          	sw	a5,-20(s0)
80001f2c:	fec42703          	lw	a4,-20(s0)
80001f30:	00300793          	li	a5,3
80001f34:	fae7d6e3          	bge	a5,a4,80001ee0 <procinit+0x14>
    }
}
80001f38:	00000013          	nop
80001f3c:	00000013          	nop
80001f40:	01c12403          	lw	s0,28(sp)
80001f44:	02010113          	addi	sp,sp,32
80001f48:	00008067          	ret

80001f4c <nowproc>:

struct pcb *nowproc()
{
80001f4c:	fe010113          	addi	sp,sp,-32
80001f50:	00112e23          	sw	ra,28(sp)
80001f54:	00812c23          	sw	s0,24(sp)
80001f58:	02010413          	addi	s0,sp,32
    int hart = r_tp();
80001f5c:	f49ff0ef          	jal	ra,80001ea4 <r_tp>
80001f60:	00050793          	mv	a5,a0
80001f64:	fef42623          	sw	a5,-20(s0)
    return cpus[hart].proc;
80001f68:	8000e7b7          	lui	a5,0x8000e
80001f6c:	64878713          	addi	a4,a5,1608 # 8000e648 <memend+0xf800e648>
80001f70:	fec42783          	lw	a5,-20(s0)
80001f74:	00779793          	slli	a5,a5,0x7
80001f78:	00f707b3          	add	a5,a4,a5
80001f7c:	0007a783          	lw	a5,0(a5)
}
80001f80:	00078513          	mv	a0,a5
80001f84:	01c12083          	lw	ra,28(sp)
80001f88:	01812403          	lw	s0,24(sp)
80001f8c:	02010113          	addi	sp,sp,32
80001f90:	00008067          	ret

80001f94 <nowcpu>:

struct cpu *nowcpu()
{
80001f94:	fe010113          	addi	sp,sp,-32
80001f98:	00112e23          	sw	ra,28(sp)
80001f9c:	00812c23          	sw	s0,24(sp)
80001fa0:	02010413          	addi	s0,sp,32
    int hart = r_tp();
80001fa4:	f01ff0ef          	jal	ra,80001ea4 <r_tp>
80001fa8:	00050793          	mv	a5,a0
80001fac:	fef42623          	sw	a5,-20(s0)
    return &cpus[hart];
80001fb0:	fec42783          	lw	a5,-20(s0)
80001fb4:	00779713          	slli	a4,a5,0x7
80001fb8:	8000e7b7          	lui	a5,0x8000e
80001fbc:	64878793          	addi	a5,a5,1608 # 8000e648 <memend+0xf800e648>
80001fc0:	00f707b3          	add	a5,a4,a5
}
80001fc4:	00078513          	mv	a0,a5
80001fc8:	01c12083          	lw	ra,28(sp)
80001fcc:	01812403          	lw	s0,24(sp)
80001fd0:	02010113          	addi	sp,sp,32
80001fd4:	00008067          	ret

80001fd8 <pidalloc>:

uint pidalloc()
{
80001fd8:	ff010113          	addi	sp,sp,-16
80001fdc:	00812623          	sw	s0,12(sp)
80001fe0:	01010413          	addi	s0,sp,16
    return nextpid++;
80001fe4:	8000e7b7          	lui	a5,0x8000e
80001fe8:	0007a783          	lw	a5,0(a5) # 8000e000 <memend+0xf800e000>
80001fec:	00178693          	addi	a3,a5,1
80001ff0:	8000e737          	lui	a4,0x8000e
80001ff4:	00d72023          	sw	a3,0(a4) # 8000e000 <memend+0xf800e000>
}
80001ff8:	00078513          	mv	a0,a5
80001ffc:	00c12403          	lw	s0,12(sp)
80002000:	01010113          	addi	sp,sp,16
80002004:	00008067          	ret

80002008 <procalloc>:

struct pcb *procalloc()
{
80002008:	fe010113          	addi	sp,sp,-32
8000200c:	00112e23          	sw	ra,28(sp)
80002010:	00812c23          	sw	s0,24(sp)
80002014:	02010413          	addi	s0,sp,32
    struct pcb *p;
    for (p = proc; p < &proc[NPROC]; p++)
80002018:	8000e7b7          	lui	a5,0x8000e
8000201c:	40878793          	addi	a5,a5,1032 # 8000e408 <memend+0xf800e408>
80002020:	fef42623          	sw	a5,-20(s0)
80002024:	0680006f          	j	8000208c <procalloc+0x84>
    {
        if (p->status == UNUSED)
80002028:	fec42783          	lw	a5,-20(s0)
8000202c:	0047a783          	lw	a5,4(a5)
80002030:	04079863          	bnez	a5,80002080 <procalloc+0x78>
        {
            p->trapframe = (struct trapframe *)palloc(sizeof(struct trapframe));
80002034:	08c00513          	li	a0,140
80002038:	e28ff0ef          	jal	ra,80001660 <palloc>
8000203c:	00050713          	mv	a4,a0
80002040:	fec42783          	lw	a5,-20(s0)
80002044:	00e7a423          	sw	a4,8(a5)

            p->pid = pidalloc();
80002048:	f91ff0ef          	jal	ra,80001fd8 <pidalloc>
8000204c:	00050793          	mv	a5,a0
80002050:	00078713          	mv	a4,a5
80002054:	fec42783          	lw	a5,-20(s0)
80002058:	00e7a023          	sw	a4,0(a5)
            p->status = USED;
8000205c:	fec42783          	lw	a5,-20(s0)
80002060:	00100713          	li	a4,1
80002064:	00e7a223          	sw	a4,4(a5)

            p->pagetable = pgtcreate();
80002068:	e0dff0ef          	jal	ra,80001e74 <pgtcreate>
8000206c:	00050713          	mv	a4,a0
80002070:	fec42783          	lw	a5,-20(s0)
80002074:	08e7a423          	sw	a4,136(a5)

            return p;
80002078:	fec42783          	lw	a5,-20(s0)
8000207c:	0240006f          	j	800020a0 <procalloc+0x98>
    for (p = proc; p < &proc[NPROC]; p++)
80002080:	fec42783          	lw	a5,-20(s0)
80002084:	09078793          	addi	a5,a5,144
80002088:	fef42623          	sw	a5,-20(s0)
8000208c:	fec42703          	lw	a4,-20(s0)
80002090:	8000e7b7          	lui	a5,0x8000e
80002094:	64878793          	addi	a5,a5,1608 # 8000e648 <memend+0xf800e648>
80002098:	f8f768e3          	bltu	a4,a5,80002028 <procalloc+0x20>
        }
    }
    return 0;
8000209c:	00000793          	li	a5,0
}
800020a0:	00078513          	mv	a0,a5
800020a4:	01c12083          	lw	ra,28(sp)
800020a8:	01812403          	lw	s0,24(sp)
800020ac:	02010113          	addi	sp,sp,32
800020b0:	00008067          	ret

800020b4 <userinit>:
    0x73, 0x00, 0x00, 0x00,
    0x6f, 0x00, 0x00, 0x00};

// 初始化第一个进程
void userinit()
{
800020b4:	fe010113          	addi	sp,sp,-32
800020b8:	00112e23          	sw	ra,28(sp)
800020bc:	00812c23          	sw	s0,24(sp)
800020c0:	02010413          	addi	s0,sp,32
    struct pcb *p = procalloc();
800020c4:	f45ff0ef          	jal	ra,80002008 <procalloc>
800020c8:	fea42623          	sw	a0,-20(s0)

    p->trapframe->epc = 0;
800020cc:	fec42783          	lw	a5,-20(s0)
800020d0:	0087a783          	lw	a5,8(a5)
800020d4:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp = PGSIZE;
800020d8:	fec42783          	lw	a5,-20(s0)
800020dc:	0087a783          	lw	a5,8(a5)
800020e0:	00001737          	lui	a4,0x1
800020e4:	00e7aa23          	sw	a4,20(a5)

    char *m = (char *)palloc();
800020e8:	d78ff0ef          	jal	ra,80001660 <palloc>
800020ec:	fea42423          	sw	a0,-24(s0)
    memmove(m, zeroproc, sizeof(zeroproc));
800020f0:	00c00613          	li	a2,12
800020f4:	00000693          	li	a3,0
800020f8:	8000c7b7          	lui	a5,0x8000c
800020fc:	00078593          	mv	a1,a5
80002100:	fe842503          	lw	a0,-24(s0)
80002104:	41c000ef          	jal	ra,80002520 <memmove>

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
80002108:	fec42783          	lw	a5,-20(s0)
8000210c:	0887a783          	lw	a5,136(a5) # 8000c088 <memend+0xf800c088>
80002110:	fe842603          	lw	a2,-24(s0)
80002114:	01e00713          	li	a4,30
80002118:	000016b7          	lui	a3,0x1
8000211c:	00000593          	li	a1,0
80002120:	00078513          	mv	a0,a5
80002124:	8adff0ef          	jal	ra,800019d0 <vmmap>
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80002128:	fec42783          	lw	a5,-20(s0)
8000212c:	0887a503          	lw	a0,136(a5)
80002130:	800007b7          	lui	a5,0x80000
80002134:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80002138:	800007b7          	lui	a5,0x80000
8000213c:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80002140:	00a00713          	li	a4,10
80002144:	000016b7          	lui	a3,0x1
80002148:	00078613          	mv	a2,a5
8000214c:	885ff0ef          	jal	ra,800019d0 <vmmap>

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
80002150:	fec42783          	lw	a5,-20(s0)
80002154:	0887a503          	lw	a0,136(a5)
80002158:	fec42783          	lw	a5,-20(s0)
8000215c:	0087a783          	lw	a5,8(a5)
80002160:	00600713          	li	a4,6
80002164:	000016b7          	lui	a3,0x1
80002168:	00078613          	mv	a2,a5
8000216c:	ffffe5b7          	lui	a1,0xffffe
80002170:	861ff0ef          	jal	ra,800019d0 <vmmap>

    p->pagetable = (addr_t *)p->pagetable;
80002174:	fec42783          	lw	a5,-20(s0)
80002178:	0887a703          	lw	a4,136(a5)
8000217c:	fec42783          	lw	a5,-20(s0)
80002180:	08e7a423          	sw	a4,136(a5)

    p->status = RUNABLE;
80002184:	fec42783          	lw	a5,-20(s0)
80002188:	00200713          	li	a4,2
8000218c:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
80002190:	fec42783          	lw	a5,-20(s0)
80002194:	0887a783          	lw	a5,136(a5)
80002198:	00078513          	mv	a0,a5
8000219c:	a19ff0ef          	jal	ra,80001bb4 <mkstack>

    p->context.ra = (reg_t)usertrapret;
800021a0:	800017b7          	lui	a5,0x80001
800021a4:	dec78713          	addi	a4,a5,-532 # 80000dec <memend+0xf8000dec>
800021a8:	fec42783          	lw	a5,-20(s0)
800021ac:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
800021b0:	fec42783          	lw	a5,-20(s0)
800021b4:	08c7a703          	lw	a4,140(a5)
800021b8:	fec42783          	lw	a5,-20(s0)
800021bc:	00e7a823          	sw	a4,16(a5)

    p = procalloc();
800021c0:	e49ff0ef          	jal	ra,80002008 <procalloc>
800021c4:	fea42623          	sw	a0,-20(s0)
    p->context.ra = (reg_t)usertrapret;
800021c8:	800017b7          	lui	a5,0x80001
800021cc:	dec78713          	addi	a4,a5,-532 # 80000dec <memend+0xf8000dec>
800021d0:	fec42783          	lw	a5,-20(s0)
800021d4:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
800021d8:	fec42783          	lw	a5,-20(s0)
800021dc:	08c7a703          	lw	a4,140(a5)
800021e0:	fec42783          	lw	a5,-20(s0)
800021e4:	00e7a823          	sw	a4,16(a5)

    p->trapframe->epc = 0;
800021e8:	fec42783          	lw	a5,-20(s0)
800021ec:	0087a783          	lw	a5,8(a5)
800021f0:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp = PGSIZE;
800021f4:	fec42783          	lw	a5,-20(s0)
800021f8:	0087a783          	lw	a5,8(a5)
800021fc:	00001737          	lui	a4,0x1
80002200:	00e7aa23          	sw	a4,20(a5)

    m = (char *)palloc();
80002204:	c5cff0ef          	jal	ra,80001660 <palloc>
80002208:	fea42423          	sw	a0,-24(s0)
    memmove(m, firstproc, sizeof(zeroproc));
8000220c:	00c00613          	li	a2,12
80002210:	00000693          	li	a3,0
80002214:	8000c7b7          	lui	a5,0x8000c
80002218:	00c78593          	addi	a1,a5,12 # 8000c00c <memend+0xf800c00c>
8000221c:	fe842503          	lw	a0,-24(s0)
80002220:	300000ef          	jal	ra,80002520 <memmove>

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
80002224:	fec42783          	lw	a5,-20(s0)
80002228:	0887a783          	lw	a5,136(a5)
8000222c:	fe842603          	lw	a2,-24(s0)
80002230:	01e00713          	li	a4,30
80002234:	000016b7          	lui	a3,0x1
80002238:	00000593          	li	a1,0
8000223c:	00078513          	mv	a0,a5
80002240:	f90ff0ef          	jal	ra,800019d0 <vmmap>
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80002244:	fec42783          	lw	a5,-20(s0)
80002248:	0887a503          	lw	a0,136(a5)
8000224c:	800007b7          	lui	a5,0x80000
80002250:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80002254:	800007b7          	lui	a5,0x80000
80002258:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
8000225c:	00a00713          	li	a4,10
80002260:	000016b7          	lui	a3,0x1
80002264:	00078613          	mv	a2,a5
80002268:	f68ff0ef          	jal	ra,800019d0 <vmmap>

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
8000226c:	fec42783          	lw	a5,-20(s0)
80002270:	0887a503          	lw	a0,136(a5)
80002274:	fec42783          	lw	a5,-20(s0)
80002278:	0087a783          	lw	a5,8(a5)
8000227c:	00600713          	li	a4,6
80002280:	000016b7          	lui	a3,0x1
80002284:	00078613          	mv	a2,a5
80002288:	ffffe5b7          	lui	a1,0xffffe
8000228c:	f44ff0ef          	jal	ra,800019d0 <vmmap>

    p->pagetable = (addr_t *)p->pagetable;
80002290:	fec42783          	lw	a5,-20(s0)
80002294:	0887a703          	lw	a4,136(a5)
80002298:	fec42783          	lw	a5,-20(s0)
8000229c:	08e7a423          	sw	a4,136(a5)

    p->status = RUNABLE;
800022a0:	fec42783          	lw	a5,-20(s0)
800022a4:	00200713          	li	a4,2
800022a8:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
800022ac:	fec42783          	lw	a5,-20(s0)
800022b0:	0887a783          	lw	a5,136(a5)
800022b4:	00078513          	mv	a0,a5
800022b8:	8fdff0ef          	jal	ra,80001bb4 <mkstack>

    p->context.ra = (reg_t)usertrapret;
800022bc:	800017b7          	lui	a5,0x80001
800022c0:	dec78713          	addi	a4,a5,-532 # 80000dec <memend+0xf8000dec>
800022c4:	fec42783          	lw	a5,-20(s0)
800022c8:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
800022cc:	fec42783          	lw	a5,-20(s0)
800022d0:	08c7a703          	lw	a4,140(a5)
800022d4:	fec42783          	lw	a5,-20(s0)
800022d8:	00e7a823          	sw	a4,16(a5)
}
800022dc:	00000013          	nop
800022e0:	01c12083          	lw	ra,28(sp)
800022e4:	01812403          	lw	s0,24(sp)
800022e8:	02010113          	addi	sp,sp,32
800022ec:	00008067          	ret

800022f0 <schedule>:

void schedule()
{
800022f0:	fe010113          	addi	sp,sp,-32
800022f4:	00112e23          	sw	ra,28(sp)
800022f8:	00812c23          	sw	s0,24(sp)
800022fc:	02010413          	addi	s0,sp,32
    struct cpu *c = nowcpu();
80002300:	c95ff0ef          	jal	ra,80001f94 <nowcpu>
80002304:	fea42423          	sw	a0,-24(s0)
    struct pcb *p;

    for (;;)
    {
        for (p = proc; p < &proc[NPROC]; p++)
80002308:	8000e7b7          	lui	a5,0x8000e
8000230c:	40878793          	addi	a5,a5,1032 # 8000e408 <memend+0xf800e408>
80002310:	fef42623          	sw	a5,-20(s0)
80002314:	05c0006f          	j	80002370 <schedule+0x80>
        {
            if (p->status == RUNABLE)
80002318:	fec42783          	lw	a5,-20(s0)
8000231c:	0047a703          	lw	a4,4(a5)
80002320:	00200793          	li	a5,2
80002324:	04f71063          	bne	a4,a5,80002364 <schedule+0x74>
            {
                p->status = RUNNING;
80002328:	fec42783          	lw	a5,-20(s0)
8000232c:	00300713          	li	a4,3
80002330:	00e7a223          	sw	a4,4(a5)
                c->proc = p;
80002334:	fe842783          	lw	a5,-24(s0)
80002338:	fec42703          	lw	a4,-20(s0)
8000233c:	00e7a023          	sw	a4,0(a5)
                // 保存当前的上下文到cpu->context中
                swtch(&c->context, &p->context);
80002340:	fe842783          	lw	a5,-24(s0)
80002344:	00478713          	addi	a4,a5,4
80002348:	fec42783          	lw	a5,-20(s0)
8000234c:	00c78793          	addi	a5,a5,12
80002350:	00078593          	mv	a1,a5
80002354:	00070513          	mv	a0,a4
80002358:	e45fd0ef          	jal	ra,8000019c <swtch>
                // swtch ret后跳转到p->context.ra

                c->proc = 0; // cpu->context.ra 指向这里
8000235c:	fe842783          	lw	a5,-24(s0)
80002360:	0007a023          	sw	zero,0(a5)
        for (p = proc; p < &proc[NPROC]; p++)
80002364:	fec42783          	lw	a5,-20(s0)
80002368:	09078793          	addi	a5,a5,144
8000236c:	fef42623          	sw	a5,-20(s0)
80002370:	fec42703          	lw	a4,-20(s0)
80002374:	8000e7b7          	lui	a5,0x8000e
80002378:	64878793          	addi	a5,a5,1608 # 8000e648 <memend+0xf800e648>
8000237c:	f8f76ee3          	bltu	a4,a5,80002318 <schedule+0x28>
80002380:	f89ff06f          	j	80002308 <schedule+0x18>

80002384 <yield>:

/**
 * @description: 进程放弃 CPU
 */
void yield()
{
80002384:	fe010113          	addi	sp,sp,-32
80002388:	00112e23          	sw	ra,28(sp)
8000238c:	00812c23          	sw	s0,24(sp)
80002390:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002394:	bb9ff0ef          	jal	ra,80001f4c <nowproc>
80002398:	fea42623          	sw	a0,-20(s0)
    if (p->status != RUNNING)
8000239c:	fec42783          	lw	a5,-20(s0)
800023a0:	0047a703          	lw	a4,4(a5)
800023a4:	00300793          	li	a5,3
800023a8:	00f70863          	beq	a4,a5,800023b8 <yield+0x34>
    {
        panic("proc status error");
800023ac:	8000d7b7          	lui	a5,0x8000d
800023b0:	45c78513          	addi	a0,a5,1116 # 8000d45c <memend+0xf800d45c>
800023b4:	dedfe0ef          	jal	ra,800011a0 <panic>
    }
    p->status = RUNABLE;
800023b8:	fec42783          	lw	a5,-20(s0)
800023bc:	00200713          	li	a4,2
800023c0:	00e7a223          	sw	a4,4(a5)
    sched();
800023c4:	018000ef          	jal	ra,800023dc <sched>
}
800023c8:	00000013          	nop
800023cc:	01c12083          	lw	ra,28(sp)
800023d0:	01812403          	lw	s0,24(sp)
800023d4:	02010113          	addi	sp,sp,32
800023d8:	00008067          	ret

800023dc <sched>:

/**
 * @description:
 */
void sched()
{
800023dc:	fe010113          	addi	sp,sp,-32
800023e0:	00112e23          	sw	ra,28(sp)
800023e4:	00812c23          	sw	s0,24(sp)
800023e8:	00912a23          	sw	s1,20(sp)
800023ec:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
800023f0:	b5dff0ef          	jal	ra,80001f4c <nowproc>
800023f4:	fea42623          	sw	a0,-20(s0)
    if (p->status == RUNNING)
800023f8:	fec42783          	lw	a5,-20(s0)
800023fc:	0047a703          	lw	a4,4(a5)
80002400:	00300793          	li	a5,3
80002404:	00f71863          	bne	a4,a5,80002414 <sched+0x38>
    {
        panic("proc is running");
80002408:	8000d7b7          	lui	a5,0x8000d
8000240c:	47078513          	addi	a0,a5,1136 # 8000d470 <memend+0xf800d470>
80002410:	d91fe0ef          	jal	ra,800011a0 <panic>
    }
    swtch(&p->context, &nowcpu()->context); //跳转到cpu->context.ra ( schedule() )
80002414:	fec42783          	lw	a5,-20(s0)
80002418:	00c78493          	addi	s1,a5,12
8000241c:	b79ff0ef          	jal	ra,80001f94 <nowcpu>
80002420:	00050793          	mv	a5,a0
80002424:	00478793          	addi	a5,a5,4
80002428:	00078593          	mv	a1,a5
8000242c:	00048513          	mv	a0,s1
80002430:	d6dfd0ef          	jal	ra,8000019c <swtch>
}
80002434:	00000013          	nop
80002438:	01c12083          	lw	ra,28(sp)
8000243c:	01812403          	lw	s0,24(sp)
80002440:	01412483          	lw	s1,20(sp)
80002444:	02010113          	addi	sp,sp,32
80002448:	00008067          	ret

8000244c <sys_fork>:

uint32 sys_fork(void)
{
8000244c:	ff010113          	addi	sp,sp,-16
80002450:	00112623          	sw	ra,12(sp)
80002454:	00812423          	sw	s0,8(sp)
80002458:	01010413          	addi	s0,sp,16
    printf("syscall fork\n");
8000245c:	8000d7b7          	lui	a5,0x8000d
80002460:	48078513          	addi	a0,a5,1152 # 8000d480 <memend+0xf800d480>
80002464:	d75fe0ef          	jal	ra,800011d8 <printf>
    return SYS_fork;
80002468:	00100793          	li	a5,1
}
8000246c:	00078513          	mv	a0,a5
80002470:	00c12083          	lw	ra,12(sp)
80002474:	00812403          	lw	s0,8(sp)
80002478:	01010113          	addi	sp,sp,16
8000247c:	00008067          	ret

80002480 <sys_exec>:

uint32 sys_exec(void)
{
80002480:	ff010113          	addi	sp,sp,-16
80002484:	00112623          	sw	ra,12(sp)
80002488:	00812423          	sw	s0,8(sp)
8000248c:	01010413          	addi	s0,sp,16
    printf("syscall exec\n");
80002490:	8000d7b7          	lui	a5,0x8000d
80002494:	49078513          	addi	a0,a5,1168 # 8000d490 <memend+0xf800d490>
80002498:	d41fe0ef          	jal	ra,800011d8 <printf>
    return SYS_exec;
8000249c:	00200793          	li	a5,2
800024a0:	00078513          	mv	a0,a5
800024a4:	00c12083          	lw	ra,12(sp)
800024a8:	00812403          	lw	s0,8(sp)
800024ac:	01010113          	addi	sp,sp,16
800024b0:	00008067          	ret

800024b4 <memset>:
 */
#include "types.h"

// 初始化内存区域
void *memset(void *addr, int c, uint n)
{
800024b4:	fd010113          	addi	sp,sp,-48
800024b8:	02812623          	sw	s0,44(sp)
800024bc:	03010413          	addi	s0,sp,48
800024c0:	fca42e23          	sw	a0,-36(s0)
800024c4:	fcb42c23          	sw	a1,-40(s0)
800024c8:	fcc42a23          	sw	a2,-44(s0)
    char *maddr = (char *)addr;
800024cc:	fdc42783          	lw	a5,-36(s0)
800024d0:	fef42423          	sw	a5,-24(s0)
    for (uint i = 0; i < n; i++)
800024d4:	fe042623          	sw	zero,-20(s0)
800024d8:	0280006f          	j	80002500 <memset+0x4c>
    {
        maddr[i] = (char)c;
800024dc:	fe842703          	lw	a4,-24(s0)
800024e0:	fec42783          	lw	a5,-20(s0)
800024e4:	00f707b3          	add	a5,a4,a5
800024e8:	fd842703          	lw	a4,-40(s0)
800024ec:	0ff77713          	andi	a4,a4,255
800024f0:	00e78023          	sb	a4,0(a5)
    for (uint i = 0; i < n; i++)
800024f4:	fec42783          	lw	a5,-20(s0)
800024f8:	00178793          	addi	a5,a5,1
800024fc:	fef42623          	sw	a5,-20(s0)
80002500:	fec42703          	lw	a4,-20(s0)
80002504:	fd442783          	lw	a5,-44(s0)
80002508:	fcf76ae3          	bltu	a4,a5,800024dc <memset+0x28>
    }
    return addr;
8000250c:	fdc42783          	lw	a5,-36(s0)
}
80002510:	00078513          	mv	a0,a5
80002514:	02c12403          	lw	s0,44(sp)
80002518:	03010113          	addi	sp,sp,48
8000251c:	00008067          	ret

80002520 <memmove>:

// 安全的 memcpy
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void *memmove(void *dst, const void *src, size_t n)
{
80002520:	fd010113          	addi	sp,sp,-48
80002524:	02812623          	sw	s0,44(sp)
80002528:	03010413          	addi	s0,sp,48
8000252c:	fca42e23          	sw	a0,-36(s0)
80002530:	fcb42c23          	sw	a1,-40(s0)
80002534:	fcc42823          	sw	a2,-48(s0)
80002538:	fcd42a23          	sw	a3,-44(s0)
    const char *s;
    char *d;
    if (n == 0)
8000253c:	fd042783          	lw	a5,-48(s0)
80002540:	fd442703          	lw	a4,-44(s0)
80002544:	00e7e7b3          	or	a5,a5,a4
80002548:	00079663          	bnez	a5,80002554 <memmove+0x34>
    {
        return dst;
8000254c:	fdc42783          	lw	a5,-36(s0)
80002550:	1200006f          	j	80002670 <memmove+0x150>
    }

    s = src;
80002554:	fd842783          	lw	a5,-40(s0)
80002558:	fef42623          	sw	a5,-20(s0)
    d = dst;
8000255c:	fdc42783          	lw	a5,-36(s0)
80002560:	fef42423          	sw	a5,-24(s0)
    if (s < d && s + n > d)
80002564:	fec42703          	lw	a4,-20(s0)
80002568:	fe842783          	lw	a5,-24(s0)
8000256c:	0cf77263          	bgeu	a4,a5,80002630 <memmove+0x110>
80002570:	fd042783          	lw	a5,-48(s0)
80002574:	fec42703          	lw	a4,-20(s0)
80002578:	00f707b3          	add	a5,a4,a5
8000257c:	fe842703          	lw	a4,-24(s0)
80002580:	0af77863          	bgeu	a4,a5,80002630 <memmove+0x110>
    {
        // 有重叠区域,从后往前复制
        s += n;
80002584:	fd042783          	lw	a5,-48(s0)
80002588:	fec42703          	lw	a4,-20(s0)
8000258c:	00f707b3          	add	a5,a4,a5
80002590:	fef42623          	sw	a5,-20(s0)
        d += n;
80002594:	fd042783          	lw	a5,-48(s0)
80002598:	fe842703          	lw	a4,-24(s0)
8000259c:	00f707b3          	add	a5,a4,a5
800025a0:	fef42423          	sw	a5,-24(s0)
        while (n-- > 0)
800025a4:	02c0006f          	j	800025d0 <memmove+0xb0>
        {
            *--d = *--s;
800025a8:	fec42783          	lw	a5,-20(s0)
800025ac:	fff78793          	addi	a5,a5,-1
800025b0:	fef42623          	sw	a5,-20(s0)
800025b4:	fe842783          	lw	a5,-24(s0)
800025b8:	fff78793          	addi	a5,a5,-1
800025bc:	fef42423          	sw	a5,-24(s0)
800025c0:	fec42783          	lw	a5,-20(s0)
800025c4:	0007c703          	lbu	a4,0(a5)
800025c8:	fe842783          	lw	a5,-24(s0)
800025cc:	00e78023          	sb	a4,0(a5)
        while (n-- > 0)
800025d0:	fd042703          	lw	a4,-48(s0)
800025d4:	fd442783          	lw	a5,-44(s0)
800025d8:	fff00513          	li	a0,-1
800025dc:	fff00593          	li	a1,-1
800025e0:	00a70633          	add	a2,a4,a0
800025e4:	00060813          	mv	a6,a2
800025e8:	00e83833          	sltu	a6,a6,a4
800025ec:	00b786b3          	add	a3,a5,a1
800025f0:	00d805b3          	add	a1,a6,a3
800025f4:	00058693          	mv	a3,a1
800025f8:	fcc42823          	sw	a2,-48(s0)
800025fc:	fcd42a23          	sw	a3,-44(s0)
80002600:	00070693          	mv	a3,a4
80002604:	00f6e6b3          	or	a3,a3,a5
80002608:	fa0690e3          	bnez	a3,800025a8 <memmove+0x88>
    if (s < d && s + n > d)
8000260c:	0600006f          	j	8000266c <memmove+0x14c>
    else
    {
        // 无重叠区域,从前往后复制
        while (n-- > 0)
        {
            *d++ = *s++;
80002610:	fec42703          	lw	a4,-20(s0)
80002614:	00170793          	addi	a5,a4,1 # 1001 <sz+0x1>
80002618:	fef42623          	sw	a5,-20(s0)
8000261c:	fe842783          	lw	a5,-24(s0)
80002620:	00178693          	addi	a3,a5,1
80002624:	fed42423          	sw	a3,-24(s0)
80002628:	00074703          	lbu	a4,0(a4)
8000262c:	00e78023          	sb	a4,0(a5)
        while (n-- > 0)
80002630:	fd042703          	lw	a4,-48(s0)
80002634:	fd442783          	lw	a5,-44(s0)
80002638:	fff00513          	li	a0,-1
8000263c:	fff00593          	li	a1,-1
80002640:	00a70633          	add	a2,a4,a0
80002644:	00060813          	mv	a6,a2
80002648:	00e83833          	sltu	a6,a6,a4
8000264c:	00b786b3          	add	a3,a5,a1
80002650:	00d805b3          	add	a1,a6,a3
80002654:	00058693          	mv	a3,a1
80002658:	fcc42823          	sw	a2,-48(s0)
8000265c:	fcd42a23          	sw	a3,-44(s0)
80002660:	00070693          	mv	a3,a4
80002664:	00f6e6b3          	or	a3,a3,a5
80002668:	fa0694e3          	bnez	a3,80002610 <memmove+0xf0>
        }
    }
    return dst;
8000266c:	fdc42783          	lw	a5,-36(s0)
}
80002670:	00078513          	mv	a0,a5
80002674:	02c12403          	lw	s0,44(sp)
80002678:	03010113          	addi	sp,sp,48
8000267c:	00008067          	ret

80002680 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char *s)
{
80002680:	fd010113          	addi	sp,sp,-48
80002684:	02812623          	sw	s0,44(sp)
80002688:	03010413          	addi	s0,sp,48
8000268c:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for (n = 0; s[n]; n++)
80002690:	00000793          	li	a5,0
80002694:	00000813          	li	a6,0
80002698:	fef42423          	sw	a5,-24(s0)
8000269c:	ff042623          	sw	a6,-20(s0)
800026a0:	0340006f          	j	800026d4 <strlen+0x54>
800026a4:	fe842603          	lw	a2,-24(s0)
800026a8:	fec42683          	lw	a3,-20(s0)
800026ac:	00100513          	li	a0,1
800026b0:	00000593          	li	a1,0
800026b4:	00a60733          	add	a4,a2,a0
800026b8:	00070813          	mv	a6,a4
800026bc:	00c83833          	sltu	a6,a6,a2
800026c0:	00b687b3          	add	a5,a3,a1
800026c4:	00f806b3          	add	a3,a6,a5
800026c8:	00068793          	mv	a5,a3
800026cc:	fee42423          	sw	a4,-24(s0)
800026d0:	fef42623          	sw	a5,-20(s0)
800026d4:	fe842783          	lw	a5,-24(s0)
800026d8:	fdc42703          	lw	a4,-36(s0)
800026dc:	00f707b3          	add	a5,a4,a5
800026e0:	0007c783          	lbu	a5,0(a5)
800026e4:	fc0790e3          	bnez	a5,800026a4 <strlen+0x24>
        ;

    return n;
800026e8:	fe842703          	lw	a4,-24(s0)
800026ec:	fec42783          	lw	a5,-20(s0)
800026f0:	00070513          	mv	a0,a4
800026f4:	00078593          	mv	a1,a5
800026f8:	02c12403          	lw	s0,44(sp)
800026fc:	03010113          	addi	sp,sp,48
80002700:	00008067          	ret

80002704 <r_tp>:
{
80002704:	fe010113          	addi	sp,sp,-32
80002708:	00812e23          	sw	s0,28(sp)
8000270c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80002710:	00020793          	mv	a5,tp
80002714:	fef42623          	sw	a5,-20(s0)
    return x;
80002718:	fec42783          	lw	a5,-20(s0)
}
8000271c:	00078513          	mv	a0,a5
80002720:	01c12403          	lw	s0,28(sp)
80002724:	02010113          	addi	sp,sp,32
80002728:	00008067          	ret

8000272c <clintinit>:
 */
#include "clint.h"
#include "riscv.h"

void clintinit()
{
8000272c:	fe010113          	addi	sp,sp,-32
80002730:	00112e23          	sw	ra,28(sp)
80002734:	00812c23          	sw	s0,24(sp)
80002738:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp
    int hart = r_tp();
8000273c:	fc9ff0ef          	jal	ra,80002704 <r_tp>
80002740:	00050793          	mv	a5,a0
80002744:	fef42623          	sw	a5,-20(s0)
    *(reg_t *)CLINT_MTIMECMP(hart) = *(reg_t *)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
80002748:	fec42703          	lw	a4,-20(s0)
8000274c:	004017b7          	lui	a5,0x401
80002750:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002754:	00f707b3          	add	a5,a4,a5
80002758:	00379793          	slli	a5,a5,0x3
8000275c:	0007a703          	lw	a4,0(a5)
80002760:	fec42683          	lw	a3,-20(s0)
80002764:	004017b7          	lui	a5,0x401
80002768:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
8000276c:	00f687b3          	add	a5,a3,a5
80002770:	00379793          	slli	a5,a5,0x3
80002774:	00078693          	mv	a3,a5
80002778:	009897b7          	lui	a5,0x989
8000277c:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80002780:	00f707b3          	add	a5,a4,a5
80002784:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
80002788:	00000013          	nop
8000278c:	01c12083          	lw	ra,28(sp)
80002790:	01812403          	lw	s0,24(sp)
80002794:	02010113          	addi	sp,sp,32
80002798:	00008067          	ret

8000279c <r_mstatus>:
{
8000279c:	fe010113          	addi	sp,sp,-32
800027a0:	00812e23          	sw	s0,28(sp)
800027a4:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus"
800027a8:	300027f3          	csrr	a5,mstatus
800027ac:	fef42623          	sw	a5,-20(s0)
    return x;
800027b0:	fec42783          	lw	a5,-20(s0)
}
800027b4:	00078513          	mv	a0,a5
800027b8:	01c12403          	lw	s0,28(sp)
800027bc:	02010113          	addi	sp,sp,32
800027c0:	00008067          	ret

800027c4 <w_mstatus>:
{
800027c4:	fe010113          	addi	sp,sp,-32
800027c8:	00812e23          	sw	s0,28(sp)
800027cc:	02010413          	addi	s0,sp,32
800027d0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0"
800027d4:	fec42783          	lw	a5,-20(s0)
800027d8:	30079073          	csrw	mstatus,a5
}
800027dc:	00000013          	nop
800027e0:	01c12403          	lw	s0,28(sp)
800027e4:	02010113          	addi	sp,sp,32
800027e8:	00008067          	ret

800027ec <w_mtvec>:
{
800027ec:	fe010113          	addi	sp,sp,-32
800027f0:	00812e23          	sw	s0,28(sp)
800027f4:	02010413          	addi	s0,sp,32
800027f8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0"
800027fc:	fec42783          	lw	a5,-20(s0)
80002800:	30579073          	csrw	mtvec,a5
}
80002804:	00000013          	nop
80002808:	01c12403          	lw	s0,28(sp)
8000280c:	02010113          	addi	sp,sp,32
80002810:	00008067          	ret

80002814 <r_tp>:
{
80002814:	fe010113          	addi	sp,sp,-32
80002818:	00812e23          	sw	s0,28(sp)
8000281c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80002820:	00020793          	mv	a5,tp
80002824:	fef42623          	sw	a5,-20(s0)
    return x;
80002828:	fec42783          	lw	a5,-20(s0)
}
8000282c:	00078513          	mv	a0,a5
80002830:	01c12403          	lw	s0,28(sp)
80002834:	02010113          	addi	sp,sp,32
80002838:	00008067          	ret

8000283c <s_mstatus_intr>:
{
8000283c:	fd010113          	addi	sp,sp,-48
80002840:	02112623          	sw	ra,44(sp)
80002844:	02812423          	sw	s0,40(sp)
80002848:	03010413          	addi	s0,sp,48
8000284c:	fca42e23          	sw	a0,-36(s0)
    uint32 x = r_mstatus();
80002850:	f4dff0ef          	jal	ra,8000279c <r_mstatus>
80002854:	fea42623          	sw	a0,-20(s0)
    switch (m)
80002858:	fdc42703          	lw	a4,-36(s0)
8000285c:	08000793          	li	a5,128
80002860:	04f70263          	beq	a4,a5,800028a4 <s_mstatus_intr+0x68>
80002864:	fdc42703          	lw	a4,-36(s0)
80002868:	08000793          	li	a5,128
8000286c:	0ae7e463          	bltu	a5,a4,80002914 <s_mstatus_intr+0xd8>
80002870:	fdc42703          	lw	a4,-36(s0)
80002874:	02000793          	li	a5,32
80002878:	04f70463          	beq	a4,a5,800028c0 <s_mstatus_intr+0x84>
8000287c:	fdc42703          	lw	a4,-36(s0)
80002880:	02000793          	li	a5,32
80002884:	08e7e863          	bltu	a5,a4,80002914 <s_mstatus_intr+0xd8>
80002888:	fdc42703          	lw	a4,-36(s0)
8000288c:	00200793          	li	a5,2
80002890:	06f70463          	beq	a4,a5,800028f8 <s_mstatus_intr+0xbc>
80002894:	fdc42703          	lw	a4,-36(s0)
80002898:	00800793          	li	a5,8
8000289c:	04f70063          	beq	a4,a5,800028dc <s_mstatus_intr+0xa0>
        break;
800028a0:	0740006f          	j	80002914 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
800028a4:	fec42783          	lw	a5,-20(s0)
800028a8:	f7f7f793          	andi	a5,a5,-129
800028ac:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
800028b0:	fec42783          	lw	a5,-20(s0)
800028b4:	0807e793          	ori	a5,a5,128
800028b8:	fef42623          	sw	a5,-20(s0)
        break;
800028bc:	05c0006f          	j	80002918 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800028c0:	fec42783          	lw	a5,-20(s0)
800028c4:	fdf7f793          	andi	a5,a5,-33
800028c8:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
800028cc:	fec42783          	lw	a5,-20(s0)
800028d0:	0207e793          	ori	a5,a5,32
800028d4:	fef42623          	sw	a5,-20(s0)
        break;
800028d8:	0400006f          	j	80002918 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
800028dc:	fec42783          	lw	a5,-20(s0)
800028e0:	ff77f793          	andi	a5,a5,-9
800028e4:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
800028e8:	fec42783          	lw	a5,-20(s0)
800028ec:	0087e793          	ori	a5,a5,8
800028f0:	fef42623          	sw	a5,-20(s0)
        break;
800028f4:	0240006f          	j	80002918 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
800028f8:	fec42783          	lw	a5,-20(s0)
800028fc:	ffd7f793          	andi	a5,a5,-3
80002900:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80002904:	fec42783          	lw	a5,-20(s0)
80002908:	0027e793          	ori	a5,a5,2
8000290c:	fef42623          	sw	a5,-20(s0)
        break;
80002910:	0080006f          	j	80002918 <s_mstatus_intr+0xdc>
        break;
80002914:	00000013          	nop
    w_mstatus(x);
80002918:	fec42503          	lw	a0,-20(s0)
8000291c:	ea9ff0ef          	jal	ra,800027c4 <w_mstatus>
}
80002920:	00000013          	nop
80002924:	02c12083          	lw	ra,44(sp)
80002928:	02812403          	lw	s0,40(sp)
8000292c:	03010113          	addi	sp,sp,48
80002930:	00008067          	ret

80002934 <r_sie>:
{
80002934:	fe010113          	addi	sp,sp,-32
80002938:	00812e23          	sw	s0,28(sp)
8000293c:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie "
80002940:	104027f3          	csrr	a5,sie
80002944:	fef42623          	sw	a5,-20(s0)
    return x;
80002948:	fec42783          	lw	a5,-20(s0)
}
8000294c:	00078513          	mv	a0,a5
80002950:	01c12403          	lw	s0,28(sp)
80002954:	02010113          	addi	sp,sp,32
80002958:	00008067          	ret

8000295c <w_sie>:
{
8000295c:	fe010113          	addi	sp,sp,-32
80002960:	00812e23          	sw	s0,28(sp)
80002964:	02010413          	addi	s0,sp,32
80002968:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"
8000296c:	fec42783          	lw	a5,-20(s0)
80002970:	10479073          	csrw	sie,a5
}
80002974:	00000013          	nop
80002978:	01c12403          	lw	s0,28(sp)
8000297c:	02010113          	addi	sp,sp,32
80002980:	00008067          	ret

80002984 <r_mie>:
#define MEIE (1 << 11)
#define MTIE (1 << 7)
#define MSIE (1 << 3)
static inline uint32 r_mie()
{
80002984:	fe010113          	addi	sp,sp,-32
80002988:	00812e23          	sw	s0,28(sp)
8000298c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie "
80002990:	304027f3          	csrr	a5,mie
80002994:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80002998:	fec42783          	lw	a5,-20(s0)
}
8000299c:	00078513          	mv	a0,a5
800029a0:	01c12403          	lw	s0,28(sp)
800029a4:	02010113          	addi	sp,sp,32
800029a8:	00008067          	ret

800029ac <w_mie>:
static inline void w_mie(uint32 x)
{
800029ac:	fe010113          	addi	sp,sp,-32
800029b0:	00812e23          	sw	s0,28(sp)
800029b4:	02010413          	addi	s0,sp,32
800029b8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"
800029bc:	fec42783          	lw	a5,-20(s0)
800029c0:	30479073          	csrw	mie,a5
                 :
                 : "r"(x));
}
800029c4:	00000013          	nop
800029c8:	01c12403          	lw	s0,28(sp)
800029cc:	02010113          	addi	sp,sp,32
800029d0:	00008067          	ret

800029d4 <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x)
{
800029d4:	fe010113          	addi	sp,sp,-32
800029d8:	00812e23          	sw	s0,28(sp)
800029dc:	02010413          	addi	s0,sp,32
800029e0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0"
800029e4:	fec42783          	lw	a5,-20(s0)
800029e8:	34079073          	csrw	mscratch,a5
                 :
                 : "r"(x));
800029ec:	00000013          	nop
800029f0:	01c12403          	lw	s0,28(sp)
800029f4:	02010113          	addi	sp,sp,32
800029f8:	00008067          	ret

800029fc <timerinit>:
// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit()
{
800029fc:	fe010113          	addi	sp,sp,-32
80002a00:	00112e23          	sw	ra,28(sp)
80002a04:	00812c23          	sw	s0,24(sp)
80002a08:	01212a23          	sw	s2,20(sp)
80002a0c:	01312823          	sw	s3,16(sp)
80002a10:	02010413          	addi	s0,sp,32
    uint hart = r_tp();
80002a14:	e01ff0ef          	jal	ra,80002814 <r_tp>
80002a18:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
80002a1c:	fec42703          	lw	a4,-20(s0)
80002a20:	00070793          	mv	a5,a4
80002a24:	00279793          	slli	a5,a5,0x2
80002a28:	00e787b3          	add	a5,a5,a4
80002a2c:	00379793          	slli	a5,a5,0x3
80002a30:	8000f737          	lui	a4,0x8000f
80002a34:	a5070713          	addi	a4,a4,-1456 # 8000ea50 <memend+0xf800ea50>
80002a38:	00e787b3          	add	a5,a5,a4
80002a3c:	00078513          	mv	a0,a5
80002a40:	f95ff0ef          	jal	ra,800029d4 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0] = CLINT_MTIMECMP(hart);
80002a44:	fec42703          	lw	a4,-20(s0)
80002a48:	004017b7          	lui	a5,0x401
80002a4c:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002a50:	00f707b3          	add	a5,a4,a5
80002a54:	00379793          	slli	a5,a5,0x3
80002a58:	00078913          	mv	s2,a5
80002a5c:	00000993          	li	s3,0
80002a60:	8000f7b7          	lui	a5,0x8000f
80002a64:	a5078693          	addi	a3,a5,-1456 # 8000ea50 <memend+0xf800ea50>
80002a68:	fec42703          	lw	a4,-20(s0)
80002a6c:	00070793          	mv	a5,a4
80002a70:	00279793          	slli	a5,a5,0x2
80002a74:	00e787b3          	add	a5,a5,a4
80002a78:	00379793          	slli	a5,a5,0x3
80002a7c:	00f687b3          	add	a5,a3,a5
80002a80:	0127a023          	sw	s2,0(a5)
80002a84:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1] = CLINT_INTERVAL;
80002a88:	8000f7b7          	lui	a5,0x8000f
80002a8c:	a5078693          	addi	a3,a5,-1456 # 8000ea50 <memend+0xf800ea50>
80002a90:	fec42703          	lw	a4,-20(s0)
80002a94:	00070793          	mv	a5,a4
80002a98:	00279793          	slli	a5,a5,0x2
80002a9c:	00e787b3          	add	a5,a5,a4
80002aa0:	00379793          	slli	a5,a5,0x3
80002aa4:	00f686b3          	add	a3,a3,a5
80002aa8:	00989737          	lui	a4,0x989
80002aac:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002ab0:	00000793          	li	a5,0
80002ab4:	00e6a423          	sw	a4,8(a3)
80002ab8:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec); // 设置 M-mode time trap处理函数
80002abc:	800007b7          	lui	a5,0x80000
80002ac0:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
80002ac4:	00078513          	mv	a0,a5
80002ac8:	d25ff0ef          	jal	ra,800027ec <w_mtvec>

    s_mstatus_intr(INTR_MIE); // 开启 M-mode 全局中断
80002acc:	00800513          	li	a0,8
80002ad0:	d6dff0ef          	jal	ra,8000283c <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
80002ad4:	e61ff0ef          	jal	ra,80002934 <r_sie>
80002ad8:	00050793          	mv	a5,a0
80002adc:	2227e793          	ori	a5,a5,546
80002ae0:	00078513          	mv	a0,a5
80002ae4:	e79ff0ef          	jal	ra,8000295c <w_sie>

    w_mie(r_mie() | MTIE); // 开启 M-mode 时钟中断
80002ae8:	e9dff0ef          	jal	ra,80002984 <r_mie>
80002aec:	00050793          	mv	a5,a0
80002af0:	0807e793          	ori	a5,a5,128
80002af4:	00078513          	mv	a0,a5
80002af8:	eb5ff0ef          	jal	ra,800029ac <w_mie>

    clintinit(); // 初始化 CLINT
80002afc:	c31ff0ef          	jal	ra,8000272c <clintinit>
80002b00:	00000013          	nop
80002b04:	01c12083          	lw	ra,28(sp)
80002b08:	01812403          	lw	s0,24(sp)
80002b0c:	01412903          	lw	s2,20(sp)
80002b10:	01012983          	lw	s3,16(sp)
80002b14:	02010113          	addi	sp,sp,32
80002b18:	00008067          	ret

80002b1c <r_sepc>:
{
80002b1c:	fe010113          	addi	sp,sp,-32
80002b20:	00812e23          	sw	s0,28(sp)
80002b24:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, sepc"
80002b28:	141027f3          	csrr	a5,sepc
80002b2c:	fef42623          	sw	a5,-20(s0)
    return x;
80002b30:	fec42783          	lw	a5,-20(s0)
}
80002b34:	00078513          	mv	a0,a5
80002b38:	01c12403          	lw	s0,28(sp)
80002b3c:	02010113          	addi	sp,sp,32
80002b40:	00008067          	ret

80002b44 <syscall>:
    [SYS_fork] sys_fork,
    [SYS_exec] sys_exec,
};

void syscall()
{
80002b44:	fe010113          	addi	sp,sp,-32
80002b48:	00112e23          	sw	ra,28(sp)
80002b4c:	00812c23          	sw	s0,24(sp)
80002b50:	00912a23          	sw	s1,20(sp)
80002b54:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002b58:	bf4ff0ef          	jal	ra,80001f4c <nowproc>
80002b5c:	fea42623          	sw	a0,-20(s0)
    p->trapframe->epc = r_sepc();
80002b60:	fec42783          	lw	a5,-20(s0)
80002b64:	0087a483          	lw	s1,8(a5)
80002b68:	fb5ff0ef          	jal	ra,80002b1c <r_sepc>
80002b6c:	00050793          	mv	a5,a0
80002b70:	00f4a623          	sw	a5,12(s1)
    p->trapframe->epc += 4;
80002b74:	fec42783          	lw	a5,-20(s0)
80002b78:	0087a783          	lw	a5,8(a5)
80002b7c:	00c7a703          	lw	a4,12(a5)
80002b80:	fec42783          	lw	a5,-20(s0)
80002b84:	0087a783          	lw	a5,8(a5)
80002b88:	00470713          	addi	a4,a4,4
80002b8c:	00e7a623          	sw	a4,12(a5)

    uint32 sysnum = p->trapframe->a7;
80002b90:	fec42783          	lw	a5,-20(s0)
80002b94:	0087a783          	lw	a5,8(a5)
80002b98:	03c7a783          	lw	a5,60(a5)
80002b9c:	fef42423          	sw	a5,-24(s0)
    p->trapframe->a0 = syscalls[sysnum]();
80002ba0:	8000c7b7          	lui	a5,0x8000c
80002ba4:	01878713          	addi	a4,a5,24 # 8000c018 <memend+0xf800c018>
80002ba8:	fe842783          	lw	a5,-24(s0)
80002bac:	00279793          	slli	a5,a5,0x2
80002bb0:	00f707b3          	add	a5,a4,a5
80002bb4:	0007a703          	lw	a4,0(a5)
80002bb8:	fec42783          	lw	a5,-20(s0)
80002bbc:	0087a483          	lw	s1,8(a5)
80002bc0:	000700e7          	jalr	a4
80002bc4:	00050793          	mv	a5,a0
80002bc8:	02f4a023          	sw	a5,32(s1)
80002bcc:	00000013          	nop
80002bd0:	01c12083          	lw	ra,28(sp)
80002bd4:	01812403          	lw	s0,24(sp)
80002bd8:	01412483          	lw	s1,20(sp)
80002bdc:	02010113          	addi	sp,sp,32
80002be0:	00008067          	ret

80002be4 <mmioinit>:

    uint8 free[DNUM];
} disk;

void mmioinit()
{
80002be4:	fe010113          	addi	sp,sp,-32
80002be8:	00112e23          	sw	ra,28(sp)
80002bec:	00812c23          	sw	s0,24(sp)
80002bf0:	02010413          	addi	s0,sp,32
#ifdef DEBUG
    printf("mmio_magicvalue: %x\n", mmio_read(MMIO_MagicValue));
80002bf4:	100017b7          	lui	a5,0x10001
80002bf8:	0007a783          	lw	a5,0(a5) # 10001000 <sz+0x10000000>
80002bfc:	00078593          	mv	a1,a5
80002c00:	8000d7b7          	lui	a5,0x8000d
80002c04:	4a078513          	addi	a0,a5,1184 # 8000d4a0 <memend+0xf800d4a0>
80002c08:	dd0fe0ef          	jal	ra,800011d8 <printf>
    printf("mmio_version: %x\n", mmio_read(MMIO_Version));
80002c0c:	100017b7          	lui	a5,0x10001
80002c10:	00478793          	addi	a5,a5,4 # 10001004 <sz+0x10000004>
80002c14:	0007a783          	lw	a5,0(a5)
80002c18:	00078593          	mv	a1,a5
80002c1c:	8000d7b7          	lui	a5,0x8000d
80002c20:	4b878513          	addi	a0,a5,1208 # 8000d4b8 <memend+0xf800d4b8>
80002c24:	db4fe0ef          	jal	ra,800011d8 <printf>
    printf("mmio_vendorID: %x\n", mmio_read(MMIO_VendorID));
80002c28:	100017b7          	lui	a5,0x10001
80002c2c:	00c78793          	addi	a5,a5,12 # 1000100c <sz+0x1000000c>
80002c30:	0007a783          	lw	a5,0(a5)
80002c34:	00078593          	mv	a1,a5
80002c38:	8000d7b7          	lui	a5,0x8000d
80002c3c:	4cc78513          	addi	a0,a5,1228 # 8000d4cc <memend+0xf800d4cc>
80002c40:	d98fe0ef          	jal	ra,800011d8 <printf>
    printf("mmio_deviceID: %x\n", mmio_read(MMIO_DeviceID));
80002c44:	100017b7          	lui	a5,0x10001
80002c48:	00878793          	addi	a5,a5,8 # 10001008 <sz+0x10000008>
80002c4c:	0007a783          	lw	a5,0(a5)
80002c50:	00078593          	mv	a1,a5
80002c54:	8000d7b7          	lui	a5,0x8000d
80002c58:	4e078513          	addi	a0,a5,1248 # 8000d4e0 <memend+0xf800d4e0>
80002c5c:	d7cfe0ef          	jal	ra,800011d8 <printf>
    printf("mmio_disk.pages: %x\n", &disk);
80002c60:	8000f7b7          	lui	a5,0x8000f
80002c64:	b9078593          	addi	a1,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80002c68:	8000d7b7          	lui	a5,0x8000d
80002c6c:	4f478513          	addi	a0,a5,1268 # 8000d4f4 <memend+0xf800d4f4>
80002c70:	d68fe0ef          	jal	ra,800011d8 <printf>
#endif

    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
80002c74:	100017b7          	lui	a5,0x10001
80002c78:	0007a703          	lw	a4,0(a5) # 10001000 <sz+0x10000000>
80002c7c:	747277b7          	lui	a5,0x74727
80002c80:	97678793          	addi	a5,a5,-1674 # 74726976 <sz+0x74725976>
80002c84:	04f71263          	bne	a4,a5,80002cc8 <mmioinit+0xe4>
        mmio_read(MMIO_Version) != 0x01 ||
80002c88:	100017b7          	lui	a5,0x10001
80002c8c:	00478793          	addi	a5,a5,4 # 10001004 <sz+0x10000004>
80002c90:	0007a703          	lw	a4,0(a5)
    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
80002c94:	00100793          	li	a5,1
80002c98:	02f71863          	bne	a4,a5,80002cc8 <mmioinit+0xe4>
        mmio_read(MMIO_DeviceID) != 0x02 ||
80002c9c:	100017b7          	lui	a5,0x10001
80002ca0:	00878793          	addi	a5,a5,8 # 10001008 <sz+0x10000008>
80002ca4:	0007a703          	lw	a4,0(a5)
        mmio_read(MMIO_Version) != 0x01 ||
80002ca8:	00200793          	li	a5,2
80002cac:	00f71e63          	bne	a4,a5,80002cc8 <mmioinit+0xe4>
        mmio_read(MMIO_VendorID) != 0x554d4551)
80002cb0:	100017b7          	lui	a5,0x10001
80002cb4:	00c78793          	addi	a5,a5,12 # 1000100c <sz+0x1000000c>
80002cb8:	0007a703          	lw	a4,0(a5)
        mmio_read(MMIO_DeviceID) != 0x02 ||
80002cbc:	554d47b7          	lui	a5,0x554d4
80002cc0:	55178793          	addi	a5,a5,1361 # 554d4551 <sz+0x554d3551>
80002cc4:	00f70863          	beq	a4,a5,80002cd4 <mmioinit+0xf0>
    {
        panic("virtio mmio disk!");
80002cc8:	8000d7b7          	lui	a5,0x8000d
80002ccc:	50c78513          	addi	a0,a5,1292 # 8000d50c <memend+0xf800d50c>
80002cd0:	cd0fe0ef          	jal	ra,800011a0 <panic>
    }

    uint32 status = mmio_read(MMIO_Status);
80002cd4:	100017b7          	lui	a5,0x10001
80002cd8:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002cdc:	0007a783          	lw	a5,0(a5)
80002ce0:	fef42423          	sw	a5,-24(s0)
    status |= MMIO_STATUS_ACKNOWLEDGE; // 表明当前已经识别到了设备
80002ce4:	fe842783          	lw	a5,-24(s0)
80002ce8:	0017e793          	ori	a5,a5,1
80002cec:	fef42423          	sw	a5,-24(s0)
    mmio_write(MMIO_Status, status);
80002cf0:	100017b7          	lui	a5,0x10001
80002cf4:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002cf8:	fe842703          	lw	a4,-24(s0)
80002cfc:	00e7a023          	sw	a4,0(a5)

    status |= MMIO_STATUS_DRIVER; // 表明驱动程序知道如何驱动当前设备
80002d00:	fe842783          	lw	a5,-24(s0)
80002d04:	0027e793          	ori	a5,a5,2
80002d08:	fef42423          	sw	a5,-24(s0)
    mmio_write(MMIO_Status, status);
80002d0c:	100017b7          	lui	a5,0x10001
80002d10:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002d14:	fe842703          	lw	a4,-24(s0)
80002d18:	00e7a023          	sw	a4,0(a5)

    uint32 features = mmio_read(MMIO_DeviceFeatures);
80002d1c:	100017b7          	lui	a5,0x10001
80002d20:	01078793          	addi	a5,a5,16 # 10001010 <sz+0x10000010>
80002d24:	0007a783          	lw	a5,0(a5)
80002d28:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_RO);   // 不支持只读
80002d2c:	fe442783          	lw	a5,-28(s0)
80002d30:	fdf7f793          	andi	a5,a5,-33
80002d34:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_SCSI); // 不支持 SCSI
80002d38:	fe442783          	lw	a5,-28(s0)
80002d3c:	f7f7f793          	andi	a5,a5,-129
80002d40:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_CONFIG_WCE);
80002d44:	fe442703          	lw	a4,-28(s0)
80002d48:	fffff7b7          	lui	a5,0xfffff
80002d4c:	7ff78793          	addi	a5,a5,2047 # fffff7ff <memend+0x77fff7ff>
80002d50:	00f777b3          	and	a5,a4,a5
80002d54:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_MQ);
80002d58:	fe442703          	lw	a4,-28(s0)
80002d5c:	fffff7b7          	lui	a5,0xfffff
80002d60:	fff78793          	addi	a5,a5,-1 # ffffefff <memend+0x77ffefff>
80002d64:	00f777b3          	and	a5,a4,a5
80002d68:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_FEATURES_ANY_LAYOUT);
80002d6c:	fe442703          	lw	a4,-28(s0)
80002d70:	f80007b7          	lui	a5,0xf8000
80002d74:	fff78793          	addi	a5,a5,-1 # f7ffffff <memend+0x6fffffff>
80002d78:	00f777b3          	and	a5,a4,a5
80002d7c:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_RING_FEATURES_INDIRECT_DESC);
80002d80:	fe442703          	lw	a4,-28(s0)
80002d84:	f00007b7          	lui	a5,0xf0000
80002d88:	fff78793          	addi	a5,a5,-1 # efffffff <memend+0x67ffffff>
80002d8c:	00f777b3          	and	a5,a4,a5
80002d90:	fef42223          	sw	a5,-28(s0)
    features &= ~(1 << MMIO_RING_FEATURES_EVENT_IDX);
80002d94:	fe442703          	lw	a4,-28(s0)
80002d98:	e00007b7          	lui	a5,0xe0000
80002d9c:	fff78793          	addi	a5,a5,-1 # dfffffff <memend+0x57ffffff>
80002da0:	00f777b3          	and	a5,a4,a5
80002da4:	fef42223          	sw	a5,-28(s0)
    mmio_write(MMIO_DeviceFeatures, features);
80002da8:	100017b7          	lui	a5,0x10001
80002dac:	01078793          	addi	a5,a5,16 # 10001010 <sz+0x10000010>
80002db0:	fe442703          	lw	a4,-28(s0)
80002db4:	00e7a023          	sw	a4,0(a5)

    status |= MMIO_STATUS_FEATURES_OK; // 特征设置成功
80002db8:	fe842783          	lw	a5,-24(s0)
80002dbc:	0087e793          	ori	a5,a5,8
80002dc0:	fef42423          	sw	a5,-24(s0)
    mmio_write(MMIO_Status, status);
80002dc4:	100017b7          	lui	a5,0x10001
80002dc8:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002dcc:	fe842703          	lw	a4,-24(s0)
80002dd0:	00e7a023          	sw	a4,0(a5)

    status |= MMIO_STATUS_DRIVER_OK; // 驱动准备完毕
80002dd4:	fe842783          	lw	a5,-24(s0)
80002dd8:	0047e793          	ori	a5,a5,4
80002ddc:	fef42423          	sw	a5,-24(s0)
    mmio_write(MMIO_Status, status);
80002de0:	100017b7          	lui	a5,0x10001
80002de4:	07078793          	addi	a5,a5,112 # 10001070 <sz+0x10000070>
80002de8:	fe842703          	lw	a4,-24(s0)
80002dec:	00e7a023          	sw	a4,0(a5)

    mmio_write(MMIO_GusetPAGESIZE, PGSIZE);
80002df0:	100017b7          	lui	a5,0x10001
80002df4:	02878793          	addi	a5,a5,40 # 10001028 <sz+0x10000028>
80002df8:	00001737          	lui	a4,0x1
80002dfc:	00e7a023          	sw	a4,0(a5)

    mmio_write(MMIO_QueueSel, 0);
80002e00:	100017b7          	lui	a5,0x10001
80002e04:	03078793          	addi	a5,a5,48 # 10001030 <sz+0x10000030>
80002e08:	0007a023          	sw	zero,0(a5)
    if (mmio_read(MMIO_QueueNumMax) < DNUM)
80002e0c:	100017b7          	lui	a5,0x10001
80002e10:	03478793          	addi	a5,a5,52 # 10001034 <sz+0x10000034>
80002e14:	0007a703          	lw	a4,0(a5)
80002e18:	00700793          	li	a5,7
80002e1c:	00e7e863          	bltu	a5,a4,80002e2c <mmioinit+0x248>
        panic("mmio : QueueNumMax");
80002e20:	8000d7b7          	lui	a5,0x8000d
80002e24:	52078513          	addi	a0,a5,1312 # 8000d520 <memend+0xf800d520>
80002e28:	b78fe0ef          	jal	ra,800011a0 <panic>
    mmio_write(MMIO_QueueNum, DNUM); // 设置队列大小
80002e2c:	100017b7          	lui	a5,0x10001
80002e30:	03878793          	addi	a5,a5,56 # 10001038 <sz+0x10000038>
80002e34:	00800713          	li	a4,8
80002e38:	00e7a023          	sw	a4,0(a5)

    memset(disk.pages, 0, sizeof(disk.pages));
80002e3c:	00003637          	lui	a2,0x3
80002e40:	00000593          	li	a1,0
80002e44:	8000f7b7          	lui	a5,0x8000f
80002e48:	b9078513          	addi	a0,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80002e4c:	e68ff0ef          	jal	ra,800024b4 <memset>
    disk.desc = (struct virtq_desc *)&disk.pages[0];
80002e50:	8000f7b7          	lui	a5,0x8000f
80002e54:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80002e58:	000037b7          	lui	a5,0x3
80002e5c:	00f707b3          	add	a5,a4,a5
80002e60:	8000f737          	lui	a4,0x8000f
80002e64:	b9070713          	addi	a4,a4,-1136 # 8000eb90 <memend+0xf800eb90>
80002e68:	00e7a023          	sw	a4,0(a5) # 3000 <sz+0x2000>
    disk.avail = (struct virtq_avail *)&disk.pages[1];
80002e6c:	8000f7b7          	lui	a5,0x8000f
80002e70:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80002e74:	000037b7          	lui	a5,0x3
80002e78:	00f707b3          	add	a5,a4,a5
80002e7c:	8000f737          	lui	a4,0x8000f
80002e80:	b9170713          	addi	a4,a4,-1135 # 8000eb91 <memend+0xf800eb91>
80002e84:	00e7a223          	sw	a4,4(a5) # 3004 <sz+0x2004>
    disk.used = (struct virtq_used *)&disk.pages[2];
80002e88:	8000f7b7          	lui	a5,0x8000f
80002e8c:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80002e90:	000037b7          	lui	a5,0x3
80002e94:	00f707b3          	add	a5,a4,a5
80002e98:	8000f737          	lui	a4,0x8000f
80002e9c:	b9270713          	addi	a4,a4,-1134 # 8000eb92 <memend+0xf800eb92>
80002ea0:	00e7a423          	sw	a4,8(a5) # 3008 <sz+0x2008>

    for (int i = 0; i < DNUM; i++)
80002ea4:	fe042623          	sw	zero,-20(s0)
80002ea8:	0300006f          	j	80002ed8 <mmioinit+0x2f4>
        disk.free[i] = 1;
80002eac:	8000f7b7          	lui	a5,0x8000f
80002eb0:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80002eb4:	fec42783          	lw	a5,-20(s0)
80002eb8:	00f707b3          	add	a5,a4,a5
80002ebc:	00004737          	lui	a4,0x4
80002ec0:	00f707b3          	add	a5,a4,a5
80002ec4:	00100713          	li	a4,1
80002ec8:	0ce78823          	sb	a4,208(a5)
    for (int i = 0; i < DNUM; i++)
80002ecc:	fec42783          	lw	a5,-20(s0)
80002ed0:	00178793          	addi	a5,a5,1
80002ed4:	fef42623          	sw	a5,-20(s0)
80002ed8:	fec42703          	lw	a4,-20(s0)
80002edc:	00700793          	li	a5,7
80002ee0:	fce7d6e3          	bge	a5,a4,80002eac <mmioinit+0x2c8>
}
80002ee4:	00000013          	nop
80002ee8:	00000013          	nop
80002eec:	01c12083          	lw	ra,28(sp)
80002ef0:	01812403          	lw	s0,24(sp)
80002ef4:	02010113          	addi	sp,sp,32
80002ef8:	00008067          	ret

80002efc <alloc_desc>:

uint8 alloc_desc()
{
80002efc:	fe010113          	addi	sp,sp,-32
80002f00:	00812e23          	sw	s0,28(sp)
80002f04:	02010413          	addi	s0,sp,32
    for (int i = 0; i < DNUM; i++)
80002f08:	fe042623          	sw	zero,-20(s0)
80002f0c:	03c0006f          	j	80002f48 <alloc_desc+0x4c>
        if (disk.free[i])
80002f10:	8000f7b7          	lui	a5,0x8000f
80002f14:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80002f18:	fec42783          	lw	a5,-20(s0)
80002f1c:	00f707b3          	add	a5,a4,a5
80002f20:	00004737          	lui	a4,0x4
80002f24:	00f707b3          	add	a5,a4,a5
80002f28:	0d07c783          	lbu	a5,208(a5)
80002f2c:	00078863          	beqz	a5,80002f3c <alloc_desc+0x40>
            return i;
80002f30:	fec42783          	lw	a5,-20(s0)
80002f34:	0ff7f793          	andi	a5,a5,255
80002f38:	0200006f          	j	80002f58 <alloc_desc+0x5c>
    for (int i = 0; i < DNUM; i++)
80002f3c:	fec42783          	lw	a5,-20(s0)
80002f40:	00178793          	addi	a5,a5,1
80002f44:	fef42623          	sw	a5,-20(s0)
80002f48:	fec42703          	lw	a4,-20(s0)
80002f4c:	00700793          	li	a5,7
80002f50:	fce7d0e3          	bge	a5,a4,80002f10 <alloc_desc+0x14>
    return -1;
80002f54:	0ff00793          	li	a5,255
}
80002f58:	00078513          	mv	a0,a5
80002f5c:	01c12403          	lw	s0,28(sp)
80002f60:	02010113          	addi	sp,sp,32
80002f64:	00008067          	ret

80002f68 <alloc3_desc>:

uint8 alloc3_desc(int idx[])
{
80002f68:	fd010113          	addi	sp,sp,-48
80002f6c:	02112623          	sw	ra,44(sp)
80002f70:	02812423          	sw	s0,40(sp)
80002f74:	03010413          	addi	s0,sp,48
80002f78:	fca42e23          	sw	a0,-36(s0)
    for (int i = 0; i < 3; i++)
80002f7c:	fe042623          	sw	zero,-20(s0)
80002f80:	0540006f          	j	80002fd4 <alloc3_desc+0x6c>
    {
        idx[i] = alloc_desc();
80002f84:	f79ff0ef          	jal	ra,80002efc <alloc_desc>
80002f88:	00050793          	mv	a5,a0
80002f8c:	00078693          	mv	a3,a5
80002f90:	fec42783          	lw	a5,-20(s0)
80002f94:	00279793          	slli	a5,a5,0x2
80002f98:	fdc42703          	lw	a4,-36(s0)
80002f9c:	00f707b3          	add	a5,a4,a5
80002fa0:	00068713          	mv	a4,a3
80002fa4:	00e7a023          	sw	a4,0(a5)
        if (idx[i] < 0)
80002fa8:	fec42783          	lw	a5,-20(s0)
80002fac:	00279793          	slli	a5,a5,0x2
80002fb0:	fdc42703          	lw	a4,-36(s0)
80002fb4:	00f707b3          	add	a5,a4,a5
80002fb8:	0007a783          	lw	a5,0(a5)
80002fbc:	0007d663          	bgez	a5,80002fc8 <alloc3_desc+0x60>
            return -1;
80002fc0:	0ff00793          	li	a5,255
80002fc4:	0200006f          	j	80002fe4 <alloc3_desc+0x7c>
    for (int i = 0; i < 3; i++)
80002fc8:	fec42783          	lw	a5,-20(s0)
80002fcc:	00178793          	addi	a5,a5,1
80002fd0:	fef42623          	sw	a5,-20(s0)
80002fd4:	fec42703          	lw	a4,-20(s0)
80002fd8:	00200793          	li	a5,2
80002fdc:	fae7d4e3          	bge	a5,a4,80002f84 <alloc3_desc+0x1c>
    }
    return 0;
80002fe0:	00000793          	li	a5,0
}
80002fe4:	00078513          	mv	a0,a5
80002fe8:	02c12083          	lw	ra,44(sp)
80002fec:	02812403          	lw	s0,40(sp)
80002ff0:	03010113          	addi	sp,sp,48
80002ff4:	00008067          	ret

80002ff8 <diskrw>:

void diskrw(uint32 sector, uint8 rw, char b[])
{
80002ff8:	fa010113          	addi	sp,sp,-96
80002ffc:	04112e23          	sw	ra,92(sp)
80003000:	04812c23          	sw	s0,88(sp)
80003004:	05212a23          	sw	s2,84(sp)
80003008:	05312823          	sw	s3,80(sp)
8000300c:	05412623          	sw	s4,76(sp)
80003010:	05512423          	sw	s5,72(sp)
80003014:	05612223          	sw	s6,68(sp)
80003018:	05712023          	sw	s7,64(sp)
8000301c:	03812e23          	sw	s8,60(sp)
80003020:	03912c23          	sw	s9,56(sp)
80003024:	06010413          	addi	s0,sp,96
80003028:	faa42623          	sw	a0,-84(s0)
8000302c:	00058793          	mv	a5,a1
80003030:	fac42223          	sw	a2,-92(s0)
80003034:	faf405a3          	sb	a5,-85(s0)
    int idx[3];
    alloc3_desc(idx);
80003038:	fbc40793          	addi	a5,s0,-68
8000303c:	00078513          	mv	a0,a5
80003040:	f29ff0ef          	jal	ra,80002f68 <alloc3_desc>
#ifdef DEBUG
    for (int i = 0; i < 3; i++)
80003044:	fc042623          	sw	zero,-52(s0)
80003048:	0340006f          	j	8000307c <diskrw+0x84>
        printf("%d ", idx[i]);
8000304c:	fcc42783          	lw	a5,-52(s0)
80003050:	00279793          	slli	a5,a5,0x2
80003054:	fd040713          	addi	a4,s0,-48
80003058:	00f707b3          	add	a5,a4,a5
8000305c:	fec7a783          	lw	a5,-20(a5)
80003060:	00078593          	mv	a1,a5
80003064:	8000d7b7          	lui	a5,0x8000d
80003068:	53478513          	addi	a0,a5,1332 # 8000d534 <memend+0xf800d534>
8000306c:	96cfe0ef          	jal	ra,800011d8 <printf>
    for (int i = 0; i < 3; i++)
80003070:	fcc42783          	lw	a5,-52(s0)
80003074:	00178793          	addi	a5,a5,1
80003078:	fcf42623          	sw	a5,-52(s0)
8000307c:	fcc42703          	lw	a4,-52(s0)
80003080:	00200793          	li	a5,2
80003084:	fce7d4e3          	bge	a5,a4,8000304c <diskrw+0x54>
    printf("\n");
80003088:	8000d7b7          	lui	a5,0x8000d
8000308c:	53878513          	addi	a0,a5,1336 # 8000d538 <memend+0xf800d538>
80003090:	948fe0ef          	jal	ra,800011d8 <printf>
#endif

    struct virtio_blk_req *buf = &disk.req[idx[0]];
80003094:	fbc42703          	lw	a4,-68(s0)
80003098:	21800793          	li	a5,536
8000309c:	02f70733          	mul	a4,a4,a5
800030a0:	000037b7          	lui	a5,0x3
800030a4:	01078793          	addi	a5,a5,16 # 3010 <sz+0x2010>
800030a8:	00f70733          	add	a4,a4,a5
800030ac:	8000f7b7          	lui	a5,0x8000f
800030b0:	b9078793          	addi	a5,a5,-1136 # 8000eb90 <memend+0xf800eb90>
800030b4:	00f707b3          	add	a5,a4,a5
800030b8:	fcf42423          	sw	a5,-56(s0)

    switch (rw)
800030bc:	fab44783          	lbu	a5,-85(s0)
800030c0:	00078863          	beqz	a5,800030d0 <diskrw+0xd8>
800030c4:	00100713          	li	a4,1
800030c8:	00e78a63          	beq	a5,a4,800030dc <diskrw+0xe4>
        break;
    case VIRTIO_BLK_T_OUT:
        buf->type = VIRTIO_BLK_T_OUT;
        break;
    default:
        break;
800030cc:	0200006f          	j	800030ec <diskrw+0xf4>
        buf->type = VIRTIO_BLK_T_IN;
800030d0:	fc842783          	lw	a5,-56(s0)
800030d4:	0007a023          	sw	zero,0(a5)
        break;
800030d8:	0140006f          	j	800030ec <diskrw+0xf4>
        buf->type = VIRTIO_BLK_T_OUT;
800030dc:	fc842783          	lw	a5,-56(s0)
800030e0:	00100713          	li	a4,1
800030e4:	00e7a023          	sw	a4,0(a5)
        break;
800030e8:	00000013          	nop
    }
    buf->reserved = 0;
800030ec:	fc842783          	lw	a5,-56(s0)
800030f0:	0007a223          	sw	zero,4(a5)
    buf->sector = sector;
800030f4:	fac42783          	lw	a5,-84(s0)
800030f8:	00078c13          	mv	s8,a5
800030fc:	00000c93          	li	s9,0
80003100:	fc842783          	lw	a5,-56(s0)
80003104:	0187a423          	sw	s8,8(a5)
80003108:	0197a623          	sw	s9,12(a5)

    disk.desc[idx[0]].addr = (uint32)buf;
8000310c:	fc842683          	lw	a3,-56(s0)
80003110:	8000f7b7          	lui	a5,0x8000f
80003114:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003118:	000037b7          	lui	a5,0x3
8000311c:	00f707b3          	add	a5,a4,a5
80003120:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
80003124:	fbc42783          	lw	a5,-68(s0)
80003128:	00479793          	slli	a5,a5,0x4
8000312c:	00f707b3          	add	a5,a4,a5
80003130:	00068b13          	mv	s6,a3
80003134:	00000b93          	li	s7,0
80003138:	0167a023          	sw	s6,0(a5)
8000313c:	0177a223          	sw	s7,4(a5)
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
80003140:	8000f7b7          	lui	a5,0x8000f
80003144:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003148:	000037b7          	lui	a5,0x3
8000314c:	00f707b3          	add	a5,a4,a5
80003150:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
80003154:	fbc42783          	lw	a5,-68(s0)
80003158:	00479793          	slli	a5,a5,0x4
8000315c:	00f707b3          	add	a5,a4,a5
80003160:	21800713          	li	a4,536
80003164:	00e7a423          	sw	a4,8(a5)
    disk.desc[idx[0]].flags = VIRTQ_DESC_F_NEXT;
80003168:	8000f7b7          	lui	a5,0x8000f
8000316c:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003170:	000037b7          	lui	a5,0x3
80003174:	00f707b3          	add	a5,a4,a5
80003178:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
8000317c:	fbc42783          	lw	a5,-68(s0)
80003180:	00479793          	slli	a5,a5,0x4
80003184:	00f707b3          	add	a5,a4,a5
80003188:	00100713          	li	a4,1
8000318c:	00e79623          	sh	a4,12(a5)
    disk.desc[idx[0]].next = idx[1];
80003190:	fc042683          	lw	a3,-64(s0)
80003194:	8000f7b7          	lui	a5,0x8000f
80003198:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
8000319c:	000037b7          	lui	a5,0x3
800031a0:	00f707b3          	add	a5,a4,a5
800031a4:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
800031a8:	fbc42783          	lw	a5,-68(s0)
800031ac:	00479793          	slli	a5,a5,0x4
800031b0:	00f707b3          	add	a5,a4,a5
800031b4:	01069713          	slli	a4,a3,0x10
800031b8:	01075713          	srli	a4,a4,0x10
800031bc:	00e79723          	sh	a4,14(a5)

    disk.desc[idx[1]].addr = (uint32)b;
800031c0:	fa442683          	lw	a3,-92(s0)
800031c4:	8000f7b7          	lui	a5,0x8000f
800031c8:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
800031cc:	000037b7          	lui	a5,0x3
800031d0:	00f707b3          	add	a5,a4,a5
800031d4:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
800031d8:	fc042783          	lw	a5,-64(s0)
800031dc:	00479793          	slli	a5,a5,0x4
800031e0:	00f707b3          	add	a5,a4,a5
800031e4:	00068a13          	mv	s4,a3
800031e8:	00000a93          	li	s5,0
800031ec:	0147a023          	sw	s4,0(a5)
800031f0:	0157a223          	sw	s5,4(a5)
    disk.desc[idx[1]].len = 512;
800031f4:	8000f7b7          	lui	a5,0x8000f
800031f8:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
800031fc:	000037b7          	lui	a5,0x3
80003200:	00f707b3          	add	a5,a4,a5
80003204:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
80003208:	fc042783          	lw	a5,-64(s0)
8000320c:	00479793          	slli	a5,a5,0x4
80003210:	00f707b3          	add	a5,a4,a5
80003214:	20000713          	li	a4,512
80003218:	00e7a423          	sw	a4,8(a5)
    switch (rw)
8000321c:	fab44783          	lbu	a5,-85(s0)
80003220:	00078863          	beqz	a5,80003230 <diskrw+0x238>
80003224:	00100713          	li	a4,1
80003228:	02e78863          	beq	a5,a4,80003258 <diskrw+0x260>
        break;
    case VIRTIO_BLK_T_OUT:
        disk.desc[idx[1]].flags = VIRTQ_DESC_F_WRITE;
        break;
    default:
        break;
8000322c:	0580006f          	j	80003284 <diskrw+0x28c>
        disk.desc[idx[1]].flags = 0;
80003230:	8000f7b7          	lui	a5,0x8000f
80003234:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003238:	000037b7          	lui	a5,0x3
8000323c:	00f707b3          	add	a5,a4,a5
80003240:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
80003244:	fc042783          	lw	a5,-64(s0)
80003248:	00479793          	slli	a5,a5,0x4
8000324c:	00f707b3          	add	a5,a4,a5
80003250:	00079623          	sh	zero,12(a5)
        break;
80003254:	0300006f          	j	80003284 <diskrw+0x28c>
        disk.desc[idx[1]].flags = VIRTQ_DESC_F_WRITE;
80003258:	8000f7b7          	lui	a5,0x8000f
8000325c:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003260:	000037b7          	lui	a5,0x3
80003264:	00f707b3          	add	a5,a4,a5
80003268:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
8000326c:	fc042783          	lw	a5,-64(s0)
80003270:	00479793          	slli	a5,a5,0x4
80003274:	00f707b3          	add	a5,a4,a5
80003278:	00200713          	li	a4,2
8000327c:	00e79623          	sh	a4,12(a5)
        break;
80003280:	00000013          	nop
    }
    disk.desc[idx[1]].flags |= VIRTQ_DESC_F_NEXT;
80003284:	8000f7b7          	lui	a5,0x8000f
80003288:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
8000328c:	000037b7          	lui	a5,0x3
80003290:	00f707b3          	add	a5,a4,a5
80003294:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
80003298:	fc042783          	lw	a5,-64(s0)
8000329c:	00479793          	slli	a5,a5,0x4
800032a0:	00f707b3          	add	a5,a4,a5
800032a4:	00c7d703          	lhu	a4,12(a5)
800032a8:	8000f7b7          	lui	a5,0x8000f
800032ac:	b9078693          	addi	a3,a5,-1136 # 8000eb90 <memend+0xf800eb90>
800032b0:	000037b7          	lui	a5,0x3
800032b4:	00f687b3          	add	a5,a3,a5
800032b8:	0007a683          	lw	a3,0(a5) # 3000 <sz+0x2000>
800032bc:	fc042783          	lw	a5,-64(s0)
800032c0:	00479793          	slli	a5,a5,0x4
800032c4:	00f687b3          	add	a5,a3,a5
800032c8:	00176713          	ori	a4,a4,1
800032cc:	01071713          	slli	a4,a4,0x10
800032d0:	01075713          	srli	a4,a4,0x10
800032d4:	00e79623          	sh	a4,12(a5)
    disk.desc[idx[1]].next = idx[2];
800032d8:	fc442683          	lw	a3,-60(s0)
800032dc:	8000f7b7          	lui	a5,0x8000f
800032e0:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
800032e4:	000037b7          	lui	a5,0x3
800032e8:	00f707b3          	add	a5,a4,a5
800032ec:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
800032f0:	fc042783          	lw	a5,-64(s0)
800032f4:	00479793          	slli	a5,a5,0x4
800032f8:	00f707b3          	add	a5,a4,a5
800032fc:	01069713          	slli	a4,a3,0x10
80003300:	01075713          	srli	a4,a4,0x10
80003304:	00e79723          	sh	a4,14(a5)

    buf->status = 0xff;
80003308:	fc842783          	lw	a5,-56(s0)
8000330c:	fff00713          	li	a4,-1
80003310:	20e78823          	sb	a4,528(a5)

    disk.desc[idx[2]].addr = (uint32)&buf->status;
80003314:	fc842783          	lw	a5,-56(s0)
80003318:	21078793          	addi	a5,a5,528
8000331c:	00078693          	mv	a3,a5
80003320:	8000f7b7          	lui	a5,0x8000f
80003324:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003328:	000037b7          	lui	a5,0x3
8000332c:	00f707b3          	add	a5,a4,a5
80003330:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
80003334:	fc442783          	lw	a5,-60(s0)
80003338:	00479793          	slli	a5,a5,0x4
8000333c:	00f707b3          	add	a5,a4,a5
80003340:	00068913          	mv	s2,a3
80003344:	00000993          	li	s3,0
80003348:	0127a023          	sw	s2,0(a5)
8000334c:	0137a223          	sw	s3,4(a5)
    disk.desc[idx[2]].len = 1;
80003350:	8000f7b7          	lui	a5,0x8000f
80003354:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003358:	000037b7          	lui	a5,0x3
8000335c:	00f707b3          	add	a5,a4,a5
80003360:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
80003364:	fc442783          	lw	a5,-60(s0)
80003368:	00479793          	slli	a5,a5,0x4
8000336c:	00f707b3          	add	a5,a4,a5
80003370:	00100713          	li	a4,1
80003374:	00e7a423          	sw	a4,8(a5)
    disk.desc[idx[2]].flags = VIRTQ_DESC_F_WRITE; // device writes the status
80003378:	8000f7b7          	lui	a5,0x8000f
8000337c:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003380:	000037b7          	lui	a5,0x3
80003384:	00f707b3          	add	a5,a4,a5
80003388:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
8000338c:	fc442783          	lw	a5,-60(s0)
80003390:	00479793          	slli	a5,a5,0x4
80003394:	00f707b3          	add	a5,a4,a5
80003398:	00200713          	li	a4,2
8000339c:	00e79623          	sh	a4,12(a5)
    disk.desc[idx[2]].next = 0;
800033a0:	8000f7b7          	lui	a5,0x8000f
800033a4:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
800033a8:	000037b7          	lui	a5,0x3
800033ac:	00f707b3          	add	a5,a4,a5
800033b0:	0007a703          	lw	a4,0(a5) # 3000 <sz+0x2000>
800033b4:	fc442783          	lw	a5,-60(s0)
800033b8:	00479793          	slli	a5,a5,0x4
800033bc:	00f707b3          	add	a5,a4,a5
800033c0:	00079723          	sh	zero,14(a5)

    disk.avail->ring[disk.avail->idx % DNUM] = idx[0];
800033c4:	fbc42603          	lw	a2,-68(s0)
800033c8:	8000f7b7          	lui	a5,0x8000f
800033cc:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
800033d0:	000037b7          	lui	a5,0x3
800033d4:	00f707b3          	add	a5,a4,a5
800033d8:	0047a683          	lw	a3,4(a5) # 3004 <sz+0x2004>
800033dc:	8000f7b7          	lui	a5,0x8000f
800033e0:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
800033e4:	000037b7          	lui	a5,0x3
800033e8:	00f707b3          	add	a5,a4,a5
800033ec:	0047a783          	lw	a5,4(a5) # 3004 <sz+0x2004>
800033f0:	0027d783          	lhu	a5,2(a5)
800033f4:	0077f793          	andi	a5,a5,7
800033f8:	01061713          	slli	a4,a2,0x10
800033fc:	01075713          	srli	a4,a4,0x10
80003400:	00179793          	slli	a5,a5,0x1
80003404:	00f687b3          	add	a5,a3,a5
80003408:	00e79223          	sh	a4,4(a5)

    // tell the device another avail ring entry is available.
    disk.avail->idx += 1; // not % NUM ...
8000340c:	8000f7b7          	lui	a5,0x8000f
80003410:	b9078713          	addi	a4,a5,-1136 # 8000eb90 <memend+0xf800eb90>
80003414:	000037b7          	lui	a5,0x3
80003418:	00f707b3          	add	a5,a4,a5
8000341c:	0047a783          	lw	a5,4(a5) # 3004 <sz+0x2004>
80003420:	0027d703          	lhu	a4,2(a5)
80003424:	8000f7b7          	lui	a5,0x8000f
80003428:	b9078693          	addi	a3,a5,-1136 # 8000eb90 <memend+0xf800eb90>
8000342c:	000037b7          	lui	a5,0x3
80003430:	00f687b3          	add	a5,a3,a5
80003434:	0047a783          	lw	a5,4(a5) # 3004 <sz+0x2004>
80003438:	00170713          	addi	a4,a4,1 # 4001 <sz+0x3001>
8000343c:	01071713          	slli	a4,a4,0x10
80003440:	01075713          	srli	a4,a4,0x10
80003444:	00e79123          	sh	a4,2(a5)

    mmio_write(MMIO_QueueNotify, 0); // value is queue number
80003448:	100017b7          	lui	a5,0x10001
8000344c:	05078793          	addi	a5,a5,80 # 10001050 <sz+0x10000050>
80003450:	0007a023          	sw	zero,0(a5)
80003454:	00000013          	nop
80003458:	05c12083          	lw	ra,92(sp)
8000345c:	05812403          	lw	s0,88(sp)
80003460:	05412903          	lw	s2,84(sp)
80003464:	05012983          	lw	s3,80(sp)
80003468:	04c12a03          	lw	s4,76(sp)
8000346c:	04812a83          	lw	s5,72(sp)
80003470:	04412b03          	lw	s6,68(sp)
80003474:	04012b83          	lw	s7,64(sp)
80003478:	03c12c03          	lw	s8,60(sp)
8000347c:	03812c83          	lw	s9,56(sp)
80003480:	06010113          	addi	sp,sp,96
80003484:	00008067          	ret

80003488 <textend>:
	...
