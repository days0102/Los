/*
 * @Author: Outsider
 * @Date: 2022-08-24 21:07:06
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-24 21:22:29
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/lock.h
 */
#include "types.h"

struct spinlock
{
    uint locked;

    char *name;
    struct cpu *cpu;
};