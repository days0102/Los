/*
 * @Author: Outsider
 * @Date: 2022-07-12 09:17:23
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-15 10:05:33
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/defs.h
 */

#include "types.h"
#include "swtch.h"

// uart.c
void uartinit();
char uartputc(char c);
void uartputs(char*);
void uartgetc();
char uartintr();

// swtch.c
struct context;
void swtch(struct context*,struct context*);

// kvec.S
void kvec();

// switch.c
void cswap(struct context*,struct context* );

// printf.c
void panic(char*);
int printf(const char*,...);

// trap.c
void trapvec();

// pmm.c
void minit();
void* memset(void*,int,uint);
void* palloc();
void pfree(void*);

// plic.c
void plicinit();
uint32 r_plicclaim();
void w_pliccomplete(uint32);