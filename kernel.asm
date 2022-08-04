
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
800000ac:	66d000ef          	jal	ra,80000f18 <trapvec>

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
8000032c:	3ed000ef          	jal	ra,80000f18 <trapvec>

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
80000720:	36c020ef          	jal	ra,80002a8c <timerinit>

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
80000924:	081000ef          	jal	ra,800011a4 <printf>

    minit();        // 物理内存管理
80000928:	489000ef          	jal	ra,800015b0 <minit>
    plicinit();     // PLIC 中断处理
8000092c:	709000ef          	jal	ra,80001834 <plicinit>
    
    kvminit();       // 启动虚拟内存
80000930:	3bc010ef          	jal	ra,80001cec <kvminit>

    printf("usertrap: %p\n",usertrap);
80000934:	800007b7          	lui	a5,0x80000
80000938:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
8000093c:	8000c7b7          	lui	a5,0x8000c
80000940:	02078513          	addi	a0,a5,32 # 8000c020 <memend+0xf800c020>
80000944:	061000ef          	jal	ra,800011a4 <printf>

    procinit();
80000948:	614010ef          	jal	ra,80001f5c <procinit>

    userinit();
8000094c:	7f8010ef          	jal	ra,80002144 <userinit>

    printf("----------------------\n");
80000950:	8000c7b7          	lui	a5,0x8000c
80000954:	03078513          	addi	a0,a5,48 # 8000c030 <memend+0xf800c030>
80000958:	04d000ef          	jal	ra,800011a4 <printf>
    schedule();
8000095c:	225010ef          	jal	ra,80002380 <schedule>
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

80000a40 <w_sepc>:
    uint32 x;
    asm volatile("csrr %0, sepc" : "=r" (x) );
    return x;
}
// 写 sepc寄存器
static inline void w_sepc(uint32 x){
80000a40:	fe010113          	addi	sp,sp,-32
80000a44:	00812e23          	sw	s0,28(sp)
80000a48:	02010413          	addi	s0,sp,32
80000a4c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
80000a50:	fec42783          	lw	a5,-20(s0)
80000a54:	14179073          	csrw	sepc,a5
}
80000a58:	00000013          	nop
80000a5c:	01c12403          	lw	s0,28(sp)
80000a60:	02010113          	addi	sp,sp,32
80000a64:	00008067          	ret

80000a68 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80000a68:	fe010113          	addi	sp,sp,-32
80000a6c:	00812e23          	sw	s0,28(sp)
80000a70:	02010413          	addi	s0,sp,32
80000a74:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80000a78:	fec42783          	lw	a5,-20(s0)
80000a7c:	10579073          	csrw	stvec,a5
}
80000a80:	00000013          	nop
80000a84:	01c12403          	lw	s0,28(sp)
80000a88:	02010113          	addi	sp,sp,32
80000a8c:	00008067          	ret

80000a90 <r_satp>:
 * mode = 地址转换方案 0=bare 1=SV32
 * asid = 地址空间标识
 * ppn  = 根页表物理页码(物理地址/4Kb)
 */
#define SATP_SV32 (1<<31)    
static inline uint32 r_satp(){
80000a90:	fe010113          	addi	sp,sp,-32
80000a94:	00812e23          	sw	s0,28(sp)
80000a98:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
80000a9c:	180027f3          	csrr	a5,satp
80000aa0:	fef42623          	sw	a5,-20(s0)
    return x;
80000aa4:	fec42783          	lw	a5,-20(s0)
}
80000aa8:	00078513          	mv	a0,a5
80000aac:	01c12403          	lw	s0,28(sp)
80000ab0:	02010113          	addi	sp,sp,32
80000ab4:	00008067          	ret

80000ab8 <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
80000ab8:	fe010113          	addi	sp,sp,-32
80000abc:	00812e23          	sw	s0,28(sp)
80000ac0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
80000ac4:	142027f3          	csrr	a5,scause
80000ac8:	fef42623          	sw	a5,-20(s0)
    return x;
80000acc:	fec42783          	lw	a5,-20(s0)
}
80000ad0:	00078513          	mv	a0,a5
80000ad4:	01c12403          	lw	s0,28(sp)
80000ad8:	02010113          	addi	sp,sp,32
80000adc:	00008067          	ret

80000ae0 <r_stval>:
// trap 时写入异常相关信息
/** 如果stval在指令获取、加载或存储发生断点、
  * 地址错位、访问错误或页面错误异常时使用非
  * 零值写入，则stval将包含出错的虚拟地址。
*/
static inline uint32 r_stval(){
80000ae0:	fe010113          	addi	sp,sp,-32
80000ae4:	00812e23          	sw	s0,28(sp)
80000ae8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,stval":"=r"(x));
80000aec:	143027f3          	csrr	a5,stval
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
80000b68:	591000ef          	jal	ra,800018f8 <r_plicclaim>
80000b6c:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000b70:	fec42583          	lw	a1,-20(s0)
80000b74:	8000c7b7          	lui	a5,0x8000c
80000b78:	04878513          	addi	a0,a5,72 # 8000c048 <memend+0xf800c048>
80000b7c:	628000ef          	jal	ra,800011a4 <printf>
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
80000ba0:	604000ef          	jal	ra,800011a4 <printf>
        break;
80000ba4:	0080006f          	j	80000bac <externinterrupt+0x54>
    default:
        break;
80000ba8:	00000013          	nop
    }
    w_pliccomplete(irq);
80000bac:	fec42503          	lw	a0,-20(s0)
80000bb0:	589000ef          	jal	ra,80001938 <w_pliccomplete>
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
80000bf0:	5b4000ef          	jal	ra,800011a4 <printf>
    printf("kernel_satp: %d \n",tf->kernel_satp);
80000bf4:	fec42783          	lw	a5,-20(s0)
80000bf8:	0007a783          	lw	a5,0(a5)
80000bfc:	00078593          	mv	a1,a5
80000c00:	8000c7b7          	lui	a5,0x8000c
80000c04:	07478513          	addi	a0,a5,116 # 8000c074 <memend+0xf800c074>
80000c08:	59c000ef          	jal	ra,800011a4 <printf>
    printf("kernel_tvec: %d \n",tf->kernel_tvec);
80000c0c:	fec42783          	lw	a5,-20(s0)
80000c10:	0047a783          	lw	a5,4(a5)
80000c14:	00078593          	mv	a1,a5
80000c18:	8000c7b7          	lui	a5,0x8000c
80000c1c:	08878513          	addi	a0,a5,136 # 8000c088 <memend+0xf800c088>
80000c20:	584000ef          	jal	ra,800011a4 <printf>

    printf("ra: %d \n",tf->ra);
80000c24:	fec42783          	lw	a5,-20(s0)
80000c28:	0107a783          	lw	a5,16(a5)
80000c2c:	00078593          	mv	a1,a5
80000c30:	8000c7b7          	lui	a5,0x8000c
80000c34:	09c78513          	addi	a0,a5,156 # 8000c09c <memend+0xf800c09c>
80000c38:	56c000ef          	jal	ra,800011a4 <printf>
    printf("sp: %d \n",tf->sp);
80000c3c:	fec42783          	lw	a5,-20(s0)
80000c40:	0147a783          	lw	a5,20(a5)
80000c44:	00078593          	mv	a1,a5
80000c48:	8000c7b7          	lui	a5,0x8000c
80000c4c:	0a878513          	addi	a0,a5,168 # 8000c0a8 <memend+0xf800c0a8>
80000c50:	554000ef          	jal	ra,800011a4 <printf>
    printf("tp: %d \n",tf->tp);
80000c54:	fec42783          	lw	a5,-20(s0)
80000c58:	01c7a783          	lw	a5,28(a5)
80000c5c:	00078593          	mv	a1,a5
80000c60:	8000c7b7          	lui	a5,0x8000c
80000c64:	0b478513          	addi	a0,a5,180 # 8000c0b4 <memend+0xf800c0b4>
80000c68:	53c000ef          	jal	ra,800011a4 <printf>
    printf("t0: %d \n",tf->t0);
80000c6c:	fec42783          	lw	a5,-20(s0)
80000c70:	0707a783          	lw	a5,112(a5)
80000c74:	00078593          	mv	a1,a5
80000c78:	8000c7b7          	lui	a5,0x8000c
80000c7c:	0c078513          	addi	a0,a5,192 # 8000c0c0 <memend+0xf800c0c0>
80000c80:	524000ef          	jal	ra,800011a4 <printf>
    printf("t1: %d \n",tf->t1);
80000c84:	fec42783          	lw	a5,-20(s0)
80000c88:	0747a783          	lw	a5,116(a5)
80000c8c:	00078593          	mv	a1,a5
80000c90:	8000c7b7          	lui	a5,0x8000c
80000c94:	0cc78513          	addi	a0,a5,204 # 8000c0cc <memend+0xf800c0cc>
80000c98:	50c000ef          	jal	ra,800011a4 <printf>
    printf("t2: %d \n",tf->t2);
80000c9c:	fec42783          	lw	a5,-20(s0)
80000ca0:	0787a783          	lw	a5,120(a5)
80000ca4:	00078593          	mv	a1,a5
80000ca8:	8000c7b7          	lui	a5,0x8000c
80000cac:	0d878513          	addi	a0,a5,216 # 8000c0d8 <memend+0xf800c0d8>
80000cb0:	4f4000ef          	jal	ra,800011a4 <printf>
    printf("t3: %d \n",tf->t3);
80000cb4:	fec42783          	lw	a5,-20(s0)
80000cb8:	07c7a783          	lw	a5,124(a5)
80000cbc:	00078593          	mv	a1,a5
80000cc0:	8000c7b7          	lui	a5,0x8000c
80000cc4:	0e478513          	addi	a0,a5,228 # 8000c0e4 <memend+0xf800c0e4>
80000cc8:	4dc000ef          	jal	ra,800011a4 <printf>
    printf("t4: %d \n",tf->t4);
80000ccc:	fec42783          	lw	a5,-20(s0)
80000cd0:	0807a783          	lw	a5,128(a5)
80000cd4:	00078593          	mv	a1,a5
80000cd8:	8000c7b7          	lui	a5,0x8000c
80000cdc:	0f078513          	addi	a0,a5,240 # 8000c0f0 <memend+0xf800c0f0>
80000ce0:	4c4000ef          	jal	ra,800011a4 <printf>
    printf("t5: %d \n",tf->t5);
80000ce4:	fec42783          	lw	a5,-20(s0)
80000ce8:	0847a783          	lw	a5,132(a5)
80000cec:	00078593          	mv	a1,a5
80000cf0:	8000c7b7          	lui	a5,0x8000c
80000cf4:	0fc78513          	addi	a0,a5,252 # 8000c0fc <memend+0xf800c0fc>
80000cf8:	4ac000ef          	jal	ra,800011a4 <printf>
    printf("t6: %d \n",tf->t6);
80000cfc:	fec42783          	lw	a5,-20(s0)
80000d00:	0887a783          	lw	a5,136(a5)
80000d04:	00078593          	mv	a1,a5
80000d08:	8000c7b7          	lui	a5,0x8000c
80000d0c:	10878513          	addi	a0,a5,264 # 8000c108 <memend+0xf800c108>
80000d10:	494000ef          	jal	ra,800011a4 <printf>
    printf("a0: %d \n",tf->a0);
80000d14:	fec42783          	lw	a5,-20(s0)
80000d18:	0207a783          	lw	a5,32(a5)
80000d1c:	00078593          	mv	a1,a5
80000d20:	8000c7b7          	lui	a5,0x8000c
80000d24:	11478513          	addi	a0,a5,276 # 8000c114 <memend+0xf800c114>
80000d28:	47c000ef          	jal	ra,800011a4 <printf>
    printf("a1: %d \n",tf->a1);
80000d2c:	fec42783          	lw	a5,-20(s0)
80000d30:	0247a783          	lw	a5,36(a5)
80000d34:	00078593          	mv	a1,a5
80000d38:	8000c7b7          	lui	a5,0x8000c
80000d3c:	12078513          	addi	a0,a5,288 # 8000c120 <memend+0xf800c120>
80000d40:	464000ef          	jal	ra,800011a4 <printf>
    printf("a2: %d \n",tf->a2);
80000d44:	fec42783          	lw	a5,-20(s0)
80000d48:	0287a783          	lw	a5,40(a5)
80000d4c:	00078593          	mv	a1,a5
80000d50:	8000c7b7          	lui	a5,0x8000c
80000d54:	12c78513          	addi	a0,a5,300 # 8000c12c <memend+0xf800c12c>
80000d58:	44c000ef          	jal	ra,800011a4 <printf>
    printf("a3: %d \n",tf->a3);
80000d5c:	fec42783          	lw	a5,-20(s0)
80000d60:	02c7a783          	lw	a5,44(a5)
80000d64:	00078593          	mv	a1,a5
80000d68:	8000c7b7          	lui	a5,0x8000c
80000d6c:	13878513          	addi	a0,a5,312 # 8000c138 <memend+0xf800c138>
80000d70:	434000ef          	jal	ra,800011a4 <printf>
    printf("a4: %d \n",tf->a4);
80000d74:	fec42783          	lw	a5,-20(s0)
80000d78:	0307a783          	lw	a5,48(a5)
80000d7c:	00078593          	mv	a1,a5
80000d80:	8000c7b7          	lui	a5,0x8000c
80000d84:	14478513          	addi	a0,a5,324 # 8000c144 <memend+0xf800c144>
80000d88:	41c000ef          	jal	ra,800011a4 <printf>
    printf("a5: %d \n",tf->a5);
80000d8c:	fec42783          	lw	a5,-20(s0)
80000d90:	0347a783          	lw	a5,52(a5)
80000d94:	00078593          	mv	a1,a5
80000d98:	8000c7b7          	lui	a5,0x8000c
80000d9c:	15078513          	addi	a0,a5,336 # 8000c150 <memend+0xf800c150>
80000da0:	404000ef          	jal	ra,800011a4 <printf>
    printf("a6: %d \n",tf->a6);
80000da4:	fec42783          	lw	a5,-20(s0)
80000da8:	0387a783          	lw	a5,56(a5)
80000dac:	00078593          	mv	a1,a5
80000db0:	8000c7b7          	lui	a5,0x8000c
80000db4:	15c78513          	addi	a0,a5,348 # 8000c15c <memend+0xf800c15c>
80000db8:	3ec000ef          	jal	ra,800011a4 <printf>
    printf("a7: %d \n",tf->a7);
80000dbc:	fec42783          	lw	a5,-20(s0)
80000dc0:	03c7a783          	lw	a5,60(a5)
80000dc4:	00078593          	mv	a1,a5
80000dc8:	8000c7b7          	lui	a5,0x8000c
80000dcc:	16878513          	addi	a0,a5,360 # 8000c168 <memend+0xf800c168>
80000dd0:	3d4000ef          	jal	ra,800011a4 <printf>
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
80000dfc:	1e0010ef          	jal	ra,80001fdc <nowproc>
80000e00:	fea42623          	sw	a0,-20(s0)
    s_sstatus_xpp(RISCV_U);
80000e04:	00000513          	li	a0,0
80000e08:	bbdff0ef          	jal	ra,800009c4 <s_sstatus_xpp>
    w_stvec((uint32)usertrap);
80000e0c:	800007b7          	lui	a5,0x80000
80000e10:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80000e14:	00078513          	mv	a0,a5
80000e18:	c51ff0ef          	jal	ra,80000a68 <w_stvec>
    addr_t satp=(SATP_SV32|(addr_t)(p->pagetable)>>12);
80000e1c:	fec42783          	lw	a5,-20(s0)
80000e20:	0887a783          	lw	a5,136(a5)
80000e24:	00c7d713          	srli	a4,a5,0xc
80000e28:	800007b7          	lui	a5,0x80000
80000e2c:	00f767b3          	or	a5,a4,a5
80000e30:	fef42423          	sw	a5,-24(s0)
    // ptf(p->trapframe);

    // printf("%p\n",p->trapframe);
    // printf("sepc: %p\n",r_sepc());
    
    w_sepc((addr_t)p->trapframe->epc);
80000e34:	fec42783          	lw	a5,-20(s0)
80000e38:	0087a783          	lw	a5,8(a5) # 80000008 <memend+0xf8000008>
80000e3c:	00c7a783          	lw	a5,12(a5)
80000e40:	00078513          	mv	a0,a5
80000e44:	bfdff0ef          	jal	ra,80000a40 <w_sepc>

    p->trapframe->kernel_satp=r_satp();
80000e48:	fec42783          	lw	a5,-20(s0)
80000e4c:	0087a483          	lw	s1,8(a5)
80000e50:	c41ff0ef          	jal	ra,80000a90 <r_satp>
80000e54:	00050793          	mv	a5,a0
80000e58:	00f4a023          	sw	a5,0(s1)
    p->trapframe->kernel_tvec=(addr_t)trapvec;
80000e5c:	fec42783          	lw	a5,-20(s0)
80000e60:	0087a783          	lw	a5,8(a5)
80000e64:	80001737          	lui	a4,0x80001
80000e68:	f1870713          	addi	a4,a4,-232 # 80000f18 <memend+0xf8000f18>
80000e6c:	00e7a223          	sw	a4,4(a5)
    p->trapframe->kernel_sp=(addr_t)p->kernelstack;
