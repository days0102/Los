/*
 * @Author       : Outsider
 * @Date         : 2023-08-05 15:12:07
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-08-05 19:45:35
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/buddy.h
 */
#include "types.h"

#define BUDDY_MAX_ORDER 12

struct page
{
    int order;
    struct page *prev;
    struct page *next;
};

struct
{
    /* data */
    struct page free_list[BUDDY_MAX_ORDER];
} buddy;