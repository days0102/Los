/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:42:08
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-12 09:24:40
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/printf.c
 */
#include "defs.h"

void panic(char* s){
    uartputs("panic: ");
    uartputs(s);
    while(1);
}