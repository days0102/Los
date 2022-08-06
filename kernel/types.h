/*
 * @Author: Outsider
 * @Date: 2022-07-08 17:56:58
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-06 18:45:20
 * @Description: 定义数据类型
 * @FilePath: /los/kernel/types.h
 */
#ifndef __TYPES
#define __TYPES

typedef unsigned int uint;
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned int uint32;
typedef unsigned long long uint64;

typedef unsigned int reg_t;        // 32bit register
typedef unsigned long long size_t; // 64bit index

typedef unsigned int pte_t;  // 32bit PTE
typedef unsigned int addr_t; // 32bit address;

#endif