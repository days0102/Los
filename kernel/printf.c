/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:42:08
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-11 10:42:19
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/printf.c
 */
#include "uart.h"

void panic(char* s){
    uartputs("panic: ");
    uartputs(s);
    while(1);
}