/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:39:43
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-12 09:24:13
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/trap.c
 */
#include "defs.h"

void tvec(){
    uartputs("exception or interrupt\n");
    panic(0);
}
