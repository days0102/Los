/*
 * @Author: Outsider
 * @Date: 2022-08-17 10:12:49
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-17 16:40:06
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/file.h
 */
#include "types.h"
#include "defs.h"

#ifndef FILE
#define FILE

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