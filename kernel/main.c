/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-26 09:53:41
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"

void main(){
    printf("start run main()\n");

    minit();        // 物理内存管理
    plicinit();     // PLIC 中断处理
    
    kvminit();       // 启动虚拟内存

    printf("usertrap: %p\n",usertrap);

    userinit();
    asm volatile("ecall");

    printf("----------------------\n");
    while(1);
}

