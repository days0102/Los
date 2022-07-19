/*
 * @Author: Outsider
 * @Date: 2022-07-15 16:35:56
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-19 16:04:23
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/vm.h
 */
#include "types.h"

#ifndef PGSIZE
#define PGSIZE 4096
#endif

#define MAXVM 0xffffffff        // 虚拟内存
#define KSPACE 0xc0000000       // 内核空间起始地址
#define KSTACK 0xc0002000

#define BASE_ADDR 0x80000000

#define PTE_V   (1<<0)  // 是否有效
#define PTE_R   (1<<1)  // 读权限
#define PTE_W   (1<<2)  // 写权限
#define PTE_X   (1<<3)  // 执行权限
#define PTE_U   (1<<4)  // 用户是否可操作
#define PTE_G   (1<<5)  // 全局
#define PTE_A   (1<<6)  // 是否被使用
#define PTE_D   (1<<7)  // 是否已写回
#define PTE_RSW (3<<8)

#define VPN_MASK    (0x3ff) // 10bit
#define OFFSET_MASK (0xfff) // 12bit

#define PA2PTE(pa)  ((((addr_t)pa)>>12)<<10)
#define PTE2PA(pte) ((((addr_t)pte)>>10)<<12)

#define VPN(level,va)  (((addr_t)va>>(12+(level)*10))&VPN_MASK)
#define PPN(level,pa)  ((pa>>(12+(level)*10))&VPN_MASK)