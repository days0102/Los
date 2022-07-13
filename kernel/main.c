/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-13 20:18:40
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"

void main(){
    printf("start run main()\n");
    
    minit();

    *(int *)0x00000000 = 100;

    printf("~\n");
    while(1);
}