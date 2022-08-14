/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:44:55
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-14 13:41:07
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/proc.c
 */
#include "proc.h"
#include "vm.h"
#include "defs.h"
#include "riscv.h"
#include "syscall.h"
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
            p->status = USED;

            p->pagetable = pgtcreate();

            return p;
        }
    }
    return 0;
}

uint8 zeroproc[] = {
    0x93, 0x08, 0x10, 0x00,
    0x73, 0x00, 0x00, 0x00,
    0x6f, 0x00, 0x00, 0x00};
uint8 firstproc[] = {
    0x93, 0x08, 0x20, 0x00,
    0x73, 0x00, 0x00, 0x00,
    0x6f, 0x00, 0x00, 0x00};

// 初始化第一个进程
void userinit()
{
    struct pcb *p = procalloc();

    p->trapframe->epc = 0;
    p->trapframe->sp = PGSIZE;

    char *m = (char *)palloc();
    memmove(m, zeroproc, sizeof(zeroproc));

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);

    p->context.ra = (reg_t)usertrapret;
    p->context.sp = p->kernelstack;

    p->status = RUNABLE;

    p = procalloc();
    p->context.ra = (reg_t)usertrapret;
    p->context.sp = p->kernelstack;

    p->trapframe->epc = 0;
    p->trapframe->sp = PGSIZE;

    m = (char *)palloc();
    memmove(m, firstproc, sizeof(zeroproc));

    vmmap(p->pagetable, 0, (addr_t)m, PGSIZE, PTE_R | PTE_W | PTE_X | PTE_U);
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);

    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);

    p->context.ra = (reg_t)usertrapret;
    p->context.sp = p->kernelstack;
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

uint32 sys_fork(void)
{
    printf("syscall fork\n");
    return SYS_fork;
}

uint32 sys_exec(void)
{
    printf("syscall exec\n");
    return SYS_exec;
}

void initproc()
{
    struct pcb *p = procalloc();
    struct Elf32_Ehdr elf;
    struct Elf32_Phdr phdr;
    struct dinode inode;
    struct dirent dirent;
    iread(0, &inode);
    dread(&inode, "initproc.elf", &dirent);
    iread(dirent.inum, &inode);
    readi(&inode, (char *)&elf, 0, sizeof(struct Elf32_Ehdr));
    assert(*(uint32 *)elf.e_ident == 0x464c457f);
    for (int i = 0, off = elf.e_phoff; i < elf.e_phnum; i++, off += sizeof(struct Elf32_Phdr))
    {
        readi(&inode, (char *)&phdr, off, sizeof(struct Elf32_Phdr));
        int size = phdr.p_filesz;
        while (size > 0)
        {
            addr_t *pa = (addr_t *)palloc();
            int cc = size > PGSIZE ? PGSIZE : size;
            readi(&inode, (char *)pa, phdr.p_offset, cc);
            size -= PGSIZE;
            vmmap(p->pagetable, (addr_t)phdr.p_vaddr, (addr_t)pa, cc, PTE_R | PTE_W | PTE_X | PTE_U);
        }
    }
    p->trapframe->epc = (reg_t)elf.e_entry;
    p->trapframe->sp = PGSIZE;
    vmmap(p->pagetable, (uint32)usertrap, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);
    vmmap(p->pagetable, (addr_t)TRAPFRAME, (addr_t)p->trapframe, PGSIZE, PTE_R | PTE_W);
    p->context.ra = (reg_t)usertrapret;
    p->context.sp = p->kernelstack;
    p->status = RUNABLE;
}