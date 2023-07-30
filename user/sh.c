/*
 * @Author       : Outsider
 * @Date         : 2022-08-15 11:27:46
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-06-27 21:07:09
 * @Description  : In User Settings Edit
 * @FilePath     : /los/user/sh.c
 */
#include "user.h"

#define MAXCMD 16

int getcmd(char *buf, int maxx)
{
    char *b = (char *)buf;
    printf("los:$ ");
    while (read(0, b, 1))
    {
        if (*b == '\n' || (b - buf) >= maxx)
            break;
        b++;
    }
    *(++b) = 0;
    return (b - buf);
}

void main()
{
    printf("start run sh\n");
    char cmd[16];
    while (getcmd(cmd, MAXCMD))
    {
        // printf("cmd :%s", cmd);

        int pid = fork();
        if (pid == 0)
        {
            // printf("exec\n");
            exec(cmd);
            // if (exec(cmd) < 0)
            // {
            //     printf("run %s fail\n", cmd);
            printf("exec fail\n");
            exit(0);
            // }
        }
        // printf("dd");
        // wait(0);
    }
}