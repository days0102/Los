/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-14 15:46:29
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"

void main(){
    printf("start run main()\n");
    
    minit();
    plicinit();

    printf("%d",a_sstatus_intr(INTR_SIE));
    printf("~\n");
    while(1);
}