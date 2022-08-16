/*
 * @Author: Outsider
 * @Date: 2022-08-05 08:47:03
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-15 20:40:06
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