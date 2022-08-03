/*
 * @Author: Outsider
 * @Date: 2022-08-02 16:44:07
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-03 21:04:37
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/syscall.c
 */
#include "types.h"
#include "riscv.h"
#include "proc.h"
#include "defs.h"

void syscall(){
    struct pcb* p=nowproc();
    p->trapframe->epc=r_sepc();
    p->trapframe->epc+=4;

}