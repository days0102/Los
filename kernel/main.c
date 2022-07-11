/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-11 08:50:01
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "uart.h"
#include "swtch.h"
#include "riscv.h"

void main(){
    uartputs("start run main()\n");
    struct context old;
    struct context new;
    swtch(&old,&new);

    swtch(&new,&old);
    while(1);
}