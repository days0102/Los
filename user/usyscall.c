/*
 * @Author: Outsider
 * @Date: 2022-08-05 08:47:03
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-19 17:17:49
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

int mknod(char* path,int major,int minor)
{
    asm volatile("li a7,4");
    asm volatile("ecall");
    uint32 x;
    asm volatile("mv %0,a0"
                 : "=r"(x));
    return x;
}

int dup(int fd)
{
    asm volatile("li a7,5");
    asm volatile("ecall");
    uint32 x;
    asm volatile("mv %0,a0"
                 : "=r"(x));
    return x;
}

int write(int fd,char* src,int size)
{
    asm volatile("li a7,6");
    asm volatile("ecall");
    uint32 x;
    asm volatile("mv %0,a0"
                 : "=r"(x));
    return x;
}

int read(int fd,char* dst,int size)
{
    asm volatile("li a7,7");
    asm volatile("ecall");
    uint32 x;
    asm volatile("mv %0,a0"
                 : "=r"(x));
    return x;
}