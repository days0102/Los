/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:44:55
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-20 08:16:56
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/proc.c
 */
#include "proc.h"
#include "vm.h"
#include "defs.h"
#include "riscv.h"
#include "elf.h"
#include "fs.h"

uint nextpid = 0;

void procinit()
{
    struct pcb *p;
    for (int i = 0; i < NPROC; i++)
    {
        p = &proc[i];
        p->kernelstack = (addr_t)(KSTACK + (i)*2 * PGSIZE);
    }
#ifdef DEBUG
    for (int i = 0; i < NPROC; i++)
    {
        p = &proc[i];
        printf("proc %d ksp : %p\n", i, p->kernelstack);
    }
#endif
}

struct cpu *nowcpu()
{
    int hart = r_tp();
    struct cpu *c = &cpus[hart];
    return c;
}
struct pcb *nowproc()
{
    struct cpu *c = nowcpu();
    return c->proc;
}

uint pidalloc()
{
    return nextpid++;
}

struct pcb *procalloc()
{
    struct pcb *p;
    for (p = proc; p < &proc[NPROC]; p++)
    {
        if (p->status == UNUSED)
        {
            p->trapframe = (struct trapframe *)palloc(sizeof(struct trapframe));
            p->pid = pidalloc();

            p->pagetable = pgtcreate();

            p->context.ra = (reg_t)usertrapret;
            p->context.sp = p->kernelstack;
            p->status = USED;
            return p;
        }
    }
    return 0;
}

uint8 initcode[] = {
    0x93, 0x08, 0x10, 0x00,
    0x13, 0x05, 0x00, 0x01,
    0x73, 0x00, 0x00, 0x00,
    0x6f, 0x00, 0x00, 0x00,

    0x69, 0x6e, 0x69, 0x74,
    0x70, 0x72, 0x6f, 0x63,
    0x00, 0x00, 0x00, 0x00};
// uint8 initcode[] = {
//     0x93, 0x08, 0x10, 0x00,
//     0x17, 0x05, 0x00, 0x00,
//     0x13, 0x05, 0x05, 0x00,
//     0x73, 0x00, 0x00, 0x00,
//     0x6f, 0x00, 0x00, 0x00,

//     0x69, 0x6e, 0x69, 0x74,
//     0x70, 0x72, 0x6f, 0x63,
//     0x00, 0x00, 0x00, 0x00};

// 初始化第一个进程
void userinit()
{
    struct pcb *p = procalloc();

    p->trapframe->epc = 0;
    p->trapframe->sp = PGSIZE;

    char *m = (char *)palloc();
    memmove(m, initcode, sizeof(initcode));

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
    vmmap(p->pagetable, (uint32)uservec, (uint32)uservec, PGSIZE, PTE_R | PTE_X);

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);

    // p->context.ra = (reg_t)usertrapret;
    // p->context.sp = p->kernelstack;

    p->size = PGSIZE;
    strcpy(p->name, "initcode");

    p->cwd = find_inode(-1, "/");

    p->status = RUNABLE;
}

void schedule()
{
    struct cpu *c = nowcpu();
    struct pcb *p;

    for (;;)
    {
        for (p = proc; p < &proc[NPROC]; p++)
        {
            if (p->status == RUNABLE)
            {
                p->status = RUNNING;
                c->proc = p;
                // 保存当前的上下文到cpu->context中
                swtch(&c->context, &p->context);
                // swtch ret后跳转到p->context.ra

                c->proc = 0; // cpu->context.ra 指向这里
            }
        }
    }
}

/**
 * @description: 进程放弃 CPU
 */
void yield()
{
    struct pcb *p = nowproc();
    if (p == 0 || p->status != RUNNING)
    {
        panic("proc status error");
    }
    p->status = RUNABLE;
    sched();
}

/**
 * @description:
 */
void sched()
{
    struct pcb *p = nowproc();
    if (p->status == RUNNING)
    {
        panic("proc is running");
    }
    swtch(&p->context, &nowcpu()->context); //跳转到cpu->context.ra ( schedule() )
}

void sleep(void *chan)
{
    struct pcb *p = nowproc();
    if (p->status != RUNNING)
        panic("sleep : status");
    p->chan = chan;
    p->status = SLEEPING;
    sched();

    p->chan = 0;
    p->status = RUNNING;
}

void wakeup(void *chan)
{
    struct pcb *p = nowproc();

    for (p = proc; p < &proc[NPROC]; p++)
    {
        if (p->status == SLEEPING &&p->chan == chan)
        {
            p->status = RUNABLE;
        }
    }
}