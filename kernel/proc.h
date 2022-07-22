/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:35:47
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-22 08:11:18
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

struct cpu{
    struct pcb* proc;           // CPU 持有的进程
    struct context* context;    // CPU 上下文(正在执行的上下文)
};

#define NCPUS 8

struct cpu cpu[NCPUS];