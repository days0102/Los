
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
80000020:	6880006f          	j	800006a8 <start>

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
800000ac:	2b1000ef          	jal	ra,80000b5c <trapvec>

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

// void saveframe(struct trapframe* tf)
.global usertrap
.align 2
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

.global loadframe
.align 2
loadframe:
    lw t6,0(a0)
8000031c:	00052f83          	lw	t6,0(a0)
    csrw satp,t6
80000320:	180f9073          	csrw	satp,t6
    sfence.vma zero, zero
80000324:	12000073          	sfence.vma

    lw ra,16(a0)
80000328:	01052083          	lw	ra,16(a0)
    lw sp,20(a0)
8000032c:	01452103          	lw	sp,20(a0)
    lw gp,24(a0)
80000330:	01852183          	lw	gp,24(a0)
    lw tp,28(a0)
80000334:	01c52203          	lw	tp,28(a0)

    lw a1,36(a0)
80000338:	02452583          	lw	a1,36(a0)
    lw a2,40(a0)
8000033c:	02852603          	lw	a2,40(a0)
    lw a3,44(a0)
80000340:	02c52683          	lw	a3,44(a0)
    lw a4,48(a0)
80000344:	03052703          	lw	a4,48(a0)
    lw a5,52(a0)
80000348:	03452783          	lw	a5,52(a0)
    lw a6,56(a0)
8000034c:	03852803          	lw	a6,56(a0)
    lw a5,52(a0)
80000350:	03452783          	lw	a5,52(a0)
    lw a7,60(a0)
80000354:	03c52883          	lw	a7,60(a0)
    lw s0,64(a0)
80000358:	04052403          	lw	s0,64(a0)
    lw s1,68(a0)
8000035c:	04452483          	lw	s1,68(a0)
    lw s2,72(a0)
80000360:	04852903          	lw	s2,72(a0)
    lw s3,76(a0)
80000364:	04c52983          	lw	s3,76(a0)
    lw s4,80(a0)
80000368:	05052a03          	lw	s4,80(a0)
    lw s5,84(a0)
8000036c:	05452a83          	lw	s5,84(a0)
    lw s6,88(a0)
80000370:	05852b03          	lw	s6,88(a0)
    lw s7,92(a0)
80000374:	05c52b83          	lw	s7,92(a0)
    lw s8,96(a0)
80000378:	06052c03          	lw	s8,96(a0)
    lw s9,100(a0)
8000037c:	06452c83          	lw	s9,100(a0)
    lw s10,104(a0)
80000380:	06852d03          	lw	s10,104(a0)
    lw s11,108(a0)
80000384:	06c52d83          	lw	s11,108(a0)
    lw t0,112(a0)
80000388:	07052283          	lw	t0,112(a0)
    lw t1,116(a0)
8000038c:	07452303          	lw	t1,116(a0)
    lw t2,120(a0)
80000390:	07852383          	lw	t2,120(a0)
    lw t3,124(a0)
80000394:	07c52e03          	lw	t3,124(a0)
    lw t4,128(a0)
80000398:	08052e83          	lw	t4,128(a0)
    lw t5,132(a0)
8000039c:	08452f03          	lw	t5,132(a0)
    lw t6,136(a0)
800003a0:	08852f83          	lw	t6,136(a0)

    lw a0,32(a0)
800003a4:	02052503          	lw	a0,32(a0)

800003a8:	10200073          	sret

800003ac <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
800003ac:	fe010113          	addi	sp,sp,-32
800003b0:	00812e23          	sw	s0,28(sp)
800003b4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
800003b8:	300027f3          	csrr	a5,mstatus
800003bc:	fef42623          	sw	a5,-20(s0)
    return x;
800003c0:	fec42783          	lw	a5,-20(s0)
}
800003c4:	00078513          	mv	a0,a5
800003c8:	01c12403          	lw	s0,28(sp)
800003cc:	02010113          	addi	sp,sp,32
800003d0:	00008067          	ret

800003d4 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
800003d4:	fe010113          	addi	sp,sp,-32
800003d8:	00812e23          	sw	s0,28(sp)
800003dc:	02010413          	addi	s0,sp,32
800003e0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
800003e4:	fec42783          	lw	a5,-20(s0)
800003e8:	30079073          	csrw	mstatus,a5
}
800003ec:	00000013          	nop
800003f0:	01c12403          	lw	s0,28(sp)
800003f4:	02010113          	addi	sp,sp,32
800003f8:	00008067          	ret

800003fc <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
800003fc:	fd010113          	addi	sp,sp,-48
80000400:	02112623          	sw	ra,44(sp)
80000404:	02812423          	sw	s0,40(sp)
80000408:	03010413          	addi	s0,sp,48
8000040c:	00050793          	mv	a5,a0
80000410:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
80000414:	f99ff0ef          	jal	ra,800003ac <r_mstatus>
80000418:	fea42623          	sw	a0,-20(s0)
    switch (m)
8000041c:	fdf44783          	lbu	a5,-33(s0)
80000420:	00300713          	li	a4,3
80000424:	06e78063          	beq	a5,a4,80000484 <s_mstatus_xpp+0x88>
80000428:	00300713          	li	a4,3
8000042c:	08f74263          	blt	a4,a5,800004b0 <s_mstatus_xpp+0xb4>
80000430:	00078863          	beqz	a5,80000440 <s_mstatus_xpp+0x44>
80000434:	00100713          	li	a4,1
80000438:	02e78063          	beq	a5,a4,80000458 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
8000043c:	0740006f          	j	800004b0 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
80000440:	fec42703          	lw	a4,-20(s0)
80000444:	ffffe7b7          	lui	a5,0xffffe
80000448:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
8000044c:	00f777b3          	and	a5,a4,a5
80000450:	fef42623          	sw	a5,-20(s0)
        break;
80000454:	0600006f          	j	800004b4 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80000458:	fec42703          	lw	a4,-20(s0)
8000045c:	ffffe7b7          	lui	a5,0xffffe
80000460:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000464:	00f777b3          	and	a5,a4,a5
80000468:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
8000046c:	fec42703          	lw	a4,-20(s0)
80000470:	000017b7          	lui	a5,0x1
80000474:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
80000478:	00f767b3          	or	a5,a4,a5
8000047c:	fef42623          	sw	a5,-20(s0)
        break;
80000480:	0340006f          	j	800004b4 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80000484:	fec42703          	lw	a4,-20(s0)
80000488:	ffffe7b7          	lui	a5,0xffffe
8000048c:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80000490:	00f777b3          	and	a5,a4,a5
80000494:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
80000498:	fec42703          	lw	a4,-20(s0)
8000049c:	000027b7          	lui	a5,0x2
800004a0:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
800004a4:	00f767b3          	or	a5,a4,a5
800004a8:	fef42623          	sw	a5,-20(s0)
        break;
800004ac:	0080006f          	j	800004b4 <s_mstatus_xpp+0xb8>
        break;
800004b0:	00000013          	nop
    }
    w_mstatus(x);
800004b4:	fec42503          	lw	a0,-20(s0)
800004b8:	f1dff0ef          	jal	ra,800003d4 <w_mstatus>
}
800004bc:	00000013          	nop
800004c0:	02c12083          	lw	ra,44(sp)
800004c4:	02812403          	lw	s0,40(sp)
800004c8:	03010113          	addi	sp,sp,48
800004cc:	00008067          	ret

800004d0 <r_sstatus>:

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus(){
800004d0:	fe010113          	addi	sp,sp,-32
800004d4:	00812e23          	sw	s0,28(sp)
800004d8:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sstatus" : "=r" (x) );
800004dc:	100027f3          	csrr	a5,sstatus
800004e0:	fef42623          	sw	a5,-20(s0)
    return x;
800004e4:	fec42783          	lw	a5,-20(s0)
}
800004e8:	00078513          	mv	a0,a5
800004ec:	01c12403          	lw	s0,28(sp)
800004f0:	02010113          	addi	sp,sp,32
800004f4:	00008067          	ret

800004f8 <w_sstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x){
800004f8:	fe010113          	addi	sp,sp,-32
800004fc:	00812e23          	sw	s0,28(sp)
80000500:	02010413          	addi	s0,sp,32
80000504:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sstatus, %0" : : "r" (x) );
80000508:	fec42783          	lw	a5,-20(s0)
8000050c:	10079073          	csrw	sstatus,a5
}
80000510:	00000013          	nop
80000514:	01c12403          	lw	s0,28(sp)
80000518:	02010113          	addi	sp,sp,32
8000051c:	00008067          	ret

80000520 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
80000520:	fe010113          	addi	sp,sp,-32
80000524:	00812e23          	sw	s0,28(sp)
80000528:	02010413          	addi	s0,sp,32
8000052c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
80000530:	fec42783          	lw	a5,-20(s0)
80000534:	34179073          	csrw	mepc,a5
}
80000538:	00000013          	nop
8000053c:	01c12403          	lw	s0,28(sp)
80000540:	02010113          	addi	sp,sp,32
80000544:	00008067          	ret

80000548 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80000548:	fe010113          	addi	sp,sp,-32
8000054c:	00812e23          	sw	s0,28(sp)
80000550:	02010413          	addi	s0,sp,32
80000554:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80000558:	fec42783          	lw	a5,-20(s0)
8000055c:	10579073          	csrw	stvec,a5
}
80000560:	00000013          	nop
80000564:	01c12403          	lw	s0,28(sp)
80000568:	02010113          	addi	sp,sp,32
8000056c:	00008067          	ret

80000570 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
80000570:	fe010113          	addi	sp,sp,-32
80000574:	00812e23          	sw	s0,28(sp)
80000578:	02010413          	addi	s0,sp,32
8000057c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
80000580:	fec42783          	lw	a5,-20(s0)
80000584:	30379073          	csrw	mideleg,a5
}
80000588:	00000013          	nop
8000058c:	01c12403          	lw	s0,28(sp)
80000590:	02010113          	addi	sp,sp,32
80000594:	00008067          	ret

80000598 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
80000598:	fe010113          	addi	sp,sp,-32
8000059c:	00812e23          	sw	s0,28(sp)
800005a0:	02010413          	addi	s0,sp,32
800005a4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
800005a8:	fec42783          	lw	a5,-20(s0)
800005ac:	30279073          	csrw	medeleg,a5
}
800005b0:	00000013          	nop
800005b4:	01c12403          	lw	s0,28(sp)
800005b8:	02010113          	addi	sp,sp,32
800005bc:	00008067          	ret

800005c0 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
800005c0:	fe010113          	addi	sp,sp,-32
800005c4:	00812e23          	sw	s0,28(sp)
800005c8:	02010413          	addi	s0,sp,32
800005cc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800005d0:	fec42783          	lw	a5,-20(s0)
800005d4:	18079073          	csrw	satp,a5
}
800005d8:	00000013          	nop
800005dc:	01c12403          	lw	s0,28(sp)
800005e0:	02010113          	addi	sp,sp,32
800005e4:	00008067          	ret

800005e8 <s_sstatus_intr>:
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m){
800005e8:	fd010113          	addi	sp,sp,-48
800005ec:	02112623          	sw	ra,44(sp)
800005f0:	02812423          	sw	s0,40(sp)
800005f4:	03010413          	addi	s0,sp,48
800005f8:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_sstatus();
800005fc:	ed5ff0ef          	jal	ra,800004d0 <r_sstatus>
80000600:	fea42623          	sw	a0,-20(s0)
    switch (m)
80000604:	fdc42703          	lw	a4,-36(s0)
80000608:	ffd00793          	li	a5,-3
8000060c:	06f70863          	beq	a4,a5,8000067c <s_sstatus_intr+0x94>
80000610:	fdc42703          	lw	a4,-36(s0)
80000614:	ffd00793          	li	a5,-3
80000618:	06e7e863          	bltu	a5,a4,80000688 <s_sstatus_intr+0xa0>
8000061c:	fdc42703          	lw	a4,-36(s0)
80000620:	fdf00793          	li	a5,-33
80000624:	02f70c63          	beq	a4,a5,8000065c <s_sstatus_intr+0x74>
80000628:	fdc42703          	lw	a4,-36(s0)
8000062c:	fdf00793          	li	a5,-33
80000630:	04e7ec63          	bltu	a5,a4,80000688 <s_sstatus_intr+0xa0>
80000634:	fdc42703          	lw	a4,-36(s0)
80000638:	00200793          	li	a5,2
8000063c:	02f70863          	beq	a4,a5,8000066c <s_sstatus_intr+0x84>
80000640:	fdc42703          	lw	a4,-36(s0)
80000644:	02000793          	li	a5,32
80000648:	04f71063          	bne	a4,a5,80000688 <s_sstatus_intr+0xa0>
    {
    case INTR_SPIE:
        x |= INTR_SPIE;    // 开
8000064c:	fec42783          	lw	a5,-20(s0)
80000650:	0207e793          	ori	a5,a5,32
80000654:	fef42623          	sw	a5,-20(s0)
        break;
80000658:	0340006f          	j	8000068c <s_sstatus_intr+0xa4>
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;   // 关
8000065c:	fec42783          	lw	a5,-20(s0)
80000660:	fdf7f793          	andi	a5,a5,-33
80000664:	fef42623          	sw	a5,-20(s0)
        break;
80000668:	0240006f          	j	8000068c <s_sstatus_intr+0xa4>
    case INTR_SIE:
        x |= INTR_SIE;     // 开
8000066c:	fec42783          	lw	a5,-20(s0)
80000670:	0027e793          	ori	a5,a5,2
80000674:	fef42623          	sw	a5,-20(s0)
        break;
80000678:	0140006f          	j	8000068c <s_sstatus_intr+0xa4>
    case ~INTR_SIE:
        x &= INTR_SIE;     // 关
8000067c:	fec42783          	lw	a5,-20(s0)
80000680:	0027f793          	andi	a5,a5,2
80000684:	fef42623          	sw	a5,-20(s0)
    default:
        break;   
80000688:	00000013          	nop
    }
    w_sstatus(x);
8000068c:	fec42503          	lw	a0,-20(s0)
80000690:	e69ff0ef          	jal	ra,800004f8 <w_sstatus>
}
80000694:	00000013          	nop
80000698:	02c12083          	lw	ra,44(sp)
8000069c:	02812403          	lw	s0,40(sp)
800006a0:	03010113          	addi	sp,sp,48
800006a4:	00008067          	ret

800006a8 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();     // 定义在main.c

