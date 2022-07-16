/*
 * @Author: Outsider
 * @Date: 2022-07-15 13:02:18
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-16 14:25:51
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/vm.c
 */
#include "types.h"
#include "defs.h"
#include "riscv.h"
#include "vm.h"
#include "uart.h"
#include "plic.h"

addr_t* pgt;
extern uint memend[];

pte_t* acquriepte(addr_t* pgt,addr_t va){
    pte_t* pte;
    pte = &pgt[VPN(1,va)];
    if(*pte & PTE_V){
        pgt=(addr_t*)PTE2PA(*pte);
    }else{
        pgt=(addr_t*)palloc();
        memset(pgt,0,PGSIZE);
        *pte = PA2PTE(pgt) | PTE_V;
    }
    return &pgt[VPN(0,va)];
}

// 地址映射
void vmmap(addr_t* pgt,addr_t va,addr_t pa,uint size,uint mode){
    pte_t* pte;

    addr_t start = va & ~0xfff;
    addr_t end = (va+size-1) & ~0xfff;

    while(1){
        pte=acquriepte(pgt,start);
        if(*pte & PTE_V)
            panic("repeat map");
        *pte = PA2PTE(pa) | mode |PTE_V ;
        if(start==end)  break;
        start += PGSIZE;
        pa += PGSIZE;
    }
}

void printpgt(addr_t* pgt){
    pte_t* pte;
    
}

void vminit(){
    pgt=(uint32*)palloc();
    memset(pgt,0,PGSIZE);

    // vmmap(pgt,UART_BASE,UART_BASE,PGSIZE,PTE_R|PTE_W);
    // vmmap(pgt,PLIC_BASE,PLIC_BASE,UART_BASE-PLIC_BASE,PTE_R|PTE_W);
    vmmap(pgt,0,0,(uint32)(memend),PTE_W|PTE_X|PTE_R);


    w_satp(SATP_SV32|(((uint32)pgt)>>12));
    sfence_vma();
}

