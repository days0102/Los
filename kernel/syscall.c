/*
 * @Author: Outsider
 * @Date: 2022-08-02 16:44:07
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-17 17:38:07
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
    // printpgt(nowproc()->pagetable);
    argstr(0, path, MAXPATH);

    return exec(path);
}

uint32 sys_fork(void)
{
    int r = fork();
    return r;
}

uint32 sys_recycle(void)
{
    int m = bufauto();
    return m;
}

uint32 sys_yeid(void)
{
    yield();
    return 0;
}

uint32 sys_exit(void)
{
    int status;
    argint(0, &status);
    exit(status);
    return 0;
}

extern uint32 sys_open();
extern uint32 sys_mknod();
extern uint32 sys_dup();
extern uint32 sys_write();
extern uint32 sys_read();
static uint32 (*syscalls[])(void) = {
    [SYS_exec] sys_exec,
    [SYS_fork] sys_fork,
    [SYS_open] sys_open,
    [SYS_mknod] sys_mknod,
    [SYS_dup] sys_dup,
    [SYS_write] sys_write,
    [SYS_read] sys_read,
    [SYS_recycle] sys_recycle,
    [SYS_yeid] sys_yeid,
    [SYS_exit] sys_exit,
};

void syscall()
{
    struct pcb *p = nowproc();

    p->trapframe->epc += 4;

    uint32 sysnum = p->trapframe->a7;

    s_sstatus_intr(INTR_SIE);

    p->trapframe->a0 = syscalls[sysnum]();
    // printf("syscall : %d return %d\n", sysnum, p->trapframe->a0);
}