
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
800000ac:	65d000ef          	jal	ra,80000f08 <trapvec>

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
8000032c:	3dd000ef          	jal	ra,80000f08 <trapvec>

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
80000720:	2c8020ef          	jal	ra,800029e8 <timerinit>

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
80000924:	0a1000ef          	jal	ra,800011c4 <printf>

    minit();    // 物理内存管理
80000928:	4a9000ef          	jal	ra,800015d0 <minit>
    plicinit(); // PLIC 中断处理
8000092c:	645000ef          	jal	ra,80001770 <plicinit>

    kvminit(); // 启动虚拟内存
80000930:	2f8010ef          	jal	ra,80001c28 <kvminit>
    
#ifdef DEBUG
    printf("usertrap: %p\n", usertrap);
#endif

    procinit();
80000934:	584010ef          	jal	ra,80001eb8 <procinit>

    userinit();
80000938:	768010ef          	jal	ra,800020a0 <userinit>

    mmioinit();
8000093c:	294020ef          	jal	ra,80002bd0 <mmioinit>

    printf("----------------------\n");
80000940:	8000c7b7          	lui	a5,0x8000c
80000944:	02078513          	addi	a0,a5,32 # 8000c020 <memend+0xf800c020>
80000948:	07d000ef          	jal	ra,800011c4 <printf>
    schedule();
8000094c:	191010ef          	jal	ra,800022dc <schedule>
}
80000950:	00000013          	nop
80000954:	00c12083          	lw	ra,12(sp)
80000958:	00812403          	lw	s0,8(sp)
8000095c:	01010113          	addi	sp,sp,16
80000960:	00008067          	ret

80000964 <r_sstatus>:
    w_mstatus(x);
}

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus()
{
80000964:	fe010113          	addi	sp,sp,-32
80000968:	00812e23          	sw	s0,28(sp)
8000096c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus"
80000970:	100027f3          	csrr	a5,sstatus
80000974:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000978:	fec42783          	lw	a5,-20(s0)
}
8000097c:	00078513          	mv	a0,a5
80000980:	01c12403          	lw	s0,28(sp)
80000984:	02010113          	addi	sp,sp,32
80000988:	00008067          	ret

8000098c <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x)
{
8000098c:	fe010113          	addi	sp,sp,-32
80000990:	00812e23          	sw	s0,28(sp)
80000994:	02010413          	addi	s0,sp,32
80000998:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0"
8000099c:	fec42783          	lw	a5,-20(s0)
800009a0:	10079073          	csrw	sstatus,a5
                 :
                 : "r"(x));
}
800009a4:	00000013          	nop
800009a8:	01c12403          	lw	s0,28(sp)
800009ac:	02010113          	addi	sp,sp,32
800009b0:	00008067          	ret

800009b4 <s_sstatus_xpp>:
    return x;
}
// 设置特权模式
#define S_SPP_SET (1 << 8)
static inline void s_sstatus_xpp(uint8 m)
{
800009b4:	fd010113          	addi	sp,sp,-48
800009b8:	02112623          	sw	ra,44(sp)
800009bc:	02812423          	sw	s0,40(sp)
800009c0:	03010413          	addi	s0,sp,48
800009c4:	00050793          	mv	a5,a0
800009c8:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x = r_sstatus();
800009cc:	f99ff0ef          	jal	ra,80000964 <r_sstatus>
800009d0:	fea42623          	sw	a0,-20(s0)
    switch (m)
800009d4:	fdf44783          	lbu	a5,-33(s0)
800009d8:	00078863          	beqz	a5,800009e8 <s_sstatus_xpp+0x34>
800009dc:	00100713          	li	a4,1
800009e0:	00e78c63          	beq	a5,a4,800009f8 <s_sstatus_xpp+0x44>
    case RISCV_S:
        x &= ~SPP_MASK;
        x |= S_SPP_SET;
        break;
    default:
        break;
800009e4:	0300006f          	j	80000a14 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
800009e8:	fec42783          	lw	a5,-20(s0)
800009ec:	eff7f793          	andi	a5,a5,-257
800009f0:	fef42623          	sw	a5,-20(s0)
        break;
800009f4:	0200006f          	j	80000a14 <s_sstatus_xpp+0x60>
        x &= ~SPP_MASK;
800009f8:	fec42783          	lw	a5,-20(s0)
800009fc:	eff7f793          	andi	a5,a5,-257
80000a00:	fef42623          	sw	a5,-20(s0)
        x |= S_SPP_SET;
80000a04:	fec42783          	lw	a5,-20(s0)
80000a08:	1007e793          	ori	a5,a5,256
80000a0c:	fef42623          	sw	a5,-20(s0)
        break;
80000a10:	00000013          	nop
    }
    w_sstatus(x);
80000a14:	fec42503          	lw	a0,-20(s0)
80000a18:	f75ff0ef          	jal	ra,8000098c <w_sstatus>
}
80000a1c:	00000013          	nop
80000a20:	02c12083          	lw	ra,44(sp)
80000a24:	02812403          	lw	s0,40(sp)
80000a28:	03010113          	addi	sp,sp,48
80000a2c:	00008067          	ret

80000a30 <w_sepc>:
                 : "=r"(x));
    return x;
}
// 写 sepc寄存器
static inline void w_sepc(uint32 x)
{
80000a30:	fe010113          	addi	sp,sp,-32
80000a34:	00812e23          	sw	s0,28(sp)
80000a38:	02010413          	addi	s0,sp,32
80000a3c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0"
80000a40:	fec42783          	lw	a5,-20(s0)
80000a44:	14179073          	csrw	sepc,a5
                 :
                 : "r"(x));
}
80000a48:	00000013          	nop
80000a4c:	01c12403          	lw	s0,28(sp)
80000a50:	02010113          	addi	sp,sp,32
80000a54:	00008067          	ret

80000a58 <w_stvec>:
    asm volatile("csrr %0 , stvec"
                 : "=r"(x));
    return x;
}
static inline void w_stvec(uint32 x)
{
80000a58:	fe010113          	addi	sp,sp,-32
80000a5c:	00812e23          	sw	s0,28(sp)
80000a60:	02010413          	addi	s0,sp,32
80000a64:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0"
80000a68:	fec42783          	lw	a5,-20(s0)
80000a6c:	10579073          	csrw	stvec,a5
                 :
                 : "r"(x));
}
80000a70:	00000013          	nop
80000a74:	01c12403          	lw	s0,28(sp)
80000a78:	02010113          	addi	sp,sp,32
80000a7c:	00008067          	ret

80000a80 <r_satp>:
 * asid = 地址空间标识
 * ppn  = 根页表物理页码(物理地址/4Kb)
 */
#define SATP_SV32 (1 << 31)
static inline uint32 r_satp()
{
80000a80:	fe010113          	addi	sp,sp,-32
80000a84:	00812e23          	sw	s0,28(sp)
80000a88:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,satp"
80000a8c:	180027f3          	csrr	a5,satp
80000a90:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000a94:	fec42783          	lw	a5,-20(s0)
}
80000a98:	00078513          	mv	a0,a5
80000a9c:	01c12403          	lw	s0,28(sp)
80000aa0:	02010113          	addi	sp,sp,32
80000aa4:	00008067          	ret

80000aa8 <r_scause>:
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常
 */
static inline uint32 r_scause()
{
80000aa8:	fe010113          	addi	sp,sp,-32
80000aac:	00812e23          	sw	s0,28(sp)
80000ab0:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause"
80000ab4:	142027f3          	csrr	a5,scause
80000ab8:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000abc:	fec42783          	lw	a5,-20(s0)
}
80000ac0:	00078513          	mv	a0,a5
80000ac4:	01c12403          	lw	s0,28(sp)
80000ac8:	02010113          	addi	sp,sp,32
80000acc:	00008067          	ret

80000ad0 <r_stval>:
/** 如果stval在指令获取、加载或存储发生断点、
 * 地址错位、访问错误或页面错误异常时使用非
 * 零值写入，则stval将包含出错的虚拟地址。
 */
static inline uint32 r_stval()
{
80000ad0:	fe010113          	addi	sp,sp,-32
80000ad4:	00812e23          	sw	s0,28(sp)
80000ad8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,stval"
80000adc:	143027f3          	csrr	a5,stval
80000ae0:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000ae4:	fec42783          	lw	a5,-20(s0)
}
80000ae8:	00078513          	mv	a0,a5
80000aec:	01c12403          	lw	s0,28(sp)
80000af0:	02010113          	addi	sp,sp,32
80000af4:	00008067          	ret

80000af8 <r_sip>:
/**
 * @description:
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip()
{
80000af8:	fe010113          	addi	sp,sp,-32
80000afc:	00812e23          	sw	s0,28(sp)
80000b00:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip"
80000b04:	144027f3          	csrr	a5,sip
80000b08:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80000b0c:	fec42783          	lw	a5,-20(s0)
}
80000b10:	00078513          	mv	a0,a5
80000b14:	01c12403          	lw	s0,28(sp)
80000b18:	02010113          	addi	sp,sp,32
80000b1c:	00008067          	ret

80000b20 <w_sip>:
static inline void w_sip(uint32 x)
{
80000b20:	fe010113          	addi	sp,sp,-32
80000b24:	00812e23          	sw	s0,28(sp)
80000b28:	02010413          	addi	s0,sp,32
80000b2c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"
80000b30:	fec42783          	lw	a5,-20(s0)
80000b34:	14479073          	csrw	sip,a5
                 :
                 : "r"(x));
}
80000b38:	00000013          	nop
80000b3c:	01c12403          	lw	s0,28(sp)
80000b40:	02010113          	addi	sp,sp,32
80000b44:	00008067          	ret

80000b48 <externinterrupt>:

/**
 * @description: 处理外部中断
 */
void externinterrupt()
{
80000b48:	fe010113          	addi	sp,sp,-32
80000b4c:	00112e23          	sw	ra,28(sp)
80000b50:	00812c23          	sw	s0,24(sp)
80000b54:	02010413          	addi	s0,sp,32
    uint32 irq = r_plicclaim();
80000b58:	4dd000ef          	jal	ra,80001834 <r_plicclaim>
80000b5c:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n", irq);
80000b60:	fec42583          	lw	a1,-20(s0)
80000b64:	8000c7b7          	lui	a5,0x8000c
80000b68:	03878513          	addi	a0,a5,56 # 8000c038 <memend+0xf800c038>
80000b6c:	658000ef          	jal	ra,800011c4 <printf>
    switch (irq)
80000b70:	fec42703          	lw	a4,-20(s0)
80000b74:	00a00793          	li	a5,10
80000b78:	02f71063          	bne	a4,a5,80000b98 <externinterrupt+0x50>
    {
    case UART_IRQ: // uart 中断(键盘输入)
        printf("recived : %c\n", uartintr());
80000b7c:	d61ff0ef          	jal	ra,800008dc <uartintr>
80000b80:	00050793          	mv	a5,a0
80000b84:	00078593          	mv	a1,a5
80000b88:	8000c7b7          	lui	a5,0x8000c
80000b8c:	04478513          	addi	a0,a5,68 # 8000c044 <memend+0xf800c044>
80000b90:	634000ef          	jal	ra,800011c4 <printf>
        break;
80000b94:	0080006f          	j	80000b9c <externinterrupt+0x54>
    default:
        break;
80000b98:	00000013          	nop
    }
    w_pliccomplete(irq);
80000b9c:	fec42503          	lw	a0,-20(s0)
80000ba0:	4d5000ef          	jal	ra,80001874 <w_pliccomplete>
}
80000ba4:	00000013          	nop
80000ba8:	01c12083          	lw	ra,28(sp)
80000bac:	01812403          	lw	s0,24(sp)
80000bb0:	02010113          	addi	sp,sp,32
80000bb4:	00008067          	ret

80000bb8 <ptf>:

void ptf(struct trapframe *tf)
{
80000bb8:	fe010113          	addi	sp,sp,-32
80000bbc:	00112e23          	sw	ra,28(sp)
80000bc0:	00812c23          	sw	s0,24(sp)
80000bc4:	02010413          	addi	s0,sp,32
80000bc8:	fea42623          	sw	a0,-20(s0)
    printf("kernel_sp: %d \n", tf->kernel_sp);
80000bcc:	fec42783          	lw	a5,-20(s0)
80000bd0:	0087a783          	lw	a5,8(a5)
80000bd4:	00078593          	mv	a1,a5
80000bd8:	8000c7b7          	lui	a5,0x8000c
80000bdc:	05478513          	addi	a0,a5,84 # 8000c054 <memend+0xf800c054>
80000be0:	5e4000ef          	jal	ra,800011c4 <printf>
    printf("kernel_satp: %d \n", tf->kernel_satp);
80000be4:	fec42783          	lw	a5,-20(s0)
80000be8:	0007a783          	lw	a5,0(a5)
80000bec:	00078593          	mv	a1,a5
80000bf0:	8000c7b7          	lui	a5,0x8000c
80000bf4:	06478513          	addi	a0,a5,100 # 8000c064 <memend+0xf800c064>
80000bf8:	5cc000ef          	jal	ra,800011c4 <printf>
    printf("kernel_tvec: %d \n", tf->kernel_tvec);
80000bfc:	fec42783          	lw	a5,-20(s0)
80000c00:	0047a783          	lw	a5,4(a5)
80000c04:	00078593          	mv	a1,a5
80000c08:	8000c7b7          	lui	a5,0x8000c
80000c0c:	07878513          	addi	a0,a5,120 # 8000c078 <memend+0xf800c078>
80000c10:	5b4000ef          	jal	ra,800011c4 <printf>

    printf("ra: %d \n", tf->ra);
80000c14:	fec42783          	lw	a5,-20(s0)
80000c18:	0107a783          	lw	a5,16(a5)
80000c1c:	00078593          	mv	a1,a5
80000c20:	8000c7b7          	lui	a5,0x8000c
80000c24:	08c78513          	addi	a0,a5,140 # 8000c08c <memend+0xf800c08c>
80000c28:	59c000ef          	jal	ra,800011c4 <printf>
    printf("sp: %d \n", tf->sp);
80000c2c:	fec42783          	lw	a5,-20(s0)
80000c30:	0147a783          	lw	a5,20(a5)
80000c34:	00078593          	mv	a1,a5
80000c38:	8000c7b7          	lui	a5,0x8000c
80000c3c:	09878513          	addi	a0,a5,152 # 8000c098 <memend+0xf800c098>
80000c40:	584000ef          	jal	ra,800011c4 <printf>
    printf("tp: %d \n", tf->tp);
80000c44:	fec42783          	lw	a5,-20(s0)
80000c48:	01c7a783          	lw	a5,28(a5)
80000c4c:	00078593          	mv	a1,a5
80000c50:	8000c7b7          	lui	a5,0x8000c
80000c54:	0a478513          	addi	a0,a5,164 # 8000c0a4 <memend+0xf800c0a4>
80000c58:	56c000ef          	jal	ra,800011c4 <printf>
    printf("t0: %d \n", tf->t0);
80000c5c:	fec42783          	lw	a5,-20(s0)
80000c60:	0707a783          	lw	a5,112(a5)
80000c64:	00078593          	mv	a1,a5
80000c68:	8000c7b7          	lui	a5,0x8000c
80000c6c:	0b078513          	addi	a0,a5,176 # 8000c0b0 <memend+0xf800c0b0>
80000c70:	554000ef          	jal	ra,800011c4 <printf>
    printf("t1: %d \n", tf->t1);
80000c74:	fec42783          	lw	a5,-20(s0)
80000c78:	0747a783          	lw	a5,116(a5)
80000c7c:	00078593          	mv	a1,a5
80000c80:	8000c7b7          	lui	a5,0x8000c
80000c84:	0bc78513          	addi	a0,a5,188 # 8000c0bc <memend+0xf800c0bc>
80000c88:	53c000ef          	jal	ra,800011c4 <printf>
    printf("t2: %d \n", tf->t2);
80000c8c:	fec42783          	lw	a5,-20(s0)
80000c90:	0787a783          	lw	a5,120(a5)
80000c94:	00078593          	mv	a1,a5
80000c98:	8000c7b7          	lui	a5,0x8000c
80000c9c:	0c878513          	addi	a0,a5,200 # 8000c0c8 <memend+0xf800c0c8>
80000ca0:	524000ef          	jal	ra,800011c4 <printf>
    printf("t3: %d \n", tf->t3);
80000ca4:	fec42783          	lw	a5,-20(s0)
80000ca8:	07c7a783          	lw	a5,124(a5)
80000cac:	00078593          	mv	a1,a5
80000cb0:	8000c7b7          	lui	a5,0x8000c
80000cb4:	0d478513          	addi	a0,a5,212 # 8000c0d4 <memend+0xf800c0d4>
80000cb8:	50c000ef          	jal	ra,800011c4 <printf>
    printf("t4: %d \n", tf->t4);
80000cbc:	fec42783          	lw	a5,-20(s0)
80000cc0:	0807a783          	lw	a5,128(a5)
80000cc4:	00078593          	mv	a1,a5
80000cc8:	8000c7b7          	lui	a5,0x8000c
80000ccc:	0e078513          	addi	a0,a5,224 # 8000c0e0 <memend+0xf800c0e0>
80000cd0:	4f4000ef          	jal	ra,800011c4 <printf>
    printf("t5: %d \n", tf->t5);
80000cd4:	fec42783          	lw	a5,-20(s0)
80000cd8:	0847a783          	lw	a5,132(a5)
80000cdc:	00078593          	mv	a1,a5
80000ce0:	8000c7b7          	lui	a5,0x8000c
80000ce4:	0ec78513          	addi	a0,a5,236 # 8000c0ec <memend+0xf800c0ec>
80000ce8:	4dc000ef          	jal	ra,800011c4 <printf>
    printf("t6: %d \n", tf->t6);
80000cec:	fec42783          	lw	a5,-20(s0)
80000cf0:	0887a783          	lw	a5,136(a5)
80000cf4:	00078593          	mv	a1,a5
80000cf8:	8000c7b7          	lui	a5,0x8000c
80000cfc:	0f878513          	addi	a0,a5,248 # 8000c0f8 <memend+0xf800c0f8>
80000d00:	4c4000ef          	jal	ra,800011c4 <printf>
    printf("a0: %d \n", tf->a0);
80000d04:	fec42783          	lw	a5,-20(s0)
80000d08:	0207a783          	lw	a5,32(a5)
80000d0c:	00078593          	mv	a1,a5
80000d10:	8000c7b7          	lui	a5,0x8000c
80000d14:	10478513          	addi	a0,a5,260 # 8000c104 <memend+0xf800c104>
80000d18:	4ac000ef          	jal	ra,800011c4 <printf>
    printf("a1: %d \n", tf->a1);
80000d1c:	fec42783          	lw	a5,-20(s0)
80000d20:	0247a783          	lw	a5,36(a5)
80000d24:	00078593          	mv	a1,a5
80000d28:	8000c7b7          	lui	a5,0x8000c
80000d2c:	11078513          	addi	a0,a5,272 # 8000c110 <memend+0xf800c110>
80000d30:	494000ef          	jal	ra,800011c4 <printf>
    printf("a2: %d \n", tf->a2);
80000d34:	fec42783          	lw	a5,-20(s0)
80000d38:	0287a783          	lw	a5,40(a5)
80000d3c:	00078593          	mv	a1,a5
80000d40:	8000c7b7          	lui	a5,0x8000c
80000d44:	11c78513          	addi	a0,a5,284 # 8000c11c <memend+0xf800c11c>
80000d48:	47c000ef          	jal	ra,800011c4 <printf>
    printf("a3: %d \n", tf->a3);
80000d4c:	fec42783          	lw	a5,-20(s0)
80000d50:	02c7a783          	lw	a5,44(a5)
80000d54:	00078593          	mv	a1,a5
80000d58:	8000c7b7          	lui	a5,0x8000c
80000d5c:	12878513          	addi	a0,a5,296 # 8000c128 <memend+0xf800c128>
80000d60:	464000ef          	jal	ra,800011c4 <printf>
    printf("a4: %d \n", tf->a4);
80000d64:	fec42783          	lw	a5,-20(s0)
80000d68:	0307a783          	lw	a5,48(a5)
80000d6c:	00078593          	mv	a1,a5
80000d70:	8000c7b7          	lui	a5,0x8000c
80000d74:	13478513          	addi	a0,a5,308 # 8000c134 <memend+0xf800c134>
80000d78:	44c000ef          	jal	ra,800011c4 <printf>
    printf("a5: %d \n", tf->a5);
80000d7c:	fec42783          	lw	a5,-20(s0)
80000d80:	0347a783          	lw	a5,52(a5)
80000d84:	00078593          	mv	a1,a5
80000d88:	8000c7b7          	lui	a5,0x8000c
80000d8c:	14078513          	addi	a0,a5,320 # 8000c140 <memend+0xf800c140>
80000d90:	434000ef          	jal	ra,800011c4 <printf>
    printf("a6: %d \n", tf->a6);
80000d94:	fec42783          	lw	a5,-20(s0)
80000d98:	0387a783          	lw	a5,56(a5)
80000d9c:	00078593          	mv	a1,a5
80000da0:	8000c7b7          	lui	a5,0x8000c
80000da4:	14c78513          	addi	a0,a5,332 # 8000c14c <memend+0xf800c14c>
80000da8:	41c000ef          	jal	ra,800011c4 <printf>
    printf("a7: %d \n", tf->a7);
80000dac:	fec42783          	lw	a5,-20(s0)
80000db0:	03c7a783          	lw	a5,60(a5)
80000db4:	00078593          	mv	a1,a5
80000db8:	8000c7b7          	lui	a5,0x8000c
80000dbc:	15878513          	addi	a0,a5,344 # 8000c158 <memend+0xf800c158>
80000dc0:	404000ef          	jal	ra,800011c4 <printf>
}
80000dc4:	00000013          	nop
80000dc8:	01c12083          	lw	ra,28(sp)
80000dcc:	01812403          	lw	s0,24(sp)
80000dd0:	02010113          	addi	sp,sp,32
80000dd4:	00008067          	ret

