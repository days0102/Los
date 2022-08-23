/*
 * @Author: Outsider
 * @Date: 2022-08-10 17:35:51
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-23 13:32:44
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
void bufio(struct buf *b, int write)
{
    if (write)
        diskrw(b, BUFWRIE);
    else
        diskrw(b, BUFREAD);
}
void bufwrite(struct buf *b)
{
    diskrw(b, BUFWRIE);
}
void bufread(struct buf *b)
{
    diskrw(b, BUFREAD);
}

struct buf *bget(int bno)
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
            bufio(b, 1); //# 不一定要写(如果数据没修改)
        b->bno = bno;
        bufio(b, 0);
        b->vaild = 1;
        b->ref = 1;
        return b;
    }
    return 0;
}

void brelse(struct buf *b)
{
    if (b == 0)
        panic("relse null buffer");
    if (b->vaild == 0)
        panic("relse invaild buffer");
    b->ref--;
    if (b->dirty == 1)
        bufio(b, 1);
    b->dirty = 0;
}

uint bufauto()
{
    struct buf *b = bcache.next;
    int cnt = 0;
    while (b != &bcache)
    {
        if (b->vaild == 1 && b->dirty == 1)
        {
            bufwrite(b);
            bufread(b);
            b->dirty = 0;
            cnt++;
        }
        b = b->next;
    }
    return cnt;
}