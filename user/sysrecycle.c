/*
 * @Author       : Outsider
 * @Date         : 2022-08-22 15:31:13
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-05-27 12:29:39
 * @Description  : In User Settings Edit
 * @FilePath     : /los/user/sysrecycle.c
 */
#include "user.h"

int main()
{
    while (1)
    {
        write(1, "hello", 5);
        printf("system recycle %d\n", recycle());
        yeid();
    }
}