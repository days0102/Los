/*
 * @Author: Outsider
 * @Date: 2022-08-17 10:12:49
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-18 16:52:52
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/file.h
 */
#include "types.h"
#include "defs.h"

#ifndef FILE
#define FILE

#define O_RDONLY 0x000
#define O_WRONLY 0x001
#define O_RDWR 0x002
#define O_CREAT 0x100
#define O_TRUNC 0x1000

#define NFILE 16

enum filetype
{
    FT_INODE,
    FT_DEVICE,
    FT_NONE
};

struct file
{
    int fd;
    uint ref;
    enum filetype type;
    struct inode *inode; // TD_INODE
    uint offset;
};

#endif