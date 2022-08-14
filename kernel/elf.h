/*
 * @Author: Outsider
 * @Date: 2022-08-13 08:07:54
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-13 20:50:07
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/elf.h
 */
#include "types.h"

#define EI_NIDENT (16)

typedef unsigned short Elf32_Half;
typedef unsigned int Elf32_Word;
typedef unsigned int Elf32_Addr;
typedef unsigned int Elf32_Off;

struct Elf32_Ehdr
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
    /** 名称        取值        含义
     **/
#define ET_NONE 0x0000      // 未知目标文件格式
#define ET_ERL 0x0001       // 可重定位文件
#define ET_EXEC 0x0002      // 可执行文件
#define ET_DYN 0x0003       // 共享目标文件
#define ET_CORE 0x0004      // Core文件(转储格式)
#define ET_LOPROC 0xff00    // 特定处理器文件
#define ET_HIPROC 0xffff    // 特定处理器文件
    Elf32_Half e_type;      /* Object file type */
    Elf32_Half e_machine;   /* Architecture */
    Elf32_Word e_version;   /* Object file version */
    Elf32_Addr e_entry;     /* Entry point virtual address */
    Elf32_Off e_phoff;      /* Program header table file offset */
    Elf32_Off e_shoff;      /* Section header table file offset */
    Elf32_Word e_flags;     /* Processor-specific flags */
    Elf32_Half e_ehsize;    /* ELF header size in bytes */
    Elf32_Half e_phentsize; /* Program header table entry size */
    Elf32_Half e_phnum;     /* Program header table entry count */
    Elf32_Half e_shentsize; /* Section header table entry size */
    Elf32_Half e_shnum;     /* Section header table entry count */
    Elf32_Half e_shstrndx;  /* Section header string table index */
};

struct Elf32_Phdr
{
#define PT_NULL 0        //空段
#define PT_LOAD 1        //可装载段
#define PT_DYNAMIC 2     //表示该段包含了用于动态连接器的信息
#define PT_INTERP 3      //表示当前段指定了用于动态连接的程序解释器，通常是ld-linux.so
#define PT_NOTE 4        //该段包含有专有的编译器信息
#define PT_SHLIB 5       //该段包含有共享库
    Elf32_Word p_type;   /* Segment type */
    Elf32_Off p_offset;  /* Segment file offset */
    Elf32_Addr p_vaddr;  /* Segment virtual address */
    Elf32_Addr p_paddr;  /* Segment physical address */
    Elf32_Word p_filesz; /* Segment size in file */
    Elf32_Word p_memsz;  /* Segment size in memory */
#define PF_R 0x4         //该段可读
#define PF_W 0x2         //该段可写
#define PF_X 0x1         //该段可执行
    Elf32_Word p_flags;  /* Segment flags */
    //指定了段在内存和二进制文件当中的对齐方式，即p_offset和p_vaddr必须是p_align的整数倍
    Elf32_Word p_align; /* Segment alignment */
};

struct Elf32_Shdr
{
    Elf32_Word sh_name;      /* Section name (string tbl index) */
    Elf32_Word sh_type;      /* Section type */
    Elf32_Word sh_flags;     /* Section flags */
    Elf32_Addr sh_addr;      /* Section virtual addr at execution */
    Elf32_Off sh_offset;     /* Section file offset */
    Elf32_Word sh_size;      /* Section size in bytes */
    Elf32_Word sh_link;      /* Link to another section */
    Elf32_Word sh_info;      /* Additional section information */
    Elf32_Word sh_addralign; /* Section alignment */
    Elf32_Word sh_entsize;   /* Entry size if section holds table */
};
