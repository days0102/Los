
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
800000ac:	321000ef          	jal	ra,80000bcc <trapvec>

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
tvec:     // 时钟中断处理
    // timerinit()将mscratch指向time_scartch
    csrrw a0,mscratch,a0   
80000134:	34051573          	csrrw	a0,mscratch,a0
    // 后面要使用 t1,t1,t3 ,先保存
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

    lw t0,0(a0) // CLINT_MTIMECMP(hart)
80000150:	00052283          	lw	t0,0(a0)
    lw t1,8(a0) // CLINT_INTERVAL 10000000
80000154:	00852303          	lw	t1,8(a0)
    lw t2,0(t0) // *CLINT_MTIMECMP(hart) 0~3byte
80000158:	0002a383          	lw	t2,0(t0)
    lw t3,4(t0) // *CLINT_MTIMECMP(hart) 4~7byte
8000015c:	0042ae03          	lw	t3,4(t0)
    add t4,t2,t1
80000160:	00638eb3          	add	t4,t2,t1
    sltu t5,t4,t2
80000164:	007ebf33          	sltu	t5,t4,t2
    add t3,t3,t5
80000168:	01ee0e33          	add	t3,t3,t5
    mv t2,t4
8000016c:	000e8393          	mv	t2,t4

    sw t2,0(t0)
80000170:	0072a023          	sw	t2,0(t0)
    sw t3,4(t0)
80000174:	01c2a223          	sw	t3,4(t0)

    // 产生一个 S-mode 软件中断
    // mret 时触发 S-mode 软件中断
    csrwi sip,2
80000178:	14415073          	csrwi	sip,2

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
80000708:	389010ef          	jal	ra,80002290 <timerinit>

    w_mepc((uint32)main);       // 设置 mepc 为 main 地址
8000070c:	800017b7          	lui	a5,0x80001
80000710:	96478793          	addi	a5,a5,-1692 # 80000964 <memend+0xf8000964>
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

800008f4 <task>:
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"
void task(){
800008f4:	fe010113          	addi	sp,sp,-32
800008f8:	00112e23          	sw	ra,28(sp)
800008fc:	00812c23          	sw	s0,24(sp)
80000900:	02010413          	addi	s0,sp,32
    int  j=5;
80000904:	00500793          	li	a5,5
80000908:	fef42623          	sw	a5,-20(s0)
    while(j--){
8000090c:	0300006f          	j	8000093c <task+0x48>
        int i=100000000;
80000910:	05f5e7b7          	lui	a5,0x5f5e
80000914:	10078793          	addi	a5,a5,256 # 5f5e100 <sz+0x5f5d100>
80000918:	fef42423          	sw	a5,-24(s0)
        while(i--);
8000091c:	00000013          	nop
80000920:	fe842783          	lw	a5,-24(s0)
80000924:	fff78713          	addi	a4,a5,-1
80000928:	fee42423          	sw	a4,-24(s0)
8000092c:	fe079ae3          	bnez	a5,80000920 <task+0x2c>
        printf("tesk\n");
80000930:	800037b7          	lui	a5,0x80003
80000934:	00c78513          	addi	a0,a5,12 # 8000300c <memend+0xf800300c>
80000938:	4dc000ef          	jal	ra,80000e14 <printf>
    while(j--){
8000093c:	fec42783          	lw	a5,-20(s0)
80000940:	fff78713          	addi	a4,a5,-1
80000944:	fee42623          	sw	a4,-20(s0)
80000948:	fc0794e3          	bnez	a5,80000910 <task+0x1c>
    }
}
8000094c:	00000013          	nop
80000950:	00000013          	nop
80000954:	01c12083          	lw	ra,28(sp)
80000958:	01812403          	lw	s0,24(sp)
8000095c:	02010113          	addi	sp,sp,32
80000960:	00008067          	ret

80000964 <main>:
void main(){
80000964:	ff010113          	addi	sp,sp,-16
80000968:	00112623          	sw	ra,12(sp)
8000096c:	00812423          	sw	s0,8(sp)
80000970:	01010413          	addi	s0,sp,16
    printf("start run main()\n");
80000974:	800037b7          	lui	a5,0x80003
80000978:	01478513          	addi	a0,a5,20 # 80003014 <memend+0xf8003014>
8000097c:	498000ef          	jal	ra,80000e14 <printf>

    minit();        // 物理内存管理
80000980:	0a1000ef          	jal	ra,80001220 <minit>
    plicinit();     // PLIC 中断处理
80000984:	23d000ef          	jal	ra,800013c0 <plicinit>
    
    kvminit();       // 启动虚拟内存
80000988:	6f1000ef          	jal	ra,80001878 <kvminit>
    // new.sp=r_sp();
    // // swtch(&old,&new);

    // userinit();
    // asm volatile("ecall");
    printf("----------------------\n");
8000098c:	800037b7          	lui	a5,0x80003
80000990:	02878513          	addi	a0,a5,40 # 80003028 <memend+0xf8003028>
80000994:	480000ef          	jal	ra,80000e14 <printf>
    while(1);
80000998:	0000006f          	j	80000998 <main+0x34>

8000099c <r_sepc>:

/**
 * @description: 读取 sepc 寄存器
 * S-mode 返回时跳转到 pc = sepc指向的地址
 */
static inline uint32 r_sepc(){
8000099c:	fe010113          	addi	sp,sp,-32
800009a0:	00812e23          	sw	s0,28(sp)
800009a4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, sepc" : "=r" (x) );
800009a8:	141027f3          	csrr	a5,sepc
800009ac:	fef42623          	sw	a5,-20(s0)
    return x;
800009b0:	fec42783          	lw	a5,-20(s0)
}
800009b4:	00078513          	mv	a0,a5
800009b8:	01c12403          	lw	s0,28(sp)
800009bc:	02010113          	addi	sp,sp,32
800009c0:	00008067          	ret

800009c4 <w_sepc>:
// 写 sepc寄存器
static inline void w_sepc(uint32 x){
800009c4:	fe010113          	addi	sp,sp,-32
800009c8:	00812e23          	sw	s0,28(sp)
800009cc:	02010413          	addi	s0,sp,32
800009d0:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sepc, %0" : : "r" (x) );
800009d4:	fec42783          	lw	a5,-20(s0)
800009d8:	14179073          	csrw	sepc,a5
}
800009dc:	00000013          	nop
800009e0:	01c12403          	lw	s0,28(sp)
800009e4:	02010113          	addi	sp,sp,32
800009e8:	00008067          	ret

800009ec <r_scause>:
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常 
 */
static inline uint32 r_scause(){
800009ec:	fe010113          	addi	sp,sp,-32
800009f0:	00812e23          	sw	s0,28(sp)
800009f4:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,scause":"=r"(x));
800009f8:	142027f3          	csrr	a5,scause
800009fc:	fef42623          	sw	a5,-20(s0)
    return x;
80000a00:	fec42783          	lw	a5,-20(s0)
}
80000a04:	00078513          	mv	a0,a5
80000a08:	01c12403          	lw	s0,28(sp)
80000a0c:	02010113          	addi	sp,sp,32
80000a10:	00008067          	ret

80000a14 <r_sip>:
        break;   
    }
    w_sstatus(x);
}

static inline uint32 r_sip(){
80000a14:	fe010113          	addi	sp,sp,-32
80000a18:	00812e23          	sw	s0,28(sp)
80000a1c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sip":"=r"(x));
80000a20:	144027f3          	csrr	a5,sip
80000a24:	fef42623          	sw	a5,-20(s0)
    return x;
80000a28:	fec42783          	lw	a5,-20(s0)
}
80000a2c:	00078513          	mv	a0,a5
80000a30:	01c12403          	lw	s0,28(sp)
80000a34:	02010113          	addi	sp,sp,32
80000a38:	00008067          	ret

80000a3c <w_sip>:
static inline void w_sip(uint32 x){
80000a3c:	fe010113          	addi	sp,sp,-32
80000a40:	00812e23          	sw	s0,28(sp)
80000a44:	02010413          	addi	s0,sp,32
80000a48:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sip,%0"::"r"(x));
80000a4c:	fec42783          	lw	a5,-20(s0)
80000a50:	14479073          	csrw	sip,a5
}
80000a54:	00000013          	nop
80000a58:	01c12403          	lw	s0,28(sp)
80000a5c:	02010113          	addi	sp,sp,32
80000a60:	00008067          	ret

80000a64 <externinterrupt>:
#include "clint.h"

/**
 * @description: 处理外部中断
 */
void externinterrupt(){
80000a64:	fe010113          	addi	sp,sp,-32
80000a68:	00112e23          	sw	ra,28(sp)
80000a6c:	00812c23          	sw	s0,24(sp)
80000a70:	02010413          	addi	s0,sp,32
    uint32 irq=r_plicclaim();
80000a74:	211000ef          	jal	ra,80001484 <r_plicclaim>
80000a78:	fea42623          	sw	a0,-20(s0)
    printf("irq : %d\n",irq);
80000a7c:	fec42583          	lw	a1,-20(s0)
80000a80:	800037b7          	lui	a5,0x80003
80000a84:	04078513          	addi	a0,a5,64 # 80003040 <memend+0xf8003040>
80000a88:	38c000ef          	jal	ra,80000e14 <printf>
    switch (irq)
80000a8c:	fec42703          	lw	a4,-20(s0)
80000a90:	00a00793          	li	a5,10
80000a94:	02f71063          	bne	a4,a5,80000ab4 <externinterrupt+0x50>
    {
    case UART_IRQ:  // uart 中断(键盘输入)
        printf("recived : %c\n",uartintr());
80000a98:	e2dff0ef          	jal	ra,800008c4 <uartintr>
80000a9c:	00050793          	mv	a5,a0
80000aa0:	00078593          	mv	a1,a5
80000aa4:	800037b7          	lui	a5,0x80003
80000aa8:	04c78513          	addi	a0,a5,76 # 8000304c <memend+0xf800304c>
80000aac:	368000ef          	jal	ra,80000e14 <printf>
        break;
80000ab0:	0080006f          	j	80000ab8 <externinterrupt+0x54>
    default:
        break;
80000ab4:	00000013          	nop
    }
    w_pliccomplete(irq);
80000ab8:	fec42503          	lw	a0,-20(s0)
80000abc:	209000ef          	jal	ra,800014c4 <w_pliccomplete>
}
80000ac0:	00000013          	nop
80000ac4:	01c12083          	lw	ra,28(sp)
80000ac8:	01812403          	lw	s0,24(sp)
80000acc:	02010113          	addi	sp,sp,32
80000ad0:	00008067          	ret

80000ad4 <usertrapret>:

// 返回用户空间
void usertrapret(){
80000ad4:	fe010113          	addi	sp,sp,-32
80000ad8:	00112e23          	sw	ra,28(sp)
80000adc:	00812c23          	sw	s0,24(sp)
80000ae0:	02010413          	addi	s0,sp,32
    struct pcb* p=nowproc();
80000ae4:	058010ef          	jal	ra,80001b3c <nowproc>
80000ae8:	fea42623          	sw	a0,-20(s0)
    loadframe(&p->trapframe);
80000aec:	fec42783          	lw	a5,-20(s0)
80000af0:	00878793          	addi	a5,a5,8
80000af4:	00078513          	mv	a0,a5
80000af8:	825ff0ef          	jal	ra,8000031c <loadframe>
}
80000afc:	00000013          	nop
80000b00:	01c12083          	lw	ra,28(sp)
80000b04:	01812403          	lw	s0,24(sp)
80000b08:	02010113          	addi	sp,sp,32
80000b0c:	00008067          	ret

80000b10 <zero>:

void zero(){
80000b10:	fe010113          	addi	sp,sp,-32
80000b14:	00112e23          	sw	ra,28(sp)
80000b18:	00812c23          	sw	s0,24(sp)
80000b1c:	02010413          	addi	s0,sp,32
    printf("zero\n");
80000b20:	800037b7          	lui	a5,0x80003
80000b24:	05c78513          	addi	a0,a5,92 # 8000305c <memend+0xf800305c>
80000b28:	2ec000ef          	jal	ra,80000e14 <printf>
    reg_t pc=r_sepc();
80000b2c:	e71ff0ef          	jal	ra,8000099c <r_sepc>
80000b30:	fea42423          	sw	a0,-24(s0)
    w_sepc(pc+4);
80000b34:	fe842783          	lw	a5,-24(s0)
80000b38:	00478793          	addi	a5,a5,4
80000b3c:	00078513          	mv	a0,a5
80000b40:	e85ff0ef          	jal	ra,800009c4 <w_sepc>
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80000b44:	8000d7b7          	lui	a5,0x8000d
80000b48:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80000b4c:	fef42623          	sw	a5,-20(s0)
80000b50:	0100006f          	j	80000b60 <zero+0x50>
80000b54:	fec42783          	lw	a5,-20(s0)
80000b58:	11878793          	addi	a5,a5,280
80000b5c:	fef42623          	sw	a5,-20(s0)
80000b60:	fec42703          	lw	a4,-20(s0)
80000b64:	8000e7b7          	lui	a5,0x8000e
80000b68:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80000b6c:	fef764e3          	bltu	a4,a5,80000b54 <zero+0x44>
        if(p->status==RUNABLE){
            
        }
    }
    usertrapret();
80000b70:	f65ff0ef          	jal	ra,80000ad4 <usertrapret>
}
80000b74:	00000013          	nop
80000b78:	01c12083          	lw	ra,28(sp)
80000b7c:	01812403          	lw	s0,24(sp)
80000b80:	02010113          	addi	sp,sp,32
80000b84:	00008067          	ret

80000b88 <timerintr>:

void timerintr(){
80000b88:	ff010113          	addi	sp,sp,-16
80000b8c:	00112623          	sw	ra,12(sp)
80000b90:	00812423          	sw	s0,8(sp)
80000b94:	01010413          	addi	s0,sp,16
    w_sip(r_sip()& ~2);
80000b98:	e7dff0ef          	jal	ra,80000a14 <r_sip>
80000b9c:	00050793          	mv	a5,a0
80000ba0:	ffd7f793          	andi	a5,a5,-3
80000ba4:	00078513          	mv	a0,a5
80000ba8:	e95ff0ef          	jal	ra,80000a3c <w_sip>
    printf("timer\n");
80000bac:	800037b7          	lui	a5,0x80003
80000bb0:	06478513          	addi	a0,a5,100 # 80003064 <memend+0xf8003064>
80000bb4:	260000ef          	jal	ra,80000e14 <printf>
}
80000bb8:	00000013          	nop
80000bbc:	00c12083          	lw	ra,12(sp)
80000bc0:	00812403          	lw	s0,8(sp)
80000bc4:	01010113          	addi	sp,sp,16
80000bc8:	00008067          	ret

