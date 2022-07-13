/*
 * @Author: Outsider
 * @Date: 2022-07-12 09:17:23
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-13 20:31:24
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/defs.h
 */

#include "types.h"
#include "swtch.h"

// uart.c
void uartinit();
char uartputc(char c);
void uartputs(char*);

// swtch.c
struct context;
void swtch(struct context*,struct context*);

void kvec();

// 
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