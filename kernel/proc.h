/*
 * @Author: Outsider
 * @Date: 2022-07-18 09:35:47
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-03 13:28:53
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/proc.h
 */
#include "types.h"
#include "swtch.h"

#define NPROC 4

enum procstatus
{
	UNUSED,
	USED,
	RUNABLE,
	RUNNING,
	BLOCKED,
	SLEEPING
};

struct trapframe
{
	reg_t kernel_satp; // 0
	reg_t kernel_tvec; // 4
	reg_t kernel_sp;   // 8

	reg_t epc; // 12

	reg_t ra;  // 16
	reg_t sp;  // 20
	reg_t gp;  // 24
	reg_t tp;  // 28
	reg_t a0;  // 32
	reg_t a1;  // 36
	reg_t a2;  // 40
	reg_t a3;  // 44
	reg_t a4;  // 48
	reg_t a5;  // 52
	reg_t a6;  // 56
	reg_t a7;  // 60
	reg_t s0;  // 64
	reg_t s1;  // 68
	reg_t s2;  // 72
	reg_t s3;  // 76
	reg_t s4;  // 80
	reg_t s5;  // 84
	reg_t s6;  // 88
	reg_t s7;  // 92
	reg_t s8;  // 96
	reg_t s9;  // 100
	reg_t s10; // 104
	reg_t s11; // 108
	reg_t t0;  // 112
	reg_t t1;  // 116
	reg_t t2;  // 120
	reg_t t3;  // 124
	reg_t t4;  // 128
	reg_t t5;  // 132
	reg_t t6;  // 136
};

struct pcb
{
	int pid;
	enum procstatus status;
	struct trapframe *trapframe;
	struct context context;
	addr_t *pagetable;
	addr_t kernelstack;
};

struct pcb proc[NPROC];

struct cpu
{
	struct pcb *proc;		// CPU 持有的进程
	struct context context; // CPU 上下文(正在执行的上下文)
};

#define NCPUS 8

struct cpu cpus[NCPUS];