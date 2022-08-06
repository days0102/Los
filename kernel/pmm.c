/*
 * @Author: Outsider
 * @Date: 2022-07-11 22:29:05
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-06 18:41:24
 * @Description: 物理内存管理 Physical Memory Management
 * @FilePath: /los/kernel/pmm.c
 */
#include "types.h"
#include "defs.h"

#define PGSIZE 4096

// 指向物理内存的指针
struct pmp
{
    struct pmp *next;
};
// mem 空闲空间链表，存储再kernel.data
struct
{
    struct pmp *freelist;
} mem;
#define _DEBUG
void minit()
{
#ifdef _DEBUG
    printf("textstart:%p    ", textstart);
    printf("textend:%p\n", textend);
    printf("datastart:%p    ", datastart);
    printf("dataend:%p\n", dataend);
    printf("rodatastart:%p  ", rodatastart);
    printf("rodataend:%p\n", rodataend);
    printf("bssstart:%p     ", bssstart);
    printf("bssend:%p\n", bssend);
    printf("mstart:%p   ", mstart);
    printf("mend:%p\n", mend);
    printf("stack:%p\n", stacks);
#endif

    char *p = (char *)mstart;
    struct pmp *m;
    for (; p + PGSIZE <= (char *)mend; p += PGSIZE)
    {
        m = (struct pmp *)p;
        m->next = mem.freelist;
        mem.freelist = m;
    }
}

void *palloc()
{
    struct pmp *p = (struct pmp *)mem.freelist;
    if (p)
        mem.freelist = mem.freelist->next;
    if (p)
        memset(p, 0, PGSIZE);
    return (void *)p;
}

void pfree(void *addr)
{
    struct pmp *p = (struct pmp *)addr;
    p->next = mem.freelist;
    mem.freelist = p;
}