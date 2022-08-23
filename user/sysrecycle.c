/*
 * @Author: Outsider
 * @Date: 2022-08-22 15:31:13
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-22 15:31:22
 * @Description: In User Settings Edit
 * @FilePath: /los/user/sysrecycle.c
 */
#include "user.h"

int main()
{
    while (1)
    {
        printf("system recycle %d\n", recycle());
        yeid();
    }
}