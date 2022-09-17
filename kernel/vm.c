/*
 * @Author: Outsider
 * @Date: 2022-07-15 13:02:18
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-17 17:52:31
 * @Description: virtual mem
 * @FilePath: /los/kernel/vm.c
 */
#include "types.h"
#include "defs.h"
#include "riscv.h"
#include "vm.h"
#include "uart.h"
#include "plic.h"
#include "proc.h"
#include "clint.h"
#include "mmio.h"

addr_t *kpgt;

/**
 * @description:  获取 PTE
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 */
pte_t *acquriepte(addr_t *pgt, addr_t va)
{
    pte_t *pte;
    pte = &pgt[VPN(1, va)]; // 获取一级页表 PTE
    // printf("%d\n",VPN(1,va));
    if (*pte & PTE_V)
    { // 已分配页
        pgt = (addr_t *)PTE2PA(*pte);
    }
    else
    {                             // 未分配页
        pgt = (addr_t *)palloc(); // 二级页表
        memset(pgt, 0, PGSIZE);
        *pte = PA2PTE(pgt) | PTE_V;
    }
    return &pgt[VPN(0, va)]; // 返回二级页表 PTE
}

/**
 * @description: 建立地址映射
 * @param {addr_t*} pgt 页表
 * @param {addr_t} va   虚拟地址
 * @param {addr_t} pa   物理地址
 * @param {uint} size   内存大小
 * @param {uint} mode   PTE 模式
 */
void vmmap(addr_t *pgt, addr_t va, addr_t pa, uint size, uint mode)
{
    pte_t *pte;

    // PPN
    addr_t start = ((va >> 12) << 12);
    addr_t end = (((va + (size - 1)) >> 12) << 12);

    while (1)
    {
        pte = acquriepte(pgt, start);
        if (*pte & PTE_V)
            panic("repeat map");
        *pte = PA2PTE(pa) | mode | PTE_V;
        if (start == end)
            break;
        start += PGSIZE;
        pa += PGSIZE;
    }
}

void printpgt(addr_t *pgt)
{
    printf("pagetable : pa %p\n", pgt);
    for (int i = 0; i < 1024; i++)
    {
        pte_t pte = pgt[i];
        if (pte & PTE_V)
        {
            addr_t *pgt2 = (addr_t *)PTE2PA(pte);
            printf(".. %d: pte %p pa %p\n", i, pte, pgt2);
            for (int j = 0; j < 1024; j++)
            {
                pte_t pte2 = pgt2[j];
                if (pte2 & PTE_V)
                {
                    addr_t va = (addr_t)(i << 22) + (j << 12);
                    printf(".. ..%d: pte %p va %p pa %p\n", j, pte2, va, PTE2PA(pte2));
                }
            }
        }
    }
}

// 进程内核栈初始化
// 所有进程共享一个内核空间
// 每个进程在内核中有独立的内核栈
void mkstack(addr_t *pgt)
{
    for (int i = 0; i < NPROC; i++)
    {
        addr_t va = (addr_t)(KSPACE + PGSIZE + (i)*2 * PGSIZE);
        addr_t pa = (addr_t)palloc();
        // printf("%p %p\n",va,pa);
        vmmap(pgt, va, pa, PGSIZE, PTE_R | PTE_W);
    }
}