80000bcc <trapvec>:

void trapvec(){
80000bcc:	fe010113          	addi	sp,sp,-32
80000bd0:	00112e23          	sw	ra,28(sp)
80000bd4:	00812c23          	sw	s0,24(sp)
80000bd8:	02010413          	addi	s0,sp,32
    uint32 scause=r_scause();
80000bdc:	e11ff0ef          	jal	ra,800009ec <r_scause>
80000be0:	fea42423          	sw	a0,-24(s0)
    printf("sip : %d\n",r_sip());
80000be4:	e31ff0ef          	jal	ra,80000a14 <r_sip>
80000be8:	00050793          	mv	a5,a0
80000bec:	00078593          	mv	a1,a5
80000bf0:	800037b7          	lui	a5,0x80003
80000bf4:	06c78513          	addi	a0,a5,108 # 8000306c <memend+0xf800306c>
80000bf8:	21c000ef          	jal	ra,80000e14 <printf>

    uint16 code= scause & 0xffff;
80000bfc:	fe842783          	lw	a5,-24(s0)
80000c00:	fef41323          	sh	a5,-26(s0)

    if(scause & (1<<31)){
80000c04:	fe842783          	lw	a5,-24(s0)
80000c08:	0807d063          	bgez	a5,80000c88 <trapvec+0xbc>
        printf("Interrupt : ");
80000c0c:	800037b7          	lui	a5,0x80003
80000c10:	07878513          	addi	a0,a5,120 # 80003078 <memend+0xf8003078>
80000c14:	200000ef          	jal	ra,80000e14 <printf>
        switch (code)
80000c18:	fe645783          	lhu	a5,-26(s0)
80000c1c:	00900713          	li	a4,9
80000c20:	04e78263          	beq	a5,a4,80000c64 <trapvec+0x98>
80000c24:	00900713          	li	a4,9
80000c28:	04f74863          	blt	a4,a5,80000c78 <trapvec+0xac>
80000c2c:	00100713          	li	a4,1
80000c30:	00e78863          	beq	a5,a4,80000c40 <trapvec+0x74>
80000c34:	00500713          	li	a4,5
80000c38:	00e78e63          	beq	a5,a4,80000c54 <trapvec+0x88>
80000c3c:	03c0006f          	j	80000c78 <trapvec+0xac>
        {
        case 1:
            printf("Supervisor software interrupt\n");
80000c40:	800037b7          	lui	a5,0x80003
80000c44:	08878513          	addi	a0,a5,136 # 80003088 <memend+0xf8003088>
80000c48:	1cc000ef          	jal	ra,80000e14 <printf>
            timerintr();
80000c4c:	f3dff0ef          	jal	ra,80000b88 <timerintr>
            break;
80000c50:	1780006f          	j	80000dc8 <trapvec+0x1fc>
        case 5:
            printf("Supervisor timer interrupt\n");
80000c54:	800037b7          	lui	a5,0x80003
80000c58:	0a878513          	addi	a0,a5,168 # 800030a8 <memend+0xf80030a8>
80000c5c:	1b8000ef          	jal	ra,80000e14 <printf>
            break;
80000c60:	1680006f          	j	80000dc8 <trapvec+0x1fc>
        case 9:
            printf("Supervisor external interrupt\n");
80000c64:	800037b7          	lui	a5,0x80003
80000c68:	0c478513          	addi	a0,a5,196 # 800030c4 <memend+0xf80030c4>
80000c6c:	1a8000ef          	jal	ra,80000e14 <printf>
            externinterrupt();
80000c70:	df5ff0ef          	jal	ra,80000a64 <externinterrupt>
            break;
80000c74:	1540006f          	j	80000dc8 <trapvec+0x1fc>
        default:
            printf("Other interrupt\n");
80000c78:	800037b7          	lui	a5,0x80003
80000c7c:	0e478513          	addi	a0,a5,228 # 800030e4 <memend+0xf80030e4>
80000c80:	194000ef          	jal	ra,80000e14 <printf>
            break;
80000c84:	1440006f          	j	80000dc8 <trapvec+0x1fc>
        }
    }else{
        int ecall=0;
80000c88:	fe042623          	sw	zero,-20(s0)
        printf("Exception : ");
80000c8c:	800037b7          	lui	a5,0x80003
80000c90:	0f878513          	addi	a0,a5,248 # 800030f8 <memend+0xf80030f8>
80000c94:	180000ef          	jal	ra,80000e14 <printf>
        switch (code)
80000c98:	fe645783          	lhu	a5,-26(s0)
80000c9c:	00f00713          	li	a4,15
80000ca0:	0ef76c63          	bltu	a4,a5,80000d98 <trapvec+0x1cc>
80000ca4:	00279713          	slli	a4,a5,0x2
80000ca8:	800037b7          	lui	a5,0x80003
80000cac:	26c78793          	addi	a5,a5,620 # 8000326c <memend+0xf800326c>
80000cb0:	00f707b3          	add	a5,a4,a5
80000cb4:	0007a783          	lw	a5,0(a5)
80000cb8:	00078067          	jr	a5
        {
        case 0:
            printf("Instruction address misaligned\n");
80000cbc:	800037b7          	lui	a5,0x80003
80000cc0:	10878513          	addi	a0,a5,264 # 80003108 <memend+0xf8003108>
80000cc4:	150000ef          	jal	ra,80000e14 <printf>
            break;
80000cc8:	0e00006f          	j	80000da8 <trapvec+0x1dc>
        case 1:
            printf("Instruction access fault\n");
80000ccc:	800037b7          	lui	a5,0x80003
80000cd0:	12878513          	addi	a0,a5,296 # 80003128 <memend+0xf8003128>
80000cd4:	140000ef          	jal	ra,80000e14 <printf>
            break;
80000cd8:	0d00006f          	j	80000da8 <trapvec+0x1dc>
        case 2:
            printf("Illegal instruction\n");
80000cdc:	800037b7          	lui	a5,0x80003
80000ce0:	14478513          	addi	a0,a5,324 # 80003144 <memend+0xf8003144>
80000ce4:	130000ef          	jal	ra,80000e14 <printf>
            break;
80000ce8:	0c00006f          	j	80000da8 <trapvec+0x1dc>
        case 3:
            printf("Breakpoint\n");
80000cec:	800037b7          	lui	a5,0x80003
80000cf0:	15c78513          	addi	a0,a5,348 # 8000315c <memend+0xf800315c>
80000cf4:	120000ef          	jal	ra,80000e14 <printf>
            break;
80000cf8:	0b00006f          	j	80000da8 <trapvec+0x1dc>
        case 4:
            printf("Load address misaligned\n");
80000cfc:	800037b7          	lui	a5,0x80003
80000d00:	16878513          	addi	a0,a5,360 # 80003168 <memend+0xf8003168>
80000d04:	110000ef          	jal	ra,80000e14 <printf>
            break;
80000d08:	0a00006f          	j	80000da8 <trapvec+0x1dc>
        case 5:
            printf("Load access fault\n");
80000d0c:	800037b7          	lui	a5,0x80003
80000d10:	18478513          	addi	a0,a5,388 # 80003184 <memend+0xf8003184>
80000d14:	100000ef          	jal	ra,80000e14 <printf>
            // ex : int a = *(int *)0x00000000;
            break;
80000d18:	0900006f          	j	80000da8 <trapvec+0x1dc>
        case 6:
            printf("Store/AMO address misaligned\n");
80000d1c:	800037b7          	lui	a5,0x80003
80000d20:	19878513          	addi	a0,a5,408 # 80003198 <memend+0xf8003198>
80000d24:	0f0000ef          	jal	ra,80000e14 <printf>
            break;
80000d28:	0800006f          	j	80000da8 <trapvec+0x1dc>
        case 7:
            printf("Store/AMO access fault\n");
80000d2c:	800037b7          	lui	a5,0x80003
80000d30:	1b878513          	addi	a0,a5,440 # 800031b8 <memend+0xf80031b8>
80000d34:	0e0000ef          	jal	ra,80000e14 <printf>
            // ex : *(int *)0x00000000 = 100;
            break;
80000d38:	0700006f          	j	80000da8 <trapvec+0x1dc>
        case 8: // 来自 U-mode 的系统调用
            printf("Environment call from U-mode\n");
80000d3c:	800037b7          	lui	a5,0x80003
80000d40:	1d078513          	addi	a0,a5,464 # 800031d0 <memend+0xf80031d0>
80000d44:	0d0000ef          	jal	ra,80000e14 <printf>
            break;
80000d48:	0600006f          	j	80000da8 <trapvec+0x1dc>
        case 9: // 来自 S-mode 的系统调用
            printf("Environment call from S-mode\n");
80000d4c:	800037b7          	lui	a5,0x80003
80000d50:	1f078513          	addi	a0,a5,496 # 800031f0 <memend+0xf80031f0>
80000d54:	0c0000ef          	jal	ra,80000e14 <printf>
            zero();
80000d58:	db9ff0ef          	jal	ra,80000b10 <zero>
            ecall=1;
80000d5c:	00100793          	li	a5,1
80000d60:	fef42623          	sw	a5,-20(s0)
            break;
80000d64:	0440006f          	j	80000da8 <trapvec+0x1dc>
        case 12:
            printf("Instruction page fault\n");
80000d68:	800037b7          	lui	a5,0x80003
80000d6c:	21078513          	addi	a0,a5,528 # 80003210 <memend+0xf8003210>
80000d70:	0a4000ef          	jal	ra,80000e14 <printf>
            break;
80000d74:	0340006f          	j	80000da8 <trapvec+0x1dc>
        case 13:
            printf("Load page fault\n");
80000d78:	800037b7          	lui	a5,0x80003
80000d7c:	22878513          	addi	a0,a5,552 # 80003228 <memend+0xf8003228>
80000d80:	094000ef          	jal	ra,80000e14 <printf>
            break;
80000d84:	0240006f          	j	80000da8 <trapvec+0x1dc>
        case 15:
            printf("Store/AMO page fault\n");
80000d88:	800037b7          	lui	a5,0x80003
80000d8c:	23c78513          	addi	a0,a5,572 # 8000323c <memend+0xf800323c>
80000d90:	084000ef          	jal	ra,80000e14 <printf>
            break;
80000d94:	0140006f          	j	80000da8 <trapvec+0x1dc>
        default:
            printf("Other\n");
80000d98:	800037b7          	lui	a5,0x80003
80000d9c:	25478513          	addi	a0,a5,596 # 80003254 <memend+0xf8003254>
80000da0:	074000ef          	jal	ra,80000e14 <printf>
            break;
80000da4:	00000013          	nop
        }
        if(!ecall){
80000da8:	fec42783          	lw	a5,-20(s0)
80000dac:	00079e63          	bnez	a5,80000dc8 <trapvec+0x1fc>
            panic("Trap Exception");
80000db0:	800037b7          	lui	a5,0x80003
80000db4:	25c78513          	addi	a0,a5,604 # 8000325c <memend+0xf800325c>
80000db8:	024000ef          	jal	ra,80000ddc <panic>
            ecall=1;
80000dbc:	00100793          	li	a5,1
80000dc0:	fef42623          	sw	a5,-20(s0)
        }
    }
}
80000dc4:	0040006f          	j	80000dc8 <trapvec+0x1fc>
80000dc8:	00000013          	nop
80000dcc:	01c12083          	lw	ra,28(sp)
80000dd0:	01812403          	lw	s0,24(sp)
80000dd4:	02010113          	addi	sp,sp,32
80000dd8:	00008067          	ret

80000ddc <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80000ddc:	fe010113          	addi	sp,sp,-32
80000de0:	00112e23          	sw	ra,28(sp)
80000de4:	00812c23          	sw	s0,24(sp)
80000de8:	02010413          	addi	s0,sp,32
80000dec:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80000df0:	800037b7          	lui	a5,0x80003
80000df4:	2ac78513          	addi	a0,a5,684 # 800032ac <memend+0xf80032ac>
80000df8:	a31ff0ef          	jal	ra,80000828 <uartputs>
    uartputs(s);
80000dfc:	fec42503          	lw	a0,-20(s0)
80000e00:	a29ff0ef          	jal	ra,80000828 <uartputs>
	uartputs("\n");
80000e04:	800037b7          	lui	a5,0x80003
80000e08:	2b478513          	addi	a0,a5,692 # 800032b4 <memend+0xf80032b4>
80000e0c:	a1dff0ef          	jal	ra,80000828 <uartputs>
    while(1);
80000e10:	0000006f          	j	80000e10 <panic+0x34>

80000e14 <printf>:
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
80000e14:	f8010113          	addi	sp,sp,-128
80000e18:	04112e23          	sw	ra,92(sp)
80000e1c:	04812c23          	sw	s0,88(sp)
80000e20:	06010413          	addi	s0,sp,96
80000e24:	faa42623          	sw	a0,-84(s0)
80000e28:	00b42223          	sw	a1,4(s0)
80000e2c:	00c42423          	sw	a2,8(s0)
80000e30:	00d42623          	sw	a3,12(s0)
80000e34:	00e42823          	sw	a4,16(s0)
80000e38:	00f42a23          	sw	a5,20(s0)
80000e3c:	01042c23          	sw	a6,24(s0)
80000e40:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80000e44:	02040793          	addi	a5,s0,32
80000e48:	faf42423          	sw	a5,-88(s0)
80000e4c:	fa842783          	lw	a5,-88(s0)
80000e50:	fe478793          	addi	a5,a5,-28
80000e54:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
80000e58:	fac42783          	lw	a5,-84(s0)
80000e5c:	fef42623          	sw	a5,-20(s0)
	int tt=0;
80000e60:	fe042423          	sw	zero,-24(s0)
	int idx=0;
