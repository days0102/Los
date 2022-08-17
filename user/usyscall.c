/*
 * @Author: Outsider
 * @Date: 2022-08-05 08:47:03
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-17 14:20:14
 * @Description: In User Settings Edit
 * @FilePath: /los/user/usyscall.c
 */
#include "kernel/types.h"

int exec(char* path)
{
    asm volatile("li a7,1");
    asm volatile("ecall");
    uint32 x;
    asm volatile("mv %0,a0"
                 : "=r"(x));
    return x;
}

int fork()
{
    asm volatile("li a7,2");
    asm volatile("ecall");
    uint32 x;
    asm volatile("mv %0,a0"
                 : "=r"(x));
    return x;
}

int open(char* path,int mode)
{
    asm volatile("li a7,3");
    asm volatile("ecall");
    uint32 x;
    asm volatile("mv %0,a0"
                 : "=r"(x));
    return x;
}