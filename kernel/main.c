/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-16 14:19:37
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"

void main(){
    printf("start run main()\n");

    minit();        // 物理内存管理
    plicinit();     // PLIC 中断处理
    vminit();       // 启动虚拟内存
    
    printf("-----------");
    while(1);
}