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
    }
    buf_interval = BUF_INTERVAL;
    buf_time = 0;
    buf_init = 1; // concurent
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
    if (bno == 0)
    {
        panic("buffer get 0 block(boot)");
    }
    // Add LRU replace
    struct buf *b = bcache.next;
    while (b != &bcache)
    {
        if (b->bno == bno)
        {
            b->ref++;

            b->prev->next = b->next;
            b->next->prev = b->prev;

            b->next = bcache.next;
            b->prev = &bcache;
            b->next->prev = b;
            bcache.next = b;

            return b;
        }
        b = b->next;
    }
    b = bcache.prev;
    while (b != &bcache)
    {
        if (b->ref == 0)
        {
            b->ref = 1; // [fixed] 先引用，避免被引用时又被其它进程引用
            if (b->dirty == 1)
                bufio(b, 1);
            b->bno = bno;
            b->dirty = 0;
            bufio(b, 0);

            b->prev->next = b->next;
            b->next->prev = b->prev;

            b->next = bcache.next;
            b->prev = &bcache;
            b->next->prev = b;
            bcache.next = b;

            return b;
        }
    }
    return 0;
}

void brelse(struct buf *b)
{
    if (b == 0)
        panic("relse null buffer");
    if (b->ref == 0)
        panic("relse invaild buffer");
    b->ref--;
    // if (b->dirty == 1)
    //     bufio(b, 1);
    // b->dirty = 0;
}

uint bufauto()
{
    struct buf *b = bcache.next;
    int cnt = 0;
    while (b != &bcache)
    {
        if (b->dirty == 1)
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

void buftime()
{
    if (buf_init && clock_tick - buf_time > buf_interval)
    {
        struct buf *b = bcache.next;
        while (b != &bcache)
        {
            if (b->dirty == 1)
            {
                bufio(b, 1);
                b->dirty = 0;
                printf("b write %d bno\n", b->bno);
            }
            b = b->next;
        }
        buf_time = clock_tick;
    }
}