void start(){
800006a8:	ff010113          	addi	sp,sp,-16
800006ac:	00112623          	sw	ra,12(sp)
800006b0:	00812423          	sw	s0,8(sp)
800006b4:	01010413          	addi	s0,sp,16
    uartinit();
800006b8:	07c000ef          	jal	ra,80000734 <uartinit>
    uartputs("Hello Los!\n");
800006bc:	800037b7          	lui	a5,0x80003
800006c0:	00078513          	mv	a0,a5
800006c4:	164000ef          	jal	ra,80000828 <uartputs>

    s_mstatus_xpp(RISCV_S);     // 设置特权模式为 S-mode
800006c8:	00100513          	li	a0,1
800006cc:	d31ff0ef          	jal	ra,800003fc <s_mstatus_xpp>

    w_satp((uint32)0);          // 暂时禁用分页
800006d0:	00000513          	li	a0,0
800006d4:	eedff0ef          	jal	ra,800005c0 <w_satp>

    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
800006d8:	000107b7          	lui	a5,0x10
800006dc:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
800006e0:	e91ff0ef          	jal	ra,80000570 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
800006e4:	000107b7          	lui	a5,0x10
800006e8:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
800006ec:	eadff0ef          	jal	ra,80000598 <w_medeleg>

    s_sstatus_intr(INTR_SIE);   // S-mode 开全局中断
800006f0:	00200513          	li	a0,2
800006f4:	ef5ff0ef          	jal	ra,800005e8 <s_sstatus_intr>
    
    w_stvec((uint32)kvec);      // 设置 S-mode trap处理函数
800006f8:	800007b7          	lui	a5,0x80000
800006fc:	02c78793          	addi	a5,a5,44 # 8000002c <memend+0xf800002c>
80000700:	00078513          	mv	a0,a5
80000704:	e45ff0ef          	jal	ra,80000548 <w_stvec>

    timerinit();                // 时钟定时器
80000708:	319010ef          	jal	ra,80002220 <timerinit>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
8000070c:	800017b7          	lui	a5,0x80001
80000710:	8f478793          	addi	a5,a5,-1804 # 800008f4 <memend+0xf80008f4>
80000714:	00078513          	mv	a0,a5
80000718:	e09ff0ef          	jal	ra,80000520 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");       // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
8000071c:	30200073          	mret
80000720:	00000013          	nop
80000724:	00c12083          	lw	ra,12(sp)
80000728:	00812403          	lw	s0,8(sp)
8000072c:	01010113          	addi	sp,sp,16
80000730:	00008067          	ret

80000734 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
80000734:	fe010113          	addi	sp,sp,-32
80000738:	00812e23          	sw	s0,28(sp)
8000073c:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
80000740:	100007b7          	lui	a5,0x10000
80000744:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000748:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
8000074c:	100007b7          	lui	a5,0x10000
80000750:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000754:	0007c783          	lbu	a5,0(a5)
80000758:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
8000075c:	100007b7          	lui	a5,0x10000
80000760:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000764:	fef44703          	lbu	a4,-17(s0)
80000768:	f8076713          	ori	a4,a4,-128
8000076c:	0ff77713          	andi	a4,a4,255
80000770:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
80000774:	100007b7          	lui	a5,0x10000
80000778:	00300713          	li	a4,3
8000077c:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
80000780:	100007b7          	lui	a5,0x10000
80000784:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
80000788:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
8000078c:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80000790:	100007b7          	lui	a5,0x10000
80000794:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
80000798:	fef44703          	lbu	a4,-17(s0)
8000079c:	00376713          	ori	a4,a4,3
800007a0:	0ff77713          	andi	a4,a4,255
800007a4:	00e78023          	sb	a4,0(a5)

    // 开中断
    uart_write(UART_IER,uart_read(UART_IER)|(1<<0));
800007a8:	100007b7          	lui	a5,0x10000
800007ac:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007b0:	0007c783          	lbu	a5,0(a5)
800007b4:	0ff7f713          	andi	a4,a5,255
800007b8:	100007b7          	lui	a5,0x10000
800007bc:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800007c0:	00176713          	ori	a4,a4,1
800007c4:	0ff77713          	andi	a4,a4,255
800007c8:	00e78023          	sb	a4,0(a5)
}
800007cc:	00000013          	nop
800007d0:	01c12403          	lw	s0,28(sp)
800007d4:	02010113          	addi	sp,sp,32
800007d8:	00008067          	ret

800007dc <uartputc>:

// 轮询处理数据
char uartputc(char c){
800007dc:	fe010113          	addi	sp,sp,-32
800007e0:	00812e23          	sw	s0,28(sp)
800007e4:	02010413          	addi	s0,sp,32
800007e8:	00050793          	mv	a5,a0
800007ec:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
800007f0:	00000013          	nop
800007f4:	100007b7          	lui	a5,0x10000
800007f8:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
800007fc:	0007c783          	lbu	a5,0(a5)
80000800:	0ff7f793          	andi	a5,a5,255
80000804:	0207f793          	andi	a5,a5,32
80000808:	fe0786e3          	beqz	a5,800007f4 <uartputc+0x18>
    return uart_write(UART_THR,c);
8000080c:	10000737          	lui	a4,0x10000
80000810:	fef44783          	lbu	a5,-17(s0)
80000814:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
80000818:	00078513          	mv	a0,a5
8000081c:	01c12403          	lw	s0,28(sp)
80000820:	02010113          	addi	sp,sp,32
80000824:	00008067          	ret

80000828 <uartputs>:

// 发送字符串
void uartputs(char* s){
80000828:	fe010113          	addi	sp,sp,-32
8000082c:	00112e23          	sw	ra,28(sp)
80000830:	00812c23          	sw	s0,24(sp)
80000834:	02010413          	addi	s0,sp,32
80000838:	fea42623          	sw	a0,-20(s0)
    while (*s)
8000083c:	01c0006f          	j	80000858 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
80000840:	fec42783          	lw	a5,-20(s0)
80000844:	00178713          	addi	a4,a5,1
80000848:	fee42623          	sw	a4,-20(s0)
8000084c:	0007c783          	lbu	a5,0(a5)
80000850:	00078513          	mv	a0,a5
80000854:	f89ff0ef          	jal	ra,800007dc <uartputc>
    while (*s)
80000858:	fec42783          	lw	a5,-20(s0)
8000085c:	0007c783          	lbu	a5,0(a5)
80000860:	fe0790e3          	bnez	a5,80000840 <uartputs+0x18>
    }
    
}
80000864:	00000013          	nop
80000868:	00000013          	nop
8000086c:	01c12083          	lw	ra,28(sp)
80000870:	01812403          	lw	s0,24(sp)
80000874:	02010113          	addi	sp,sp,32
80000878:	00008067          	ret

8000087c <uartgetc>:

// 接收输入
int uartgetc(){
8000087c:	ff010113          	addi	sp,sp,-16
80000880:	00812623          	sw	s0,12(sp)
80000884:	01010413          	addi	s0,sp,16
    if(uart_read(UART_LSR)&(1<<0)){
80000888:	100007b7          	lui	a5,0x10000
8000088c:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
80000890:	0007c783          	lbu	a5,0(a5)
80000894:	0ff7f793          	andi	a5,a5,255
80000898:	0017f793          	andi	a5,a5,1
8000089c:	00078a63          	beqz	a5,800008b0 <uartgetc+0x34>
        return uart_read(UART_RHR);
800008a0:	100007b7          	lui	a5,0x10000
800008a4:	0007c783          	lbu	a5,0(a5) # 10000000 <sz+0xffff000>
800008a8:	0ff7f793          	andi	a5,a5,255
800008ac:	0080006f          	j	800008b4 <uartgetc+0x38>
    }else{
        return -1;
800008b0:	fff00793          	li	a5,-1
    }
}
800008b4:	00078513          	mv	a0,a5
800008b8:	00c12403          	lw	s0,12(sp)
800008bc:	01010113          	addi	sp,sp,16
800008c0:	00008067          	ret

800008c4 <uartintr>:

