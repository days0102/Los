/*
 * @Author: Outsider
 * @Date: 2022-07-11 22:29:05
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-12 21:50:06
 * @Description: 物理内存管理 Physical Memory Management
 * @FilePath: /los/kernel/pmm.c
 */
#include "types.h"

#define PGSIZE 4096

// 指向物理内存的指针
struct pmp
{
    struct pmp* next;
};
// mem 空闲空间链表，存储再kernel.data
struct
{
    struct pmp* freelist;
}mem;

extern uint8 textstart[];
extern uint8 textend[];
extern uint8 rodatastart[];
extern uint8 rodataend[];
extern uint8 datastart[];
extern uint8 dataend[];
extern uint8 bssstart[];
extern uint8 bssend[];
extern uint8 end[];
extern uint8 pstart[];
extern uint8 pend[];
extern uint8 memstart[];
extern uint8 memend[];

void* memset(void* addr,int c,uint n){
    char* maddr=(char*)addr;
    for(uint i=0;i<n;i++){
        maddr[i]=(char)c;
    }
    return addr;
}

void minit(){
    // uint32* te=textend;
    // uint32* re=rodataend;
    // uint32* de=dataend;
    // uint32* be=bssend;
    // uint8* me=memend;
    char* p=(char*)pstart;
    struct pmp* m;
    for( ; p + PGSIZE <= (char*)pend ; p+=PGSIZE){
        m=(struct pmp*)p;
        m->next=mem.freelist;
        mem.freelist=m;
    }
}

void* palloc(){
    struct pmp* p=(struct pmp*)mem.freelist;
    if(p)
        mem.freelist=mem.freelist->next;
    if(p)
        memset(p,0,PGSIZE);
    return (void*)p;
}

void pfree(void* addr){
    struct pmp* p=(struct pmp*)addr;
    p->next=mem.freelist;
    mem.freelist=p;
}