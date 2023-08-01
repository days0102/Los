/*
 * @Author       : Outsider
 * @Date         : 2023-08-01 10:58:08
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-08-01 11:20:46
 * @Description  : In User Settings Edit
 * @FilePath     : /los/user/mem_test.c
 */

#include "user.h"

int main()
{
    for (int i = 0; i < 10000; i++)
    {
        int ret = fork();
        if (ret == 0)
        {
            printf("%d\n", i);
            exit(0);
        }
        wait(0);
    }
    exit(0);

    return 0;
}