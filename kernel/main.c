/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-12 14:46:09
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"
#include "buf.h"

void main()
{
    printf("start run main()\n");

    minit();    // 物理内存管理
    plicinit(); // PLIC 中断处理

    kvminit(); // 启动虚拟内存

#ifdef DEBUG
    printf("usertrap: %p\n", usertrap);
#endif

    procinit();

    userinit();

    mmioinit();

    bufinit();

    struct buf* b;
    b=bufget(1);
    uint16 magic=*(uint16*)b->data;
    printf("%x\n",magic);

    assert(magic==0xEF53);

    printf("----------------------\n");
    schedule();
}