80000dd8 <usertrapret>:

// 返回用户空间
void usertrapret()
{
80000dd8:	fe010113          	addi	sp,sp,-32
80000ddc:	00112e23          	sw	ra,28(sp)
80000de0:	00812c23          	sw	s0,24(sp)
80000de4:	00912a23          	sw	s1,20(sp)
80000de8:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80000dec:	14c010ef          	jal	ra,80001f38 <nowproc>
80000df0:	fea42623          	sw	a0,-20(s0)
    s_sstatus_xpp(RISCV_U);
80000df4:	00000513          	li	a0,0
80000df8:	bbdff0ef          	jal	ra,800009b4 <s_sstatus_xpp>
    w_stvec((uint32)usertrap);
80000dfc:	800007b7          	lui	a5,0x80000
80000e00:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80000e04:	00078513          	mv	a0,a5
80000e08:	c51ff0ef          	jal	ra,80000a58 <w_stvec>
    addr_t satp = (SATP_SV32 | (addr_t)(p->pagetable) >> 12);
80000e0c:	fec42783          	lw	a5,-20(s0)
80000e10:	0887a783          	lw	a5,136(a5)
80000e14:	00c7d713          	srli	a4,a5,0xc
80000e18:	800007b7          	lui	a5,0x80000
80000e1c:	00f767b3          	or	a5,a4,a5
80000e20:	fef42423          	sw	a5,-24(s0)
    // ptf(p->trapframe);

    // printf("%p\n",p->trapframe);
    // printf("sepc: %p\n",r_sepc());

    w_sepc((addr_t)p->trapframe->epc);
80000e24:	fec42783          	lw	a5,-20(s0)
80000e28:	0087a783          	lw	a5,8(a5) # 80000008 <memend+0xf8000008>
80000e2c:	00c7a783          	lw	a5,12(a5)
80000e30:	00078513          	mv	a0,a5
80000e34:	bfdff0ef          	jal	ra,80000a30 <w_sepc>

    p->trapframe->kernel_satp = r_satp();
80000e38:	fec42783          	lw	a5,-20(s0)
80000e3c:	0087a483          	lw	s1,8(a5)
80000e40:	c41ff0ef          	jal	ra,80000a80 <r_satp>
80000e44:	00050793          	mv	a5,a0
80000e48:	00f4a023          	sw	a5,0(s1)
    p->trapframe->kernel_tvec = (addr_t)trapvec;
80000e4c:	fec42783          	lw	a5,-20(s0)
80000e50:	0087a783          	lw	a5,8(a5)
80000e54:	80001737          	lui	a4,0x80001
80000e58:	f0870713          	addi	a4,a4,-248 # 80000f08 <memend+0xf8000f08>
80000e5c:	00e7a223          	sw	a4,4(a5)
    p->trapframe->kernel_sp = (addr_t)p->kernelstack;
80000e60:	fec42783          	lw	a5,-20(s0)
80000e64:	0087a783          	lw	a5,8(a5)
80000e68:	fec42703          	lw	a4,-20(s0)
80000e6c:	08c72703          	lw	a4,140(a4)
80000e70:	00e7a423          	sw	a4,8(a5)

    // printf("%p\n",p->kernelstack);
    userret((addr_t *)TRAPFRAME, satp);
80000e74:	fe842583          	lw	a1,-24(s0)
80000e78:	ffffe537          	lui	a0,0xffffe
80000e7c:	cb4ff0ef          	jal	ra,80000330 <userret>
}
80000e80:	00000013          	nop
80000e84:	01c12083          	lw	ra,28(sp)
80000e88:	01812403          	lw	s0,24(sp)
80000e8c:	01412483          	lw	s1,20(sp)
80000e90:	02010113          	addi	sp,sp,32
80000e94:	00008067          	ret

80000e98 <startproc>:

static int first = 0;
void startproc()
{
80000e98:	ff010113          	addi	sp,sp,-16
80000e9c:	00112623          	sw	ra,12(sp)
80000ea0:	00812423          	sw	s0,8(sp)
80000ea4:	01010413          	addi	s0,sp,16
    first = 1;
80000ea8:	8000d7b7          	lui	a5,0x8000d
80000eac:	00100713          	li	a4,1
80000eb0:	00e7a223          	sw	a4,4(a5) # 8000d004 <memend+0xf800d004>
    usertrapret();
80000eb4:	f25ff0ef          	jal	ra,80000dd8 <usertrapret>
}
80000eb8:	00000013          	nop
80000ebc:	00c12083          	lw	ra,12(sp)
80000ec0:	00812403          	lw	s0,8(sp)
80000ec4:	01010113          	addi	sp,sp,16
80000ec8:	00008067          	ret

80000ecc <timerintr>:

void timerintr()
{
80000ecc:	ff010113          	addi	sp,sp,-16
80000ed0:	00112623          	sw	ra,12(sp)
80000ed4:	00812423          	sw	s0,8(sp)
80000ed8:	01010413          	addi	s0,sp,16
    w_sip(r_sip() & ~2); // 清除中断
80000edc:	c1dff0ef          	jal	ra,80000af8 <r_sip>
80000ee0:	00050793          	mv	a5,a0
80000ee4:	ffd7f793          	andi	a5,a5,-3
80000ee8:	00078513          	mv	a0,a5
80000eec:	c35ff0ef          	jal	ra,80000b20 <w_sip>
    yield();
80000ef0:	480010ef          	jal	ra,80002370 <yield>
}
80000ef4:	00000013          	nop
80000ef8:	00c12083          	lw	ra,12(sp)
80000efc:	00812403          	lw	s0,8(sp)
80000f00:	01010113          	addi	sp,sp,16
80000f04:	00008067          	ret

80000f08 <trapvec>:

void trapvec()
{
80000f08:	fe010113          	addi	sp,sp,-32
80000f0c:	00112e23          	sw	ra,28(sp)
80000f10:	00812c23          	sw	s0,24(sp)
80000f14:	02010413          	addi	s0,sp,32
    int where = r_sstatus() & S_SPP_SET;
80000f18:	a4dff0ef          	jal	ra,80000964 <r_sstatus>
80000f1c:	00050793          	mv	a5,a0
80000f20:	1007f793          	andi	a5,a5,256
80000f24:	fef42623          	sw	a5,-20(s0)
    w_stvec((reg_t)kvec);
80000f28:	800007b7          	lui	a5,0x80000
80000f2c:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000f30:	00078513          	mv	a0,a5
80000f34:	b25ff0ef          	jal	ra,80000a58 <w_stvec>

    uint32 scause = r_scause();
80000f38:	b71ff0ef          	jal	ra,80000aa8 <r_scause>
80000f3c:	fea42423          	sw	a0,-24(s0)

    uint16 code = scause & 0xffff;
80000f40:	fe842783          	lw	a5,-24(s0)
80000f44:	fef41323          	sh	a5,-26(s0)

    if (scause & (1 << 31))
80000f48:	fe842783          	lw	a5,-24(s0)
80000f4c:	0607dc63          	bgez	a5,80000fc4 <trapvec+0xbc>
    {
        //     printf("Interrupt : ");
        switch (code)
80000f50:	fe645783          	lhu	a5,-26(s0)
80000f54:	00900713          	li	a4,9
80000f58:	02e78c63          	beq	a5,a4,80000f90 <trapvec+0x88>
80000f5c:	00900713          	li	a4,9
80000f60:	04f74263          	blt	a4,a5,80000fa4 <trapvec+0x9c>
80000f64:	00100713          	li	a4,1
80000f68:	00e78863          	beq	a5,a4,80000f78 <trapvec+0x70>
80000f6c:	00500713          	li	a4,5
80000f70:	00e78863          	beq	a5,a4,80000f80 <trapvec+0x78>
80000f74:	0300006f          	j	80000fa4 <trapvec+0x9c>
        {
        case 1:
            // printf("Supervisor software interrupt\n");
            timerintr();
80000f78:	f55ff0ef          	jal	ra,80000ecc <timerintr>
            break;
80000f7c:	0380006f          	j	80000fb4 <trapvec+0xac>
        case 5:
            printf("Supervisor timer interrupt\n");
80000f80:	8000c7b7          	lui	a5,0x8000c
80000f84:	16478513          	addi	a0,a5,356 # 8000c164 <memend+0xf800c164>
80000f88:	23c000ef          	jal	ra,800011c4 <printf>
            break;
80000f8c:	0280006f          	j	80000fb4 <trapvec+0xac>
        case 9:
            printf("Supervisor external interrupt\n");
80000f90:	8000c7b7          	lui	a5,0x8000c
80000f94:	18078513          	addi	a0,a5,384 # 8000c180 <memend+0xf800c180>
80000f98:	22c000ef          	jal	ra,800011c4 <printf>
            externinterrupt();
80000f9c:	badff0ef          	jal	ra,80000b48 <externinterrupt>
            break;
80000fa0:	0140006f          	j	80000fb4 <trapvec+0xac>
        default:
            printf("Other interrupt\n");
80000fa4:	8000c7b7          	lui	a5,0x8000c
80000fa8:	1a078513          	addi	a0,a5,416 # 8000c1a0 <memend+0xf800c1a0>
80000fac:	218000ef          	jal	ra,800011c4 <printf>
            break;
80000fb0:	00000013          	nop
        }
        where ?: usertrapret();
80000fb4:	fec42783          	lw	a5,-20(s0)
80000fb8:	1c079063          	bnez	a5,80001178 <trapvec+0x270>
80000fbc:	e1dff0ef          	jal	ra,80000dd8 <usertrapret>
            printf("Other\n");
            break;
        }
        panic("Trap Exception");
    }
}
80000fc0:	1b80006f          	j	80001178 <trapvec+0x270>
        printf("Exception : ");
80000fc4:	8000c7b7          	lui	a5,0x8000c
80000fc8:	1b478513          	addi	a0,a5,436 # 8000c1b4 <memend+0xf800c1b4>
80000fcc:	1f8000ef          	jal	ra,800011c4 <printf>
        switch (code)
80000fd0:	fe645783          	lhu	a5,-26(s0)
80000fd4:	00f00713          	li	a4,15
80000fd8:	18f76263          	bltu	a4,a5,8000115c <trapvec+0x254>
80000fdc:	00279713          	slli	a4,a5,0x2
80000fe0:	8000c7b7          	lui	a5,0x8000c
80000fe4:	33878793          	addi	a5,a5,824 # 8000c338 <memend+0xf800c338>
80000fe8:	00f707b3          	add	a5,a4,a5
80000fec:	0007a783          	lw	a5,0(a5)
80000ff0:	00078067          	jr	a5
            printf("Instruction address misaligned\n");
80000ff4:	8000c7b7          	lui	a5,0x8000c
80000ff8:	1c478513          	addi	a0,a5,452 # 8000c1c4 <memend+0xf800c1c4>
80000ffc:	1c8000ef          	jal	ra,800011c4 <printf>
            break;
80001000:	16c0006f          	j	8000116c <trapvec+0x264>
            printf("Instruction access fault\n");
80001004:	8000c7b7          	lui	a5,0x8000c
80001008:	1e478513          	addi	a0,a5,484 # 8000c1e4 <memend+0xf800c1e4>
8000100c:	1b8000ef          	jal	ra,800011c4 <printf>
            break;
80001010:	15c0006f          	j	8000116c <trapvec+0x264>
            printf("Illegal instruction\n");
80001014:	8000c7b7          	lui	a5,0x8000c
80001018:	20078513          	addi	a0,a5,512 # 8000c200 <memend+0xf800c200>
8000101c:	1a8000ef          	jal	ra,800011c4 <printf>
            break;
80001020:	14c0006f          	j	8000116c <trapvec+0x264>
            printf("Breakpoint\n");
80001024:	8000c7b7          	lui	a5,0x8000c
80001028:	21878513          	addi	a0,a5,536 # 8000c218 <memend+0xf800c218>
8000102c:	198000ef          	jal	ra,800011c4 <printf>
            break;
80001030:	13c0006f          	j	8000116c <trapvec+0x264>
            printf("Load address misaligned\n");
80001034:	8000c7b7          	lui	a5,0x8000c
80001038:	22478513          	addi	a0,a5,548 # 8000c224 <memend+0xf800c224>
8000103c:	188000ef          	jal	ra,800011c4 <printf>
            break;
80001040:	12c0006f          	j	8000116c <trapvec+0x264>
            printf("Load access fault\n");
80001044:	8000c7b7          	lui	a5,0x8000c
80001048:	24078513          	addi	a0,a5,576 # 8000c240 <memend+0xf800c240>
8000104c:	178000ef          	jal	ra,800011c4 <printf>
            printf("stval va: %p\n", r_stval());
80001050:	a81ff0ef          	jal	ra,80000ad0 <r_stval>
80001054:	00050793          	mv	a5,a0
80001058:	00078593          	mv	a1,a5
8000105c:	8000c7b7          	lui	a5,0x8000c
80001060:	25478513          	addi	a0,a5,596 # 8000c254 <memend+0xf800c254>
80001064:	160000ef          	jal	ra,800011c4 <printf>
            break;
80001068:	1040006f          	j	8000116c <trapvec+0x264>
            printf("Store/AMO address misaligned\n");
8000106c:	8000c7b7          	lui	a5,0x8000c
80001070:	26478513          	addi	a0,a5,612 # 8000c264 <memend+0xf800c264>
80001074:	150000ef          	jal	ra,800011c4 <printf>
            break;
80001078:	0f40006f          	j	8000116c <trapvec+0x264>
            printf("Store/AMO access fault\n");
8000107c:	8000c7b7          	lui	a5,0x8000c
80001080:	28478513          	addi	a0,a5,644 # 8000c284 <memend+0xf800c284>
80001084:	140000ef          	jal	ra,800011c4 <printf>
            printf("stval va: %p\n", r_stval());
80001088:	a49ff0ef          	jal	ra,80000ad0 <r_stval>
8000108c:	00050793          	mv	a5,a0
80001090:	00078593          	mv	a1,a5
80001094:	8000c7b7          	lui	a5,0x8000c
80001098:	25478513          	addi	a0,a5,596 # 8000c254 <memend+0xf800c254>
8000109c:	128000ef          	jal	ra,800011c4 <printf>
            break;
800010a0:	0cc0006f          	j	8000116c <trapvec+0x264>
            printf("Environment call from U-mode\n");
800010a4:	8000c7b7          	lui	a5,0x8000c
800010a8:	29c78513          	addi	a0,a5,668 # 8000c29c <memend+0xf800c29c>
800010ac:	118000ef          	jal	ra,800011c4 <printf>
            syscall();
800010b0:	281010ef          	jal	ra,80002b30 <syscall>
            usertrapret();
800010b4:	d25ff0ef          	jal	ra,80000dd8 <usertrapret>
            break;
800010b8:	0b40006f          	j	8000116c <trapvec+0x264>
            printf("Environment call from S-mode\n");
800010bc:	8000c7b7          	lui	a5,0x8000c
800010c0:	2bc78513          	addi	a0,a5,700 # 8000c2bc <memend+0xf800c2bc>
800010c4:	100000ef          	jal	ra,800011c4 <printf>
            first ? usertrapret() : startproc();
800010c8:	8000d7b7          	lui	a5,0x8000d
800010cc:	0047a783          	lw	a5,4(a5) # 8000d004 <memend+0xf800d004>
800010d0:	00078663          	beqz	a5,800010dc <trapvec+0x1d4>
800010d4:	d05ff0ef          	jal	ra,80000dd8 <usertrapret>
            break;
800010d8:	0940006f          	j	8000116c <trapvec+0x264>
            first ? usertrapret() : startproc();
800010dc:	dbdff0ef          	jal	ra,80000e98 <startproc>
            break;
800010e0:	08c0006f          	j	8000116c <trapvec+0x264>
            printf("Instruction page fault\n");
800010e4:	8000c7b7          	lui	a5,0x8000c
800010e8:	2dc78513          	addi	a0,a5,732 # 8000c2dc <memend+0xf800c2dc>
800010ec:	0d8000ef          	jal	ra,800011c4 <printf>
            printf("stval va: %p\n", r_stval());
800010f0:	9e1ff0ef          	jal	ra,80000ad0 <r_stval>
800010f4:	00050793          	mv	a5,a0
800010f8:	00078593          	mv	a1,a5
800010fc:	8000c7b7          	lui	a5,0x8000c
80001100:	25478513          	addi	a0,a5,596 # 8000c254 <memend+0xf800c254>
80001104:	0c0000ef          	jal	ra,800011c4 <printf>
            break;
80001108:	0640006f          	j	8000116c <trapvec+0x264>
            printf("Load page fault\n");
