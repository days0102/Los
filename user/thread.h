/*
 * @Author       : Outsider
 * @Date         : 2023-08-01 15:40:37
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-08-01 16:05:28
 * @Description  : In User Settings Edit
 * @FilePath     : /los/user/thread.h
 */
#define STACK_SIZE 512
#include "user.h"

enum threadstatus
{
    RUNNING = 0,
    RUNABLE,
    UNUSED
};

struct thread_context
{
    uint64 ra;
    uint64 sp;

    // callee-saved
    uint64 s0;
    uint64 s1;
    uint64 s2;
    uint64 s3;
    uint64 s4;
    uint64 s5;
    uint64 s6;
    uint64 s7;
    uint64 s8;
    uint64 s9;
    uint64 s10;
    uint64 s11;
};

struct thread
{
    char stack[STACK_SIZE];
    enum threadstatus status;
    struct thread_context context;
};

void thread_creatd(struct thread *t, void *func);
void thread_yeid();