// 键盘输入中断
char uartintr(){
800008c4:	ff010113          	addi	sp,sp,-16
800008c8:	00112623          	sw	ra,12(sp)
800008cc:	00812423          	sw	s0,8(sp)
800008d0:	01010413          	addi	s0,sp,16
    return uartgetc();
800008d4:	fa9ff0ef          	jal	ra,8000087c <uartgetc>
800008d8:	00050793          	mv	a5,a0
800008dc:	0ff7f793          	andi	a5,a5,255
800008e0:	00078513          	mv	a0,a5
800008e4:	00c12083          	lw	ra,12(sp)
800008e8:	00812403          	lw	s0,8(sp)
800008ec:	01010113          	addi	sp,sp,16
800008f0:	00008067          	ret

800008f4 <main>:
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

void main(){
800008f4:	ff010113          	addi	sp,sp,-16
800008f8:	00112623          	sw	ra,12(sp)
800008fc:	00812423          	sw	s0,8(sp)
80000900:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
80000904:	800037b7          	lui	a5,0x80003
80000908:	00c78513          	addi	a0,a5,12 # 8000300c <memend+0xf800300c>
8000090c:	498000ef          	jal	ra,80000da4 <printf>

    minit();        // 物理内存管理
80000910:	0a1000ef          	jal	ra,800011b0 <minit>
    plicinit();     // PLIC 中断处理
80000914:	23d000ef          	jal	ra,80001350 <plicinit>
    
    kvminit();       // 启动虚拟内存
80000918:	6f1000ef          	jal	ra,80001808 <kvminit>
    
    printf("----------------------\n");
8000091c:	800037b7          	lui	a5,0x80003
80000920:	02078513          	addi	a0,a5,32 # 80003020 <memend+0xf8003020>
80000924:	480000ef          	jal	ra,80000da4 <printf>
    while(1);
80000928:	0000006f          	j	80000928 <main+0x34>

8000092c <r_sepc>:

/**
 * @description: 读取 sepc 寄存器
 * S-mode 返回时跳转到 pc = sepc指向的地址
 */
static inline uint32 r_sepc(){
8000092c:	fe010113          	addi	sp,sp,-32
80000930:	00812e23          	sw	s0,28(sp)
80000934:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sepc" : "=r" (x) );
80000938:	141027f3          	csrr	a5,sepc
8000093c:	fef42623          	sw	a5,-20(s0)
    return x;
80000940:	fec42783          	lw	a5,-20(s0)
}
80000944:	00078513          	mv	a0,a5
80000948:	01c12403          	lw	s0,28(sp)
8000094c:	02010113          	addi	sp,sp,32
80000950:	00008067          	ret

80000954 <w_sepc>:
// 写 sepc寄存器
static inline void w_sepc(uint32 x){
80000954:	fe010113          	addi	sp,sp,-32
80000958:	00812e23          	sw	s0,28(sp)
8000095c:	02010413          	addi	s0,sp,32
80000960:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
80000964:	fec42783          	lw	a5,-20(s0)
80000968:	14179073          	csrw	sepc,a5
}
8000096c:	00000013          	nop
80000970:	01c12403          	lw	s0,28(sp)
80000974:	02010113          	addi	sp,sp,32
80000978:	00008067          	ret

8000097c <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
8000097c:	fe010113          	addi	sp,sp,-32
80000980:	00812e23          	sw	s0,28(sp)
80000984:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
80000988:	142027f3          	csrr	a5,scause
8000098c:	fef42623          	sw	a5,-20(s0)
    return x;
80000990:	fec42783          	lw	a5,-20(s0)
}
80000994:	00078513          	mv	a0,a5
80000998:	01c12403          	lw	s0,28(sp)
8000099c:	02010113          	addi	sp,sp,32
800009a0:	00008067          	ret

800009a4 <r_sip>:

/**
 * @description: 
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip(){
800009a4:	fe010113          	addi	sp,sp,-32
800009a8:	00812e23          	sw	s0,28(sp)
800009ac:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip":"=r"(x));
800009b0:	144027f3          	csrr	a5,sip
800009b4:	fef42623          	sw	a5,-20(s0)
    return x;
800009b8:	fec42783          	lw	a5,-20(s0)
}
800009bc:	00078513          	mv	a0,a5
800009c0:	01c12403          	lw	s0,28(sp)
800009c4:	02010113          	addi	sp,sp,32
800009c8:	00008067          	ret

800009cc <w_sip>:
static inline void w_sip(uint32 x){
800009cc:	fe010113          	addi	sp,sp,-32
800009d0:	00812e23          	sw	s0,28(sp)
800009d4:	02010413          	addi	s0,sp,32
800009d8:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"::"r"(x));
800009dc:	fec42783          	lw	a5,-20(s0)
800009e0:	14479073          	csrw	sip,a5
}
800009e4:	00000013          	nop
800009e8:	01c12403          	lw	s0,28(sp)
800009ec:	02010113          	addi	sp,sp,32
800009f0:	00008067          	ret

800009f4 <externinterrupt>:
#include "clint.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
800009f4:	fe010113          	addi	sp,sp,-32
800009f8:	00112e23          	sw	ra,28(sp)
800009fc:	00812c23          	sw	s0,24(sp)
80000a00:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000a04:	211000ef          	jal	ra,80001414 <r_plicclaim>
80000a08:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000a0c:	fec42583          	lw	a1,-20(s0)
80000a10:	800037b7          	lui	a5,0x80003
80000a14:	03878513          	addi	a0,a5,56 # 80003038 <memend+0xf8003038>
80000a18:	38c000ef          	jal	ra,80000da4 <printf>
    switch (irq)
80000a1c:	fec42703          	lw	a4,-20(s0)
80000a20:	00a00793          	li	a5,10
80000a24:	02f71063          	bne	a4,a5,80000a44 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80000a28:	e9dff0ef          	jal	ra,800008c4 <uartintr>
80000a2c:	00050793          	mv	a5,a0
80000a30:	00078593          	mv	a1,a5
80000a34:	800037b7          	lui	a5,0x80003
80000a38:	04478513          	addi	a0,a5,68 # 80003044 <memend+0xf8003044>
80000a3c:	368000ef          	jal	ra,80000da4 <printf>
        break;
80000a40:	0080006f          	j	80000a48 <externinterrupt+0x54>
    default:
        break;
80000a44:	00000013          	nop
    }
    w_pliccomplete(irq);
80000a48:	fec42503          	lw	a0,-20(s0)
80000a4c:	209000ef          	jal	ra,80001454 <w_pliccomplete>
}
80000a50:	00000013          	nop
80000a54:	01c12083          	lw	ra,28(sp)
80000a58:	01812403          	lw	s0,24(sp)
80000a5c:	02010113          	addi	sp,sp,32
80000a60:	00008067          	ret

80000a64 <usertrapret>:

// 返回用户空间
void usertrapret(){
80000a64:	fe010113          	addi	sp,sp,-32
80000a68:	00112e23          	sw	ra,28(sp)
80000a6c:	00812c23          	sw	s0,24(sp)
80000a70:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80000a74:	058010ef          	jal	ra,80001acc <nowproc>
80000a78:	fea42623          	sw	a0,-20(s0)
    loadframe(&p->trapframe);
80000a7c:	fec42783          	lw	a5,-20(s0)
80000a80:	00878793          	addi	a5,a5,8
80000a84:	00078513          	mv	a0,a5
80000a88:	895ff0ef          	jal	ra,8000031c <loadframe>
}
80000a8c:	00000013          	nop
80000a90:	01c12083          	lw	ra,28(sp)
80000a94:	01812403          	lw	s0,24(sp)
80000a98:	02010113          	addi	sp,sp,32
80000a9c:	00008067          	ret

80000aa0 <zero>:

void zero(){
80000aa0:	fe010113          	addi	sp,sp,-32
80000aa4:	00112e23          	sw	ra,28(sp)
80000aa8:	00812c23          	sw	s0,24(sp)
80000aac:	02010413          	addi	s0,sp,32
    printf("zero\n");
80000ab0:	800037b7          	lui	a5,0x80003
80000ab4:	05478513          	addi	a0,a5,84 # 80003054 <memend+0xf8003054>
80000ab8:	2ec000ef          	jal	ra,80000da4 <printf>
    reg_t pc=r_sepc();
80000abc:	e71ff0ef          	jal	ra,8000092c <r_sepc>
80000ac0:	fea42423          	sw	a0,-24(s0)
    w_sepc(pc+4);
80000ac4:	fe842783          	lw	a5,-24(s0)
80000ac8:	00478793          	addi	a5,a5,4
80000acc:	00078513          	mv	a0,a5
80000ad0:	e85ff0ef          	jal	ra,80000954 <w_sepc>
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80000ad4:	8000d7b7          	lui	a5,0x8000d
80000ad8:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80000adc:	fef42623          	sw	a5,-20(s0)
80000ae0:	0100006f          	j	80000af0 <zero+0x50>
80000ae4:	fec42783          	lw	a5,-20(s0)
80000ae8:	11878793          	addi	a5,a5,280
80000aec:	fef42623          	sw	a5,-20(s0)
80000af0:	fec42703          	lw	a4,-20(s0)
80000af4:	8000e7b7          	lui	a5,0x8000e
80000af8:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80000afc:	fef764e3          	bltu	a4,a5,80000ae4 <zero+0x44>
        if(p->status==RUNABLE){
            
        }
    }
    usertrapret();
80000b00:	f65ff0ef          	jal	ra,80000a64 <usertrapret>
}
80000b04:	00000013          	nop
80000b08:	01c12083          	lw	ra,28(sp)
80000b0c:	01812403          	lw	s0,24(sp)
80000b10:	02010113          	addi	sp,sp,32
80000b14:	00008067          	ret

80000b18 <timerintr>:

void timerintr(){
80000b18:	ff010113          	addi	sp,sp,-16
80000b1c:	00112623          	sw	ra,12(sp)
80000b20:	00812423          	sw	s0,8(sp)
80000b24:	01010413          	addi	s0,sp,16
    w_sip(r_sip()& ~2); // 清除中断
80000b28:	e7dff0ef          	jal	ra,800009a4 <r_sip>
80000b2c:	00050793          	mv	a5,a0
80000b30:	ffd7f793          	andi	a5,a5,-3
80000b34:	00078513          	mv	a0,a5
80000b38:	e95ff0ef          	jal	ra,800009cc <w_sip>
    printf("timer interrupt\n");
80000b3c:	800037b7          	lui	a5,0x80003
80000b40:	05c78513          	addi	a0,a5,92 # 8000305c <memend+0xf800305c>
80000b44:	260000ef          	jal	ra,80000da4 <printf>
}
80000b48:	00000013          	nop
80000b4c:	00c12083          	lw	ra,12(sp)
80000b50:	00812403          	lw	s0,8(sp)
80000b54:	01010113          	addi	sp,sp,16
80000b58:	00008067          	ret

80000b5c <trapvec>:

void trapvec(){
80000b5c:	fe010113          	addi	sp,sp,-32
80000b60:	00112e23          	sw	ra,28(sp)
80000b64:	00812c23          	sw	s0,24(sp)
80000b68:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000b6c:	e11ff0ef          	jal	ra,8000097c <r_scause>
80000b70:	fea42423          	sw	a0,-24(s0)
    printf("sip : %d\n",r_sip());
80000b74:	e31ff0ef          	jal	ra,800009a4 <r_sip>
80000b78:	00050793          	mv	a5,a0
80000b7c:	00078593          	mv	a1,a5
80000b80:	800037b7          	lui	a5,0x80003
80000b84:	07078513          	addi	a0,a5,112 # 80003070 <memend+0xf8003070>
80000b88:	21c000ef          	jal	ra,80000da4 <printf>

    uint16 code= scause & 0xffff;
80000b8c:	fe842783          	lw	a5,-24(s0)
80000b90:	fef41323          	sh	a5,-26(s0)

    if(scause & (1<<31)){
80000b94:	fe842783          	lw	a5,-24(s0)
80000b98:	0807d063          	bgez	a5,80000c18 <trapvec+0xbc>
        printf("Interrupt : ");
80000b9c:	800037b7          	lui	a5,0x80003
80000ba0:	07c78513          	addi	a0,a5,124 # 8000307c <memend+0xf800307c>
80000ba4:	200000ef          	jal	ra,80000da4 <printf>
        switch (code)
80000ba8:	fe645783          	lhu	a5,-26(s0)
80000bac:	00900713          	li	a4,9
80000bb0:	04e78263          	beq	a5,a4,80000bf4 <trapvec+0x98>
80000bb4:	00900713          	li	a4,9
80000bb8:	04f74863          	blt	a4,a5,80000c08 <trapvec+0xac>
80000bbc:	00100713          	li	a4,1
80000bc0:	00e78863          	beq	a5,a4,80000bd0 <trapvec+0x74>
80000bc4:	00500713          	li	a4,5
80000bc8:	00e78e63          	beq	a5,a4,80000be4 <trapvec+0x88>
80000bcc:	03c0006f          	j	80000c08 <trapvec+0xac>
        {
        case 1:
            printf("Supervisor software interrupt\n");
80000bd0:	800037b7          	lui	a5,0x80003
80000bd4:	08c78513          	addi	a0,a5,140 # 8000308c <memend+0xf800308c>
80000bd8:	1cc000ef          	jal	ra,80000da4 <printf>
            timerintr();
80000bdc:	f3dff0ef          	jal	ra,80000b18 <timerintr>
            break;
80000be0:	1780006f          	j	80000d58 <trapvec+0x1fc>
        case 5:
            printf("Supervisor timer interrupt\n");
80000be4:	800037b7          	lui	a5,0x80003
80000be8:	0ac78513          	addi	a0,a5,172 # 800030ac <memend+0xf80030ac>
80000bec:	1b8000ef          	jal	ra,80000da4 <printf>
            break;
80000bf0:	1680006f          	j	80000d58 <trapvec+0x1fc>
        case 9:
            printf("Supervisor external interrupt\n");
80000bf4:	800037b7          	lui	a5,0x80003
80000bf8:	0c878513          	addi	a0,a5,200 # 800030c8 <memend+0xf80030c8>
80000bfc:	1a8000ef          	jal	ra,80000da4 <printf>
            externinterrupt();
80000c00:	df5ff0ef          	jal	ra,800009f4 <externinterrupt>
            break;
80000c04:	1540006f          	j	80000d58 <trapvec+0x1fc>
        default:
            printf("Other interrupt\n");
80000c08:	800037b7          	lui	a5,0x80003
80000c0c:	0e878513          	addi	a0,a5,232 # 800030e8 <memend+0xf80030e8>
80000c10:	194000ef          	jal	ra,80000da4 <printf>
            break;
80000c14:	1440006f          	j	80000d58 <trapvec+0x1fc>
        }
    }else{
        int ecall=0;
80000c18:	fe042623          	sw	zero,-20(s0)
        printf("Exception : ");
80000c1c:	800037b7          	lui	a5,0x80003
80000c20:	0fc78513          	addi	a0,a5,252 # 800030fc <memend+0xf80030fc>
80000c24:	180000ef          	jal	ra,80000da4 <printf>
        switch (code)
80000c28:	fe645783          	lhu	a5,-26(s0)
80000c2c:	00f00713          	li	a4,15
80000c30:	0ef76c63          	bltu	a4,a5,80000d28 <trapvec+0x1cc>
80000c34:	00279713          	slli	a4,a5,0x2
80000c38:	800037b7          	lui	a5,0x80003
80000c3c:	27078793          	addi	a5,a5,624 # 80003270 <memend+0xf8003270>
80000c40:	00f707b3          	add	a5,a4,a5
80000c44:	0007a783          	lw	a5,0(a5)
80000c48:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000c4c:	800037b7          	lui	a5,0x80003
80000c50:	10c78513          	addi	a0,a5,268 # 8000310c <memend+0xf800310c>
80000c54:	150000ef          	jal	ra,80000da4 <printf>
            break;
80000c58:	0e00006f          	j	80000d38 <trapvec+0x1dc>
        case 1:
            printf("Instruction access fault\n");
80000c5c:	800037b7          	lui	a5,0x80003
80000c60:	12c78513          	addi	a0,a5,300 # 8000312c <memend+0xf800312c>
80000c64:	140000ef          	jal	ra,80000da4 <printf>
            break;
80000c68:	0d00006f          	j	80000d38 <trapvec+0x1dc>
        case 2:
            printf("Illegal instruction\n");
80000c6c:	800037b7          	lui	a5,0x80003
80000c70:	14878513          	addi	a0,a5,328 # 80003148 <memend+0xf8003148>
80000c74:	130000ef          	jal	ra,80000da4 <printf>
            break;
80000c78:	0c00006f          	j	80000d38 <trapvec+0x1dc>
        case 3:
            printf("Breakpoint\n");
80000c7c:	800037b7          	lui	a5,0x80003
80000c80:	16078513          	addi	a0,a5,352 # 80003160 <memend+0xf8003160>
80000c84:	120000ef          	jal	ra,80000da4 <printf>
            break;
80000c88:	0b00006f          	j	80000d38 <trapvec+0x1dc>
        case 4:
            printf("Load address misaligned\n");
80000c8c:	800037b7          	lui	a5,0x80003
80000c90:	16c78513          	addi	a0,a5,364 # 8000316c <memend+0xf800316c>
80000c94:	110000ef          	jal	ra,80000da4 <printf>
            break;
80000c98:	0a00006f          	j	80000d38 <trapvec+0x1dc>
        case 5:
            printf("Load access fault\n");
80000c9c:	800037b7          	lui	a5,0x80003
80000ca0:	18878513          	addi	a0,a5,392 # 80003188 <memend+0xf8003188>
80000ca4:	100000ef          	jal	ra,80000da4 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000ca8:	0900006f          	j	80000d38 <trapvec+0x1dc>
        case 6:
            printf("Store/AMO address misaligned\n");
80000cac:	800037b7          	lui	a5,0x80003
80000cb0:	19c78513          	addi	a0,a5,412 # 8000319c <memend+0xf800319c>
80000cb4:	0f0000ef          	jal	ra,80000da4 <printf>
            break;
80000cb8:	0800006f          	j	80000d38 <trapvec+0x1dc>
        case 7:
            printf("Store/AMO access fault\n");
80000cbc:	800037b7          	lui	a5,0x80003
80000cc0:	1bc78513          	addi	a0,a5,444 # 800031bc <memend+0xf80031bc>
80000cc4:	0e0000ef          	jal	ra,80000da4 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000cc8:	0700006f          	j	80000d38 <trapvec+0x1dc>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000ccc:	800037b7          	lui	a5,0x80003
80000cd0:	1d478513          	addi	a0,a5,468 # 800031d4 <memend+0xf80031d4>
80000cd4:	0d0000ef          	jal	ra,80000da4 <printf>
            break;
80000cd8:	0600006f          	j	80000d38 <trapvec+0x1dc>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000cdc:	800037b7          	lui	a5,0x80003
80000ce0:	1f478513          	addi	a0,a5,500 # 800031f4 <memend+0xf80031f4>
80000ce4:	0c0000ef          	jal	ra,80000da4 <printf>
            zero();
80000ce8:	db9ff0ef          	jal	ra,80000aa0 <zero>
            ecall=1;
80000cec:	00100793          	li	a5,1
80000cf0:	fef42623          	sw	a5,-20(s0)
            break;
80000cf4:	0440006f          	j	80000d38 <trapvec+0x1dc>
        case 12:
            printf("Instruction page fault\n");
80000cf8:	800037b7          	lui	a5,0x80003
80000cfc:	21478513          	addi	a0,a5,532 # 80003214 <memend+0xf8003214>
80000d00:	0a4000ef          	jal	ra,80000da4 <printf>
            break;
80000d04:	0340006f          	j	80000d38 <trapvec+0x1dc>
        case 13:
            printf("Load page fault\n");
80000d08:	800037b7          	lui	a5,0x80003
80000d0c:	22c78513          	addi	a0,a5,556 # 8000322c <memend+0xf800322c>
80000d10:	094000ef          	jal	ra,80000da4 <printf>
            break;
80000d14:	0240006f          	j	80000d38 <trapvec+0x1dc>
        case 15:
            printf("Store/AMO page fault\n");
80000d18:	800037b7          	lui	a5,0x80003
80000d1c:	24078513          	addi	a0,a5,576 # 80003240 <memend+0xf8003240>
80000d20:	084000ef          	jal	ra,80000da4 <printf>
            break;
80000d24:	0140006f          	j	80000d38 <trapvec+0x1dc>
        default:
            printf("Other\n");
80000d28:	800037b7          	lui	a5,0x80003
80000d2c:	25878513          	addi	a0,a5,600 # 80003258 <memend+0xf8003258>
80000d30:	074000ef          	jal	ra,80000da4 <printf>
            break;
80000d34:	00000013          	nop
        }
        if(!ecall){
80000d38:	fec42783          	lw	a5,-20(s0)
80000d3c:	00079e63          	bnez	a5,80000d58 <trapvec+0x1fc>
            panic("Trap Exception");
80000d40:	800037b7          	lui	a5,0x80003
80000d44:	26078513          	addi	a0,a5,608 # 80003260 <memend+0xf8003260>
80000d48:	024000ef          	jal	ra,80000d6c <panic>
            ecall=1;
80000d4c:	00100793          	li	a5,1
80000d50:	fef42623          	sw	a5,-20(s0)
        }
    }
}
80000d54:	0040006f          	j	80000d58 <trapvec+0x1fc>
80000d58:	00000013          	nop
80000d5c:	01c12083          	lw	ra,28(sp)
80000d60:	01812403          	lw	s0,24(sp)
80000d64:	02010113          	addi	sp,sp,32
80000d68:	00008067          	ret

80000d6c <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000d6c:	fe010113          	addi	sp,sp,-32
80000d70:	00112e23          	sw	ra,28(sp)
80000d74:	00812c23          	sw	s0,24(sp)
80000d78:	02010413          	addi	s0,sp,32
80000d7c:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000d80:	800037b7          	lui	a5,0x80003
80000d84:	2b078513          	addi	a0,a5,688 # 800032b0 <memend+0xf80032b0>
80000d88:	aa1ff0ef          	jal	ra,80000828 <uartputs>
    uartputs(s);
80000d8c:	fec42503          	lw	a0,-20(s0)
80000d90:	a99ff0ef          	jal	ra,80000828 <uartputs>
	uartputs("\n");
80000d94:	800037b7          	lui	a5,0x80003
80000d98:	2b878513          	addi	a0,a5,696 # 800032b8 <memend+0xf80032b8>
80000d9c:	a8dff0ef          	jal	ra,80000828 <uartputs>
    while(1);
80000da0:	0000006f          	j	80000da0 <panic+0x34>

80000da4 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000da4:	f8010113          	addi	sp,sp,-128
80000da8:	04112e23          	sw	ra,92(sp)
80000dac:	04812c23          	sw	s0,88(sp)
80000db0:	06010413          	addi	s0,sp,96
80000db4:	faa42623          	sw	a0,-84(s0)
80000db8:	00b42223          	sw	a1,4(s0)
80000dbc:	00c42423          	sw	a2,8(s0)
80000dc0:	00d42623          	sw	a3,12(s0)
80000dc4:	00e42823          	sw	a4,16(s0)
80000dc8:	00f42a23          	sw	a5,20(s0)
80000dcc:	01042c23          	sw	a6,24(s0)
80000dd0:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000dd4:	02040793          	addi	a5,s0,32
80000dd8:	faf42423          	sw	a5,-88(s0)
80000ddc:	fa842783          	lw	a5,-88(s0)
80000de0:	fe478793          	addi	a5,a5,-28
80000de4:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000de8:	fac42783          	lw	a5,-84(s0)
80000dec:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000df0:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000df4:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
80000df8:	36c0006f          	j	80001164 <printf+0x3c0>
		if(ch=='%'){
80000dfc:	fbf44703          	lbu	a4,-65(s0)
80000e00:	02500793          	li	a5,37
80000e04:	04f71863          	bne	a4,a5,80000e54 <printf+0xb0>
			if(tt==1){
80000e08:	fe842703          	lw	a4,-24(s0)
80000e0c:	00100793          	li	a5,1
80000e10:	02f71663          	bne	a4,a5,80000e3c <printf+0x98>
				outbuf[idx++]='%';
80000e14:	fe442783          	lw	a5,-28(s0)
80000e18:	00178713          	addi	a4,a5,1
80000e1c:	fee42223          	sw	a4,-28(s0)
80000e20:	8000d737          	lui	a4,0x8000d
80000e24:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000e28:	00f707b3          	add	a5,a4,a5
80000e2c:	02500713          	li	a4,37
80000e30:	00e78023          	sb	a4,0(a5)
				tt=0;
80000e34:	fe042423          	sw	zero,-24(s0)
80000e38:	00c0006f          	j	80000e44 <printf+0xa0>
			}else{
				tt=1;
80000e3c:	00100793          	li	a5,1
80000e40:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000e44:	fec42783          	lw	a5,-20(s0)
80000e48:	00178793          	addi	a5,a5,1
80000e4c:	fef42623          	sw	a5,-20(s0)
80000e50:	3140006f          	j	80001164 <printf+0x3c0>
		}else{
			if(tt==1){
80000e54:	fe842703          	lw	a4,-24(s0)
80000e58:	00100793          	li	a5,1
80000e5c:	2cf71e63          	bne	a4,a5,80001138 <printf+0x394>
				switch (ch)
80000e60:	fbf44783          	lbu	a5,-65(s0)
80000e64:	fa878793          	addi	a5,a5,-88
80000e68:	02000713          	li	a4,32
80000e6c:	2af76663          	bltu	a4,a5,80001118 <printf+0x374>
80000e70:	00279713          	slli	a4,a5,0x2
80000e74:	800037b7          	lui	a5,0x80003
80000e78:	2d478793          	addi	a5,a5,724 # 800032d4 <memend+0xf80032d4>
80000e7c:	00f707b3          	add	a5,a4,a5
80000e80:	0007a783          	lw	a5,0(a5)
80000e84:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000e88:	fb842783          	lw	a5,-72(s0)
80000e8c:	00478713          	addi	a4,a5,4
80000e90:	fae42c23          	sw	a4,-72(s0)
80000e94:	0007a783          	lw	a5,0(a5)
80000e98:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000e9c:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000ea0:	fe042783          	lw	a5,-32(s0)
80000ea4:	fcf42c23          	sw	a5,-40(s0)
80000ea8:	0100006f          	j	80000eb8 <printf+0x114>
80000eac:	fdc42783          	lw	a5,-36(s0)
80000eb0:	00178793          	addi	a5,a5,1
80000eb4:	fcf42e23          	sw	a5,-36(s0)
80000eb8:	fd842703          	lw	a4,-40(s0)
80000ebc:	00a00793          	li	a5,10
80000ec0:	02f747b3          	div	a5,a4,a5
80000ec4:	fcf42c23          	sw	a5,-40(s0)
80000ec8:	fd842783          	lw	a5,-40(s0)
80000ecc:	fe0790e3          	bnez	a5,80000eac <printf+0x108>
					for(int i=len;i>=0;i--){
80000ed0:	fdc42783          	lw	a5,-36(s0)
80000ed4:	fcf42a23          	sw	a5,-44(s0)
80000ed8:	0540006f          	j	80000f2c <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000edc:	fe042703          	lw	a4,-32(s0)
80000ee0:	00a00793          	li	a5,10
80000ee4:	02f767b3          	rem	a5,a4,a5
80000ee8:	0ff7f713          	andi	a4,a5,255
80000eec:	fe442683          	lw	a3,-28(s0)
80000ef0:	fd442783          	lw	a5,-44(s0)
80000ef4:	00f687b3          	add	a5,a3,a5
80000ef8:	03070713          	addi	a4,a4,48
80000efc:	0ff77713          	andi	a4,a4,255
80000f00:	8000d6b7          	lui	a3,0x8000d
80000f04:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
80000f08:	00f687b3          	add	a5,a3,a5
80000f0c:	00e78023          	sb	a4,0(a5)
						x/=10;
80000f10:	fe042703          	lw	a4,-32(s0)
80000f14:	00a00793          	li	a5,10
80000f18:	02f747b3          	div	a5,a4,a5
80000f1c:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000f20:	fd442783          	lw	a5,-44(s0)
80000f24:	fff78793          	addi	a5,a5,-1
80000f28:	fcf42a23          	sw	a5,-44(s0)
80000f2c:	fd442783          	lw	a5,-44(s0)
80000f30:	fa07d6e3          	bgez	a5,80000edc <printf+0x138>
					}
					idx+=(len+1);
80000f34:	fdc42783          	lw	a5,-36(s0)
80000f38:	00178793          	addi	a5,a5,1
80000f3c:	fe442703          	lw	a4,-28(s0)
80000f40:	00f707b3          	add	a5,a4,a5
80000f44:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000f48:	fe042423          	sw	zero,-24(s0)
					break;
80000f4c:	1dc0006f          	j	80001128 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000f50:	fe442783          	lw	a5,-28(s0)
80000f54:	00178713          	addi	a4,a5,1
80000f58:	fee42223          	sw	a4,-28(s0)
80000f5c:	8000d737          	lui	a4,0x8000d
80000f60:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000f64:	00f707b3          	add	a5,a4,a5
80000f68:	03000713          	li	a4,48
80000f6c:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000f70:	fe442783          	lw	a5,-28(s0)
80000f74:	00178713          	addi	a4,a5,1
80000f78:	fee42223          	sw	a4,-28(s0)
80000f7c:	8000d737          	lui	a4,0x8000d
80000f80:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000f84:	00f707b3          	add	a5,a4,a5
80000f88:	07800713          	li	a4,120
80000f8c:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80000f90:	fb842783          	lw	a5,-72(s0)
80000f94:	00478713          	addi	a4,a5,4
80000f98:	fae42c23          	sw	a4,-72(s0)
80000f9c:	0007a783          	lw	a5,0(a5)
80000fa0:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80000fa4:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80000fa8:	fd042783          	lw	a5,-48(s0)
80000fac:	fcf42423          	sw	a5,-56(s0)
80000fb0:	0100006f          	j	80000fc0 <printf+0x21c>
80000fb4:	fcc42783          	lw	a5,-52(s0)
80000fb8:	00178793          	addi	a5,a5,1
80000fbc:	fcf42623          	sw	a5,-52(s0)
80000fc0:	fc842783          	lw	a5,-56(s0)
80000fc4:	0047d793          	srli	a5,a5,0x4
80000fc8:	fcf42423          	sw	a5,-56(s0)
80000fcc:	fc842783          	lw	a5,-56(s0)
80000fd0:	fe0792e3          	bnez	a5,80000fb4 <printf+0x210>
					for(int i=len;i>=0;i--){
80000fd4:	fcc42783          	lw	a5,-52(s0)
80000fd8:	fcf42223          	sw	a5,-60(s0)
80000fdc:	0840006f          	j	80001060 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80000fe0:	fd042783          	lw	a5,-48(s0)
80000fe4:	00f7f713          	andi	a4,a5,15
80000fe8:	00900793          	li	a5,9
80000fec:	02e7f063          	bgeu	a5,a4,8000100c <printf+0x268>
80000ff0:	fd042783          	lw	a5,-48(s0)
80000ff4:	0ff7f793          	andi	a5,a5,255
80000ff8:	00f7f793          	andi	a5,a5,15
80000ffc:	0ff7f793          	andi	a5,a5,255
80001000:	05778793          	addi	a5,a5,87
80001004:	0ff7f793          	andi	a5,a5,255
80001008:	01c0006f          	j	80001024 <printf+0x280>
8000100c:	fd042783          	lw	a5,-48(s0)
80001010:	0ff7f793          	andi	a5,a5,255
80001014:	00f7f793          	andi	a5,a5,15
80001018:	0ff7f793          	andi	a5,a5,255
8000101c:	03078793          	addi	a5,a5,48
80001020:	0ff7f793          	andi	a5,a5,255
80001024:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80001028:	fe442703          	lw	a4,-28(s0)
8000102c:	fc442783          	lw	a5,-60(s0)
80001030:	00f707b3          	add	a5,a4,a5
80001034:	8000d737          	lui	a4,0x8000d
80001038:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
8000103c:	00f707b3          	add	a5,a4,a5
80001040:	fbe44703          	lbu	a4,-66(s0)
80001044:	00e78023          	sb	a4,0(a5)
						x/=16;
80001048:	fd042783          	lw	a5,-48(s0)
8000104c:	0047d793          	srli	a5,a5,0x4
80001050:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80001054:	fc442783          	lw	a5,-60(s0)
80001058:	fff78793          	addi	a5,a5,-1
8000105c:	fcf42223          	sw	a5,-60(s0)
80001060:	fc442783          	lw	a5,-60(s0)
80001064:	f607dee3          	bgez	a5,80000fe0 <printf+0x23c>
					}
					idx+=(len+1);
80001068:	fcc42783          	lw	a5,-52(s0)
8000106c:	00178793          	addi	a5,a5,1
80001070:	fe442703          	lw	a4,-28(s0)
80001074:	00f707b3          	add	a5,a4,a5
80001078:	fef42223          	sw	a5,-28(s0)
					tt=0;
8000107c:	fe042423          	sw	zero,-24(s0)
					break;
80001080:	0a80006f          	j	80001128 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80001084:	fb842783          	lw	a5,-72(s0)
80001088:	00478713          	addi	a4,a5,4
8000108c:	fae42c23          	sw	a4,-72(s0)
80001090:	0007a783          	lw	a5,0(a5)
80001094:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80001098:	fe442783          	lw	a5,-28(s0)
8000109c:	00178713          	addi	a4,a5,1
800010a0:	fee42223          	sw	a4,-28(s0)
800010a4:	8000d737          	lui	a4,0x8000d
800010a8:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
800010ac:	00f707b3          	add	a5,a4,a5
800010b0:	fbf44703          	lbu	a4,-65(s0)
800010b4:	00e78023          	sb	a4,0(a5)
					tt=0;
800010b8:	fe042423          	sw	zero,-24(s0)
					break;
800010bc:	06c0006f          	j	80001128 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
800010c0:	fb842783          	lw	a5,-72(s0)
800010c4:	00478713          	addi	a4,a5,4
800010c8:	fae42c23          	sw	a4,-72(s0)
800010cc:	0007a783          	lw	a5,0(a5)
800010d0:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
800010d4:	0300006f          	j	80001104 <printf+0x360>
						outbuf[idx++]=*ss++;
800010d8:	fc042703          	lw	a4,-64(s0)
800010dc:	00170793          	addi	a5,a4,1
800010e0:	fcf42023          	sw	a5,-64(s0)
800010e4:	fe442783          	lw	a5,-28(s0)
800010e8:	00178693          	addi	a3,a5,1
800010ec:	fed42223          	sw	a3,-28(s0)
800010f0:	00074703          	lbu	a4,0(a4)
800010f4:	8000d6b7          	lui	a3,0x8000d
800010f8:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
800010fc:	00f687b3          	add	a5,a3,a5
80001100:	00e78023          	sb	a4,0(a5)
					while(*ss){
80001104:	fc042783          	lw	a5,-64(s0)
80001108:	0007c783          	lbu	a5,0(a5)
8000110c:	fc0796e3          	bnez	a5,800010d8 <printf+0x334>
					}
					tt=0;
80001110:	fe042423          	sw	zero,-24(s0)
					break;
80001114:	0140006f          	j	80001128 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80001118:	800037b7          	lui	a5,0x80003
8000111c:	2bc78513          	addi	a0,a5,700 # 800032bc <memend+0xf80032bc>
80001120:	c4dff0ef          	jal	ra,80000d6c <panic>
					break;
80001124:	00000013          	nop
				}
				s++;
80001128:	fec42783          	lw	a5,-20(s0)
8000112c:	00178793          	addi	a5,a5,1
80001130:	fef42623          	sw	a5,-20(s0)
80001134:	0300006f          	j	80001164 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
80001138:	fe442783          	lw	a5,-28(s0)
8000113c:	00178713          	addi	a4,a5,1
80001140:	fee42223          	sw	a4,-28(s0)
80001144:	8000d737          	lui	a4,0x8000d
80001148:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
8000114c:	00f707b3          	add	a5,a4,a5
80001150:	fbf44703          	lbu	a4,-65(s0)
80001154:	00e78023          	sb	a4,0(a5)
				s++;
80001158:	fec42783          	lw	a5,-20(s0)
8000115c:	00178793          	addi	a5,a5,1
80001160:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
80001164:	fec42783          	lw	a5,-20(s0)
80001168:	0007c783          	lbu	a5,0(a5)
8000116c:	faf40fa3          	sb	a5,-65(s0)
80001170:	fbf44783          	lbu	a5,-65(s0)
80001174:	c80794e3          	bnez	a5,80000dfc <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80001178:	8000d7b7          	lui	a5,0x8000d
8000117c:	00478713          	addi	a4,a5,4 # 8000d004 <memend+0xf800d004>
80001180:	fe442783          	lw	a5,-28(s0)
80001184:	00f707b3          	add	a5,a4,a5
80001188:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
8000118c:	8000d7b7          	lui	a5,0x8000d
80001190:	00478513          	addi	a0,a5,4 # 8000d004 <memend+0xf800d004>
80001194:	e94ff0ef          	jal	ra,80000828 <uartputs>
	return idx;
80001198:	fe442783          	lw	a5,-28(s0)
8000119c:	00078513          	mv	a0,a5
800011a0:	05c12083          	lw	ra,92(sp)
800011a4:	05812403          	lw	s0,88(sp)
800011a8:	08010113          	addi	sp,sp,128
800011ac:	00008067          	ret

800011b0 <minit>:
struct
{
    struct pmp* freelist;
}mem;

void minit(){
800011b0:	fe010113          	addi	sp,sp,-32
800011b4:	00812e23          	sw	s0,28(sp)
800011b8:	02010413          	addi	s0,sp,32
        printf("mstart:%p   ",mstart);
        printf("mend:%p\n",mend);
        printf("stack:%p\n",stacks);
    #endif

    char* p=(char*)mstart;
800011bc:	8000e7b7          	lui	a5,0x8000e
800011c0:	00078793          	mv	a5,a5
800011c4:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800011c8:	0380006f          	j	80001200 <minit+0x50>
        m=(struct pmp*)p;
800011cc:	fec42783          	lw	a5,-20(s0)
800011d0:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
800011d4:	8000e7b7          	lui	a5,0x8000e
800011d8:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800011dc:	fe842783          	lw	a5,-24(s0)
800011e0:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
800011e4:	8000e7b7          	lui	a5,0x8000e
800011e8:	fe842703          	lw	a4,-24(s0)
800011ec:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
800011f0:	fec42703          	lw	a4,-20(s0)
800011f4:	000017b7          	lui	a5,0x1
800011f8:	00f707b3          	add	a5,a4,a5
800011fc:	fef42623          	sw	a5,-20(s0)
80001200:	fec42703          	lw	a4,-20(s0)
80001204:	000017b7          	lui	a5,0x1
80001208:	00f70733          	add	a4,a4,a5
8000120c:	880007b7          	lui	a5,0x88000
80001210:	00078793          	mv	a5,a5
80001214:	fae7fce3          	bgeu	a5,a4,800011cc <minit+0x1c>
    }
}
80001218:	00000013          	nop
8000121c:	00000013          	nop
80001220:	01c12403          	lw	s0,28(sp)
80001224:	02010113          	addi	sp,sp,32
80001228:	00008067          	ret

8000122c <palloc>:

void* palloc(){
8000122c:	fe010113          	addi	sp,sp,-32
80001230:	00112e23          	sw	ra,28(sp)
80001234:	00812c23          	sw	s0,24(sp)
80001238:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
8000123c:	8000e7b7          	lui	a5,0x8000e
80001240:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001244:	fef42623          	sw	a5,-20(s0)
    if(p)
80001248:	fec42783          	lw	a5,-20(s0)
8000124c:	00078c63          	beqz	a5,80001264 <palloc+0x38>
        mem.freelist=mem.freelist->next;
80001250:	8000e7b7          	lui	a5,0x8000e
80001254:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001258:	0007a703          	lw	a4,0(a5)
8000125c:	8000e7b7          	lui	a5,0x8000e
80001260:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    if(p)
80001264:	fec42783          	lw	a5,-20(s0)
80001268:	00078a63          	beqz	a5,8000127c <palloc+0x50>
        memset(p,0,PGSIZE);
8000126c:	00001637          	lui	a2,0x1
80001270:	00000593          	li	a1,0
80001274:	fec42503          	lw	a0,-20(s0)
80001278:	261000ef          	jal	ra,80001cd8 <memset>
    return (void*)p;
8000127c:	fec42783          	lw	a5,-20(s0)
}
80001280:	00078513          	mv	a0,a5
80001284:	01c12083          	lw	ra,28(sp)
80001288:	01812403          	lw	s0,24(sp)
8000128c:	02010113          	addi	sp,sp,32
80001290:	00008067          	ret

80001294 <pfree>:

void pfree(void* addr){
80001294:	fd010113          	addi	sp,sp,-48
80001298:	02812623          	sw	s0,44(sp)
8000129c:	03010413          	addi	s0,sp,48
800012a0:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
800012a4:	fdc42783          	lw	a5,-36(s0)
800012a8:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
800012ac:	8000e7b7          	lui	a5,0x8000e
800012b0:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800012b4:	fec42783          	lw	a5,-20(s0)
800012b8:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
800012bc:	8000e7b7          	lui	a5,0x8000e
800012c0:	fec42703          	lw	a4,-20(s0)
800012c4:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800012c8:	00000013          	nop
800012cc:	02c12403          	lw	s0,44(sp)
800012d0:	03010113          	addi	sp,sp,48
800012d4:	00008067          	ret

800012d8 <r_tp>:
static inline uint32 r_tp(){
800012d8:	fe010113          	addi	sp,sp,-32
800012dc:	00812e23          	sw	s0,28(sp)
800012e0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800012e4:	00020793          	mv	a5,tp
800012e8:	fef42623          	sw	a5,-20(s0)
    return x;
800012ec:	fec42783          	lw	a5,-20(s0)
}
800012f0:	00078513          	mv	a0,a5
800012f4:	01c12403          	lw	s0,28(sp)
800012f8:	02010113          	addi	sp,sp,32
800012fc:	00008067          	ret

80001300 <r_sie>:
/**
 * @description: S-mode 中断使能
 */
80001300:	fe010113          	addi	sp,sp,-32
80001304:	00812e23          	sw	s0,28(sp)
80001308:	02010413          	addi	s0,sp,32
#define SEIE (1<<9)
#define STIE (1<<5)
8000130c:	104027f3          	csrr	a5,sie
80001310:	fef42623          	sw	a5,-20(s0)
#define SSIE (1<<1)
80001314:	fec42783          	lw	a5,-20(s0)
static inline uint32 r_sie(){
80001318:	00078513          	mv	a0,a5
8000131c:	01c12403          	lw	s0,28(sp)
80001320:	02010113          	addi	sp,sp,32
80001324:	00008067          	ret

80001328 <w_sie>:
    uint32 x;
80001328:	fe010113          	addi	sp,sp,-32
8000132c:	00812e23          	sw	s0,28(sp)
80001330:	02010413          	addi	s0,sp,32
80001334:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrr %0,sie " : "=r"(x));
80001338:	fec42783          	lw	a5,-20(s0)
8000133c:	10479073          	csrw	sie,a5
    return x;
80001340:	00000013          	nop
80001344:	01c12403          	lw	s0,28(sp)
80001348:	02010113          	addi	sp,sp,32
8000134c:	00008067          	ret

80001350 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
80001350:	ff010113          	addi	sp,sp,-16
80001354:	00112623          	sw	ra,12(sp)
80001358:	00812423          	sw	s0,8(sp)
8000135c:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
80001360:	0c0007b7          	lui	a5,0xc000
80001364:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
80001368:	00100713          	li	a4,1
8000136c:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001370:	f69ff0ef          	jal	ra,800012d8 <r_tp>
80001374:	00050793          	mv	a5,a0
80001378:	00879713          	slli	a4,a5,0x8
8000137c:	0c0027b7          	lui	a5,0xc002
80001380:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
80001384:	00f707b3          	add	a5,a4,a5
80001388:	00078713          	mv	a4,a5
8000138c:	40000793          	li	a5,1024
80001390:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001394:	f45ff0ef          	jal	ra,800012d8 <r_tp>
80001398:	00050713          	mv	a4,a0
8000139c:	000c07b7          	lui	a5,0xc0
800013a0:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
800013a4:	00f707b3          	add	a5,a4,a5
800013a8:	00879793          	slli	a5,a5,0x8
800013ac:	00078713          	mv	a4,a5
800013b0:	40000793          	li	a5,1024
800013b4:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
800013b8:	f21ff0ef          	jal	ra,800012d8 <r_tp>
800013bc:	00050713          	mv	a4,a0
800013c0:	000067b7          	lui	a5,0x6
800013c4:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
800013c8:	00f707b3          	add	a5,a4,a5
800013cc:	00d79793          	slli	a5,a5,0xd
800013d0:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
800013d4:	f05ff0ef          	jal	ra,800012d8 <r_tp>
800013d8:	00050793          	mv	a5,a0
800013dc:	00d79713          	slli	a4,a5,0xd
800013e0:	0c2017b7          	lui	a5,0xc201
800013e4:	00f707b3          	add	a5,a4,a5
800013e8:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
800013ec:	f15ff0ef          	jal	ra,80001300 <r_sie>
800013f0:	00050793          	mv	a5,a0
800013f4:	2227e793          	ori	a5,a5,546
800013f8:	00078513          	mv	a0,a5
800013fc:	f2dff0ef          	jal	ra,80001328 <w_sie>
}
80001400:	00000013          	nop
80001404:	00c12083          	lw	ra,12(sp)
80001408:	00812403          	lw	s0,8(sp)
8000140c:	01010113          	addi	sp,sp,16
80001410:	00008067          	ret

80001414 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80001414:	ff010113          	addi	sp,sp,-16
80001418:	00112623          	sw	ra,12(sp)
8000141c:	00812423          	sw	s0,8(sp)
80001420:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001424:	eb5ff0ef          	jal	ra,800012d8 <r_tp>
80001428:	00050793          	mv	a5,a0
8000142c:	00d79713          	slli	a4,a5,0xd
80001430:	0c2017b7          	lui	a5,0xc201
80001434:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
80001438:	00f707b3          	add	a5,a4,a5
8000143c:	0007a783          	lw	a5,0(a5)
}
80001440:	00078513          	mv	a0,a5
80001444:	00c12083          	lw	ra,12(sp)
80001448:	00812403          	lw	s0,8(sp)
8000144c:	01010113          	addi	sp,sp,16
80001450:	00008067          	ret