80000e70:	fec42783          	lw	a5,-20(s0)
80000e74:	0087a783          	lw	a5,8(a5)
80000e78:	fec42703          	lw	a4,-20(s0)
80000e7c:	08c72703          	lw	a4,140(a4)
80000e80:	00e7a423          	sw	a4,8(a5)

    // printf("%p\n",p->kernelstack);
    userret((addr_t*)TRAPFRAME,satp);
80000e84:	fe842583          	lw	a1,-24(s0)
80000e88:	ffffe537          	lui	a0,0xffffe
80000e8c:	ca4ff0ef          	jal	ra,80000330 <userret>
}
80000e90:	00000013          	nop
80000e94:	01c12083          	lw	ra,28(sp)
80000e98:	01812403          	lw	s0,24(sp)
80000e9c:	01412483          	lw	s1,20(sp)
80000ea0:	02010113          	addi	sp,sp,32
80000ea4:	00008067          	ret

80000ea8 <startproc>:

static int first = 0; 
void startproc(){
80000ea8:	ff010113          	addi	sp,sp,-16
80000eac:	00112623          	sw	ra,12(sp)
80000eb0:	00812423          	sw	s0,8(sp)
80000eb4:	01010413          	addi	s0,sp,16
    first = 1;
80000eb8:	8000d7b7          	lui	a5,0x8000d
80000ebc:	00100713          	li	a4,1
80000ec0:	00e7a223          	sw	a4,4(a5) # 8000d004 <memend+0xf800d004>
    usertrapret();
80000ec4:	f25ff0ef          	jal	ra,80000de8 <usertrapret>
}
80000ec8:	00000013          	nop
80000ecc:	00c12083          	lw	ra,12(sp)
80000ed0:	00812403          	lw	s0,8(sp)
80000ed4:	01010113          	addi	sp,sp,16
80000ed8:	00008067          	ret

80000edc <timerintr>:

void timerintr(){
80000edc:	ff010113          	addi	sp,sp,-16
80000ee0:	00112623          	sw	ra,12(sp)
80000ee4:	00812423          	sw	s0,8(sp)
80000ee8:	01010413          	addi	s0,sp,16
    w_sip(r_sip()& ~2); // 清除中断
80000eec:	c1dff0ef          	jal	ra,80000b08 <r_sip>
80000ef0:	00050793          	mv	a5,a0
80000ef4:	ffd7f793          	andi	a5,a5,-3
80000ef8:	00078513          	mv	a0,a5
80000efc:	c35ff0ef          	jal	ra,80000b30 <w_sip>
    yield();
80000f00:	514010ef          	jal	ra,80002414 <yield>
    
}
80000f04:	00000013          	nop
80000f08:	00c12083          	lw	ra,12(sp)
80000f0c:	00812403          	lw	s0,8(sp)
80000f10:	01010113          	addi	sp,sp,16
80000f14:	00008067          	ret

80000f18 <trapvec>:

void trapvec(){
80000f18:	fe010113          	addi	sp,sp,-32
80000f1c:	00112e23          	sw	ra,28(sp)
80000f20:	00812c23          	sw	s0,24(sp)
80000f24:	02010413          	addi	s0,sp,32
    int where=r_sstatus()&S_SPP_SET;
80000f28:	a4dff0ef          	jal	ra,80000974 <r_sstatus>
80000f2c:	00050793          	mv	a5,a0
80000f30:	1007f793          	andi	a5,a5,256
80000f34:	fef42623          	sw	a5,-20(s0)
    w_stvec((reg_t)kvec);
80000f38:	800007b7          	lui	a5,0x80000
80000f3c:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000f40:	00078513          	mv	a0,a5
80000f44:	b25ff0ef          	jal	ra,80000a68 <w_stvec>

    uint32 scause=r_scause();
80000f48:	b71ff0ef          	jal	ra,80000ab8 <r_scause>
80000f4c:	fea42423          	sw	a0,-24(s0)

    uint16 code= scause & 0xffff;
80000f50:	fe842783          	lw	a5,-24(s0)
80000f54:	fef41323          	sh	a5,-26(s0)

    if(scause & (1<<31)){
80000f58:	fe842783          	lw	a5,-24(s0)
80000f5c:	0607dc63          	bgez	a5,80000fd4 <trapvec+0xbc>
    //     printf("Interrupt : ");
        switch (code)
80000f60:	fe645783          	lhu	a5,-26(s0)
80000f64:	00900713          	li	a4,9
80000f68:	02e78c63          	beq	a5,a4,80000fa0 <trapvec+0x88>
80000f6c:	00900713          	li	a4,9
80000f70:	04f74263          	blt	a4,a5,80000fb4 <trapvec+0x9c>
80000f74:	00100713          	li	a4,1
80000f78:	00e78863          	beq	a5,a4,80000f88 <trapvec+0x70>
80000f7c:	00500713          	li	a4,5
80000f80:	00e78863          	beq	a5,a4,80000f90 <trapvec+0x78>
80000f84:	0300006f          	j	80000fb4 <trapvec+0x9c>
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
80000f88:	f55ff0ef          	jal	ra,80000edc <timerintr>
            break;
80000f8c:	0380006f          	j	80000fc4 <trapvec+0xac>
        case 5:
            printf("Supervisor timer interrupt\n");
80000f90:	8000c7b7          	lui	a5,0x8000c
80000f94:	17478513          	addi	a0,a5,372 # 8000c174 <memend+0xf800c174>
80000f98:	20c000ef          	jal	ra,800011a4 <printf>
            break;
80000f9c:	0280006f          	j	80000fc4 <trapvec+0xac>
        case 9:
            printf("Supervisor external interrupt\n");
80000fa0:	8000c7b7          	lui	a5,0x8000c
80000fa4:	19078513          	addi	a0,a5,400 # 8000c190 <memend+0xf800c190>
80000fa8:	1fc000ef          	jal	ra,800011a4 <printf>
            externinterrupt();
80000fac:	badff0ef          	jal	ra,80000b58 <externinterrupt>
            break;
80000fb0:	0140006f          	j	80000fc4 <trapvec+0xac>
        default:
            printf("Other interrupt\n");
80000fb4:	8000c7b7          	lui	a5,0x8000c
80000fb8:	1b078513          	addi	a0,a5,432 # 8000c1b0 <memend+0xf800c1b0>
80000fbc:	1e8000ef          	jal	ra,800011a4 <printf>
            break;
80000fc0:	00000013          	nop
        }
        where ? : usertrapret();
80000fc4:	fec42783          	lw	a5,-20(s0)
80000fc8:	18079863          	bnez	a5,80001158 <trapvec+0x240>
80000fcc:	e1dff0ef          	jal	ra,80000de8 <usertrapret>
            printf("Other\n");
            break;
        }
        panic("Trap Exception");
    }
}
80000fd0:	1880006f          	j	80001158 <trapvec+0x240>
        printf("Exception : ");
80000fd4:	8000c7b7          	lui	a5,0x8000c
80000fd8:	1c478513          	addi	a0,a5,452 # 8000c1c4 <memend+0xf800c1c4>
80000fdc:	1c8000ef          	jal	ra,800011a4 <printf>
        switch (code)
80000fe0:	fe645783          	lhu	a5,-26(s0)
80000fe4:	00f00713          	li	a4,15
80000fe8:	14f76a63          	bltu	a4,a5,8000113c <trapvec+0x224>
80000fec:	00279713          	slli	a4,a5,0x2
80000ff0:	8000c7b7          	lui	a5,0x8000c
80000ff4:	34878793          	addi	a5,a5,840 # 8000c348 <memend+0xf800c348>
80000ff8:	00f707b3          	add	a5,a4,a5
80000ffc:	0007a783          	lw	a5,0(a5)
80001000:	00078067          	jr	a5
            printf("Instruction address misaligned\n");
80001004:	8000c7b7          	lui	a5,0x8000c
80001008:	1d478513          	addi	a0,a5,468 # 8000c1d4 <memend+0xf800c1d4>
8000100c:	198000ef          	jal	ra,800011a4 <printf>
            break;
80001010:	13c0006f          	j	8000114c <trapvec+0x234>
            printf("Instruction access fault\n");
80001014:	8000c7b7          	lui	a5,0x8000c
80001018:	1f478513          	addi	a0,a5,500 # 8000c1f4 <memend+0xf800c1f4>
8000101c:	188000ef          	jal	ra,800011a4 <printf>
            break;
80001020:	12c0006f          	j	8000114c <trapvec+0x234>
            printf("Illegal instruction\n");
80001024:	8000c7b7          	lui	a5,0x8000c
80001028:	21078513          	addi	a0,a5,528 # 8000c210 <memend+0xf800c210>
8000102c:	178000ef          	jal	ra,800011a4 <printf>
            break;
80001030:	11c0006f          	j	8000114c <trapvec+0x234>
            printf("Breakpoint\n");
80001034:	8000c7b7          	lui	a5,0x8000c
80001038:	22878513          	addi	a0,a5,552 # 8000c228 <memend+0xf800c228>
8000103c:	168000ef          	jal	ra,800011a4 <printf>
            break;
80001040:	10c0006f          	j	8000114c <trapvec+0x234>
            printf("Load address misaligned\n");
80001044:	8000c7b7          	lui	a5,0x8000c
80001048:	23478513          	addi	a0,a5,564 # 8000c234 <memend+0xf800c234>
8000104c:	158000ef          	jal	ra,800011a4 <printf>
            break;
80001050:	0fc0006f          	j	8000114c <trapvec+0x234>
            printf("Load access fault\n");
80001054:	8000c7b7          	lui	a5,0x8000c
80001058:	25078513          	addi	a0,a5,592 # 8000c250 <memend+0xf800c250>
8000105c:	148000ef          	jal	ra,800011a4 <printf>
            printf("stval va: %p\n",r_stval());
80001060:	a81ff0ef          	jal	ra,80000ae0 <r_stval>
80001064:	00050793          	mv	a5,a0
80001068:	00078593          	mv	a1,a5
8000106c:	8000c7b7          	lui	a5,0x8000c
80001070:	26478513          	addi	a0,a5,612 # 8000c264 <memend+0xf800c264>
80001074:	130000ef          	jal	ra,800011a4 <printf>
            break;
80001078:	0d40006f          	j	8000114c <trapvec+0x234>
            printf("Store/AMO address misaligned\n");
8000107c:	8000c7b7          	lui	a5,0x8000c
80001080:	27478513          	addi	a0,a5,628 # 8000c274 <memend+0xf800c274>
80001084:	120000ef          	jal	ra,800011a4 <printf>
            break;
80001088:	0c40006f          	j	8000114c <trapvec+0x234>
            printf("Store/AMO access fault\n");
8000108c:	8000c7b7          	lui	a5,0x8000c
80001090:	29478513          	addi	a0,a5,660 # 8000c294 <memend+0xf800c294>
80001094:	110000ef          	jal	ra,800011a4 <printf>
            printf("stval va: %p\n",r_stval());
80001098:	a49ff0ef          	jal	ra,80000ae0 <r_stval>
8000109c:	00050793          	mv	a5,a0
800010a0:	00078593          	mv	a1,a5
800010a4:	8000c7b7          	lui	a5,0x8000c
800010a8:	26478513          	addi	a0,a5,612 # 8000c264 <memend+0xf800c264>
800010ac:	0f8000ef          	jal	ra,800011a4 <printf>
            break;
800010b0:	09c0006f          	j	8000114c <trapvec+0x234>
            printf("Environment call from U-mode\n");
800010b4:	8000c7b7          	lui	a5,0x8000c
800010b8:	2ac78513          	addi	a0,a5,684 # 8000c2ac <memend+0xf800c2ac>
800010bc:	0e8000ef          	jal	ra,800011a4 <printf>
            syscall();
800010c0:	315010ef          	jal	ra,80002bd4 <syscall>
            usertrapret();
800010c4:	d25ff0ef          	jal	ra,80000de8 <usertrapret>
            break;
800010c8:	0840006f          	j	8000114c <trapvec+0x234>
            printf("Environment call from S-mode\n");
800010cc:	8000c7b7          	lui	a5,0x8000c
800010d0:	2cc78513          	addi	a0,a5,716 # 8000c2cc <memend+0xf800c2cc>
800010d4:	0d0000ef          	jal	ra,800011a4 <printf>
            first ? usertrapret():startproc();
800010d8:	8000d7b7          	lui	a5,0x8000d
800010dc:	0047a783          	lw	a5,4(a5) # 8000d004 <memend+0xf800d004>
800010e0:	00078663          	beqz	a5,800010ec <trapvec+0x1d4>
800010e4:	d05ff0ef          	jal	ra,80000de8 <usertrapret>
            break;
800010e8:	0640006f          	j	8000114c <trapvec+0x234>
            first ? usertrapret():startproc();
800010ec:	dbdff0ef          	jal	ra,80000ea8 <startproc>
            break;
800010f0:	05c0006f          	j	8000114c <trapvec+0x234>
            printf("Instruction page fault\n");
800010f4:	8000c7b7          	lui	a5,0x8000c
800010f8:	2ec78513          	addi	a0,a5,748 # 8000c2ec <memend+0xf800c2ec>
800010fc:	0a8000ef          	jal	ra,800011a4 <printf>
            printf("stval va: %p\n",r_stval());
80001100:	9e1ff0ef          	jal	ra,80000ae0 <r_stval>
80001104:	00050793          	mv	a5,a0
80001108:	00078593          	mv	a1,a5
8000110c:	8000c7b7          	lui	a5,0x8000c
80001110:	26478513          	addi	a0,a5,612 # 8000c264 <memend+0xf800c264>
80001114:	090000ef          	jal	ra,800011a4 <printf>
            break;
80001118:	0340006f          	j	8000114c <trapvec+0x234>
            printf("Load page fault\n");
8000111c:	8000c7b7          	lui	a5,0x8000c
80001120:	30478513          	addi	a0,a5,772 # 8000c304 <memend+0xf800c304>
80001124:	080000ef          	jal	ra,800011a4 <printf>
            break;
80001128:	0240006f          	j	8000114c <trapvec+0x234>
            printf("Store/AMO page fault\n");
8000112c:	8000c7b7          	lui	a5,0x8000c
80001130:	31878513          	addi	a0,a5,792 # 8000c318 <memend+0xf800c318>
80001134:	070000ef          	jal	ra,800011a4 <printf>
            break;
80001138:	0140006f          	j	8000114c <trapvec+0x234>
            printf("Other\n");
8000113c:	8000c7b7          	lui	a5,0x8000c
80001140:	33078513          	addi	a0,a5,816 # 8000c330 <memend+0xf800c330>
80001144:	060000ef          	jal	ra,800011a4 <printf>
            break;
80001148:	00000013          	nop
        panic("Trap Exception");
8000114c:	8000c7b7          	lui	a5,0x8000c
80001150:	33878513          	addi	a0,a5,824 # 8000c338 <memend+0xf800c338>
80001154:	018000ef          	jal	ra,8000116c <panic>
}
80001158:	00000013          	nop
8000115c:	01c12083          	lw	ra,28(sp)
80001160:	01812403          	lw	s0,24(sp)
80001164:	02010113          	addi	sp,sp,32
80001168:	00008067          	ret

8000116c <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
8000116c:	fe010113          	addi	sp,sp,-32
80001170:	00112e23          	sw	ra,28(sp)
80001174:	00812c23          	sw	s0,24(sp)
80001178:	02010413          	addi	s0,sp,32
8000117c:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80001180:	8000c7b7          	lui	a5,0x8000c
80001184:	38878513          	addi	a0,a5,904 # 8000c388 <memend+0xf800c388>
80001188:	eb8ff0ef          	jal	ra,80000840 <uartputs>
    uartputs(s);
8000118c:	fec42503          	lw	a0,-20(s0)
80001190:	eb0ff0ef          	jal	ra,80000840 <uartputs>
	uartputs("\n");
80001194:	8000c7b7          	lui	a5,0x8000c
80001198:	39078513          	addi	a0,a5,912 # 8000c390 <memend+0xf800c390>
8000119c:	ea4ff0ef          	jal	ra,80000840 <uartputs>
    while(1);
800011a0:	0000006f          	j	800011a0 <panic+0x34>

800011a4 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
800011a4:	f8010113          	addi	sp,sp,-128
800011a8:	04112e23          	sw	ra,92(sp)
800011ac:	04812c23          	sw	s0,88(sp)
800011b0:	06010413          	addi	s0,sp,96
800011b4:	faa42623          	sw	a0,-84(s0)
800011b8:	00b42223          	sw	a1,4(s0)
800011bc:	00c42423          	sw	a2,8(s0)
800011c0:	00d42623          	sw	a3,12(s0)
800011c4:	00e42823          	sw	a4,16(s0)
800011c8:	00f42a23          	sw	a5,20(s0)
800011cc:	01042c23          	sw	a6,24(s0)
800011d0:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
800011d4:	02040793          	addi	a5,s0,32
800011d8:	faf42423          	sw	a5,-88(s0)
800011dc:	fa842783          	lw	a5,-88(s0)
800011e0:	fe478793          	addi	a5,a5,-28
800011e4:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
800011e8:	fac42783          	lw	a5,-84(s0)
800011ec:	fef42623          	sw	a5,-20(s0)
	int tt=0;
