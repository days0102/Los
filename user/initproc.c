/*
 * @Author: Outsider
 * @Date: 2022-08-03 16:37:00
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-19 17:10:52
 * @Description: In User Settings Edit
 * @FilePath: /los/user/initproc.c
 */
#include "user/user.h"

int main()
{
    int pid = fork();
    if (pid == 0)
    {
        int fd;
        while ((fd = open("console", O_RDWR)) < 0)
            mknod("console", 1, 0);
        dup(fd);
        dup(fd);
        exec("sh");
    }
    else
        while (1)
            ;

    while (1)
        ;
}