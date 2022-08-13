/*
 * @Author: Outsider
 * @Date: 2022-08-10 17:35:51
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-13 13:58:29
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/buf.c
 */
#include "types.h"
#include "buf.h"
#include "defs.h"

#define BCLEN 10

struct buf bcache;
struct buf buf[BCLEN];

void bufinit()
{
    struct buf *b;
    bcache.prev = bcache.next = &bcache;
    for (b = buf; b < &buf[BCLEN]; b++)
    {
        b->prev = &bcache;
        b->next = bcache.next;
        bcache.next->prev = b;
        bcache.next = b;
        b->ref = 0;
        b->vaild = 0;
    }
}

#define BUFWRIE 1 // buf write into disk
#define BUFREAD 0 // buf read from disk
void bufwrite(struct buf *b)
{
    diskrw(b, BUFWRIE);
}
void bufread(struct buf *b)
{
    diskrw(b, BUFREAD);
}

struct buf *bufget(int bno)
{
    struct buf *b = bcache.next;
    while (b != &bcache)
    {
        if (b->bno == bno && b->vaild == 1)
        {
            b->ref++;
            return b;
        }
        b = b->next;
    }
    if (b == &bcache)
    {
        b = bcache.prev;
        while (b->ref != 0) //! b==&bcache
        {
            b = b->prev;
        }
        if (b->vaild == 1)
            bufwrite(b); //# 不一定要写(如果数据没修改)
        b->bno = bno;
        bufread(b);
        b->ref = 1;
        return b;
    }
    return 0;
}