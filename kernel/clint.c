/*
 * @Author: Outsider
 * @Date: 2022-07-23 08:06:32
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-06 18:40:26
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/clint.c
 */
#include "clint.h"
#include "riscv.h"

void clintinit()
{
    // 初始化 mtimecmp
    int hart = r_tp();
    *(reg_t *)CLINT_MTIMECMP(hart) = *(reg_t *)CLINT_MTIMECMP(hart) + CLINT_INTERVAL;
}