800011f0:	fe042423          	sw	zero,-24(s0)
	int idx=0;
800011f4:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
800011f8:	36c0006f          	j	80001564 <printf+0x3c0>
		if(ch=='%'){
800011fc:	fbf44703          	lbu	a4,-65(s0)
80001200:	02500793          	li	a5,37
80001204:	04f71863          	bne	a4,a5,80001254 <printf+0xb0>
			if(tt==1){
80001208:	fe842703          	lw	a4,-24(s0)
8000120c:	00100793          	li	a5,1
80001210:	02f71663          	bne	a4,a5,8000123c <printf+0x98>
				outbuf[idx++]='%';
80001214:	fe442783          	lw	a5,-28(s0)
80001218:	00178713          	addi	a4,a5,1
8000121c:	fee42223          	sw	a4,-28(s0)
80001220:	8000d737          	lui	a4,0x8000d
80001224:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001228:	00f707b3          	add	a5,a4,a5
8000122c:	02500713          	li	a4,37
80001230:	00e78023          	sb	a4,0(a5)
				tt=0;
80001234:	fe042423          	sw	zero,-24(s0)
80001238:	00c0006f          	j	80001244 <printf+0xa0>
			}else{
				tt=1;
8000123c:	00100793          	li	a5,1
80001240:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80001244:	fec42783          	lw	a5,-20(s0)
80001248:	00178793          	addi	a5,a5,1
8000124c:	fef42623          	sw	a5,-20(s0)
80001250:	3140006f          	j	80001564 <printf+0x3c0>
		}else{
			if(tt==1){
80001254:	fe842703          	lw	a4,-24(s0)
80001258:	00100793          	li	a5,1
8000125c:	2cf71e63          	bne	a4,a5,80001538 <printf+0x394>
				switch (ch)
80001260:	fbf44783          	lbu	a5,-65(s0)
80001264:	fa878793          	addi	a5,a5,-88
80001268:	02000713          	li	a4,32
8000126c:	2af76663          	bltu	a4,a5,80001518 <printf+0x374>
80001270:	00279713          	slli	a4,a5,0x2
80001274:	8000c7b7          	lui	a5,0x8000c
80001278:	3ac78793          	addi	a5,a5,940 # 8000c3ac <memend+0xf800c3ac>
8000127c:	00f707b3          	add	a5,a4,a5
80001280:	0007a783          	lw	a5,0(a5)
80001284:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80001288:	fb842783          	lw	a5,-72(s0)
8000128c:	00478713          	addi	a4,a5,4
80001290:	fae42c23          	sw	a4,-72(s0)
80001294:	0007a783          	lw	a5,0(a5)
80001298:	fef42023          	sw	a5,-32(s0)
					int len=0;
8000129c:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
800012a0:	fe042783          	lw	a5,-32(s0)
800012a4:	fcf42c23          	sw	a5,-40(s0)
800012a8:	0100006f          	j	800012b8 <printf+0x114>
800012ac:	fdc42783          	lw	a5,-36(s0)
800012b0:	00178793          	addi	a5,a5,1
800012b4:	fcf42e23          	sw	a5,-36(s0)
800012b8:	fd842703          	lw	a4,-40(s0)
800012bc:	00a00793          	li	a5,10
800012c0:	02f747b3          	div	a5,a4,a5
800012c4:	fcf42c23          	sw	a5,-40(s0)
800012c8:	fd842783          	lw	a5,-40(s0)
800012cc:	fe0790e3          	bnez	a5,800012ac <printf+0x108>
					for(int i=len;i>=0;i--){
800012d0:	fdc42783          	lw	a5,-36(s0)
800012d4:	fcf42a23          	sw	a5,-44(s0)
800012d8:	0540006f          	j	8000132c <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
800012dc:	fe042703          	lw	a4,-32(s0)
800012e0:	00a00793          	li	a5,10
800012e4:	02f767b3          	rem	a5,a4,a5
800012e8:	0ff7f713          	andi	a4,a5,255
800012ec:	fe442683          	lw	a3,-28(s0)
800012f0:	fd442783          	lw	a5,-44(s0)
800012f4:	00f687b3          	add	a5,a3,a5
800012f8:	03070713          	addi	a4,a4,48
800012fc:	0ff77713          	andi	a4,a4,255
80001300:	8000d6b7          	lui	a3,0x8000d
80001304:	00868693          	addi	a3,a3,8 # 8000d008 <memend+0xf800d008>
80001308:	00f687b3          	add	a5,a3,a5
8000130c:	00e78023          	sb	a4,0(a5)
						x/=10;
80001310:	fe042703          	lw	a4,-32(s0)
80001314:	00a00793          	li	a5,10
80001318:	02f747b3          	div	a5,a4,a5
8000131c:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80001320:	fd442783          	lw	a5,-44(s0)
80001324:	fff78793          	addi	a5,a5,-1
80001328:	fcf42a23          	sw	a5,-44(s0)
8000132c:	fd442783          	lw	a5,-44(s0)
80001330:	fa07d6e3          	bgez	a5,800012dc <printf+0x138>
					}
					idx+=(len+1);
80001334:	fdc42783          	lw	a5,-36(s0)
80001338:	00178793          	addi	a5,a5,1
8000133c:	fe442703          	lw	a4,-28(s0)
80001340:	00f707b3          	add	a5,a4,a5
80001344:	fef42223          	sw	a5,-28(s0)
					tt=0;
80001348:	fe042423          	sw	zero,-24(s0)
					break;
8000134c:	1dc0006f          	j	80001528 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80001350:	fe442783          	lw	a5,-28(s0)
80001354:	00178713          	addi	a4,a5,1
80001358:	fee42223          	sw	a4,-28(s0)
8000135c:	8000d737          	lui	a4,0x8000d
80001360:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001364:	00f707b3          	add	a5,a4,a5
80001368:	03000713          	li	a4,48
8000136c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80001370:	fe442783          	lw	a5,-28(s0)
80001374:	00178713          	addi	a4,a5,1
80001378:	fee42223          	sw	a4,-28(s0)
8000137c:	8000d737          	lui	a4,0x8000d
80001380:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001384:	00f707b3          	add	a5,a4,a5
80001388:	07800713          	li	a4,120
8000138c:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80001390:	fb842783          	lw	a5,-72(s0)
80001394:	00478713          	addi	a4,a5,4
80001398:	fae42c23          	sw	a4,-72(s0)
8000139c:	0007a783          	lw	a5,0(a5)
800013a0:	fcf42823          	sw	a5,-48(s0)
					int len=0;
800013a4:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
800013a8:	fd042783          	lw	a5,-48(s0)
800013ac:	fcf42423          	sw	a5,-56(s0)
800013b0:	0100006f          	j	800013c0 <printf+0x21c>
800013b4:	fcc42783          	lw	a5,-52(s0)
800013b8:	00178793          	addi	a5,a5,1
800013bc:	fcf42623          	sw	a5,-52(s0)
800013c0:	fc842783          	lw	a5,-56(s0)
800013c4:	0047d793          	srli	a5,a5,0x4
800013c8:	fcf42423          	sw	a5,-56(s0)
800013cc:	fc842783          	lw	a5,-56(s0)
800013d0:	fe0792e3          	bnez	a5,800013b4 <printf+0x210>
					for(int i=len;i>=0;i--){
800013d4:	fcc42783          	lw	a5,-52(s0)
800013d8:	fcf42223          	sw	a5,-60(s0)
800013dc:	0840006f          	j	80001460 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
800013e0:	fd042783          	lw	a5,-48(s0)
800013e4:	00f7f713          	andi	a4,a5,15
800013e8:	00900793          	li	a5,9
800013ec:	02e7f063          	bgeu	a5,a4,8000140c <printf+0x268>
800013f0:	fd042783          	lw	a5,-48(s0)
800013f4:	0ff7f793          	andi	a5,a5,255
800013f8:	00f7f793          	andi	a5,a5,15
800013fc:	0ff7f793          	andi	a5,a5,255
80001400:	05778793          	addi	a5,a5,87
80001404:	0ff7f793          	andi	a5,a5,255
80001408:	01c0006f          	j	80001424 <printf+0x280>
8000140c:	fd042783          	lw	a5,-48(s0)
80001410:	0ff7f793          	andi	a5,a5,255
80001414:	00f7f793          	andi	a5,a5,15
80001418:	0ff7f793          	andi	a5,a5,255
8000141c:	03078793          	addi	a5,a5,48
80001420:	0ff7f793          	andi	a5,a5,255
80001424:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80001428:	fe442703          	lw	a4,-28(s0)
8000142c:	fc442783          	lw	a5,-60(s0)
80001430:	00f707b3          	add	a5,a4,a5
80001434:	8000d737          	lui	a4,0x8000d
80001438:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
8000143c:	00f707b3          	add	a5,a4,a5
80001440:	fbe44703          	lbu	a4,-66(s0)
80001444:	00e78023          	sb	a4,0(a5)
						x/=16;
80001448:	fd042783          	lw	a5,-48(s0)
8000144c:	0047d793          	srli	a5,a5,0x4
80001450:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80001454:	fc442783          	lw	a5,-60(s0)
80001458:	fff78793          	addi	a5,a5,-1
8000145c:	fcf42223          	sw	a5,-60(s0)
80001460:	fc442783          	lw	a5,-60(s0)
80001464:	f607dee3          	bgez	a5,800013e0 <printf+0x23c>
					}
					idx+=(len+1);
80001468:	fcc42783          	lw	a5,-52(s0)
8000146c:	00178793          	addi	a5,a5,1
80001470:	fe442703          	lw	a4,-28(s0)
80001474:	00f707b3          	add	a5,a4,a5
80001478:	fef42223          	sw	a5,-28(s0)
					tt=0;
8000147c:	fe042423          	sw	zero,-24(s0)
					break;
80001480:	0a80006f          	j	80001528 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80001484:	fb842783          	lw	a5,-72(s0)
80001488:	00478713          	addi	a4,a5,4
8000148c:	fae42c23          	sw	a4,-72(s0)
80001490:	0007a783          	lw	a5,0(a5)
80001494:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80001498:	fe442783          	lw	a5,-28(s0)
8000149c:	00178713          	addi	a4,a5,1
800014a0:	fee42223          	sw	a4,-28(s0)
800014a4:	8000d737          	lui	a4,0x8000d
800014a8:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
800014ac:	00f707b3          	add	a5,a4,a5
800014b0:	fbf44703          	lbu	a4,-65(s0)
800014b4:	00e78023          	sb	a4,0(a5)
					tt=0;
800014b8:	fe042423          	sw	zero,-24(s0)
					break;
800014bc:	06c0006f          	j	80001528 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
800014c0:	fb842783          	lw	a5,-72(s0)
800014c4:	00478713          	addi	a4,a5,4
800014c8:	fae42c23          	sw	a4,-72(s0)
800014cc:	0007a783          	lw	a5,0(a5)
800014d0:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
800014d4:	0300006f          	j	80001504 <printf+0x360>
						outbuf[idx++]=*ss++;
800014d8:	fc042703          	lw	a4,-64(s0)
800014dc:	00170793          	addi	a5,a4,1
800014e0:	fcf42023          	sw	a5,-64(s0)
800014e4:	fe442783          	lw	a5,-28(s0)
800014e8:	00178693          	addi	a3,a5,1
800014ec:	fed42223          	sw	a3,-28(s0)
800014f0:	00074703          	lbu	a4,0(a4)
800014f4:	8000d6b7          	lui	a3,0x8000d
800014f8:	00868693          	addi	a3,a3,8 # 8000d008 <memend+0xf800d008>
800014fc:	00f687b3          	add	a5,a3,a5
80001500:	00e78023          	sb	a4,0(a5)
					while(*ss){
80001504:	fc042783          	lw	a5,-64(s0)
80001508:	0007c783          	lbu	a5,0(a5)
8000150c:	fc0796e3          	bnez	a5,800014d8 <printf+0x334>
					}
					tt=0;
80001510:	fe042423          	sw	zero,-24(s0)
					break;
80001514:	0140006f          	j	80001528 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80001518:	8000c7b7          	lui	a5,0x8000c
8000151c:	39478513          	addi	a0,a5,916 # 8000c394 <memend+0xf800c394>
80001520:	c4dff0ef          	jal	ra,8000116c <panic>
					break;
80001524:	00000013          	nop
				}
				s++;
80001528:	fec42783          	lw	a5,-20(s0)
8000152c:	00178793          	addi	a5,a5,1
80001530:	fef42623          	sw	a5,-20(s0)
80001534:	0300006f          	j	80001564 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80001538:	fe442783          	lw	a5,-28(s0)
8000153c:	00178713          	addi	a4,a5,1
80001540:	fee42223          	sw	a4,-28(s0)
80001544:	8000d737          	lui	a4,0x8000d
80001548:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
8000154c:	00f707b3          	add	a5,a4,a5
80001550:	fbf44703          	lbu	a4,-65(s0)
80001554:	00e78023          	sb	a4,0(a5)
				s++;
80001558:	fec42783          	lw	a5,-20(s0)
8000155c:	00178793          	addi	a5,a5,1
80001560:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
80001564:	fec42783          	lw	a5,-20(s0)
80001568:	0007c783          	lbu	a5,0(a5)
8000156c:	faf40fa3          	sb	a5,-65(s0)
80001570:	fbf44783          	lbu	a5,-65(s0)
80001574:	c80794e3          	bnez	a5,800011fc <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80001578:	8000d7b7          	lui	a5,0x8000d
8000157c:	00878713          	addi	a4,a5,8 # 8000d008 <memend+0xf800d008>
80001580:	fe442783          	lw	a5,-28(s0)
80001584:	00f707b3          	add	a5,a4,a5
80001588:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
8000158c:	8000d7b7          	lui	a5,0x8000d
80001590:	00878513          	addi	a0,a5,8 # 8000d008 <memend+0xf800d008>
80001594:	aacff0ef          	jal	ra,80000840 <uartputs>
	return idx;
80001598:	fe442783          	lw	a5,-28(s0)
8000159c:	00078513          	mv	a0,a5
800015a0:	05c12083          	lw	ra,92(sp)
800015a4:	05812403          	lw	s0,88(sp)
800015a8:	08010113          	addi	sp,sp,128
800015ac:	00008067          	ret

800015b0 <minit>:
struct
{
    struct pmp* freelist;
}mem;
#define _DEBUG
void minit(){
800015b0:	fe010113          	addi	sp,sp,-32
800015b4:	00112e23          	sw	ra,28(sp)
800015b8:	00812c23          	sw	s0,24(sp)
800015bc:	02010413          	addi	s0,sp,32
    #ifdef _DEBUG
        printf("textstart:%p    ",textstart);
800015c0:	800007b7          	lui	a5,0x80000
800015c4:	00078593          	mv	a1,a5
800015c8:	8000c7b7          	lui	a5,0x8000c
800015cc:	43078513          	addi	a0,a5,1072 # 8000c430 <memend+0xf800c430>
800015d0:	bd5ff0ef          	jal	ra,800011a4 <printf>
        printf("textend:%p\n",textend);
800015d4:	800037b7          	lui	a5,0x80003
800015d8:	c7478593          	addi	a1,a5,-908 # 80002c74 <memend+0xf8002c74>
800015dc:	8000c7b7          	lui	a5,0x8000c
800015e0:	44478513          	addi	a0,a5,1092 # 8000c444 <memend+0xf800c444>
800015e4:	bc1ff0ef          	jal	ra,800011a4 <printf>
        printf("datastart:%p    ",datastart);
800015e8:	800037b7          	lui	a5,0x80003
800015ec:	00078593          	mv	a1,a5
800015f0:	8000c7b7          	lui	a5,0x8000c
800015f4:	45078513          	addi	a0,a5,1104 # 8000c450 <memend+0xf800c450>
800015f8:	badff0ef          	jal	ra,800011a4 <printf>
        printf("dataend:%p\n",dataend);
800015fc:	8000b7b7          	lui	a5,0x8000b
80001600:	02478593          	addi	a1,a5,36 # 8000b024 <memend+0xf800b024>
80001604:	8000c7b7          	lui	a5,0x8000c
80001608:	46478513          	addi	a0,a5,1124 # 8000c464 <memend+0xf800c464>
8000160c:	b99ff0ef          	jal	ra,800011a4 <printf>
        printf("rodatastart:%p  ",rodatastart);
80001610:	8000c7b7          	lui	a5,0x8000c
80001614:	00078593          	mv	a1,a5
80001618:	8000c7b7          	lui	a5,0x8000c
8000161c:	47078513          	addi	a0,a5,1136 # 8000c470 <memend+0xf800c470>
80001620:	b85ff0ef          	jal	ra,800011a4 <printf>
        printf("rodataend:%p\n",rodataend);
80001624:	8000c7b7          	lui	a5,0x8000c
80001628:	55a78593          	addi	a1,a5,1370 # 8000c55a <memend+0xf800c55a>
8000162c:	8000c7b7          	lui	a5,0x8000c
80001630:	48478513          	addi	a0,a5,1156 # 8000c484 <memend+0xf800c484>
80001634:	b71ff0ef          	jal	ra,800011a4 <printf>
        printf("bssstart:%p     ",bssstart);
80001638:	8000d7b7          	lui	a5,0x8000d
8000163c:	00078593          	mv	a1,a5
80001640:	8000c7b7          	lui	a5,0x8000c
80001644:	49478513          	addi	a0,a5,1172 # 8000c494 <memend+0xf800c494>
80001648:	b5dff0ef          	jal	ra,800011a4 <printf>
        printf("bssend:%p\n",bssend);
8000164c:	8000e7b7          	lui	a5,0x8000e
80001650:	b9078593          	addi	a1,a5,-1136 # 8000db90 <memend+0xf800db90>
80001654:	8000c7b7          	lui	a5,0x8000c
80001658:	4a878513          	addi	a0,a5,1192 # 8000c4a8 <memend+0xf800c4a8>
8000165c:	b49ff0ef          	jal	ra,800011a4 <printf>
        printf("mstart:%p   ",mstart);
80001660:	8000e7b7          	lui	a5,0x8000e
80001664:	00078593          	mv	a1,a5
80001668:	8000c7b7          	lui	a5,0x8000c
8000166c:	4b478513          	addi	a0,a5,1204 # 8000c4b4 <memend+0xf800c4b4>
80001670:	b35ff0ef          	jal	ra,800011a4 <printf>
        printf("mend:%p\n",mend);
80001674:	880007b7          	lui	a5,0x88000
80001678:	00078593          	mv	a1,a5
8000167c:	8000c7b7          	lui	a5,0x8000c
80001680:	4c478513          	addi	a0,a5,1220 # 8000c4c4 <memend+0xf800c4c4>
80001684:	b21ff0ef          	jal	ra,800011a4 <printf>
        printf("stack:%p\n",stacks);
80001688:	800037b7          	lui	a5,0x80003
8000168c:	00078593          	mv	a1,a5
80001690:	8000c7b7          	lui	a5,0x8000c
80001694:	4d078513          	addi	a0,a5,1232 # 8000c4d0 <memend+0xf800c4d0>
80001698:	b0dff0ef          	jal	ra,800011a4 <printf>
    #endif

    char* p=(char*)mstart;
8000169c:	8000e7b7          	lui	a5,0x8000e
800016a0:	00078793          	mv	a5,a5
800016a4:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800016a8:	0380006f          	j	800016e0 <minit+0x130>
        m=(struct pmp*)p;
800016ac:	fec42783          	lw	a5,-20(s0)
800016b0:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
800016b4:	8000e7b7          	lui	a5,0x8000e
800016b8:	a487a703          	lw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
800016bc:	fe842783          	lw	a5,-24(s0)
800016c0:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
800016c4:	8000e7b7          	lui	a5,0x8000e
800016c8:	fe842703          	lw	a4,-24(s0)
800016cc:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800016d0:	fec42703          	lw	a4,-20(s0)
800016d4:	000017b7          	lui	a5,0x1
800016d8:	00f707b3          	add	a5,a4,a5
800016dc:	fef42623          	sw	a5,-20(s0)
800016e0:	fec42703          	lw	a4,-20(s0)
800016e4:	000017b7          	lui	a5,0x1
800016e8:	00f70733          	add	a4,a4,a5
800016ec:	880007b7          	lui	a5,0x88000
800016f0:	00078793          	mv	a5,a5
800016f4:	fae7fce3          	bgeu	a5,a4,800016ac <minit+0xfc>
    }
}
800016f8:	00000013          	nop
800016fc:	00000013          	nop
80001700:	01c12083          	lw	ra,28(sp)
80001704:	01812403          	lw	s0,24(sp)
80001708:	02010113          	addi	sp,sp,32
8000170c:	00008067          	ret

80001710 <palloc>:

void* palloc(){
80001710:	fe010113          	addi	sp,sp,-32
80001714:	00112e23          	sw	ra,28(sp)
80001718:	00812c23          	sw	s0,24(sp)
8000171c:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80001720:	8000e7b7          	lui	a5,0x8000e
80001724:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001728:	fef42623          	sw	a5,-20(s0)
    if(p)
8000172c:	fec42783          	lw	a5,-20(s0)
80001730:	00078c63          	beqz	a5,80001748 <palloc+0x38>
        mem.freelist=mem.freelist->next;
80001734:	8000e7b7          	lui	a5,0x8000e
80001738:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
8000173c:	0007a703          	lw	a4,0(a5)
80001740:	8000e7b7          	lui	a5,0x8000e
80001744:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
    if(p)
80001748:	fec42783          	lw	a5,-20(s0)
8000174c:	00078a63          	beqz	a5,80001760 <palloc+0x50>
        memset(p,0,PGSIZE);
80001750:	00001637          	lui	a2,0x1
80001754:	00000593          	li	a1,0
80001758:	fec42503          	lw	a0,-20(s0)
8000175c:	5e9000ef          	jal	ra,80002544 <memset>
    return (void*)p;
80001760:	fec42783          	lw	a5,-20(s0)
}
80001764:	00078513          	mv	a0,a5
80001768:	01c12083          	lw	ra,28(sp)
8000176c:	01812403          	lw	s0,24(sp)
80001770:	02010113          	addi	sp,sp,32
80001774:	00008067          	ret

80001778 <pfree>:

void pfree(void* addr){
80001778:	fd010113          	addi	sp,sp,-48
8000177c:	02812623          	sw	s0,44(sp)
80001780:	03010413          	addi	s0,sp,48
80001784:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80001788:	fdc42783          	lw	a5,-36(s0)
8000178c:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
80001790:	8000e7b7          	lui	a5,0x8000e
80001794:	a487a703          	lw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
80001798:	fec42783          	lw	a5,-20(s0)
8000179c:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
800017a0:	8000e7b7          	lui	a5,0x8000e
800017a4:	fec42703          	lw	a4,-20(s0)
800017a8:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
800017ac:	00000013          	nop
800017b0:	02c12403          	lw	s0,44(sp)
800017b4:	03010113          	addi	sp,sp,48
800017b8:	00008067          	ret

800017bc <r_tp>:
static inline uint32 r_tp(){
800017bc:	fe010113          	addi	sp,sp,-32
800017c0:	00812e23          	sw	s0,28(sp)
800017c4:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800017c8:	00020793          	mv	a5,tp
800017cc:	fef42623          	sw	a5,-20(s0)
    return x;
800017d0:	fec42783          	lw	a5,-20(s0)
}
800017d4:	00078513          	mv	a0,a5
800017d8:	01c12403          	lw	s0,28(sp)
800017dc:	02010113          	addi	sp,sp,32
800017e0:	00008067          	ret

800017e4 <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
800017e4:	fe010113          	addi	sp,sp,-32
800017e8:	00812e23          	sw	s0,28(sp)
800017ec:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
800017f0:	104027f3          	csrr	a5,sie
800017f4:	fef42623          	sw	a5,-20(s0)
    return x;
800017f8:	fec42783          	lw	a5,-20(s0)
}
800017fc:	00078513          	mv	a0,a5
80001800:	01c12403          	lw	s0,28(sp)
80001804:	02010113          	addi	sp,sp,32
80001808:	00008067          	ret

8000180c <w_sie>:
static inline void w_sie(uint32 x){
8000180c:	fe010113          	addi	sp,sp,-32
80001810:	00812e23          	sw	s0,28(sp)
80001814:	02010413          	addi	s0,sp,32
80001818:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
8000181c:	fec42783          	lw	a5,-20(s0)
80001820:	10479073          	csrw	sie,a5
}
80001824:	00000013          	nop
80001828:	01c12403          	lw	s0,28(sp)
8000182c:	02010113          	addi	sp,sp,32
80001830:	00008067          	ret

80001834 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
80001834:	ff010113          	addi	sp,sp,-16
80001838:	00112623          	sw	ra,12(sp)
8000183c:	00812423          	sw	s0,8(sp)
80001840:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
80001844:	0c0007b7          	lui	a5,0xc000
80001848:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
8000184c:	00100713          	li	a4,1
80001850:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001854:	f69ff0ef          	jal	ra,800017bc <r_tp>
80001858:	00050793          	mv	a5,a0
8000185c:	00879713          	slli	a4,a5,0x8
80001860:	0c0027b7          	lui	a5,0xc002
80001864:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001868:	00f707b3          	add	a5,a4,a5
8000186c:	00078713          	mv	a4,a5
80001870:	40000793          	li	a5,1024
80001874:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001878:	f45ff0ef          	jal	ra,800017bc <r_tp>
8000187c:	00050713          	mv	a4,a0
80001880:	000c07b7          	lui	a5,0xc0
80001884:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
80001888:	00f707b3          	add	a5,a4,a5
8000188c:	00879793          	slli	a5,a5,0x8
80001890:	00078713          	mv	a4,a5
80001894:	40000793          	li	a5,1024
80001898:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
8000189c:	f21ff0ef          	jal	ra,800017bc <r_tp>
800018a0:	00050713          	mv	a4,a0
800018a4:	000067b7          	lui	a5,0x6
800018a8:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800018ac:	00f707b3          	add	a5,a4,a5
800018b0:	00d79793          	slli	a5,a5,0xd
800018b4:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800018b8:	f05ff0ef          	jal	ra,800017bc <r_tp>
800018bc:	00050793          	mv	a5,a0
800018c0:	00d79713          	slli	a4,a5,0xd
800018c4:	0c2017b7          	lui	a5,0xc201
800018c8:	00f707b3          	add	a5,a4,a5
800018cc:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800018d0:	f15ff0ef          	jal	ra,800017e4 <r_sie>
800018d4:	00050793          	mv	a5,a0
800018d8:	2227e793          	ori	a5,a5,546
800018dc:	00078513          	mv	a0,a5
800018e0:	f2dff0ef          	jal	ra,8000180c <w_sie>
}
800018e4:	00000013          	nop
800018e8:	00c12083          	lw	ra,12(sp)
800018ec:	00812403          	lw	s0,8(sp)
800018f0:	01010113          	addi	sp,sp,16
800018f4:	00008067          	ret

