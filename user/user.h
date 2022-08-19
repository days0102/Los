/*
 * @Author: Outsider
 * @Date: 2022-08-04 21:45:34
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-18 18:43:15
 * @Description: In User Settings Edit
 * @FilePath: /los/user/user.h
 */
#include "kernel/types.h"

// file.h
#define O_RDONLY 0x000
#define O_WRONLY 0x001
#define O_RDWR 0x002
#define O_CREAT 0x100
#define O_TRUNC 0x1000

// syscall
int fork();
int exec(char *path);
int open(char* path,int mode);
int mknod(char* path,int major,int minor);