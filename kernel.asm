
kernel.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <_start>:

    # csrrs 读取并设置 CSR 寄存器 csrrs rd,csr,rs;
    # 伪指令 csrr rd,csr ;

    # mhartid 寄存器存放hart的id(只读寄存器)
    csrr t0,mhartid     # 读 mhartid 寄存器
80000000:	f14022f3          	csrr	t0,mhartid
    addi t0,t0,1
80000004:	00128293          	addi	t0,t0,1
    # bnez t0,empty       # 不为0则空转，只使用一个hart

    # 初始化栈
    li t1,ssize
80000008:	00001337          	lui	t1,0x1
    mul t1,t1,t0
8000000c:	02530333          	mul	t1,t1,t0
    la sp,stacks+ssize # 栈指针指向栈底
80000010:	00001117          	auipc	sp,0x1
80000014:	01410113          	addi	sp,sp,20 # 80001024 <stacks+0x1000>
    
    # 跳转到start()
    j start
80000018:	1a80806f          	j	800081c0 <start>

8000001c <empty>:

empty:
    wfi       # 休眠指令 wait for interrupt 直至收到中断
8000001c:	10500073          	wfi
    j empty
80000020:	ffdff06f          	j	8000001c <empty>

80000024 <stacks>:
	...

80008024 <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
80008024:	fe010113          	addi	sp,sp,-32
80008028:	00812e23          	sw	s0,28(sp)
8000802c:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80008030:	300027f3          	csrr	a5,mstatus
80008034:	fef42623          	sw	a5,-20(s0)
    return x;
80008038:	fec42783          	lw	a5,-20(s0)
}
8000803c:	00078513          	mv	a0,a5
80008040:	01c12403          	lw	s0,28(sp)
80008044:	02010113          	addi	sp,sp,32
80008048:	00008067          	ret

8000804c <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
8000804c:	fe010113          	addi	sp,sp,-32
80008050:	00812e23          	sw	s0,28(sp)
80008054:	02010413          	addi	s0,sp,32
80008058:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
8000805c:	fec42783          	lw	a5,-20(s0)
80008060:	30079073          	csrw	mstatus,a5
}
80008064:	00000013          	nop
80008068:	01c12403          	lw	s0,28(sp)
8000806c:	02010113          	addi	sp,sp,32
80008070:	00008067          	ret

80008074 <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
80008074:	fd010113          	addi	sp,sp,-48
80008078:	02112623          	sw	ra,44(sp)
8000807c:	02812423          	sw	s0,40(sp)
80008080:	03010413          	addi	s0,sp,48
80008084:	00050793          	mv	a5,a0
80008088:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
8000808c:	f99ff0ef          	jal	ra,80008024 <r_mstatus>
80008090:	fea42623          	sw	a0,-20(s0)
    switch (m)
80008094:	fdf44783          	lbu	a5,-33(s0)
80008098:	00300713          	li	a4,3
8000809c:	06e78063          	beq	a5,a4,800080fc <s_mstatus_xpp+0x88>
800080a0:	00300713          	li	a4,3
800080a4:	08f74263          	blt	a4,a5,80008128 <s_mstatus_xpp+0xb4>
800080a8:	00078863          	beqz	a5,800080b8 <s_mstatus_xpp+0x44>
800080ac:	00100713          	li	a4,1
800080b0:	02e78063          	beq	a5,a4,800080d0 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800080b4:	0740006f          	j	80008128 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800080b8:	fec42703          	lw	a4,-20(s0)
800080bc:	ffffe7b7          	lui	a5,0xffffe
800080c0:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <panic+0x7fff62df>
800080c4:	00f777b3          	and	a5,a4,a5
800080c8:	fef42623          	sw	a5,-20(s0)
        break;
800080cc:	0600006f          	j	8000812c <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800080d0:	fec42703          	lw	a4,-20(s0)
800080d4:	ffffe7b7          	lui	a5,0xffffe
800080d8:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <panic+0x7fff62df>
800080dc:	00f777b3          	and	a5,a4,a5
800080e0:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
800080e4:	fec42703          	lw	a4,-20(s0)
800080e8:	000017b7          	lui	a5,0x1
800080ec:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
800080f0:	00f767b3          	or	a5,a4,a5
800080f4:	fef42623          	sw	a5,-20(s0)
        break;