800018f8 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
800018f8:	ff010113          	addi	sp,sp,-16
800018fc:	00112623          	sw	ra,12(sp)
80001900:	00812423          	sw	s0,8(sp)
80001904:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001908:	eb5ff0ef          	jal	ra,800017bc <r_tp>
8000190c:	00050793          	mv	a5,a0
80001910:	00d79713          	slli	a4,a5,0xd
80001914:	0c2017b7          	lui	a5,0xc201
80001918:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
8000191c:	00f707b3          	add	a5,a4,a5
80001920:	0007a783          	lw	a5,0(a5)
}
80001924:	00078513          	mv	a0,a5
80001928:	00c12083          	lw	ra,12(sp)
8000192c:	00812403          	lw	s0,8(sp)
80001930:	01010113          	addi	sp,sp,16
80001934:	00008067          	ret

80001938 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001938:	fe010113          	addi	sp,sp,-32
8000193c:	00112e23          	sw	ra,28(sp)
80001940:	00812c23          	sw	s0,24(sp)
80001944:	02010413          	addi	s0,sp,32
80001948:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
8000194c:	e71ff0ef          	jal	ra,800017bc <r_tp>
80001950:	00050793          	mv	a5,a0
80001954:	00d79713          	slli	a4,a5,0xd
80001958:	0c2007b7          	lui	a5,0xc200
8000195c:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
80001960:	00f707b3          	add	a5,a4,a5
80001964:	00078713          	mv	a4,a5
80001968:	fec42783          	lw	a5,-20(s0)
8000196c:	00f72023          	sw	a5,0(a4)
80001970:	00000013          	nop
80001974:	01c12083          	lw	ra,28(sp)
80001978:	01812403          	lw	s0,24(sp)
8000197c:	02010113          	addi	sp,sp,32
80001980:	00008067          	ret

80001984 <w_satp>:
static inline void w_satp(uint32 x){
80001984:	fe010113          	addi	sp,sp,-32
80001988:	00812e23          	sw	s0,28(sp)
8000198c:	02010413          	addi	s0,sp,32
80001990:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80001994:	fec42783          	lw	a5,-20(s0)
80001998:	18079073          	csrw	satp,a5
}
8000199c:	00000013          	nop
800019a0:	01c12403          	lw	s0,28(sp)
800019a4:	02010113          	addi	sp,sp,32
800019a8:	00008067          	ret

800019ac <sfence_vma>:
static inline void sfence_vma(){
800019ac:	ff010113          	addi	sp,sp,-16
800019b0:	00812623          	sw	s0,12(sp)
800019b4:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800019b8:	12000073          	sfence.vma
}
800019bc:	00000013          	nop
800019c0:	00c12403          	lw	s0,12(sp)
800019c4:	01010113          	addi	sp,sp,16
800019c8:	00008067          	ret

800019cc <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
800019cc:	fd010113          	addi	sp,sp,-48
800019d0:	02112623          	sw	ra,44(sp)
800019d4:	02812423          	sw	s0,40(sp)
800019d8:	03010413          	addi	s0,sp,48
800019dc:	fca42e23          	sw	a0,-36(s0)
800019e0:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
800019e4:	fd842783          	lw	a5,-40(s0)
800019e8:	0167d793          	srli	a5,a5,0x16
800019ec:	00279793          	slli	a5,a5,0x2
800019f0:	fdc42703          	lw	a4,-36(s0)
800019f4:	00f707b3          	add	a5,a4,a5
800019f8:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
800019fc:	fec42783          	lw	a5,-20(s0)
80001a00:	0007a783          	lw	a5,0(a5)
80001a04:	0017f793          	andi	a5,a5,1
80001a08:	00078e63          	beqz	a5,80001a24 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001a0c:	fec42783          	lw	a5,-20(s0)
80001a10:	0007a783          	lw	a5,0(a5)
80001a14:	00a7d793          	srli	a5,a5,0xa
80001a18:	00c79793          	slli	a5,a5,0xc
80001a1c:	fcf42e23          	sw	a5,-36(s0)
80001a20:	0340006f          	j	80001a54 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
80001a24:	cedff0ef          	jal	ra,80001710 <palloc>
80001a28:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001a2c:	00001637          	lui	a2,0x1
80001a30:	00000593          	li	a1,0
80001a34:	fdc42503          	lw	a0,-36(s0)
80001a38:	30d000ef          	jal	ra,80002544 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001a3c:	fdc42783          	lw	a5,-36(s0)
80001a40:	00c7d793          	srli	a5,a5,0xc
80001a44:	00a79793          	slli	a5,a5,0xa
80001a48:	0017e713          	ori	a4,a5,1
80001a4c:	fec42783          	lw	a5,-20(s0)
80001a50:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001a54:	fd842783          	lw	a5,-40(s0)
80001a58:	00c7d793          	srli	a5,a5,0xc
80001a5c:	3ff7f793          	andi	a5,a5,1023
80001a60:	00279793          	slli	a5,a5,0x2
80001a64:	fdc42703          	lw	a4,-36(s0)
80001a68:	00f707b3          	add	a5,a4,a5
}
80001a6c:	00078513          	mv	a0,a5
80001a70:	02c12083          	lw	ra,44(sp)
80001a74:	02812403          	lw	s0,40(sp)
80001a78:	03010113          	addi	sp,sp,48
80001a7c:	00008067          	ret

80001a80 <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
80001a80:	fc010113          	addi	sp,sp,-64
80001a84:	02112e23          	sw	ra,60(sp)
80001a88:	02812c23          	sw	s0,56(sp)
80001a8c:	04010413          	addi	s0,sp,64
80001a90:	fca42e23          	sw	a0,-36(s0)
80001a94:	fcb42c23          	sw	a1,-40(s0)
80001a98:	fcc42a23          	sw	a2,-44(s0)
80001a9c:	fcd42823          	sw	a3,-48(s0)
80001aa0:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
80001aa4:	fd842703          	lw	a4,-40(s0)
80001aa8:	fffff7b7          	lui	a5,0xfffff
80001aac:	00f777b3          	and	a5,a4,a5
80001ab0:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
80001ab4:	fd042703          	lw	a4,-48(s0)
80001ab8:	fd842783          	lw	a5,-40(s0)
80001abc:	00f707b3          	add	a5,a4,a5
80001ac0:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
80001ac4:	fffff7b7          	lui	a5,0xfffff
80001ac8:	00f777b3          	and	a5,a4,a5
80001acc:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
80001ad0:	fec42583          	lw	a1,-20(s0)
80001ad4:	fdc42503          	lw	a0,-36(s0)
80001ad8:	ef5ff0ef          	jal	ra,800019cc <acquriepte>
80001adc:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
80001ae0:	fe442783          	lw	a5,-28(s0)
80001ae4:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001ae8:	0017f793          	andi	a5,a5,1
80001aec:	00078863          	beqz	a5,80001afc <vmmap+0x7c>
            panic("repeat map");
