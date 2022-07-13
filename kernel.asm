
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
    mv tp,t0            # 保存为线程id
80000008:	00028213          	mv	tp,t0
    # bnez t0,empty       # 不为0则空转，只使用一个hart

    # 初始化栈
    la sp,stacks
8000000c:	00000117          	auipc	sp,0x0
80000010:	02010113          	addi	sp,sp,32 # 8000002c <stacks>
    li t1,sz
80000014:	00001337          	lui	t1,0x1
    mul t1,t1,t0
80000018:	02530333          	mul	t1,t1,t0
    add sp,sp,t1 # 栈指针指向栈顶
8000001c:	00610133          	add	sp,sp,t1
    
    # 跳转到start()
    j start
80000020:	1f80806f          	j	80008218 <start>

80000024 <empty>:

empty:
    wfi       # 休眠指令 wait for interrupt 直至收到中断
80000024:	10500073          	wfi
    j empty
80000028:	ffdff06f          	j	80000024 <empty>

8000002c <stacks>:
	...

8000802c <r_mstatus>:
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus(){
8000802c:	fe010113          	addi	sp,sp,-32
80008030:	00812e23          	sw	s0,28(sp)
80008034:	02010413          	addi	s0,sp,32
    uint32 x;
    asm volatile("csrr %0, mstatus" : "=r" (x) );
80008038:	300027f3          	csrr	a5,mstatus
8000803c:	fef42623          	sw	a5,-20(s0)
    return x;
80008040:	fec42783          	lw	a5,-20(s0)
}
80008044:	00078513          	mv	a0,a5
80008048:	01c12403          	lw	s0,28(sp)
8000804c:	02010113          	addi	sp,sp,32
80008050:	00008067          	ret

80008054 <w_mstatus>:
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x){
80008054:	fe010113          	addi	sp,sp,-32
80008058:	00812e23          	sw	s0,28(sp)
8000805c:	02010413          	addi	s0,sp,32
80008060:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mstatus, %0" : : "r" (x) );
80008064:	fec42783          	lw	a5,-20(s0)
80008068:	30079073          	csrw	mstatus,a5
}
8000806c:	00000013          	nop
80008070:	01c12403          	lw	s0,28(sp)
80008074:	02010113          	addi	sp,sp,32
80008078:	00008067          	ret

8000807c <s_mstatus_xpp>:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m){
8000807c:	fd010113          	addi	sp,sp,-48
80008080:	02112623          	sw	ra,44(sp)
80008084:	02812423          	sw	s0,40(sp)
80008088:	03010413          	addi	s0,sp,48
8000808c:	00050793          	mv	a5,a0
80008090:	fcf40fa3          	sb	a5,-33(s0)
    uint32 x=r_mstatus();
80008094:	f99ff0ef          	jal	ra,8000802c <r_mstatus>
80008098:	fea42623          	sw	a0,-20(s0)
    switch (m)
8000809c:	fdf44783          	lbu	a5,-33(s0)
800080a0:	00300713          	li	a4,3
800080a4:	06e78063          	beq	a5,a4,80008104 <s_mstatus_xpp+0x88>
800080a8:	00300713          	li	a4,3
800080ac:	08f74263          	blt	a4,a5,80008130 <s_mstatus_xpp+0xb4>
800080b0:	00078863          	beqz	a5,800080c0 <s_mstatus_xpp+0x44>
800080b4:	00100713          	li	a4,1
800080b8:	02e78063          	beq	a5,a4,800080d8 <s_mstatus_xpp+0x5c>
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= MPP_SET;
        break;
    default:
        break;
800080bc:	0740006f          	j	80008130 <s_mstatus_xpp+0xb4>
        x &= ~XPP_MASK;
800080c0:	fec42703          	lw	a4,-20(s0)
800080c4:	ffffe7b7          	lui	a5,0xffffe
800080c8:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800080cc:	00f777b3          	and	a5,a4,a5
800080d0:	fef42623          	sw	a5,-20(s0)
        break;
800080d4:	0600006f          	j	80008134 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
800080d8:	fec42703          	lw	a4,-20(s0)
800080dc:	ffffe7b7          	lui	a5,0xffffe
800080e0:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
800080e4:	00f777b3          	and	a5,a4,a5
800080e8:	fef42623          	sw	a5,-20(s0)
        x |= SPP_SET;
800080ec:	fec42703          	lw	a4,-20(s0)
800080f0:	000017b7          	lui	a5,0x1
800080f4:	80078793          	addi	a5,a5,-2048 # 800 <harts+0x7f8>
800080f8:	00f767b3          	or	a5,a4,a5
800080fc:	fef42623          	sw	a5,-20(s0)
        break;
80008100:	0340006f          	j	80008134 <s_mstatus_xpp+0xb8>
        x &= ~XPP_MASK;
80008104:	fec42703          	lw	a4,-20(s0)
80008108:	ffffe7b7          	lui	a5,0xffffe
8000810c:	7ff78793          	addi	a5,a5,2047 # ffffe7ff <memend+0x77ffe7ff>
80008110:	00f777b3          	and	a5,a4,a5
80008114:	fef42623          	sw	a5,-20(s0)
        x |= MPP_SET;
80008118:	fec42703          	lw	a4,-20(s0)
8000811c:	000027b7          	lui	a5,0x2
80008120:	80078793          	addi	a5,a5,-2048 # 1800 <sz+0x800>
80008124:	00f767b3          	or	a5,a4,a5
80008128:	fef42623          	sw	a5,-20(s0)
        break;
8000812c:	0080006f          	j	80008134 <s_mstatus_xpp+0xb8>
        break;
80008130:	00000013          	nop
    }
    w_mstatus(x);
80008134:	fec42503          	lw	a0,-20(s0)
80008138:	f1dff0ef          	jal	ra,80008054 <w_mstatus>
}
8000813c:	00000013          	nop
80008140:	02c12083          	lw	ra,44(sp)
80008144:	02812403          	lw	s0,40(sp)
80008148:	03010113          	addi	sp,sp,48
8000814c:	00008067          	ret

80008150 <w_mepc>:
    uint32 x;
    asm volatile("csrr %0, mepc" : "=r" (x) );
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x){
80008150:	fe010113          	addi	sp,sp,-32
80008154:	00812e23          	sw	s0,28(sp)
80008158:	02010413          	addi	s0,sp,32
8000815c:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mepc, %0" : : "r" (x) );
80008160:	fec42783          	lw	a5,-20(s0)
80008164:	34179073          	csrw	mepc,a5
}
80008168:	00000013          	nop
8000816c:	01c12403          	lw	s0,28(sp)
80008170:	02010113          	addi	sp,sp,32
80008174:	00008067          	ret

