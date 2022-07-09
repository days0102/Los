/*
 * @Author: Outsider
 * @Date: 2022-07-08 10:52:32
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-09 08:52:26
 * @Description: In User Settings Edit
 * @FilePath: /los/init/start.c
 */
#include "kernel/uart.h"

extern char* end[];

void start(){
    uartinit();
    uartputs("Hello Los!\n");
    uartputs((char*)end);
    while(1);
}