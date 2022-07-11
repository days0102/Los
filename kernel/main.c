/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-11 17:15:50
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "uart.h"
#include "swtch.h"
#include "riscv.h"

extern void tvec();

void main(){
    uartputs("start run main()\n");
    struct context old;
    struct context new;
    swtch(&old,&new);
    w_stvec((uint32)tvec);
    // uint32 x=r_mstatus();

    swtch(&new,&old);
    while(1);
}