80001af0:	8000c7b7          	lui	a5,0x8000c
80001af4:	4dc78513          	addi	a0,a5,1244 # 8000c4dc <memend+0xf800c4dc>
80001af8:	e74ff0ef          	jal	ra,8000116c <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001afc:	fd442783          	lw	a5,-44(s0)
80001b00:	00c7d793          	srli	a5,a5,0xc
80001b04:	00a79713          	slli	a4,a5,0xa
80001b08:	fcc42783          	lw	a5,-52(s0)
80001b0c:	00f767b3          	or	a5,a4,a5
80001b10:	0017e713          	ori	a4,a5,1
80001b14:	fe442783          	lw	a5,-28(s0)
80001b18:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001b1c:	fec42703          	lw	a4,-20(s0)
80001b20:	fe842783          	lw	a5,-24(s0)
80001b24:	02f70463          	beq	a4,a5,80001b4c <vmmap+0xcc>
        start += PGSIZE;
80001b28:	fec42703          	lw	a4,-20(s0)
80001b2c:	000017b7          	lui	a5,0x1
80001b30:	00f707b3          	add	a5,a4,a5
80001b34:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001b38:	fd442703          	lw	a4,-44(s0)
80001b3c:	000017b7          	lui	a5,0x1
80001b40:	00f707b3          	add	a5,a4,a5
80001b44:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001b48:	f89ff06f          	j	80001ad0 <vmmap+0x50>
        if(start==end)  break;
80001b4c:	00000013          	nop
    }
}
80001b50:	00000013          	nop
80001b54:	03c12083          	lw	ra,60(sp)
80001b58:	03812403          	lw	s0,56(sp)
80001b5c:	04010113          	addi	sp,sp,64
80001b60:	00008067          	ret

80001b64 <printpgt>:

void printpgt(addr_t* pgt){
80001b64:	fc010113          	addi	sp,sp,-64
80001b68:	02112e23          	sw	ra,60(sp)
80001b6c:	02812c23          	sw	s0,56(sp)
80001b70:	04010413          	addi	s0,sp,64
80001b74:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
80001b78:	fe042623          	sw	zero,-20(s0)
80001b7c:	0c40006f          	j	80001c40 <printpgt+0xdc>
        pte_t pte=pgt[i];
80001b80:	fec42783          	lw	a5,-20(s0)
80001b84:	00279793          	slli	a5,a5,0x2
80001b88:	fcc42703          	lw	a4,-52(s0)
80001b8c:	00f707b3          	add	a5,a4,a5
80001b90:	0007a783          	lw	a5,0(a5) # 1000 <sz>
80001b94:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
80001b98:	fe442783          	lw	a5,-28(s0)
80001b9c:	0017f793          	andi	a5,a5,1
80001ba0:	08078a63          	beqz	a5,80001c34 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
80001ba4:	fe442783          	lw	a5,-28(s0)
80001ba8:	00a7d793          	srli	a5,a5,0xa
80001bac:	00c79793          	slli	a5,a5,0xc
80001bb0:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
80001bb4:	fe042683          	lw	a3,-32(s0)
80001bb8:	fe442603          	lw	a2,-28(s0)
80001bbc:	fec42583          	lw	a1,-20(s0)
80001bc0:	8000c7b7          	lui	a5,0x8000c
80001bc4:	4e878513          	addi	a0,a5,1256 # 8000c4e8 <memend+0xf800c4e8>
80001bc8:	ddcff0ef          	jal	ra,800011a4 <printf>
            for(int j=0;j<1024;j++){
80001bcc:	fe042423          	sw	zero,-24(s0)
80001bd0:	0580006f          	j	80001c28 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001bd4:	fe842783          	lw	a5,-24(s0)
80001bd8:	00279793          	slli	a5,a5,0x2
80001bdc:	fe042703          	lw	a4,-32(s0)
80001be0:	00f707b3          	add	a5,a4,a5
80001be4:	0007a783          	lw	a5,0(a5)
80001be8:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001bec:	fdc42783          	lw	a5,-36(s0)
80001bf0:	0017f793          	andi	a5,a5,1
80001bf4:	02078463          	beqz	a5,80001c1c <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001bf8:	fdc42783          	lw	a5,-36(s0)
80001bfc:	00a7d793          	srli	a5,a5,0xa
80001c00:	00c79793          	slli	a5,a5,0xc
80001c04:	00078693          	mv	a3,a5
80001c08:	fdc42603          	lw	a2,-36(s0)
80001c0c:	fe842583          	lw	a1,-24(s0)
80001c10:	8000c7b7          	lui	a5,0x8000c
80001c14:	50078513          	addi	a0,a5,1280 # 8000c500 <memend+0xf800c500>
80001c18:	d8cff0ef          	jal	ra,800011a4 <printf>
            for(int j=0;j<1024;j++){
80001c1c:	fe842783          	lw	a5,-24(s0)
80001c20:	00178793          	addi	a5,a5,1
80001c24:	fef42423          	sw	a5,-24(s0)
80001c28:	fe842703          	lw	a4,-24(s0)
80001c2c:	3ff00793          	li	a5,1023
80001c30:	fae7d2e3          	bge	a5,a4,80001bd4 <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001c34:	fec42783          	lw	a5,-20(s0)
80001c38:	00178793          	addi	a5,a5,1
80001c3c:	fef42623          	sw	a5,-20(s0)
80001c40:	fec42703          	lw	a4,-20(s0)
80001c44:	3ff00793          	li	a5,1023
80001c48:	f2e7dce3          	bge	a5,a4,80001b80 <printpgt+0x1c>
                }
            }
        }
    }
}
80001c4c:	00000013          	nop
80001c50:	00000013          	nop
80001c54:	03c12083          	lw	ra,60(sp)
80001c58:	03812403          	lw	s0,56(sp)
80001c5c:	04010113          	addi	sp,sp,64
80001c60:	00008067          	ret

80001c64 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
80001c64:	fd010113          	addi	sp,sp,-48
80001c68:	02112623          	sw	ra,44(sp)
80001c6c:	02812423          	sw	s0,40(sp)
80001c70:	03010413          	addi	s0,sp,48
80001c74:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
80001c78:	fe042623          	sw	zero,-20(s0)
80001c7c:	04c0006f          	j	80001cc8 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
80001c80:	fec42783          	lw	a5,-20(s0)
80001c84:	00d79793          	slli	a5,a5,0xd
80001c88:	00078713          	mv	a4,a5
80001c8c:	c00017b7          	lui	a5,0xc0001
80001c90:	00f707b3          	add	a5,a4,a5
80001c94:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
80001c98:	a79ff0ef          	jal	ra,80001710 <palloc>
80001c9c:	00050793          	mv	a5,a0
80001ca0:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
80001ca4:	00600713          	li	a4,6
80001ca8:	000016b7          	lui	a3,0x1
80001cac:	fe442603          	lw	a2,-28(s0)
80001cb0:	fe842583          	lw	a1,-24(s0)
80001cb4:	fdc42503          	lw	a0,-36(s0)
80001cb8:	dc9ff0ef          	jal	ra,80001a80 <vmmap>
    for(int i=0;i<NPROC;i++){
80001cbc:	fec42783          	lw	a5,-20(s0)
80001cc0:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
80001cc4:	fef42623          	sw	a5,-20(s0)
80001cc8:	fec42703          	lw	a4,-20(s0)
80001ccc:	00300793          	li	a5,3
80001cd0:	fae7d8e3          	bge	a5,a4,80001c80 <mkstack+0x1c>
    }
}
80001cd4:	00000013          	nop
80001cd8:	00000013          	nop
80001cdc:	02c12083          	lw	ra,44(sp)
80001ce0:	02812403          	lw	s0,40(sp)
80001ce4:	03010113          	addi	sp,sp,48
80001ce8:	00008067          	ret

80001cec <kvminit>:

// 初始化虚拟内存
void kvminit(){
80001cec:	ff010113          	addi	sp,sp,-16
80001cf0:	00112623          	sw	ra,12(sp)
80001cf4:	00812423          	sw	s0,8(sp)
80001cf8:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001cfc:	a15ff0ef          	jal	ra,80001710 <palloc>
80001d00:	00050713          	mv	a4,a0
80001d04:	8000e7b7          	lui	a5,0x8000e
80001d08:	a4e7a623          	sw	a4,-1460(a5) # 8000da4c <memend+0xf800da4c>
    memset(kpgt,0,PGSIZE);
80001d0c:	8000e7b7          	lui	a5,0x8000e
80001d10:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d14:	00001637          	lui	a2,0x1
80001d18:	00000593          	li	a1,0
80001d1c:	00078513          	mv	a0,a5
80001d20:	025000ef          	jal	ra,80002544 <memset>

    // 映射 CLINT
    vmmap(kpgt,CLINT_BASE,CLINT_BASE,0xc000,PTE_R|PTE_W);
80001d24:	8000e7b7          	lui	a5,0x8000e
80001d28:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d2c:	00600713          	li	a4,6
80001d30:	0000c6b7          	lui	a3,0xc
80001d34:	02000637          	lui	a2,0x2000
80001d38:	020005b7          	lui	a1,0x2000
80001d3c:	00078513          	mv	a0,a5
80001d40:	d41ff0ef          	jal	ra,80001a80 <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
80001d44:	8000e7b7          	lui	a5,0x8000e
80001d48:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d4c:	00600713          	li	a4,6
80001d50:	004006b7          	lui	a3,0x400
80001d54:	0c000637          	lui	a2,0xc000
80001d58:	0c0005b7          	lui	a1,0xc000
80001d5c:	00078513          	mv	a0,a5
80001d60:	d21ff0ef          	jal	ra,80001a80 <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
80001d64:	8000e7b7          	lui	a5,0x8000e
80001d68:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d6c:	00600713          	li	a4,6
80001d70:	000016b7          	lui	a3,0x1
80001d74:	10000637          	lui	a2,0x10000
80001d78:	100005b7          	lui	a1,0x10000
80001d7c:	00078513          	mv	a0,a5
80001d80:	d01ff0ef          	jal	ra,80001a80 <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
80001d84:	8000e7b7          	lui	a5,0x8000e
80001d88:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d8c:	800007b7          	lui	a5,0x80000
80001d90:	00078593          	mv	a1,a5
80001d94:	800007b7          	lui	a5,0x80000
80001d98:	00078613          	mv	a2,a5
80001d9c:	800037b7          	lui	a5,0x80003
80001da0:	c7478713          	addi	a4,a5,-908 # 80002c74 <memend+0xf8002c74>
80001da4:	800007b7          	lui	a5,0x80000
80001da8:	00078793          	mv	a5,a5
80001dac:	40f707b3          	sub	a5,a4,a5
80001db0:	00a00713          	li	a4,10
80001db4:	00078693          	mv	a3,a5
80001db8:	cc9ff0ef          	jal	ra,80001a80 <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001dbc:	8000e7b7          	lui	a5,0x8000e
80001dc0:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001dc4:	800037b7          	lui	a5,0x80003
80001dc8:	00078593          	mv	a1,a5
80001dcc:	800037b7          	lui	a5,0x80003
80001dd0:	00078613          	mv	a2,a5
80001dd4:	8000b7b7          	lui	a5,0x8000b
80001dd8:	02478713          	addi	a4,a5,36 # 8000b024 <memend+0xf800b024>
80001ddc:	800037b7          	lui	a5,0x80003
80001de0:	00078793          	mv	a5,a5
80001de4:	40f707b3          	sub	a5,a4,a5
80001de8:	00600713          	li	a4,6
80001dec:	00078693          	mv	a3,a5
80001df0:	c91ff0ef          	jal	ra,80001a80 <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001df4:	8000e7b7          	lui	a5,0x8000e
80001df8:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001dfc:	8000c7b7          	lui	a5,0x8000c
80001e00:	00078593          	mv	a1,a5
80001e04:	8000c7b7          	lui	a5,0x8000c
80001e08:	00078613          	mv	a2,a5
80001e0c:	8000c7b7          	lui	a5,0x8000c
80001e10:	55a78713          	addi	a4,a5,1370 # 8000c55a <memend+0xf800c55a>
80001e14:	8000c7b7          	lui	a5,0x8000c
80001e18:	00078793          	mv	a5,a5
80001e1c:	40f707b3          	sub	a5,a4,a5
80001e20:	00200713          	li	a4,2
80001e24:	00078693          	mv	a3,a5
80001e28:	c59ff0ef          	jal	ra,80001a80 <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001e2c:	8000e7b7          	lui	a5,0x8000e
80001e30:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001e34:	8000d7b7          	lui	a5,0x8000d
80001e38:	00078593          	mv	a1,a5
80001e3c:	8000d7b7          	lui	a5,0x8000d
80001e40:	00078613          	mv	a2,a5
80001e44:	8000e7b7          	lui	a5,0x8000e
80001e48:	b9078713          	addi	a4,a5,-1136 # 8000db90 <memend+0xf800db90>
80001e4c:	8000d7b7          	lui	a5,0x8000d
80001e50:	00078793          	mv	a5,a5
80001e54:	40f707b3          	sub	a5,a4,a5
80001e58:	00600713          	li	a4,6
80001e5c:	00078693          	mv	a3,a5
80001e60:	c21ff0ef          	jal	ra,80001a80 <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001e64:	8000e7b7          	lui	a5,0x8000e
80001e68:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001e6c:	8000e7b7          	lui	a5,0x8000e
80001e70:	00078593          	mv	a1,a5
80001e74:	8000e7b7          	lui	a5,0x8000e
80001e78:	00078613          	mv	a2,a5
80001e7c:	880007b7          	lui	a5,0x88000
80001e80:	00078713          	mv	a4,a5
80001e84:	8000e7b7          	lui	a5,0x8000e
80001e88:	00078793          	mv	a5,a5
80001e8c:	40f707b3          	sub	a5,a4,a5
80001e90:	00600713          	li	a4,6
80001e94:	00078693          	mv	a3,a5
80001e98:	be9ff0ef          	jal	ra,80001a80 <vmmap>

    mkstack(kpgt);
80001e9c:	8000e7b7          	lui	a5,0x8000e
80001ea0:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001ea4:	00078513          	mv	a0,a5
80001ea8:	dbdff0ef          	jal	ra,80001c64 <mkstack>

    // 映射 usertrap
    vmmap(kpgt,USERVEC,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
80001eac:	8000e7b7          	lui	a5,0x8000e
80001eb0:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001eb4:	800007b7          	lui	a5,0x80000
80001eb8:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001ebc:	00a00713          	li	a4,10
80001ec0:	000016b7          	lui	a3,0x1
80001ec4:	00078613          	mv	a2,a5
80001ec8:	fffff5b7          	lui	a1,0xfffff
80001ecc:	bb5ff0ef          	jal	ra,80001a80 <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001ed0:	8000e7b7          	lui	a5,0x8000e
80001ed4:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001ed8:	00c7d713          	srli	a4,a5,0xc
80001edc:	800007b7          	lui	a5,0x80000
80001ee0:	00f767b3          	or	a5,a4,a5
80001ee4:	00078513          	mv	a0,a5
80001ee8:	a9dff0ef          	jal	ra,80001984 <w_satp>
    sfence_vma();       // 刷新页表
80001eec:	ac1ff0ef          	jal	ra,800019ac <sfence_vma>
}
80001ef0:	00000013          	nop
80001ef4:	00c12083          	lw	ra,12(sp)
80001ef8:	00812403          	lw	s0,8(sp)
80001efc:	01010113          	addi	sp,sp,16
80001f00:	00008067          	ret

80001f04 <pgtcreate>:

addr_t* pgtcreate(){
80001f04:	fe010113          	addi	sp,sp,-32
80001f08:	00112e23          	sw	ra,28(sp)
80001f0c:	00812c23          	sw	s0,24(sp)
80001f10:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001f14:	ffcff0ef          	jal	ra,80001710 <palloc>
80001f18:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001f1c:	fec42783          	lw	a5,-20(s0)
}
80001f20:	00078513          	mv	a0,a5
80001f24:	01c12083          	lw	ra,28(sp)
80001f28:	01812403          	lw	s0,24(sp)
80001f2c:	02010113          	addi	sp,sp,32
80001f30:	00008067          	ret

80001f34 <r_tp>:
static inline uint32 r_tp(){
80001f34:	fe010113          	addi	sp,sp,-32
80001f38:	00812e23          	sw	s0,28(sp)
80001f3c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001f40:	00020793          	mv	a5,tp
80001f44:	fef42623          	sw	a5,-20(s0)
    return x;
80001f48:	fec42783          	lw	a5,-20(s0)
}
80001f4c:	00078513          	mv	a0,a5
80001f50:	01c12403          	lw	s0,28(sp)
80001f54:	02010113          	addi	sp,sp,32
80001f58:	00008067          	ret

80001f5c <procinit>:
#include "riscv.h"
#include "syscall.h"

uint nextpid=0;

void procinit(){
80001f5c:	fe010113          	addi	sp,sp,-32
80001f60:	00812e23          	sw	s0,28(sp)
80001f64:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001f68:	fe042623          	sw	zero,-20(s0)
80001f6c:	0500006f          	j	80001fbc <procinit+0x60>
        p=&proc[i];
80001f70:	fec42703          	lw	a4,-20(s0)
80001f74:	00070793          	mv	a5,a4
80001f78:	00379793          	slli	a5,a5,0x3
80001f7c:	00e787b3          	add	a5,a5,a4
80001f80:	00479793          	slli	a5,a5,0x4
80001f84:	8000d737          	lui	a4,0x8000d
80001f88:	40870713          	addi	a4,a4,1032 # 8000d408 <memend+0xf800d408>
80001f8c:	00e787b3          	add	a5,a5,a4
80001f90:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
80001f94:	fec42783          	lw	a5,-20(s0)
80001f98:	00d79793          	slli	a5,a5,0xd
80001f9c:	00078713          	mv	a4,a5
80001fa0:	c00027b7          	lui	a5,0xc0002
80001fa4:	00f70733          	add	a4,a4,a5
80001fa8:	fe842783          	lw	a5,-24(s0)
80001fac:	08e7a623          	sw	a4,140(a5) # c000208c <memend+0x3800208c>
    for(int i=0;i<NPROC;i++){
80001fb0:	fec42783          	lw	a5,-20(s0)
80001fb4:	00178793          	addi	a5,a5,1
80001fb8:	fef42623          	sw	a5,-20(s0)
80001fbc:	fec42703          	lw	a4,-20(s0)
80001fc0:	00300793          	li	a5,3
80001fc4:	fae7d6e3          	bge	a5,a4,80001f70 <procinit+0x14>
    }
}
80001fc8:	00000013          	nop
80001fcc:	00000013          	nop
80001fd0:	01c12403          	lw	s0,28(sp)
80001fd4:	02010113          	addi	sp,sp,32
80001fd8:	00008067          	ret

80001fdc <nowproc>:

struct pcb* nowproc(){
80001fdc:	fe010113          	addi	sp,sp,-32
80001fe0:	00112e23          	sw	ra,28(sp)
80001fe4:	00812c23          	sw	s0,24(sp)
80001fe8:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80001fec:	f49ff0ef          	jal	ra,80001f34 <r_tp>
80001ff0:	00050793          	mv	a5,a0
80001ff4:	fef42623          	sw	a5,-20(s0)
    return cpus[hart].proc;
80001ff8:	8000d7b7          	lui	a5,0x8000d
80001ffc:	64878713          	addi	a4,a5,1608 # 8000d648 <memend+0xf800d648>
80002000:	fec42783          	lw	a5,-20(s0)
80002004:	00779793          	slli	a5,a5,0x7
80002008:	00f707b3          	add	a5,a4,a5
8000200c:	0007a783          	lw	a5,0(a5)
}
80002010:	00078513          	mv	a0,a5
80002014:	01c12083          	lw	ra,28(sp)
80002018:	01812403          	lw	s0,24(sp)
8000201c:	02010113          	addi	sp,sp,32
80002020:	00008067          	ret

80002024 <nowcpu>:

struct cpu* nowcpu(){
80002024:	fe010113          	addi	sp,sp,-32
80002028:	00112e23          	sw	ra,28(sp)
8000202c:	00812c23          	sw	s0,24(sp)
80002030:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80002034:	f01ff0ef          	jal	ra,80001f34 <r_tp>
80002038:	00050793          	mv	a5,a0
8000203c:	fef42623          	sw	a5,-20(s0)
    return &cpus[hart];
80002040:	fec42783          	lw	a5,-20(s0)
80002044:	00779713          	slli	a4,a5,0x7
80002048:	8000d7b7          	lui	a5,0x8000d
8000204c:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
80002050:	00f707b3          	add	a5,a4,a5
}
80002054:	00078513          	mv	a0,a5
80002058:	01c12083          	lw	ra,28(sp)
8000205c:	01812403          	lw	s0,24(sp)
80002060:	02010113          	addi	sp,sp,32
80002064:	00008067          	ret

80002068 <pidalloc>:

uint pidalloc(){
80002068:	ff010113          	addi	sp,sp,-16
8000206c:	00812623          	sw	s0,12(sp)
80002070:	01010413          	addi	s0,sp,16
    return nextpid++;
80002074:	8000d7b7          	lui	a5,0x8000d
80002078:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
8000207c:	00178693          	addi	a3,a5,1
80002080:	8000d737          	lui	a4,0x8000d
80002084:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
} 
80002088:	00078513          	mv	a0,a5
8000208c:	00c12403          	lw	s0,12(sp)
80002090:	01010113          	addi	sp,sp,16
80002094:	00008067          	ret

80002098 <procalloc>:

struct pcb* procalloc(){
80002098:	fe010113          	addi	sp,sp,-32
8000209c:	00112e23          	sw	ra,28(sp)
800020a0:	00812c23          	sw	s0,24(sp)
800020a4:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
800020a8:	8000d7b7          	lui	a5,0x8000d
800020ac:	40878793          	addi	a5,a5,1032 # 8000d408 <memend+0xf800d408>
800020b0:	fef42623          	sw	a5,-20(s0)
800020b4:	0680006f          	j	8000211c <procalloc+0x84>
        if(p->status==UNUSED){
800020b8:	fec42783          	lw	a5,-20(s0)
800020bc:	0047a783          	lw	a5,4(a5)
800020c0:	04079863          	bnez	a5,80002110 <procalloc+0x78>
            p->trapframe=(struct trapframe*)palloc(sizeof(struct trapframe));
800020c4:	08c00513          	li	a0,140
800020c8:	e48ff0ef          	jal	ra,80001710 <palloc>
800020cc:	00050713          	mv	a4,a0
800020d0:	fec42783          	lw	a5,-20(s0)
800020d4:	00e7a423          	sw	a4,8(a5)
            
            p->pid=pidalloc();
800020d8:	f91ff0ef          	jal	ra,80002068 <pidalloc>
800020dc:	00050793          	mv	a5,a0
800020e0:	00078713          	mv	a4,a5
800020e4:	fec42783          	lw	a5,-20(s0)
800020e8:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
800020ec:	fec42783          	lw	a5,-20(s0)
800020f0:	00100713          	li	a4,1
800020f4:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
800020f8:	e0dff0ef          	jal	ra,80001f04 <pgtcreate>
800020fc:	00050713          	mv	a4,a0
80002100:	fec42783          	lw	a5,-20(s0)
80002104:	08e7a423          	sw	a4,136(a5)
            
            return p;
80002108:	fec42783          	lw	a5,-20(s0)
8000210c:	0240006f          	j	80002130 <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
80002110:	fec42783          	lw	a5,-20(s0)
80002114:	09078793          	addi	a5,a5,144
80002118:	fef42623          	sw	a5,-20(s0)
8000211c:	fec42703          	lw	a4,-20(s0)
80002120:	8000d7b7          	lui	a5,0x8000d
80002124:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
80002128:	f8f768e3          	bltu	a4,a5,800020b8 <procalloc+0x20>
        }
    }
    return 0;
8000212c:	00000793          	li	a5,0
}
80002130:	00078513          	mv	a0,a5
80002134:	01c12083          	lw	ra,28(sp)
80002138:	01812403          	lw	s0,24(sp)
8000213c:	02010113          	addi	sp,sp,32
80002140:	00008067          	ret

