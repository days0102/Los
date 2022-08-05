/*
 * @Author: Outsider
 * @Date: 2022-08-05 08:47:03
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-05 11:54:56
 * @Description: In User Settings Edit
 * @FilePath: /los/user/sys.c
 */
#include "kernel/types.h"

int fork(){
    asm volatile("li a7,1");
    asm volatile("ecall");
    uint32 x;
    asm volatile("mv %0,a0":"=r"(x));
    return x;
}