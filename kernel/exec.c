/*
 * @Author: Outsider
 * @Date: 2022-08-14 13:42:37
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-15 16:33:55
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/exec.c
 */
#include "types.h"
#include "proc.h"
#include "defs.h"
#include "elf.h"
#include "fs.h"
#include "vm.h"

void exec(char *path)
{
    struct pcb *p = nowproc();
    struct Elf32_Ehdr elf;
    struct Elf32_Phdr phdr;
    struct dinode inode;
    iread(0, &inode);
    uint32 inum;
    if ((inum = dread(&inode, path)))
        iread(inum, &inode);
    else
        return;
    readi(&inode, (char *)&elf, 0, sizeof(struct Elf32_Ehdr));
    assert(*(uint32 *)elf.e_ident == ELF_MAGIC);
    vmunmap(p->pagetable, 0, p->size, 1);
    p->size = 0;
    for (int i = 0, off = elf.e_phoff; i < elf.e_phnum; i++, off += sizeof(struct Elf32_Phdr))
    {
        readi(&inode, (char *)&phdr, off, sizeof(struct Elf32_Phdr));
        long long size = phdr.p_filesz;
        while (size > 0)
        {
            addr_t *pa = (addr_t *)palloc();
            uint32 cc = size > PGSIZE ? PGSIZE : size;
            readi(&inode, (char *)pa, phdr.p_offset + (phdr.p_filesz - size), cc);
            size -= PGSIZE;
            vmmap(p->pagetable, (addr_t)phdr.p_vaddr, (addr_t)pa, cc, PTE_R | PTE_W | PTE_X | PTE_U);
        }
        p->size += phdr.p_memsz;
    }
    memset(p->name, 0, PCBNAME);
    strcpy(p->name, path);
    p->trapframe->epc = (reg_t)elf.e_entry;
    p->trapframe->sp = PGSIZE;
    p->context.ra = (reg_t)usertrapret;
    p->context.sp = p->kernelstack;
    p->status = RUNABLE;
}