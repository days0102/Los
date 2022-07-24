/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-23 13:57:42
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"
void task(){
    int  j=5;
    while(j--){
        int i=100000000;
        while(i--);
        printf("tesk\n");
    }
}
void main(){
    printf("start run main()\n");

    minit();        // 物理内存管理
    plicinit();     // PLIC 中断处理
    
    kvminit();       // 启动虚拟内存


    // procinit();
    
    // char* va=(char*)0xc0002000;
    // printf("%c\n",*va);
    // *va=10;
    // *(int *)0x00000000 = 100;
   
    // struct context old;
    // struct context new;
    // new.ra=(reg_t)task;
    // new.sp=r_sp();
    // // swtch(&old,&new);

    // userinit();
    // asm volatile("ecall");
    printf("----------------------\n");
    while(1);
}