8000110c:	8000c7b7          	lui	a5,0x8000c
80001110:	2f478513          	addi	a0,a5,756 # 8000c2f4 <memend+0xf800c2f4>
80001114:	0b0000ef          	jal	ra,800011c4 <printf>
            printf("stval va: %p\n", r_stval());
80001118:	9b9ff0ef          	jal	ra,80000ad0 <r_stval>
8000111c:	00050793          	mv	a5,a0
80001120:	00078593          	mv	a1,a5
80001124:	8000c7b7          	lui	a5,0x8000c
80001128:	25478513          	addi	a0,a5,596 # 8000c254 <memend+0xf800c254>
8000112c:	098000ef          	jal	ra,800011c4 <printf>
            break;
80001130:	03c0006f          	j	8000116c <trapvec+0x264>
            printf("Store/AMO page fault\n");
80001134:	8000c7b7          	lui	a5,0x8000c
80001138:	30878513          	addi	a0,a5,776 # 8000c308 <memend+0xf800c308>
8000113c:	088000ef          	jal	ra,800011c4 <printf>
            printf("stval va: %p\n", r_stval());
80001140:	991ff0ef          	jal	ra,80000ad0 <r_stval>
80001144:	00050793          	mv	a5,a0
80001148:	00078593          	mv	a1,a5
8000114c:	8000c7b7          	lui	a5,0x8000c
80001150:	25478513          	addi	a0,a5,596 # 8000c254 <memend+0xf800c254>
80001154:	070000ef          	jal	ra,800011c4 <printf>
            break;
80001158:	0140006f          	j	8000116c <trapvec+0x264>
            printf("Other\n");
8000115c:	8000c7b7          	lui	a5,0x8000c
80001160:	32078513          	addi	a0,a5,800 # 8000c320 <memend+0xf800c320>
80001164:	060000ef          	jal	ra,800011c4 <printf>
            break;
80001168:	00000013          	nop
        panic("Trap Exception");
8000116c:	8000c7b7          	lui	a5,0x8000c
80001170:	32878513          	addi	a0,a5,808 # 8000c328 <memend+0xf800c328>
80001174:	018000ef          	jal	ra,8000118c <panic>
}
80001178:	00000013          	nop
8000117c:	01c12083          	lw	ra,28(sp)
80001180:	01812403          	lw	s0,24(sp)
80001184:	02010113          	addi	sp,sp,32
80001188:	00008067          	ret

8000118c <panic>:
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char *s)
{
8000118c:	fe010113          	addi	sp,sp,-32
80001190:	00112e23          	sw	ra,28(sp)
80001194:	00812c23          	sw	s0,24(sp)
80001198:	02010413          	addi	s0,sp,32
8000119c:	fea42623          	sw	a0,-20(s0)
	uartputs("panic: ");
800011a0:	8000c7b7          	lui	a5,0x8000c
800011a4:	37878513          	addi	a0,a5,888 # 8000c378 <memend+0xf800c378>
800011a8:	e98ff0ef          	jal	ra,80000840 <uartputs>
	uartputs(s);
800011ac:	fec42503          	lw	a0,-20(s0)
800011b0:	e90ff0ef          	jal	ra,80000840 <uartputs>
	uartputs("\n");
800011b4:	8000c7b7          	lui	a5,0x8000c
800011b8:	38078513          	addi	a0,a5,896 # 8000c380 <memend+0xf800c380>
800011bc:	e84ff0ef          	jal	ra,80000840 <uartputs>
	while (1)
800011c0:	0000006f          	j	800011c0 <panic+0x34>

800011c4 <printf>:

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char *fmt, ...)
{
800011c4:	f8010113          	addi	sp,sp,-128
800011c8:	04112e23          	sw	ra,92(sp)
800011cc:	04812c23          	sw	s0,88(sp)
800011d0:	06010413          	addi	s0,sp,96
800011d4:	faa42623          	sw	a0,-84(s0)
800011d8:	00b42223          	sw	a1,4(s0)
800011dc:	00c42423          	sw	a2,8(s0)
800011e0:	00d42623          	sw	a3,12(s0)
800011e4:	00e42823          	sw	a4,16(s0)
800011e8:	00f42a23          	sw	a5,20(s0)
800011ec:	01042c23          	sw	a6,24(s0)
800011f0:	01142e23          	sw	a7,28(s0)
	va_list vl;		   // 保存参数的地址，定义在stdarg.h
	va_start(vl, fmt); // 将vl指向fmt后面的参数
800011f4:	02040793          	addi	a5,s0,32
800011f8:	faf42423          	sw	a5,-88(s0)
800011fc:	fa842783          	lw	a5,-88(s0)
80001200:	fe478793          	addi	a5,a5,-28
80001204:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char *s = fmt;
80001208:	fac42783          	lw	a5,-84(s0)
8000120c:	fef42623          	sw	a5,-20(s0)
	int tt = 0;
80001210:	fe042423          	sw	zero,-24(s0)
	int idx = 0;
80001214:	fe042223          	sw	zero,-28(s0)
	while ((ch = *(s)))
80001218:	36c0006f          	j	80001584 <printf+0x3c0>
	{
		if (ch == '%')
8000121c:	fbf44703          	lbu	a4,-65(s0)
80001220:	02500793          	li	a5,37
80001224:	04f71863          	bne	a4,a5,80001274 <printf+0xb0>
		{
			if (tt == 1)
80001228:	fe842703          	lw	a4,-24(s0)
8000122c:	00100793          	li	a5,1
80001230:	02f71663          	bne	a4,a5,8000125c <printf+0x98>
			{
				outbuf[idx++] = '%';
80001234:	fe442783          	lw	a5,-28(s0)
80001238:	00178713          	addi	a4,a5,1
8000123c:	fee42223          	sw	a4,-28(s0)
80001240:	8000d737          	lui	a4,0x8000d
80001244:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001248:	00f707b3          	add	a5,a4,a5
8000124c:	02500713          	li	a4,37
80001250:	00e78023          	sb	a4,0(a5)
				tt = 0;
80001254:	fe042423          	sw	zero,-24(s0)
80001258:	00c0006f          	j	80001264 <printf+0xa0>
			}
			else
			{
				tt = 1;
8000125c:	00100793          	li	a5,1
80001260:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80001264:	fec42783          	lw	a5,-20(s0)
80001268:	00178793          	addi	a5,a5,1
8000126c:	fef42623          	sw	a5,-20(s0)
80001270:	3140006f          	j	80001584 <printf+0x3c0>
		}
		else
		{
			if (tt == 1)
80001274:	fe842703          	lw	a4,-24(s0)
80001278:	00100793          	li	a5,1
8000127c:	2cf71e63          	bne	a4,a5,80001558 <printf+0x394>
			{
				switch (ch)
80001280:	fbf44783          	lbu	a5,-65(s0)
80001284:	fa878793          	addi	a5,a5,-88
80001288:	02000713          	li	a4,32
8000128c:	2af76663          	bltu	a4,a5,80001538 <printf+0x374>
80001290:	00279713          	slli	a4,a5,0x2
80001294:	8000c7b7          	lui	a5,0x8000c
80001298:	39c78793          	addi	a5,a5,924 # 8000c39c <memend+0xf800c39c>
8000129c:	00f707b3          	add	a5,a4,a5
800012a0:	0007a783          	lw	a5,0(a5)
800012a4:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x = va_arg(vl, int);
800012a8:	fb842783          	lw	a5,-72(s0)
800012ac:	00478713          	addi	a4,a5,4
800012b0:	fae42c23          	sw	a4,-72(s0)
800012b4:	0007a783          	lw	a5,0(a5)
800012b8:	fef42023          	sw	a5,-32(s0)
					int len = 0;
800012bc:	fc042e23          	sw	zero,-36(s0)
					for (int n = x; n /= 10; len++)
800012c0:	fe042783          	lw	a5,-32(s0)
800012c4:	fcf42c23          	sw	a5,-40(s0)
800012c8:	0100006f          	j	800012d8 <printf+0x114>
800012cc:	fdc42783          	lw	a5,-36(s0)
800012d0:	00178793          	addi	a5,a5,1
800012d4:	fcf42e23          	sw	a5,-36(s0)
800012d8:	fd842703          	lw	a4,-40(s0)
800012dc:	00a00793          	li	a5,10
800012e0:	02f747b3          	div	a5,a4,a5
800012e4:	fcf42c23          	sw	a5,-40(s0)
800012e8:	fd842783          	lw	a5,-40(s0)
800012ec:	fe0790e3          	bnez	a5,800012cc <printf+0x108>
						;
					for (int i = len; i >= 0; i--)
800012f0:	fdc42783          	lw	a5,-36(s0)
800012f4:	fcf42a23          	sw	a5,-44(s0)
800012f8:	0540006f          	j	8000134c <printf+0x188>
					{
						outbuf[idx + i] = '0' + (x % 10);
800012fc:	fe042703          	lw	a4,-32(s0)
80001300:	00a00793          	li	a5,10
80001304:	02f767b3          	rem	a5,a4,a5
80001308:	0ff7f713          	andi	a4,a5,255
8000130c:	fe442683          	lw	a3,-28(s0)
80001310:	fd442783          	lw	a5,-44(s0)
80001314:	00f687b3          	add	a5,a3,a5
80001318:	03070713          	addi	a4,a4,48
8000131c:	0ff77713          	andi	a4,a4,255
80001320:	8000d6b7          	lui	a3,0x8000d
80001324:	00868693          	addi	a3,a3,8 # 8000d008 <memend+0xf800d008>
80001328:	00f687b3          	add	a5,a3,a5
8000132c:	00e78023          	sb	a4,0(a5)
						x /= 10;
80001330:	fe042703          	lw	a4,-32(s0)
80001334:	00a00793          	li	a5,10
80001338:	02f747b3          	div	a5,a4,a5
8000133c:	fef42023          	sw	a5,-32(s0)
					for (int i = len; i >= 0; i--)
80001340:	fd442783          	lw	a5,-44(s0)
80001344:	fff78793          	addi	a5,a5,-1
80001348:	fcf42a23          	sw	a5,-44(s0)
8000134c:	fd442783          	lw	a5,-44(s0)
80001350:	fa07d6e3          	bgez	a5,800012fc <printf+0x138>
					}
					idx += (len + 1);
80001354:	fdc42783          	lw	a5,-36(s0)
80001358:	00178793          	addi	a5,a5,1
8000135c:	fe442703          	lw	a4,-28(s0)
80001360:	00f707b3          	add	a5,a4,a5
80001364:	fef42223          	sw	a5,-28(s0)
					tt = 0;
80001368:	fe042423          	sw	zero,-24(s0)
					break;
8000136c:	1dc0006f          	j	80001548 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++] = '0';
80001370:	fe442783          	lw	a5,-28(s0)
80001374:	00178713          	addi	a4,a5,1
80001378:	fee42223          	sw	a4,-28(s0)
8000137c:	8000d737          	lui	a4,0x8000d
80001380:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
80001384:	00f707b3          	add	a5,a4,a5
80001388:	03000713          	li	a4,48
8000138c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++] = 'x';
80001390:	fe442783          	lw	a5,-28(s0)
80001394:	00178713          	addi	a4,a5,1
80001398:	fee42223          	sw	a4,-28(s0)
8000139c:	8000d737          	lui	a4,0x8000d
800013a0:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
800013a4:	00f707b3          	add	a5,a4,a5
800013a8:	07800713          	li	a4,120
800013ac:	00e78023          	sb	a4,0(a5)
				} // 接着下面输出16进制数
				case 'x':
				case 'X': // 大小写一致
				{
					uint x = va_arg(vl, uint);
800013b0:	fb842783          	lw	a5,-72(s0)
800013b4:	00478713          	addi	a4,a5,4
800013b8:	fae42c23          	sw	a4,-72(s0)
800013bc:	0007a783          	lw	a5,0(a5)
800013c0:	fcf42823          	sw	a5,-48(s0)
					int len = 0;
800013c4:	fc042623          	sw	zero,-52(s0)
					for (unsigned int n = x; n /= 16; len++)
800013c8:	fd042783          	lw	a5,-48(s0)
800013cc:	fcf42423          	sw	a5,-56(s0)
800013d0:	0100006f          	j	800013e0 <printf+0x21c>
800013d4:	fcc42783          	lw	a5,-52(s0)
800013d8:	00178793          	addi	a5,a5,1
800013dc:	fcf42623          	sw	a5,-52(s0)
800013e0:	fc842783          	lw	a5,-56(s0)
800013e4:	0047d793          	srli	a5,a5,0x4
800013e8:	fcf42423          	sw	a5,-56(s0)
800013ec:	fc842783          	lw	a5,-56(s0)
800013f0:	fe0792e3          	bnez	a5,800013d4 <printf+0x210>
						;
					for (int i = len; i >= 0; i--)
800013f4:	fcc42783          	lw	a5,-52(s0)
800013f8:	fcf42223          	sw	a5,-60(s0)
800013fc:	0840006f          	j	80001480 <printf+0x2bc>
					{
						char c = (x % 16) >= 10 ? 'a' + ((x % 16) - 10) : '0' + (x % 16);
80001400:	fd042783          	lw	a5,-48(s0)
80001404:	00f7f713          	andi	a4,a5,15
80001408:	00900793          	li	a5,9
8000140c:	02e7f063          	bgeu	a5,a4,8000142c <printf+0x268>
80001410:	fd042783          	lw	a5,-48(s0)
80001414:	0ff7f793          	andi	a5,a5,255
80001418:	00f7f793          	andi	a5,a5,15
8000141c:	0ff7f793          	andi	a5,a5,255
80001420:	05778793          	addi	a5,a5,87
80001424:	0ff7f793          	andi	a5,a5,255
80001428:	01c0006f          	j	80001444 <printf+0x280>
8000142c:	fd042783          	lw	a5,-48(s0)
80001430:	0ff7f793          	andi	a5,a5,255
80001434:	00f7f793          	andi	a5,a5,15
80001438:	0ff7f793          	andi	a5,a5,255
8000143c:	03078793          	addi	a5,a5,48
80001440:	0ff7f793          	andi	a5,a5,255
80001444:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx + i] = c;
80001448:	fe442703          	lw	a4,-28(s0)
8000144c:	fc442783          	lw	a5,-60(s0)
80001450:	00f707b3          	add	a5,a4,a5
80001454:	8000d737          	lui	a4,0x8000d
80001458:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
8000145c:	00f707b3          	add	a5,a4,a5
80001460:	fbe44703          	lbu	a4,-66(s0)
80001464:	00e78023          	sb	a4,0(a5)
						x /= 16;
80001468:	fd042783          	lw	a5,-48(s0)
8000146c:	0047d793          	srli	a5,a5,0x4
80001470:	fcf42823          	sw	a5,-48(s0)
					for (int i = len; i >= 0; i--)
80001474:	fc442783          	lw	a5,-60(s0)
80001478:	fff78793          	addi	a5,a5,-1
8000147c:	fcf42223          	sw	a5,-60(s0)
80001480:	fc442783          	lw	a5,-60(s0)
80001484:	f607dee3          	bgez	a5,80001400 <printf+0x23c>
					}
					idx += (len + 1);
80001488:	fcc42783          	lw	a5,-52(s0)
8000148c:	00178793          	addi	a5,a5,1
80001490:	fe442703          	lw	a4,-28(s0)
80001494:	00f707b3          	add	a5,a4,a5
80001498:	fef42223          	sw	a5,-28(s0)
					tt = 0;
8000149c:	fe042423          	sw	zero,-24(s0)
					break;
800014a0:	0a80006f          	j	80001548 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch = va_arg(vl, int);
800014a4:	fb842783          	lw	a5,-72(s0)
800014a8:	00478713          	addi	a4,a5,4
800014ac:	fae42c23          	sw	a4,-72(s0)
800014b0:	0007a783          	lw	a5,0(a5)
800014b4:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++] = ch;
800014b8:	fe442783          	lw	a5,-28(s0)
800014bc:	00178713          	addi	a4,a5,1
800014c0:	fee42223          	sw	a4,-28(s0)
800014c4:	8000d737          	lui	a4,0x8000d
800014c8:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
800014cc:	00f707b3          	add	a5,a4,a5
800014d0:	fbf44703          	lbu	a4,-65(s0)
800014d4:	00e78023          	sb	a4,0(a5)
					tt = 0;
800014d8:	fe042423          	sw	zero,-24(s0)
					break;
800014dc:	06c0006f          	j	80001548 <printf+0x384>
				case 's':
				{
					char *ss = va_arg(vl, char *);
800014e0:	fb842783          	lw	a5,-72(s0)
800014e4:	00478713          	addi	a4,a5,4
800014e8:	fae42c23          	sw	a4,-72(s0)
800014ec:	0007a783          	lw	a5,0(a5)
800014f0:	fcf42023          	sw	a5,-64(s0)
					while (*ss)
800014f4:	0300006f          	j	80001524 <printf+0x360>
					{
						outbuf[idx++] = *ss++;
800014f8:	fc042703          	lw	a4,-64(s0)
800014fc:	00170793          	addi	a5,a4,1
80001500:	fcf42023          	sw	a5,-64(s0)
80001504:	fe442783          	lw	a5,-28(s0)
80001508:	00178693          	addi	a3,a5,1
8000150c:	fed42223          	sw	a3,-28(s0)
80001510:	00074703          	lbu	a4,0(a4)
80001514:	8000d6b7          	lui	a3,0x8000d
80001518:	00868693          	addi	a3,a3,8 # 8000d008 <memend+0xf800d008>
8000151c:	00f687b3          	add	a5,a3,a5
80001520:	00e78023          	sb	a4,0(a5)
					while (*ss)
80001524:	fc042783          	lw	a5,-64(s0)
80001528:	0007c783          	lbu	a5,0(a5)
8000152c:	fc0796e3          	bnez	a5,800014f8 <printf+0x334>
					}
					tt = 0;
80001530:	fe042423          	sw	zero,-24(s0)
					break;
80001534:	0140006f          	j	80001548 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80001538:	8000c7b7          	lui	a5,0x8000c
8000153c:	38478513          	addi	a0,a5,900 # 8000c384 <memend+0xf800c384>
80001540:	c4dff0ef          	jal	ra,8000118c <panic>
					break;
80001544:	00000013          	nop
				}
				s++;
80001548:	fec42783          	lw	a5,-20(s0)
8000154c:	00178793          	addi	a5,a5,1
80001550:	fef42623          	sw	a5,-20(s0)
80001554:	0300006f          	j	80001584 <printf+0x3c0>
			}
			else
			{
				outbuf[idx++] = ch;
80001558:	fe442783          	lw	a5,-28(s0)
8000155c:	00178713          	addi	a4,a5,1
80001560:	fee42223          	sw	a4,-28(s0)
80001564:	8000d737          	lui	a4,0x8000d
80001568:	00870713          	addi	a4,a4,8 # 8000d008 <memend+0xf800d008>
8000156c:	00f707b3          	add	a5,a4,a5
80001570:	fbf44703          	lbu	a4,-65(s0)
80001574:	00e78023          	sb	a4,0(a5)
				s++;
80001578:	fec42783          	lw	a5,-20(s0)
8000157c:	00178793          	addi	a5,a5,1
80001580:	fef42623          	sw	a5,-20(s0)
	while ((ch = *(s)))
80001584:	fec42783          	lw	a5,-20(s0)
80001588:	0007c783          	lbu	a5,0(a5)
8000158c:	faf40fa3          	sb	a5,-65(s0)
80001590:	fbf44783          	lbu	a5,-65(s0)
80001594:	c80794e3          	bnez	a5,8000121c <printf+0x58>
			}
		}
	}
	va_end(vl); // 释法参数
	outbuf[idx] = '\0';
