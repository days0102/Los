/*
 * @Author: Outsider
 * @Date: 2022-07-12 09:17:23
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-01 16:36:27
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/defs.h
 */

#include "types.h"

// uart.c
void uartinit();
char uartputc(char c);
void uartputs(char*);
void uartgetc();
char uartintr();

// kvec.S
void    kvec();
void    tvec();

// printf.c
void    panic(char*);
int     printf(const char*,...);

// trap.c
void    trapvec();

// pmm.c
void    minit();
void*   palloc();
void    pfree(void*);

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
void    plicinit();
uint32  r_plicclaim();
void    w_pliccomplete(uint32);

// vm.c 
void    kvminit();
addr_t* pgtcreate();
void    vmmap(addr_t* pgt,addr_t va,addr_t pa,uint sz,uint mode);
void    mkstack(addr_t* pgt);

// proc.h
struct pcb;
// proc.c
void    procinit();
void    userinit();
struct pcb* nowproc();
void    schedule();

// string.c
void*   memset(void*,int,uint);
void*   memmove(void* dst,const void* src,size_t n);
size_t  strlen(const char* s);

// swtch.S
struct context;
void    swtch(struct context* old,struct context* new);

// proc.h
struct trapframe;
// usertrap.S
void    userret(struct trapframe*,addr_t pgt);
extern char usertrap[];
extern char uservec[];

// clint.c
void    clintinit();

// time.c
void    timerinit();