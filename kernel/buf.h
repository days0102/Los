/*
 * @Author: Outsider
 * @Date: 2022-08-10 17:28:02
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-10 21:12:25
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/buf.h
 */
#include "types.h"

#define BSIZE 1024

// disk IO buffer
struct buf
{
    /* data */
    int vaild;         // is buffer vaild ?
    int bno;           // disk block num
    uint8 ref;         // buf ref count
    uint8 data[BSIZE]; // disk block data;
    struct buf *prev;  // prev pointer
    struct buf *next;  // next pointer
};
