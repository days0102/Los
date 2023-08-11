/*
 * @Author       : Outsider
 * @Date         : 2022-08-10 17:28:02
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-08-08 20:45:37
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/buf.h
 */

#include "types.h"

#define BSIZE 1024

// disk IO buffer
struct buf
{
    // int vaild;         // is buffer vaild ?
    int bno;           // disk block num
    uint8 dirty;       // buffer modify ?
    uint8 ref;         // buf ref count
    uint8 disk;        // read ?
    uint8 data[BSIZE]; // disk block data;
    struct buf *prev;  // prev pointer
    struct buf *next;  // next pointer
};

#define BUF_INTERVAL 100
int buf_init;
uint64 buf_time;
uint64 buf_interval;