80001598:	8000d7b7          	lui	a5,0x8000d
8000159c:	00878713          	addi	a4,a5,8 # 8000d008 <memend+0xf800d008>
800015a0:	fe442783          	lw	a5,-28(s0)
800015a4:	00f707b3          	add	a5,a4,a5
800015a8:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
800015ac:	8000d7b7          	lui	a5,0x8000d
800015b0:	00878513          	addi	a0,a5,8 # 8000d008 <memend+0xf800d008>
800015b4:	a8cff0ef          	jal	ra,80000840 <uartputs>
	return idx;
800015b8:	fe442783          	lw	a5,-28(s0)
800015bc:	00078513          	mv	a0,a5
800015c0:	05c12083          	lw	ra,92(sp)
800015c4:	05812403          	lw	s0,88(sp)
800015c8:	08010113          	addi	sp,sp,128
800015cc:	00008067          	ret

800015d0 <minit>:
{
    struct pmp *freelist;
} mem;

void minit()
{
800015d0:	fe010113          	addi	sp,sp,-32
800015d4:	00812e23          	sw	s0,28(sp)
800015d8:	02010413          	addi	s0,sp,32
    printf("mstart:%p   ", mstart);
    printf("mend:%p\n", mend);
    printf("stack:%p\n", stacks);
#endif

    char *p = (char *)mstart;
800015dc:	8000e7b7          	lui	a5,0x8000e
800015e0:	00078793          	mv	a5,a5
800015e4:	fef42623          	sw	a5,-20(s0)
    struct pmp *m;
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
800015e8:	0380006f          	j	80001620 <minit+0x50>
    {
        m = (struct pmp *)p;
800015ec:	fec42783          	lw	a5,-20(s0)
800015f0:	fef42423          	sw	a5,-24(s0)
        m->next = mem.freelist;
800015f4:	8000e7b7          	lui	a5,0x8000e
800015f8:	a487a703          	lw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
800015fc:	fe842783          	lw	a5,-24(s0)
80001600:	00e7a023          	sw	a4,0(a5)
        mem.freelist = m;
80001604:	8000e7b7          	lui	a5,0x8000e
80001608:	fe842703          	lw	a4,-24(s0)
8000160c:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
80001610:	fec42703          	lw	a4,-20(s0)
80001614:	000017b7          	lui	a5,0x1
80001618:	00f707b3          	add	a5,a4,a5
8000161c:	fef42623          	sw	a5,-20(s0)
80001620:	fec42703          	lw	a4,-20(s0)
80001624:	000017b7          	lui	a5,0x1
80001628:	00f70733          	add	a4,a4,a5
8000162c:	880007b7          	lui	a5,0x88000
80001630:	00078793          	mv	a5,a5
80001634:	fae7fce3          	bgeu	a5,a4,800015ec <minit+0x1c>
    }
}
80001638:	00000013          	nop
8000163c:	00000013          	nop
80001640:	01c12403          	lw	s0,28(sp)
80001644:	02010113          	addi	sp,sp,32
80001648:	00008067          	ret

8000164c <palloc>:

void *palloc()
{
8000164c:	fe010113          	addi	sp,sp,-32
80001650:	00112e23          	sw	ra,28(sp)
80001654:	00812c23          	sw	s0,24(sp)
80001658:	02010413          	addi	s0,sp,32
    struct pmp *p = (struct pmp *)mem.freelist;
8000165c:	8000e7b7          	lui	a5,0x8000e
80001660:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001664:	fef42623          	sw	a5,-20(s0)
    if (p)
80001668:	fec42783          	lw	a5,-20(s0)
8000166c:	00078c63          	beqz	a5,80001684 <palloc+0x38>
        mem.freelist = mem.freelist->next;
80001670:	8000e7b7          	lui	a5,0x8000e
80001674:	a487a783          	lw	a5,-1464(a5) # 8000da48 <memend+0xf800da48>
80001678:	0007a703          	lw	a4,0(a5)
8000167c:	8000e7b7          	lui	a5,0x8000e
80001680:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
    if (p)
80001684:	fec42783          	lw	a5,-20(s0)
80001688:	00078a63          	beqz	a5,8000169c <palloc+0x50>
        memset(p, 0, PGSIZE);
8000168c:	00001637          	lui	a2,0x1
80001690:	00000593          	li	a1,0
80001694:	fec42503          	lw	a0,-20(s0)
80001698:	609000ef          	jal	ra,800024a0 <memset>
    return (void *)p;
8000169c:	fec42783          	lw	a5,-20(s0)
}
800016a0:	00078513          	mv	a0,a5
800016a4:	01c12083          	lw	ra,28(sp)
800016a8:	01812403          	lw	s0,24(sp)
800016ac:	02010113          	addi	sp,sp,32
800016b0:	00008067          	ret

800016b4 <pfree>:

void pfree(void *addr)
{
800016b4:	fd010113          	addi	sp,sp,-48
800016b8:	02812623          	sw	s0,44(sp)
800016bc:	03010413          	addi	s0,sp,48
800016c0:	fca42e23          	sw	a0,-36(s0)
    struct pmp *p = (struct pmp *)addr;
800016c4:	fdc42783          	lw	a5,-36(s0)
800016c8:	fef42623          	sw	a5,-20(s0)
    p->next = mem.freelist;
800016cc:	8000e7b7          	lui	a5,0x8000e
800016d0:	a487a703          	lw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
800016d4:	fec42783          	lw	a5,-20(s0)
800016d8:	00e7a023          	sw	a4,0(a5)
    mem.freelist = p;
800016dc:	8000e7b7          	lui	a5,0x8000e
800016e0:	fec42703          	lw	a4,-20(s0)
800016e4:	a4e7a423          	sw	a4,-1464(a5) # 8000da48 <memend+0xf800da48>
800016e8:	00000013          	nop
800016ec:	02c12403          	lw	s0,44(sp)
800016f0:	03010113          	addi	sp,sp,48
800016f4:	00008067          	ret

800016f8 <r_tp>:
{
800016f8:	fe010113          	addi	sp,sp,-32
800016fc:	00812e23          	sw	s0,28(sp)
80001700:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80001704:	00020793          	mv	a5,tp
80001708:	fef42623          	sw	a5,-20(s0)
    return x;
8000170c:	fec42783          	lw	a5,-20(s0)
}
80001710:	00078513          	mv	a0,a5
80001714:	01c12403          	lw	s0,28(sp)
80001718:	02010113          	addi	sp,sp,32
8000171c:	00008067          	ret

80001720 <r_sie>:
 */
#define SEIE (1 << 9)
#define STIE (1 << 5)
#define SSIE (1 << 1)
static inline uint32 r_sie()
{
80001720:	fe010113          	addi	sp,sp,-32
80001724:	00812e23          	sw	s0,28(sp)
80001728:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie "
8000172c:	104027f3          	csrr	a5,sie
80001730:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80001734:	fec42783          	lw	a5,-20(s0)
}
80001738:	00078513          	mv	a0,a5
8000173c:	01c12403          	lw	s0,28(sp)
80001740:	02010113          	addi	sp,sp,32
80001744:	00008067          	ret

80001748 <w_sie>:
static inline void w_sie(uint32 x)
{
80001748:	fe010113          	addi	sp,sp,-32
8000174c:	00812e23          	sw	s0,28(sp)
80001750:	02010413          	addi	s0,sp,32
80001754:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"
80001758:	fec42783          	lw	a5,-20(s0)
8000175c:	10479073          	csrw	sie,a5
                 :
                 : "r"(x));
}
80001760:	00000013          	nop
80001764:	01c12403          	lw	s0,28(sp)
80001768:	02010113          	addi	sp,sp,32
8000176c:	00008067          	ret

80001770 <plicinit>:
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit()
{
80001770:	ff010113          	addi	sp,sp,-16
80001774:	00112623          	sw	ra,12(sp)
80001778:	00812423          	sw	s0,8(sp)
8000177c:	01010413          	addi	s0,sp,16
    *(uint32 *)PLIC_PRIORITY(UART_IRQ) = 1; // uart 设置优先级(1~7)，0为关中断
80001780:	0c0007b7          	lui	a5,0xc000
80001784:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001788:	00100713          	li	a4,1
8000178c:	00e7a023          	sw	a4,0(a5)

    *(uint32 *)PLIC_SENABLE(r_tp()) = (1 << UART_IRQ); // uart 开中断
80001790:	f69ff0ef          	jal	ra,800016f8 <r_tp>
80001794:	00050793          	mv	a5,a0
80001798:	00879713          	slli	a4,a5,0x8
8000179c:	0c0027b7          	lui	a5,0xc002
800017a0:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
800017a4:	00f707b3          	add	a5,a4,a5
800017a8:	00078713          	mv	a4,a5
800017ac:	40000793          	li	a5,1024
800017b0:	00f72023          	sw	a5,0(a4)
    *(uint32 *)PLIC_MENABLE(r_tp()) = (1 << UART_IRQ); // uart 开中断
800017b4:	f45ff0ef          	jal	ra,800016f8 <r_tp>
800017b8:	00050713          	mv	a4,a0
800017bc:	000c07b7          	lui	a5,0xc0
800017c0:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800017c4:	00f707b3          	add	a5,a4,a5
800017c8:	00879793          	slli	a5,a5,0x8
800017cc:	00078713          	mv	a4,a5
800017d0:	40000793          	li	a5,1024
800017d4:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32 *)PLIC_MPRIORITY(r_tp()) = 0;
800017d8:	f21ff0ef          	jal	ra,800016f8 <r_tp>
800017dc:	00050713          	mv	a4,a0
800017e0:	000067b7          	lui	a5,0x6
800017e4:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800017e8:	00f707b3          	add	a5,a4,a5
800017ec:	00d79793          	slli	a5,a5,0xd
800017f0:	0007a023          	sw	zero,0(a5)
    *(uint32 *)PLIC_SPRIORITY(r_tp()) = 0;
800017f4:	f05ff0ef          	jal	ra,800016f8 <r_tp>
800017f8:	00050793          	mv	a5,a0
800017fc:	00d79713          	slli	a4,a5,0xd
80001800:	0c2017b7          	lui	a5,0xc201
80001804:	00f707b3          	add	a5,a4,a5
80001808:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开S-mode中断
8000180c:	f15ff0ef          	jal	ra,80001720 <r_sie>
80001810:	00050793          	mv	a5,a0
80001814:	2227e793          	ori	a5,a5,546
80001818:	00078513          	mv	a0,a5
8000181c:	f2dff0ef          	jal	ra,80001748 <w_sie>
}
80001820:	00000013          	nop
80001824:	00c12083          	lw	ra,12(sp)
80001828:	00812403          	lw	s0,8(sp)
8000182c:	01010113          	addi	sp,sp,16
80001830:	00008067          	ret

80001834 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim()
{
80001834:	ff010113          	addi	sp,sp,-16
80001838:	00112623          	sw	ra,12(sp)
8000183c:	00812423          	sw	s0,8(sp)
80001840:	01010413          	addi	s0,sp,16
    return *(uint32 *)PLIC_SCLAIM(r_tp());
80001844:	eb5ff0ef          	jal	ra,800016f8 <r_tp>
80001848:	00050793          	mv	a5,a0
8000184c:	00d79713          	slli	a4,a5,0xd
80001850:	0c2017b7          	lui	a5,0xc201
80001854:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001858:	00f707b3          	add	a5,a4,a5
8000185c:	0007a783          	lw	a5,0(a5)
}
80001860:	00078513          	mv	a0,a5
80001864:	00c12083          	lw	ra,12(sp)
80001868:	00812403          	lw	s0,8(sp)
8000186c:	01010113          	addi	sp,sp,16
80001870:	00008067          	ret

80001874 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq)
{
80001874:	fe010113          	addi	sp,sp,-32
80001878:	00112e23          	sw	ra,28(sp)
8000187c:	00812c23          	sw	s0,24(sp)
80001880:	02010413          	addi	s0,sp,32
80001884:	fea42623          	sw	a0,-20(s0)
    *(uint32 *)PLIC_MCOMPLETE(r_tp()) = irq;
80001888:	e71ff0ef          	jal	ra,800016f8 <r_tp>
8000188c:	00050793          	mv	a5,a0
80001890:	00d79713          	slli	a4,a5,0xd
80001894:	0c2007b7          	lui	a5,0xc200
80001898:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
8000189c:	00f707b3          	add	a5,a4,a5
800018a0:	00078713          	mv	a4,a5
800018a4:	fec42783          	lw	a5,-20(s0)
800018a8:	00f72023          	sw	a5,0(a4)
800018ac:	00000013          	nop
800018b0:	01c12083          	lw	ra,28(sp)
800018b4:	01812403          	lw	s0,24(sp)
800018b8:	02010113          	addi	sp,sp,32
800018bc:	00008067          	ret

800018c0 <w_satp>:
{
800018c0:	fe010113          	addi	sp,sp,-32
800018c4:	00812e23          	sw	s0,28(sp)
800018c8:	02010413          	addi	s0,sp,32
800018cc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"
800018d0:	fec42783          	lw	a5,-20(s0)
800018d4:	18079073          	csrw	satp,a5
}
800018d8:	00000013          	nop
800018dc:	01c12403          	lw	s0,28(sp)
800018e0:	02010113          	addi	sp,sp,32
800018e4:	00008067          	ret

800018e8 <sfence_vma>:
{
800018e8:	ff010113          	addi	sp,sp,-16
800018ec:	00812623          	sw	s0,12(sp)
800018f0:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800018f4:	12000073          	sfence.vma
}
800018f8:	00000013          	nop
800018fc:	00c12403          	lw	s0,12(sp)
80001900:	01010113          	addi	sp,sp,16
80001904:	00008067          	ret

80001908 <acquriepte>:
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t *acquriepte(addr_t *pgt, addr_t va)
{
80001908:	fd010113          	addi	sp,sp,-48
8000190c:	02112623          	sw	ra,44(sp)
80001910:	02812423          	sw	s0,40(sp)
80001914:	03010413          	addi	s0,sp,48
80001918:	fca42e23          	sw	a0,-36(s0)
8000191c:	fcb42c23          	sw	a1,-40(s0)
    pte_t *pte;
    pte = &pgt[VPN(1, va)]; // 获取一级页表 PTE
80001920:	fd842783          	lw	a5,-40(s0)
80001924:	0167d793          	srli	a5,a5,0x16
80001928:	00279793          	slli	a5,a5,0x2
8000192c:	fdc42703          	lw	a4,-36(s0)
80001930:	00f707b3          	add	a5,a4,a5
80001934:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if (*pte & PTE_V)
80001938:	fec42783          	lw	a5,-20(s0)
8000193c:	0007a783          	lw	a5,0(a5)
80001940:	0017f793          	andi	a5,a5,1
80001944:	00078e63          	beqz	a5,80001960 <acquriepte+0x58>
    { // 已分配页
        pgt = (addr_t *)PTE2PA(*pte);
80001948:	fec42783          	lw	a5,-20(s0)
8000194c:	0007a783          	lw	a5,0(a5)
80001950:	00a7d793          	srli	a5,a5,0xa
80001954:	00c79793          	slli	a5,a5,0xc
80001958:	fcf42e23          	sw	a5,-36(s0)
8000195c:	0340006f          	j	80001990 <acquriepte+0x88>
    }
    else
    {                             // 未分配页
        pgt = (addr_t *)palloc(); // 二级页表
80001960:	cedff0ef          	jal	ra,8000164c <palloc>
80001964:	fca42e23          	sw	a0,-36(s0)
        memset(pgt, 0, PGSIZE);
80001968:	00001637          	lui	a2,0x1
8000196c:	00000593          	li	a1,0
80001970:	fdc42503          	lw	a0,-36(s0)
80001974:	32d000ef          	jal	ra,800024a0 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001978:	fdc42783          	lw	a5,-36(s0)
8000197c:	00c7d793          	srli	a5,a5,0xc
80001980:	00a79793          	slli	a5,a5,0xa
80001984:	0017e713          	ori	a4,a5,1
80001988:	fec42783          	lw	a5,-20(s0)
8000198c:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0, va)]; // 返回二级页表 PTE
80001990:	fd842783          	lw	a5,-40(s0)
80001994:	00c7d793          	srli	a5,a5,0xc
80001998:	3ff7f793          	andi	a5,a5,1023
8000199c:	00279793          	slli	a5,a5,0x2
800019a0:	fdc42703          	lw	a4,-36(s0)
800019a4:	00f707b3          	add	a5,a4,a5
}
800019a8:	00078513          	mv	a0,a5
800019ac:	02c12083          	lw	ra,44(sp)
800019b0:	02812403          	lw	s0,40(sp)
800019b4:	03010113          	addi	sp,sp,48
800019b8:	00008067          	ret

800019bc <vmmap>:
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t *pgt, addr_t va, addr_t pa, uint size, uint mode)
{
800019bc:	fc010113          	addi	sp,sp,-64
800019c0:	02112e23          	sw	ra,60(sp)
800019c4:	02812c23          	sw	s0,56(sp)
800019c8:	04010413          	addi	s0,sp,64
800019cc:	fca42e23          	sw	a0,-36(s0)
800019d0:	fcb42c23          	sw	a1,-40(s0)
800019d4:	fcc42a23          	sw	a2,-44(s0)
800019d8:	fcd42823          	sw	a3,-48(s0)
800019dc:	fce42623          	sw	a4,-52(s0)
    pte_t *pte;

    // PPN
    addr_t start = ((va >> 12) << 12);
800019e0:	fd842703          	lw	a4,-40(s0)
800019e4:	fffff7b7          	lui	a5,0xfffff
800019e8:	00f777b3          	and	a5,a4,a5
800019ec:	fef42623          	sw	a5,-20(s0)
    addr_t end = (((va + (size - 1)) >> 12) << 12);
800019f0:	fd042703          	lw	a4,-48(s0)
800019f4:	fd842783          	lw	a5,-40(s0)
800019f8:	00f707b3          	add	a5,a4,a5
800019fc:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
80001a00:	fffff7b7          	lui	a5,0xfffff
80001a04:	00f777b3          	and	a5,a4,a5
80001a08:	fef42423          	sw	a5,-24(s0)

    while (1)
    {
        pte = acquriepte(pgt, start);
80001a0c:	fec42583          	lw	a1,-20(s0)
80001a10:	fdc42503          	lw	a0,-36(s0)
80001a14:	ef5ff0ef          	jal	ra,80001908 <acquriepte>
80001a18:	fea42223          	sw	a0,-28(s0)
        if (*pte & PTE_V)
80001a1c:	fe442783          	lw	a5,-28(s0)
80001a20:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001a24:	0017f793          	andi	a5,a5,1
80001a28:	00078863          	beqz	a5,80001a38 <vmmap+0x7c>
            panic("repeat map");
80001a2c:	8000c7b7          	lui	a5,0x8000c
80001a30:	42078513          	addi	a0,a5,1056 # 8000c420 <memend+0xf800c420>
80001a34:	f58ff0ef          	jal	ra,8000118c <panic>
        *pte = PA2PTE(pa) | mode | PTE_V;
80001a38:	fd442783          	lw	a5,-44(s0)
80001a3c:	00c7d793          	srli	a5,a5,0xc
80001a40:	00a79713          	slli	a4,a5,0xa
80001a44:	fcc42783          	lw	a5,-52(s0)
80001a48:	00f767b3          	or	a5,a4,a5
80001a4c:	0017e713          	ori	a4,a5,1
80001a50:	fe442783          	lw	a5,-28(s0)
80001a54:	00e7a023          	sw	a4,0(a5)
        if (start == end)
80001a58:	fec42703          	lw	a4,-20(s0)
80001a5c:	fe842783          	lw	a5,-24(s0)
80001a60:	02f70463          	beq	a4,a5,80001a88 <vmmap+0xcc>
            break;
        start += PGSIZE;
80001a64:	fec42703          	lw	a4,-20(s0)
80001a68:	000017b7          	lui	a5,0x1
80001a6c:	00f707b3          	add	a5,a4,a5
80001a70:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001a74:	fd442703          	lw	a4,-44(s0)
80001a78:	000017b7          	lui	a5,0x1
80001a7c:	00f707b3          	add	a5,a4,a5
80001a80:	fcf42a23          	sw	a5,-44(s0)
        pte = acquriepte(pgt, start);
80001a84:	f89ff06f          	j	80001a0c <vmmap+0x50>
            break;
80001a88:	00000013          	nop
    }
}
80001a8c:	00000013          	nop
80001a90:	03c12083          	lw	ra,60(sp)
80001a94:	03812403          	lw	s0,56(sp)
80001a98:	04010113          	addi	sp,sp,64
80001a9c:	00008067          	ret

