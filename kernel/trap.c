/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:39:43
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-13 14:11:29
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/trap.c
 */
#include "defs.h"

void trapvec(){
    uartputs("exception or interrupt\n");
    panic(0);
}
