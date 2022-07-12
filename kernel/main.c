/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-12 12:01:39
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"

void main(){
    uartputs("start run main()\n");
    
    w_stvec((uint32)tvec);

    minit();

    void* addr=palloc();
    pfree(addr);

    while(1);
}