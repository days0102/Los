/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:44:55
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-03 14:11:31
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/proc.c
 */
#include "proc.h"
#include "vm.h"
#include "defs.h"
#include "riscv.h"

uint nextpid=0;

void procinit(){
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
        p=&proc[i];
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
    }
}

struct pcb* nowproc(){
    int hart=r_tp();
    return cpus[hart].proc;
}

struct cpu* nowcpu(){
    int hart=r_tp();
    return &cpus[hart];
}

uint pidalloc(){
    return nextpid++;
} 

struct pcb* procalloc(){
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
        if(p->status==UNUSED){
            p->trapframe=(struct trapframe*)palloc(sizeof(struct trapframe));
            
            p->pid=pidalloc();
            p->status=USED;

            p->pagetable=pgtcreate();
            
            return p;
        }
    }
    return 0;
}

uint8 zeroproc[]={
  0x93,0x08,0x10,0x00,
  0x73,0x00,0x00,0x00,
  0x6f,0x00,0x00,0x00
  };

// 初始化第一个进程
void userinit(){
    struct pcb* p=procalloc();
    
    p->trapframe->epc=0;
    p->trapframe->sp=PGSIZE;
    
    char* m=(char*)palloc();
    memmove(m,zeroproc,sizeof(zeroproc));

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X|PTE_U);
    vmmap(p->pagetable,(uint32)usertrap,(uint32)usertrap,PGSIZE,PTE_R|PTE_X);

    vmmap(p->pagetable,(addr_t)TRAPFRAME,(addr_t)p->trapframe,PGSIZE,PTE_R|PTE_W);

    p->pagetable=(addr_t*)p->pagetable;

    p->status=RUNABLE;

    mkstack(p->pagetable);

    p->context.ra=(reg_t)usertrapret;
    p->context.sp=p->kernelstack;
}

void schedule(){
    struct cpu* c=nowcpu();

    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
            if(p->status==RUNABLE){
                p->status=RUNNING;
                c->proc=p;
                swtch(&c->context,&p->context);
                // swtch ret后跳转到p->context.ra

            }
        }
    }
}

void yield(){
    struct pcb* p=nowproc();
    if(p->status!=RUNNING){
        panic("proc status error");
    }
    p->status=RUNABLE;
}