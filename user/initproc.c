/*
 * @Author       : Outsider
 * @Date         : 2022-08-03 16:37:00
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-07-31 12:37:21
 * @Description  : In User Settings Edit
 * @FilePath     : /los/user/initproc.c
 */

#include "user/user.h"

int main()
{
    int fd;
    while ((fd = open("console", O_RDWR)) < 0)
        mknod("console", 1, 0);
    dup(fd);
    dup(fd);
    int pid = fork();
    if (pid == 0)
    {
        exec("sh");
        printf("exec sh fail!\n");
    }
    else
    {
        exec("sysrecycle");
        printf("exec sysrecycle fail!\n");
    }
    while (1)
        ;
}