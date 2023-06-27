/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:44:55
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-17 17:57:28
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
        // 初始化内核栈，并用一个页作为保护页避免越界访问
        p->kernelstack = (addr_t)(KSTACK + (i)*2 * PGSIZE);
        initspinlock(&p->spinlock, "proc_spinlock");
    }
#ifdef DEBUG
    for (int i = 0; i < NPROC; i++)
    {
        p = &proc[i];
        printf("proc %d ksp : %p\n", i, p->kernelstack);
    }
#endif
}

void cpuinit()
{
    struct cpu *c;
    int i;
    for (c = cpus, i = 0; c < &cpus[NCPUS]; c++, i++)
        c->id = i;
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
    // todo lock
    return nextpid++;
}

struct pcb *procalloc()
{
    // 寻找空闲 PCB，并初始化pcb
    struct pcb *p;
    for (p = proc; p < &proc[NPROC]; p++)
    {
        if (p->status == UNUSED)
        {
            p->trapframe = (struct trapframe *)palloc(sizeof(struct trapframe));
            p->pid = pidalloc();

            p->pagetable = pgtcreate();

            p->context.ra = (reg_t)forkret;
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
    addr_t stack = (addr_t)palloc();
    vmmap(p->pagetable, USTACKBASE, stack, PGSIZE, PTE_R | PTE_W | PTE_U);
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

/**
 * 调度器 - 时间片轮转
 **/
void schedule()
{
    struct cpu *c = nowcpu();
    struct pcb *p;

    for (;;)
    {
        //? intrrupt enable ?
        for (p = proc; p < &proc[NPROC]; p++)
        {
            acquirespinlock(&p->spinlock);
            if (p->status == RUNABLE)
            {
                p->status = RUNNING;
                c->proc = p;
                // 保存当前的上下文到cpu->context中
                swtch(&c->context, &p->context);
                // swtch ret后跳转到p->context.ra

                c->proc = 0; // cpu->context.ra 指向这里
            }
            releasespinlock(&p->spinlock);
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
        panic("proc status error");
    // 获取 spinlock, 修改 status，在调度器中释放
    acquirespinlock(&p->spinlock);
    p->status = RUNABLE;
    sched();                       // 切换到进程调度器
    releasespinlock(&p->spinlock); // 释放在调度器获得的 spinlock
}

/**
 * @description: 保存当前状态，跳转到进程调度器
 */
void sched()
{
    struct pcb *p = nowproc();
    if (p->status == RUNNING)
        panic("proc is running");
    //? intrrupt enable ?
    int enable = nowcpu()->sintr;           // save intrrupt
    swtch(&p->context, &nowcpu()->context); // 跳转到cpu->context.ra ( schedule() )
    nowcpu()->sintr = enable;               // resave intrrput
}

/**
 * @description: 进程睡眠
 * @param {void} *chan 通道
 * @param {spinlock} *spinlock
 */
void sleep(void *chan, struct spinlock *spinlock)
{
    struct pcb *p = nowproc();
    if (p == 0 || chan == 0)
        return;
    if (p->status != RUNNING)
        panic("sleep : status");
    acquirespinlock(&p->spinlock);
    if (spinlock != 0)
    {
        if (!checkspinlock(spinlock))
            panic("sleep no hold spinlock");
        releasespinlock(spinlock);
    }
    p->chan = chan;
    p->status = SLEEPING;
    sched();

    p->chan = 0;
    releasespinlock(&p->spinlock);
    if (spinlock != 0)
        acquirespinlock(spinlock);
}

/**
 * @description: 唤醒睡眠进程
 * @param {void} *chan 通道，唤醒所有通道为 chan 的进程
 */
void wakeup(void *chan)
{
    struct pcb *p;
    if (chan == 0)
        return;
    for (p = proc; p < &proc[NPROC]; p++)
    {
        //! now proc?
        acquirespinlock(&p->spinlock);
        if (p->status == SLEEPING && p->chan == chan)
            p->status = RUNABLE;
        releasespinlock(&p->spinlock);
    }
}

//!
void exit(int status)
{
    struct pcb *p = nowproc();
    acquirespinlock(&p->spinlock);

    p->cwd = 0;
    vmunmap(p->pagetable, 0, p->size, 1);
    vmunmap(p->pagetable, USTACKBASE, PGSIZE, 1);
    p->status = ZOMBIE;
    p->estatus = status;
    // wakeup(p->parent);
    sched();
    // not return
}

int wait(addr_t ret)
{
    struct pcb *p = nowproc();

    int has = 1;
    while (has)
    {
        has = 0;
        for (size_t i = 0; i < NPROC; i++)
        {
            if (proc[i].parent == p)
            {
                has = 1;
                if (proc[i].status == ZOMBIE)
                {
                    if (ret != 0)
                        copyout(p->pagetable, ret, (char *)&(proc[i].estatus), 4);
                    return proc[i].pid;
                }
            }
        }
        // sleep(&p, &(p->spinlock));
    }
    return -1;
}