// 初始化虚拟内存
void kvminit()
{
    kpgt = (addr_t *)pgtcreate();

    // 映射 CLINT
    vmmap(kpgt, CLINT_BASE, CLINT_BASE, 0xc000, PTE_R | PTE_W);

    // 映射 PLIC 寄存器
    vmmap(kpgt, PLIC_BASE, PLIC_BASE, 0x400000, PTE_R | PTE_W);

    // 映射 UART 寄存器
    vmmap(kpgt, UART_BASE, UART_BASE, PGSIZE, PTE_R | PTE_W);

    // 映射 VIRTIO_MMIO
    vmmap(kpgt, VIRTIO_BASE, VIRTIO_BASE, PGSIZE, PTE_R | PTE_W);

    // 映射 内核 指令区
    vmmap(kpgt, (addr_t)textstart, (addr_t)textstart, (textend - textstart), PTE_R | PTE_X);
    // 映射 数据区
    vmmap(kpgt, (addr_t)datastart, (addr_t)datastart, dataend - datastart, PTE_R | PTE_W);
    // 映射 内核 只读区
    vmmap(kpgt, (addr_t)rodatastart, (addr_t)rodatastart, (rodataend - rodatastart), PTE_R);
    // 映射 内核 全局数据区
    vmmap(kpgt, (addr_t)bssstart, (addr_t)bssstart, bssend - bssstart, PTE_R | PTE_W);

    // 映射空闲内存区
    vmmap(kpgt, (addr_t)mstart, (addr_t)mstart, mend - mstart, PTE_W | PTE_R);

    mkstack(kpgt);

    // 映射 usertrap
    vmmap(kpgt, USERVEC, (uint32)usertrap, PGSIZE, PTE_R | PTE_X);

    // printpgt(pgt);
}

// 启动内存映射
void kvmstart()
{
    w_satp(SATP_SV32 | (((uint32)kpgt) >> 12)); // 页表 PPN 写入Satp
    sfence_vma();                               // 刷新页表
}

addr_t *pgtcreate()
{
    // 分配页表
    addr_t *pagetable = (addr_t *)palloc();
    memset(pagetable, 0, PGSIZE);
    return pagetable;
}

void upgtinit(addr_t *pagtable)
{
}

void vmunmap(addr_t *pagetable, addr_t va, size_t size, int freepa)
{
    pte_t *pte;

    // PPN
    addr_t start = ((va >> 12) << 12);
    addr_t end = (((va + (size - 1)) >> 12) << 12);

    addr_t pa;
    while (1)
    {
        pte = acquriepte(pagetable, start);
        if (*pte & PTE_V)
        {
            pa = PTE2PA(*pte);
            if (freepa)
                pfree((addr_t *)pa);
            *pte &= ~PTE_V;
            if (start == end)
                break;
            start += PGSIZE;
        }
        if (start == end)
            break;
    }
}

void pgtfree(addr_t *pagetable)
{
    pte_t pte;
    for (int i = 0; i < NPTEPG; i++)
    {
        pte = pagetable[i];
        if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)))
            pfree((addr_t *)PTE2PA(pte));
    }
    pfree(pagetable);
}

int copyin(addr_t *pagetable, addr_t vaddr, char *buf, int max)
{
    pte_t *pte;
    addr_t pa;
    uint32 off = ((vaddr << 20) >> 20);
    addr_t start = ((vaddr >> 12) << 12);
    addr_t end = (((vaddr + (max - 1)) >> 12) << 12);
    int cnt = 0;
    while (1)
    {
        pte = acquriepte(pagetable, start);
        if (*pte & PTE_V)
        {
            pa = PTE2PA(*pte);
            int cc = max - cnt < PGSIZE - off ? max - cnt : PGSIZE - off;
            memmove(buf + cnt, (void *)(pa + off), cc);
            cnt += cc;
            off = (off + cc) % PGSIZE;
            if (start == end || cnt >= max)
                break;
            start += PGSIZE;
        }
        else
        {
            //! ummap
            return cnt;
        }
    }
    return cnt;
}

void copyout(addr_t *pagetable, addr_t vaddr, char *buf, int max)
{
    pte_t *pte;
    addr_t pa;
    uint32 off = ((vaddr << 20) >> 20);
    addr_t start = ((vaddr >> 12) << 12);
    addr_t end = (((vaddr + (max - 1)) >> 12) << 12);
    int cnt = 0;
    while (1)
    {
        pte = acquriepte(pagetable, start);
        if (*pte & PTE_V)
        {
            pa = PTE2PA(*pte);
            int cc = max - cnt < PGSIZE - off ? max - cnt : PGSIZE - off;
            memmove((void *)(pa + off), buf + cnt, cc);
            cnt += cc;
            off = (off + cc) % PGSIZE;
            if (start == end || cnt >= max)
                break;
            start += PGSIZE;
        }
        else
            error("unmap");
    }
}