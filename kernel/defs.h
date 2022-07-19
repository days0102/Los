/*
 * @Author: Outsider
 * @Date: 2022-07-12 09:17:23
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-19 16:54:00
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
void    vminit();

// proc.c
void    procinit();

// string.c
void*   memset(void*,int,uint);
void*   memmove(void* dst,const void* src,size_t n);
size_t  strlen(const char* s);