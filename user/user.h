/*
 * @Author: Outsider
 * @Date: 2022-08-04 21:45:34
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-17 14:28:54
 * @Description: In User Settings Edit
 * @FilePath: /los/user/user.h
 */
#include "kernel/types.h"

// syscall
int fork();
int exec(char *path);
int open(char* path,int mode);