80008178 <w_stvec>:
static inline uint32 r_stvec(){
    uint32 x;
    asm volatile("csrr %0 , stvec" : "=r" (x));
    return x;
}
static inline void w_stvec(uint32 x){
80008178:	fe010113          	addi	sp,sp,-32
8000817c:	00812e23          	sw	s0,28(sp)
80008180:	02010413          	addi	s0,sp,32
80008184:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw stvec , %0" : : "r"(x));
80008188:	fec42783          	lw	a5,-20(s0)
8000818c:	10579073          	csrw	stvec,a5
}
80008190:	00000013          	nop
80008194:	01c12403          	lw	s0,28(sp)
80008198:	02010113          	addi	sp,sp,32
8000819c:	00008067          	ret

800081a0 <w_mideleg>:
static inline uint32 r_mideleg(){
    uint32 x;
    asm volatile("csrr %0 , mideleg" : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x){
800081a0:	fe010113          	addi	sp,sp,-32
800081a4:	00812e23          	sw	s0,28(sp)
800081a8:	02010413          	addi	s0,sp,32
800081ac:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw mideleg , %0 " : : "r"(x));
800081b0:	fec42783          	lw	a5,-20(s0)
800081b4:	30379073          	csrw	mideleg,a5
}
800081b8:	00000013          	nop
800081bc:	01c12403          	lw	s0,28(sp)
800081c0:	02010113          	addi	sp,sp,32
800081c4:	00008067          	ret

800081c8 <w_medeleg>:
static inline uint32 r_medeleg(){
    uint32 x;
    asm volatile("csrr %0 , medeleg" : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x){
800081c8:	fe010113          	addi	sp,sp,-32
800081cc:	00812e23          	sw	s0,28(sp)
800081d0:	02010413          	addi	s0,sp,32
800081d4:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw medeleg , %0 " : : "r"(x));
800081d8:	fec42783          	lw	a5,-20(s0)
800081dc:	30279073          	csrw	medeleg,a5
}
800081e0:	00000013          	nop
800081e4:	01c12403          	lw	s0,28(sp)
800081e8:	02010113          	addi	sp,sp,32
800081ec:	00008067          	ret

800081f0 <w_satp>:
static inline uint32 r_satp(){
    uint32 x;
    asm volatile("csrr %0,satp":"=r"(x));
    return x;
}
static inline void w_satp(uint32 x){
800081f0:	fe010113          	addi	sp,sp,-32
800081f4:	00812e23          	sw	s0,28(sp)
800081f8:	02010413          	addi	s0,sp,32
800081fc:	fea42623          	sw	a0,-20(s0)
    asm volatile("csrw satp,%0"::"r"(x));
80008200:	fec42783          	lw	a5,-20(s0)
80008204:	18079073          	csrw	satp,a5
}
80008208:	00000013          	nop
8000820c:	01c12403          	lw	s0,28(sp)
80008210:	02010113          	addi	sp,sp,32
80008214:	00008067          	ret

80008218 <start>:
#include "kernel/defs.h"
#include "kernel/riscv.h"

extern void main();

void start(){
80008218:	ff010113          	addi	sp,sp,-16
8000821c:	00112623          	sw	ra,12(sp)
80008220:	00812423          	sw	s0,8(sp)
80008224:	01010413          	addi	s0,sp,16
    uartinit();
80008228:	070000ef          	jal	ra,80008298 <uartinit>
    uartputs("Hello Los!\n");
8000822c:	800097b7          	lui	a5,0x80009
80008230:	00078513          	mv	a0,a5
80008234:	134000ef          	jal	ra,80008368 <uartputs>

    s_mstatus_xpp(RISCV_S); // 设置特权模式为 S-mode
80008238:	00100513          	li	a0,1
8000823c:	e41ff0ef          	jal	ra,8000807c <s_mstatus_xpp>

    w_satp((uint32)0);      // 暂时禁用分页
80008240:	00000513          	li	a0,0
80008244:	fadff0ef          	jal	ra,800081f0 <w_satp>

    // w_mtvec((uint32)tvec);  // 设置 trap 向量地址
    w_stvec((uint32)tvec);
80008248:	800087b7          	lui	a5,0x80008
8000824c:	4f078793          	addi	a5,a5,1264 # 800084f0 <memend+0xf80084f0>
80008250:	00078513          	mv	a0,a5
80008254:	f25ff0ef          	jal	ra,80008178 <w_stvec>
    w_mideleg((uint32)0xffff);  // 16项中断委托给S-mode
80008258:	000107b7          	lui	a5,0x10
8000825c:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
80008260:	f41ff0ef          	jal	ra,800081a0 <w_mideleg>
    w_medeleg((uint32)0xffff);  // 16项异常委托给S-mode
80008264:	000107b7          	lui	a5,0x10
80008268:	fff78513          	addi	a0,a5,-1 # ffff <sz+0xefff>
8000826c:	f5dff0ef          	jal	ra,800081c8 <w_medeleg>

    w_mepc((uint32)main);   // 设置 mepc 为 main 地址
80008270:	800087b7          	lui	a5,0x80008
80008274:	4cc78793          	addi	a5,a5,1228 # 800084cc <memend+0xf80084cc>
80008278:	00078513          	mv	a0,a5
8000827c:	ed5ff0ef          	jal	ra,80008150 <w_mepc>
    // Upon reset, a hart’s privilege mode is set to M
    asm volatile("mret");   // 改变特权级，从M-mode返回。跳转至mepc寄存器地址处
80008280:	30200073          	mret
80008284:	00000013          	nop
80008288:	00c12083          	lw	ra,12(sp)
8000828c:	00812403          	lw	s0,8(sp)
80008290:	01010113          	addi	sp,sp,16
80008294:	00008067          	ret

80008298 <uartinit>:
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"

void uartinit(){
80008298:	fe010113          	addi	sp,sp,-32
8000829c:	00812e23          	sw	s0,28(sp)
800082a0:	02010413          	addi	s0,sp,32
    // 关闭中断
    uart_write(UART_IER,0x00);
800082a4:	100007b7          	lui	a5,0x10000
800082a8:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800082ac:	00078023          	sb	zero,0(a5)

    // 设置传输波特率
    uint8 lcr=uart_read(UART_LCR);  // 读取LCR寄存器值
800082b0:	100007b7          	lui	a5,0x10000
800082b4:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800082b8:	0007c783          	lbu	a5,0(a5)
800082bc:	fef407a3          	sb	a5,-17(s0)
    uart_write(UART_LCR,lcr|(1<<7));    // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
800082c0:	100007b7          	lui	a5,0x10000
800082c4:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800082c8:	fef44703          	lbu	a4,-17(s0)
800082cc:	f8076713          	ori	a4,a4,-128
800082d0:	0ff77713          	andi	a4,a4,255
800082d4:	00e78023          	sb	a4,0(a5)
    // 设置0x0003,38.4K频
    uart_write(UART_DLL,0x03);      // 设置低位
800082d8:	100007b7          	lui	a5,0x10000
800082dc:	00300713          	li	a4,3
800082e0:	00e78023          	sb	a4,0(a5) # 10000000 <sz+0xffff000>
    uart_write(UART_DLM,0x00);      // 设置高位
800082e4:	100007b7          	lui	a5,0x10000
800082e8:	00178793          	addi	a5,a5,1 # 10000001 <sz+0xffff001>
800082ec:	00078023          	sb	zero,0(a5)

    // 设置校验位
    lcr=0;
800082f0:	fe0407a3          	sb	zero,-17(s0)
    uart_write(UART_LCR,lcr|(3<<0));
800082f4:	100007b7          	lui	a5,0x10000
800082f8:	00378793          	addi	a5,a5,3 # 10000003 <sz+0xffff003>
800082fc:	fef44703          	lbu	a4,-17(s0)
80008300:	00376713          	ori	a4,a4,3
80008304:	0ff77713          	andi	a4,a4,255
80008308:	00e78023          	sb	a4,0(a5)
}
8000830c:	00000013          	nop
80008310:	01c12403          	lw	s0,28(sp)
80008314:	02010113          	addi	sp,sp,32
80008318:	00008067          	ret

8000831c <uartputc>:

// 轮询处理数据
char uartputc(char c){
8000831c:	fe010113          	addi	sp,sp,-32
80008320:	00812e23          	sw	s0,28(sp)
80008324:	02010413          	addi	s0,sp,32
80008328:	00050793          	mv	a5,a0
8000832c:	fef407a3          	sb	a5,-17(s0)
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while(((uart_read(UART_LSR))&(1<<5))==0);     // 轮询
80008330:	00000013          	nop
80008334:	100007b7          	lui	a5,0x10000
80008338:	00578793          	addi	a5,a5,5 # 10000005 <sz+0xffff005>
8000833c:	0007c783          	lbu	a5,0(a5)
80008340:	0ff7f793          	andi	a5,a5,255
80008344:	0207f793          	andi	a5,a5,32
80008348:	fe0786e3          	beqz	a5,80008334 <uartputc+0x18>
    return uart_write(UART_THR,c);
8000834c:	10000737          	lui	a4,0x10000
80008350:	fef44783          	lbu	a5,-17(s0)
80008354:	00f70023          	sb	a5,0(a4) # 10000000 <sz+0xffff000>
}
80008358:	00078513          	mv	a0,a5
8000835c:	01c12403          	lw	s0,28(sp)
80008360:	02010113          	addi	sp,sp,32
80008364:	00008067          	ret

80008368 <uartputs>:

// 发送字符串
void uartputs(char* s){
80008368:	fe010113          	addi	sp,sp,-32
8000836c:	00112e23          	sw	ra,28(sp)
80008370:	00812c23          	sw	s0,24(sp)
80008374:	02010413          	addi	s0,sp,32
80008378:	fea42623          	sw	a0,-20(s0)
    while (*s)
8000837c:	01c0006f          	j	80008398 <uartputs+0x30>
    {
        /* code */
        uartputc(*s++);
80008380:	fec42783          	lw	a5,-20(s0)
80008384:	00178713          	addi	a4,a5,1
80008388:	fee42623          	sw	a4,-20(s0)
8000838c:	0007c783          	lbu	a5,0(a5)
80008390:	00078513          	mv	a0,a5
80008394:	f89ff0ef          	jal	ra,8000831c <uartputc>
    while (*s)
80008398:	fec42783          	lw	a5,-20(s0)
8000839c:	0007c783          	lbu	a5,0(a5)
800083a0:	fe0790e3          	bnez	a5,80008380 <uartputs+0x18>
    }
    
800083a4:	00000013          	nop
800083a8:	00000013          	nop
800083ac:	01c12083          	lw	ra,28(sp)
800083b0:	01812403          	lw	s0,24(sp)
800083b4:	02010113          	addi	sp,sp,32
800083b8:	00008067          	ret

800083bc <swtch>:
 * @FilePath: /los/kernel/swtch.c
 */

#include "defs.h"

void swtch(struct context* old,struct context* new){
800083bc:	fe010113          	addi	sp,sp,-32
800083c0:	00812e23          	sw	s0,28(sp)
800083c4:	02010413          	addi	s0,sp,32
800083c8:	fea42623          	sw	a0,-20(s0)
800083cc:	feb42423          	sw	a1,-24(s0)
    // 将当前context 保存到 old context 中
    asm volatile("sw ra,0(a0)");
800083d0:	00152023          	sw	ra,0(a0)
    asm volatile("sw sp,4(a0)");
800083d4:	00252223          	sw	sp,4(a0)
    asm volatile("sw gp,8(a0)");
800083d8:	00352423          	sw	gp,8(a0)
    asm volatile("sw tp,12(a0)");
800083dc:	00452623          	sw	tp,12(a0)
    asm volatile("sw a0,16(a0)");
800083e0:	00a52823          	sw	a0,16(a0)
    asm volatile("sw a1,20(a0)");
800083e4:	00b52a23          	sw	a1,20(a0)
    asm volatile("sw a2,24(a0)");
800083e8:	00c52c23          	sw	a2,24(a0)
    asm volatile("sw a3,28(a0)");
800083ec:	00d52e23          	sw	a3,28(a0)
    asm volatile("sw a4,32(a0)");
800083f0:	02e52023          	sw	a4,32(a0)
    asm volatile("sw a5,36(a0)");
800083f4:	02f52223          	sw	a5,36(a0)
    asm volatile("sw a6,40(a0)");
800083f8:	03052423          	sw	a6,40(a0)
    asm volatile("sw a7,44(a0)");
800083fc:	03152623          	sw	a7,44(a0)
    asm volatile("sw s0,48(a0)");
80008400:	02852823          	sw	s0,48(a0)
    asm volatile("sw s1,52(a0)");
80008404:	02952a23          	sw	s1,52(a0)
    asm volatile("sw s2,56(a0)");
80008408:	03252c23          	sw	s2,56(a0)
    asm volatile("sw s3,60(a0)");
8000840c:	03352e23          	sw	s3,60(a0)
    asm volatile("sw s4,64(a0)");
80008410:	05452023          	sw	s4,64(a0)
    asm volatile("sw s5,68(a0)");
80008414:	05552223          	sw	s5,68(a0)
    asm volatile("sw s6,72(a0)");
80008418:	05652423          	sw	s6,72(a0)
    asm volatile("sw s7,76(a0)");
8000841c:	05752623          	sw	s7,76(a0)
    asm volatile("sw s8,80(a0)");
80008420:	05852823          	sw	s8,80(a0)
    asm volatile("sw s9,84(a0)");
80008424:	05952a23          	sw	s9,84(a0)
    asm volatile("sw s10,88(a0)");
80008428:	05a52c23          	sw	s10,88(a0)
    asm volatile("sw s11,92(a0)");
8000842c:	05b52e23          	sw	s11,92(a0)
    asm volatile("sw t0,96(a0)");
80008430:	06552023          	sw	t0,96(a0)
    asm volatile("sw t1,100(a0)");
80008434:	06652223          	sw	t1,100(a0)
    asm volatile("sw t2,104(a0)");
80008438:	06752423          	sw	t2,104(a0)
    asm volatile("sw t3,108(a0)");
8000843c:	07c52623          	sw	t3,108(a0)
    asm volatile("sw t4,112(a0)");
80008440:	07d52823          	sw	t4,112(a0)
    asm volatile("sw t5,116(a0)");
80008444:	07e52a23          	sw	t5,116(a0)
    asm volatile("sw t6,120(a0)");
80008448:	07f52c23          	sw	t6,120(a0)

    // 将 new context 加载到寄存器中
    // asm volatile("lw ra,0(a1)");
    // asm volatile("lw sp,4(a1)");
    asm volatile("lw gp,8(a1)");
8000844c:	0085a183          	lw	gp,8(a1)
    asm volatile("lw tp,12(a1)");
80008450:	00c5a203          	lw	tp,12(a1)
    asm volatile("lw a0,16(a1)");
80008454:	0105a503          	lw	a0,16(a1)
    // asm volatile("lw a1,20(a1)");
    asm volatile("lw a2,24(a1)");
80008458:	0185a603          	lw	a2,24(a1)
    asm volatile("lw a3,28(a1)");
8000845c:	01c5a683          	lw	a3,28(a1)
    asm volatile("lw a4,32(a1)");
80008460:	0205a703          	lw	a4,32(a1)
    asm volatile("lw a5,36(a1)");
80008464:	0245a783          	lw	a5,36(a1)
    asm volatile("lw a6,40(a1)");
80008468:	0285a803          	lw	a6,40(a1)
    asm volatile("lw a7,44(a1)");
8000846c:	02c5a883          	lw	a7,44(a1)
    asm volatile("lw s0,48(a1)");
80008470:	0305a403          	lw	s0,48(a1)
    asm volatile("lw s1,52(a1)");
80008474:	0345a483          	lw	s1,52(a1)
    asm volatile("lw s2,56(a1)");
80008478:	0385a903          	lw	s2,56(a1)
    asm volatile("lw s3,60(a1)");
8000847c:	03c5a983          	lw	s3,60(a1)
    asm volatile("lw s4,64(a1)");
80008480:	0405aa03          	lw	s4,64(a1)
    asm volatile("lw s5,68(a1)");
80008484:	0445aa83          	lw	s5,68(a1)
    asm volatile("lw s6,72(a1)");
80008488:	0485ab03          	lw	s6,72(a1)
    asm volatile("lw s7,76(a1)");
8000848c:	04c5ab83          	lw	s7,76(a1)
    asm volatile("lw s8,80(a1)");
80008490:	0505ac03          	lw	s8,80(a1)
    asm volatile("lw s9,84(a1)");
80008494:	0545ac83          	lw	s9,84(a1)
    asm volatile("lw s10,88(a1)");
80008498:	0585ad03          	lw	s10,88(a1)
    asm volatile("lw s11,92(a1)");
8000849c:	05c5ad83          	lw	s11,92(a1)
    asm volatile("lw t0,96(a1)");
800084a0:	0605a283          	lw	t0,96(a1)
    asm volatile("lw t1,100(a1)");
800084a4:	0645a303          	lw	t1,100(a1)
    asm volatile("lw t2,104(a1)");
800084a8:	0685a383          	lw	t2,104(a1)
    asm volatile("lw t3,108(a1)");
800084ac:	06c5ae03          	lw	t3,108(a1)
    asm volatile("lw t4,112(a1)");
800084b0:	0705ae83          	lw	t4,112(a1)
    asm volatile("lw t5,116(a1)");
800084b4:	0745af03          	lw	t5,116(a1)
    asm volatile("lw t6,120(a1)");
800084b8:	0785af83          	lw	t6,120(a1)
    
800084bc:	00000013          	nop
800084c0:	01c12403          	lw	s0,28(sp)
800084c4:	02010113          	addi	sp,sp,32
800084c8:	00008067          	ret

800084cc <main>:
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"

void main(){
800084cc:	ff010113          	addi	sp,sp,-16
800084d0:	00112623          	sw	ra,12(sp)
800084d4:	00812423          	sw	s0,8(sp)
800084d8:	01010413          	addi	s0,sp,16
    uartputs("start run main()\n");
800084dc:	800097b7          	lui	a5,0x80009
800084e0:	00c78513          	addi	a0,a5,12 # 8000900c <memend+0xf800900c>
800084e4:	e85ff0ef          	jal	ra,80008368 <uartputs>
    
    minit();
800084e8:	4f0000ef          	jal	ra,800089d8 <minit>

    
    while(1);
800084ec:	0000006f          	j	800084ec <main+0x20>

800084f0 <tvec>:
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/trap.c
 */
#include "defs.h"

void tvec(){
800084f0:	ff010113          	addi	sp,sp,-16
800084f4:	00112623          	sw	ra,12(sp)
800084f8:	00812423          	sw	s0,8(sp)
800084fc:	01010413          	addi	s0,sp,16
    uartputs("exception or interrupt\n");
80008500:	800097b7          	lui	a5,0x80009
80008504:	02078513          	addi	a0,a5,32 # 80009020 <memend+0xf8009020>
80008508:	e61ff0ef          	jal	ra,80008368 <uartputs>
    panic(0);
8000850c:	00000513          	li	a0,0
80008510:	018000ef          	jal	ra,80008528 <panic>
}
80008514:	00000013          	nop
80008518:	00c12083          	lw	ra,12(sp)
8000851c:	00812403          	lw	s0,8(sp)
80008520:	01010113          	addi	sp,sp,16
80008524:	00008067          	ret

80008528 <panic>:
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
80008528:	fe010113          	addi	sp,sp,-32
8000852c:	00112e23          	sw	ra,28(sp)
80008530:	00812c23          	sw	s0,24(sp)
80008534:	02010413          	addi	s0,sp,32
80008538:	fea42623          	sw	a0,-20(s0)
    uartputs("panic: ");
8000853c:	800097b7          	lui	a5,0x80009
80008540:	03878513          	addi	a0,a5,56 # 80009038 <memend+0xf8009038>
80008544:	e25ff0ef          	jal	ra,80008368 <uartputs>
    uartputs(s);
80008548:	fec42503          	lw	a0,-20(s0)
8000854c:	e1dff0ef          	jal	ra,80008368 <uartputs>
	uartputs("\n");
80008550:	800097b7          	lui	a5,0x80009
80008554:	04078513          	addi	a0,a5,64 # 80009040 <memend+0xf8009040>
80008558:	e11ff0ef          	jal	ra,80008368 <uartputs>
    while(1);
8000855c:	0000006f          	j	8000855c <panic+0x34>

80008560 <printf>:
}

static char outbuf[1024];
// # 简易版 printf
// ! 未处理异常
int printf(const char* fmt,...){
80008560:	f8010113          	addi	sp,sp,-128
80008564:	04112e23          	sw	ra,92(sp)
80008568:	04812c23          	sw	s0,88(sp)
8000856c:	06010413          	addi	s0,sp,96
80008570:	faa42623          	sw	a0,-84(s0)
80008574:	00b42223          	sw	a1,4(s0)
80008578:	00c42423          	sw	a2,8(s0)
8000857c:	00d42623          	sw	a3,12(s0)
80008580:	00e42823          	sw	a4,16(s0)
80008584:	00f42a23          	sw	a5,20(s0)
80008588:	01042c23          	sw	a6,24(s0)
8000858c:	01142e23          	sw	a7,28(s0)
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
80008590:	02040793          	addi	a5,s0,32
80008594:	faf42423          	sw	a5,-88(s0)
80008598:	fa842783          	lw	a5,-88(s0)
8000859c:	fe478793          	addi	a5,a5,-28
800085a0:	faf42c23          	sw	a5,-72(s0)
	char ch;
	const char* s = fmt;
800085a4:	fac42783          	lw	a5,-84(s0)
800085a8:	fef42623          	sw	a5,-20(s0)
	int tt=0;
800085ac:	fe042423          	sw	zero,-24(s0)
	int idx=0;
800085b0:	fe042223          	sw	zero,-28(s0)
	while(ch=*(s)){
800085b4:	36c0006f          	j	80008920 <printf+0x3c0>
		if(ch=='%'){
800085b8:	fbf44703          	lbu	a4,-65(s0)
800085bc:	02500793          	li	a5,37
800085c0:	04f71863          	bne	a4,a5,80008610 <printf+0xb0>
			if(tt==1){
800085c4:	fe842703          	lw	a4,-24(s0)
800085c8:	00100793          	li	a5,1
800085cc:	02f71663          	bne	a4,a5,800085f8 <printf+0x98>
				outbuf[idx++]='%';
800085d0:	fe442783          	lw	a5,-28(s0)
800085d4:	00178713          	addi	a4,a5,1
800085d8:	fee42223          	sw	a4,-28(s0)
800085dc:	8000a737          	lui	a4,0x8000a
800085e0:	00070713          	mv	a4,a4
800085e4:	00f707b3          	add	a5,a4,a5
800085e8:	02500713          	li	a4,37
800085ec:	00e78023          	sb	a4,0(a5)
				tt=0;
800085f0:	fe042423          	sw	zero,-24(s0)
800085f4:	00c0006f          	j	80008600 <printf+0xa0>
			}else{
				tt=1;
800085f8:	00100793          	li	a5,1
800085fc:	fef42423          	sw	a5,-24(s0)
			}
			s++;
80008600:	fec42783          	lw	a5,-20(s0)
80008604:	00178793          	addi	a5,a5,1
80008608:	fef42623          	sw	a5,-20(s0)
			continue;
8000860c:	3140006f          	j	80008920 <printf+0x3c0>
		}else{
			if(tt==1){
80008610:	fe842703          	lw	a4,-24(s0)
80008614:	00100793          	li	a5,1
80008618:	2cf71e63          	bne	a4,a5,800088f4 <printf+0x394>
				switch (ch)
8000861c:	fbf44783          	lbu	a5,-65(s0)
80008620:	fa878793          	addi	a5,a5,-88
80008624:	02000713          	li	a4,32
80008628:	2af76663          	bltu	a4,a5,800088d4 <printf+0x374>
8000862c:	00279713          	slli	a4,a5,0x2
80008630:	800097b7          	lui	a5,0x80009
80008634:	05c78793          	addi	a5,a5,92 # 8000905c <memend+0xf800905c>
80008638:	00f707b3          	add	a5,a4,a5
8000863c:	0007a783          	lw	a5,0(a5)
80008640:	00078067          	jr	a5
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
80008644:	fb842783          	lw	a5,-72(s0)
80008648:	00478713          	addi	a4,a5,4
8000864c:	fae42c23          	sw	a4,-72(s0)
80008650:	0007a783          	lw	a5,0(a5)
80008654:	fef42023          	sw	a5,-32(s0)
					int len=0;
80008658:	fc042e23          	sw	zero,-36(s0)
					for(int n=x;n/=10;len++);
8000865c:	fe042783          	lw	a5,-32(s0)
80008660:	fcf42c23          	sw	a5,-40(s0)
80008664:	0100006f          	j	80008674 <printf+0x114>
80008668:	fdc42783          	lw	a5,-36(s0)
8000866c:	00178793          	addi	a5,a5,1
80008670:	fcf42e23          	sw	a5,-36(s0)
80008674:	fd842703          	lw	a4,-40(s0)
80008678:	00a00793          	li	a5,10
8000867c:	02f747b3          	div	a5,a4,a5
80008680:	fcf42c23          	sw	a5,-40(s0)
80008684:	fd842783          	lw	a5,-40(s0)
80008688:	fe0790e3          	bnez	a5,80008668 <printf+0x108>
					for(int i=len;i>=0;i--){
8000868c:	fdc42783          	lw	a5,-36(s0)
80008690:	fcf42a23          	sw	a5,-44(s0)
80008694:	0540006f          	j	800086e8 <printf+0x188>
						outbuf[idx+i]='0'+(x%10);
80008698:	fe042703          	lw	a4,-32(s0)
8000869c:	00a00793          	li	a5,10
800086a0:	02f767b3          	rem	a5,a4,a5
800086a4:	0ff7f713          	andi	a4,a5,255
800086a8:	fe442683          	lw	a3,-28(s0)
800086ac:	fd442783          	lw	a5,-44(s0)
800086b0:	00f687b3          	add	a5,a3,a5
800086b4:	03070713          	addi	a4,a4,48 # 8000a030 <memend+0xf800a030>
800086b8:	0ff77713          	andi	a4,a4,255
800086bc:	8000a6b7          	lui	a3,0x8000a
800086c0:	00068693          	mv	a3,a3
800086c4:	00f687b3          	add	a5,a3,a5
800086c8:	00e78023          	sb	a4,0(a5)
						x/=10;
800086cc:	fe042703          	lw	a4,-32(s0)
800086d0:	00a00793          	li	a5,10
800086d4:	02f747b3          	div	a5,a4,a5
800086d8:	fef42023          	sw	a5,-32(s0)
					for(int i=len;i>=0;i--){
800086dc:	fd442783          	lw	a5,-44(s0)
800086e0:	fff78793          	addi	a5,a5,-1
800086e4:	fcf42a23          	sw	a5,-44(s0)
800086e8:	fd442783          	lw	a5,-44(s0)
800086ec:	fa07d6e3          	bgez	a5,80008698 <printf+0x138>
					}
					idx+=(len+1);
800086f0:	fdc42783          	lw	a5,-36(s0)
800086f4:	00178793          	addi	a5,a5,1
800086f8:	fe442703          	lw	a4,-28(s0)
800086fc:	00f707b3          	add	a5,a4,a5
80008700:	fef42223          	sw	a5,-28(s0)
					tt=0;
80008704:	fe042423          	sw	zero,-24(s0)
					break;
80008708:	1dc0006f          	j	800088e4 <printf+0x384>
				}
				case 'p':
				{
					outbuf[idx++]='0';
8000870c:	fe442783          	lw	a5,-28(s0)
80008710:	00178713          	addi	a4,a5,1
80008714:	fee42223          	sw	a4,-28(s0)
80008718:	8000a737          	lui	a4,0x8000a
8000871c:	00070713          	mv	a4,a4
80008720:	00f707b3          	add	a5,a4,a5
80008724:	03000713          	li	a4,48
80008728:	00e78023          	sb	a4,0(a5)
					outbuf[idx++]='x';
8000872c:	fe442783          	lw	a5,-28(s0)
80008730:	00178713          	addi	a4,a5,1
80008734:	fee42223          	sw	a4,-28(s0)
80008738:	8000a737          	lui	a4,0x8000a
8000873c:	00070713          	mv	a4,a4
80008740:	00f707b3          	add	a5,a4,a5
80008744:	07800713          	li	a4,120
80008748:	00e78023          	sb	a4,0(a5)
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
8000874c:	fb842783          	lw	a5,-72(s0)
80008750:	00478713          	addi	a4,a5,4
80008754:	fae42c23          	sw	a4,-72(s0)
80008758:	0007a783          	lw	a5,0(a5)
8000875c:	fcf42823          	sw	a5,-48(s0)
					int len=0;
80008760:	fc042623          	sw	zero,-52(s0)
					for(unsigned int n=x;n/=16;len++);
80008764:	fd042783          	lw	a5,-48(s0)
80008768:	fcf42423          	sw	a5,-56(s0)
8000876c:	0100006f          	j	8000877c <printf+0x21c>
80008770:	fcc42783          	lw	a5,-52(s0)
80008774:	00178793          	addi	a5,a5,1
80008778:	fcf42623          	sw	a5,-52(s0)
8000877c:	fc842783          	lw	a5,-56(s0)
80008780:	0047d793          	srli	a5,a5,0x4
80008784:	fcf42423          	sw	a5,-56(s0)
80008788:	fc842783          	lw	a5,-56(s0)
8000878c:	fe0792e3          	bnez	a5,80008770 <printf+0x210>
					for(int i=len;i>=0;i--){
80008790:	fcc42783          	lw	a5,-52(s0)
80008794:	fcf42223          	sw	a5,-60(s0)
80008798:	0840006f          	j	8000881c <printf+0x2bc>
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
8000879c:	fd042783          	lw	a5,-48(s0)
800087a0:	00f7f713          	andi	a4,a5,15
800087a4:	00900793          	li	a5,9
800087a8:	02e7f063          	bgeu	a5,a4,800087c8 <printf+0x268>
800087ac:	fd042783          	lw	a5,-48(s0)
800087b0:	0ff7f793          	andi	a5,a5,255
800087b4:	00f7f793          	andi	a5,a5,15
800087b8:	0ff7f793          	andi	a5,a5,255
800087bc:	05778793          	addi	a5,a5,87
800087c0:	0ff7f793          	andi	a5,a5,255
800087c4:	01c0006f          	j	800087e0 <printf+0x280>
800087c8:	fd042783          	lw	a5,-48(s0)
800087cc:	0ff7f793          	andi	a5,a5,255
800087d0:	00f7f793          	andi	a5,a5,15
800087d4:	0ff7f793          	andi	a5,a5,255
800087d8:	03078793          	addi	a5,a5,48
800087dc:	0ff7f793          	andi	a5,a5,255
800087e0:	faf40f23          	sb	a5,-66(s0)
						outbuf[idx+i]=c;
800087e4:	fe442703          	lw	a4,-28(s0)
800087e8:	fc442783          	lw	a5,-60(s0)
800087ec:	00f707b3          	add	a5,a4,a5
800087f0:	8000a737          	lui	a4,0x8000a
800087f4:	00070713          	mv	a4,a4
800087f8:	00f707b3          	add	a5,a4,a5
800087fc:	fbe44703          	lbu	a4,-66(s0)
80008800:	00e78023          	sb	a4,0(a5)
						x/=16;
80008804:	fd042783          	lw	a5,-48(s0)
80008808:	0047d793          	srli	a5,a5,0x4
8000880c:	fcf42823          	sw	a5,-48(s0)
					for(int i=len;i>=0;i--){
80008810:	fc442783          	lw	a5,-60(s0)
80008814:	fff78793          	addi	a5,a5,-1
80008818:	fcf42223          	sw	a5,-60(s0)
8000881c:	fc442783          	lw	a5,-60(s0)
80008820:	f607dee3          	bgez	a5,8000879c <printf+0x23c>
					}
					idx+=(len+1);
80008824:	fcc42783          	lw	a5,-52(s0)
80008828:	00178793          	addi	a5,a5,1
8000882c:	fe442703          	lw	a4,-28(s0)
80008830:	00f707b3          	add	a5,a4,a5
80008834:	fef42223          	sw	a5,-28(s0)
					tt=0;
80008838:	fe042423          	sw	zero,-24(s0)
					break;
8000883c:	0a80006f          	j	800088e4 <printf+0x384>
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
80008840:	fb842783          	lw	a5,-72(s0)
80008844:	00478713          	addi	a4,a5,4
80008848:	fae42c23          	sw	a4,-72(s0)
8000884c:	0007a783          	lw	a5,0(a5)
80008850:	faf40fa3          	sb	a5,-65(s0)
					outbuf[idx++]=ch;
80008854:	fe442783          	lw	a5,-28(s0)
80008858:	00178713          	addi	a4,a5,1
8000885c:	fee42223          	sw	a4,-28(s0)
80008860:	8000a737          	lui	a4,0x8000a
80008864:	00070713          	mv	a4,a4
80008868:	00f707b3          	add	a5,a4,a5
8000886c:	fbf44703          	lbu	a4,-65(s0)
80008870:	00e78023          	sb	a4,0(a5)
					tt=0;
80008874:	fe042423          	sw	zero,-24(s0)
					break;
80008878:	06c0006f          	j	800088e4 <printf+0x384>
				case 's':
				{
					char* ss=va_arg(vl,char*);
8000887c:	fb842783          	lw	a5,-72(s0)
80008880:	00478713          	addi	a4,a5,4
80008884:	fae42c23          	sw	a4,-72(s0)
80008888:	0007a783          	lw	a5,0(a5)
8000888c:	fcf42023          	sw	a5,-64(s0)
					while(*ss){
80008890:	0300006f          	j	800088c0 <printf+0x360>
						outbuf[idx++]=*ss++;
80008894:	fc042703          	lw	a4,-64(s0)
80008898:	00170793          	addi	a5,a4,1 # 8000a001 <memend+0xf800a001>
8000889c:	fcf42023          	sw	a5,-64(s0)
800088a0:	fe442783          	lw	a5,-28(s0)
800088a4:	00178693          	addi	a3,a5,1
800088a8:	fed42223          	sw	a3,-28(s0)
800088ac:	00074703          	lbu	a4,0(a4)
800088b0:	8000a6b7          	lui	a3,0x8000a
800088b4:	00068693          	mv	a3,a3
800088b8:	00f687b3          	add	a5,a3,a5
800088bc:	00e78023          	sb	a4,0(a5)
					while(*ss){
800088c0:	fc042783          	lw	a5,-64(s0)
800088c4:	0007c783          	lbu	a5,0(a5)
800088c8:	fc0796e3          	bnez	a5,80008894 <printf+0x334>
					}
					tt=0;
800088cc:	fe042423          	sw	zero,-24(s0)
					break;
800088d0:	0140006f          	j	800088e4 <printf+0x384>
				}
				default:
					panic("printf not this type!\n");
800088d4:	800097b7          	lui	a5,0x80009
800088d8:	04478513          	addi	a0,a5,68 # 80009044 <memend+0xf8009044>
800088dc:	c4dff0ef          	jal	ra,80008528 <panic>
					break;
800088e0:	00000013          	nop
				}
				s++;
800088e4:	fec42783          	lw	a5,-20(s0)
800088e8:	00178793          	addi	a5,a5,1
800088ec:	fef42623          	sw	a5,-20(s0)
800088f0:	0300006f          	j	80008920 <printf+0x3c0>
			}else{
				outbuf[idx++]=ch;
800088f4:	fe442783          	lw	a5,-28(s0)
800088f8:	00178713          	addi	a4,a5,1
800088fc:	fee42223          	sw	a4,-28(s0)
80008900:	8000a737          	lui	a4,0x8000a
80008904:	00070713          	mv	a4,a4
80008908:	00f707b3          	add	a5,a4,a5
8000890c:	fbf44703          	lbu	a4,-65(s0)
80008910:	00e78023          	sb	a4,0(a5)
				s++;
80008914:	fec42783          	lw	a5,-20(s0)
80008918:	00178793          	addi	a5,a5,1
8000891c:	fef42623          	sw	a5,-20(s0)
	while(ch=*(s)){
80008920:	fec42783          	lw	a5,-20(s0)
80008924:	0007c783          	lbu	a5,0(a5)
80008928:	faf40fa3          	sb	a5,-65(s0)
8000892c:	fbf44783          	lbu	a5,-65(s0)
80008930:	c80794e3          	bnez	a5,800085b8 <printf+0x58>
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
80008934:	8000a7b7          	lui	a5,0x8000a
80008938:	00078713          	mv	a4,a5
8000893c:	fe442783          	lw	a5,-28(s0)
80008940:	00f707b3          	add	a5,a4,a5
80008944:	00078023          	sb	zero,0(a5) # 8000a000 <memend+0xf800a000>
	uartputs(outbuf);
80008948:	8000a7b7          	lui	a5,0x8000a
8000894c:	00078513          	mv	a0,a5
80008950:	a19ff0ef          	jal	ra,80008368 <uartputs>
80008954:	00000013          	nop
80008958:	00078513          	mv	a0,a5
8000895c:	05c12083          	lw	ra,92(sp)
80008960:	05812403          	lw	s0,88(sp)
80008964:	08010113          	addi	sp,sp,128
80008968:	00008067          	ret

8000896c <memset>:
extern uint8 pstart[];
extern uint8 pend[];
extern uint8 memstart[];
extern uint8 memend[];

void* memset(void* addr,int c,uint n){
8000896c:	fd010113          	addi	sp,sp,-48
80008970:	02812623          	sw	s0,44(sp)
80008974:	03010413          	addi	s0,sp,48
80008978:	fca42e23          	sw	a0,-36(s0)
8000897c:	fcb42c23          	sw	a1,-40(s0)
80008980:	fcc42a23          	sw	a2,-44(s0)
    char* maddr=(char*)addr;
80008984:	fdc42783          	lw	a5,-36(s0)
80008988:	fef42423          	sw	a5,-24(s0)
    for(uint i=0;i<n;i++){
8000898c:	fe042623          	sw	zero,-20(s0)
80008990:	0280006f          	j	800089b8 <memset+0x4c>
        maddr[i]=(char)c;
80008994:	fe842703          	lw	a4,-24(s0)
80008998:	fec42783          	lw	a5,-20(s0)
8000899c:	00f707b3          	add	a5,a4,a5
800089a0:	fd842703          	lw	a4,-40(s0)
800089a4:	0ff77713          	andi	a4,a4,255
800089a8:	00e78023          	sb	a4,0(a5) # 8000a000 <memend+0xf800a000>
    for(uint i=0;i<n;i++){
800089ac:	fec42783          	lw	a5,-20(s0)
800089b0:	00178793          	addi	a5,a5,1
800089b4:	fef42623          	sw	a5,-20(s0)
800089b8:	fec42703          	lw	a4,-20(s0)
800089bc:	fd442783          	lw	a5,-44(s0)
800089c0:	fcf76ae3          	bltu	a4,a5,80008994 <memset+0x28>
    }
    return addr;
800089c4:	fdc42783          	lw	a5,-36(s0)
}
800089c8:	00078513          	mv	a0,a5
800089cc:	02c12403          	lw	s0,44(sp)
800089d0:	03010113          	addi	sp,sp,48
800089d4:	00008067          	ret

800089d8 <minit>:

void minit(){
800089d8:	fe010113          	addi	sp,sp,-32
800089dc:	00812e23          	sw	s0,28(sp)
800089e0:	02010413          	addi	s0,sp,32
    // uint32* te=textend;
    // uint32* re=rodataend;
    // uint32* de=dataend;
    // uint32* be=bssend;
    // uint8* me=memend;
    char* p=(char*)pstart;
800089e4:	8000b7b7          	lui	a5,0x8000b
800089e8:	00078793          	mv	a5,a5
800089ec:	fef42623          	sw	a5,-20(s0)
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)pend ; p+=PGSIZE){
800089f0:	0380006f          	j	80008a28 <minit+0x50>
        m=(struct pmp*)p;
800089f4:	fec42783          	lw	a5,-20(s0)
800089f8:	fef42423          	sw	a5,-24(s0)
        m->next=mem.freelist;
800089fc:	8000a7b7          	lui	a5,0x8000a
80008a00:	4007a703          	lw	a4,1024(a5) # 8000a400 <memend+0xf800a400>
80008a04:	fe842783          	lw	a5,-24(s0)
80008a08:	00e7a023          	sw	a4,0(a5)
        mem.freelist=m;
80008a0c:	8000a7b7          	lui	a5,0x8000a
80008a10:	fe842703          	lw	a4,-24(s0)
80008a14:	40e7a023          	sw	a4,1024(a5) # 8000a400 <memend+0xf800a400>
    for( ; p + PGSIZE <= (char*)pend ; p+=PGSIZE){
80008a18:	fec42703          	lw	a4,-20(s0)
80008a1c:	000017b7          	lui	a5,0x1
80008a20:	00f707b3          	add	a5,a4,a5
80008a24:	fef42623          	sw	a5,-20(s0)
80008a28:	fec42703          	lw	a4,-20(s0)
80008a2c:	000017b7          	lui	a5,0x1
80008a30:	00f70733          	add	a4,a4,a5
80008a34:	880007b7          	lui	a5,0x88000
80008a38:	00078793          	mv	a5,a5
80008a3c:	fae7fce3          	bgeu	a5,a4,800089f4 <minit+0x1c>
    }
}
80008a40:	00000013          	nop
80008a44:	00000013          	nop
80008a48:	01c12403          	lw	s0,28(sp)
80008a4c:	02010113          	addi	sp,sp,32
80008a50:	00008067          	ret

80008a54 <palloc>:

void* palloc(){
80008a54:	fe010113          	addi	sp,sp,-32
80008a58:	00112e23          	sw	ra,28(sp)
80008a5c:	00812c23          	sw	s0,24(sp)
80008a60:	02010413          	addi	s0,sp,32
    struct pmp* p=(struct pmp*)mem.freelist;
80008a64:	8000a7b7          	lui	a5,0x8000a
80008a68:	4007a783          	lw	a5,1024(a5) # 8000a400 <memend+0xf800a400>
80008a6c:	fef42623          	sw	a5,-20(s0)
    if(p)
80008a70:	fec42783          	lw	a5,-20(s0)
80008a74:	00078c63          	beqz	a5,80008a8c <palloc+0x38>
        mem.freelist=mem.freelist->next;
80008a78:	8000a7b7          	lui	a5,0x8000a
80008a7c:	4007a783          	lw	a5,1024(a5) # 8000a400 <memend+0xf800a400>
80008a80:	0007a703          	lw	a4,0(a5)
80008a84:	8000a7b7          	lui	a5,0x8000a
80008a88:	40e7a023          	sw	a4,1024(a5) # 8000a400 <memend+0xf800a400>
    if(p)
80008a8c:	fec42783          	lw	a5,-20(s0)
80008a90:	00078a63          	beqz	a5,80008aa4 <palloc+0x50>
        memset(p,0,PGSIZE);
80008a94:	00001637          	lui	a2,0x1
80008a98:	00000593          	li	a1,0
80008a9c:	fec42503          	lw	a0,-20(s0)
80008aa0:	ecdff0ef          	jal	ra,8000896c <memset>
    return (void*)p;
80008aa4:	fec42783          	lw	a5,-20(s0)
}
80008aa8:	00078513          	mv	a0,a5
80008aac:	01c12083          	lw	ra,28(sp)
80008ab0:	01812403          	lw	s0,24(sp)
80008ab4:	02010113          	addi	sp,sp,32
80008ab8:	00008067          	ret

80008abc <pfree>:

void pfree(void* addr){
80008abc:	fd010113          	addi	sp,sp,-48
80008ac0:	02812623          	sw	s0,44(sp)
80008ac4:	03010413          	addi	s0,sp,48
80008ac8:	fca42e23          	sw	a0,-36(s0)
    struct pmp* p=(struct pmp*)addr;
80008acc:	fdc42783          	lw	a5,-36(s0)
80008ad0:	fef42623          	sw	a5,-20(s0)
    p->next=mem.freelist;
80008ad4:	8000a7b7          	lui	a5,0x8000a
80008ad8:	4007a703          	lw	a4,1024(a5) # 8000a400 <memend+0xf800a400>
80008adc:	fec42783          	lw	a5,-20(s0)
80008ae0:	00e7a023          	sw	a4,0(a5)
    mem.freelist=p;
80008ae4:	8000a7b7          	lui	a5,0x8000a
80008ae8:	fec42703          	lw	a4,-20(s0)
80008aec:	40e7a023          	sw	a4,1024(a5) # 8000a400 <memend+0xf800a400>
80008af0:	00000013          	nop
80008af4:	02c12403          	lw	s0,44(sp)
80008af8:	03010113          	addi	sp,sp,48
80008afc:	00008067          	ret
