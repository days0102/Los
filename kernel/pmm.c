/*
 * @Author       : Outsider
 * @Date         : 2022-07-11 22:29:05
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-05-27 11:45:07
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/pmm.c
 */
#include "types.h"
#include "defs.h"
#include "lock.h"

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
    struct spinlock lock;
} mem;

// 物理内存管理 - 空闲链表
void minit()
{
#ifdef DEBUG
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
    initspinlock(&mem.lock, "mem_lock");

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
    acquirespinlock(&mem.lock);
    struct pmp *p = (struct pmp *)mem.freelist;
    if (p)
        mem.freelist = mem.freelist->next;
    if (p)
        memset(p, 0, PGSIZE);
    releasespinlock(&mem.lock);
    return (void *)p;
}

void pfree(void *addr)
{
    struct pmp *p = (struct pmp *)addr;
    acquirespinlock(&mem.lock);
    p->next = mem.freelist;
    mem.freelist = p;
    releasespinlock(&mem.lock);
}