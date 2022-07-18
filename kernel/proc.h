/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:35:47
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-18 17:11:59
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/proc.h
 */
#include "types.h"
#include "defs.h"
#include "swtch.h"

#define NPROC 4

enum procstatus {UNUSED,RUNABLE,RUNNING,BLOCKED,SLEEPING};

struct pcb
{
    int pid;
    enum procstatus status;
    struct context context;
    addr_t* pagetable;
    addr_t kstack;
};

struct pcb proc[NPROC];