80001aa0 <printpgt>:

void printpgt(addr_t *pgt)
{
80001aa0:	fc010113          	addi	sp,sp,-64
80001aa4:	02112e23          	sw	ra,60(sp)
80001aa8:	02812c23          	sw	s0,56(sp)
80001aac:	04010413          	addi	s0,sp,64
80001ab0:	fca42623          	sw	a0,-52(s0)
    for (int i = 0; i < 1024; i++)
80001ab4:	fe042623          	sw	zero,-20(s0)
80001ab8:	0c40006f          	j	80001b7c <printpgt+0xdc>
    {
        pte_t pte = pgt[i];
80001abc:	fec42783          	lw	a5,-20(s0)
80001ac0:	00279793          	slli	a5,a5,0x2
80001ac4:	fcc42703          	lw	a4,-52(s0)
80001ac8:	00f707b3          	add	a5,a4,a5
80001acc:	0007a783          	lw	a5,0(a5) # 1000 <sz>
80001ad0:	fef42223          	sw	a5,-28(s0)
        if (pte & PTE_V)
80001ad4:	fe442783          	lw	a5,-28(s0)
80001ad8:	0017f793          	andi	a5,a5,1
80001adc:	08078a63          	beqz	a5,80001b70 <printpgt+0xd0>
        {
            addr_t *pgt2 = (addr_t *)PTE2PA(pte);
80001ae0:	fe442783          	lw	a5,-28(s0)
80001ae4:	00a7d793          	srli	a5,a5,0xa
80001ae8:	00c79793          	slli	a5,a5,0xc
80001aec:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n", i, pte, pgt2);
80001af0:	fe042683          	lw	a3,-32(s0)
80001af4:	fe442603          	lw	a2,-28(s0)
80001af8:	fec42583          	lw	a1,-20(s0)
80001afc:	8000c7b7          	lui	a5,0x8000c
80001b00:	42c78513          	addi	a0,a5,1068 # 8000c42c <memend+0xf800c42c>
80001b04:	ec0ff0ef          	jal	ra,800011c4 <printf>
            for (int j = 0; j < 1024; j++)
80001b08:	fe042423          	sw	zero,-24(s0)
80001b0c:	0580006f          	j	80001b64 <printpgt+0xc4>
            {
                pte_t pte2 = pgt2[j];
80001b10:	fe842783          	lw	a5,-24(s0)
80001b14:	00279793          	slli	a5,a5,0x2
80001b18:	fe042703          	lw	a4,-32(s0)
80001b1c:	00f707b3          	add	a5,a4,a5
80001b20:	0007a783          	lw	a5,0(a5)
80001b24:	fcf42e23          	sw	a5,-36(s0)
                if (pte2 & PTE_V)
80001b28:	fdc42783          	lw	a5,-36(s0)
80001b2c:	0017f793          	andi	a5,a5,1
80001b30:	02078463          	beqz	a5,80001b58 <printpgt+0xb8>
                {
                    printf(".. ..%d: pte %p pa %p\n", j, pte2, PTE2PA(pte2));
80001b34:	fdc42783          	lw	a5,-36(s0)
80001b38:	00a7d793          	srli	a5,a5,0xa
80001b3c:	00c79793          	slli	a5,a5,0xc
80001b40:	00078693          	mv	a3,a5
80001b44:	fdc42603          	lw	a2,-36(s0)
80001b48:	fe842583          	lw	a1,-24(s0)
80001b4c:	8000c7b7          	lui	a5,0x8000c
80001b50:	44478513          	addi	a0,a5,1092 # 8000c444 <memend+0xf800c444>
80001b54:	e70ff0ef          	jal	ra,800011c4 <printf>
            for (int j = 0; j < 1024; j++)
80001b58:	fe842783          	lw	a5,-24(s0)
80001b5c:	00178793          	addi	a5,a5,1
80001b60:	fef42423          	sw	a5,-24(s0)
80001b64:	fe842703          	lw	a4,-24(s0)
80001b68:	3ff00793          	li	a5,1023
80001b6c:	fae7d2e3          	bge	a5,a4,80001b10 <printpgt+0x70>
    for (int i = 0; i < 1024; i++)
80001b70:	fec42783          	lw	a5,-20(s0)
80001b74:	00178793          	addi	a5,a5,1
80001b78:	fef42623          	sw	a5,-20(s0)
80001b7c:	fec42703          	lw	a4,-20(s0)
80001b80:	3ff00793          	li	a5,1023
80001b84:	f2e7dce3          	bge	a5,a4,80001abc <printpgt+0x1c>
                }
            }
        }
    }
}
80001b88:	00000013          	nop
80001b8c:	00000013          	nop
80001b90:	03c12083          	lw	ra,60(sp)
80001b94:	03812403          	lw	s0,56(sp)
80001b98:	04010113          	addi	sp,sp,64
80001b9c:	00008067          	ret

80001ba0 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t *pgt)
{
80001ba0:	fd010113          	addi	sp,sp,-48
80001ba4:	02112623          	sw	ra,44(sp)
80001ba8:	02812423          	sw	s0,40(sp)
80001bac:	03010413          	addi	s0,sp,48
80001bb0:	fca42e23          	sw	a0,-36(s0)
    for (int i = 0; i < NPROC; i++)
80001bb4:	fe042623          	sw	zero,-20(s0)
80001bb8:	04c0006f          	j	80001c04 <mkstack+0x64>
    {
        addr_t va = (addr_t)(KSPACE + PGSIZE + (i)*2 * PGSIZE);
80001bbc:	fec42783          	lw	a5,-20(s0)
80001bc0:	00d79793          	slli	a5,a5,0xd
80001bc4:	00078713          	mv	a4,a5
80001bc8:	c00017b7          	lui	a5,0xc0001
80001bcc:	00f707b3          	add	a5,a4,a5
80001bd0:	fef42423          	sw	a5,-24(s0)
        addr_t pa = (addr_t)palloc(); //! 待处理
80001bd4:	a79ff0ef          	jal	ra,8000164c <palloc>
80001bd8:	00050793          	mv	a5,a0
80001bdc:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt, va, pa, PGSIZE, PTE_R | PTE_W);
80001be0:	00600713          	li	a4,6
80001be4:	000016b7          	lui	a3,0x1
80001be8:	fe442603          	lw	a2,-28(s0)
80001bec:	fe842583          	lw	a1,-24(s0)
80001bf0:	fdc42503          	lw	a0,-36(s0)
80001bf4:	dc9ff0ef          	jal	ra,800019bc <vmmap>
    for (int i = 0; i < NPROC; i++)
80001bf8:	fec42783          	lw	a5,-20(s0)
80001bfc:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
80001c00:	fef42623          	sw	a5,-20(s0)
80001c04:	fec42703          	lw	a4,-20(s0)
80001c08:	00300793          	li	a5,3
80001c0c:	fae7d8e3          	bge	a5,a4,80001bbc <mkstack+0x1c>
    }
}
80001c10:	00000013          	nop
80001c14:	00000013          	nop
80001c18:	02c12083          	lw	ra,44(sp)
80001c1c:	02812403          	lw	s0,40(sp)
80001c20:	03010113          	addi	sp,sp,48
80001c24:	00008067          	ret

80001c28 <kvminit>:

// 初始化虚拟内存
void kvminit()
{
80001c28:	ff010113          	addi	sp,sp,-16
80001c2c:	00112623          	sw	ra,12(sp)
80001c30:	00812423          	sw	s0,8(sp)
80001c34:	01010413          	addi	s0,sp,16
    kpgt = (addr_t *)palloc();
80001c38:	a15ff0ef          	jal	ra,8000164c <palloc>
80001c3c:	00050713          	mv	a4,a0
80001c40:	8000e7b7          	lui	a5,0x8000e
80001c44:	a4e7a623          	sw	a4,-1460(a5) # 8000da4c <memend+0xf800da4c>
    memset(kpgt, 0, PGSIZE);
80001c48:	8000e7b7          	lui	a5,0x8000e
80001c4c:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001c50:	00001637          	lui	a2,0x1
80001c54:	00000593          	li	a1,0
80001c58:	00078513          	mv	a0,a5
80001c5c:	045000ef          	jal	ra,800024a0 <memset>

    // 映射 CLINT
    vmmap(kpgt, CLINT_BASE, CLINT_BASE, 0xc000, PTE_R | PTE_W);
80001c60:	8000e7b7          	lui	a5,0x8000e
80001c64:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001c68:	00600713          	li	a4,6
80001c6c:	0000c6b7          	lui	a3,0xc
80001c70:	02000637          	lui	a2,0x2000
80001c74:	020005b7          	lui	a1,0x2000
80001c78:	00078513          	mv	a0,a5
80001c7c:	d41ff0ef          	jal	ra,800019bc <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt, PLIC_BASE, PLIC_BASE, 0x400000, PTE_R | PTE_W);
80001c80:	8000e7b7          	lui	a5,0x8000e
80001c84:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001c88:	00600713          	li	a4,6
80001c8c:	004006b7          	lui	a3,0x400
80001c90:	0c000637          	lui	a2,0xc000
80001c94:	0c0005b7          	lui	a1,0xc000
80001c98:	00078513          	mv	a0,a5
80001c9c:	d21ff0ef          	jal	ra,800019bc <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt, UART_BASE, UART_BASE, PGSIZE, PTE_R | PTE_W);
80001ca0:	8000e7b7          	lui	a5,0x8000e
80001ca4:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001ca8:	00600713          	li	a4,6
80001cac:	000016b7          	lui	a3,0x1
80001cb0:	10000637          	lui	a2,0x10000
80001cb4:	100005b7          	lui	a1,0x10000
80001cb8:	00078513          	mv	a0,a5
80001cbc:	d01ff0ef          	jal	ra,800019bc <vmmap>

    // 映射 VIRTIO_MMIO
    vmmap(kpgt, VIRTIO_BASE, VIRTIO_BASE, PGSIZE, PTE_R | PTE_W);
80001cc0:	8000e7b7          	lui	a5,0x8000e
80001cc4:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001cc8:	00600713          	li	a4,6
80001ccc:	000016b7          	lui	a3,0x1
80001cd0:	10001637          	lui	a2,0x10001
80001cd4:	100015b7          	lui	a1,0x10001
80001cd8:	00078513          	mv	a0,a5
80001cdc:	ce1ff0ef          	jal	ra,800019bc <vmmap>

    // 映射 内核 指令区
    vmmap(kpgt, (addr_t)textstart, (addr_t)textstart, (textend - textstart), PTE_R | PTE_X);
80001ce0:	8000e7b7          	lui	a5,0x8000e
80001ce4:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001ce8:	800007b7          	lui	a5,0x80000
80001cec:	00078593          	mv	a1,a5
80001cf0:	800007b7          	lui	a5,0x80000
80001cf4:	00078613          	mv	a2,a5
80001cf8:	800037b7          	lui	a5,0x80003
80001cfc:	c5478713          	addi	a4,a5,-940 # 80002c54 <memend+0xf8002c54>
80001d00:	800007b7          	lui	a5,0x80000
80001d04:	00078793          	mv	a5,a5
80001d08:	40f707b3          	sub	a5,a4,a5
80001d0c:	00a00713          	li	a4,10
80001d10:	00078693          	mv	a3,a5
80001d14:	ca9ff0ef          	jal	ra,800019bc <vmmap>
    // 映射 数据区
    vmmap(kpgt, (addr_t)datastart, (addr_t)datastart, dataend - datastart, PTE_R | PTE_W);
80001d18:	8000e7b7          	lui	a5,0x8000e
80001d1c:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d20:	800037b7          	lui	a5,0x80003
80001d24:	00078593          	mv	a1,a5
80001d28:	800037b7          	lui	a5,0x80003
80001d2c:	00078613          	mv	a2,a5
80001d30:	8000b7b7          	lui	a5,0x8000b
80001d34:	02478713          	addi	a4,a5,36 # 8000b024 <memend+0xf800b024>
80001d38:	800037b7          	lui	a5,0x80003
80001d3c:	00078793          	mv	a5,a5
80001d40:	40f707b3          	sub	a5,a4,a5
80001d44:	00600713          	li	a4,6
80001d48:	00078693          	mv	a3,a5
80001d4c:	c71ff0ef          	jal	ra,800019bc <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt, (addr_t)rodatastart, (addr_t)rodatastart, (rodataend - rodatastart), PTE_R);
80001d50:	8000e7b7          	lui	a5,0x8000e
80001d54:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d58:	8000c7b7          	lui	a5,0x8000c
80001d5c:	00078593          	mv	a1,a5
80001d60:	8000c7b7          	lui	a5,0x8000c
80001d64:	00078613          	mv	a2,a5
80001d68:	8000c7b7          	lui	a5,0x8000c
80001d6c:	4b278713          	addi	a4,a5,1202 # 8000c4b2 <memend+0xf800c4b2>
80001d70:	8000c7b7          	lui	a5,0x8000c
80001d74:	00078793          	mv	a5,a5
80001d78:	40f707b3          	sub	a5,a4,a5
80001d7c:	00200713          	li	a4,2
80001d80:	00078693          	mv	a3,a5
80001d84:	c39ff0ef          	jal	ra,800019bc <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt, (addr_t)bssstart, (addr_t)bssstart, bssend - bssstart, PTE_R | PTE_W);
80001d88:	8000e7b7          	lui	a5,0x8000e
80001d8c:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001d90:	8000d7b7          	lui	a5,0x8000d
80001d94:	00078593          	mv	a1,a5
80001d98:	8000d7b7          	lui	a5,0x8000d
80001d9c:	00078613          	mv	a2,a5
80001da0:	8000e7b7          	lui	a5,0x8000e
80001da4:	b9078713          	addi	a4,a5,-1136 # 8000db90 <memend+0xf800db90>
80001da8:	8000d7b7          	lui	a5,0x8000d
80001dac:	00078793          	mv	a5,a5
80001db0:	40f707b3          	sub	a5,a4,a5
80001db4:	00600713          	li	a4,6
80001db8:	00078693          	mv	a3,a5
80001dbc:	c01ff0ef          	jal	ra,800019bc <vmmap>

    // 映射空闲内存区
    vmmap(kpgt, (addr_t)mstart, (addr_t)mstart, mend - mstart, PTE_W | PTE_R);
80001dc0:	8000e7b7          	lui	a5,0x8000e
80001dc4:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001dc8:	8000e7b7          	lui	a5,0x8000e
80001dcc:	00078593          	mv	a1,a5
80001dd0:	8000e7b7          	lui	a5,0x8000e
80001dd4:	00078613          	mv	a2,a5
80001dd8:	880007b7          	lui	a5,0x88000
80001ddc:	00078713          	mv	a4,a5
80001de0:	8000e7b7          	lui	a5,0x8000e
80001de4:	00078793          	mv	a5,a5
80001de8:	40f707b3          	sub	a5,a4,a5
80001dec:	00600713          	li	a4,6
80001df0:	00078693          	mv	a3,a5
80001df4:	bc9ff0ef          	jal	ra,800019bc <vmmap>

    mkstack(kpgt);
80001df8:	8000e7b7          	lui	a5,0x8000e
80001dfc:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001e00:	00078513          	mv	a0,a5
80001e04:	d9dff0ef          	jal	ra,80001ba0 <mkstack>

    // 映射 usertrap
    vmmap(kpgt, USERVEC, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80001e08:	8000e7b7          	lui	a5,0x8000e
80001e0c:	a4c7a503          	lw	a0,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001e10:	800007b7          	lui	a5,0x80000
80001e14:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80001e18:	00a00713          	li	a4,10
80001e1c:	000016b7          	lui	a3,0x1
80001e20:	00078613          	mv	a2,a5
80001e24:	fffff5b7          	lui	a1,0xfffff
80001e28:	b95ff0ef          	jal	ra,800019bc <vmmap>

    // printpgt(pgt);
    w_satp(SATP_SV32 | (((uint32)kpgt) >> 12)); // 页表 PPN 写入Satp
80001e2c:	8000e7b7          	lui	a5,0x8000e
80001e30:	a4c7a783          	lw	a5,-1460(a5) # 8000da4c <memend+0xf800da4c>
80001e34:	00c7d713          	srli	a4,a5,0xc
80001e38:	800007b7          	lui	a5,0x80000
80001e3c:	00f767b3          	or	a5,a4,a5
80001e40:	00078513          	mv	a0,a5
80001e44:	a7dff0ef          	jal	ra,800018c0 <w_satp>
    sfence_vma();                               // 刷新页表
80001e48:	aa1ff0ef          	jal	ra,800018e8 <sfence_vma>
}
80001e4c:	00000013          	nop
80001e50:	00c12083          	lw	ra,12(sp)
80001e54:	00812403          	lw	s0,8(sp)
80001e58:	01010113          	addi	sp,sp,16
80001e5c:	00008067          	ret

80001e60 <pgtcreate>:

addr_t *pgtcreate()
{
80001e60:	fe010113          	addi	sp,sp,-32
80001e64:	00112e23          	sw	ra,28(sp)
80001e68:	00812c23          	sw	s0,24(sp)
80001e6c:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t *pgt = (addr_t *)palloc();
80001e70:	fdcff0ef          	jal	ra,8000164c <palloc>
80001e74:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001e78:	fec42783          	lw	a5,-20(s0)
}
80001e7c:	00078513          	mv	a0,a5
80001e80:	01c12083          	lw	ra,28(sp)
80001e84:	01812403          	lw	s0,24(sp)
80001e88:	02010113          	addi	sp,sp,32
80001e8c:	00008067          	ret