80001454 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
80001454:	fe010113          	addi	sp,sp,-32
80001458:	00112e23          	sw	ra,28(sp)
8000145c:	00812c23          	sw	s0,24(sp)
80001460:	02010413          	addi	s0,sp,32
80001464:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
80001468:	e71ff0ef          	jal	ra,800012d8 <r_tp>
8000146c:	00050793          	mv	a5,a0
80001470:	00d79713          	slli	a4,a5,0xd
80001474:	0c2007b7          	lui	a5,0xc200
80001478:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
8000147c:	00f707b3          	add	a5,a4,a5
80001480:	00078713          	mv	a4,a5
80001484:	fec42783          	lw	a5,-20(s0)
80001488:	00f72023          	sw	a5,0(a4)
8000148c:	00000013          	nop
80001490:	01c12083          	lw	ra,28(sp)
80001494:	01812403          	lw	s0,24(sp)
80001498:	02010113          	addi	sp,sp,32
8000149c:	00008067          	ret

800014a0 <w_satp>:
static inline void w_satp(uint32 x){
800014a0:	fe010113          	addi	sp,sp,-32
800014a4:	00812e23          	sw	s0,28(sp)
800014a8:	02010413          	addi	s0,sp,32
800014ac:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
800014b0:	fec42783          	lw	a5,-20(s0)
800014b4:	18079073          	csrw	satp,a5
}
800014b8:	00000013          	nop
800014bc:	01c12403          	lw	s0,28(sp)
800014c0:	02010113          	addi	sp,sp,32
800014c4:	00008067          	ret

