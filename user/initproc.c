/*
 * @Author: Outsider
 * @Date: 2022-08-03 16:37:00
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-16 09:13:31
 * @Description: In User Settings Edit
 * @FilePath: /los/user/initproc.c
 */
#include "user/user.h"

int main()
{
    int pid = fork();
    if (pid == 0)
        exec("sh");
    else
        while (1)
            ;

    while (1)
        ;
}