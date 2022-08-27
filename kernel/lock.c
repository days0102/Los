/*
 * @Author: Outsider
 * @Date: 2022-08-25 08:07:30
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-27 16:07:16
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/lock.c
 */
#include "types.h"
#include "proc.h"
#include "lock.h"
#include "riscv.h"
#include "defs.h"

void beforelock()
{
    struct cpu *c = nowcpu();
    s_sstatus_intr(~INTR_SIE);
    c->lockdepth += 1;
}

void afterlock()
{
    struct cpu *c = nowcpu();
    if (c->lockdepth < 0)
        panic("afterlock");
    c->lockdepth -= 1;
    if (c->lockdepth == 0)
        s_sstatus_intr(INTR_SIE);
}

void initspinlock(struct spinlock *spinlock, char *name)
{
    spinlock->name = name;
    spinlock->cpu = 0;
    spinlock->locked = 0;
}

int checkspinlock(struct spinlock *spinlock)
{
    int r;
    r = ((spinlock->locked) && (spinlock->cpu == nowcpu()));
    return r;
}

void acquirespinlock(struct spinlock *spinlock)
{
    beforelock();

    if (checkspinlock(spinlock))
        panic("acquirespinlock - hold spinlock");

    while (__sync_lock_test_and_set(&spinlock->locked, 1))
        ;

    __sync_synchronize();

    spinlock->cpu = nowcpu();
}

void releasespinlock(struct spinlock *spinlock)
{
    int r = checkspinlock(spinlock);
    struct cpu *c = nowcpu();
    if (!r)
        panic("releasespinlock - no hold spinlock");

    spinlock->cpu = 0;

    __sync_synchronize();

    __sync_lock_release(&spinlock->locked);

    afterlock();
}