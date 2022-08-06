/*
 * @Author: Outsider
 * @Date: 2022-07-10 17:55:14
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-06 18:44:51
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/swtch.h
 */

#include "types.h"

struct context
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
