/*
 * @Author       : Outsider
 * @Date         : 2022-07-10 17:55:14
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-05-26 15:49:42
 * @Description  :
 * ***********************************
 * 上下文状态，用于进程调度跳转到内核调度器
 * 和返回到切换后的进程在内核的执行流
 * 更换 ra 后 ret 即会跳转到 ra 的地址处
 * 其他寄存器(sp...)也需要更换
 * 1.进程由中断进入内核态时，如果是时间片耗尽
 * 	 此时进程需要放弃CPU，并跳转到调度器调度
 * 	 下一个进程，
 * 2.CPU选中要运行的进程后，又会加载该进程的
 *  上下文，跳转到该进程上次最后持有CPU的状态
 * 系统第一个进程设置为返回到用户空间的函数
 * ***********************************
 * @FilePath     : /los/kernel/swtch.h
 */

#include "types.h"

struct context // 执行流的上下文状态
{
	/* data */
	reg_t ra; // 0
	reg_t sp; // 4
	reg_t gp; // 8
	reg_t tp; // 12
	reg_t a0; // 16
	reg_t a1; // 20
	reg_t a2; // 24
	reg_t a3; // 28
	reg_t a4;
	reg_t a5;
	reg_t a6;
	reg_t a7;
	reg_t s0;
	reg_t s1;
	reg_t s2;
	reg_t s3;
	reg_t s4;
	reg_t s5;
	reg_t s6;
	reg_t s7;
	reg_t s8;
	reg_t s9;
	reg_t s10;
	reg_t s11;
	reg_t t0;
	reg_t t1;
	reg_t t2;
	reg_t t3;
	reg_t t4;
	reg_t t5;
	reg_t t6;
};
