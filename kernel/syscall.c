/*
 * @Author: Outsider
 * @Date: 2022-08-02 16:44:07
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-02 16:45:33
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/syscall.c
 */
#include "types.h"
#include "riscv.h"

void syscall(){
    uint32 sepc=r_sepc();
    w_sepc(sepc+4);
}