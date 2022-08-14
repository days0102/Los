/*
 * @Author: Outsider
 * @Date: 2022-08-02 16:44:07
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-14 11:09:19
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/syscall.c
 */
#include "types.h"
#include "riscv.h"
#include "proc.h"
#include "defs.h"
#include "syscall.h"

static uint32 (*syscalls[])(void) = {
    [SYS_fork] sys_fork,
    [SYS_exec] sys_exec,
};

void syscall()
{
    struct pcb *p = nowproc();
    
    p->trapframe->epc += 4;

    uint32 sysnum = p->trapframe->a7;
    p->trapframe->a7 = syscalls[sysnum]();
}