80002144 <userinit>:
  0x73,0x00,0x00,0x00,
  0x6f,0x00,0x00,0x00
  };

// 初始化第一个进程
void userinit(){
80002144:	fe010113          	addi	sp,sp,-32
80002148:	00112e23          	sw	ra,28(sp)
8000214c:	00812c23          	sw	s0,24(sp)
80002150:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80002154:	f45ff0ef          	jal	ra,80002098 <procalloc>
80002158:	fea42623          	sw	a0,-20(s0)
    
    p->trapframe->epc=0;
8000215c:	fec42783          	lw	a5,-20(s0)
80002160:	0087a783          	lw	a5,8(a5)
80002164:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp=PGSIZE;
80002168:	fec42783          	lw	a5,-20(s0)
8000216c:	0087a783          	lw	a5,8(a5)
80002170:	00001737          	lui	a4,0x1
80002174:	00e7aa23          	sw	a4,20(a5)
    
    char* m=(char*)palloc();
80002178:	d98ff0ef          	jal	ra,80001710 <palloc>
8000217c:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80002180:	00c00613          	li	a2,12
80002184:	00000693          	li	a3,0
80002188:	8000b7b7          	lui	a5,0x8000b
8000218c:	00078593          	mv	a1,a5
80002190:	fe842503          	lw	a0,-24(s0)
80002194:	41c000ef          	jal	ra,800025b0 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X|PTE_U);
80002198:	fec42783          	lw	a5,-20(s0)
8000219c:	0887a783          	lw	a5,136(a5) # 8000b088 <memend+0xf800b088>
800021a0:	fe842603          	lw	a2,-24(s0)
800021a4:	01e00713          	li	a4,30
800021a8:	000016b7          	lui	a3,0x1
800021ac:	00000593          	li	a1,0
800021b0:	00078513          	mv	a0,a5
800021b4:	8cdff0ef          	jal	ra,80001a80 <vmmap>
    vmmap(p->pagetable,(uint32)usertrap,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
800021b8:	fec42783          	lw	a5,-20(s0)
800021bc:	0887a503          	lw	a0,136(a5)
800021c0:	800007b7          	lui	a5,0x80000
800021c4:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
800021c8:	800007b7          	lui	a5,0x80000
800021cc:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
800021d0:	00a00713          	li	a4,10
800021d4:	000016b7          	lui	a3,0x1
800021d8:	00078613          	mv	a2,a5
800021dc:	8a5ff0ef          	jal	ra,80001a80 <vmmap>

    vmmap(p->pagetable,(addr_t)TRAPFRAME,(addr_t)p->trapframe,PGSIZE,PTE_R|PTE_W);
800021e0:	fec42783          	lw	a5,-20(s0)
800021e4:	0887a503          	lw	a0,136(a5)
800021e8:	fec42783          	lw	a5,-20(s0)
800021ec:	0087a783          	lw	a5,8(a5)
800021f0:	00600713          	li	a4,6
800021f4:	000016b7          	lui	a3,0x1
800021f8:	00078613          	mv	a2,a5
800021fc:	ffffe5b7          	lui	a1,0xffffe
80002200:	881ff0ef          	jal	ra,80001a80 <vmmap>

    p->pagetable=(addr_t*)p->pagetable;
80002204:	fec42783          	lw	a5,-20(s0)
80002208:	0887a703          	lw	a4,136(a5)
8000220c:	fec42783          	lw	a5,-20(s0)
80002210:	08e7a423          	sw	a4,136(a5)

    p->status=RUNABLE;
80002214:	fec42783          	lw	a5,-20(s0)
80002218:	00200713          	li	a4,2
8000221c:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
80002220:	fec42783          	lw	a5,-20(s0)
80002224:	0887a783          	lw	a5,136(a5)
80002228:	00078513          	mv	a0,a5
8000222c:	a39ff0ef          	jal	ra,80001c64 <mkstack>
    
    p->context.ra=(reg_t)usertrapret;
80002230:	800017b7          	lui	a5,0x80001
80002234:	de878713          	addi	a4,a5,-536 # 80000de8 <memend+0xf8000de8>
80002238:	fec42783          	lw	a5,-20(s0)
8000223c:	00e7a623          	sw	a4,12(a5)
    p->context.sp=p->kernelstack;
80002240:	fec42783          	lw	a5,-20(s0)
80002244:	08c7a703          	lw	a4,140(a5)
80002248:	fec42783          	lw	a5,-20(s0)
8000224c:	00e7a823          	sw	a4,16(a5)


    p=procalloc();
80002250:	e49ff0ef          	jal	ra,80002098 <procalloc>
80002254:	fea42623          	sw	a0,-20(s0)
    p->context.ra=(reg_t)usertrapret;
80002258:	800017b7          	lui	a5,0x80001
8000225c:	de878713          	addi	a4,a5,-536 # 80000de8 <memend+0xf8000de8>
80002260:	fec42783          	lw	a5,-20(s0)
80002264:	00e7a623          	sw	a4,12(a5)
    p->context.sp=p->kernelstack;
80002268:	fec42783          	lw	a5,-20(s0)
8000226c:	08c7a703          	lw	a4,140(a5)
80002270:	fec42783          	lw	a5,-20(s0)
80002274:	00e7a823          	sw	a4,16(a5)

    p->trapframe->epc=0;
80002278:	fec42783          	lw	a5,-20(s0)
8000227c:	0087a783          	lw	a5,8(a5)
80002280:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp=PGSIZE;
80002284:	fec42783          	lw	a5,-20(s0)
80002288:	0087a783          	lw	a5,8(a5)
8000228c:	00001737          	lui	a4,0x1
80002290:	00e7aa23          	sw	a4,20(a5)
    
    m=(char*)palloc();
80002294:	c7cff0ef          	jal	ra,80001710 <palloc>
80002298:	fea42423          	sw	a0,-24(s0)
    memmove(m,firstproc,sizeof(zeroproc));
8000229c:	00c00613          	li	a2,12
800022a0:	00000693          	li	a3,0
800022a4:	8000b7b7          	lui	a5,0x8000b
800022a8:	00c78593          	addi	a1,a5,12 # 8000b00c <memend+0xf800b00c>
800022ac:	fe842503          	lw	a0,-24(s0)
800022b0:	300000ef          	jal	ra,800025b0 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X|PTE_U);
800022b4:	fec42783          	lw	a5,-20(s0)
800022b8:	0887a783          	lw	a5,136(a5)
800022bc:	fe842603          	lw	a2,-24(s0)
800022c0:	01e00713          	li	a4,30
800022c4:	000016b7          	lui	a3,0x1
800022c8:	00000593          	li	a1,0
800022cc:	00078513          	mv	a0,a5
800022d0:	fb0ff0ef          	jal	ra,80001a80 <vmmap>
    vmmap(p->pagetable,(uint32)usertrap,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);
800022d4:	fec42783          	lw	a5,-20(s0)
800022d8:	0887a503          	lw	a0,136(a5)
800022dc:	800007b7          	lui	a5,0x80000
800022e0:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
800022e4:	800007b7          	lui	a5,0x80000
800022e8:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
800022ec:	00a00713          	li	a4,10
800022f0:	000016b7          	lui	a3,0x1
800022f4:	00078613          	mv	a2,a5
800022f8:	f88ff0ef          	jal	ra,80001a80 <vmmap>

    vmmap(p->pagetable,(addr_t)TRAPFRAME,(addr_t)p->trapframe,PGSIZE,PTE_R|PTE_W);
800022fc:	fec42783          	lw	a5,-20(s0)
80002300:	0887a503          	lw	a0,136(a5)
80002304:	fec42783          	lw	a5,-20(s0)
80002308:	0087a783          	lw	a5,8(a5)
8000230c:	00600713          	li	a4,6
80002310:	000016b7          	lui	a3,0x1
80002314:	00078613          	mv	a2,a5
80002318:	ffffe5b7          	lui	a1,0xffffe
8000231c:	f64ff0ef          	jal	ra,80001a80 <vmmap>

    p->pagetable=(addr_t*)p->pagetable;
80002320:	fec42783          	lw	a5,-20(s0)
80002324:	0887a703          	lw	a4,136(a5)
80002328:	fec42783          	lw	a5,-20(s0)
8000232c:	08e7a423          	sw	a4,136(a5)

    p->status=RUNABLE;
80002330:	fec42783          	lw	a5,-20(s0)
80002334:	00200713          	li	a4,2
80002338:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
8000233c:	fec42783          	lw	a5,-20(s0)
80002340:	0887a783          	lw	a5,136(a5)
80002344:	00078513          	mv	a0,a5
80002348:	91dff0ef          	jal	ra,80001c64 <mkstack>

    p->context.ra=(reg_t)usertrapret;
8000234c:	800017b7          	lui	a5,0x80001
80002350:	de878713          	addi	a4,a5,-536 # 80000de8 <memend+0xf8000de8>
80002354:	fec42783          	lw	a5,-20(s0)
80002358:	00e7a623          	sw	a4,12(a5)
    p->context.sp=p->kernelstack;
8000235c:	fec42783          	lw	a5,-20(s0)
80002360:	08c7a703          	lw	a4,140(a5)
80002364:	fec42783          	lw	a5,-20(s0)
80002368:	00e7a823          	sw	a4,16(a5)
}
8000236c:	00000013          	nop
80002370:	01c12083          	lw	ra,28(sp)
80002374:	01812403          	lw	s0,24(sp)
80002378:	02010113          	addi	sp,sp,32
8000237c:	00008067          	ret

80002380 <schedule>:

