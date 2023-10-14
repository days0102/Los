/*
 * @Author       : Outsider
 * @Date         : 2023-08-05 15:15:45
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-10-14 11:32:53
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/buddy.c
 */
#include "defs.h"
#include "vm.h"
#include "buddy.h"

// todo [buddy lock]

struct page *header;
void *base_addr;

struct page *addr_page(void *addr)
{
    return header + (addr - base_addr) / PGSIZE;
}

void buddy_merge(struct page *lhs, struct page *rhs)
{
    assert(lhs->order == rhs->order);
    assert(lhs + (1 << lhs->order) == rhs);
    lhs->order++;
    memset(rhs, 0, sizeof(struct page));
    buddy_free(lhs->addr, 1);
}

void buddy_free(void *addr, int merge)
{
    struct page *hp = addr_page(addr);

    hp->addr = addr;
    int order = hp->order;

    struct page *head = &buddy.free_list[order];
    struct page *p = head->next;
    while (p != head && p->addr < addr)
    {
        p = p->next;
    }

    hp->next = p;
    hp->prev = p->prev;
    p->prev->next = hp;
    p->prev = hp;

    if (merge && order + 1 < BUDDY_MAX_ORDER)
    {
        struct page *prev = (struct page *)hp->prev;
        struct page *next = (struct page *)hp->next;

        if (prev->addr + (PGSIZE * (1 << order)) == hp->addr)
        {
            hp->prev->prev->next = hp->next;
            hp->next->prev = hp->prev->prev;
            buddy_merge(prev, hp);
        }
        else if ((void *)hp->addr + (PGSIZE * (1 << order)) == next->addr)
        {
            hp->prev->next = hp->next->next;
            hp->next->next->prev = hp->prev;
            buddy_merge(hp, next);
        }
    }
}

void buddy_init()
{
    initspinlock(&buddy.lock, "buddy");
    for (uint i = 0; i < BUDDY_MAX_ORDER; i++)
    {
        buddy.free_list[i].next = buddy.free_list[i].prev = &buddy.free_list[i];
        initspinlock(&(buddy.locks[i]), "buddy");
    }

    int page_num = ((char *)mend - (char *)mstart) / PGSIZE;
    header = (struct page *)mstart;
    memset(header, 0, page_num * sizeof(struct page));

    char *start = (char *)mstart + PALIGN_UP(page_num * sizeof(struct page), PGSIZE);
    base_addr = start;
    // char *start = (char *)mstart;
    for (; start + PGSIZE <= (char *)mend; start += PGSIZE)
    {
        buddy_free(start, 1);
    }
}

void buddy_split(struct page *p)
{
    p->prev->next = p->next;
    p->next->prev = p->prev;
    assert(p->order != 0);
    p->order--;
    struct page *np = addr_page(p->addr + PGSIZE * (1 << p->order));
    np->order = p->order;
    buddy_free(p->addr, 0);
    buddy_free(p->addr + PGSIZE * (1 << p->order), 0);
}

void *buddy_alloc(int order)
{
    struct page *head = &buddy.free_list[order];
    struct page *page = head->next;
    if (page == head)
    {
        struct page *pp = addr_page(buddy_alloc(order + 1));
        buddy_split(pp);
    }
    page = head->next;
    head->next->next->prev = head;
    head->next = head->next->next;
    memset((void *)page->addr, 0, PGSIZE);
    return page->addr;
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
        buddy_free(arr0[i], 1);
    }
    for (int i = 0; i < 50; i++)
    {
        buddy_free(arr1[i], 1);
    }
    for (int i = 1; i < 100; i += 2)
    {
        buddy_free(arr0[i], 1);
    }
    printf("buddy test ok\n");
}