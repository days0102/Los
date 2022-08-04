/*
 * @Author: Outsider
 * @Date: 2022-08-04 16:45:25
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-04 21:34:01
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/syscall.h
 */
#include "types.h"

// 系统调用号
#define SYS_fork 1
#define SYS_exec 2

extern uint32 sys_fork(void);
extern uint32 sys_exec(void);
