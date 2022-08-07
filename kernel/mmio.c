/*
 * @Author: Outsider
 * @Date: 2022-08-07 15:58:24
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-07 16:01:30
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/mmio.c
 */
#include "types.h"
#include "defs.h"
#include "mmio.h"

void mmioinit()
{
    printf("%x\n",mmio_read(MMIO_MagicValue));
}