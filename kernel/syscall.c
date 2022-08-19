/*
 * @Author: Outsider
 * @Date: 2022-08-02 16:44:07
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-18 18:41:19
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/syscall.c
 */
#include "types.h"
#include "riscv.h"
#include "proc.h"
#include "defs.h"
#include "syscall.h"
#include "fs.h"

uint32 sysreg(int n)
{
    struct pcb *p = nowproc();
    switch (n)
    {
    case 0:
        return p->trapframe->a0;
    case 1:
        return p->trapframe->a1;
    case 2:
        return p->trapframe->a2;
    case 3:
        return p->trapframe->a3;
    case 4:
        return p->trapframe->a4;
    case 5:
        return p->trapframe->a5;
    case 6:
        return p->trapframe->a6;
    case 7:
        return p->trapframe->a7;
    }
    return 0;
}

void argint(int n, int *r)
{
    *r = sysreg(n);
}

void argaddr(int n, addr_t *r)
{
    *r = sysreg(n);
}

void argstr(int n, char *b, int cc)
{
    addr_t addr;
    argaddr(n, &addr);
    struct pcb *p = nowproc();
    copyin(p->pagetable, addr, b, cc);
}

uint32 sys_exec(void)
{
    char path[MAXPATH];
    memset(path, 0, MAXPATH);
    argstr(0, path, MAXPATH);

    exec(path);
    return SYS_exec;
}

uint32 sys_fork(void)
{
    int r = fork();
    return r;
}

extern uint32 sys_open();
extern uint32 sys_mknod();
static uint32 (*syscalls[])(void) = {
    [SYS_exec] sys_exec,
    [SYS_fork] sys_fork,
    [SYS_open] sys_open,
    [SYS_mknod] sys_mknod,
};

void syscall()
{
    struct pcb *p = nowproc();

    p->trapframe->epc += 4;

    uint32 sysnum = p->trapframe->a7;
    p->trapframe->a0 = syscalls[sysnum]();
    printf("syscall : %d return %d\n", sysnum, p->trapframe->a0);
}