800080f8:	0340006f          	j	8000812c <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800080fc:	fec42703          	lw	a4,-20(s0)
80008100:	ffffe7b7          	lui	a5,0xffffe
80008104:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <panic+0x7fff62df>
80008108:	00f777b3          	and	a5,a4,a5
8000810c:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
80008110:	fec42703          	lw	a4,-20(s0)
80008114:	000027b7          	lui	a5,0x2
80008118:	80078793          	addi	a5,a5,-2048 # 1800 <ssize+0x800>
8000811c:	00f767b3          	or	a5,a4,a5
80008120:	fef42623          	sw	a5,-20(s0)
        break;
80008124:	0080006f          	j	8000812c <s_mstatus_xpp+0xb8>
        break;
80008128:	00000013          	nop
    }
    w_mstatus(x);
8000812c:	fec42503          	lw	a0,-20(s0)
80008130:	f1dff0ef          	jal	ra,8000804c <w_mstatus>
}
80008134:	00000013          	nop
80008138:	02c12083          	lw	ra,44(sp)
8000813c:	02812403          	lw	s0,40(sp)
80008140:	03010113          	addi	sp,sp,48
80008144:	00008067          	ret

80008148 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
80008148:	fe010113          	addi	sp,sp,-32
8000814c:	00812e23          	sw	s0,28(sp)
80008150:	02010413          	addi	s0,sp,32
80008154:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
80008158:	fec42783          	lw	a5,-20(s0)
8000815c:	34179073          	csrw	mepc,a5
}
80008160:	00000013          	nop
80008164:	01c12403          	lw	s0,28(sp)
80008168:	02010113          	addi	sp,sp,32
8000816c:	00008067          	ret

80008170 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
80008170:	fe010113          	addi	sp,sp,-32
80008174:	00812e23          	sw	s0,28(sp)
80008178:	02010413          	addi	s0,sp,32
8000817c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
80008180:	fec42783          	lw	a5,-20(s0)
80008184:	30379073          	csrw	mideleg,a5
}
80008188:	00000013          	nop
8000818c:	01c12403          	lw	s0,28(sp)
80008190:	02010113          	addi	sp,sp,32
80008194:	00008067          	ret

80008198 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
80008198:	fe010113          	addi	sp,sp,-32
8000819c:	00812e23          	sw	s0,28(sp)
800081a0:	02010413          	addi	s0,sp,32
800081a4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
800081a8:	fec42783          	lw	a5,-20(s0)
800081ac:	30279073          	csrw	medeleg,a5
800081b0:	00000013          	nop
800081b4:	01c12403          	lw	s0,28(sp)
800081b8:	02010113          	addi	sp,sp,32
800081bc:	00008067          	ret

800081c0 <start>:

extern void main();
extern void tvec();
extern void* stacks[];

