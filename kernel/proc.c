/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:44:55
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-18 18:25:02
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/proc.c
 */
#include "proc.h"
#include "vm.h"

void procinit(){
    struct pcb* p;
    for(int i=0;i<NPROC;i++){
        p=&proc[i];
        p->kstack=(addr_t)(KSTACK+(i)*2*PGSIZE);
    }
}