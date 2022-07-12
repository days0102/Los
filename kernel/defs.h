/*
 * @Author: Outsider
 * @Date: 2022-07-12 09:17:23
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-12 12:01:29
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/defs.h
 */
// uart.c
void uartinit();
char uartputc(char c);
void uartputs(char*);

// swtch.c
struct context;
void swtch(struct context*,struct context*);

// printf.c
void panic(char*);

// trap.c
void tvec();

// pmm.c
void minit();
void* palloc();
void pfree(void*);