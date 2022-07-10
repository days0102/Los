/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-10 23:14:47
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "uart.h"
#include "swtch.h"

void main(){
    uartputs("Start run main()\n");
    struct context old;
    struct context new;
    swtch(&old,&new);
    
    swtch(&new,&old);
    
}