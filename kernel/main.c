/*
 * @Author: Outsider
 * @Date: 2022-07-10 22:25:45
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-09 22:27:36
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/main.c
 */
#include "riscv.h"
#include "defs.h"
#include "swtch.h"
#include "virtio.h"

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

    char buf[512];
    diskrw(0,1,buf);
    printf("%s\n",buf);
    // virtio_disk_init();
    // struct buf b;
    // virtio_disk_rw(&b, 1);

    printf("----------------------\n");
    schedule();
}
