/*
 * @Author: Outsider
 * @Date: 2022-08-13 08:07:54
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-13 08:18:22
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/elf.h
 */
#include "types.h"

#define EI_NIDENT (16)

typedef unsigned short Elf_Half;
typedef unsigned int Elf_Word;
typedef unsigned int Elf_Addr;
typedef unsigned int Elf_Off;

struct Elf_Ehdr
{
    /** e_ident [EI_NIDENT]
     * 包含了Maigc Number和其它信息，共16字节。
     * 0~3：前4字节为Magic Number，固定为ELFMAG。
     * 4（EI_CLASS）：ELFCLASS32代表是32位ELF，ELFCLASS64 代表64位ELF。
     * 5（EI_DATA）：ELFDATA2LSB代表小端，ELFDATA2MSB代表大端。
     * 6（EI_VERSION）：固定为EV_CURRENT（1）。
     * 7（EI_OSABI）：操作系统ABI标识（实际未使用）。
     * 8（EI_ABIVERSION）：ABI版本（实际 未使用）。
     * 9~15：对齐填充，无实际意义。
     */
    unsigned char e_ident[EI_NIDENT]; /* Magic number and other info */
    /**
     * ELF的文件类型，定义如下：
     * ET_REL		可重定位文 件（如目标文件）
     * ET_EXEC	        可执行文件（可直接执行的文件）
     * DT_DYN	        共享目标文件（如SO库）
     * DT_CORE	        Core文件（吐核文件）
     * 注：GCC使用编译选项 -pie 编译的可执行文件实际 也是DT_DYN类型。
     */
    Elf_Half e_type;      /* Object file type */
    Elf_Half e_machine;   /* Architecture */
    Elf_Word e_version;   /* Object file version */
    Elf_Addr e_entry;     /* Entry point virtual address */
    Elf_Off e_phoff;      /* Program header table file offset */
    Elf_Off e_shoff;      /* Section header table file offset */
    Elf_Word e_flags;     /* Processor-specific flags */
    Elf_Half e_ehsize;    /* ELF header size in bytes */
    Elf_Half e_phentsize; /* Program header table entry size */
    Elf_Half e_phnum;     /* Program header table entry count */
    Elf_Half e_shentsize; /* Section header table entry size */
    Elf_Half e_shnum;     /* Section header table entry count */
    Elf_Half e_shstrndx;  /* Section header string table index */
};
