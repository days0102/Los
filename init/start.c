/*
 * @Author: Outsider
 * @Date: 2022-07-08 10:52:32
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-08 19:22:56
 * @Description: In User Settings Edit
 * @FilePath: /los/init/start.c
 */
#include "../kernel/uart.h"

void start(){
    uartinit();
    uartputs("Hello!");
    while(1);
}