void start(){
800081c0:	ff010113          	addi	sp,sp,-16
800081c4:	00112623          	sw	ra,12(sp)
800081c8:	00812423          	sw	s0,8(sp)
800081cc:	01010413          	addi	s0,sp,16
    uartinit();
800081d0:	064000ef          	jal	ra,80008234 <uartinit>

    uartputs("Hello Los!\n");
800081d4:	800087b7          	lui	a5,0x80008
800081d8:	54c78513          	addi	a0,a5,1356 # 8000854c <panic+0x2c>
800081dc:	128000ef          	jal	ra,80008304 <uartputs>
    uartputs((char*)stacks);
800081e0:	800007b7          	lui	a5,0x80000
800081e4:	02478513          	addi	a0,a5,36 # 80000024 <panic+0xffff7b04>
800081e8:	11c000ef          	jal	ra,80008304 <uartputs>

    s_mstatus_xpp(RISCV_S); // 设置特权模式为 S-mode
800081ec:	00100513          	li	a0,1
800081f0:	e85ff0ef          	jal	ra,80008074 <s_mstatus_xpp>

    // w_mtvec((uint32)tvec);  // 设置 trap 向量地址
    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
800081f4:	000107b7          	lui	a5,0x10
800081f8:	fff78513          	addi	a0,a5,-1 # ffff <ssize+0xefff>
800081fc:	f75ff0ef          	jal	ra,80008170 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80008200:	000107b7          	lui	a5,0x10
80008204:	fff78513          	addi	a0,a5,-1 # ffff <ssize+0xefff>
80008208:	f91ff0ef          	jal	ra,80008198 <w_medeleg>

    w_mepc((uint32)main);   // 设置 mepc 为 main 地址
8000820c:	800087b7          	lui	a5,0x80008
80008210:	49078793          	addi	a5,a5,1168 # 80008490 <panic+0xffffff70>
80008214:	00078513          	mv	a0,a5
80008218:	f31ff0ef          	jal	ra,80008148 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");   // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
8000821c:	30200073          	mret
80008220:	00000013          	nop
80008224:	00c12083          	lw	ra,12(sp)
80008228:	00812403          	lw	s0,8(sp)
8000822c:	01010113          	addi	sp,sp,16
80008230:	00008067          	ret

80008234 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
80008234:	fe010113          	addi	sp,sp,-32
80008238:	00812e23          	sw	s0,28(sp)
8000823c:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
80008240:	100007b7          	lui	a5,0x10000
80008244:	00178793          	addi	a5,a5,1 # 10000001 <ssize+0xffff001>
80008248:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
8000824c:	100007b7          	lui	a5,0x10000
80008250:	00378793          	addi	a5,a5,3 # 10000003 <ssize+0xffff003>
80008254:	0007c783          	lbu	a5,0(a5)
80008258:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
8000825c:	100007b7          	lui	a5,0x10000
80008260:	00378793          	addi	a5,a5,3 # 10000003 <ssize+0xffff003>
80008264:	fef44703          	lbu	a4,-17(s0)
80008268:	f8076713          	ori	a4,a4,-128
8000826c:	0ff77713          	andi	a4,a4,255
80008270:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
80008274:	100007b7          	lui	a5,0x10000
80008278:	00300713          	li	a4,3
8000827c:	00e78023          	sb	a4,0(a5) # 10000000 <ssize+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
80008280:	100007b7          	lui	a5,0x10000
80008284:	00178793          	addi	a5,a5,1 # 10000001 <ssize+0xffff001>
80008288:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
8000828c:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
80008290:	100007b7          	lui	a5,0x10000
80008294:	00378793          	addi	a5,a5,3 # 10000003 <ssize+0xffff003>
80008298:	fef44703          	lbu	a4,-17(s0)
8000829c:	00376713          	ori	a4,a4,3
800082a0:	0ff77713          	andi	a4,a4,255
800082a4:	00e78023          	sb	a4,0(a5)
}
800082a8:	00000013          	nop
800082ac:	01c12403          	lw	s0,28(sp)
800082b0:	02010113          	addi	sp,sp,32
800082b4:	00008067          	ret

800082b8 <uartputc>:

// 轮询处理数据
char uartputc(char c){
800082b8:	fe010113          	addi	sp,sp,-32
800082bc:	00812e23          	sw	s0,28(sp)
800082c0:	02010413          	addi	s0,sp,32
800082c4:	00050793          	mv	a5,a0
800082c8:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
800082cc:	00000013          	nop
800082d0:	100007b7          	lui	a5,0x10000
800082d4:	00578793          	addi	a5,a5,5 # 10000005 <ssize+0xffff005>
800082d8:	0007c783          	lbu	a5,0(a5)
800082dc:	0ff7f793          	andi	a5,a5,255
800082e0:	0207f793          	andi	a5,a5,32
800082e4:	fe0786e3          	beqz	a5,800082d0 <uartputc+0x18>
    return uart_write(UART_THR,c);
800082e8:	10000737          	lui	a4,0x10000
800082ec:	fef44783          	lbu	a5,-17(s0)
800082f0:	00f70023          	sb	a5,0(a4) # 10000000 <ssize+0xffff000>
}
800082f4:	00078513          	mv	a0,a5
800082f8:	01c12403          	lw	s0,28(sp)
800082fc:	02010113          	addi	sp,sp,32
80008300:	00008067          	ret

80008304 <uartputs>:

// 发送字符串
void uartputs(char* s){
80008304:	fe010113          	addi	sp,sp,-32
80008308:	00112e23          	sw	ra,28(sp)
8000830c:	00812c23          	sw	s0,24(sp)
80008310:	02010413          	addi	s0,sp,32
80008314:	fea42623          	sw	a0,-20(s0)
    while (*s)
80008318:	01c0006f          	j	80008334 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
8000831c:	fec42783          	lw	a5,-20(s0)
80008320:	00178713          	addi	a4,a5,1
80008324:	fee42623          	sw	a4,-20(s0)
80008328:	0007c783          	lbu	a5,0(a5)
8000832c:	00078513          	mv	a0,a5
80008330:	f89ff0ef          	jal	ra,800082b8 <uartputc>
    while (*s)
80008334:	fec42783          	lw	a5,-20(s0)
80008338:	0007c783          	lbu	a5,0(a5)
8000833c:	fe0790e3          	bnez	a5,8000831c <uartputs+0x18>
    }
    
80008340:	00000013          	nop
80008344:	00000013          	nop
80008348:	01c12083          	lw	ra,28(sp)
8000834c:	01812403          	lw	s0,24(sp)
80008350:	02010113          	addi	sp,sp,32
80008354:	00008067          	ret

80008358 <swtch>:
 * @FilePath: /los/kernel/swtch.c
 */

#include "kernel/swtch.h"