800014c8 <sfence_vma>:
static inline void sfence_vma(){
800014c8:	ff010113          	addi	sp,sp,-16
800014cc:	00812623          	sw	s0,12(sp)
800014d0:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
800014d4:	12000073          	sfence.vma
}
800014d8:	00000013          	nop
800014dc:	00c12403          	lw	s0,12(sp)
800014e0:	01010113          	addi	sp,sp,16
800014e4:	00008067          	ret

800014e8 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
800014e8:	fd010113          	addi	sp,sp,-48
800014ec:	02112623          	sw	ra,44(sp)
800014f0:	02812423          	sw	s0,40(sp)
800014f4:	03010413          	addi	s0,sp,48
800014f8:	fca42e23          	sw	a0,-36(s0)
800014fc:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
80001500:	fd842783          	lw	a5,-40(s0)
80001504:	0167d793          	srli	a5,a5,0x16
80001508:	00279793          	slli	a5,a5,0x2
8000150c:	fdc42703          	lw	a4,-36(s0)
80001510:	00f707b3          	add	a5,a4,a5
80001514:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001518:	fec42783          	lw	a5,-20(s0)
8000151c:	0007a783          	lw	a5,0(a5)
80001520:	0017f793          	andi	a5,a5,1
80001524:	00078e63          	beqz	a5,80001540 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001528:	fec42783          	lw	a5,-20(s0)
8000152c:	0007a783          	lw	a5,0(a5)
80001530:	00a7d793          	srli	a5,a5,0xa
80001534:	00c79793          	slli	a5,a5,0xc
80001538:	fcf42e23          	sw	a5,-36(s0)
8000153c:	0340006f          	j	80001570 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
80001540:	cedff0ef          	jal	ra,8000122c <palloc>
80001544:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
80001548:	00001637          	lui	a2,0x1
8000154c:	00000593          	li	a1,0
80001550:	fdc42503          	lw	a0,-36(s0)
80001554:	784000ef          	jal	ra,80001cd8 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
80001558:	fdc42783          	lw	a5,-36(s0)
8000155c:	00c7d793          	srli	a5,a5,0xc
80001560:	00a79793          	slli	a5,a5,0xa
80001564:	0017e713          	ori	a4,a5,1
80001568:	fec42783          	lw	a5,-20(s0)
8000156c:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
80001570:	fd842783          	lw	a5,-40(s0)
80001574:	00c7d793          	srli	a5,a5,0xc
80001578:	3ff7f793          	andi	a5,a5,1023
8000157c:	00279793          	slli	a5,a5,0x2
80001580:	fdc42703          	lw	a4,-36(s0)
80001584:	00f707b3          	add	a5,a4,a5
}
80001588:	00078513          	mv	a0,a5
8000158c:	02c12083          	lw	ra,44(sp)
80001590:	02812403          	lw	s0,40(sp)
80001594:	03010113          	addi	sp,sp,48
80001598:	00008067          	ret

8000159c <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
8000159c:	fc010113          	addi	sp,sp,-64
800015a0:	02112e23          	sw	ra,60(sp)
800015a4:	02812c23          	sw	s0,56(sp)
800015a8:	04010413          	addi	s0,sp,64
800015ac:	fca42e23          	sw	a0,-36(s0)
800015b0:	fcb42c23          	sw	a1,-40(s0)
800015b4:	fcc42a23          	sw	a2,-44(s0)
800015b8:	fcd42823          	sw	a3,-48(s0)
800015bc:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
800015c0:	fd842703          	lw	a4,-40(s0)
800015c4:	fffff7b7          	lui	a5,0xfffff
800015c8:	00f777b3          	and	a5,a4,a5
800015cc:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
800015d0:	fd042703          	lw	a4,-48(s0)
800015d4:	fd842783          	lw	a5,-40(s0)
800015d8:	00f707b3          	add	a5,a4,a5
800015dc:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
800015e0:	fffff7b7          	lui	a5,0xfffff
800015e4:	00f777b3          	and	a5,a4,a5
800015e8:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
800015ec:	fec42583          	lw	a1,-20(s0)
800015f0:	fdc42503          	lw	a0,-36(s0)
800015f4:	ef5ff0ef          	jal	ra,800014e8 <acquriepte>
800015f8:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
800015fc:	fe442783          	lw	a5,-28(s0)
80001600:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001604:	0017f793          	andi	a5,a5,1
80001608:	00078863          	beqz	a5,80001618 <vmmap+0x7c>
            panic("repeat map");
8000160c:	800037b7          	lui	a5,0x80003
80001610:	35878513          	addi	a0,a5,856 # 80003358 <memend+0xf8003358>
80001614:	f58ff0ef          	jal	ra,80000d6c <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001618:	fd442783          	lw	a5,-44(s0)
8000161c:	00c7d793          	srli	a5,a5,0xc
80001620:	00a79713          	slli	a4,a5,0xa
80001624:	fcc42783          	lw	a5,-52(s0)
80001628:	00f767b3          	or	a5,a4,a5
8000162c:	0017e713          	ori	a4,a5,1
80001630:	fe442783          	lw	a5,-28(s0)
80001634:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
80001638:	fec42703          	lw	a4,-20(s0)
8000163c:	fe842783          	lw	a5,-24(s0)
80001640:	02f70463          	beq	a4,a5,80001668 <vmmap+0xcc>
        start += PGSIZE;
80001644:	fec42703          	lw	a4,-20(s0)
80001648:	000017b7          	lui	a5,0x1
8000164c:	00f707b3          	add	a5,a4,a5
80001650:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
80001654:	fd442703          	lw	a4,-44(s0)
80001658:	000017b7          	lui	a5,0x1
8000165c:	00f707b3          	add	a5,a4,a5
80001660:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
80001664:	f89ff06f          	j	800015ec <vmmap+0x50>
        if(start==end)  break;
80001668:	00000013          	nop
    }
}
8000166c:	00000013          	nop
80001670:	03c12083          	lw	ra,60(sp)
80001674:	03812403          	lw	s0,56(sp)
80001678:	04010113          	addi	sp,sp,64
8000167c:	00008067          	ret

80001680 <printpgt>:

