/*
 * @Author: Outsider
 * @Date: 2022-07-12 09:17:23
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-12 14:52:49
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/defs.h
 */

#include "types.h"

// proc.h
struct pcb;
struct trapframe;

// swtch.S
struct context;

// buf.h
struct buf;

// uart.c
void uartinit();
char uartputc(char c);
void uartputs(char *s);
void uartgetc();
char uartintr();

// kvec.S
void kvec();
void tvec();

// printf.c
void panic(char *str);
int printf(const char *fmt, ...);
char *sprintf(char *str, const char *fmt, ...);
void assertfail(const char *__assertion, const char *__file,
                unsigned int __line, const char *__function);
void printferror(const char *__errmsg, const char *__file,
                unsigned int __line, const char *__function);

#define assert(expr) (expr) ? 0: assertfail(#expr, __FILE__, __LINE__, __FUNCTION__)
#define error(msg) printferror(#msg, __FILE__, __LINE__, __FUNCTION__)

// trap.c
void trapvec();
void usertrapret();

// pmm.c
void minit();
void *palloc();
void pfree(void *pa);

// kernel.ld
extern uint8 textstart[];
extern uint8 textend[];
extern uint8 rodatastart[];
extern uint8 rodataend[];
extern uint8 datastart[];
extern uint8 dataend[];
extern uint8 bssstart[];
extern uint8 bssend[];
extern uint8 mstart[];
extern uint8 mend[];
extern uint8 memstart[];
extern uint8 memend[];

// entry.S
extern uint stacks[];

// plic.c
void plicinit();
uint32 r_plicclaim();
void w_pliccomplete(uint32 irq);

// vm.c
void kvminit();
addr_t *pgtcreate();
void vmmap(addr_t *pgt, addr_t va, addr_t pa, uint sz, uint mode);
void mkstack(addr_t *pgt);

// proc.c
void procinit();
void userinit();
struct pcb *nowproc();
void schedule();
void yield();
void sched();

// string.c
void *memset(void *, int, uint);
void *memmove(void *dst, const void *src, size_t n);
size_t strlen(const char *s);

void swtch(struct context *old, struct context *new);

// usertrap.S
void userret(addr_t *tf, addr_t pgt);
extern char usertrap[];
extern char uservec[];

// clint.c
void clintinit();

// time.c
void timerinit();

// syscall.c
void syscall();

// mmio.c
void mmioinit();
void diskrw(struct buf *buf, uint8 rw);
void diskintr();

// buf.c
void bufinit(void);
struct buf *bufget(int bno);