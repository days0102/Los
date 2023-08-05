/*
 * @Author       : Outsider
 * @Date         : 2023-08-05 15:15:45
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-08-05 20:19:31
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/buddy.c
 */
#include "defs.h"
#include "vm.h"
#include "buddy.h"

void buddy_merge(struct page *page, int order)
{
    page->order = order + 1;
    buddy_free(page, page->order, 1);
}

void buddy_free(void *addr, int order, int merge)
{
    struct page *page = (struct page *)addr;
    struct page *head = &buddy.free_list[order];
    struct page *p = head->next;
    while (p != head && p < page)
    {
        p = p->next;
    }

    page->next = p;
    page->prev = p->prev;
    p->prev->next = page;
    p->prev = page;

    page->order = order;

    if (merge && order + 1 < BUDDY_MAX_ORDER)
    {
        char *prev = (char *)page->prev;
        char *next = (char *)page->next;

        if (prev + ((1 << order) * PGSIZE) == (char *)page)
        {
            page->prev->prev->next = page->next;
            page->next->prev = page->prev->prev;
            buddy_merge(page->prev, order);
        }
        else if ((char *)page + ((1 << order) * PGSIZE) == next)
        {
            buddy_merge(page, order);
        }
    }
}

void buddy_init()
{
    for (uint i = 0; i < BUDDY_MAX_ORDER; i++)
    {
        buddy.free_list[i].next = buddy.free_list[i].prev = &buddy.free_list[i];
    }

    char *start = (char *)mstart;
    struct page *page;
    for (; start + PGSIZE <= (char *)mend; start += PGSIZE)
    {
        page = (struct page *)start;
        buddy_free(page, 0, 1);
    }
}

void buddy_split(struct page *page, int order)
{
    struct page *np = (struct page *)((char *)(page) + (1 << order) * PGSIZE);
    buddy_free(page, order, 0);
    buddy_free(np, order, 0);
}

void *buddy_alloc(int order)
{
    struct page *head = &buddy.free_list[order];
    struct page *page = head->next;
    if (page == head)
    {
        struct page *pp = (struct page *)buddy_alloc(order + 1);
        buddy_split(pp, order);
    }
    page = head->next;
    head->next->next->prev = head;
    head->next = head->next->next;
    memset((void *)page, 0, PGSIZE);
    return page;
}

void buddy_test()
{
    void *arr0[105];
    void *arr1[105];
    for (int i = 0; i < 100; i++)
    {
        arr0[i] = buddy_alloc(0);
    }
    for (int i = 0; i < 50; i++)
    {
        arr1[i] = buddy_alloc(1);
    }
    for (int i = 0; i < 100; i += 2)
    {
        buddy_free(arr0[i], 0, 1);
    }
    for (int i = 0; i < 50; i++)
    {
        buddy_free(arr1[i], 1, 1);
    }
    for (int i = 1; i < 100; i += 2)
    {
        buddy_free(arr0[i], 0, 1);
    }
    printf("buddy test ok\n");
}