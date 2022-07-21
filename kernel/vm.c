/*
 * @Author: Outsider
 * @Date: 2022-07-15 13:02:18
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-22 07:21:46
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/vm.c
 */
#include "types.h"
#include "defs.h"
#include "riscv.h"
#include "vm.h"
#include "uart.h"
#include "plic.h"
#include "proc.h"

addr_t* kpgt;

/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t* acquriepte(addr_t* pgt,addr_t va){
    pte_t* pte;
    pte = &pgt[VPN(1,va)];          // 获取一级页表 PTE
    // printf("%d\n",VPN(1,va));
    if(*pte & PTE_V){               // 已分配页
        pgt=(addr_t*)PTE2PA(*pte);
    }else{                          // 未分配页
        pgt=(addr_t*)palloc();      // 二级页表
        memset(pgt,0,PGSIZE);
        *pte = PA2PTE(pgt) | PTE_V;
    }
    return &pgt[VPN(0,va)];         // 返回二级页表 PTE
}

/**
 * @description: 建立地址映射
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
    pte_t* pte;
    
    // PPN
    addr_t start = ((va>>12)<<12);   
    addr_t end =(((va + (size - 1)) >>12)<<12);

    while(1){
        pte=acquriepte(pgt,start);
        if(*pte & PTE_V)
            panic("repeat map");
        *pte = PA2PTE(pa) | mode | PTE_V ;
        if(start==end)  break;
        start += PGSIZE;
        pa += PGSIZE;
    }
}

void printpgt(addr_t* pgt){
    for(int i=0;i<1024;i++){
        pte_t pte=pgt[i];
        if(pte & PTE_V){
            addr_t* pgt2=(addr_t*)PTE2PA(pte);
            printf(".. %d: pte %p pa %p\n",i,pte,pgt2);
            for(int j=0;j<1024;j++){
                pte_t pte2=pgt2[j];
                if(pte2 & PTE_V){
                    printf(".. ..%d: pte %p pa %p\n",j,pte2,PTE2PA(pte2));
                }
            }
        }
    }
}

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t* pgt){
    for(int i=0;i<NPROC;i++){
        addr_t va=(addr_t)(KSPACE+PGSIZE+(i)*2*PGSIZE);
        addr_t pa=(addr_t)palloc();
        // printf("%p %p\n",va,pa);
        vmmap(pgt,va,pa,PGSIZE,PTE_R|PTE_W);
    }
}

// 初始化虚拟内存
void vminit(){
    kpgt=(addr_t*)palloc();
    memset(kpgt,0,PGSIZE);

    // 映射 PLIC 寄存器
    vmmap(kpgt,PLIC_BASE,PLIC_BASE,0x400000,PTE_R|PTE_W);

    // 映射 UART 寄存器
    vmmap(kpgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
    
    // 映射 内核 指令区
    vmmap(kpgt,(addr_t)textstart,(addr_t)textstart,(textend-textstart),PTE_R|PTE_X);
    // 映射 内核 只读区
    vmmap(kpgt,(addr_t)rodatastart,(addr_t)rodatastart,(rodataend-rodatastart),PTE_R);
    // 映射 数据区
    vmmap(kpgt,(addr_t)datastart,(addr_t)datastart,dataend-datastart,PTE_R|PTE_W);
    // 映射 内核 全局数据区
    vmmap(kpgt,(addr_t)bssstart,(addr_t)bssstart,bssend-bssstart,PTE_R|PTE_W);
    
    // 映射空闲内存区
    vmmap(kpgt,(addr_t)mstart,(addr_t)mstart,mend-mstart,PTE_W|PTE_R);

    mkstack(kpgt);

    // printpgt(pgt);
    w_satp(SATP_SV32|(((uint32)kpgt)>>12)); // 页表 PPN 写入Satp
    sfence_vma();       // 刷新页表
}

addr_t* pgtcreate(){
    // 分配页表
    addr_t* pgt=(addr_t*)palloc();

    return pgt;
}

