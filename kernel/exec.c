/*
 * @Author: Outsider
 * @Date: 2022-08-14 13:42:37
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-17 17:02:18
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/exec.c
 */
#include "types.h"
#include "proc.h"
#include "defs.h"
#include "elf.h"
#include "fs.h"
#include "vm.h"

int exec(char *path)
{
    struct pcb *p = nowproc();
    struct Elf32_Ehdr elf;
    struct Elf32_Phdr phdr;

    struct inode *inode = find_inode(-1, path);
    if (inode == 0 || inode->dinode.type != I_TYPE_FILE)
    {
        irelse(inode);
        return -1;
    }

    read_data(inode, (char *)&elf, 0, sizeof(struct Elf32_Ehdr));
    assert(*(uint32 *)elf.e_ident == ELF_MAGIC);
    // printpgt(p->pagetable);
    vmunmap(p->pagetable, 0, p->size, 1);
    // printpgt(p->pagetable);

    p->size = 0;
    for (int i = 0, off = elf.e_phoff; i < elf.e_phnum; i++, off += sizeof(struct Elf32_Phdr))
    {
        read_data(inode, (char *)&phdr, off, sizeof(struct Elf32_Phdr));
        long long size = 0;
        long long cnt = phdr.p_memsz;
        assert(phdr.p_vaddr % PGSIZE == 0);
        while (size < phdr.p_memsz)
        {
            addr_t *pa = (addr_t *)palloc();
            uint32 cc = cnt > PGSIZE ? PGSIZE : cnt;
            read_data(inode, (char *)pa, phdr.p_offset + size, cc);

            vmmap(p->pagetable, (addr_t)phdr.p_vaddr + size, (addr_t)pa, cc, PTE_R | PTE_W | PTE_X | PTE_U);
            size += PGSIZE;
            cnt -= cc;
        }
        p->size += phdr.p_memsz;
    }
    // addr_t stack = (addr_t)palloc();
    // vmmap(p->pagetable, USTACKBASE, stack, PGSIZE, PTE_R | PTE_W | PTE_U);

    memset(p->name, 0, PCBNAME);
    strcpy(p->name, path);
    p->trapframe->epc = (reg_t)elf.e_entry;
    p->trapframe->sp = KSPACE;
    // p->context.ra = (reg_t)usertrapret;
    p->context.sp = p->kernelstack;
    // printpgt(p->pagetable);

    irelse(inode);
    return 0;
}