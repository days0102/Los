/*
 * @Author: Outsider
 * @Date: 2022-08-15 18:29:54
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-18 12:14:54
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/fork.c
 */
#include "types.h"
#include "defs.h"
#include "proc.h"
#include "vm.h"

void uvmcopy(addr_t *oldpgt, addr_t *newpgt, uint32 size)
{
    pte_t *pte;
    addr_t pa;
    addr_t npa;
    for (int i = 0; i < size; i += PGSIZE)
    {
        pte = acquriepte(oldpgt, i);
        if ((*pte & PTE_V))
        {
            pa = (addr_t)PTE2PA(*pte);
            npa = (addr_t)palloc();
            memmove((void *)npa, (void *)pa, PGSIZE);
            vmmap(newpgt, (addr_t)i, (addr_t)npa, PGSIZE, PTE_R | PTE_W | PTE_U | PTE_X);
        }
    }
}

int fork()
{
    struct pcb *p = nowproc();
    struct pcb *np = procalloc();
    uvmcopy(p->pagetable, np->pagetable, p->size);

    memmove(np->trapframe, p->trapframe, sizeof(*np->trapframe));

    np->trapframe->a0 = 0; // 子进程返回 0

    np->parent = p;
    np->cwd = p->cwd;
    // np->trapframe->kernel_sp = p->kernelstack;
    vmmap(np->pagetable, (uint32)uservec, (uint32)uservec, PGSIZE, PTE_R | PTE_X);

    vmmap(np->pagetable, (addr_t)TRAPFRAME, (addr_t)np->trapframe, PGSIZE, PTE_R | PTE_W);

    np->size = p->size;
    strcpy(np->name, p->name);
    np->status = RUNABLE;
    return np->pid;
}