void printpgt(addr_t* pgt){
80001680:	fc010113          	addi	sp,sp,-64
80001684:	02112e23          	sw	ra,60(sp)
80001688:	02812c23          	sw	s0,56(sp)
8000168c:	04010413          	addi	s0,sp,64
80001690:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
80001694:	fe042623          	sw	zero,-20(s0)
80001698:	0c40006f          	j	8000175c <printpgt+0xdc>
        pte_t pte=pgt[i];
8000169c:	fec42783          	lw	a5,-20(s0)
800016a0:	00279793          	slli	a5,a5,0x2
800016a4:	fcc42703          	lw	a4,-52(s0)
800016a8:	00f707b3          	add	a5,a4,a5
800016ac:	0007a783          	lw	a5,0(a5) # 1000 <sz>
800016b0:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
800016b4:	fe442783          	lw	a5,-28(s0)
800016b8:	0017f793          	andi	a5,a5,1
800016bc:	08078a63          	beqz	a5,80001750 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
800016c0:	fe442783          	lw	a5,-28(s0)
800016c4:	00a7d793          	srli	a5,a5,0xa
800016c8:	00c79793          	slli	a5,a5,0xc
800016cc:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
800016d0:	fe042683          	lw	a3,-32(s0)
800016d4:	fe442603          	lw	a2,-28(s0)
800016d8:	fec42583          	lw	a1,-20(s0)
800016dc:	800037b7          	lui	a5,0x80003
800016e0:	36478513          	addi	a0,a5,868 # 80003364 <memend+0xf8003364>
800016e4:	ec0ff0ef          	jal	ra,80000da4 <printf>
            for(int j=0;j<1024;j++){
800016e8:	fe042423          	sw	zero,-24(s0)
800016ec:	0580006f          	j	80001744 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
800016f0:	fe842783          	lw	a5,-24(s0)
800016f4:	00279793          	slli	a5,a5,0x2
800016f8:	fe042703          	lw	a4,-32(s0)
800016fc:	00f707b3          	add	a5,a4,a5
80001700:	0007a783          	lw	a5,0(a5)
80001704:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001708:	fdc42783          	lw	a5,-36(s0)
8000170c:	0017f793          	andi	a5,a5,1
80001710:	02078463          	beqz	a5,80001738 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001714:	fdc42783          	lw	a5,-36(s0)
80001718:	00a7d793          	srli	a5,a5,0xa
8000171c:	00c79793          	slli	a5,a5,0xc
80001720:	00078693          	mv	a3,a5
80001724:	fdc42603          	lw	a2,-36(s0)
80001728:	fe842583          	lw	a1,-24(s0)
8000172c:	800037b7          	lui	a5,0x80003
80001730:	37c78513          	addi	a0,a5,892 # 8000337c <memend+0xf800337c>
80001734:	e70ff0ef          	jal	ra,80000da4 <printf>
            for(int j=0;j<1024;j++){
80001738:	fe842783          	lw	a5,-24(s0)
8000173c:	00178793          	addi	a5,a5,1
80001740:	fef42423          	sw	a5,-24(s0)
80001744:	fe842703          	lw	a4,-24(s0)
80001748:	3ff00793          	li	a5,1023
8000174c:	fae7d2e3          	bge	a5,a4,800016f0 <printpgt+0x70>
    for(int i=0;i<1024;i++){
80001750:	fec42783          	lw	a5,-20(s0)
80001754:	00178793          	addi	a5,a5,1
80001758:	fef42623          	sw	a5,-20(s0)
8000175c:	fec42703          	lw	a4,-20(s0)
80001760:	3ff00793          	li	a5,1023
80001764:	f2e7dce3          	bge	a5,a4,8000169c <printpgt+0x1c>
                }
            }
        }
    }
}
80001768:	00000013          	nop
8000176c:	00000013          	nop
80001770:	03c12083          	lw	ra,60(sp)
80001774:	03812403          	lw	s0,56(sp)
80001778:	04010113          	addi	sp,sp,64
8000177c:	00008067          	ret

80001780 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
80001780:	fd010113          	addi	sp,sp,-48
80001784:	02112623          	sw	ra,44(sp)
80001788:	02812423          	sw	s0,40(sp)
8000178c:	03010413          	addi	s0,sp,48
80001790:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
80001794:	fe042623          	sw	zero,-20(s0)
80001798:	04c0006f          	j	800017e4 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
8000179c:	fec42783          	lw	a5,-20(s0)
800017a0:	00d79793          	slli	a5,a5,0xd
800017a4:	00078713          	mv	a4,a5
800017a8:	c00017b7          	lui	a5,0xc0001
800017ac:	00f707b3          	add	a5,a4,a5
800017b0:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
800017b4:	a79ff0ef          	jal	ra,8000122c <palloc>
800017b8:	00050793          	mv	a5,a0
800017bc:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
800017c0:	00600713          	li	a4,6
800017c4:	000016b7          	lui	a3,0x1
800017c8:	fe442603          	lw	a2,-28(s0)
800017cc:	fe842583          	lw	a1,-24(s0)
800017d0:	fdc42503          	lw	a0,-36(s0)
800017d4:	dc9ff0ef          	jal	ra,8000159c <vmmap>
    for(int i=0;i<NPROC;i++){
800017d8:	fec42783          	lw	a5,-20(s0)
800017dc:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
800017e0:	fef42623          	sw	a5,-20(s0)
800017e4:	fec42703          	lw	a4,-20(s0)
800017e8:	00300793          	li	a5,3
800017ec:	fae7d8e3          	bge	a5,a4,8000179c <mkstack+0x1c>
    }
}
800017f0:	00000013          	nop
800017f4:	00000013          	nop
800017f8:	02c12083          	lw	ra,44(sp)
800017fc:	02812403          	lw	s0,40(sp)
80001800:	03010113          	addi	sp,sp,48
80001804:	00008067          	ret

80001808 <kvminit>:

// 初始化虚拟内存
void kvminit(){
80001808:	ff010113          	addi	sp,sp,-16
8000180c:	00112623          	sw	ra,12(sp)
80001810:	00812423          	sw	s0,8(sp)
80001814:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001818:	a15ff0ef          	jal	ra,8000122c <palloc>
8000181c:	00050713          	mv	a4,a0
80001820:	8000e7b7          	lui	a5,0x8000e
80001824:	8ae7a423          	sw	a4,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
    memset(kpgt,0,PGSIZE);
80001828:	8000e7b7          	lui	a5,0x8000e
8000182c:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001830:	00001637          	lui	a2,0x1
80001834:	00000593          	li	a1,0
80001838:	00078513          	mv	a0,a5
8000183c:	49c000ef          	jal	ra,80001cd8 <memset>

    // 映射 CLINT
    vmmap(kpgt,CLINT_BASE,CLINT_BASE,0xc000,PTE_R|PTE_W);
80001840:	8000e7b7          	lui	a5,0x8000e
80001844:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001848:	00600713          	li	a4,6
8000184c:	0000c6b7          	lui	a3,0xc
80001850:	02000637          	lui	a2,0x2000
80001854:	020005b7          	lui	a1,0x2000
80001858:	00078513          	mv	a0,a5
8000185c:	d41ff0ef          	jal	ra,8000159c <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
80001860:	8000e7b7          	lui	a5,0x8000e
80001864:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001868:	00600713          	li	a4,6
8000186c:	004006b7          	lui	a3,0x400
80001870:	0c000637          	lui	a2,0xc000
80001874:	0c0005b7          	lui	a1,0xc000
80001878:	00078513          	mv	a0,a5
8000187c:	d21ff0ef          	jal	ra,8000159c <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
80001880:	8000e7b7          	lui	a5,0x8000e
80001884:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001888:	00600713          	li	a4,6
8000188c:	000016b7          	lui	a3,0x1
80001890:	10000637          	lui	a2,0x10000
80001894:	100005b7          	lui	a1,0x10000
80001898:	00078513          	mv	a0,a5
8000189c:	d01ff0ef          	jal	ra,8000159c <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
800018a0:	8000e7b7          	lui	a5,0x8000e
800018a4:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018a8:	800007b7          	lui	a5,0x80000
800018ac:	00078593          	mv	a1,a5
800018b0:	800007b7          	lui	a5,0x80000
800018b4:	00078613          	mv	a2,a5
800018b8:	800027b7          	lui	a5,0x80002
800018bc:	34078713          	addi	a4,a5,832 # 80002340 <memend+0xf8002340>
800018c0:	800007b7          	lui	a5,0x80000
800018c4:	00078793          	mv	a5,a5
800018c8:	40f707b3          	sub	a5,a4,a5
800018cc:	00a00713          	li	a4,10
800018d0:	00078693          	mv	a3,a5
800018d4:	cc9ff0ef          	jal	ra,8000159c <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
800018d8:	8000e7b7          	lui	a5,0x8000e
800018dc:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018e0:	800037b7          	lui	a5,0x80003
800018e4:	00078593          	mv	a1,a5
800018e8:	800037b7          	lui	a5,0x80003
800018ec:	00078613          	mv	a2,a5
800018f0:	800037b7          	lui	a5,0x80003
800018f4:	39378713          	addi	a4,a5,915 # 80003393 <memend+0xf8003393>
800018f8:	800037b7          	lui	a5,0x80003
800018fc:	00078793          	mv	a5,a5
80001900:	40f707b3          	sub	a5,a4,a5
80001904:	00200713          	li	a4,2
80001908:	00078693          	mv	a3,a5
8000190c:	c91ff0ef          	jal	ra,8000159c <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001910:	8000e7b7          	lui	a5,0x8000e
80001914:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001918:	800047b7          	lui	a5,0x80004
8000191c:	00078593          	mv	a1,a5
80001920:	800047b7          	lui	a5,0x80004
80001924:	00078613          	mv	a2,a5
80001928:	8000c7b7          	lui	a5,0x8000c
8000192c:	00478713          	addi	a4,a5,4 # 8000c004 <memend+0xf800c004>
80001930:	800047b7          	lui	a5,0x80004
80001934:	00078793          	mv	a5,a5
80001938:	40f707b3          	sub	a5,a4,a5
8000193c:	00600713          	li	a4,6
80001940:	00078693          	mv	a3,a5
80001944:	c59ff0ef          	jal	ra,8000159c <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
80001948:	8000e7b7          	lui	a5,0x8000e
8000194c:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001950:	8000d7b7          	lui	a5,0x8000d
80001954:	00078593          	mv	a1,a5
80001958:	8000d7b7          	lui	a5,0x8000d
8000195c:	00078613          	mv	a2,a5
80001960:	8000e7b7          	lui	a5,0x8000e
80001964:	9f078713          	addi	a4,a5,-1552 # 8000d9f0 <memend+0xf800d9f0>
80001968:	8000d7b7          	lui	a5,0x8000d
8000196c:	00078793          	mv	a5,a5
80001970:	40f707b3          	sub	a5,a4,a5
80001974:	00600713          	li	a4,6
80001978:	00078693          	mv	a3,a5
8000197c:	c21ff0ef          	jal	ra,8000159c <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
80001980:	8000e7b7          	lui	a5,0x8000e
80001984:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001988:	8000e7b7          	lui	a5,0x8000e
8000198c:	00078593          	mv	a1,a5
80001990:	8000e7b7          	lui	a5,0x8000e
80001994:	00078613          	mv	a2,a5
80001998:	880007b7          	lui	a5,0x88000
8000199c:	00078713          	mv	a4,a5
800019a0:	8000e7b7          	lui	a5,0x8000e
800019a4:	00078793          	mv	a5,a5
800019a8:	40f707b3          	sub	a5,a4,a5
800019ac:	00600713          	li	a4,6
800019b0:	00078693          	mv	a3,a5
800019b4:	be9ff0ef          	jal	ra,8000159c <vmmap>

    mkstack(kpgt);
800019b8:	8000e7b7          	lui	a5,0x8000e
800019bc:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019c0:	00078513          	mv	a0,a5
800019c4:	dbdff0ef          	jal	ra,80001780 <mkstack>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
800019c8:	8000e7b7          	lui	a5,0x8000e
800019cc:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019d0:	00c7d713          	srli	a4,a5,0xc
800019d4:	800007b7          	lui	a5,0x80000
800019d8:	00f767b3          	or	a5,a4,a5
800019dc:	00078513          	mv	a0,a5
800019e0:	ac1ff0ef          	jal	ra,800014a0 <w_satp>
    sfence_vma();       // 刷新页表
800019e4:	ae5ff0ef          	jal	ra,800014c8 <sfence_vma>
}
800019e8:	00000013          	nop
800019ec:	00c12083          	lw	ra,12(sp)
800019f0:	00812403          	lw	s0,8(sp)
800019f4:	01010113          	addi	sp,sp,16
800019f8:	00008067          	ret

800019fc <pgtcreate>:

addr_t* pgtcreate(){
800019fc:	fe010113          	addi	sp,sp,-32
80001a00:	00112e23          	sw	ra,28(sp)
80001a04:	00812c23          	sw	s0,24(sp)
80001a08:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001a0c:	821ff0ef          	jal	ra,8000122c <palloc>
80001a10:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001a14:	fec42783          	lw	a5,-20(s0)
}
80001a18:	00078513          	mv	a0,a5
80001a1c:	01c12083          	lw	ra,28(sp)
80001a20:	01812403          	lw	s0,24(sp)
80001a24:	02010113          	addi	sp,sp,32
80001a28:	00008067          	ret

80001a2c <r_tp>:
static inline uint32 r_tp(){
80001a2c:	fe010113          	addi	sp,sp,-32
80001a30:	00812e23          	sw	s0,28(sp)
80001a34:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001a38:	00020793          	mv	a5,tp
80001a3c:	fef42623          	sw	a5,-20(s0)
    return x;
80001a40:	fec42783          	lw	a5,-20(s0)
}
80001a44:	00078513          	mv	a0,a5
80001a48:	01c12403          	lw	s0,28(sp)
80001a4c:	02010113          	addi	sp,sp,32
80001a50:	00008067          	ret

80001a54 <procinit>:
#include "defs.h"
#include "riscv.h"

uint nextpid=0;

void procinit(){
80001a54:	fe010113          	addi	sp,sp,-32
80001a58:	00812e23          	sw	s0,28(sp)
80001a5c:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001a60:	fe042623          	sw	zero,-20(s0)
80001a64:	0480006f          	j	80001aac <procinit+0x58>
        p=&proc[i];
80001a68:	fec42703          	lw	a4,-20(s0)
80001a6c:	11800793          	li	a5,280
80001a70:	02f70733          	mul	a4,a4,a5
80001a74:	8000d7b7          	lui	a5,0x8000d
80001a78:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001a7c:	00f707b3          	add	a5,a4,a5
80001a80:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
80001a84:	fec42783          	lw	a5,-20(s0)
80001a88:	00d79793          	slli	a5,a5,0xd
80001a8c:	00078713          	mv	a4,a5
80001a90:	c00027b7          	lui	a5,0xc0002
80001a94:	00f70733          	add	a4,a4,a5
80001a98:	fe842783          	lw	a5,-24(s0)
80001a9c:	10e7aa23          	sw	a4,276(a5) # c0002114 <memend+0x38002114>
    for(int i=0;i<NPROC;i++){
80001aa0:	fec42783          	lw	a5,-20(s0)
80001aa4:	00178793          	addi	a5,a5,1
80001aa8:	fef42623          	sw	a5,-20(s0)
80001aac:	fec42703          	lw	a4,-20(s0)
80001ab0:	00300793          	li	a5,3
80001ab4:	fae7dae3          	bge	a5,a4,80001a68 <procinit+0x14>
    }
}
80001ab8:	00000013          	nop
80001abc:	00000013          	nop
80001ac0:	01c12403          	lw	s0,28(sp)
80001ac4:	02010113          	addi	sp,sp,32
80001ac8:	00008067          	ret

80001acc <nowproc>:

struct pcb* nowproc(){
80001acc:	fe010113          	addi	sp,sp,-32
80001ad0:	00112e23          	sw	ra,28(sp)
80001ad4:	00812c23          	sw	s0,24(sp)
80001ad8:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80001adc:	f51ff0ef          	jal	ra,80001a2c <r_tp>
80001ae0:	00050793          	mv	a5,a0
80001ae4:	fef42623          	sw	a5,-20(s0)
    return cpu[hart].proc;
80001ae8:	8000e7b7          	lui	a5,0x8000e
80001aec:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001af0:	fec42783          	lw	a5,-20(s0)
80001af4:	00379793          	slli	a5,a5,0x3
80001af8:	00f707b3          	add	a5,a4,a5
80001afc:	0007a783          	lw	a5,0(a5)
}
80001b00:	00078513          	mv	a0,a5
80001b04:	01c12083          	lw	ra,28(sp)
80001b08:	01812403          	lw	s0,24(sp)
80001b0c:	02010113          	addi	sp,sp,32
80001b10:	00008067          	ret

80001b14 <pidalloc>:

uint pidalloc(){
80001b14:	ff010113          	addi	sp,sp,-16
80001b18:	00812623          	sw	s0,12(sp)
80001b1c:	01010413          	addi	s0,sp,16
    return nextpid++;
80001b20:	8000d7b7          	lui	a5,0x8000d
80001b24:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
80001b28:	00178693          	addi	a3,a5,1
80001b2c:	8000d737          	lui	a4,0x8000d
80001b30:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
} 
80001b34:	00078513          	mv	a0,a5
80001b38:	00c12403          	lw	s0,12(sp)
80001b3c:	01010113          	addi	sp,sp,16
80001b40:	00008067          	ret

80001b44 <procalloc>:

struct pcb* procalloc(){
80001b44:	fe010113          	addi	sp,sp,-32
80001b48:	00112e23          	sw	ra,28(sp)
80001b4c:	00812c23          	sw	s0,24(sp)
80001b50:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80001b54:	8000d7b7          	lui	a5,0x8000d
80001b58:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001b5c:	fef42623          	sw	a5,-20(s0)
80001b60:	0680006f          	j	80001bc8 <procalloc+0x84>
        if(p->status==UNUSED){
80001b64:	fec42783          	lw	a5,-20(s0)
80001b68:	0047a783          	lw	a5,4(a5)
80001b6c:	04079863          	bnez	a5,80001bbc <procalloc+0x78>
            p->pid=pidalloc();
80001b70:	fa5ff0ef          	jal	ra,80001b14 <pidalloc>
80001b74:	00050793          	mv	a5,a0
80001b78:	00078713          	mv	a4,a5
80001b7c:	fec42783          	lw	a5,-20(s0)
80001b80:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80001b84:	fec42783          	lw	a5,-20(s0)
80001b88:	00100713          	li	a4,1
80001b8c:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
80001b90:	e6dff0ef          	jal	ra,800019fc <pgtcreate>
80001b94:	00050713          	mv	a4,a0
80001b98:	fec42783          	lw	a5,-20(s0)
80001b9c:	10e7a823          	sw	a4,272(a5)
            
            p->trapframe.epc=0;
80001ba0:	fec42783          	lw	a5,-20(s0)
80001ba4:	0007aa23          	sw	zero,20(a5)
            p->trapframe.sp=KSPACE;
80001ba8:	fec42783          	lw	a5,-20(s0)
80001bac:	c0000737          	lui	a4,0xc0000
80001bb0:	00e7ae23          	sw	a4,28(a5)

            return p;
80001bb4:	fec42783          	lw	a5,-20(s0)
80001bb8:	0240006f          	j	80001bdc <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
80001bbc:	fec42783          	lw	a5,-20(s0)
80001bc0:	11878793          	addi	a5,a5,280
80001bc4:	fef42623          	sw	a5,-20(s0)
80001bc8:	fec42703          	lw	a4,-20(s0)
80001bcc:	8000e7b7          	lui	a5,0x8000e
80001bd0:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001bd4:	f8f768e3          	bltu	a4,a5,80001b64 <procalloc+0x20>
        }
    }
    return 0;
80001bd8:	00000793          	li	a5,0
}
80001bdc:	00078513          	mv	a0,a5
80001be0:	01c12083          	lw	ra,28(sp)
80001be4:	01812403          	lw	s0,24(sp)
80001be8:	02010113          	addi	sp,sp,32
80001bec:	00008067          	ret

80001bf0 <userinit>:

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
80001bf0:	fe010113          	addi	sp,sp,-32
80001bf4:	00112e23          	sw	ra,28(sp)
80001bf8:	00812c23          	sw	s0,24(sp)
80001bfc:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80001c00:	f45ff0ef          	jal	ra,80001b44 <procalloc>
80001c04:	fea42623          	sw	a0,-20(s0)
    
    char* m=(char*)palloc();
80001c08:	e24ff0ef          	jal	ra,8000122c <palloc>
80001c0c:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80001c10:	00400613          	li	a2,4
80001c14:	00000693          	li	a3,0
80001c18:	800047b7          	lui	a5,0x80004
80001c1c:	00078593          	mv	a1,a5
80001c20:	fe842503          	lw	a0,-24(s0)
80001c24:	120000ef          	jal	ra,80001d44 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X);
80001c28:	fec42783          	lw	a5,-20(s0)
80001c2c:	1107a783          	lw	a5,272(a5) # 80004110 <memend+0xf8004110>
80001c30:	fe842603          	lw	a2,-24(s0)
80001c34:	00e00713          	li	a4,14
80001c38:	000016b7          	lui	a3,0x1
80001c3c:	00000593          	li	a1,0
80001c40:	00078513          	mv	a0,a5
80001c44:	959ff0ef          	jal	ra,8000159c <vmmap>

    p->context.sp=KSPACE;
80001c48:	fec42783          	lw	a5,-20(s0)
80001c4c:	c0000737          	lui	a4,0xc0000
80001c50:	08e7ac23          	sw	a4,152(a5)

    p->status=RUNABLE;
80001c54:	fec42783          	lw	a5,-20(s0)
80001c58:	00200713          	li	a4,2
80001c5c:	00e7a223          	sw	a4,4(a5)

    int id=r_tp();
80001c60:	dcdff0ef          	jal	ra,80001a2c <r_tp>
80001c64:	00050793          	mv	a5,a0
80001c68:	fef42223          	sw	a5,-28(s0)
    cpu[id].proc=p;
80001c6c:	8000e7b7          	lui	a5,0x8000e
80001c70:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001c74:	fe442783          	lw	a5,-28(s0)
80001c78:	00379793          	slli	a5,a5,0x3
80001c7c:	00f707b3          	add	a5,a4,a5
80001c80:	fec42703          	lw	a4,-20(s0)
80001c84:	00e7a023          	sw	a4,0(a5)
}
80001c88:	00000013          	nop
80001c8c:	01c12083          	lw	ra,28(sp)
80001c90:	01812403          	lw	s0,24(sp)
80001c94:	02010113          	addi	sp,sp,32
80001c98:	00008067          	ret

80001c9c <schedule>:

void schedule(){
80001c9c:	fe010113          	addi	sp,sp,-32
80001ca0:	00812e23          	sw	s0,28(sp)
80001ca4:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
80001ca8:	8000d7b7          	lui	a5,0x8000d
80001cac:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001cb0:	fef42623          	sw	a5,-20(s0)
80001cb4:	0100006f          	j	80001cc4 <schedule+0x28>
80001cb8:	fec42783          	lw	a5,-20(s0)
80001cbc:	11878793          	addi	a5,a5,280
80001cc0:	fef42623          	sw	a5,-20(s0)
80001cc4:	fec42703          	lw	a4,-20(s0)
80001cc8:	8000e7b7          	lui	a5,0x8000e
80001ccc:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001cd0:	fef764e3          	bltu	a4,a5,80001cb8 <schedule+0x1c>
    for(;;){
80001cd4:	fd5ff06f          	j	80001ca8 <schedule+0xc>

80001cd8 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80001cd8:	fd010113          	addi	sp,sp,-48
80001cdc:	02812623          	sw	s0,44(sp)
80001ce0:	03010413          	addi	s0,sp,48
80001ce4:	fca42e23          	sw	a0,-36(s0)
80001ce8:	fcb42c23          	sw	a1,-40(s0)
80001cec:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
80001cf0:	fdc42783          	lw	a5,-36(s0)
80001cf4:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001cf8:	fe042623          	sw	zero,-20(s0)
80001cfc:	0280006f          	j	80001d24 <memset+0x4c>
        maddr[i] = (char)c;
80001d00:	fe842703          	lw	a4,-24(s0)
80001d04:	fec42783          	lw	a5,-20(s0)
80001d08:	00f707b3          	add	a5,a4,a5
80001d0c:	fd842703          	lw	a4,-40(s0)
80001d10:	0ff77713          	andi	a4,a4,255
80001d14:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001d18:	fec42783          	lw	a5,-20(s0)
80001d1c:	00178793          	addi	a5,a5,1
80001d20:	fef42623          	sw	a5,-20(s0)
80001d24:	fec42703          	lw	a4,-20(s0)
80001d28:	fd442783          	lw	a5,-44(s0)
80001d2c:	fcf76ae3          	bltu	a4,a5,80001d00 <memset+0x28>
    }
    return addr;
80001d30:	fdc42783          	lw	a5,-36(s0)
}
80001d34:	00078513          	mv	a0,a5
80001d38:	02c12403          	lw	s0,44(sp)
80001d3c:	03010113          	addi	sp,sp,48
80001d40:	00008067          	ret

80001d44 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80001d44:	fd010113          	addi	sp,sp,-48
80001d48:	02812623          	sw	s0,44(sp)
80001d4c:	03010413          	addi	s0,sp,48
80001d50:	fca42e23          	sw	a0,-36(s0)
80001d54:	fcb42c23          	sw	a1,-40(s0)
80001d58:	fcc42823          	sw	a2,-48(s0)
80001d5c:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001d60:	fd042783          	lw	a5,-48(s0)
80001d64:	fd442703          	lw	a4,-44(s0)
80001d68:	00e7e7b3          	or	a5,a5,a4
80001d6c:	00079663          	bnez	a5,80001d78 <memmove+0x34>
        return dst;
80001d70:	fdc42783          	lw	a5,-36(s0)
80001d74:	1200006f          	j	80001e94 <memmove+0x150>
    }

    s = src;
80001d78:	fd842783          	lw	a5,-40(s0)
80001d7c:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001d80:	fdc42783          	lw	a5,-36(s0)
80001d84:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001d88:	fec42703          	lw	a4,-20(s0)
80001d8c:	fe842783          	lw	a5,-24(s0)
80001d90:	0cf77263          	bgeu	a4,a5,80001e54 <memmove+0x110>
80001d94:	fd042783          	lw	a5,-48(s0)
80001d98:	fec42703          	lw	a4,-20(s0)
80001d9c:	00f707b3          	add	a5,a4,a5
80001da0:	fe842703          	lw	a4,-24(s0)
80001da4:	0af77863          	bgeu	a4,a5,80001e54 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80001da8:	fd042783          	lw	a5,-48(s0)
80001dac:	fec42703          	lw	a4,-20(s0)
80001db0:	00f707b3          	add	a5,a4,a5
80001db4:	fef42623          	sw	a5,-20(s0)
        d += n;
80001db8:	fd042783          	lw	a5,-48(s0)
80001dbc:	fe842703          	lw	a4,-24(s0)
80001dc0:	00f707b3          	add	a5,a4,a5
80001dc4:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80001dc8:	02c0006f          	j	80001df4 <memmove+0xb0>
            *--d = *--s;
80001dcc:	fec42783          	lw	a5,-20(s0)
80001dd0:	fff78793          	addi	a5,a5,-1
80001dd4:	fef42623          	sw	a5,-20(s0)
80001dd8:	fe842783          	lw	a5,-24(s0)
80001ddc:	fff78793          	addi	a5,a5,-1
80001de0:	fef42423          	sw	a5,-24(s0)
80001de4:	fec42783          	lw	a5,-20(s0)
80001de8:	0007c703          	lbu	a4,0(a5)
80001dec:	fe842783          	lw	a5,-24(s0)
80001df0:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80001df4:	fd042703          	lw	a4,-48(s0)
80001df8:	fd442783          	lw	a5,-44(s0)
80001dfc:	fff00513          	li	a0,-1
80001e00:	fff00593          	li	a1,-1
80001e04:	00a70633          	add	a2,a4,a0
80001e08:	00060813          	mv	a6,a2
80001e0c:	00e83833          	sltu	a6,a6,a4
80001e10:	00b786b3          	add	a3,a5,a1
80001e14:	00d805b3          	add	a1,a6,a3
80001e18:	00058693          	mv	a3,a1
80001e1c:	fcc42823          	sw	a2,-48(s0)
80001e20:	fcd42a23          	sw	a3,-44(s0)
80001e24:	00070693          	mv	a3,a4
80001e28:	00f6e6b3          	or	a3,a3,a5
80001e2c:	fa0690e3          	bnez	a3,80001dcc <memmove+0x88>
    if(s < d && s + n > d){     
80001e30:	0600006f          	j	80001e90 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80001e34:	fec42703          	lw	a4,-20(s0)
80001e38:	00170793          	addi	a5,a4,1 # c0000001 <memend+0x38000001>
80001e3c:	fef42623          	sw	a5,-20(s0)
80001e40:	fe842783          	lw	a5,-24(s0)
80001e44:	00178693          	addi	a3,a5,1
80001e48:	fed42423          	sw	a3,-24(s0)
80001e4c:	00074703          	lbu	a4,0(a4)
80001e50:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80001e54:	fd042703          	lw	a4,-48(s0)
80001e58:	fd442783          	lw	a5,-44(s0)
80001e5c:	fff00513          	li	a0,-1
80001e60:	fff00593          	li	a1,-1
80001e64:	00a70633          	add	a2,a4,a0
80001e68:	00060813          	mv	a6,a2
80001e6c:	00e83833          	sltu	a6,a6,a4
80001e70:	00b786b3          	add	a3,a5,a1
80001e74:	00d805b3          	add	a1,a6,a3
80001e78:	00058693          	mv	a3,a1
80001e7c:	fcc42823          	sw	a2,-48(s0)
80001e80:	fcd42a23          	sw	a3,-44(s0)
80001e84:	00070693          	mv	a3,a4
80001e88:	00f6e6b3          	or	a3,a3,a5
80001e8c:	fa0694e3          	bnez	a3,80001e34 <memmove+0xf0>
        }
    }
    return dst;
80001e90:	fdc42783          	lw	a5,-36(s0)
}
80001e94:	00078513          	mv	a0,a5
80001e98:	02c12403          	lw	s0,44(sp)
80001e9c:	03010113          	addi	sp,sp,48
80001ea0:	00008067          	ret

80001ea4 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80001ea4:	fd010113          	addi	sp,sp,-48
80001ea8:	02812623          	sw	s0,44(sp)
80001eac:	03010413          	addi	s0,sp,48
80001eb0:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80001eb4:	00000793          	li	a5,0
80001eb8:	00000813          	li	a6,0
80001ebc:	fef42423          	sw	a5,-24(s0)
80001ec0:	ff042623          	sw	a6,-20(s0)
80001ec4:	0340006f          	j	80001ef8 <strlen+0x54>
80001ec8:	fe842603          	lw	a2,-24(s0)
80001ecc:	fec42683          	lw	a3,-20(s0)
80001ed0:	00100513          	li	a0,1
80001ed4:	00000593          	li	a1,0
80001ed8:	00a60733          	add	a4,a2,a0
80001edc:	00070813          	mv	a6,a4
80001ee0:	00c83833          	sltu	a6,a6,a2
80001ee4:	00b687b3          	add	a5,a3,a1
80001ee8:	00f806b3          	add	a3,a6,a5
80001eec:	00068793          	mv	a5,a3
80001ef0:	fee42423          	sw	a4,-24(s0)
80001ef4:	fef42623          	sw	a5,-20(s0)
80001ef8:	fe842783          	lw	a5,-24(s0)
80001efc:	fdc42703          	lw	a4,-36(s0)
80001f00:	00f707b3          	add	a5,a4,a5
80001f04:	0007c783          	lbu	a5,0(a5)
80001f08:	fc0790e3          	bnez	a5,80001ec8 <strlen+0x24>
    
    return n;
80001f0c:	fe842703          	lw	a4,-24(s0)
80001f10:	fec42783          	lw	a5,-20(s0)
80001f14:	00070513          	mv	a0,a4
80001f18:	00078593          	mv	a1,a5
80001f1c:	02c12403          	lw	s0,44(sp)
80001f20:	03010113          	addi	sp,sp,48
80001f24:	00008067          	ret

