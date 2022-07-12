/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-12 22:55:16
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"

void main(){
    uartputs("start run main()\n");
    
    minit();

    void* addr=palloc();

    printf("%d %p %s %c\n",225555560,addr,"hello",'c');
    while(1);
}