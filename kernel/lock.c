/*
 * @Author: Outsider
 * @Date: 2022-08-25 08:07:30
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-06 10:07:53
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
    int sintr = a_sstatus_intr(INTR_SIE);
    s_sstatus_intr(~INTR_SIE);
    struct cpu *c = nowcpu();
    if (c->nlock == 0)
        c->sintr = sintr;
    c->nlock += 1;
}

void afterlock()
{
    struct cpu *c = nowcpu();
    if (c->nlock < 0 || a_sstatus_intr(INTR_SIE))
        panic("afterlock");
    c->nlock -= 1;
    if (c->nlock == 0 && c->sintr)
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
#ifdef DEBUG
    struct cpu *c = nowcpu();
    printf("checksipn - cpu: %d\n", c->id);
#endif
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
    if (!checkspinlock(spinlock))
        panic("releasespinlock - no hold spinlock");

    spinlock->cpu = 0;

    __sync_synchronize();

    __sync_lock_release(&spinlock->locked);

    afterlock();
}