80001e90 <r_tp>:
{
80001e90:	fe010113          	addi	sp,sp,-32
80001e94:	00812e23          	sw	s0,28(sp)
80001e98:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
80001e9c:	00020793          	mv	a5,tp
80001ea0:	fef42623          	sw	a5,-20(s0)
    return x;
80001ea4:	fec42783          	lw	a5,-20(s0)
}
80001ea8:	00078513          	mv	a0,a5
80001eac:	01c12403          	lw	s0,28(sp)
80001eb0:	02010113          	addi	sp,sp,32
80001eb4:	00008067          	ret

80001eb8 <procinit>:
#include "syscall.h"

uint nextpid = 0;

void procinit()
{
80001eb8:	fe010113          	addi	sp,sp,-32
80001ebc:	00812e23          	sw	s0,28(sp)
80001ec0:	02010413          	addi	s0,sp,32
    struct pcb *p;
    for (int i = 0; i < NPROC; i++)
80001ec4:	fe042623          	sw	zero,-20(s0)
80001ec8:	0500006f          	j	80001f18 <procinit+0x60>
    {
        p = &proc[i];
80001ecc:	fec42703          	lw	a4,-20(s0)
80001ed0:	00070793          	mv	a5,a4
80001ed4:	00379793          	slli	a5,a5,0x3
80001ed8:	00e787b3          	add	a5,a5,a4
80001edc:	00479793          	slli	a5,a5,0x4
80001ee0:	8000d737          	lui	a4,0x8000d
80001ee4:	40870713          	addi	a4,a4,1032 # 8000d408 <memend+0xf800d408>
80001ee8:	00e787b3          	add	a5,a5,a4
80001eec:	fef42423          	sw	a5,-24(s0)
        p->kernelstack = (addr_t)(KSTACK + (i)*2 * PGSIZE);
80001ef0:	fec42783          	lw	a5,-20(s0)
80001ef4:	00d79793          	slli	a5,a5,0xd
80001ef8:	00078713          	mv	a4,a5
80001efc:	c00027b7          	lui	a5,0xc0002
80001f00:	00f70733          	add	a4,a4,a5
80001f04:	fe842783          	lw	a5,-24(s0)
80001f08:	08e7a623          	sw	a4,140(a5) # c000208c <memend+0x3800208c>
    for (int i = 0; i < NPROC; i++)
80001f0c:	fec42783          	lw	a5,-20(s0)
80001f10:	00178793          	addi	a5,a5,1
80001f14:	fef42623          	sw	a5,-20(s0)
80001f18:	fec42703          	lw	a4,-20(s0)
80001f1c:	00300793          	li	a5,3
80001f20:	fae7d6e3          	bge	a5,a4,80001ecc <procinit+0x14>
    }
}
80001f24:	00000013          	nop
80001f28:	00000013          	nop
80001f2c:	01c12403          	lw	s0,28(sp)
80001f30:	02010113          	addi	sp,sp,32
80001f34:	00008067          	ret

80001f38 <nowproc>:

struct pcb *nowproc()
{
80001f38:	fe010113          	addi	sp,sp,-32
80001f3c:	00112e23          	sw	ra,28(sp)
80001f40:	00812c23          	sw	s0,24(sp)
80001f44:	02010413          	addi	s0,sp,32
    int hart = r_tp();
80001f48:	f49ff0ef          	jal	ra,80001e90 <r_tp>
80001f4c:	00050793          	mv	a5,a0
80001f50:	fef42623          	sw	a5,-20(s0)
    return cpus[hart].proc;
80001f54:	8000d7b7          	lui	a5,0x8000d
80001f58:	64878713          	addi	a4,a5,1608 # 8000d648 <memend+0xf800d648>
80001f5c:	fec42783          	lw	a5,-20(s0)
80001f60:	00779793          	slli	a5,a5,0x7
80001f64:	00f707b3          	add	a5,a4,a5
80001f68:	0007a783          	lw	a5,0(a5)
}
80001f6c:	00078513          	mv	a0,a5
80001f70:	01c12083          	lw	ra,28(sp)
80001f74:	01812403          	lw	s0,24(sp)
80001f78:	02010113          	addi	sp,sp,32
80001f7c:	00008067          	ret

80001f80 <nowcpu>:

struct cpu *nowcpu()
{
80001f80:	fe010113          	addi	sp,sp,-32
80001f84:	00112e23          	sw	ra,28(sp)
80001f88:	00812c23          	sw	s0,24(sp)
80001f8c:	02010413          	addi	s0,sp,32
    int hart = r_tp();
80001f90:	f01ff0ef          	jal	ra,80001e90 <r_tp>
80001f94:	00050793          	mv	a5,a0
80001f98:	fef42623          	sw	a5,-20(s0)
    return &cpus[hart];
80001f9c:	fec42783          	lw	a5,-20(s0)
80001fa0:	00779713          	slli	a4,a5,0x7
80001fa4:	8000d7b7          	lui	a5,0x8000d
80001fa8:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
80001fac:	00f707b3          	add	a5,a4,a5
}
80001fb0:	00078513          	mv	a0,a5
80001fb4:	01c12083          	lw	ra,28(sp)
80001fb8:	01812403          	lw	s0,24(sp)
80001fbc:	02010113          	addi	sp,sp,32
80001fc0:	00008067          	ret

80001fc4 <pidalloc>:

uint pidalloc()
{
80001fc4:	ff010113          	addi	sp,sp,-16
80001fc8:	00812623          	sw	s0,12(sp)
80001fcc:	01010413          	addi	s0,sp,16
    return nextpid++;
80001fd0:	8000d7b7          	lui	a5,0x8000d
80001fd4:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
80001fd8:	00178693          	addi	a3,a5,1
80001fdc:	8000d737          	lui	a4,0x8000d
80001fe0:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
}
80001fe4:	00078513          	mv	a0,a5
80001fe8:	00c12403          	lw	s0,12(sp)
80001fec:	01010113          	addi	sp,sp,16
80001ff0:	00008067          	ret

80001ff4 <procalloc>:

struct pcb *procalloc()
{
80001ff4:	fe010113          	addi	sp,sp,-32
80001ff8:	00112e23          	sw	ra,28(sp)
80001ffc:	00812c23          	sw	s0,24(sp)
80002000:	02010413          	addi	s0,sp,32
    struct pcb *p;
    for (p = proc; p < &proc[NPROC]; p++)
80002004:	8000d7b7          	lui	a5,0x8000d
80002008:	40878793          	addi	a5,a5,1032 # 8000d408 <memend+0xf800d408>
8000200c:	fef42623          	sw	a5,-20(s0)
80002010:	0680006f          	j	80002078 <procalloc+0x84>
    {
        if (p->status == UNUSED)
80002014:	fec42783          	lw	a5,-20(s0)
80002018:	0047a783          	lw	a5,4(a5)
8000201c:	04079863          	bnez	a5,8000206c <procalloc+0x78>
        {
            p->trapframe = (struct trapframe *)palloc(sizeof(struct trapframe));
80002020:	08c00513          	li	a0,140
80002024:	e28ff0ef          	jal	ra,8000164c <palloc>
80002028:	00050713          	mv	a4,a0
8000202c:	fec42783          	lw	a5,-20(s0)
80002030:	00e7a423          	sw	a4,8(a5)

            p->pid = pidalloc();
80002034:	f91ff0ef          	jal	ra,80001fc4 <pidalloc>
80002038:	00050793          	mv	a5,a0
8000203c:	00078713          	mv	a4,a5
80002040:	fec42783          	lw	a5,-20(s0)
80002044:	00e7a023          	sw	a4,0(a5)
            p->status = USED;
80002048:	fec42783          	lw	a5,-20(s0)
8000204c:	00100713          	li	a4,1
80002050:	00e7a223          	sw	a4,4(a5)

            p->pagetable = pgtcreate();
80002054:	e0dff0ef          	jal	ra,80001e60 <pgtcreate>
80002058:	00050713          	mv	a4,a0
8000205c:	fec42783          	lw	a5,-20(s0)
80002060:	08e7a423          	sw	a4,136(a5)

            return p;
80002064:	fec42783          	lw	a5,-20(s0)
80002068:	0240006f          	j	8000208c <procalloc+0x98>
    for (p = proc; p < &proc[NPROC]; p++)
8000206c:	fec42783          	lw	a5,-20(s0)
80002070:	09078793          	addi	a5,a5,144
80002074:	fef42623          	sw	a5,-20(s0)
80002078:	fec42703          	lw	a4,-20(s0)
8000207c:	8000d7b7          	lui	a5,0x8000d
80002080:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
80002084:	f8f768e3          	bltu	a4,a5,80002014 <procalloc+0x20>
        }
    }
    return 0;
80002088:	00000793          	li	a5,0
}
8000208c:	00078513          	mv	a0,a5
80002090:	01c12083          	lw	ra,28(sp)
80002094:	01812403          	lw	s0,24(sp)
80002098:	02010113          	addi	sp,sp,32
8000209c:	00008067          	ret

800020a0 <userinit>:
    0x73, 0x00, 0x00, 0x00,
    0x6f, 0x00, 0x00, 0x00};

// 初始化第一个进程
void userinit()
{
800020a0:	fe010113          	addi	sp,sp,-32
800020a4:	00112e23          	sw	ra,28(sp)
800020a8:	00812c23          	sw	s0,24(sp)
800020ac:	02010413          	addi	s0,sp,32
    struct pcb *p = procalloc();
800020b0:	f45ff0ef          	jal	ra,80001ff4 <procalloc>
800020b4:	fea42623          	sw	a0,-20(s0)

    p->trapframe->epc = 0;
800020b8:	fec42783          	lw	a5,-20(s0)
800020bc:	0087a783          	lw	a5,8(a5)
800020c0:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp = PGSIZE;
800020c4:	fec42783          	lw	a5,-20(s0)
800020c8:	0087a783          	lw	a5,8(a5)
800020cc:	00001737          	lui	a4,0x1
800020d0:	00e7aa23          	sw	a4,20(a5)

    char *m = (char *)palloc();
800020d4:	d78ff0ef          	jal	ra,8000164c <palloc>
800020d8:	fea42423          	sw	a0,-24(s0)
    memmove(m, zeroproc, sizeof(zeroproc));
800020dc:	00c00613          	li	a2,12
800020e0:	00000693          	li	a3,0
800020e4:	8000b7b7          	lui	a5,0x8000b
800020e8:	00078593          	mv	a1,a5
800020ec:	fe842503          	lw	a0,-24(s0)
800020f0:	41c000ef          	jal	ra,8000250c <memmove>

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
800020f4:	fec42783          	lw	a5,-20(s0)
800020f8:	0887a783          	lw	a5,136(a5) # 8000b088 <memend+0xf800b088>
800020fc:	fe842603          	lw	a2,-24(s0)
80002100:	01e00713          	li	a4,30
80002104:	000016b7          	lui	a3,0x1
80002108:	00000593          	li	a1,0
8000210c:	00078513          	mv	a0,a5
80002110:	8adff0ef          	jal	ra,800019bc <vmmap>
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80002114:	fec42783          	lw	a5,-20(s0)
80002118:	0887a503          	lw	a0,136(a5)
8000211c:	800007b7          	lui	a5,0x80000
80002120:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80002124:	800007b7          	lui	a5,0x80000
80002128:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
8000212c:	00a00713          	li	a4,10
80002130:	000016b7          	lui	a3,0x1
80002134:	00078613          	mv	a2,a5
80002138:	885ff0ef          	jal	ra,800019bc <vmmap>

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
8000213c:	fec42783          	lw	a5,-20(s0)
80002140:	0887a503          	lw	a0,136(a5)
80002144:	fec42783          	lw	a5,-20(s0)
80002148:	0087a783          	lw	a5,8(a5)
8000214c:	00600713          	li	a4,6
80002150:	000016b7          	lui	a3,0x1
80002154:	00078613          	mv	a2,a5
80002158:	ffffe5b7          	lui	a1,0xffffe
8000215c:	861ff0ef          	jal	ra,800019bc <vmmap>

    p->pagetable = (addr_t *)p->pagetable;
80002160:	fec42783          	lw	a5,-20(s0)
80002164:	0887a703          	lw	a4,136(a5)
80002168:	fec42783          	lw	a5,-20(s0)
8000216c:	08e7a423          	sw	a4,136(a5)

    p->status = RUNABLE;
80002170:	fec42783          	lw	a5,-20(s0)
80002174:	00200713          	li	a4,2
80002178:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
8000217c:	fec42783          	lw	a5,-20(s0)
80002180:	0887a783          	lw	a5,136(a5)
80002184:	00078513          	mv	a0,a5
80002188:	a19ff0ef          	jal	ra,80001ba0 <mkstack>

    p->context.ra = (reg_t)usertrapret;
8000218c:	800017b7          	lui	a5,0x80001
80002190:	dd878713          	addi	a4,a5,-552 # 80000dd8 <memend+0xf8000dd8>
80002194:	fec42783          	lw	a5,-20(s0)
80002198:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
8000219c:	fec42783          	lw	a5,-20(s0)
800021a0:	08c7a703          	lw	a4,140(a5)
800021a4:	fec42783          	lw	a5,-20(s0)
800021a8:	00e7a823          	sw	a4,16(a5)

    p = procalloc();
800021ac:	e49ff0ef          	jal	ra,80001ff4 <procalloc>
800021b0:	fea42623          	sw	a0,-20(s0)
    p->context.ra = (reg_t)usertrapret;
800021b4:	800017b7          	lui	a5,0x80001
800021b8:	dd878713          	addi	a4,a5,-552 # 80000dd8 <memend+0xf8000dd8>
800021bc:	fec42783          	lw	a5,-20(s0)
800021c0:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
800021c4:	fec42783          	lw	a5,-20(s0)
800021c8:	08c7a703          	lw	a4,140(a5)
800021cc:	fec42783          	lw	a5,-20(s0)
800021d0:	00e7a823          	sw	a4,16(a5)

    p->trapframe->epc = 0;
800021d4:	fec42783          	lw	a5,-20(s0)
800021d8:	0087a783          	lw	a5,8(a5)
800021dc:	0007a623          	sw	zero,12(a5)
    p->trapframe->sp = PGSIZE;
800021e0:	fec42783          	lw	a5,-20(s0)
800021e4:	0087a783          	lw	a5,8(a5)
800021e8:	00001737          	lui	a4,0x1
800021ec:	00e7aa23          	sw	a4,20(a5)

    m = (char *)palloc();
800021f0:	c5cff0ef          	jal	ra,8000164c <palloc>
800021f4:	fea42423          	sw	a0,-24(s0)
    memmove(m, firstproc, sizeof(zeroproc));
800021f8:	00c00613          	li	a2,12
800021fc:	00000693          	li	a3,0
80002200:	8000b7b7          	lui	a5,0x8000b
80002204:	00c78593          	addi	a1,a5,12 # 8000b00c <memend+0xf800b00c>
80002208:	fe842503          	lw	a0,-24(s0)
8000220c:	300000ef          	jal	ra,8000250c <memmove>

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
80002210:	fec42783          	lw	a5,-20(s0)
80002214:	0887a783          	lw	a5,136(a5)
80002218:	fe842603          	lw	a2,-24(s0)
8000221c:	01e00713          	li	a4,30
80002220:	000016b7          	lui	a3,0x1
80002224:	00000593          	li	a1,0
80002228:	00078513          	mv	a0,a5
8000222c:	f90ff0ef          	jal	ra,800019bc <vmmap>
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
80002230:	fec42783          	lw	a5,-20(s0)
80002234:	0887a503          	lw	a0,136(a5)
80002238:	800007b7          	lui	a5,0x80000
8000223c:	29878593          	addi	a1,a5,664 # 80000298 <memend+0xf8000298>
80002240:	800007b7          	lui	a5,0x80000
80002244:	29878793          	addi	a5,a5,664 # 80000298 <memend+0xf8000298>
80002248:	00a00713          	li	a4,10
8000224c:	000016b7          	lui	a3,0x1
80002250:	00078613          	mv	a2,a5
80002254:	f68ff0ef          	jal	ra,800019bc <vmmap>

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
80002258:	fec42783          	lw	a5,-20(s0)
8000225c:	0887a503          	lw	a0,136(a5)
80002260:	fec42783          	lw	a5,-20(s0)
80002264:	0087a783          	lw	a5,8(a5)
80002268:	00600713          	li	a4,6
8000226c:	000016b7          	lui	a3,0x1
80002270:	00078613          	mv	a2,a5
80002274:	ffffe5b7          	lui	a1,0xffffe
80002278:	f44ff0ef          	jal	ra,800019bc <vmmap>

    p->pagetable = (addr_t *)p->pagetable;
8000227c:	fec42783          	lw	a5,-20(s0)
80002280:	0887a703          	lw	a4,136(a5)
80002284:	fec42783          	lw	a5,-20(s0)
80002288:	08e7a423          	sw	a4,136(a5)

    p->status = RUNABLE;
8000228c:	fec42783          	lw	a5,-20(s0)
80002290:	00200713          	li	a4,2
80002294:	00e7a223          	sw	a4,4(a5)

    mkstack(p->pagetable);
80002298:	fec42783          	lw	a5,-20(s0)
8000229c:	0887a783          	lw	a5,136(a5)
800022a0:	00078513          	mv	a0,a5
800022a4:	8fdff0ef          	jal	ra,80001ba0 <mkstack>

    p->context.ra = (reg_t)usertrapret;
800022a8:	800017b7          	lui	a5,0x80001
800022ac:	dd878713          	addi	a4,a5,-552 # 80000dd8 <memend+0xf8000dd8>
800022b0:	fec42783          	lw	a5,-20(s0)
800022b4:	00e7a623          	sw	a4,12(a5)
    p->context.sp = p->kernelstack;
800022b8:	fec42783          	lw	a5,-20(s0)
800022bc:	08c7a703          	lw	a4,140(a5)
800022c0:	fec42783          	lw	a5,-20(s0)
800022c4:	00e7a823          	sw	a4,16(a5)
}
800022c8:	00000013          	nop
800022cc:	01c12083          	lw	ra,28(sp)
800022d0:	01812403          	lw	s0,24(sp)
800022d4:	02010113          	addi	sp,sp,32
800022d8:	00008067          	ret

800022dc <schedule>:

void schedule()
{
800022dc:	fe010113          	addi	sp,sp,-32
800022e0:	00112e23          	sw	ra,28(sp)
800022e4:	00812c23          	sw	s0,24(sp)
800022e8:	02010413          	addi	s0,sp,32
    struct cpu *c = nowcpu();
800022ec:	c95ff0ef          	jal	ra,80001f80 <nowcpu>
800022f0:	fea42423          	sw	a0,-24(s0)
    struct pcb *p;

    for (;;)
    {
        for (p = proc; p < &proc[NPROC]; p++)
800022f4:	8000d7b7          	lui	a5,0x8000d
800022f8:	40878793          	addi	a5,a5,1032 # 8000d408 <memend+0xf800d408>
800022fc:	fef42623          	sw	a5,-20(s0)
80002300:	05c0006f          	j	8000235c <schedule+0x80>
        {
            if (p->status == RUNABLE)
80002304:	fec42783          	lw	a5,-20(s0)
80002308:	0047a703          	lw	a4,4(a5)
8000230c:	00200793          	li	a5,2
80002310:	04f71063          	bne	a4,a5,80002350 <schedule+0x74>
            {
                p->status = RUNNING;
80002314:	fec42783          	lw	a5,-20(s0)
80002318:	00300713          	li	a4,3
8000231c:	00e7a223          	sw	a4,4(a5)
                c->proc = p;
80002320:	fe842783          	lw	a5,-24(s0)
80002324:	fec42703          	lw	a4,-20(s0)
80002328:	00e7a023          	sw	a4,0(a5)
                // 保存当前的上下文到cpu->context中
                swtch(&c->context, &p->context);
8000232c:	fe842783          	lw	a5,-24(s0)
80002330:	00478713          	addi	a4,a5,4
80002334:	fec42783          	lw	a5,-20(s0)
80002338:	00c78793          	addi	a5,a5,12
8000233c:	00078593          	mv	a1,a5
80002340:	00070513          	mv	a0,a4
80002344:	e59fd0ef          	jal	ra,8000019c <swtch>
                // swtch ret后跳转到p->context.ra

                c->proc = 0; // cpu->context.ra 指向这里
80002348:	fe842783          	lw	a5,-24(s0)
8000234c:	0007a023          	sw	zero,0(a5)
        for (p = proc; p < &proc[NPROC]; p++)
80002350:	fec42783          	lw	a5,-20(s0)
80002354:	09078793          	addi	a5,a5,144
80002358:	fef42623          	sw	a5,-20(s0)
8000235c:	fec42703          	lw	a4,-20(s0)
80002360:	8000d7b7          	lui	a5,0x8000d
80002364:	64878793          	addi	a5,a5,1608 # 8000d648 <memend+0xf800d648>
80002368:	f8f76ee3          	bltu	a4,a5,80002304 <schedule+0x28>
8000236c:	f89ff06f          	j	800022f4 <schedule+0x18>

80002370 <yield>:

/**
 * @description: 进程放弃 CPU
 */
void yield()
{
80002370:	fe010113          	addi	sp,sp,-32
80002374:	00112e23          	sw	ra,28(sp)
80002378:	00812c23          	sw	s0,24(sp)
8000237c:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002380:	bb9ff0ef          	jal	ra,80001f38 <nowproc>
80002384:	fea42623          	sw	a0,-20(s0)
    if (p->status != RUNNING)
80002388:	fec42783          	lw	a5,-20(s0)
8000238c:	0047a703          	lw	a4,4(a5)
80002390:	00300793          	li	a5,3
80002394:	00f70863          	beq	a4,a5,800023a4 <yield+0x34>
    {
        panic("proc status error");
80002398:	8000c7b7          	lui	a5,0x8000c
8000239c:	45c78513          	addi	a0,a5,1116 # 8000c45c <memend+0xf800c45c>
800023a0:	dedfe0ef          	jal	ra,8000118c <panic>
    }
    p->status = RUNABLE;
800023a4:	fec42783          	lw	a5,-20(s0)
800023a8:	00200713          	li	a4,2
800023ac:	00e7a223          	sw	a4,4(a5)
    sched();
800023b0:	018000ef          	jal	ra,800023c8 <sched>
}
800023b4:	00000013          	nop
800023b8:	01c12083          	lw	ra,28(sp)
800023bc:	01812403          	lw	s0,24(sp)
800023c0:	02010113          	addi	sp,sp,32
800023c4:	00008067          	ret

800023c8 <sched>:

/**
 * @description:
 */
void sched()
{
800023c8:	fe010113          	addi	sp,sp,-32
800023cc:	00112e23          	sw	ra,28(sp)
800023d0:	00812c23          	sw	s0,24(sp)
800023d4:	00912a23          	sw	s1,20(sp)
800023d8:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
800023dc:	b5dff0ef          	jal	ra,80001f38 <nowproc>
800023e0:	fea42623          	sw	a0,-20(s0)
    if (p->status == RUNNING)
800023e4:	fec42783          	lw	a5,-20(s0)
800023e8:	0047a703          	lw	a4,4(a5)
800023ec:	00300793          	li	a5,3
800023f0:	00f71863          	bne	a4,a5,80002400 <sched+0x38>
    {
        panic("proc is running");
800023f4:	8000c7b7          	lui	a5,0x8000c
800023f8:	47078513          	addi	a0,a5,1136 # 8000c470 <memend+0xf800c470>
800023fc:	d91fe0ef          	jal	ra,8000118c <panic>
    }
    swtch(&p->context, &nowcpu()->context); //跳转到cpu->context.ra ( schedule() )
80002400:	fec42783          	lw	a5,-20(s0)
80002404:	00c78493          	addi	s1,a5,12
80002408:	b79ff0ef          	jal	ra,80001f80 <nowcpu>
8000240c:	00050793          	mv	a5,a0
80002410:	00478793          	addi	a5,a5,4
80002414:	00078593          	mv	a1,a5
80002418:	00048513          	mv	a0,s1
8000241c:	d81fd0ef          	jal	ra,8000019c <swtch>
}
80002420:	00000013          	nop
80002424:	01c12083          	lw	ra,28(sp)
80002428:	01812403          	lw	s0,24(sp)
8000242c:	01412483          	lw	s1,20(sp)
80002430:	02010113          	addi	sp,sp,32
80002434:	00008067          	ret

80002438 <sys_fork>:

uint32 sys_fork(void)
{
80002438:	ff010113          	addi	sp,sp,-16
8000243c:	00112623          	sw	ra,12(sp)
80002440:	00812423          	sw	s0,8(sp)
80002444:	01010413          	addi	s0,sp,16
    printf("syscall fork\n");
80002448:	8000c7b7          	lui	a5,0x8000c
8000244c:	48078513          	addi	a0,a5,1152 # 8000c480 <memend+0xf800c480>
80002450:	d75fe0ef          	jal	ra,800011c4 <printf>
    return SYS_fork;
80002454:	00100793          	li	a5,1
}
80002458:	00078513          	mv	a0,a5
8000245c:	00c12083          	lw	ra,12(sp)
80002460:	00812403          	lw	s0,8(sp)
80002464:	01010113          	addi	sp,sp,16
80002468:	00008067          	ret

8000246c <sys_exec>:

uint32 sys_exec(void)
{
8000246c:	ff010113          	addi	sp,sp,-16
80002470:	00112623          	sw	ra,12(sp)
80002474:	00812423          	sw	s0,8(sp)
80002478:	01010413          	addi	s0,sp,16
    printf("syscall exec\n");
8000247c:	8000c7b7          	lui	a5,0x8000c
80002480:	49078513          	addi	a0,a5,1168 # 8000c490 <memend+0xf800c490>
80002484:	d41fe0ef          	jal	ra,800011c4 <printf>
    return SYS_exec;
80002488:	00200793          	li	a5,2
8000248c:	00078513          	mv	a0,a5
80002490:	00c12083          	lw	ra,12(sp)
80002494:	00812403          	lw	s0,8(sp)
80002498:	01010113          	addi	sp,sp,16
8000249c:	00008067          	ret

800024a0 <memset>:
 */
#include "types.h"

// 初始化内存区域
void *memset(void *addr, int c, uint n)
{
800024a0:	fd010113          	addi	sp,sp,-48
800024a4:	02812623          	sw	s0,44(sp)
800024a8:	03010413          	addi	s0,sp,48
800024ac:	fca42e23          	sw	a0,-36(s0)
800024b0:	fcb42c23          	sw	a1,-40(s0)
800024b4:	fcc42a23          	sw	a2,-44(s0)
    char *maddr = (char *)addr;
800024b8:	fdc42783          	lw	a5,-36(s0)
800024bc:	fef42423          	sw	a5,-24(s0)
    for (uint i = 0; i < n; i++)
800024c0:	fe042623          	sw	zero,-20(s0)
800024c4:	0280006f          	j	800024ec <memset+0x4c>
    {
        maddr[i] = (char)c;
800024c8:	fe842703          	lw	a4,-24(s0)
800024cc:	fec42783          	lw	a5,-20(s0)
800024d0:	00f707b3          	add	a5,a4,a5
800024d4:	fd842703          	lw	a4,-40(s0)
800024d8:	0ff77713          	andi	a4,a4,255
800024dc:	00e78023          	sb	a4,0(a5)
    for (uint i = 0; i < n; i++)
800024e0:	fec42783          	lw	a5,-20(s0)
800024e4:	00178793          	addi	a5,a5,1
800024e8:	fef42623          	sw	a5,-20(s0)
800024ec:	fec42703          	lw	a4,-20(s0)
800024f0:	fd442783          	lw	a5,-44(s0)
800024f4:	fcf76ae3          	bltu	a4,a5,800024c8 <memset+0x28>
    }
    return addr;
800024f8:	fdc42783          	lw	a5,-36(s0)
}
800024fc:	00078513          	mv	a0,a5
80002500:	02c12403          	lw	s0,44(sp)
80002504:	03010113          	addi	sp,sp,48
80002508:	00008067          	ret

8000250c <memmove>:

// 安全的 memcpy
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void *memmove(void *dst, const void *src, size_t n)
{
8000250c:	fd010113          	addi	sp,sp,-48
80002510:	02812623          	sw	s0,44(sp)
80002514:	03010413          	addi	s0,sp,48
80002518:	fca42e23          	sw	a0,-36(s0)
8000251c:	fcb42c23          	sw	a1,-40(s0)
80002520:	fcc42823          	sw	a2,-48(s0)
80002524:	fcd42a23          	sw	a3,-44(s0)
    const char *s;
    char *d;
    if (n == 0)
80002528:	fd042783          	lw	a5,-48(s0)
8000252c:	fd442703          	lw	a4,-44(s0)
80002530:	00e7e7b3          	or	a5,a5,a4
80002534:	00079663          	bnez	a5,80002540 <memmove+0x34>
    {
        return dst;
80002538:	fdc42783          	lw	a5,-36(s0)
8000253c:	1200006f          	j	8000265c <memmove+0x150>
    }

    s = src;
80002540:	fd842783          	lw	a5,-40(s0)
80002544:	fef42623          	sw	a5,-20(s0)
    d = dst;
80002548:	fdc42783          	lw	a5,-36(s0)
8000254c:	fef42423          	sw	a5,-24(s0)
    if (s < d && s + n > d)
80002550:	fec42703          	lw	a4,-20(s0)
80002554:	fe842783          	lw	a5,-24(s0)
80002558:	0cf77263          	bgeu	a4,a5,8000261c <memmove+0x110>
8000255c:	fd042783          	lw	a5,-48(s0)
80002560:	fec42703          	lw	a4,-20(s0)
80002564:	00f707b3          	add	a5,a4,a5
80002568:	fe842703          	lw	a4,-24(s0)
8000256c:	0af77863          	bgeu	a4,a5,8000261c <memmove+0x110>
    {
        // 有重叠区域,从后往前复制
        s += n;
80002570:	fd042783          	lw	a5,-48(s0)
80002574:	fec42703          	lw	a4,-20(s0)
80002578:	00f707b3          	add	a5,a4,a5
8000257c:	fef42623          	sw	a5,-20(s0)
        d += n;
80002580:	fd042783          	lw	a5,-48(s0)
80002584:	fe842703          	lw	a4,-24(s0)
80002588:	00f707b3          	add	a5,a4,a5
8000258c:	fef42423          	sw	a5,-24(s0)
        while (n-- > 0)
80002590:	02c0006f          	j	800025bc <memmove+0xb0>
        {
            *--d = *--s;
80002594:	fec42783          	lw	a5,-20(s0)
80002598:	fff78793          	addi	a5,a5,-1
8000259c:	fef42623          	sw	a5,-20(s0)
800025a0:	fe842783          	lw	a5,-24(s0)
800025a4:	fff78793          	addi	a5,a5,-1
800025a8:	fef42423          	sw	a5,-24(s0)
800025ac:	fec42783          	lw	a5,-20(s0)
800025b0:	0007c703          	lbu	a4,0(a5)
800025b4:	fe842783          	lw	a5,-24(s0)
800025b8:	00e78023          	sb	a4,0(a5)
        while (n-- > 0)
800025bc:	fd042703          	lw	a4,-48(s0)
800025c0:	fd442783          	lw	a5,-44(s0)
800025c4:	fff00513          	li	a0,-1
800025c8:	fff00593          	li	a1,-1
800025cc:	00a70633          	add	a2,a4,a0
800025d0:	00060813          	mv	a6,a2
800025d4:	00e83833          	sltu	a6,a6,a4
800025d8:	00b786b3          	add	a3,a5,a1
800025dc:	00d805b3          	add	a1,a6,a3
800025e0:	00058693          	mv	a3,a1
800025e4:	fcc42823          	sw	a2,-48(s0)
800025e8:	fcd42a23          	sw	a3,-44(s0)
800025ec:	00070693          	mv	a3,a4
800025f0:	00f6e6b3          	or	a3,a3,a5
800025f4:	fa0690e3          	bnez	a3,80002594 <memmove+0x88>
    if (s < d && s + n > d)
800025f8:	0600006f          	j	80002658 <memmove+0x14c>
    else
    {
        // 无重叠区域,从前往后复制
        while (n-- > 0)
        {
            *d++ = *s++;
800025fc:	fec42703          	lw	a4,-20(s0)
80002600:	00170793          	addi	a5,a4,1 # 1001 <sz+0x1>
80002604:	fef42623          	sw	a5,-20(s0)
80002608:	fe842783          	lw	a5,-24(s0)
8000260c:	00178693          	addi	a3,a5,1
80002610:	fed42423          	sw	a3,-24(s0)
80002614:	00074703          	lbu	a4,0(a4)
80002618:	00e78023          	sb	a4,0(a5)
        while (n-- > 0)
8000261c:	fd042703          	lw	a4,-48(s0)
80002620:	fd442783          	lw	a5,-44(s0)
80002624:	fff00513          	li	a0,-1
80002628:	fff00593          	li	a1,-1
8000262c:	00a70633          	add	a2,a4,a0
80002630:	00060813          	mv	a6,a2
80002634:	00e83833          	sltu	a6,a6,a4
80002638:	00b786b3          	add	a3,a5,a1
8000263c:	00d805b3          	add	a1,a6,a3
80002640:	00058693          	mv	a3,a1
80002644:	fcc42823          	sw	a2,-48(s0)
80002648:	fcd42a23          	sw	a3,-44(s0)
8000264c:	00070693          	mv	a3,a4
80002650:	00f6e6b3          	or	a3,a3,a5
80002654:	fa0694e3          	bnez	a3,800025fc <memmove+0xf0>
        }
    }
    return dst;
80002658:	fdc42783          	lw	a5,-36(s0)
}
8000265c:	00078513          	mv	a0,a5
80002660:	02c12403          	lw	s0,44(sp)
80002664:	03010113          	addi	sp,sp,48
80002668:	00008067          	ret

8000266c <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char *s)
{
8000266c:	fd010113          	addi	sp,sp,-48
80002670:	02812623          	sw	s0,44(sp)
80002674:	03010413          	addi	s0,sp,48
80002678:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for (n = 0; s[n]; n++)
8000267c:	00000793          	li	a5,0
80002680:	00000813          	li	a6,0
80002684:	fef42423          	sw	a5,-24(s0)
80002688:	ff042623          	sw	a6,-20(s0)
8000268c:	0340006f          	j	800026c0 <strlen+0x54>
80002690:	fe842603          	lw	a2,-24(s0)
80002694:	fec42683          	lw	a3,-20(s0)
80002698:	00100513          	li	a0,1
8000269c:	00000593          	li	a1,0
800026a0:	00a60733          	add	a4,a2,a0
800026a4:	00070813          	mv	a6,a4
800026a8:	00c83833          	sltu	a6,a6,a2
800026ac:	00b687b3          	add	a5,a3,a1
800026b0:	00f806b3          	add	a3,a6,a5
800026b4:	00068793          	mv	a5,a3
800026b8:	fee42423          	sw	a4,-24(s0)
800026bc:	fef42623          	sw	a5,-20(s0)
800026c0:	fe842783          	lw	a5,-24(s0)
800026c4:	fdc42703          	lw	a4,-36(s0)
800026c8:	00f707b3          	add	a5,a4,a5
800026cc:	0007c783          	lbu	a5,0(a5)
800026d0:	fc0790e3          	bnez	a5,80002690 <strlen+0x24>
        ;

    return n;
800026d4:	fe842703          	lw	a4,-24(s0)
800026d8:	fec42783          	lw	a5,-20(s0)
800026dc:	00070513          	mv	a0,a4
800026e0:	00078593          	mv	a1,a5
800026e4:	02c12403          	lw	s0,44(sp)
800026e8:	03010113          	addi	sp,sp,48
800026ec:	00008067          	ret

800026f0 <r_tp>:
{
800026f0:	fe010113          	addi	sp,sp,-32
800026f4:	00812e23          	sw	s0,28(sp)
800026f8:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
800026fc:	00020793          	mv	a5,tp
80002700:	fef42623          	sw	a5,-20(s0)
    return x;
80002704:	fec42783          	lw	a5,-20(s0)
}
80002708:	00078513          	mv	a0,a5
8000270c:	01c12403          	lw	s0,28(sp)
80002710:	02010113          	addi	sp,sp,32
80002714:	00008067          	ret

80002718 <clintinit>:
 */
#include "clint.h"
#include "riscv.h"

void clintinit()
{
80002718:	fe010113          	addi	sp,sp,-32
8000271c:	00112e23          	sw	ra,28(sp)
80002720:	00812c23          	sw	s0,24(sp)
80002724:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp
    int hart = r_tp();
80002728:	fc9ff0ef          	jal	ra,800026f0 <r_tp>
8000272c:	00050793          	mv	a5,a0
80002730:	fef42623          	sw	a5,-20(s0)
    *(reg_t *)CLINT_MTIMECMP(hart) = *(reg_t *)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
80002734:	fec42703          	lw	a4,-20(s0)
80002738:	004017b7          	lui	a5,0x401
8000273c:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002740:	00f707b3          	add	a5,a4,a5
80002744:	00379793          	slli	a5,a5,0x3
80002748:	0007a703          	lw	a4,0(a5)
8000274c:	fec42683          	lw	a3,-20(s0)
80002750:	004017b7          	lui	a5,0x401
80002754:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002758:	00f687b3          	add	a5,a3,a5
8000275c:	00379793          	slli	a5,a5,0x3
80002760:	00078693          	mv	a3,a5
80002764:	009897b7          	lui	a5,0x989
80002768:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
8000276c:	00f707b3          	add	a5,a4,a5
80002770:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
80002774:	00000013          	nop
80002778:	01c12083          	lw	ra,28(sp)
8000277c:	01812403          	lw	s0,24(sp)
80002780:	02010113          	addi	sp,sp,32
80002784:	00008067          	ret

80002788 <r_mstatus>:
{
80002788:	fe010113          	addi	sp,sp,-32
8000278c:	00812e23          	sw	s0,28(sp)
80002790:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus"
80002794:	300027f3          	csrr	a5,mstatus
80002798:	fef42623          	sw	a5,-20(s0)
    return x;
8000279c:	fec42783          	lw	a5,-20(s0)
}
800027a0:	00078513          	mv	a0,a5
800027a4:	01c12403          	lw	s0,28(sp)
800027a8:	02010113          	addi	sp,sp,32
800027ac:	00008067          	ret

800027b0 <w_mstatus>:
{
800027b0:	fe010113          	addi	sp,sp,-32
800027b4:	00812e23          	sw	s0,28(sp)
800027b8:	02010413          	addi	s0,sp,32
800027bc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0"
800027c0:	fec42783          	lw	a5,-20(s0)
800027c4:	30079073          	csrw	mstatus,a5
}
800027c8:	00000013          	nop
800027cc:	01c12403          	lw	s0,28(sp)
800027d0:	02010113          	addi	sp,sp,32
800027d4:	00008067          	ret

800027d8 <w_mtvec>:
{
800027d8:	fe010113          	addi	sp,sp,-32
800027dc:	00812e23          	sw	s0,28(sp)
800027e0:	02010413          	addi	s0,sp,32
800027e4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0"
800027e8:	fec42783          	lw	a5,-20(s0)
800027ec:	30579073          	csrw	mtvec,a5
}
800027f0:	00000013          	nop
800027f4:	01c12403          	lw	s0,28(sp)
800027f8:	02010113          	addi	sp,sp,32
800027fc:	00008067          	ret

80002800 <r_tp>:
{
80002800:	fe010113          	addi	sp,sp,-32
80002804:	00812e23          	sw	s0,28(sp)
80002808:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp"
8000280c:	00020793          	mv	a5,tp
80002810:	fef42623          	sw	a5,-20(s0)
    return x;
80002814:	fec42783          	lw	a5,-20(s0)
}
80002818:	00078513          	mv	a0,a5
8000281c:	01c12403          	lw	s0,28(sp)
80002820:	02010113          	addi	sp,sp,32
80002824:	00008067          	ret

80002828 <s_mstatus_intr>:
{
80002828:	fd010113          	addi	sp,sp,-48
8000282c:	02112623          	sw	ra,44(sp)
80002830:	02812423          	sw	s0,40(sp)
80002834:	03010413          	addi	s0,sp,48
80002838:	fca42e23          	sw	a0,-36(s0)
    uint32 x = r_mstatus();
8000283c:	f4dff0ef          	jal	ra,80002788 <r_mstatus>
80002840:	fea42623          	sw	a0,-20(s0)
    switch (m)
80002844:	fdc42703          	lw	a4,-36(s0)
80002848:	08000793          	li	a5,128
8000284c:	04f70263          	beq	a4,a5,80002890 <s_mstatus_intr+0x68>
80002850:	fdc42703          	lw	a4,-36(s0)
80002854:	08000793          	li	a5,128
80002858:	0ae7e463          	bltu	a5,a4,80002900 <s_mstatus_intr+0xd8>
8000285c:	fdc42703          	lw	a4,-36(s0)
80002860:	02000793          	li	a5,32
80002864:	04f70463          	beq	a4,a5,800028ac <s_mstatus_intr+0x84>
80002868:	fdc42703          	lw	a4,-36(s0)
8000286c:	02000793          	li	a5,32
80002870:	08e7e863          	bltu	a5,a4,80002900 <s_mstatus_intr+0xd8>
80002874:	fdc42703          	lw	a4,-36(s0)
80002878:	00200793          	li	a5,2
8000287c:	06f70463          	beq	a4,a5,800028e4 <s_mstatus_intr+0xbc>
80002880:	fdc42703          	lw	a4,-36(s0)
80002884:	00800793          	li	a5,8
80002888:	04f70063          	beq	a4,a5,800028c8 <s_mstatus_intr+0xa0>
        break;
8000288c:	0740006f          	j	80002900 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
80002890:	fec42783          	lw	a5,-20(s0)
80002894:	f7f7f793          	andi	a5,a5,-129
80002898:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
8000289c:	fec42783          	lw	a5,-20(s0)
800028a0:	0807e793          	ori	a5,a5,128
800028a4:	fef42623          	sw	a5,-20(s0)
        break;
800028a8:	05c0006f          	j	80002904 <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800028ac:	fec42783          	lw	a5,-20(s0)
800028b0:	fdf7f793          	andi	a5,a5,-33
800028b4:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
800028b8:	fec42783          	lw	a5,-20(s0)
800028bc:	0207e793          	ori	a5,a5,32
800028c0:	fef42623          	sw	a5,-20(s0)
        break;
800028c4:	0400006f          	j	80002904 <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
800028c8:	fec42783          	lw	a5,-20(s0)
800028cc:	ff77f793          	andi	a5,a5,-9
800028d0:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
800028d4:	fec42783          	lw	a5,-20(s0)
800028d8:	0087e793          	ori	a5,a5,8
800028dc:	fef42623          	sw	a5,-20(s0)
        break;
800028e0:	0240006f          	j	80002904 <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
800028e4:	fec42783          	lw	a5,-20(s0)
800028e8:	ffd7f793          	andi	a5,a5,-3
800028ec:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
800028f0:	fec42783          	lw	a5,-20(s0)
800028f4:	0027e793          	ori	a5,a5,2
800028f8:	fef42623          	sw	a5,-20(s0)
        break;
800028fc:	0080006f          	j	80002904 <s_mstatus_intr+0xdc>
        break;
80002900:	00000013          	nop
    w_mstatus(x);
80002904:	fec42503          	lw	a0,-20(s0)
80002908:	ea9ff0ef          	jal	ra,800027b0 <w_mstatus>
}
8000290c:	00000013          	nop
80002910:	02c12083          	lw	ra,44(sp)
80002914:	02812403          	lw	s0,40(sp)
80002918:	03010113          	addi	sp,sp,48
8000291c:	00008067          	ret

80002920 <r_sie>:
{
80002920:	fe010113          	addi	sp,sp,-32
80002924:	00812e23          	sw	s0,28(sp)
80002928:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie "
8000292c:	104027f3          	csrr	a5,sie
80002930:	fef42623          	sw	a5,-20(s0)
    return x;
80002934:	fec42783          	lw	a5,-20(s0)
}
80002938:	00078513          	mv	a0,a5
8000293c:	01c12403          	lw	s0,28(sp)
80002940:	02010113          	addi	sp,sp,32
80002944:	00008067          	ret

80002948 <w_sie>:
{
80002948:	fe010113          	addi	sp,sp,-32
8000294c:	00812e23          	sw	s0,28(sp)
80002950:	02010413          	addi	s0,sp,32
80002954:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"
80002958:	fec42783          	lw	a5,-20(s0)
8000295c:	10479073          	csrw	sie,a5
}
80002960:	00000013          	nop
80002964:	01c12403          	lw	s0,28(sp)
80002968:	02010113          	addi	sp,sp,32
8000296c:	00008067          	ret

80002970 <r_mie>:
#define MEIE (1 << 11)
#define MTIE (1 << 7)
#define MSIE (1 << 3)
static inline uint32 r_mie()
{
80002970:	fe010113          	addi	sp,sp,-32
80002974:	00812e23          	sw	s0,28(sp)
80002978:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie "
8000297c:	304027f3          	csrr	a5,mie
80002980:	fef42623          	sw	a5,-20(s0)
                 : "=r"(x));
    return x;
80002984:	fec42783          	lw	a5,-20(s0)
}
80002988:	00078513          	mv	a0,a5
8000298c:	01c12403          	lw	s0,28(sp)
80002990:	02010113          	addi	sp,sp,32
80002994:	00008067          	ret

80002998 <w_mie>:
static inline void w_mie(uint32 x)
{
80002998:	fe010113          	addi	sp,sp,-32
8000299c:	00812e23          	sw	s0,28(sp)
800029a0:	02010413          	addi	s0,sp,32
800029a4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"
800029a8:	fec42783          	lw	a5,-20(s0)
800029ac:	30479073          	csrw	mie,a5
                 :
                 : "r"(x));
}
800029b0:	00000013          	nop
800029b4:	01c12403          	lw	s0,28(sp)
800029b8:	02010113          	addi	sp,sp,32
800029bc:	00008067          	ret

800029c0 <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x)
{
800029c0:	fe010113          	addi	sp,sp,-32
800029c4:	00812e23          	sw	s0,28(sp)
800029c8:	02010413          	addi	s0,sp,32
800029cc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0"
800029d0:	fec42783          	lw	a5,-20(s0)
800029d4:	34079073          	csrw	mscratch,a5
                 :
                 : "r"(x));
800029d8:	00000013          	nop
800029dc:	01c12403          	lw	s0,28(sp)
800029e0:	02010113          	addi	sp,sp,32
800029e4:	00008067          	ret

800029e8 <timerinit>:
// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit()
{
800029e8:	fe010113          	addi	sp,sp,-32
800029ec:	00112e23          	sw	ra,28(sp)
800029f0:	00812c23          	sw	s0,24(sp)
800029f4:	01212a23          	sw	s2,20(sp)
800029f8:	01312823          	sw	s3,16(sp)
800029fc:	02010413          	addi	s0,sp,32
    uint hart = r_tp();
80002a00:	e01ff0ef          	jal	ra,80002800 <r_tp>
80002a04:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
80002a08:	fec42703          	lw	a4,-20(s0)
80002a0c:	00070793          	mv	a5,a4
80002a10:	00279793          	slli	a5,a5,0x2
80002a14:	00e787b3          	add	a5,a5,a4
80002a18:	00379793          	slli	a5,a5,0x3
80002a1c:	8000e737          	lui	a4,0x8000e
80002a20:	a5070713          	addi	a4,a4,-1456 # 8000da50 <memend+0xf800da50>
80002a24:	00e787b3          	add	a5,a5,a4
80002a28:	00078513          	mv	a0,a5
80002a2c:	f95ff0ef          	jal	ra,800029c0 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0] = CLINT_MTIMECMP(hart);
80002a30:	fec42703          	lw	a4,-20(s0)
80002a34:	004017b7          	lui	a5,0x401
80002a38:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002a3c:	00f707b3          	add	a5,a4,a5
80002a40:	00379793          	slli	a5,a5,0x3
80002a44:	00078913          	mv	s2,a5
80002a48:	00000993          	li	s3,0
80002a4c:	8000e7b7          	lui	a5,0x8000e
80002a50:	a5078693          	addi	a3,a5,-1456 # 8000da50 <memend+0xf800da50>
80002a54:	fec42703          	lw	a4,-20(s0)
80002a58:	00070793          	mv	a5,a4
80002a5c:	00279793          	slli	a5,a5,0x2
80002a60:	00e787b3          	add	a5,a5,a4
80002a64:	00379793          	slli	a5,a5,0x3
80002a68:	00f687b3          	add	a5,a3,a5
80002a6c:	0127a023          	sw	s2,0(a5)
80002a70:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1] = CLINT_INTERVAL;
80002a74:	8000e7b7          	lui	a5,0x8000e
80002a78:	a5078693          	addi	a3,a5,-1456 # 8000da50 <memend+0xf800da50>
80002a7c:	fec42703          	lw	a4,-20(s0)
80002a80:	00070793          	mv	a5,a4
80002a84:	00279793          	slli	a5,a5,0x2
80002a88:	00e787b3          	add	a5,a5,a4
80002a8c:	00379793          	slli	a5,a5,0x3
80002a90:	00f686b3          	add	a3,a3,a5
80002a94:	00989737          	lui	a4,0x989
80002a98:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002a9c:	00000793          	li	a5,0
80002aa0:	00e6a423          	sw	a4,8(a3)
80002aa4:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec); // 设置 M-mode time trap处理函数
80002aa8:	800007b7          	lui	a5,0x80000
80002aac:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
80002ab0:	00078513          	mv	a0,a5
80002ab4:	d25ff0ef          	jal	ra,800027d8 <w_mtvec>

    s_mstatus_intr(INTR_MIE); // 开启 M-mode 全局中断
80002ab8:	00800513          	li	a0,8
80002abc:	d6dff0ef          	jal	ra,80002828 <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
80002ac0:	e61ff0ef          	jal	ra,80002920 <r_sie>
80002ac4:	00050793          	mv	a5,a0
80002ac8:	2227e793          	ori	a5,a5,546
80002acc:	00078513          	mv	a0,a5
80002ad0:	e79ff0ef          	jal	ra,80002948 <w_sie>

    w_mie(r_mie() | MTIE); // 开启 M-mode 时钟中断
80002ad4:	e9dff0ef          	jal	ra,80002970 <r_mie>
80002ad8:	00050793          	mv	a5,a0
80002adc:	0807e793          	ori	a5,a5,128
80002ae0:	00078513          	mv	a0,a5
80002ae4:	eb5ff0ef          	jal	ra,80002998 <w_mie>

    clintinit(); // 初始化 CLINT
80002ae8:	c31ff0ef          	jal	ra,80002718 <clintinit>
80002aec:	00000013          	nop
80002af0:	01c12083          	lw	ra,28(sp)
80002af4:	01812403          	lw	s0,24(sp)
80002af8:	01412903          	lw	s2,20(sp)
80002afc:	01012983          	lw	s3,16(sp)
80002b00:	02010113          	addi	sp,sp,32
80002b04:	00008067          	ret

80002b08 <r_sepc>:
{
80002b08:	fe010113          	addi	sp,sp,-32
80002b0c:	00812e23          	sw	s0,28(sp)
80002b10:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, sepc"
80002b14:	141027f3          	csrr	a5,sepc
80002b18:	fef42623          	sw	a5,-20(s0)
    return x;
80002b1c:	fec42783          	lw	a5,-20(s0)
}
80002b20:	00078513          	mv	a0,a5
80002b24:	01c12403          	lw	s0,28(sp)
80002b28:	02010113          	addi	sp,sp,32
80002b2c:	00008067          	ret

80002b30 <syscall>:
    [SYS_fork] sys_fork,
    [SYS_exec] sys_exec,
};

void syscall()
{
80002b30:	fe010113          	addi	sp,sp,-32
80002b34:	00112e23          	sw	ra,28(sp)
80002b38:	00812c23          	sw	s0,24(sp)
80002b3c:	00912a23          	sw	s1,20(sp)
80002b40:	02010413          	addi	s0,sp,32
    struct pcb *p = nowproc();
80002b44:	bf4ff0ef          	jal	ra,80001f38 <nowproc>
80002b48:	fea42623          	sw	a0,-20(s0)
    p->trapframe->epc = r_sepc();
80002b4c:	fec42783          	lw	a5,-20(s0)
80002b50:	0087a483          	lw	s1,8(a5)
80002b54:	fb5ff0ef          	jal	ra,80002b08 <r_sepc>
80002b58:	00050793          	mv	a5,a0
80002b5c:	00f4a623          	sw	a5,12(s1)
    p->trapframe->epc += 4;
80002b60:	fec42783          	lw	a5,-20(s0)
80002b64:	0087a783          	lw	a5,8(a5)
80002b68:	00c7a703          	lw	a4,12(a5)
80002b6c:	fec42783          	lw	a5,-20(s0)
80002b70:	0087a783          	lw	a5,8(a5)
80002b74:	00470713          	addi	a4,a4,4
80002b78:	00e7a623          	sw	a4,12(a5)

    uint32 sysnum = p->trapframe->a7;
80002b7c:	fec42783          	lw	a5,-20(s0)
80002b80:	0087a783          	lw	a5,8(a5)
80002b84:	03c7a783          	lw	a5,60(a5)
80002b88:	fef42423          	sw	a5,-24(s0)
    p->trapframe->a0 = syscalls[sysnum]();
80002b8c:	8000b7b7          	lui	a5,0x8000b
80002b90:	01878713          	addi	a4,a5,24 # 8000b018 <memend+0xf800b018>
80002b94:	fe842783          	lw	a5,-24(s0)
80002b98:	00279793          	slli	a5,a5,0x2
80002b9c:	00f707b3          	add	a5,a4,a5
80002ba0:	0007a703          	lw	a4,0(a5)
80002ba4:	fec42783          	lw	a5,-20(s0)
80002ba8:	0087a483          	lw	s1,8(a5)
80002bac:	000700e7          	jalr	a4
80002bb0:	00050793          	mv	a5,a0
80002bb4:	02f4a023          	sw	a5,32(s1)
80002bb8:	00000013          	nop
80002bbc:	01c12083          	lw	ra,28(sp)
80002bc0:	01812403          	lw	s0,24(sp)
80002bc4:	01412483          	lw	s1,20(sp)
80002bc8:	02010113          	addi	sp,sp,32
80002bcc:	00008067          	ret

80002bd0 <mmioinit>:
#include "types.h"
#include "defs.h"
#include "mmio.h"

void mmioinit()
{
80002bd0:	ff010113          	addi	sp,sp,-16
80002bd4:	00112623          	sw	ra,12(sp)
80002bd8:	00812423          	sw	s0,8(sp)
80002bdc:	01010413          	addi	s0,sp,16
    printf("mmio_version: %x\n", mmio_read(MMIO_Version));
    printf("mmio_vendorID: %x\n", mmio_read(MMIO_VendorID));
    printf("mmio_deviceID: %x\n", mmio_read(MMIO_DeviceID));
#endif

    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
80002be0:	100017b7          	lui	a5,0x10001
80002be4:	0007a703          	lw	a4,0(a5) # 10001000 <sz+0x10000000>
80002be8:	747277b7          	lui	a5,0x74727
80002bec:	97678793          	addi	a5,a5,-1674 # 74726976 <sz+0x74725976>
80002bf0:	04f71263          	bne	a4,a5,80002c34 <mmioinit+0x64>
        mmio_read(MMIO_Version) != 0x01 ||
80002bf4:	100017b7          	lui	a5,0x10001
80002bf8:	00478793          	addi	a5,a5,4 # 10001004 <sz+0x10000004>
80002bfc:	0007a703          	lw	a4,0(a5)
    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
80002c00:	00100793          	li	a5,1
80002c04:	02f71863          	bne	a4,a5,80002c34 <mmioinit+0x64>
        mmio_read(MMIO_DeviceID) != 0x02 ||
80002c08:	100017b7          	lui	a5,0x10001
80002c0c:	00878793          	addi	a5,a5,8 # 10001008 <sz+0x10000008>
80002c10:	0007a703          	lw	a4,0(a5)
        mmio_read(MMIO_Version) != 0x01 ||
80002c14:	00200793          	li	a5,2
80002c18:	00f71e63          	bne	a4,a5,80002c34 <mmioinit+0x64>
        mmio_read(MMIO_VendorID) != 0x554d4551)
80002c1c:	100017b7          	lui	a5,0x10001
80002c20:	00c78793          	addi	a5,a5,12 # 1000100c <sz+0x1000000c>
80002c24:	0007a703          	lw	a4,0(a5)
        mmio_read(MMIO_DeviceID) != 0x02 ||
80002c28:	554d47b7          	lui	a5,0x554d4
80002c2c:	55178793          	addi	a5,a5,1361 # 554d4551 <sz+0x554d3551>
80002c30:	00f70863          	beq	a4,a5,80002c40 <mmioinit+0x70>
    {
        panic("virtio mmio disk!");
80002c34:	8000c7b7          	lui	a5,0x8000c
80002c38:	4a078513          	addi	a0,a5,1184 # 8000c4a0 <memend+0xf800c4a0>
80002c3c:	d50fe0ef          	jal	ra,8000118c <panic>
    }
80002c40:	00000013          	nop
80002c44:	00c12083          	lw	ra,12(sp)
80002c48:	00812403          	lw	s0,8(sp)
80002c4c:	01010113          	addi	sp,sp,16
80002c50:	00008067          	ret

80002c54 <textend>:
	...