80000e64:	fe042223          	sw	zero,-28(s0)
	while((ch=*(s))){
80000e68:	36c0006f          	j	800011d4 <printf+0x3c0>
		if(ch=='%'){
80000e6c:	fbf44703          	lbu	a4,-65(s0)
80000e70:	02500793          	li	a5,37
80000e74:	04f71863          	bne	a4,a5,80000ec4 <printf+0xb0>
			if(tt==1){
80000e78:	fe842703          	lw	a4,-24(s0)
80000e7c:	00100793          	li	a5,1
80000e80:	02f71663          	bne	a4,a5,80000eac <printf+0x98>
				outbuf[idx++]='%';
80000e84:	fe442783          	lw	a5,-28(s0)
80000e88:	00178713          	addi	a4,a5,1
80000e8c:	fee42223          	sw	a4,-28(s0)
80000e90:	8000d737          	lui	a4,0x8000d
80000e94:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000e98:	00f707b3          	add	a5,a4,a5
80000e9c:	02500713          	li	a4,37
80000ea0:	00e78023          	sb	a4,0(a5)
				tt=0;
80000ea4:	fe042423          	sw	zero,-24(s0)
80000ea8:	00c0006f          	j	80000eb4 <printf+0xa0>
			}else{
				tt=1;
80000eac:	00100793          	li	a5,1
80000eb0:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80000eb4:	fec42783          	lw	a5,-20(s0)
80000eb8:	00178793          	addi	a5,a5,1
80000ebc:	fef42623          	sw	a5,-20(s0)
80000ec0:	3140006f          	j	800011d4 <printf+0x3c0>
		}else{
			if(tt==1){
80000ec4:	fe842703          	lw	a4,-24(s0)
80000ec8:	00100793          	li	a5,1
80000ecc:	2cf71e63          	bne	a4,a5,800011a8 <printf+0x394>
				switch (ch)
80000ed0:	fbf44783          	lbu	a5,-65(s0)
80000ed4:	fa878793          	addi	a5,a5,-88
80000ed8:	02000713          	li	a4,32
80000edc:	2af76663          	bltu	a4,a5,80001188 <printf+0x374>
80000ee0:	00279713          	slli	a4,a5,0x2
80000ee4:	800037b7          	lui	a5,0x80003
80000ee8:	2d078793          	addi	a5,a5,720 # 800032d0 <memend+0xf80032d0>
80000eec:	00f707b3          	add	a5,a4,a5
80000ef0:	0007a783          	lw	a5,0(a5)
80000ef4:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80000ef8:	fb842783          	lw	a5,-72(s0)
80000efc:	00478713          	addi	a4,a5,4
80000f00:	fae42c23          	sw	a4,-72(s0)
80000f04:	0007a783          	lw	a5,0(a5)
80000f08:	fef42023          	sw	a5,-32(s0)
					int len=0;
80000f0c:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
80000f10:	fe042783          	lw	a5,-32(s0)
80000f14:	fcf42c23          	sw	a5,-40(s0)
80000f18:	0100006f          	j	80000f28 <printf+0x114>
80000f1c:	fdc42783          	lw	a5,-36(s0)
80000f20:	00178793          	addi	a5,a5,1
80000f24:	fcf42e23          	sw	a5,-36(s0)
80000f28:	fd842703          	lw	a4,-40(s0)
80000f2c:	00a00793          	li	a5,10
80000f30:	02f747b3          	div	a5,a4,a5
80000f34:	fcf42c23          	sw	a5,-40(s0)
80000f38:	fd842783          	lw	a5,-40(s0)
80000f3c:	fe0790e3          	bnez	a5,80000f1c <printf+0x108>
					for(int i=len;i>=0;i--){
80000f40:	fdc42783          	lw	a5,-36(s0)
80000f44:	fcf42a23          	sw	a5,-44(s0)
80000f48:	0540006f          	j	80000f9c <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80000f4c:	fe042703          	lw	a4,-32(s0)
80000f50:	00a00793          	li	a5,10
80000f54:	02f767b3          	rem	a5,a4,a5
80000f58:	0ff7f713          	andi	a4,a5,255
80000f5c:	fe442683          	lw	a3,-28(s0)
80000f60:	fd442783          	lw	a5,-44(s0)
80000f64:	00f687b3          	add	a5,a3,a5
80000f68:	03070713          	addi	a4,a4,48
80000f6c:	0ff77713          	andi	a4,a4,255
80000f70:	8000d6b7          	lui	a3,0x8000d
80000f74:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
80000f78:	00f687b3          	add	a5,a3,a5
80000f7c:	00e78023          	sb	a4,0(a5)
						x/=10;
80000f80:	fe042703          	lw	a4,-32(s0)
80000f84:	00a00793          	li	a5,10
80000f88:	02f747b3          	div	a5,a4,a5
80000f8c:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
80000f90:	fd442783          	lw	a5,-44(s0)
80000f94:	fff78793          	addi	a5,a5,-1
80000f98:	fcf42a23          	sw	a5,-44(s0)
80000f9c:	fd442783          	lw	a5,-44(s0)
80000fa0:	fa07d6e3          	bgez	a5,80000f4c <printf+0x138>
					}
					idx+=(len+1);
80000fa4:	fdc42783          	lw	a5,-36(s0)
80000fa8:	00178793          	addi	a5,a5,1
80000fac:	fe442703          	lw	a4,-28(s0)
80000fb0:	00f707b3          	add	a5,a4,a5
80000fb4:	fef42223          	sw	a5,-28(s0)
					tt=0;
80000fb8:	fe042423          	sw	zero,-24(s0)
					break;
80000fbc:	1dc0006f          	j	80001198 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
80000fc0:	fe442783          	lw	a5,-28(s0)
80000fc4:	00178713          	addi	a4,a5,1
80000fc8:	fee42223          	sw	a4,-28(s0)
80000fcc:	8000d737          	lui	a4,0x8000d
80000fd0:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000fd4:	00f707b3          	add	a5,a4,a5
80000fd8:	03000713          	li	a4,48
80000fdc:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
80000fe0:	fe442783          	lw	a5,-28(s0)
80000fe4:	00178713          	addi	a4,a5,1
80000fe8:	fee42223          	sw	a4,-28(s0)
80000fec:	8000d737          	lui	a4,0x8000d
80000ff0:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
80000ff4:	00f707b3          	add	a5,a4,a5
80000ff8:	07800713          	li	a4,120
80000ffc:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
80001000:	fb842783          	lw	a5,-72(s0)
80001004:	00478713          	addi	a4,a5,4
80001008:	fae42c23          	sw	a4,-72(s0)
8000100c:	0007a783          	lw	a5,0(a5)
80001010:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80001014:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80001018:	fd042783          	lw	a5,-48(s0)
8000101c:	fcf42423          	sw	a5,-56(s0)
80001020:	0100006f          	j	80001030 <printf+0x21c>
80001024:	fcc42783          	lw	a5,-52(s0)
80001028:	00178793          	addi	a5,a5,1
8000102c:	fcf42623          	sw	a5,-52(s0)
80001030:	fc842783          	lw	a5,-56(s0)
80001034:	0047d793          	srli	a5,a5,0x4
80001038:	fcf42423          	sw	a5,-56(s0)
8000103c:	fc842783          	lw	a5,-56(s0)
80001040:	fe0792e3          	bnez	a5,80001024 <printf+0x210>
					for(int i=len;i>=0;i--){
80001044:	fcc42783          	lw	a5,-52(s0)
80001048:	fcf42223          	sw	a5,-60(s0)
8000104c:	0840006f          	j	800010d0 <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
80001050:	fd042783          	lw	a5,-48(s0)
80001054:	00f7f713          	andi	a4,a5,15
80001058:	00900793          	li	a5,9
8000105c:	02e7f063          	bgeu	a5,a4,8000107c <printf+0x268>
80001060:	fd042783          	lw	a5,-48(s0)
80001064:	0ff7f793          	andi	a5,a5,255
80001068:	00f7f793          	andi	a5,a5,15
8000106c:	0ff7f793          	andi	a5,a5,255
80001070:	05778793          	addi	a5,a5,87
80001074:	0ff7f793          	andi	a5,a5,255
80001078:	01c0006f          	j	80001094 <printf+0x280>
8000107c:	fd042783          	lw	a5,-48(s0)
80001080:	0ff7f793          	andi	a5,a5,255
80001084:	00f7f793          	andi	a5,a5,15
80001088:	0ff7f793          	andi	a5,a5,255
8000108c:	03078793          	addi	a5,a5,48
80001090:	0ff7f793          	andi	a5,a5,255
80001094:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
80001098:	fe442703          	lw	a4,-28(s0)
8000109c:	fc442783          	lw	a5,-60(s0)
800010a0:	00f707b3          	add	a5,a4,a5
800010a4:	8000d737          	lui	a4,0x8000d
800010a8:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
800010ac:	00f707b3          	add	a5,a4,a5
800010b0:	fbe44703          	lbu	a4,-66(s0)
800010b4:	00e78023          	sb	a4,0(a5)
						x/=16;
800010b8:	fd042783          	lw	a5,-48(s0)
800010bc:	0047d793          	srli	a5,a5,0x4
800010c0:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
800010c4:	fc442783          	lw	a5,-60(s0)
800010c8:	fff78793          	addi	a5,a5,-1
800010cc:	fcf42223          	sw	a5,-60(s0)
800010d0:	fc442783          	lw	a5,-60(s0)
800010d4:	f607dee3          	bgez	a5,80001050 <printf+0x23c>
					}
					idx+=(len+1);
800010d8:	fcc42783          	lw	a5,-52(s0)
800010dc:	00178793          	addi	a5,a5,1
800010e0:	fe442703          	lw	a4,-28(s0)
800010e4:	00f707b3          	add	a5,a4,a5
800010e8:	fef42223          	sw	a5,-28(s0)
					tt=0;
800010ec:	fe042423          	sw	zero,-24(s0)
					break;
800010f0:	0a80006f          	j	80001198 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
800010f4:	fb842783          	lw	a5,-72(s0)
800010f8:	00478713          	addi	a4,a5,4
800010fc:	fae42c23          	sw	a4,-72(s0)
80001100:	0007a783          	lw	a5,0(a5)
80001104:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80001108:	fe442783          	lw	a5,-28(s0)
8000110c:	00178713          	addi	a4,a5,1
80001110:	fee42223          	sw	a4,-28(s0)
80001114:	8000d737          	lui	a4,0x8000d
80001118:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
8000111c:	00f707b3          	add	a5,a4,a5
80001120:	fbf44703          	lbu	a4,-65(s0)
80001124:	00e78023          	sb	a4,0(a5)
					tt=0;
80001128:	fe042423          	sw	zero,-24(s0)
					break;
8000112c:	06c0006f          	j	80001198 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
80001130:	fb842783          	lw	a5,-72(s0)
80001134:	00478713          	addi	a4,a5,4
80001138:	fae42c23          	sw	a4,-72(s0)
8000113c:	0007a783          	lw	a5,0(a5)
80001140:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80001144:	0300006f          	j	80001174 <printf+0x360>
						outbuf[idx++]=*ss++;
80001148:	fc042703          	lw	a4,-64(s0)
8000114c:	00170793          	addi	a5,a4,1
80001150:	fcf42023          	sw	a5,-64(s0)
80001154:	fe442783          	lw	a5,-28(s0)
80001158:	00178693          	addi	a3,a5,1
8000115c:	fed42223          	sw	a3,-28(s0)
80001160:	00074703          	lbu	a4,0(a4)
80001164:	8000d6b7          	lui	a3,0x8000d
80001168:	00468693          	addi	a3,a3,4 # 8000d004 <memend+0xf800d004>
8000116c:	00f687b3          	add	a5,a3,a5
80001170:	00e78023          	sb	a4,0(a5)
					while(*ss){
80001174:	fc042783          	lw	a5,-64(s0)
80001178:	0007c783          	lbu	a5,0(a5)
8000117c:	fc0796e3          	bnez	a5,80001148 <printf+0x334>
					}
					tt=0;
80001180:	fe042423          	sw	zero,-24(s0)
					break;
80001184:	0140006f          	j	80001198 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
80001188:	800037b7          	lui	a5,0x80003
8000118c:	2b878513          	addi	a0,a5,696 # 800032b8 <memend+0xf80032b8>
80001190:	c4dff0ef          	jal	ra,80000ddc <panic>
					break;
80001194:	00000013          	nop
				}
				s++;
80001198:	fec42783          	lw	a5,-20(s0)
8000119c:	00178793          	addi	a5,a5,1
800011a0:	fef42623          	sw	a5,-20(s0)
800011a4:	0300006f          	j	800011d4 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
800011a8:	fe442783          	lw	a5,-28(s0)
800011ac:	00178713          	addi	a4,a5,1
800011b0:	fee42223          	sw	a4,-28(s0)
800011b4:	8000d737          	lui	a4,0x8000d
800011b8:	00470713          	addi	a4,a4,4 # 8000d004 <memend+0xf800d004>
800011bc:	00f707b3          	add	a5,a4,a5
800011c0:	fbf44703          	lbu	a4,-65(s0)
800011c4:	00e78023          	sb	a4,0(a5)
				s++;
800011c8:	fec42783          	lw	a5,-20(s0)
800011cc:	00178793          	addi	a5,a5,1
800011d0:	fef42623          	sw	a5,-20(s0)
	while((ch=*(s))){
800011d4:	fec42783          	lw	a5,-20(s0)
800011d8:	0007c783          	lbu	a5,0(a5)
800011dc:	faf40fa3          	sb	a5,-65(s0)
800011e0:	fbf44783          	lbu	a5,-65(s0)
800011e4:	c80794e3          	bnez	a5,80000e6c <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
800011e8:	8000d7b7          	lui	a5,0x8000d
800011ec:	00478713          	addi	a4,a5,4 # 8000d004 <memend+0xf800d004>
800011f0:	fe442783          	lw	a5,-28(s0)
800011f4:	00f707b3          	add	a5,a4,a5
800011f8:	00078023          	sb	zero,0(a5)
	uartputs(outbuf);
800011fc:	8000d7b7          	lui	a5,0x8000d
80001200:	00478513          	addi	a0,a5,4 # 8000d004 <memend+0xf800d004>
80001204:	e24ff0ef          	jal	ra,80000828 <uartputs>
	return idx;
80001208:	fe442783          	lw	a5,-28(s0)
8000120c:	00078513          	mv	a0,a5
80001210:	05c12083          	lw	ra,92(sp)
80001214:	05812403          	lw	s0,88(sp)
80001218:	08010113          	addi	sp,sp,128
8000121c:	00008067          	ret

80001220 <minit>:
struct
{
    struct pmp* freelist;
}mem;

void minit(){
80001220:	fe010113          	addi	sp,sp,-32
80001224:	00812e23          	sw	s0,28(sp)
80001228:	02010413          	addi	s0,sp,32
        printf("mstart:%p   ",mstart);
        printf("mend:%p\n",mend);
        printf("stack:%p\n",stacks);
    #endif

    char* p=(char*)mstart;
8000122c:	8000e7b7          	lui	a5,0x8000e
80001230:	00078793          	mv	a5,a5
80001234:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001238:	0380006f          	j	80001270 <minit+0x50>
        m=(struct pmp*)p;
8000123c:	fec42783          	lw	a5,-20(s0)
80001240:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
80001244:	8000e7b7          	lui	a5,0x8000e
80001248:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
8000124c:	fe842783          	lw	a5,-24(s0)
80001250:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
80001254:	8000e7b7          	lui	a5,0x8000e
80001258:	fe842703          	lw	a4,-24(s0)
8000125c:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    for( ; p + PGSIZE <= (char*)mend ; p+=PGSIZE){
80001260:	fec42703          	lw	a4,-20(s0)
80001264:	000017b7          	lui	a5,0x1
80001268:	00f707b3          	add	a5,a4,a5
8000126c:	fef42623          	sw	a5,-20(s0)
80001270:	fec42703          	lw	a4,-20(s0)
80001274:	000017b7          	lui	a5,0x1
80001278:	00f70733          	add	a4,a4,a5
8000127c:	880007b7          	lui	a5,0x88000
80001280:	00078793          	mv	a5,a5
80001284:	fae7fce3          	bgeu	a5,a4,8000123c <minit+0x1c>
    }
}
80001288:	00000013          	nop
8000128c:	00000013          	nop
80001290:	01c12403          	lw	s0,28(sp)
80001294:	02010113          	addi	sp,sp,32
80001298:	00008067          	ret

8000129c <palloc>:

void* palloc(){
8000129c:	fe010113          	addi	sp,sp,-32
800012a0:	00112e23          	sw	ra,28(sp)
800012a4:	00812c23          	sw	s0,24(sp)
800012a8:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
800012ac:	8000e7b7          	lui	a5,0x8000e
800012b0:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800012b4:	fef42623          	sw	a5,-20(s0)
    if(p)
800012b8:	fec42783          	lw	a5,-20(s0)
800012bc:	00078c63          	beqz	a5,800012d4 <palloc+0x38>
        mem.freelist=mem.freelist->next;
800012c0:	8000e7b7          	lui	a5,0x8000e
800012c4:	8a47a783          	lw	a5,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
800012c8:	0007a703          	lw	a4,0(a5)
800012cc:	8000e7b7          	lui	a5,0x8000e
800012d0:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
    if(p)
800012d4:	fec42783          	lw	a5,-20(s0)
800012d8:	00078a63          	beqz	a5,800012ec <palloc+0x50>
        memset(p,0,PGSIZE);
800012dc:	00001637          	lui	a2,0x1
800012e0:	00000593          	li	a1,0
800012e4:	fec42503          	lw	a0,-20(s0)
800012e8:	261000ef          	jal	ra,80001d48 <memset>
    return (void*)p;
800012ec:	fec42783          	lw	a5,-20(s0)
}
800012f0:	00078513          	mv	a0,a5
800012f4:	01c12083          	lw	ra,28(sp)
800012f8:	01812403          	lw	s0,24(sp)
800012fc:	02010113          	addi	sp,sp,32
80001300:	00008067          	ret

80001304 <pfree>:

void pfree(void* addr){
80001304:	fd010113          	addi	sp,sp,-48
80001308:	02812623          	sw	s0,44(sp)
8000130c:	03010413          	addi	s0,sp,48
80001310:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80001314:	fdc42783          	lw	a5,-36(s0)
80001318:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
8000131c:	8000e7b7          	lui	a5,0x8000e
80001320:	8a47a703          	lw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001324:	fec42783          	lw	a5,-20(s0)
80001328:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
8000132c:	8000e7b7          	lui	a5,0x8000e
80001330:	fec42703          	lw	a4,-20(s0)
80001334:	8ae7a223          	sw	a4,-1884(a5) # 8000d8a4 <memend+0xf800d8a4>
80001338:	00000013          	nop
8000133c:	02c12403          	lw	s0,44(sp)
80001340:	03010113          	addi	sp,sp,48
80001344:	00008067          	ret

80001348 <r_tp>:
static inline uint32 r_tp(){
80001348:	fe010113          	addi	sp,sp,-32
8000134c:	00812e23          	sw	s0,28(sp)
80001350:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001354:	00020793          	mv	a5,tp
80001358:	fef42623          	sw	a5,-20(s0)
    return x;
8000135c:	fec42783          	lw	a5,-20(s0)
}
80001360:	00078513          	mv	a0,a5
80001364:	01c12403          	lw	s0,28(sp)
80001368:	02010113          	addi	sp,sp,32
8000136c:	00008067          	ret

80001370 <r_sie>:
 * @description: S-mode 中断使能
 */
#define SEIE (1<<9)
#define STIE (1<<5)
#define SSIE (1<<1)
static inline uint32 r_sie(){
80001370:	fe010113          	addi	sp,sp,-32
80001374:	00812e23          	sw	s0,28(sp)
80001378:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,sie " : "=r"(x));
8000137c:	104027f3          	csrr	a5,sie
80001380:	fef42623          	sw	a5,-20(s0)
    return x;
80001384:	fec42783          	lw	a5,-20(s0)
}
80001388:	00078513          	mv	a0,a5
8000138c:	01c12403          	lw	s0,28(sp)
80001390:	02010113          	addi	sp,sp,32
80001394:	00008067          	ret

80001398 <w_sie>:
static inline void w_sie(uint32 x){
80001398:	fe010113          	addi	sp,sp,-32
8000139c:	00812e23          	sw	s0,28(sp)
800013a0:	02010413          	addi	s0,sp,32
800013a4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
800013a8:	fec42783          	lw	a5,-20(s0)
800013ac:	10479073          	csrw	sie,a5
}
800013b0:	00000013          	nop
800013b4:	01c12403          	lw	s0,28(sp)
800013b8:	02010113          	addi	sp,sp,32
800013bc:	00008067          	ret

800013c0 <plicinit>:
#include "plic.h"
#include "types.h"
#include "riscv.h"

// 初始化平台级中断控制 Platform Level Interrupt Controller (PLIC).
void plicinit(){
800013c0:	ff010113          	addi	sp,sp,-16
800013c4:	00112623          	sw	ra,12(sp)
800013c8:	00812423          	sw	s0,8(sp)
800013cc:	01010413          	addi	s0,sp,16
    *(uint32*)PLIC_PRIORITY(UART_IRQ)=1; // uart 设置优先级(1~7)，0为关中断
800013d0:	0c0007b7          	lui	a5,0xc000
800013d4:	02878793          	addi	a5,a5,40 # c000028 <sz+0xbfff028>
800013d8:	00100713          	li	a4,1
800013dc:	00e7a023          	sw	a4,0(a5)
    
    *(uint32*)PLIC_SENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
800013e0:	f69ff0ef          	jal	ra,80001348 <r_tp>
800013e4:	00050793          	mv	a5,a0
800013e8:	00879713          	slli	a4,a5,0x8
800013ec:	0c0027b7          	lui	a5,0xc002
800013f0:	08078793          	addi	a5,a5,128 # c002080 <sz+0xc001080>
800013f4:	00f707b3          	add	a5,a4,a5
800013f8:	00078713          	mv	a4,a5
800013fc:	40000793          	li	a5,1024
80001400:	00f72023          	sw	a5,0(a4)
    *(uint32*)PLIC_MENABLE(r_tp()) = (1<<UART_IRQ);  // uart 开中断
80001404:	f45ff0ef          	jal	ra,80001348 <r_tp>
80001408:	00050713          	mv	a4,a0
8000140c:	000c07b7          	lui	a5,0xc0
80001410:	02078793          	addi	a5,a5,32 # c0020 <sz+0xbf020>
80001414:	00f707b3          	add	a5,a4,a5
80001418:	00879793          	slli	a5,a5,0x8
8000141c:	00078713          	mv	a4,a5
80001420:	40000793          	li	a5,1024
80001424:	00f72023          	sw	a5,0(a4)

    // 设置优先级阈值(忽略小于阈值的中断)
    *(uint32*)PLIC_MPRIORITY(r_tp()) = 0;
80001428:	f21ff0ef          	jal	ra,80001348 <r_tp>
8000142c:	00050713          	mv	a4,a0
80001430:	000067b7          	lui	a5,0x6
80001434:	10078793          	addi	a5,a5,256 # 6100 <sz+0x5100>
80001438:	00f707b3          	add	a5,a4,a5
8000143c:	00d79793          	slli	a5,a5,0xd
80001440:	0007a023          	sw	zero,0(a5)
    *(uint32*)PLIC_SPRIORITY(r_tp()) = 0;
80001444:	f05ff0ef          	jal	ra,80001348 <r_tp>
80001448:	00050793          	mv	a5,a0
8000144c:	00d79713          	slli	a4,a5,0xd
80001450:	0c2017b7          	lui	a5,0xc201
80001454:	00f707b3          	add	a5,a4,a5
80001458:	0007a023          	sw	zero,0(a5) # c201000 <sz+0xc200000>

    w_sie(r_sie()|SSIE|STIE|SEIE); // 开S-mode中断
8000145c:	f15ff0ef          	jal	ra,80001370 <r_sie>
80001460:	00050793          	mv	a5,a0
80001464:	2227e793          	ori	a5,a5,546
80001468:	00078513          	mv	a0,a5
8000146c:	f2dff0ef          	jal	ra,80001398 <w_sie>
}
80001470:	00000013          	nop
80001474:	00c12083          	lw	ra,12(sp)
80001478:	00812403          	lw	s0,8(sp)
8000147c:	01010113          	addi	sp,sp,16
80001480:	00008067          	ret

80001484 <r_plicclaim>:

// 读取claim寄存器，获取当前最高优先级中断源
uint32 r_plicclaim(){
80001484:	ff010113          	addi	sp,sp,-16
80001488:	00112623          	sw	ra,12(sp)
8000148c:	00812423          	sw	s0,8(sp)
80001490:	01010413          	addi	s0,sp,16
    return *(uint32*)PLIC_SCLAIM(r_tp());
80001494:	eb5ff0ef          	jal	ra,80001348 <r_tp>
80001498:	00050793          	mv	a5,a0
8000149c:	00d79713          	slli	a4,a5,0xd
800014a0:	0c2017b7          	lui	a5,0xc201
800014a4:	00478793          	addi	a5,a5,4 # c201004 <sz+0xc200004>
800014a8:	00f707b3          	add	a5,a4,a5
800014ac:	0007a783          	lw	a5,0(a5)
}
800014b0:	00078513          	mv	a0,a5
800014b4:	00c12083          	lw	ra,12(sp)
800014b8:	00812403          	lw	s0,8(sp)
800014bc:	01010113          	addi	sp,sp,16
800014c0:	00008067          	ret

800014c4 <w_pliccomplete>:
// 写complete寄存器，表示irq中断处理完成
void w_pliccomplete(uint32 irq){
800014c4:	fe010113          	addi	sp,sp,-32
800014c8:	00112e23          	sw	ra,28(sp)
800014cc:	00812c23          	sw	s0,24(sp)
800014d0:	02010413          	addi	s0,sp,32
800014d4:	fea42623          	sw	a0,-20(s0)
    *(uint32*)PLIC_MCOMPLETE(r_tp())=irq;
800014d8:	e71ff0ef          	jal	ra,80001348 <r_tp>
800014dc:	00050793          	mv	a5,a0
800014e0:	00d79713          	slli	a4,a5,0xd
800014e4:	0c2007b7          	lui	a5,0xc200
800014e8:	00478793          	addi	a5,a5,4 # c200004 <sz+0xc1ff004>
800014ec:	00f707b3          	add	a5,a4,a5
800014f0:	00078713          	mv	a4,a5
800014f4:	fec42783          	lw	a5,-20(s0)
800014f8:	00f72023          	sw	a5,0(a4)
800014fc:	00000013          	nop
80001500:	01c12083          	lw	ra,28(sp)
80001504:	01812403          	lw	s0,24(sp)
80001508:	02010113          	addi	sp,sp,32
8000150c:	00008067          	ret

80001510 <w_satp>:
static inline void w_satp(uint32 x){
80001510:	fe010113          	addi	sp,sp,-32
80001514:	00812e23          	sw	s0,28(sp)
80001518:	02010413          	addi	s0,sp,32
8000151c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80001520:	fec42783          	lw	a5,-20(s0)
80001524:	18079073          	csrw	satp,a5
}
80001528:	00000013          	nop
8000152c:	01c12403          	lw	s0,28(sp)
80001530:	02010113          	addi	sp,sp,32
80001534:	00008067          	ret

80001538 <sfence_vma>:
static inline void sfence_vma(){
80001538:	ff010113          	addi	sp,sp,-16
8000153c:	00812623          	sw	s0,12(sp)
80001540:	01010413          	addi	s0,sp,16
    asm volatile("sfence.vma zero,zero");
80001544:	12000073          	sfence.vma
}
80001548:	00000013          	nop
8000154c:	00c12403          	lw	s0,12(sp)
80001550:	01010113          	addi	sp,sp,16
80001554:	00008067          	ret

80001558 <acquriepte>:
/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
80001558:	fd010113          	addi	sp,sp,-48
8000155c:	02112623          	sw	ra,44(sp)
80001560:	02812423          	sw	s0,40(sp)
80001564:	03010413          	addi	s0,sp,48
80001568:	fca42e23          	sw	a0,-36(s0)
8000156c:	fcb42c23          	sw	a1,-40(s0)
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
80001570:	fd842783          	lw	a5,-40(s0)
80001574:	0167d793          	srli	a5,a5,0x16
80001578:	00279793          	slli	a5,a5,0x2
8000157c:	fdc42703          	lw	a4,-36(s0)
80001580:	00f707b3          	add	a5,a4,a5
80001584:	fef42623          	sw	a5,-20(s0)
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
80001588:	fec42783          	lw	a5,-20(s0)
8000158c:	0007a783          	lw	a5,0(a5)
80001590:	0017f793          	andi	a5,a5,1
80001594:	00078e63          	beqz	a5,800015b0 <acquriepte+0x58>
        pgt=(addr_t*)PTE2PA(*pte);
80001598:	fec42783          	lw	a5,-20(s0)
8000159c:	0007a783          	lw	a5,0(a5)
800015a0:	00a7d793          	srli	a5,a5,0xa
800015a4:	00c79793          	slli	a5,a5,0xc
800015a8:	fcf42e23          	sw	a5,-36(s0)
800015ac:	0340006f          	j	800015e0 <acquriepte+0x88>
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
800015b0:	cedff0ef          	jal	ra,8000129c <palloc>
800015b4:	fca42e23          	sw	a0,-36(s0)
        memset(pgt,0,PGSIZE);
800015b8:	00001637          	lui	a2,0x1
800015bc:	00000593          	li	a1,0
800015c0:	fdc42503          	lw	a0,-36(s0)
800015c4:	784000ef          	jal	ra,80001d48 <memset>
        *pte = PA2PTE(pgt) | PTE_V;
800015c8:	fdc42783          	lw	a5,-36(s0)
800015cc:	00c7d793          	srli	a5,a5,0xc
800015d0:	00a79793          	slli	a5,a5,0xa
800015d4:	0017e713          	ori	a4,a5,1
800015d8:	fec42783          	lw	a5,-20(s0)
800015dc:	00e7a023          	sw	a4,0(a5)
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
800015e0:	fd842783          	lw	a5,-40(s0)
800015e4:	00c7d793          	srli	a5,a5,0xc
800015e8:	3ff7f793          	andi	a5,a5,1023
800015ec:	00279793          	slli	a5,a5,0x2
800015f0:	fdc42703          	lw	a4,-36(s0)
800015f4:	00f707b3          	add	a5,a4,a5
}
800015f8:	00078513          	mv	a0,a5
800015fc:	02c12083          	lw	ra,44(sp)
80001600:	02812403          	lw	s0,40(sp)
80001604:	03010113          	addi	sp,sp,48
80001608:	00008067          	ret

8000160c <vmmap>:
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
8000160c:	fc010113          	addi	sp,sp,-64
80001610:	02112e23          	sw	ra,60(sp)
80001614:	02812c23          	sw	s0,56(sp)
80001618:	04010413          	addi	s0,sp,64
8000161c:	fca42e23          	sw	a0,-36(s0)
80001620:	fcb42c23          	sw	a1,-40(s0)
80001624:	fcc42a23          	sw	a2,-44(s0)
80001628:	fcd42823          	sw	a3,-48(s0)
8000162c:	fce42623          	sw	a4,-52(s0)
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
80001630:	fd842703          	lw	a4,-40(s0)
80001634:	fffff7b7          	lui	a5,0xfffff
80001638:	00f777b3          	and	a5,a4,a5
8000163c:	fef42623          	sw	a5,-20(s0)
    addr_t end =(((va + (size - 1)) >>12)<<12);
80001640:	fd042703          	lw	a4,-48(s0)
80001644:	fd842783          	lw	a5,-40(s0)
80001648:	00f707b3          	add	a5,a4,a5
8000164c:	fff78713          	addi	a4,a5,-1 # ffffefff <memend+0x77ffefff>
80001650:	fffff7b7          	lui	a5,0xfffff
80001654:	00f777b3          	and	a5,a4,a5
80001658:	fef42423          	sw	a5,-24(s0)

    while(1){
        pte=acquriepte(pgt,start);
8000165c:	fec42583          	lw	a1,-20(s0)
80001660:	fdc42503          	lw	a0,-36(s0)
80001664:	ef5ff0ef          	jal	ra,80001558 <acquriepte>
80001668:	fea42223          	sw	a0,-28(s0)
        if(*pte & PTE_V)
8000166c:	fe442783          	lw	a5,-28(s0)
80001670:	0007a783          	lw	a5,0(a5) # fffff000 <memend+0x77fff000>
80001674:	0017f793          	andi	a5,a5,1
80001678:	00078863          	beqz	a5,80001688 <vmmap+0x7c>
            panic("repeat map");
8000167c:	800037b7          	lui	a5,0x80003
80001680:	35478513          	addi	a0,a5,852 # 80003354 <memend+0xf8003354>
80001684:	f58ff0ef          	jal	ra,80000ddc <panic>
        *pte = PA2PTE(pa) | mode | PTE_V ;
80001688:	fd442783          	lw	a5,-44(s0)
8000168c:	00c7d793          	srli	a5,a5,0xc
80001690:	00a79713          	slli	a4,a5,0xa
80001694:	fcc42783          	lw	a5,-52(s0)
80001698:	00f767b3          	or	a5,a4,a5
8000169c:	0017e713          	ori	a4,a5,1
800016a0:	fe442783          	lw	a5,-28(s0)
800016a4:	00e7a023          	sw	a4,0(a5)
        if(start==end)  break;
800016a8:	fec42703          	lw	a4,-20(s0)
800016ac:	fe842783          	lw	a5,-24(s0)
800016b0:	02f70463          	beq	a4,a5,800016d8 <vmmap+0xcc>
        start += PGSIZE;
800016b4:	fec42703          	lw	a4,-20(s0)
800016b8:	000017b7          	lui	a5,0x1
800016bc:	00f707b3          	add	a5,a4,a5
800016c0:	fef42623          	sw	a5,-20(s0)
        pa += PGSIZE;
800016c4:	fd442703          	lw	a4,-44(s0)
800016c8:	000017b7          	lui	a5,0x1
800016cc:	00f707b3          	add	a5,a4,a5
800016d0:	fcf42a23          	sw	a5,-44(s0)
        pte=acquriepte(pgt,start);
800016d4:	f89ff06f          	j	8000165c <vmmap+0x50>
        if(start==end)  break;
800016d8:	00000013          	nop
    }
}
800016dc:	00000013          	nop
800016e0:	03c12083          	lw	ra,60(sp)
800016e4:	03812403          	lw	s0,56(sp)
800016e8:	04010113          	addi	sp,sp,64
800016ec:	00008067          	ret

800016f0 <printpgt>:

void printpgt(addr_t* pgt){
800016f0:	fc010113          	addi	sp,sp,-64
800016f4:	02112e23          	sw	ra,60(sp)
800016f8:	02812c23          	sw	s0,56(sp)
800016fc:	04010413          	addi	s0,sp,64
80001700:	fca42623          	sw	a0,-52(s0)
    for(int i=0;i<1024;i++){
80001704:	fe042623          	sw	zero,-20(s0)
80001708:	0c40006f          	j	800017cc <printpgt+0xdc>
        pte_t pte=pgt[i];
8000170c:	fec42783          	lw	a5,-20(s0)
80001710:	00279793          	slli	a5,a5,0x2
80001714:	fcc42703          	lw	a4,-52(s0)
80001718:	00f707b3          	add	a5,a4,a5
8000171c:	0007a783          	lw	a5,0(a5) # 1000 <sz>
80001720:	fef42223          	sw	a5,-28(s0)
        if(pte & PTE_V){
80001724:	fe442783          	lw	a5,-28(s0)
80001728:	0017f793          	andi	a5,a5,1
8000172c:	08078a63          	beqz	a5,800017c0 <printpgt+0xd0>
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
80001730:	fe442783          	lw	a5,-28(s0)
80001734:	00a7d793          	srli	a5,a5,0xa
80001738:	00c79793          	slli	a5,a5,0xc
8000173c:	fef42023          	sw	a5,-32(s0)
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
80001740:	fe042683          	lw	a3,-32(s0)
80001744:	fe442603          	lw	a2,-28(s0)
80001748:	fec42583          	lw	a1,-20(s0)
8000174c:	800037b7          	lui	a5,0x80003
80001750:	36078513          	addi	a0,a5,864 # 80003360 <memend+0xf8003360>
80001754:	ec0ff0ef          	jal	ra,80000e14 <printf>
            for(int j=0;j<1024;j++){
80001758:	fe042423          	sw	zero,-24(s0)
8000175c:	0580006f          	j	800017b4 <printpgt+0xc4>
                pte_t pte2=pgt2[j];
80001760:	fe842783          	lw	a5,-24(s0)
80001764:	00279793          	slli	a5,a5,0x2
80001768:	fe042703          	lw	a4,-32(s0)
8000176c:	00f707b3          	add	a5,a4,a5
80001770:	0007a783          	lw	a5,0(a5)
80001774:	fcf42e23          	sw	a5,-36(s0)
                if(pte2 & PTE_V){
80001778:	fdc42783          	lw	a5,-36(s0)
8000177c:	0017f793          	andi	a5,a5,1
80001780:	02078463          	beqz	a5,800017a8 <printpgt+0xb8>
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
80001784:	fdc42783          	lw	a5,-36(s0)
80001788:	00a7d793          	srli	a5,a5,0xa
8000178c:	00c79793          	slli	a5,a5,0xc
80001790:	00078693          	mv	a3,a5
80001794:	fdc42603          	lw	a2,-36(s0)
80001798:	fe842583          	lw	a1,-24(s0)
8000179c:	800037b7          	lui	a5,0x80003
800017a0:	37878513          	addi	a0,a5,888 # 80003378 <memend+0xf8003378>
800017a4:	e70ff0ef          	jal	ra,80000e14 <printf>
            for(int j=0;j<1024;j++){
800017a8:	fe842783          	lw	a5,-24(s0)
800017ac:	00178793          	addi	a5,a5,1
800017b0:	fef42423          	sw	a5,-24(s0)
800017b4:	fe842703          	lw	a4,-24(s0)
800017b8:	3ff00793          	li	a5,1023
800017bc:	fae7d2e3          	bge	a5,a4,80001760 <printpgt+0x70>
    for(int i=0;i<1024;i++){
800017c0:	fec42783          	lw	a5,-20(s0)
800017c4:	00178793          	addi	a5,a5,1
800017c8:	fef42623          	sw	a5,-20(s0)
800017cc:	fec42703          	lw	a4,-20(s0)
800017d0:	3ff00793          	li	a5,1023
800017d4:	f2e7dce3          	bge	a5,a4,8000170c <printpgt+0x1c>
                }
            }
        }
    }
}
800017d8:	00000013          	nop
800017dc:	00000013          	nop
800017e0:	03c12083          	lw	ra,60(sp)
800017e4:	03812403          	lw	s0,56(sp)
800017e8:	04010113          	addi	sp,sp,64
800017ec:	00008067          	ret

800017f0 <mkstack>:

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
800017f0:	fd010113          	addi	sp,sp,-48
800017f4:	02112623          	sw	ra,44(sp)
800017f8:	02812423          	sw	s0,40(sp)
800017fc:	03010413          	addi	s0,sp,48
80001800:	fca42e23          	sw	a0,-36(s0)
    for(int i=0;i<NPROC;i++){
80001804:	fe042623          	sw	zero,-20(s0)
80001808:	04c0006f          	j	80001854 <mkstack+0x64>
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
8000180c:	fec42783          	lw	a5,-20(s0)
80001810:	00d79793          	slli	a5,a5,0xd
80001814:	00078713          	mv	a4,a5
80001818:	c00017b7          	lui	a5,0xc0001
8000181c:	00f707b3          	add	a5,a4,a5
80001820:	fef42423          	sw	a5,-24(s0)
        addr_t pa=(addr_t)palloc();
80001824:	a79ff0ef          	jal	ra,8000129c <palloc>
80001828:	00050793          	mv	a5,a0
8000182c:	fef42223          	sw	a5,-28(s0)
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
80001830:	00600713          	li	a4,6
80001834:	000016b7          	lui	a3,0x1
80001838:	fe442603          	lw	a2,-28(s0)
8000183c:	fe842583          	lw	a1,-24(s0)
80001840:	fdc42503          	lw	a0,-36(s0)
80001844:	dc9ff0ef          	jal	ra,8000160c <vmmap>
    for(int i=0;i<NPROC;i++){
80001848:	fec42783          	lw	a5,-20(s0)
8000184c:	00178793          	addi	a5,a5,1 # c0001001 <memend+0x38001001>
80001850:	fef42623          	sw	a5,-20(s0)
80001854:	fec42703          	lw	a4,-20(s0)
80001858:	00300793          	li	a5,3
8000185c:	fae7d8e3          	bge	a5,a4,8000180c <mkstack+0x1c>
    }
}
80001860:	00000013          	nop
80001864:	00000013          	nop
80001868:	02c12083          	lw	ra,44(sp)
8000186c:	02812403          	lw	s0,40(sp)
80001870:	03010113          	addi	sp,sp,48
80001874:	00008067          	ret

80001878 <kvminit>:

// 初始化虚拟内存
void kvminit(){
80001878:	ff010113          	addi	sp,sp,-16
8000187c:	00112623          	sw	ra,12(sp)
80001880:	00812423          	sw	s0,8(sp)
80001884:	01010413          	addi	s0,sp,16
    kpgt=(addr_t*)palloc();
80001888:	a15ff0ef          	jal	ra,8000129c <palloc>
8000188c:	00050713          	mv	a4,a0
80001890:	8000e7b7          	lui	a5,0x8000e
80001894:	8ae7a423          	sw	a4,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
    memset(kpgt,0,PGSIZE);
80001898:	8000e7b7          	lui	a5,0x8000e
8000189c:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018a0:	00001637          	lui	a2,0x1
800018a4:	00000593          	li	a1,0
800018a8:	00078513          	mv	a0,a5
800018ac:	49c000ef          	jal	ra,80001d48 <memset>

    // 映射 CLINT
    vmmap(kpgt,CLINT_BASE,CLINT_BASE,0xc000,PTE_R|PTE_W);
800018b0:	8000e7b7          	lui	a5,0x8000e
800018b4:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018b8:	00600713          	li	a4,6
800018bc:	0000c6b7          	lui	a3,0xc
800018c0:	02000637          	lui	a2,0x2000
800018c4:	020005b7          	lui	a1,0x2000
800018c8:	00078513          	mv	a0,a5
800018cc:	d41ff0ef          	jal	ra,8000160c <vmmap>

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);
800018d0:	8000e7b7          	lui	a5,0x8000e
800018d4:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018d8:	00600713          	li	a4,6
800018dc:	004006b7          	lui	a3,0x400
800018e0:	0c000637          	lui	a2,0xc000
800018e4:	0c0005b7          	lui	a1,0xc000
800018e8:	00078513          	mv	a0,a5
800018ec:	d21ff0ef          	jal	ra,8000160c <vmmap>

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
800018f0:	8000e7b7          	lui	a5,0x8000e
800018f4:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800018f8:	00600713          	li	a4,6
800018fc:	000016b7          	lui	a3,0x1
80001900:	10000637          	lui	a2,0x10000
80001904:	100005b7          	lui	a1,0x10000
80001908:	00078513          	mv	a0,a5
8000190c:	d01ff0ef          	jal	ra,8000160c <vmmap>
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
80001910:	8000e7b7          	lui	a5,0x8000e
80001914:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001918:	800007b7          	lui	a5,0x80000
8000191c:	00078593          	mv	a1,a5
80001920:	800007b7          	lui	a5,0x80000
80001924:	00078613          	mv	a2,a5
80001928:	800027b7          	lui	a5,0x80002
8000192c:	3b078713          	addi	a4,a5,944 # 800023b0 <memend+0xf80023b0>
80001930:	800007b7          	lui	a5,0x80000
80001934:	00078793          	mv	a5,a5
80001938:	40f707b3          	sub	a5,a4,a5
8000193c:	00a00713          	li	a4,10
80001940:	00078693          	mv	a3,a5
80001944:	cc9ff0ef          	jal	ra,8000160c <vmmap>
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
80001948:	8000e7b7          	lui	a5,0x8000e
8000194c:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001950:	800037b7          	lui	a5,0x80003
80001954:	00078593          	mv	a1,a5
80001958:	800037b7          	lui	a5,0x80003
8000195c:	00078613          	mv	a2,a5
80001960:	800037b7          	lui	a5,0x80003
80001964:	38f78713          	addi	a4,a5,911 # 8000338f <memend+0xf800338f>
80001968:	800037b7          	lui	a5,0x80003
8000196c:	00078793          	mv	a5,a5
80001970:	40f707b3          	sub	a5,a4,a5
80001974:	00200713          	li	a4,2
80001978:	00078693          	mv	a3,a5
8000197c:	c91ff0ef          	jal	ra,8000160c <vmmap>
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
80001980:	8000e7b7          	lui	a5,0x8000e
80001984:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001988:	800047b7          	lui	a5,0x80004
8000198c:	00078593          	mv	a1,a5
80001990:	800047b7          	lui	a5,0x80004
80001994:	00078613          	mv	a2,a5
80001998:	8000c7b7          	lui	a5,0x8000c
8000199c:	00478713          	addi	a4,a5,4 # 8000c004 <memend+0xf800c004>
800019a0:	800047b7          	lui	a5,0x80004
800019a4:	00078793          	mv	a5,a5
800019a8:	40f707b3          	sub	a5,a4,a5
800019ac:	00600713          	li	a4,6
800019b0:	00078693          	mv	a3,a5
800019b4:	c59ff0ef          	jal	ra,8000160c <vmmap>
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
800019b8:	8000e7b7          	lui	a5,0x8000e
800019bc:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019c0:	8000d7b7          	lui	a5,0x8000d
800019c4:	00078593          	mv	a1,a5
800019c8:	8000d7b7          	lui	a5,0x8000d
800019cc:	00078613          	mv	a2,a5
800019d0:	8000e7b7          	lui	a5,0x8000e
800019d4:	9f078713          	addi	a4,a5,-1552 # 8000d9f0 <memend+0xf800d9f0>
800019d8:	8000d7b7          	lui	a5,0x8000d
800019dc:	00078793          	mv	a5,a5
800019e0:	40f707b3          	sub	a5,a4,a5
800019e4:	00600713          	li	a4,6
800019e8:	00078693          	mv	a3,a5
800019ec:	c21ff0ef          	jal	ra,8000160c <vmmap>
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);
800019f0:	8000e7b7          	lui	a5,0x8000e
800019f4:	8a87a503          	lw	a0,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
800019f8:	8000e7b7          	lui	a5,0x8000e
800019fc:	00078593          	mv	a1,a5
80001a00:	8000e7b7          	lui	a5,0x8000e
80001a04:	00078613          	mv	a2,a5
80001a08:	880007b7          	lui	a5,0x88000
80001a0c:	00078713          	mv	a4,a5
80001a10:	8000e7b7          	lui	a5,0x8000e
80001a14:	00078793          	mv	a5,a5
80001a18:	40f707b3          	sub	a5,a4,a5
80001a1c:	00600713          	li	a4,6
80001a20:	00078693          	mv	a3,a5
80001a24:	be9ff0ef          	jal	ra,8000160c <vmmap>

    mkstack(kpgt);
80001a28:	8000e7b7          	lui	a5,0x8000e
80001a2c:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001a30:	00078513          	mv	a0,a5
80001a34:	dbdff0ef          	jal	ra,800017f0 <mkstack>

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
80001a38:	8000e7b7          	lui	a5,0x8000e
80001a3c:	8a87a783          	lw	a5,-1880(a5) # 8000d8a8 <memend+0xf800d8a8>
80001a40:	00c7d713          	srli	a4,a5,0xc
80001a44:	800007b7          	lui	a5,0x80000
80001a48:	00f767b3          	or	a5,a4,a5
80001a4c:	00078513          	mv	a0,a5
80001a50:	ac1ff0ef          	jal	ra,80001510 <w_satp>
    sfence_vma();       // 刷新页表
80001a54:	ae5ff0ef          	jal	ra,80001538 <sfence_vma>
}
80001a58:	00000013          	nop
80001a5c:	00c12083          	lw	ra,12(sp)
80001a60:	00812403          	lw	s0,8(sp)
80001a64:	01010113          	addi	sp,sp,16
80001a68:	00008067          	ret

80001a6c <pgtcreate>:

addr_t* pgtcreate(){
80001a6c:	fe010113          	addi	sp,sp,-32
80001a70:	00112e23          	sw	ra,28(sp)
80001a74:	00812c23          	sw	s0,24(sp)
80001a78:	02010413          	addi	s0,sp,32
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();
80001a7c:	821ff0ef          	jal	ra,8000129c <palloc>
80001a80:	fea42623          	sw	a0,-20(s0)

    return pgt;
80001a84:	fec42783          	lw	a5,-20(s0)
}
80001a88:	00078513          	mv	a0,a5
80001a8c:	01c12083          	lw	ra,28(sp)
80001a90:	01812403          	lw	s0,24(sp)
80001a94:	02010113          	addi	sp,sp,32
80001a98:	00008067          	ret

80001a9c <r_tp>:
static inline uint32 r_tp(){
80001a9c:	fe010113          	addi	sp,sp,-32
80001aa0:	00812e23          	sw	s0,28(sp)
80001aa4:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001aa8:	00020793          	mv	a5,tp
80001aac:	fef42623          	sw	a5,-20(s0)
    return x;
80001ab0:	fec42783          	lw	a5,-20(s0)
}
80001ab4:	00078513          	mv	a0,a5
80001ab8:	01c12403          	lw	s0,28(sp)
80001abc:	02010113          	addi	sp,sp,32
80001ac0:	00008067          	ret

80001ac4 <procinit>:
#include "defs.h"
#include "riscv.h"

uint nextpid=0;

void procinit(){
80001ac4:	fe010113          	addi	sp,sp,-32
80001ac8:	00812e23          	sw	s0,28(sp)
80001acc:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
80001ad0:	fe042623          	sw	zero,-20(s0)
80001ad4:	0480006f          	j	80001b1c <procinit+0x58>
        p=&proc[i];
80001ad8:	fec42703          	lw	a4,-20(s0)
80001adc:	11800793          	li	a5,280
80001ae0:	02f70733          	mul	a4,a4,a5
80001ae4:	8000d7b7          	lui	a5,0x8000d
80001ae8:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001aec:	00f707b3          	add	a5,a4,a5
80001af0:	fef42423          	sw	a5,-24(s0)
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
80001af4:	fec42783          	lw	a5,-20(s0)
80001af8:	00d79793          	slli	a5,a5,0xd
80001afc:	00078713          	mv	a4,a5
80001b00:	c00027b7          	lui	a5,0xc0002
80001b04:	00f70733          	add	a4,a4,a5
80001b08:	fe842783          	lw	a5,-24(s0)
80001b0c:	10e7aa23          	sw	a4,276(a5) # c0002114 <memend+0x38002114>
    for(int i=0;i<NPROC;i++){
80001b10:	fec42783          	lw	a5,-20(s0)
80001b14:	00178793          	addi	a5,a5,1
80001b18:	fef42623          	sw	a5,-20(s0)
80001b1c:	fec42703          	lw	a4,-20(s0)
80001b20:	00300793          	li	a5,3
80001b24:	fae7dae3          	bge	a5,a4,80001ad8 <procinit+0x14>
    }
}
80001b28:	00000013          	nop
80001b2c:	00000013          	nop
80001b30:	01c12403          	lw	s0,28(sp)
80001b34:	02010113          	addi	sp,sp,32
80001b38:	00008067          	ret

80001b3c <nowproc>:

struct pcb* nowproc(){
80001b3c:	fe010113          	addi	sp,sp,-32
80001b40:	00112e23          	sw	ra,28(sp)
80001b44:	00812c23          	sw	s0,24(sp)
80001b48:	02010413          	addi	s0,sp,32
    int hart=r_tp();
80001b4c:	f51ff0ef          	jal	ra,80001a9c <r_tp>
80001b50:	00050793          	mv	a5,a0
80001b54:	fef42623          	sw	a5,-20(s0)
    return cpu[hart].proc;
80001b58:	8000e7b7          	lui	a5,0x8000e
80001b5c:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001b60:	fec42783          	lw	a5,-20(s0)
80001b64:	00379793          	slli	a5,a5,0x3
80001b68:	00f707b3          	add	a5,a4,a5
80001b6c:	0007a783          	lw	a5,0(a5)
}
80001b70:	00078513          	mv	a0,a5
80001b74:	01c12083          	lw	ra,28(sp)
80001b78:	01812403          	lw	s0,24(sp)
80001b7c:	02010113          	addi	sp,sp,32
80001b80:	00008067          	ret

80001b84 <pidalloc>:

uint pidalloc(){
80001b84:	ff010113          	addi	sp,sp,-16
80001b88:	00812623          	sw	s0,12(sp)
80001b8c:	01010413          	addi	s0,sp,16
    return nextpid++;
80001b90:	8000d7b7          	lui	a5,0x8000d
80001b94:	0007a783          	lw	a5,0(a5) # 8000d000 <memend+0xf800d000>
80001b98:	00178693          	addi	a3,a5,1
80001b9c:	8000d737          	lui	a4,0x8000d
80001ba0:	00d72023          	sw	a3,0(a4) # 8000d000 <memend+0xf800d000>
} 
80001ba4:	00078513          	mv	a0,a5
80001ba8:	00c12403          	lw	s0,12(sp)
80001bac:	01010113          	addi	sp,sp,16
80001bb0:	00008067          	ret

80001bb4 <procalloc>:

struct pcb* procalloc(){
80001bb4:	fe010113          	addi	sp,sp,-32
80001bb8:	00112e23          	sw	ra,28(sp)
80001bbc:	00812c23          	sw	s0,24(sp)
80001bc0:	02010413          	addi	s0,sp,32
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
80001bc4:	8000d7b7          	lui	a5,0x8000d
80001bc8:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001bcc:	fef42623          	sw	a5,-20(s0)
80001bd0:	0680006f          	j	80001c38 <procalloc+0x84>
        if(p->status==UNUSED){
80001bd4:	fec42783          	lw	a5,-20(s0)
80001bd8:	0047a783          	lw	a5,4(a5)
80001bdc:	04079863          	bnez	a5,80001c2c <procalloc+0x78>
            p->pid=pidalloc();
80001be0:	fa5ff0ef          	jal	ra,80001b84 <pidalloc>
80001be4:	00050793          	mv	a5,a0
80001be8:	00078713          	mv	a4,a5
80001bec:	fec42783          	lw	a5,-20(s0)
80001bf0:	00e7a023          	sw	a4,0(a5)
            p->status=USED;
80001bf4:	fec42783          	lw	a5,-20(s0)
80001bf8:	00100713          	li	a4,1
80001bfc:	00e7a223          	sw	a4,4(a5)

            p->pagetable=pgtcreate();
80001c00:	e6dff0ef          	jal	ra,80001a6c <pgtcreate>
80001c04:	00050713          	mv	a4,a0
80001c08:	fec42783          	lw	a5,-20(s0)
80001c0c:	10e7a823          	sw	a4,272(a5)
            
            p->trapframe.epc=0;
80001c10:	fec42783          	lw	a5,-20(s0)
80001c14:	0007aa23          	sw	zero,20(a5)
            p->trapframe.sp=KSPACE;
80001c18:	fec42783          	lw	a5,-20(s0)
80001c1c:	c0000737          	lui	a4,0xc0000
80001c20:	00e7ae23          	sw	a4,28(a5)

            return p;
80001c24:	fec42783          	lw	a5,-20(s0)
80001c28:	0240006f          	j	80001c4c <procalloc+0x98>
    for(p=proc;p<&proc[NPROC];p++){
80001c2c:	fec42783          	lw	a5,-20(s0)
80001c30:	11878793          	addi	a5,a5,280
80001c34:	fef42623          	sw	a5,-20(s0)
80001c38:	fec42703          	lw	a4,-20(s0)
80001c3c:	8000e7b7          	lui	a5,0x8000e
80001c40:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001c44:	f8f768e3          	bltu	a4,a5,80001bd4 <procalloc+0x20>
        }
    }
    return 0;
80001c48:	00000793          	li	a5,0
}
80001c4c:	00078513          	mv	a0,a5
80001c50:	01c12083          	lw	ra,28(sp)
80001c54:	01812403          	lw	s0,24(sp)
80001c58:	02010113          	addi	sp,sp,32
80001c5c:	00008067          	ret

80001c60 <userinit>:

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
80001c60:	fe010113          	addi	sp,sp,-32
80001c64:	00112e23          	sw	ra,28(sp)
80001c68:	00812c23          	sw	s0,24(sp)
80001c6c:	02010413          	addi	s0,sp,32
    struct pcb* p=procalloc();
80001c70:	f45ff0ef          	jal	ra,80001bb4 <procalloc>
80001c74:	fea42623          	sw	a0,-20(s0)
    
    char* m=(char*)palloc();
80001c78:	e24ff0ef          	jal	ra,8000129c <palloc>
80001c7c:	fea42423          	sw	a0,-24(s0)
    memmove(m,zeroproc,sizeof(zeroproc));
80001c80:	00400613          	li	a2,4
80001c84:	00000693          	li	a3,0
80001c88:	800047b7          	lui	a5,0x80004
80001c8c:	00078593          	mv	a1,a5
80001c90:	fe842503          	lw	a0,-24(s0)
80001c94:	120000ef          	jal	ra,80001db4 <memmove>

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X);
80001c98:	fec42783          	lw	a5,-20(s0)
80001c9c:	1107a783          	lw	a5,272(a5) # 80004110 <memend+0xf8004110>
80001ca0:	fe842603          	lw	a2,-24(s0)
80001ca4:	00e00713          	li	a4,14
80001ca8:	000016b7          	lui	a3,0x1
80001cac:	00000593          	li	a1,0
80001cb0:	00078513          	mv	a0,a5
80001cb4:	959ff0ef          	jal	ra,8000160c <vmmap>

    p->context.sp=KSPACE;
80001cb8:	fec42783          	lw	a5,-20(s0)
80001cbc:	c0000737          	lui	a4,0xc0000
80001cc0:	08e7ac23          	sw	a4,152(a5)

    p->status=RUNABLE;
80001cc4:	fec42783          	lw	a5,-20(s0)
80001cc8:	00200713          	li	a4,2
80001ccc:	00e7a223          	sw	a4,4(a5)

    int id=r_tp();
80001cd0:	dcdff0ef          	jal	ra,80001a9c <r_tp>
80001cd4:	00050793          	mv	a5,a0
80001cd8:	fef42223          	sw	a5,-28(s0)
    cpu[id].proc=p;
80001cdc:	8000e7b7          	lui	a5,0x8000e
80001ce0:	86478713          	addi	a4,a5,-1948 # 8000d864 <memend+0xf800d864>
80001ce4:	fe442783          	lw	a5,-28(s0)
80001ce8:	00379793          	slli	a5,a5,0x3
80001cec:	00f707b3          	add	a5,a4,a5
80001cf0:	fec42703          	lw	a4,-20(s0)
80001cf4:	00e7a023          	sw	a4,0(a5)
}
80001cf8:	00000013          	nop
80001cfc:	01c12083          	lw	ra,28(sp)
80001d00:	01812403          	lw	s0,24(sp)
80001d04:	02010113          	addi	sp,sp,32
80001d08:	00008067          	ret

80001d0c <schedule>:

void schedule(){
80001d0c:	fe010113          	addi	sp,sp,-32
80001d10:	00812e23          	sw	s0,28(sp)
80001d14:	02010413          	addi	s0,sp,32
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
80001d18:	8000d7b7          	lui	a5,0x8000d
80001d1c:	40478793          	addi	a5,a5,1028 # 8000d404 <memend+0xf800d404>
80001d20:	fef42623          	sw	a5,-20(s0)
80001d24:	0100006f          	j	80001d34 <schedule+0x28>
80001d28:	fec42783          	lw	a5,-20(s0)
80001d2c:	11878793          	addi	a5,a5,280
80001d30:	fef42623          	sw	a5,-20(s0)
80001d34:	fec42703          	lw	a4,-20(s0)
80001d38:	8000e7b7          	lui	a5,0x8000e
80001d3c:	86478793          	addi	a5,a5,-1948 # 8000d864 <memend+0xf800d864>
80001d40:	fef764e3          	bltu	a4,a5,80001d28 <schedule+0x1c>
    for(;;){
80001d44:	fd5ff06f          	j	80001d18 <schedule+0xc>

80001d48 <memset>:
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
80001d48:	fd010113          	addi	sp,sp,-48
80001d4c:	02812623          	sw	s0,44(sp)
80001d50:	03010413          	addi	s0,sp,48
80001d54:	fca42e23          	sw	a0,-36(s0)
80001d58:	fcb42c23          	sw	a1,-40(s0)
80001d5c:	fcc42a23          	sw	a2,-44(s0)
    char* maddr = (char*)addr;
80001d60:	fdc42783          	lw	a5,-36(s0)
80001d64:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
80001d68:	fe042623          	sw	zero,-20(s0)
80001d6c:	0280006f          	j	80001d94 <memset+0x4c>
        maddr[i] = (char)c;
80001d70:	fe842703          	lw	a4,-24(s0)
80001d74:	fec42783          	lw	a5,-20(s0)
80001d78:	00f707b3          	add	a5,a4,a5
80001d7c:	fd842703          	lw	a4,-40(s0)
80001d80:	0ff77713          	andi	a4,a4,255
80001d84:	00e78023          	sb	a4,0(a5)
    for(uint i=0;i<n;i++){
80001d88:	fec42783          	lw	a5,-20(s0)
80001d8c:	00178793          	addi	a5,a5,1
80001d90:	fef42623          	sw	a5,-20(s0)
80001d94:	fec42703          	lw	a4,-20(s0)
80001d98:	fd442783          	lw	a5,-44(s0)
80001d9c:	fcf76ae3          	bltu	a4,a5,80001d70 <memset+0x28>
    }
    return addr;
80001da0:	fdc42783          	lw	a5,-36(s0)
}
80001da4:	00078513          	mv	a0,a5
80001da8:	02c12403          	lw	s0,44(sp)
80001dac:	03010113          	addi	sp,sp,48
80001db0:	00008067          	ret

80001db4 <memmove>:

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
80001db4:	fd010113          	addi	sp,sp,-48
80001db8:	02812623          	sw	s0,44(sp)
80001dbc:	03010413          	addi	s0,sp,48
80001dc0:	fca42e23          	sw	a0,-36(s0)
80001dc4:	fcb42c23          	sw	a1,-40(s0)
80001dc8:	fcc42823          	sw	a2,-48(s0)
80001dcc:	fcd42a23          	sw	a3,-44(s0)
    const char* s;
    char* d;
    if(n==0){
80001dd0:	fd042783          	lw	a5,-48(s0)
80001dd4:	fd442703          	lw	a4,-44(s0)
80001dd8:	00e7e7b3          	or	a5,a5,a4
80001ddc:	00079663          	bnez	a5,80001de8 <memmove+0x34>
        return dst;
80001de0:	fdc42783          	lw	a5,-36(s0)
80001de4:	1200006f          	j	80001f04 <memmove+0x150>
    }

    s = src;
80001de8:	fd842783          	lw	a5,-40(s0)
80001dec:	fef42623          	sw	a5,-20(s0)
    d = dst;
80001df0:	fdc42783          	lw	a5,-36(s0)
80001df4:	fef42423          	sw	a5,-24(s0)
    if(s < d && s + n > d){     
80001df8:	fec42703          	lw	a4,-20(s0)
80001dfc:	fe842783          	lw	a5,-24(s0)
80001e00:	0cf77263          	bgeu	a4,a5,80001ec4 <memmove+0x110>
80001e04:	fd042783          	lw	a5,-48(s0)
80001e08:	fec42703          	lw	a4,-20(s0)
80001e0c:	00f707b3          	add	a5,a4,a5
80001e10:	fe842703          	lw	a4,-24(s0)
80001e14:	0af77863          	bgeu	a4,a5,80001ec4 <memmove+0x110>
        // 有重叠区域,从后往前复制
        s += n;
80001e18:	fd042783          	lw	a5,-48(s0)
80001e1c:	fec42703          	lw	a4,-20(s0)
80001e20:	00f707b3          	add	a5,a4,a5
80001e24:	fef42623          	sw	a5,-20(s0)
        d += n;
80001e28:	fd042783          	lw	a5,-48(s0)
80001e2c:	fe842703          	lw	a4,-24(s0)
80001e30:	00f707b3          	add	a5,a4,a5
80001e34:	fef42423          	sw	a5,-24(s0)
        while(n-- > 0){
80001e38:	02c0006f          	j	80001e64 <memmove+0xb0>
            *--d = *--s;
80001e3c:	fec42783          	lw	a5,-20(s0)
80001e40:	fff78793          	addi	a5,a5,-1
80001e44:	fef42623          	sw	a5,-20(s0)
80001e48:	fe842783          	lw	a5,-24(s0)
80001e4c:	fff78793          	addi	a5,a5,-1
80001e50:	fef42423          	sw	a5,-24(s0)
80001e54:	fec42783          	lw	a5,-20(s0)
80001e58:	0007c703          	lbu	a4,0(a5)
80001e5c:	fe842783          	lw	a5,-24(s0)
80001e60:	00e78023          	sb	a4,0(a5)
        while(n-- > 0){
80001e64:	fd042703          	lw	a4,-48(s0)
80001e68:	fd442783          	lw	a5,-44(s0)
80001e6c:	fff00513          	li	a0,-1
80001e70:	fff00593          	li	a1,-1
80001e74:	00a70633          	add	a2,a4,a0
80001e78:	00060813          	mv	a6,a2
80001e7c:	00e83833          	sltu	a6,a6,a4
80001e80:	00b786b3          	add	a3,a5,a1
80001e84:	00d805b3          	add	a1,a6,a3
80001e88:	00058693          	mv	a3,a1
80001e8c:	fcc42823          	sw	a2,-48(s0)
80001e90:	fcd42a23          	sw	a3,-44(s0)
80001e94:	00070693          	mv	a3,a4
80001e98:	00f6e6b3          	or	a3,a3,a5
80001e9c:	fa0690e3          	bnez	a3,80001e3c <memmove+0x88>
    if(s < d && s + n > d){     
80001ea0:	0600006f          	j	80001f00 <memmove+0x14c>
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
80001ea4:	fec42703          	lw	a4,-20(s0)
80001ea8:	00170793          	addi	a5,a4,1 # c0000001 <memend+0x38000001>
80001eac:	fef42623          	sw	a5,-20(s0)
80001eb0:	fe842783          	lw	a5,-24(s0)
80001eb4:	00178693          	addi	a3,a5,1
80001eb8:	fed42423          	sw	a3,-24(s0)
80001ebc:	00074703          	lbu	a4,0(a4)
80001ec0:	00e78023          	sb	a4,0(a5)
        while(n-- >0){
80001ec4:	fd042703          	lw	a4,-48(s0)
80001ec8:	fd442783          	lw	a5,-44(s0)
80001ecc:	fff00513          	li	a0,-1
80001ed0:	fff00593          	li	a1,-1
80001ed4:	00a70633          	add	a2,a4,a0
80001ed8:	00060813          	mv	a6,a2
80001edc:	00e83833          	sltu	a6,a6,a4
80001ee0:	00b786b3          	add	a3,a5,a1
80001ee4:	00d805b3          	add	a1,a6,a3
80001ee8:	00058693          	mv	a3,a1
80001eec:	fcc42823          	sw	a2,-48(s0)
80001ef0:	fcd42a23          	sw	a3,-44(s0)
80001ef4:	00070693          	mv	a3,a4
80001ef8:	00f6e6b3          	or	a3,a3,a5
80001efc:	fa0694e3          	bnez	a3,80001ea4 <memmove+0xf0>
        }
    }
    return dst;
80001f00:	fdc42783          	lw	a5,-36(s0)
}
80001f04:	00078513          	mv	a0,a5
80001f08:	02c12403          	lw	s0,44(sp)
80001f0c:	03010113          	addi	sp,sp,48
80001f10:	00008067          	ret

80001f14 <strlen>:

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
80001f14:	fd010113          	addi	sp,sp,-48
80001f18:	02812623          	sw	s0,44(sp)
80001f1c:	03010413          	addi	s0,sp,48
80001f20:	fca42e23          	sw	a0,-36(s0)
    size_t n;

    for(n = 0; s[n] ; n++);
80001f24:	00000793          	li	a5,0
80001f28:	00000813          	li	a6,0
80001f2c:	fef42423          	sw	a5,-24(s0)
80001f30:	ff042623          	sw	a6,-20(s0)
80001f34:	0340006f          	j	80001f68 <strlen+0x54>
80001f38:	fe842603          	lw	a2,-24(s0)
80001f3c:	fec42683          	lw	a3,-20(s0)
80001f40:	00100513          	li	a0,1
80001f44:	00000593          	li	a1,0
80001f48:	00a60733          	add	a4,a2,a0
80001f4c:	00070813          	mv	a6,a4
80001f50:	00c83833          	sltu	a6,a6,a2
80001f54:	00b687b3          	add	a5,a3,a1
80001f58:	00f806b3          	add	a3,a6,a5
80001f5c:	00068793          	mv	a5,a3
80001f60:	fee42423          	sw	a4,-24(s0)
80001f64:	fef42623          	sw	a5,-20(s0)
80001f68:	fe842783          	lw	a5,-24(s0)
80001f6c:	fdc42703          	lw	a4,-36(s0)
80001f70:	00f707b3          	add	a5,a4,a5
80001f74:	0007c783          	lbu	a5,0(a5)
80001f78:	fc0790e3          	bnez	a5,80001f38 <strlen+0x24>
    
    return n;
80001f7c:	fe842703          	lw	a4,-24(s0)
80001f80:	fec42783          	lw	a5,-20(s0)
80001f84:	00070513          	mv	a0,a4
80001f88:	00078593          	mv	a1,a5
80001f8c:	02c12403          	lw	s0,44(sp)
80001f90:	03010113          	addi	sp,sp,48
80001f94:	00008067          	ret

80001f98 <r_tp>:
static inline uint32 r_tp(){
80001f98:	fe010113          	addi	sp,sp,-32
80001f9c:	00812e23          	sw	s0,28(sp)
80001fa0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
80001fa4:	00020793          	mv	a5,tp
80001fa8:	fef42623          	sw	a5,-20(s0)
    return x;
80001fac:	fec42783          	lw	a5,-20(s0)
}
80001fb0:	00078513          	mv	a0,a5
80001fb4:	01c12403          	lw	s0,28(sp)
80001fb8:	02010113          	addi	sp,sp,32
80001fbc:	00008067          	ret

80001fc0 <clintinit>:
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit(){
80001fc0:	fe010113          	addi	sp,sp,-32
80001fc4:	00112e23          	sw	ra,28(sp)
80001fc8:	00812c23          	sw	s0,24(sp)
80001fcc:	02010413          	addi	s0,sp,32
    // 初始化 mtimecmp 
    int hart=r_tp();
80001fd0:	fc9ff0ef          	jal	ra,80001f98 <r_tp>
80001fd4:	00050793          	mv	a5,a0
80001fd8:	fef42623          	sw	a5,-20(s0)
    *(reg_t*)CLINT_MTIMECMP(hart)=*(reg_t*)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
80001fdc:	fec42703          	lw	a4,-20(s0)
80001fe0:	004017b7          	lui	a5,0x401
80001fe4:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80001fe8:	00f707b3          	add	a5,a4,a5
80001fec:	00379793          	slli	a5,a5,0x3
80001ff0:	0007a703          	lw	a4,0(a5)
80001ff4:	fec42683          	lw	a3,-20(s0)
80001ff8:	004017b7          	lui	a5,0x401
80001ffc:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
80002000:	00f687b3          	add	a5,a3,a5
80002004:	00379793          	slli	a5,a5,0x3
80002008:	00078693          	mv	a3,a5
8000200c:	009897b7          	lui	a5,0x989
80002010:	68078793          	addi	a5,a5,1664 # 989680 <sz+0x988680>
80002014:	00f707b3          	add	a5,a4,a5
80002018:	00f6a023          	sw	a5,0(a3) # 1000 <sz>
8000201c:	00000013          	nop
80002020:	01c12083          	lw	ra,28(sp)
80002024:	01812403          	lw	s0,24(sp)
80002028:	02010113          	addi	sp,sp,32
8000202c:	00008067          	ret

80002030 <r_mstatus>:
static inline uint32 r_mstatus(){
80002030:	fe010113          	addi	sp,sp,-32
80002034:	00812e23          	sw	s0,28(sp)
80002038:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0, mstatus" : "=r" (x) );
8000203c:	300027f3          	csrr	a5,mstatus
80002040:	fef42623          	sw	a5,-20(s0)
    return x;
80002044:	fec42783          	lw	a5,-20(s0)
}
80002048:	00078513          	mv	a0,a5
8000204c:	01c12403          	lw	s0,28(sp)
80002050:	02010113          	addi	sp,sp,32
80002054:	00008067          	ret

80002058 <w_mstatus>:
static inline void w_mstatus(uint32 x){
80002058:	fe010113          	addi	sp,sp,-32
8000205c:	00812e23          	sw	s0,28(sp)
80002060:	02010413          	addi	s0,sp,32
80002064:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80002068:	fec42783          	lw	a5,-20(s0)
8000206c:	30079073          	csrw	mstatus,a5
}
80002070:	00000013          	nop
80002074:	01c12403          	lw	s0,28(sp)
80002078:	02010113          	addi	sp,sp,32
8000207c:	00008067          	ret

80002080 <w_mtvec>:
static inline void w_mtvec(uint32 x){
80002080:	fe010113          	addi	sp,sp,-32
80002084:	00812e23          	sw	s0,28(sp)
80002088:	02010413          	addi	s0,sp,32
8000208c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mtvec , %0" : : "r"(x));
80002090:	fec42783          	lw	a5,-20(s0)
80002094:	30579073          	csrw	mtvec,a5
}
80002098:	00000013          	nop
8000209c:	01c12403          	lw	s0,28(sp)
800020a0:	02010113          	addi	sp,sp,32
800020a4:	00008067          	ret

800020a8 <r_tp>:
static inline uint32 r_tp(){
800020a8:	fe010113          	addi	sp,sp,-32
800020ac:	00812e23          	sw	s0,28(sp)
800020b0:	02010413          	addi	s0,sp,32
    asm volatile("mv %0 , tp": "=r"(x));
800020b4:	00020793          	mv	a5,tp
800020b8:	fef42623          	sw	a5,-20(s0)
    return x;
800020bc:	fec42783          	lw	a5,-20(s0)
}
800020c0:	00078513          	mv	a0,a5
800020c4:	01c12403          	lw	s0,28(sp)
800020c8:	02010113          	addi	sp,sp,32
800020cc:	00008067          	ret

800020d0 <s_mstatus_intr>:
static inline void s_mstatus_intr(uint32 m){
800020d0:	fd010113          	addi	sp,sp,-48
800020d4:	02112623          	sw	ra,44(sp)
800020d8:	02812423          	sw	s0,40(sp)
800020dc:	03010413          	addi	s0,sp,48
800020e0:	fca42e23          	sw	a0,-36(s0)
    uint32 x=r_mstatus();
800020e4:	f4dff0ef          	jal	ra,80002030 <r_mstatus>
800020e8:	fea42623          	sw	a0,-20(s0)
    switch (m)
800020ec:	fdc42703          	lw	a4,-36(s0)
800020f0:	08000793          	li	a5,128
800020f4:	04f70263          	beq	a4,a5,80002138 <s_mstatus_intr+0x68>
800020f8:	fdc42703          	lw	a4,-36(s0)
800020fc:	08000793          	li	a5,128
80002100:	0ae7e463          	bltu	a5,a4,800021a8 <s_mstatus_intr+0xd8>
80002104:	fdc42703          	lw	a4,-36(s0)
80002108:	02000793          	li	a5,32
8000210c:	04f70463          	beq	a4,a5,80002154 <s_mstatus_intr+0x84>
80002110:	fdc42703          	lw	a4,-36(s0)
80002114:	02000793          	li	a5,32
80002118:	08e7e863          	bltu	a5,a4,800021a8 <s_mstatus_intr+0xd8>
8000211c:	fdc42703          	lw	a4,-36(s0)
80002120:	00200793          	li	a5,2
80002124:	06f70463          	beq	a4,a5,8000218c <s_mstatus_intr+0xbc>
80002128:	fdc42703          	lw	a4,-36(s0)
8000212c:	00800793          	li	a5,8
80002130:	04f70063          	beq	a4,a5,80002170 <s_mstatus_intr+0xa0>
        break;
80002134:	0740006f          	j	800021a8 <s_mstatus_intr+0xd8>
        x &= ~INTR_MPIE;
80002138:	fec42783          	lw	a5,-20(s0)
8000213c:	f7f7f793          	andi	a5,a5,-129
80002140:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MPIE;
80002144:	fec42783          	lw	a5,-20(s0)
80002148:	0807e793          	ori	a5,a5,128
8000214c:	fef42623          	sw	a5,-20(s0)
        break;
80002150:	05c0006f          	j	800021ac <s_mstatus_intr+0xdc>
        x &= ~INTR_SPIE;
80002154:	fec42783          	lw	a5,-20(s0)
80002158:	fdf7f793          	andi	a5,a5,-33
8000215c:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SPIE;
80002160:	fec42783          	lw	a5,-20(s0)
80002164:	0207e793          	ori	a5,a5,32
80002168:	fef42623          	sw	a5,-20(s0)
        break;
8000216c:	0400006f          	j	800021ac <s_mstatus_intr+0xdc>
        x &= ~INTR_MIE;
80002170:	fec42783          	lw	a5,-20(s0)
80002174:	ff77f793          	andi	a5,a5,-9
80002178:	fef42623          	sw	a5,-20(s0)
        x |= INTR_MIE;
8000217c:	fec42783          	lw	a5,-20(s0)
80002180:	0087e793          	ori	a5,a5,8
80002184:	fef42623          	sw	a5,-20(s0)
        break;
80002188:	0240006f          	j	800021ac <s_mstatus_intr+0xdc>
        x &= ~INTR_SIE;
8000218c:	fec42783          	lw	a5,-20(s0)
80002190:	ffd7f793          	andi	a5,a5,-3
80002194:	fef42623          	sw	a5,-20(s0)
        x |= INTR_SIE;
80002198:	fec42783          	lw	a5,-20(s0)
8000219c:	0027e793          	ori	a5,a5,2
800021a0:	fef42623          	sw	a5,-20(s0)
        break;
800021a4:	0080006f          	j	800021ac <s_mstatus_intr+0xdc>
        break;
800021a8:	00000013          	nop
    w_mstatus(x);
800021ac:	fec42503          	lw	a0,-20(s0)
800021b0:	ea9ff0ef          	jal	ra,80002058 <w_mstatus>
}
800021b4:	00000013          	nop
800021b8:	02c12083          	lw	ra,44(sp)
800021bc:	02812403          	lw	s0,40(sp)
800021c0:	03010113          	addi	sp,sp,48
800021c4:	00008067          	ret

800021c8 <r_sie>:
static inline uint32 r_sie(){
800021c8:	fe010113          	addi	sp,sp,-32
800021cc:	00812e23          	sw	s0,28(sp)
800021d0:	02010413          	addi	s0,sp,32
    asm volatile("csrr %0,sie " : "=r"(x));
800021d4:	104027f3          	csrr	a5,sie
800021d8:	fef42623          	sw	a5,-20(s0)
    return x;
800021dc:	fec42783          	lw	a5,-20(s0)
}
800021e0:	00078513          	mv	a0,a5
800021e4:	01c12403          	lw	s0,28(sp)
800021e8:	02010113          	addi	sp,sp,32
800021ec:	00008067          	ret

800021f0 <w_sie>:
static inline void w_sie(uint32 x){
800021f0:	fe010113          	addi	sp,sp,-32
800021f4:	00812e23          	sw	s0,28(sp)
800021f8:	02010413          	addi	s0,sp,32
800021fc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw sie,%0"::"r"(x));
80002200:	fec42783          	lw	a5,-20(s0)
80002204:	10479073          	csrw	sie,a5
}
80002208:	00000013          	nop
8000220c:	01c12403          	lw	s0,28(sp)
80002210:	02010113          	addi	sp,sp,32
80002214:	00008067          	ret

80002218 <r_mie>:
#define MEIE (1<<11)
#define MTIE (1<<7)
#define MSIE (1<<3)
static inline uint32 r_mie(){
80002218:	fe010113          	addi	sp,sp,-32
8000221c:	00812e23          	sw	s0,28(sp)
80002220:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0,mie " : "=r"(x));
80002224:	304027f3          	csrr	a5,mie
80002228:	fef42623          	sw	a5,-20(s0)
    return x;
8000222c:	fec42783          	lw	a5,-20(s0)
}
80002230:	00078513          	mv	a0,a5
80002234:	01c12403          	lw	s0,28(sp)
80002238:	02010113          	addi	sp,sp,32
8000223c:	00008067          	ret

80002240 <w_mie>:
static inline void w_mie(uint32 x){
80002240:	fe010113          	addi	sp,sp,-32
80002244:	00812e23          	sw	s0,28(sp)
80002248:	02010413          	addi	s0,sp,32
8000224c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mie,%0"::"r"(x));
80002250:	fec42783          	lw	a5,-20(s0)
80002254:	30479073          	csrw	mie,a5
}
80002258:	00000013          	nop
8000225c:	01c12403          	lw	s0,28(sp)
80002260:	02010113          	addi	sp,sp,32
80002264:	00008067          	ret

80002268 <w_mscratch>:

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x){
80002268:	fe010113          	addi	sp,sp,-32
8000226c:	00812e23          	sw	s0,28(sp)
80002270:	02010413          	addi	s0,sp,32
80002274:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mscratch , %0" : :"r"(x));
80002278:	fec42783          	lw	a5,-20(s0)
8000227c:	34079073          	csrw	mscratch,a5
80002280:	00000013          	nop
80002284:	01c12403          	lw	s0,28(sp)
80002288:	02010113          	addi	sp,sp,32
8000228c:	00008067          	ret

80002290 <timerinit>:

// [0] CLINT_MTIMECMP(hart)
// [1] INTERVAL
uint64 timer_sscartch[NCPUS][5];

void timerinit(){
80002290:	fe010113          	addi	sp,sp,-32
80002294:	00112e23          	sw	ra,28(sp)
80002298:	00812c23          	sw	s0,24(sp)
8000229c:	01212a23          	sw	s2,20(sp)
800022a0:	01312823          	sw	s3,16(sp)
800022a4:	02010413          	addi	s0,sp,32
    uint hart=r_tp();
800022a8:	e01ff0ef          	jal	ra,800020a8 <r_tp>
800022ac:	fea42623          	sw	a0,-20(s0)
    // mscratch 指向 time_sscartch[hart]
    w_mscratch((uint32)&timer_sscartch[hart][0]);
800022b0:	fec42703          	lw	a4,-20(s0)
800022b4:	00070793          	mv	a5,a4
800022b8:	00279793          	slli	a5,a5,0x2
800022bc:	00e787b3          	add	a5,a5,a4
800022c0:	00379793          	slli	a5,a5,0x3
800022c4:	8000e737          	lui	a4,0x8000e
800022c8:	8b070713          	addi	a4,a4,-1872 # 8000d8b0 <memend+0xf800d8b0>
800022cc:	00e787b3          	add	a5,a5,a4
800022d0:	00078513          	mv	a0,a5
800022d4:	f95ff0ef          	jal	ra,80002268 <w_mscratch>
    // [0]指向 MTIMECMP 寄存器
    timer_sscartch[hart][0]=CLINT_MTIMECMP(hart);
800022d8:	fec42703          	lw	a4,-20(s0)
800022dc:	004017b7          	lui	a5,0x401
800022e0:	80078793          	addi	a5,a5,-2048 # 400800 <sz+0x3ff800>
800022e4:	00f707b3          	add	a5,a4,a5
800022e8:	00379793          	slli	a5,a5,0x3
800022ec:	00078913          	mv	s2,a5
800022f0:	00000993          	li	s3,0
800022f4:	8000e7b7          	lui	a5,0x8000e
800022f8:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
800022fc:	fec42703          	lw	a4,-20(s0)
80002300:	00070793          	mv	a5,a4
80002304:	00279793          	slli	a5,a5,0x2
80002308:	00e787b3          	add	a5,a5,a4
8000230c:	00379793          	slli	a5,a5,0x3
80002310:	00f687b3          	add	a5,a3,a5
80002314:	0127a023          	sw	s2,0(a5)
80002318:	0137a223          	sw	s3,4(a5)
    // [1]存储 INTERCVAL
    timer_sscartch[hart][1]=CLINT_INTERVAL;
8000231c:	8000e7b7          	lui	a5,0x8000e
80002320:	8b078693          	addi	a3,a5,-1872 # 8000d8b0 <memend+0xf800d8b0>
80002324:	fec42703          	lw	a4,-20(s0)
80002328:	00070793          	mv	a5,a4
8000232c:	00279793          	slli	a5,a5,0x2
80002330:	00e787b3          	add	a5,a5,a4
80002334:	00379793          	slli	a5,a5,0x3
80002338:	00f686b3          	add	a3,a3,a5
8000233c:	00989737          	lui	a4,0x989
80002340:	68070713          	addi	a4,a4,1664 # 989680 <sz+0x988680>
80002344:	00000793          	li	a5,0
80002348:	00e6a423          	sw	a4,8(a3)
8000234c:	00f6a623          	sw	a5,12(a3)

    w_mtvec((uint32)tvec);      // 设置 M-mode time trap处理函数
80002350:	800007b7          	lui	a5,0x80000
80002354:	13478793          	addi	a5,a5,308 # 80000134 <memend+0xf8000134>
80002358:	00078513          	mv	a0,a5
8000235c:	d25ff0ef          	jal	ra,80002080 <w_mtvec>

    s_mstatus_intr(INTR_MIE);   // 开启 M-mode 全局中断
80002360:	00800513          	li	a0,8
80002364:	d6dff0ef          	jal	ra,800020d0 <s_mstatus_intr>

    w_sie(r_sie() | SSIE | STIE | SEIE); // 开 S-mode中断
80002368:	e61ff0ef          	jal	ra,800021c8 <r_sie>
8000236c:	00050793          	mv	a5,a0
80002370:	2227e793          	ori	a5,a5,546
80002374:	00078513          	mv	a0,a5
80002378:	e79ff0ef          	jal	ra,800021f0 <w_sie>

    w_mie(r_mie() | MTIE );      // 开启 M-mode 时钟中断
8000237c:	e9dff0ef          	jal	ra,80002218 <r_mie>
80002380:	00050793          	mv	a5,a0
80002384:	0807e793          	ori	a5,a5,128
80002388:	00078513          	mv	a0,a5
8000238c:	eb5ff0ef          	jal	ra,80002240 <w_mie>

    clintinit();                
80002390:	c31ff0ef          	jal	ra,80001fc0 <clintinit>
80002394:	00000013          	nop
80002398:	01c12083          	lw	ra,28(sp)
8000239c:	01812403          	lw	s0,24(sp)
800023a0:	01412903          	lw	s2,20(sp)
800023a4:	01012983          	lw	s3,16(sp)
800023a8:	02010113          	addi	sp,sp,32
800023ac:	00008067          	ret
