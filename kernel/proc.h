/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:35:47
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-21 23:01:35
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/proc.h
 */
#include "types.h"
#include "swtch.h"

#define NPROC 4

enum procstatus {UNUSED,USED,RUNABLE,RUNNING,BLOCKED,SLEEPING};

struct pcb
{
    int pid;
    enum procstatus status;
    struct context context;
    addr_t* pagetable;
    addr_t kernelstack;
};

struct pcb proc[NPROC];
