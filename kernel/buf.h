/*
 * @Author: Outsider
 * @Date: 2022-08-10 17:28:02
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-23 13:26:02
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/buf.h
 */
#include "types.h"

#define BSIZE 1024

// disk IO buffer
struct buf
{
    int vaild;         // is buffer vaild ?
    int dirty;         // buffer modify ?
    int bno;           // disk block num
    uint8 ref;         // buf ref count
    uint8 data[BSIZE]; // disk block data;
    struct buf *prev;  // prev pointer
    struct buf *next;  // next pointer
};