void schedule(){
80002380:	fe010113          	addi	sp,sp,-32
80002384:	00112e23          	sw	ra,28(sp)
80002388:	00812c23          	sw	s0,24(sp)
8000238c:	02010413          	addi	s0,sp,32
    struct cpu* c=nowcpu();
80002390:	c95ff0ef          	jal	ra,80002024 <nowcpu>
80002394:	fea42423          	sw	a0,-24(s0)
    struct pcb* p;

    for( ; ; ){
        for(p = proc; p < &proc[NPROC]; p++){
80002398:	8000d7b7          	lui	a5,0x8000d
8000239c:	40878793          	addi	a5,a5,1032 # 8000d408 <memend+0xf800d408>
800023a0:	fef42623          	sw	a5,-20(s0)
800023a4:	05c0006f          	j	80002400 <schedule+0x80>
            if(p->status == RUNABLE){
800023a8:	fec42783          	lw	a5,-20(s0)
800023ac:	0047a703          	lw	a4,4(a5)
800023b0:	00200793          	li	a5,2
800023b4:	04f71063          	bne	a4,a5,800023f4 <schedule+0x74>
                p->status = RUNNING;
800023b8:	fec42783          	lw	a5,-20(s0)
800023bc:	00300713          	li	a4,3
800023c0:	00e7a223          	sw	a4,4(a5)
                c->proc = p;
800023c4:	fe842783          	lw	a5,-24(s0)
800023c8:	fec42703          	lw	a4,-20(s0)
800023cc:	00e7a023          	sw	a4,0(a5)
                // 保存当前的上下文到cpu->context中
                swtch(&c->context,&p->context);
800023d0:	fe842783          	lw	a5,-24(s0)
800023d4:	00478713          	addi	a4,a5,4
800023d8:	fec42783          	lw	a5,-20(s0)
800023dc:	00c78793          	addi	a5,a5,12
800023e0:	00078593          	mv	a1,a5
800023e4:	00070513          	mv	a0,a4
800023e8:	db5fd0ef          	jal	ra,8000019c <swtch>
                // swtch ret后跳转到p->context.ra
                
                c->proc=0;  // cpu->context.ra 指向这里
800023ec:	fe842783          	lw	a5,-24(s0)
800023f0:	0007a023          	sw	zero,0(a5)
        for(p = proc; p < &proc[NPROC]; p++){
800023f4:	fec42783          	lw	a5,-20(s0)
800023f8:	09078793          	addi	a5,a5,144
800023fc:	fef42623          	sw	a5,-20(s0)
80002400:	fec42703          	lw	a4,-20(s0)
80002404:	8000d7b7          	lui	a5,0x8000d
80002408:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
8000240c:	f8f76ee3          	bltu	a4,a5,800023a8 <schedule+0x28>
80002410:	f89ff06f          	j	80002398 <schedule+0x18>

80002414 <yield>:
}

/**
 * @description: 进程放弃 CPU
 */
void yield(){
80002414:	fe010113          	addi	sp,sp,-32
80002418:	00112e23          	sw	ra,28(sp)
8000241c:	00812c23          	sw	s0,24(sp)
80002420:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80002424:	bb9ff0ef          	jal	ra,80001fdc <nowproc>
80002428:	fea42623          	sw	a0,-20(s0)
    if(p->status!=RUNNING){
8000242c:	fec42783          	lw	a5,-20(s0)
80002430:	0047a703          	lw	a4,4(a5)
80002434:	00300793          	li	a5,3
80002438:	00f70863          	beq	a4,a5,80002448 <yield+0x34>
        panic("proc status error");
8000243c:	8000c7b7          	lui	a5,0x8000c
80002440:	51878513          	addi	a0,a5,1304 # 8000c518 <memend+0xf800c518>
80002444:	d29fe0ef          	jal	ra,8000116c <panic>
    }
    p->status=RUNABLE;
80002448:	fec42783          	lw	a5,-20(s0)
8000244c:	00200713          	li	a4,2
80002450:	00e7a223          	sw	a4,4(a5)
    sched();
80002454:	018000ef          	jal	ra,8000246c <sched>
}
80002458:	00000013          	nop
8000245c:	01c12083          	lw	ra,28(sp)
80002460:	01812403          	lw	s0,24(sp)
80002464:	02010113          	addi	sp,sp,32
80002468:	00008067          	ret

8000246c <sched>:

/**
 * @description: 
 */
void sched(){
8000246c:	fe010113          	addi	sp,sp,-32
80002470:	00112e23          	sw	ra,28(sp)
80002474:	00812c23          	sw	s0,24(sp)
80002478:	00912a23          	sw	s1,20(sp)
8000247c:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80002480:	b5dff0ef          	jal	ra,80001fdc <nowproc>
80002484:	fea42623          	sw	a0,-20(s0)
    if(p->status==RUNNING){
80002488:	fec42783          	lw	a5,-20(s0)
8000248c:	0047a703          	lw	a4,4(a5)
80002490:	00300793          	li	a5,3
80002494:	00f71863          	bne	a4,a5,800024a4 <sched+0x38>
        panic("proc is running");
80002498:	8000c7b7          	lui	a5,0x8000c
8000249c:	52c78513          	addi	a0,a5,1324 # 8000c52c <memend+0xf800c52c>
800024a0:	ccdfe0ef          	jal	ra,8000116c <panic>
    }
    swtch(&p->context,&nowcpu()->context); //跳转到cpu->context.ra ( schedule() )
800024a4:	fec42783          	lw	a5,-20(s0)
800024a8:	00c78493          	addi	s1,a5,12
800024ac:	b79ff0ef          	jal	ra,80002024 <nowcpu>
800024b0:	00050793          	mv	a5,a0
800024b4:	00478793          	addi	a5,a5,4
800024b8:	00078593          	mv	a1,a5
800024bc:	00048513          	mv	a0,s1
800024c0:	cddfd0ef          	jal	ra,8000019c <swtch>
}
800024c4:	00000013          	nop
800024c8:	01c12083          	lw	ra,28(sp)
800024cc:	01812403          	lw	s0,24(sp)
800024d0:	01412483          	lw	s1,20(sp)
800024d4:	02010113          	addi	sp,sp,32
800024d8:	00008067          	ret

800024dc <sys_fork>:

uint32 sys_fork(void){
800024dc:	ff010113          	addi	sp,sp,-16
800024e0:	00112623          	sw	ra,12(sp)
800024e4:	00812423          	sw	s0,8(sp)
800024e8:	01010413          	addi	s0,sp,16
    printf("syscall fork\n");
800024ec:	8000c7b7          	lui	a5,0x8000c
800024f0:	53c78513          	addi	a0,a5,1340 # 8000c53c <memend+0xf800c53c>
800024f4:	cb1fe0ef          	jal	ra,800011a4 <printf>
    return SYS_fork;
800024f8:	00100793          	li	a5,1
}
800024fc:	00078513          	mv	a0,a5
80002500:	00c12083          	lw	ra,12(sp)
80002504:	00812403          	lw	s0,8(sp)
80002508:	01010113          	addi	sp,sp,16
8000250c:	00008067          	ret

80002510 <sys_exec>:

uint32 sys_exec(void){
80002510:	ff010113          	addi	sp,sp,-16
80002514:	00112623          	sw	ra,12(sp)
80002518:	00812423          	sw	s0,8(sp)
8000251c:	01010413          	addi	s0,sp,16
    printf("syscall exec\n");
80002520:	8000c7b7          	lui	a5,0x8000c
80002524:	54c78513          	addi	a0,a5,1356 # 8000c54c <memend+0xf800c54c>
80002528:	c7dfe0ef          	jal	ra,800011a4 <printf>
    return SYS_exec;
8000252c:	00200793          	li	a5,2
80002530:	00078513          	mv	a0,a5
80002534:	00c12083          	lw	ra,12(sp)
80002538:	00812403          	lw	s0,8(sp)
8000253c:	01010113          	addi	sp,sp,16
80002540:	00008067          	ret

80002544 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80002544:	fd010113          	addi	sp,sp,-48
80002548:	02812623          	sw	s0,44(sp)
8000254c:	03010413          	addi	s0,sp,48
80002550:	fca42e23          	sw	a0,-36(s0)
80002554:	fcb42c23          	sw	a1,-40(s0)
80002558:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
8000255c:	fdc42783          	lw	a5,-36(s0)
80002560:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80002564:	fe042623          	sw	zero,-20(s0)
80002568:	0280006f          	j	80002590 <memset+0x4c>
        maddr[i] = (char)c;
8000256c:	fe842703          	lw	a4,-24(s0)
80002570:	fec42783          	lw	a5,-20(s0)
80002574:	00f707b3          	add	a5,a4,a5
80002578:	fd842703          	lw	a4,-40(s0)
8000257c:	0ff77713          	andi	a4,a4,255
80002580:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80002584:	fec42783          	lw	a5,-20(s0)
80002588:	00178793          	addi	a5,a5,1
8000258c:	fef42623          	sw	a5,-20(s0)
80002590:	fec42703          	lw	a4,-20(s0)
80002594:	fd442783          	lw	a5,-44(s0)
80002598:	fcf76ae3          	bltu	a4,a5,8000256c <memset+0x28>
    }
    return addr;
8000259c:	fdc42783          	lw	a5,-36(s0)
}
800025a0:	00078513          	mv	a0,a5
800025a4:	02c12403          	lw	s0,44(sp)
800025a8:	03010113          	addi	sp,sp,48
800025ac:	00008067          	ret

800025b0 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
800025b0:	fd010113          	addi	sp,sp,-48
800025b4:	02812623          	sw	s0,44(sp)
800025b8:	03010413          	addi	s0,sp,48
800025bc:	fca42e23          	sw	a0,-36(s0)
800025c0:	fcb42c23          	sw	a1,-40(s0)
800025c4:	fcc42823          	sw	a2,-48(s0)
800025c8:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
800025cc:	fd042783          	lw	a5,-48(s0)
800025d0:	fd442703          	lw	a4,-44(s0)
800025d4:	00e7e7b3          	or	a5,a5,a4
800025d8:	00079663          	bnez	a5,800025e4 <memmove+0x34>
        return dst;
800025dc:	fdc42783          	lw	a5,-36(s0)
800025e0:	1200006f          	j	80002700 <memmove+0x150>
    }

    s = src;
800025e4:	fd842783          	lw	a5,-40(s0)
800025e8:	fef42623          	sw	a5,-20(s0)
    d = dst;
800025ec:	fdc42783          	lw	a5,-36(s0)
800025f0:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
800025f4:	fec42703          	lw	a4,-20(s0)
800025f8:	fe842783          	lw	a5,-24(s0)
800025fc:	0cf77263          	bgeu	a4,a5,800026c0 <memmove+0x110>
80002600:	fd042783          	lw	a5,-48(s0)
80002604:	fec42703          	lw	a4,-20(s0)
80002608:	00f707b3          	add	a5,a4,a5
8000260c:	fe842703          	lw	a4,-24(s0)
80002610:	0af77863          	bgeu	a4,a5,800026c0 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80002614:	fd042783          	lw	a5,-48(s0)
80002618:	fec42703          	lw	a4,-20(s0)
8000261c:	00f707b3          	add	a5,a4,a5
80002620:	fef42623          	sw	a5,-20(s0)
        d += n;
80002624:	fd042783          	lw	a5,-48(s0)
80002628:	fe842703          	lw	a4,-24(s0)
8000262c:	00f707b3          	add	a5,a4,a5
80002630:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80002634:	02c0006f          	j	80002660 <memmove+0xb0>
            *--d = *--s;
80002638:	fec42783          	lw	a5,-20(s0)
8000263c:	fff78793          	addi	a5,a5,-1
80002640:	fef42623          	sw	a5,-20(s0)
80002644:	fe842783          	lw	a5,-24(s0)
80002648:	fff78793          	addi	a5,a5,-1
8000264c:	fef42423          	sw	a5,-24(s0)
80002650:	fec42783          	lw	a5,-20(s0)
80002654:	0007c703          	lbu	a4,0(a5)
80002658:	fe842783          	lw	a5,-24(s0)
8000265c:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80002660:	fd042703          	lw	a4,-48(s0)
80002664:	fd442783          	lw	a5,-44(s0)
80002668:	fff00513          	li	a0,-1
8000266c:	fff00593          	li	a1,-1
80002670:	00a70633          	add	a2,a4,a0
80002674:	00060813          	mv	a6,a2
80002678:	00e83833          	sltu	a6,a6,a4
8000267c:	00b786b3          	add	a3,a5,a1
80002680:	00d805b3          	add	a1,a6,a3
80002684:	00058693          	mv	a3,a1
80002688:	fcc42823          	sw	a2,-48(s0)
8000268c:	fcd42a23          	sw	a3,-44(s0)
80002690:	00070693          	mv	a3,a4
80002694:	00f6e6b3          	or	a3,a3,a5
80002698:	fa0690e3          	bnez	a3,80002638 <memmove+0x88>
    if(s < d && s + n > d){     
8000269c:	0600006f          	j	800026fc <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
800026a0:	fec42703          	lw	a4,-20(s0)
800026a4:	00170793          	addi	a5,a4,1 # 1001 <sz+0x1>
800026a8:	fef42623          	sw	a5,-20(s0)
800026ac:	fe842783          	lw	a5,-24(s0)
800026b0:	00178693          	addi	a3,a5,1
800026b4:	fed42423          	sw	a3,-24(s0)
800026b8:	00074703          	lbu	a4,0(a4)
800026bc:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
800026c0:	fd042703          	lw	a4,-48(s0)
800026c4:	fd442783          	lw	a5,-44(s0)
800026c8:	fff00513          	li	a0,-1
800026cc:	fff00593          	li	a1,-1
800026d0:	00a70633          	add	a2,a4,a0
800026d4:	00060813          	mv	a6,a2
800026d8:	00e83833          	sltu	a6,a6,a4
800026dc:	00b786b3          	add	a3,a5,a1
800026e0:	00d805b3          	add	a1,a6,a3
800026e4:	00058693          	mv	a3,a1
800026e8:	fcc42823          	sw	a2,-48(s0)
800026ec:	fcd42a23          	sw	a3,-44(s0)
800026f0:	00070693          	mv	a3,a4
800026f4:	00f6e6b3          	or	a3,a3,a5
800026f8:	fa0694e3          	bnez	a3,800026a0 <memmove+0xf0>
        }
    }
    return dst;
800026fc:	fdc42783          	lw	a5,-36(s0)
}
80002700:	00078513          	mv	a0,a5
80002704:	02c12403          	lw	s0,44(sp)
80002708:	03010113          	addi	sp,sp,48
8000270c:	00008067          	ret

80002710 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80002710:	fd010113          	addi	sp,sp,-48
80002714:	02812623          	sw	s0,44(sp)
80002718:	03010413          	addi	s0,sp,48
8000271c:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80002720:	00000793          	li	a5,0
80002724:	00000813          	li	a6,0
80002728:	fef42423          	sw	a5,-24(s0)
8000272c:	ff042623          	sw	a6,-20(s0)
80002730:	0340006f          	j	80002764 <strlen+0x54>
80002734:	fe842603          	lw	a2,-24(s0)
80002738:	fec42683          	lw	a3,-20(s0)
8000273c:	00100513          	li	a0,1
80002740:	00000593          	li	a1,0
80002744:	00a60733          	add	a4,a2,a0
80002748:	00070813          	mv	a6,a4
8000274c:	00c83833          	sltu	a6,a6,a2
80002750:	00b687b3          	add	a5,a3,a1
80002754:	00f806b3          	add	a3,a6,a5
80002758:	00068793          	mv	a5,a3
8000275c:	fee42423          	sw	a4,-24(s0)
80002760:	fef42623          	sw	a5,-20(s0)
80002764:	fe842783          	lw	a5,-24(s0)
80002768:	fdc42703          	lw	a4,-36(s0)
8000276c:	00f707b3          	add	a5,a4,a5
80002770:	0007c783          	lbu	a5,0(a5)
80002774:	fc0790e3          	bnez	a5,80002734 <strlen+0x24>
    
    return n;
80002778:	fe842703          	lw	a4,-24(s0)
8000277c:	fec42783          	lw	a5,-20(s0)
80002780:	00070513          	mv	a0,a4
80002784:	00078593          	mv	a1,a5
80002788:	02c12403          	lw	s0,44(sp)
8000278c:	03010113          	addi	sp,sp,48
80002790:	00008067          	ret

80002794 <r_tp>:
static inline uint32 r_tp(){
80002794:	fe010113          	addi	sp,sp,-32
80002798:	00812e23          	sw	s0,28(sp)
8000279c:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800027a0:	00020793          	mv	a5,tp
800027a4:	fef42623          	sw	a5,-20(s0)
    return x;
800027a8:	fec42783          	lw	a5,-20(s0)
}
800027ac:	00078513          	mv	a0,a5
800027b0:	01c12403          	lw	s0,28(sp)
800027b4:	02010113          	addi	sp,sp,32
800027b8:	00008067          	ret