void swtch(struct context* old,struct context* new){
80008358:	fe010113          	addi	sp,sp,-32
8000835c:	00812e23          	sw	s0,28(sp)
80008360:	02010413          	addi	s0,sp,32
80008364:	fea42623          	sw	a0,-20(s0)
80008368:	feb42423          	sw	a1,-24(s0)
    // 将当前context 保存到 old context 中
    asm volatile("sw ra,0(a0)");
8000836c:	00152023          	sw	ra,0(a0)
    asm volatile("sw sp,4(a0)");
80008370:	00252223          	sw	sp,4(a0)
    asm volatile("sw gp,8(a0)");
80008374:	00352423          	sw	gp,8(a0)
    asm volatile("sw tp,12(a0)");
80008378:	00452623          	sw	tp,12(a0)
    asm volatile("sw a0,16(a0)");
8000837c:	00a52823          	sw	a0,16(a0)
    asm volatile("sw a1,20(a0)");
80008380:	00b52a23          	sw	a1,20(a0)
    asm volatile("sw a2,24(a0)");
80008384:	00c52c23          	sw	a2,24(a0)
    asm volatile("sw a3,28(a0)");
80008388:	00d52e23          	sw	a3,28(a0)
    asm volatile("sw a4,32(a0)");
8000838c:	02e52023          	sw	a4,32(a0)
    asm volatile("sw a5,36(a0)");
80008390:	02f52223          	sw	a5,36(a0)
    asm volatile("sw a6,40(a0)");
80008394:	03052423          	sw	a6,40(a0)
    asm volatile("sw a7,44(a0)");
80008398:	03152623          	sw	a7,44(a0)
    asm volatile("sw s0,48(a0)");
8000839c:	02852823          	sw	s0,48(a0)
    asm volatile("sw s1,52(a0)");
800083a0:	02952a23          	sw	s1,52(a0)
    asm volatile("sw s2,56(a0)");
800083a4:	03252c23          	sw	s2,56(a0)
    asm volatile("sw s3,60(a0)");
800083a8:	03352e23          	sw	s3,60(a0)
    asm volatile("sw s4,64(a0)");
800083ac:	05452023          	sw	s4,64(a0)
    asm volatile("sw s5,68(a0)");
800083b0:	05552223          	sw	s5,68(a0)
    asm volatile("sw s6,72(a0)");
800083b4:	05652423          	sw	s6,72(a0)
    asm volatile("sw s7,76(a0)");
800083b8:	05752623          	sw	s7,76(a0)
    asm volatile("sw s8,80(a0)");
800083bc:	05852823          	sw	s8,80(a0)
    asm volatile("sw s9,84(a0)");
800083c0:	05952a23          	sw	s9,84(a0)
    asm volatile("sw s10,88(a0)");
800083c4:	05a52c23          	sw	s10,88(a0)
    asm volatile("sw s11,92(a0)");
800083c8:	05b52e23          	sw	s11,92(a0)
    asm volatile("sw t0,96(a0)");
800083cc:	06552023          	sw	t0,96(a0)
    asm volatile("sw t1,100(a0)");
800083d0:	06652223          	sw	t1,100(a0)
    asm volatile("sw t2,104(a0)");
800083d4:	06752423          	sw	t2,104(a0)
    asm volatile("sw t3,108(a0)");
800083d8:	07c52623          	sw	t3,108(a0)
    asm volatile("sw t4,112(a0)");
800083dc:	07d52823          	sw	t4,112(a0)
    asm volatile("sw t5,116(a0)");
800083e0:	07e52a23          	sw	t5,116(a0)
    asm volatile("sw t6,120(a0)");
800083e4:	07f52c23          	sw	t6,120(a0)

    // 将 new context 加载到寄存器中
    // asm volatile("lw ra,0(a1)");
    // asm volatile("lw sp,4(a1)");
    asm volatile("lw gp,8(a1)");
800083e8:	0085a183          	lw	gp,8(a1)
    asm volatile("lw tp,12(a1)");
800083ec:	00c5a203          	lw	tp,12(a1)
    asm volatile("lw a0,16(a1)");
800083f0:	0105a503          	lw	a0,16(a1)
    // asm volatile("lw a1,20(a1)");
    asm volatile("lw a2,24(a1)");
800083f4:	0185a603          	lw	a2,24(a1)
    asm volatile("lw a3,28(a1)");
800083f8:	01c5a683          	lw	a3,28(a1)
    asm volatile("lw a4,32(a1)");
800083fc:	0205a703          	lw	a4,32(a1)
    asm volatile("lw a5,36(a1)");
80008400:	0245a783          	lw	a5,36(a1)
    asm volatile("lw a6,40(a1)");
80008404:	0285a803          	lw	a6,40(a1)
    asm volatile("lw a7,44(a1)");
80008408:	02c5a883          	lw	a7,44(a1)
    asm volatile("lw s0,48(a1)");
8000840c:	0305a403          	lw	s0,48(a1)
    asm volatile("lw s1,52(a1)");
80008410:	0345a483          	lw	s1,52(a1)
    asm volatile("lw s2,56(a1)");
80008414:	0385a903          	lw	s2,56(a1)
    asm volatile("lw s3,60(a1)");
80008418:	03c5a983          	lw	s3,60(a1)
    asm volatile("lw s4,64(a1)");
8000841c:	0405aa03          	lw	s4,64(a1)
    asm volatile("lw s5,68(a1)");
80008420:	0445aa83          	lw	s5,68(a1)
    asm volatile("lw s6,72(a1)");
80008424:	0485ab03          	lw	s6,72(a1)
    asm volatile("lw s7,76(a1)");
80008428:	04c5ab83          	lw	s7,76(a1)
    asm volatile("lw s8,80(a1)");
8000842c:	0505ac03          	lw	s8,80(a1)
    asm volatile("lw s9,84(a1)");
80008430:	0545ac83          	lw	s9,84(a1)
    asm volatile("lw s10,88(a1)");
80008434:	0585ad03          	lw	s10,88(a1)
    asm volatile("lw s11,92(a1)");
80008438:	05c5ad83          	lw	s11,92(a1)
    asm volatile("lw t0,96(a1)");
8000843c:	0605a283          	lw	t0,96(a1)
    asm volatile("lw t1,100(a1)");
80008440:	0645a303          	lw	t1,100(a1)
    asm volatile("lw t2,104(a1)");
80008444:	0685a383          	lw	t2,104(a1)
    asm volatile("lw t3,108(a1)");
80008448:	06c5ae03          	lw	t3,108(a1)
    asm volatile("lw t4,112(a1)");
8000844c:	0705ae83          	lw	t4,112(a1)
    asm volatile("lw t5,116(a1)");
80008450:	0745af03          	lw	t5,116(a1)
    asm volatile("lw t6,120(a1)");
80008454:	0785af83          	lw	t6,120(a1)
    
80008458:	00000013          	nop
8000845c:	01c12403          	lw	s0,28(sp)
80008460:	02010113          	addi	sp,sp,32
80008464:	00008067          	ret

80008468 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80008468:	fe010113          	addi	sp,sp,-32
8000846c:	00812e23          	sw	s0,28(sp)
80008470:	02010413          	addi	s0,sp,32
80008474:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80008478:	fec42783          	lw	a5,-20(s0)
8000847c:	10579073          	csrw	stvec,a5
}
80008480:	00000013          	nop
80008484:	01c12403          	lw	s0,28(sp)
80008488:	02010113          	addi	sp,sp,32
8000848c:	00008067          	ret

