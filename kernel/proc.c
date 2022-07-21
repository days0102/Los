/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:44:55
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-22 07:49:54
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/proc.c
 */
#include "proc.h"
#include "vm.h"
#include "defs.h"

uint nextpid=0;

void procinit(){
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
        p=&proc[i];
        p->kernelstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
    }
}

uint pidalloc(){
    return nextpid++;
} 

struct pcb* procalloc(){
    struct pcb* p;
    for(p=proc;p<&proc[NPROC];p++){
        if(p->status==UNUSED){
            p->pid=pidalloc();
            p->status=USED;

            p->pagetable=pgtcreate();
            return p;
        }
    }
    return 0;
}

uint8 zeroproc[]={0x73,0x00,0x00,0x00};

// 初始化第一个进程
void userinit(){
    struct pcb* p=procalloc();
    
    char* m=(char*)palloc();
    memmove(m,zeroproc,sizeof(zeroproc));

    vmmap(p->pagetable,0,(addr_t)m,PGSIZE,PTE_R|PTE_W|PTE_X);

    p->context.sp=KSPACE;

    p->status=RUNABLE;
}

void schedule(){
    for(;;){
        struct pcb* p;
        for(p=proc;p<&proc[NPROC];p++){
            if(p->status==RUNABLE){
                
            }
        }
    }
}