800027bc <clintinit>:
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit(){
800027bc:	fe010113          	addi	sp,sp,-32
800027c0:	00112e23          	sw	ra,28(sp)
800027c4:	00812c23          	sw	s0,24(sp)
800027c8:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp 
    int hart=r_tp();
800027cc:	fc9ff0ef          	jal	ra,80002794 <r_tp>
800027d0:	00050793          	mv	a5,a0
800027d4:	fef42623          	sw	a5,-20(s0)
    *(reg_t*)CLINT_MTIMECMP(hart)=*(reg_t*)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
800027d8:	fec42703          	lw	a4,-20(s0)
800027dc:	004017b7          	lui	a5,0x401
800027e0:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800027e4:	00f707b3          	add	a5,a4,a5
800027e8:	00379793          	slli	a5,a5,0x3
800027ec:	0007a703          	lw	a4,0(a5)
800027f0:	fec42683          	lw	a3,-20(s0)
800027f4:	004017b7          	lui	a5,0x401
800027f8:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800027fc:	00f687b3          	add	a5,a3,a5
80002800:	00379793          	slli	a5,a5,0x3
80002804:	00078693          	mv	a3,a5
80002808:	009897b7          	lui	a5,0x989
8000280c:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80002810:	00f707b3          	add	a5,a4,a5
80002814:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
80002818:	00000013          	nop
8000281c:	01c12083          	lw	ra,28(sp)
80002820:	01812403          	lw	s0,24(sp)
80002824:	02010113          	addi	sp,sp,32
80002828:	00008067          	ret

8000282c <r_mstatus>:
static inline uint32 r_mstatus(){
8000282c:	fe010113          	addi	sp,sp,-32
80002830:	00812e23          	sw	s0,28(sp)
80002834:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80002838:	300027f3          	csrr	a5,mstatus
8000283c:	fef42623          	sw	a5,-20(s0)
    return x;
80002840:	fec42783          	lw	a5,-20(s0)
}
80002844:	00078513          	mv	a0,a5
80002848:	01c12403          	lw	s0,28(sp)
8000284c:	02010113          	addi	sp,sp,32
80002850:	00008067          	ret

80002854 <w_mstatus>:
static inline void w_mstatus(uint32 x){
80002854:	fe010113          	addi	sp,sp,-32
80002858:	00812e23          	sw	s0,28(sp)
8000285c:	02010413          	addi	s0,sp,32
80002860:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80002864:	fec42783          	lw	a5,-20(s0)
80002868:	30079073          	csrw	mstatus,a5
}
8000286c:	00000013          	nop
80002870:	01c12403          	lw	s0,28(sp)
80002874:	02010113          	addi	sp,sp,32
80002878:	00008067          	ret

8000287c <w_mtvec>:
static inline void w_mtvec(uint32 x){
8000287c:	fe010113          	addi	sp,sp,-32
80002880:	00812e23          	sw	s0,28(sp)
80002884:	02010413          	addi	s0,sp,32
80002888:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0" : : "r"(x));
8000288c:	fec42783          	lw	a5,-20(s0)
80002890:	30579073          	csrw	mtvec,a5
}
80002894:	00000013          	nop
80002898:	01c12403          	lw	s0,28(sp)
8000289c:	02010113          	addi	sp,sp,32
800028a0:	00008067          	ret

800028a4 <r_tp>:
static inline uint32 r_tp(){
800028a4:	fe010113          	addi	sp,sp,-32
800028a8:	00812e23          	sw	s0,28(sp)
800028ac:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800028b0:	00020793          	mv	a5,tp
800028b4:	fef42623          	sw	a5,-20(s0)
    return x;
800028b8:	fec42783          	lw	a5,-20(s0)
}
800028bc:	00078513          	mv	a0,a5
800028c0:	01c12403          	lw	s0,28(sp)
800028c4:	02010113          	addi	sp,sp,32
800028c8:	00008067          	ret

800028cc <s_mstatus_intr>:
static inline void s_mstatus_intr(uint32 m){
800028cc:	fd010113          	addi	sp,sp,-48
800028d0:	02112623          	sw	ra,44(sp)
800028d4:	02812423          	sw	s0,40(sp)
800028d8:	03010413          	addi	s0,sp,48
800028dc:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
800028e0:	f4dff0ef          	jal	ra,8000282c <r_mstatus>
800028e4:	fea42623          	sw	a0,-20(s0)
    switch (m)
800028e8:	fdc42703          	lw	a4,-36(s0)
800028ec:	08000793          	li	a5,128
800028f0:	04f70263          	beq	a4,a5,80002934 <s_mstatus_intr+0x68>
800028f4:	fdc42703          	lw	a4,-36(s0)
800028f8:	08000793          	li	a5,128
800028fc:	0ae7e463          	bltu	a5,a4,800029a4 <s_mstatus_intr+0xd8>
80002900:	fdc42703          	lw	a4,-36(s0)
80002904:	02000793          	li	a5,32
80002908:	04f70463          	beq	a4,a5,80002950 <s_mstatus_intr+0x84>
8000290c:	fdc42703          	lw	a4,-36(s0)
80002910:	02000793          	li	a5,32
80002914:	08e7e863          	bltu	a5,a4,800029a4 <s_mstatus_intr+0xd8>
80002918:	fdc42703          	lw	a4,-36(s0)
8000291c:	00200793          	li	a5,2
80002920:	06f70463          	beq	a4,a5,80002988 <s_mstatus_intr+0xbc>
80002924:	fdc42703          	lw	a4,-36(s0)
80002928:	00800793          	li	a5,8
8000292c:	04f70063          	beq	a4,a5,8000296c <s_mstatus_intr+0xa0>
        break;
80002930:	0740006f          	j	800029a4 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
80002934:	fec42783          	lw	a5,-20(s0)
80002938:	f7f7f793          	andi	a5,a5,-129
8000293c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
80002940:	fec42783          	lw	a5,-20(s0)
80002944:	0807e793          	ori	a5,a5,128
80002948:	fef42623          	sw	a5,-20(s0)
        break;
8000294c:	05c0006f          	j	800029a8 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
80002950:	fec42783          	lw	a5,-20(s0)
80002954:	fdf7f793          	andi	a5,a5,-33
80002958:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
8000295c:	fec42783          	lw	a5,-20(s0)
80002960:	0207e793          	ori	a5,a5,32
80002964:	fef42623          	sw	a5,-20(s0)
        break;
80002968:	0400006f          	j	800029a8 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
8000296c:	fec42783          	lw	a5,-20(s0)
80002970:	ff77f793          	andi	a5,a5,-9
80002974:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
80002978:	fec42783          	lw	a5,-20(s0)
8000297c:	0087e793          	ori	a5,a5,8
80002980:	fef42623          	sw	a5,-20(s0)
        break;
80002984:	0240006f          	j	800029a8 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
80002988:	fec42783          	lw	a5,-20(s0)
8000298c:	ffd7f793          	andi	a5,a5,-3
80002990:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80002994:	fec42783          	lw	a5,-20(s0)
80002998:	0027e793          	ori	a5,a5,2
8000299c:	fef42623          	sw	a5,-20(s0)
        break;
800029a0:	0080006f          	j	800029a8 <s_mstatus_intr+0xdc>
        break;
800029a4:	00000013          	nop
    w_mstatus(x);
800029a8:	fec42503          	lw	a0,-20(s0)
800029ac:	ea9ff0ef          	jal	ra,80002854 <w_mstatus>
}
800029b0:	00000013          	nop
800029b4:	02c12083          	lw	ra,44(sp)
800029b8:	02812403          	lw	s0,40(sp)
800029bc:	03010113          	addi	sp,sp,48
800029c0:	00008067          	ret

800029c4 <r_sie>:
static inline uint32 r_sie(){
800029c4:	fe010113          	addi	sp,sp,-32
800029c8:	00812e23          	sw	s0,28(sp)
800029cc:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie " : "=r"(x));
800029d0:	104027f3          	csrr	a5,sie
800029d4:	fef42623          	sw	a5,-20(s0)
    return x;
800029d8:	fec42783          	lw	a5,-20(s0)
}
800029dc:	00078513          	mv	a0,a5
800029e0:	01c12403          	lw	s0,28(sp)
800029e4:	02010113          	addi	sp,sp,32
800029e8:	00008067          	ret

800029ec <w_sie>:
static inline void w_sie(uint32 x){
800029ec:	fe010113          	addi	sp,sp,-32
800029f0:	00812e23          	sw	s0,28(sp)
800029f4:	02010413          	addi	s0,sp,32
800029f8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
800029fc:	fec42783          	lw	a5,-20(s0)
80002a00:	10479073          	csrw	sie,a5
}
80002a04:	00000013          	nop
80002a08:	01c12403          	lw	s0,28(sp)
80002a0c:	02010113          	addi	sp,sp,32
80002a10:	00008067          	ret

80002a14 <r_mie>:
#define MEIE (1<<11)
#define MTIE (1<<7)
#define MSIE (1<<3)
static inline uint32 r_mie(){
80002a14:	fe010113          	addi	sp,sp,-32
80002a18:	00812e23          	sw	s0,28(sp)
80002a1c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie " : "=r"(x));
80002a20:	304027f3          	csrr	a5,mie
80002a24:	fef42623          	sw	a5,-20(s0)
    return x;
80002a28:	fec42783          	lw	a5,-20(s0)
}
80002a2c:	00078513          	mv	a0,a5
80002a30:	01c12403          	lw	s0,28(sp)
80002a34:	02010113          	addi	sp,sp,32
80002a38:	00008067          	ret

80002a3c <w_mie>:
static inline void w_mie(uint32 x){
80002a3c:	fe010113          	addi	sp,sp,-32
80002a40:	00812e23          	sw	s0,28(sp)
80002a44:	02010413          	addi	s0,sp,32
80002a48:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"::"r"(x));
80002a4c:	fec42783          	lw	a5,-20(s0)
80002a50:	30479073          	csrw	mie,a5
}
80002a54:	00000013          	nop
80002a58:	01c12403          	lw	s0,28(sp)
80002a5c:	02010113          	addi	sp,sp,32
80002a60:	00008067          	ret

80002a64 <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x){
80002a64:	fe010113          	addi	sp,sp,-32
80002a68:	00812e23          	sw	s0,28(sp)
80002a6c:	02010413          	addi	s0,sp,32
80002a70:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0" : :"r"(x));
80002a74:	fec42783          	lw	a5,-20(s0)
80002a78:	34079073          	csrw	mscratch,a5
80002a7c:	00000013          	nop
80002a80:	01c12403          	lw	s0,28(sp)
80002a84:	02010113          	addi	sp,sp,32
80002a88:	00008067          	ret

80002a8c <timerinit>:

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit(){
80002a8c:	fe010113          	addi	sp,sp,-32
80002a90:	00112e23          	sw	ra,28(sp)
80002a94:	00812c23          	sw	s0,24(sp)
80002a98:	01212a23          	sw	s2,20(sp)
80002a9c:	01312823          	sw	s3,16(sp)
80002aa0:	02010413          	addi	s0,sp,32
    uint hart=r_tp();
80002aa4:	e01ff0ef          	jal	ra,800028a4 <r_tp>
80002aa8:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
80002aac:	fec42703          	lw	a4,-20(s0)
80002ab0:	00070793          	mv	a5,a4
80002ab4:	00279793          	slli	a5,a5,0x2
80002ab8:	00e787b3          	add	a5,a5,a4
80002abc:	00379793          	slli	a5,a5,0x3
80002ac0:	8000e737          	lui	a4,0x8000e
80002ac4:	a5070713          	addi	a4,a4,-1456 # 8000da50 <memend+0xf800da50>
80002ac8:	00e787b3          	add	a5,a5,a4
80002acc:	00078513          	mv	a0,a5
80002ad0:	f95ff0ef          	jal	ra,80002a64 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
80002ad4:	fec42703          	lw	a4,-20(s0)
80002ad8:	004017b7          	lui	a5,0x401
80002adc:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002ae0:	00f707b3          	add	a5,a4,a5
80002ae4:	00379793          	slli	a5,a5,0x3
80002ae8:	00078913          	mv	s2,a5
80002aec:	00000993          	li	s3,0
80002af0:	8000e7b7          	lui	a5,0x8000e
80002af4:	a5078693          	addi	a3,a5,-1456 # 8000da50 <memend+0xf800da50>
80002af8:	fec42703          	lw	a4,-20(s0)
80002afc:	00070793          	mv	a5,a4
80002b00:	00279793          	slli	a5,a5,0x2
80002b04:	00e787b3          	add	a5,a5,a4
80002b08:	00379793          	slli	a5,a5,0x3
80002b0c:	00f687b3          	add	a5,a3,a5
80002b10:	0127a023          	sw	s2,0(a5)
80002b14:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;
80002b18:	8000e7b7          	lui	a5,0x8000e
80002b1c:	a5078693          	addi	a3,a5,-1456 # 8000da50 <memend+0xf800da50>
80002b20:	fec42703          	lw	a4,-20(s0)
80002b24:	00070793          	mv	a5,a4
80002b28:	00279793          	slli	a5,a5,0x2
80002b2c:	00e787b3          	add	a5,a5,a4
80002b30:	00379793          	slli	a5,a5,0x3
80002b34:	00f686b3          	add	a3,a3,a5
80002b38:	00989737          	lui	a4,0x989
80002b3c:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002b40:	00000793          	li	a5,0
80002b44:	00e6a423          	sw	a4,8(a3)
80002b48:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数
80002b4c:	800007b7          	lui	a5,0x80000
80002b50:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
80002b54:	00078513          	mv	a0,a5
80002b58:	d25ff0ef          	jal	ra,8000287c <w_mtvec>

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断
80002b5c:	00800513          	li	a0,8
80002b60:	d6dff0ef          	jal	ra,800028cc <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
80002b64:	e61ff0ef          	jal	ra,800029c4 <r_sie>
80002b68:	00050793          	mv	a5,a0
80002b6c:	2227e793          	ori	a5,a5,546
80002b70:	00078513          	mv	a0,a5
80002b74:	e79ff0ef          	jal	ra,800029ec <w_sie>

    w_mie(r_mie() | MTIE );      // 开启 M-mode 时钟中断
80002b78:	e9dff0ef          	jal	ra,80002a14 <r_mie>
80002b7c:	00050793          	mv	a5,a0
80002b80:	0807e793          	ori	a5,a5,128
80002b84:	00078513          	mv	a0,a5
80002b88:	eb5ff0ef          	jal	ra,80002a3c <w_mie>

    clintinit();                 // 初始化 CLINT           
80002b8c:	c31ff0ef          	jal	ra,800027bc <clintinit>
80002b90:	00000013          	nop
80002b94:	01c12083          	lw	ra,28(sp)
80002b98:	01812403          	lw	s0,24(sp)
80002b9c:	01412903          	lw	s2,20(sp)
80002ba0:	01012983          	lw	s3,16(sp)
80002ba4:	02010113          	addi	sp,sp,32
80002ba8:	00008067          	ret

80002bac <r_sepc>:
static inline uint32 r_sepc(){
80002bac:	fe010113          	addi	sp,sp,-32
80002bb0:	00812e23          	sw	s0,28(sp)
80002bb4:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, sepc" : "=r" (x) );
80002bb8:	141027f3          	csrr	a5,sepc
80002bbc:	fef42623          	sw	a5,-20(s0)
    return x;
80002bc0:	fec42783          	lw	a5,-20(s0)
}
80002bc4:	00078513          	mv	a0,a5
80002bc8:	01c12403          	lw	s0,28(sp)
80002bcc:	02010113          	addi	sp,sp,32
80002bd0:	00008067          	ret

80002bd4 <syscall>:
static uint32 (*syscalls[])(void)={
[SYS_fork]  sys_fork,
[SYS_exec]  sys_exec,
};

void syscall(){
80002bd4:	fe010113          	addi	sp,sp,-32
80002bd8:	00112e23          	sw	ra,28(sp)
80002bdc:	00812c23          	sw	s0,24(sp)
80002be0:	00912a23          	sw	s1,20(sp)
80002be4:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80002be8:	bf4ff0ef          	jal	ra,80001fdc <nowproc>
80002bec:	fea42623          	sw	a0,-20(s0)
    p->trapframe->epc=r_sepc();
80002bf0:	fec42783          	lw	a5,-20(s0)
80002bf4:	0087a483          	lw	s1,8(a5)
80002bf8:	fb5ff0ef          	jal	ra,80002bac <r_sepc>
80002bfc:	00050793          	mv	a5,a0
80002c00:	00f4a623          	sw	a5,12(s1)
    p->trapframe->epc+=4;
80002c04:	fec42783          	lw	a5,-20(s0)
80002c08:	0087a783          	lw	a5,8(a5)
80002c0c:	00c7a703          	lw	a4,12(a5)
80002c10:	fec42783          	lw	a5,-20(s0)
80002c14:	0087a783          	lw	a5,8(a5)
80002c18:	00470713          	addi	a4,a4,4
80002c1c:	00e7a623          	sw	a4,12(a5)

    uint32 sysnum=p->trapframe->a7;
80002c20:	fec42783          	lw	a5,-20(s0)
80002c24:	0087a783          	lw	a5,8(a5)
80002c28:	03c7a783          	lw	a5,60(a5)
80002c2c:	fef42423          	sw	a5,-24(s0)
    p->trapframe->a0=syscalls[sysnum]();
80002c30:	8000b7b7          	lui	a5,0x8000b
80002c34:	01878713          	addi	a4,a5,24 # 8000b018 <memend+0xf800b018>
80002c38:	fe842783          	lw	a5,-24(s0)
80002c3c:	00279793          	slli	a5,a5,0x2
80002c40:	00f707b3          	add	a5,a4,a5
80002c44:	0007a703          	lw	a4,0(a5)
80002c48:	fec42783          	lw	a5,-20(s0)
80002c4c:	0087a483          	lw	s1,8(a5)
80002c50:	000700e7          	jalr	a4
80002c54:	00050793          	mv	a5,a0
80002c58:	02f4a023          	sw	a5,32(s1)
80002c5c:	00000013          	nop
80002c60:	01c12083          	lw	ra,28(sp)
80002c64:	01812403          	lw	s0,24(sp)
80002c68:	01412483          	lw	s1,20(sp)
80002c6c:	02010113          	addi	sp,sp,32
80002c70:	00008067          	ret

80002c74 <textend>:
	...