80008490 <main>:
#include "swtch.h"
#include "riscv.h"

extern void tvec();

void main(){
80008490:	ef010113          	addi	sp,sp,-272
80008494:	10112623          	sw	ra,268(sp)
80008498:	10812423          	sw	s0,264(sp)
8000849c:	11010413          	addi	s0,sp,272
    uartputs("start run main()\n");
800084a0:	800087b7          	lui	a5,0x80008
800084a4:	55878513          	addi	a0,a5,1368 # 80008558 <panic+0x38>
800084a8:	e5dff0ef          	jal	ra,80008304 <uartputs>
    struct context old;
    struct context new;
    swtch(&old,&new);
800084ac:	ef840713          	addi	a4,s0,-264
800084b0:	f7440793          	addi	a5,s0,-140
800084b4:	00070593          	mv	a1,a4
800084b8:	00078513          	mv	a0,a5
800084bc:	e9dff0ef          	jal	ra,80008358 <swtch>
    w_stvec((uint32)tvec);
800084c0:	800087b7          	lui	a5,0x80008
800084c4:	4e878793          	addi	a5,a5,1256 # 800084e8 <panic+0xffffffc8>
800084c8:	00078513          	mv	a0,a5
800084cc:	f9dff0ef          	jal	ra,80008468 <w_stvec>
    // uint32 x=r_mstatus();

    swtch(&new,&old);
800084d0:	f7440713          	addi	a4,s0,-140
800084d4:	ef840793          	addi	a5,s0,-264
800084d8:	00070593          	mv	a1,a4
800084dc:	00078513          	mv	a0,a5
800084e0:	e79ff0ef          	jal	ra,80008358 <swtch>
    while(1);
800084e4:	0000006f          	j	800084e4 <main+0x54>

800084e8 <tvec>:
 * @FilePath: /los/kernel/trap.c
 */
#include "types.h"
#include "uart.h"

void tvec(){
800084e8:	ff010113          	addi	sp,sp,-16
800084ec:	00112623          	sw	ra,12(sp)
800084f0:	00812423          	sw	s0,8(sp)
800084f4:	01010413          	addi	s0,sp,16
    uartputs("exception or interrupt\n");
800084f8:	800087b7          	lui	a5,0x80008
800084fc:	56c78513          	addi	a0,a5,1388 # 8000856c <panic+0x4c>
80008500:	e05ff0ef          	jal	ra,80008304 <uartputs>
    panic(0);
80008504:	00000513          	li	a0,0
80008508:	018000ef          	jal	ra,80008520 <panic>
}
8000850c:	00000013          	nop
80008510:	00c12083          	lw	ra,12(sp)
80008514:	00812403          	lw	s0,8(sp)
80008518:	01010113          	addi	sp,sp,16
8000851c:	00008067          	ret

80008520 <panic>:
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/printf.c
 */
#include "uart.h"

void panic(char* s){
80008520:	fe010113          	addi	sp,sp,-32
80008524:	00112e23          	sw	ra,28(sp)
80008528:	00812c23          	sw	s0,24(sp)
8000852c:	02010413          	addi	s0,sp,32
80008530:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
80008534:	800087b7          	lui	a5,0x80008
80008538:	58478513          	addi	a0,a5,1412 # 80008584 <panic+0x64>
8000853c:	dc9ff0ef          	jal	ra,80008304 <uartputs>
    uartputs(s);
80008540:	fec42503          	lw	a0,-20(s0)
80008544:	dc1ff0ef          	jal	ra,80008304 <uartputs>
    while(1);
80008548:	0000006f          	j	80008548 <panic+0x28>
