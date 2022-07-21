/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-20 20:17:12
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "proc.h"

void main(){
    printf("start run main()\n");

    minit();        // 物理内存管理
    plicinit();     // PLIC 中断处理
    vminit();       // 启动虚拟内存

    procinit();
    
    // char* va=(char*)0xc0002000;
    // printf("%c\n",*va);
    // *va=10;
    // *(int *)0x00000000 = 100;
    for(int i=0;i<NPROC;i++){
        struct pcb* p=&proc[i];
        printf("%p ",p->kernelstack);
    }
    printf("----------------------\n");
    asm volatile("ecall");
    asm volatile("ecall");
    while(1);
}