80001f28 <r_tp>:
static inline uint32 r_tp(){
80001f28:	fe010113          	addi	sp,sp,-32
80001f2c:	00812e23          	sw	s0,28(sp)
80001f30:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001f34:	00020793          	mv	a5,tp
80001f38:	fef42623          	sw	a5,-20(s0)
    return x;
80001f3c:	fec42783          	lw	a5,-20(s0)
}
80001f40:	00078513          	mv	a0,a5
80001f44:	01c12403          	lw	s0,28(sp)
80001f48:	02010113          	addi	sp,sp,32
80001f4c:	00008067          	ret

80001f50 <clintinit>:
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit(){
80001f50:	fe010113          	addi	sp,sp,-32
80001f54:	00112e23          	sw	ra,28(sp)
80001f58:	00812c23          	sw	s0,24(sp)
80001f5c:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp 
    int hart=r_tp();
80001f60:	fc9ff0ef          	jal	ra,80001f28 <r_tp>
80001f64:	00050793          	mv	a5,a0
80001f68:	fef42623          	sw	a5,-20(s0)
    *(reg_t*)CLINT_MTIMECMP(hart)=*(reg_t*)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
80001f6c:	fec42703          	lw	a4,-20(s0)
80001f70:	004017b7          	lui	a5,0x401
80001f74:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80001f78:	00f707b3          	add	a5,a4,a5
80001f7c:	00379793          	slli	a5,a5,0x3
80001f80:	0007a703          	lw	a4,0(a5)
80001f84:	fec42683          	lw	a3,-20(s0)
80001f88:	004017b7          	lui	a5,0x401
80001f8c:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80001f90:	00f687b3          	add	a5,a3,a5
80001f94:	00379793          	slli	a5,a5,0x3
80001f98:	00078693          	mv	a3,a5
80001f9c:	009897b7          	lui	a5,0x989
80001fa0:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80001fa4:	00f707b3          	add	a5,a4,a5
80001fa8:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
80001fac:	00000013          	nop
80001fb0:	01c12083          	lw	ra,28(sp)
80001fb4:	01812403          	lw	s0,24(sp)
80001fb8:	02010113          	addi	sp,sp,32
80001fbc:	00008067          	ret

80001fc0 <r_mstatus>:
static inline uint32 r_mstatus(){
80001fc0:	fe010113          	addi	sp,sp,-32
80001fc4:	00812e23          	sw	s0,28(sp)
80001fc8:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80001fcc:	300027f3          	csrr	a5,mstatus
80001fd0:	fef42623          	sw	a5,-20(s0)
    return x;
80001fd4:	fec42783          	lw	a5,-20(s0)
}
80001fd8:	00078513          	mv	a0,a5
80001fdc:	01c12403          	lw	s0,28(sp)
80001fe0:	02010113          	addi	sp,sp,32
80001fe4:	00008067          	ret

80001fe8 <w_mstatus>:
static inline void w_mstatus(uint32 x){
80001fe8:	fe010113          	addi	sp,sp,-32
80001fec:	00812e23          	sw	s0,28(sp)
80001ff0:	02010413          	addi	s0,sp,32
80001ff4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80001ff8:	fec42783          	lw	a5,-20(s0)
80001ffc:	30079073          	csrw	mstatus,a5
}
80002000:	00000013          	nop
80002004:	01c12403          	lw	s0,28(sp)
80002008:	02010113          	addi	sp,sp,32
8000200c:	00008067          	ret

80002010 <w_mtvec>:
static inline void w_mtvec(uint32 x){
80002010:	fe010113          	addi	sp,sp,-32
80002014:	00812e23          	sw	s0,28(sp)
80002018:	02010413          	addi	s0,sp,32
8000201c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0" : : "r"(x));
80002020:	fec42783          	lw	a5,-20(s0)
80002024:	30579073          	csrw	mtvec,a5
}
80002028:	00000013          	nop
8000202c:	01c12403          	lw	s0,28(sp)
80002030:	02010113          	addi	sp,sp,32
80002034:	00008067          	ret

80002038 <r_tp>:
static inline uint32 r_tp(){
80002038:	fe010113          	addi	sp,sp,-32
8000203c:	00812e23          	sw	s0,28(sp)
80002040:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80002044:	00020793          	mv	a5,tp
80002048:	fef42623          	sw	a5,-20(s0)
    return x;
8000204c:	fec42783          	lw	a5,-20(s0)
}
80002050:	00078513          	mv	a0,a5
80002054:	01c12403          	lw	s0,28(sp)
80002058:	02010113          	addi	sp,sp,32
8000205c:	00008067          	ret

80002060 <s_mstatus_intr>:
static inline void s_mstatus_intr(uint32 m){
80002060:	fd010113          	addi	sp,sp,-48
80002064:	02112623          	sw	ra,44(sp)
80002068:	02812423          	sw	s0,40(sp)
8000206c:	03010413          	addi	s0,sp,48
80002070:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
80002074:	f4dff0ef          	jal	ra,80001fc0 <r_mstatus>
80002078:	fea42623          	sw	a0,-20(s0)
    switch (m)
8000207c:	fdc42703          	lw	a4,-36(s0)
80002080:	08000793          	li	a5,128
80002084:	04f70263          	beq	a4,a5,800020c8 <s_mstatus_intr+0x68>
80002088:	fdc42703          	lw	a4,-36(s0)
8000208c:	08000793          	li	a5,128
80002090:	0ae7e463          	bltu	a5,a4,80002138 <s_mstatus_intr+0xd8>
80002094:	fdc42703          	lw	a4,-36(s0)
80002098:	02000793          	li	a5,32
8000209c:	04f70463          	beq	a4,a5,800020e4 <s_mstatus_intr+0x84>
800020a0:	fdc42703          	lw	a4,-36(s0)
800020a4:	02000793          	li	a5,32
800020a8:	08e7e863          	bltu	a5,a4,80002138 <s_mstatus_intr+0xd8>
800020ac:	fdc42703          	lw	a4,-36(s0)
800020b0:	00200793          	li	a5,2
800020b4:	06f70463          	beq	a4,a5,8000211c <s_mstatus_intr+0xbc>
800020b8:	fdc42703          	lw	a4,-36(s0)
800020bc:	00800793          	li	a5,8
800020c0:	04f70063          	beq	a4,a5,80002100 <s_mstatus_intr+0xa0>
        break;
800020c4:	0740006f          	j	80002138 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
800020c8:	fec42783          	lw	a5,-20(s0)
800020cc:	f7f7f793          	andi	a5,a5,-129
800020d0:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
800020d4:	fec42783          	lw	a5,-20(s0)
800020d8:	0807e793          	ori	a5,a5,128
800020dc:	fef42623          	sw	a5,-20(s0)
        break;
800020e0:	05c0006f          	j	8000213c <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
800020e4:	fec42783          	lw	a5,-20(s0)
800020e8:	fdf7f793          	andi	a5,a5,-33
800020ec:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
800020f0:	fec42783          	lw	a5,-20(s0)
800020f4:	0207e793          	ori	a5,a5,32
800020f8:	fef42623          	sw	a5,-20(s0)
        break;
800020fc:	0400006f          	j	8000213c <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
80002100:	fec42783          	lw	a5,-20(s0)
80002104:	ff77f793          	andi	a5,a5,-9
80002108:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
8000210c:	fec42783          	lw	a5,-20(s0)
80002110:	0087e793          	ori	a5,a5,8
80002114:	fef42623          	sw	a5,-20(s0)
        break;
80002118:	0240006f          	j	8000213c <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
8000211c:	fec42783          	lw	a5,-20(s0)
80002120:	ffd7f793          	andi	a5,a5,-3
80002124:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80002128:	fec42783          	lw	a5,-20(s0)
8000212c:	0027e793          	ori	a5,a5,2
80002130:	fef42623          	sw	a5,-20(s0)
        break;
80002134:	0080006f          	j	8000213c <s_mstatus_intr+0xdc>
        break;
80002138:	00000013          	nop
    w_mstatus(x);
8000213c:	fec42503          	lw	a0,-20(s0)
80002140:	ea9ff0ef          	jal	ra,80001fe8 <w_mstatus>
}
80002144:	00000013          	nop
80002148:	02c12083          	lw	ra,44(sp)
8000214c:	02812403          	lw	s0,40(sp)
80002150:	03010113          	addi	sp,sp,48
80002154:	00008067          	ret

80002158 <r_sie>:
 */
80002158:	fe010113          	addi	sp,sp,-32
8000215c:	00812e23          	sw	s0,28(sp)
80002160:	02010413          	addi	s0,sp,32
#define STIE (1<<5)
80002164:	104027f3          	csrr	a5,sie
80002168:	fef42623          	sw	a5,-20(s0)
#define SSIE (1<<1)
8000216c:	fec42783          	lw	a5,-20(s0)
static inline uint32 r_sie(){
80002170:	00078513          	mv	a0,a5
80002174:	01c12403          	lw	s0,28(sp)
80002178:	02010113          	addi	sp,sp,32
8000217c:	00008067          	ret

80002180 <w_sie>:
    uint32 x;
80002180:	fe010113          	addi	sp,sp,-32
80002184:	00812e23          	sw	s0,28(sp)
80002188:	02010413          	addi	s0,sp,32
8000218c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrr %0,sie " : "=r"(x));
80002190:	fec42783          	lw	a5,-20(s0)
80002194:	10479073          	csrw	sie,a5
    return x;
80002198:	00000013          	nop
8000219c:	01c12403          	lw	s0,28(sp)
800021a0:	02010113          	addi	sp,sp,32
800021a4:	00008067          	ret

800021a8 <r_mie>:
}
static inline void w_sie(uint32 x){
    asm volatile("csrw sie,%0"::"r"(x));
}
800021a8:	fe010113          	addi	sp,sp,-32
800021ac:	00812e23          	sw	s0,28(sp)
800021b0:	02010413          	addi	s0,sp,32
#define MEIE (1<<11)
#define MTIE (1<<7)
800021b4:	304027f3          	csrr	a5,mie
800021b8:	fef42623          	sw	a5,-20(s0)
#define MSIE (1<<3)
800021bc:	fec42783          	lw	a5,-20(s0)
static inline uint32 r_mie(){
800021c0:	00078513          	mv	a0,a5
800021c4:	01c12403          	lw	s0,28(sp)
800021c8:	02010113          	addi	sp,sp,32
800021cc:	00008067          	ret

800021d0 <w_mie>:
    uint32 x;
800021d0:	fe010113          	addi	sp,sp,-32
800021d4:	00812e23          	sw	s0,28(sp)
800021d8:	02010413          	addi	s0,sp,32
800021dc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrr %0,mie " : "=r"(x));
800021e0:	fec42783          	lw	a5,-20(s0)
800021e4:	30479073          	csrw	mie,a5
    return x;
800021e8:	00000013          	nop
800021ec:	01c12403          	lw	s0,28(sp)
800021f0:	02010113          	addi	sp,sp,32
800021f4:	00008067          	ret

800021f8 <w_mscratch>:
}
static inline void w_mie(uint32 x){
    asm volatile("csrw mie,%0"::"r"(x));
800021f8:	fe010113          	addi	sp,sp,-32
800021fc:	00812e23          	sw	s0,28(sp)
80002200:	02010413          	addi	s0,sp,32
80002204:	fea42623          	sw	a0,-20(s0)
}
80002208:	fec42783          	lw	a5,-20(s0)
8000220c:	34079073          	csrw	mscratch,a5

80002210:	00000013          	nop
80002214:	01c12403          	lw	s0,28(sp)
80002218:	02010113          	addi	sp,sp,32
8000221c:	00008067          	ret

80002220 <timerinit>:

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit(){
80002220:	fe010113          	addi	sp,sp,-32
80002224:	00112e23          	sw	ra,28(sp)
80002228:	00812c23          	sw	s0,24(sp)
8000222c:	01212a23          	sw	s2,20(sp)
80002230:	01312823          	sw	s3,16(sp)
80002234:	02010413          	addi	s0,sp,32
    uint hart=r_tp();
80002238:	e01ff0ef          	jal	ra,80002038 <r_tp>
8000223c:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
80002240:	fec42703          	lw	a4,-20(s0)
80002244:	00070793          	mv	a5,a4
80002248:	00279793          	slli	a5,a5,0x2
8000224c:	00e787b3          	add	a5,a5,a4
80002250:	00379793          	slli	a5,a5,0x3
80002254:	8000e737          	lui	a4,0x8000e
80002258:	8b070713          	addi	a4,a4,-1872 # 8000d8b0 <memend+0xf800d8b0>
8000225c:	00e787b3          	add	a5,a5,a4
80002260:	00078513          	mv	a0,a5
80002264:	f95ff0ef          	jal	ra,800021f8 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
80002268:	fec42703          	lw	a4,-20(s0)
8000226c:	004017b7          	lui	a5,0x401
80002270:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002274:	00f707b3          	add	a5,a4,a5
80002278:	00379793          	slli	a5,a5,0x3
8000227c:	00078913          	mv	s2,a5
80002280:	00000993          	li	s3,0
80002284:	8000e7b7          	lui	a5,0x8000e
80002288:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
8000228c:	fec42703          	lw	a4,-20(s0)
80002290:	00070793          	mv	a5,a4
80002294:	00279793          	slli	a5,a5,0x2
80002298:	00e787b3          	add	a5,a5,a4
8000229c:	00379793          	slli	a5,a5,0x3
800022a0:	00f687b3          	add	a5,a3,a5
800022a4:	0127a023          	sw	s2,0(a5)
800022a8:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;
800022ac:	8000e7b7          	lui	a5,0x8000e
800022b0:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
800022b4:	fec42703          	lw	a4,-20(s0)
800022b8:	00070793          	mv	a5,a4
800022bc:	00279793          	slli	a5,a5,0x2
800022c0:	00e787b3          	add	a5,a5,a4
800022c4:	00379793          	slli	a5,a5,0x3
800022c8:	00f686b3          	add	a3,a3,a5
800022cc:	00989737          	lui	a4,0x989
800022d0:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
800022d4:	00000793          	li	a5,0
800022d8:	00e6a423          	sw	a4,8(a3)
800022dc:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数
800022e0:	800007b7          	lui	a5,0x80000
800022e4:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
800022e8:	00078513          	mv	a0,a5
800022ec:	d25ff0ef          	jal	ra,80002010 <w_mtvec>

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断
800022f0:	00800513          	li	a0,8
800022f4:	d6dff0ef          	jal	ra,80002060 <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
800022f8:	e61ff0ef          	jal	ra,80002158 <r_sie>
800022fc:	00050793          	mv	a5,a0
80002300:	2227e793          	ori	a5,a5,546
80002304:	00078513          	mv	a0,a5
80002308:	e79ff0ef          	jal	ra,80002180 <w_sie>

    w_mie(r_mie() | MTIE );      // 开启 M-mode 时钟中断
8000230c:	e9dff0ef          	jal	ra,800021a8 <r_mie>
80002310:	00050793          	mv	a5,a0
80002314:	0807e793          	ori	a5,a5,128
80002318:	00078513          	mv	a0,a5
8000231c:	eb5ff0ef          	jal	ra,800021d0 <w_mie>

    clintinit();                
80002320:	c31ff0ef          	jal	ra,80001f50 <clintinit>
80002324:	00000013          	nop
80002328:	01c12083          	lw	ra,28(sp)
8000232c:	01812403          	lw	s0,24(sp)
80002330:	01412903          	lw	s2,20(sp)
80002334:	01012983          	lw	s3,16(sp)
80002338:	02010113          	addi	sp,sp,32
8000233c:	00008067          	ret
