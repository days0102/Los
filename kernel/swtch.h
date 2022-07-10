/*
 * @Author: Outsider
 * @Date: 2022-07-10 17:55:14
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-10 23:15:35
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/swtch.h
 */

#include "types.h"

struct context
{
    /* data */
    regt ra;
	regt sp;
	regt gp;
	regt tp;
	regt a0;
	regt a1;
	regt a2;
	regt a3;
	regt a4;
	regt a5;
	regt a6;
	regt a7;
	regt s0;
	regt s1;
	regt s2;
	regt s3;
	regt s4;
	regt s5;
	regt s6;
	regt s7;
	regt s8;
	regt s9;
	regt s10;
	regt s11;
	regt t0;
	regt t1;
	regt t2;
	regt t3;
	regt t4;
	regt t5;
	regt t6;
};

void swtch(struct context*,struct context*);
