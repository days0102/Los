/*
 * @Author       : Outsider
 * @Date         : 2023-08-05 15:12:07
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-10-14 11:29:29
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/buddy.h
 */
#include "types.h"
#include "lock.h"

#define BUDDY_MAX_ORDER 12

#define PALIGN_UP(x, align) ((x + (align - 1)) & ~(align - 1))

struct page
{
    int order;
    void *addr;
    struct page *prev;
    struct page *next;
};

struct
{
    /* data */
    struct page free_list[BUDDY_MAX_ORDER];
    struct spinlock locks[BUDDY_MAX_ORDER];
    struct spinlock lock;
} buddy;