/*
 * @Author: Outsider
 * @Date: 2022-08-15 11:27:46
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-20 07:51:06
 * @Description: In User Settings Edit
 * @FilePath: /los/user/sh.c
 */
#include "user.h"

int main()
{
    printf("start run sh\n");
    char buf[23];
    read(0, buf, 5);
    printf("%s\n", buf);
    while (1)
        ;
}