/*
 * @Author: Outsider
 * @Date: 2022-08-07 15:58:24
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-27 10:34:18
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/mmio.c
 */
#include "types.h"
#include "defs.h"
#include "mmio.h"
#include "vm.h"
#include "buf.h"
#include "lock.h"

struct disk
{
    /**
     * @description: 保存 virtqueue, 2 个或 2 个以上页
     * layout:                           ALIGN(PAGESIZE)
     *          [ desc | avail ...(padding)...| used ]
     */
    uint8 pages[2 * PGSIZE];

    // 描述符表
    /**
     * @description:
     * virtq_desc描述一个缓冲区
     * desc 为缓冲区链表
     */
    struct virtq_desc *desc;

    // 可用环形缓冲区
    struct virtq_avail *avail;
    // 已用环形缓冲区
    struct virtq_used *used;

    struct virtio_blk_req req[DNUM];

    uint8 free[DNUM];

    struct
    {
        struct buf *buf;
        uint8 status;
    } info[DNUM];

    uint16 last_used;

    struct spinlock spinlock;
} __attribute__((aligned(PGSIZE))) disk;

void mmioinit()
{
#ifdef DEBUG
    printf("mmio_magicvalue: %x\n", mmio_read(MMIO_MagicValue));
    printf("mmio_version: %x\n", mmio_read(MMIO_Version));
    printf("mmio_vendorID: %x\n", mmio_read(MMIO_VendorID));
    printf("mmio_deviceID: %x\n", mmio_read(MMIO_DeviceID));
    printf("mmio_disk.pages: %x\n", &disk);
#endif
    initspinlock(&disk.spinlock, "disk_spinlock");

    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
        mmio_read(MMIO_Version) != 0x01 ||
        mmio_read(MMIO_DeviceID) != 0x02 ||
        mmio_read(MMIO_VendorID) != 0x554d4551)
    {
        panic("virtio mmio disk!");
    }

    uint32 status = 0;
    status |= MMIO_STATUS_ACKNOWLEDGE; // 表明当前已经识别到了设备
    mmio_write(MMIO_Status, status);

    status |= MMIO_STATUS_DRIVER; // 表明驱动程序知道如何驱动当前设备
    mmio_write(MMIO_Status, status);

    uint32 features = mmio_read(MMIO_DeviceFeatures);
    features &= ~(1 << MMIO_FEATURES_RO);   // 不支持只读
    features &= ~(1 << MMIO_FEATURES_SCSI); // 不支持 SCSI
    features &= ~(1 << MMIO_FEATURES_CONFIG_WCE);
    features &= ~(1 << MMIO_FEATURES_MQ);
    features &= ~(1 << MMIO_FEATURES_ANY_LAYOUT);
    features &= ~(1 << MMIO_RING_FEATURES_INDIRECT_DESC);
    features &= ~(1 << MMIO_RING_FEATURES_EVENT_IDX);
    mmio_write(MMIO_DeviceFeatures, features);

    status |= MMIO_STATUS_FEATURES_OK; // 特征设置成功
    mmio_write(MMIO_Status, status);

    status |= MMIO_STATUS_DRIVER_OK; // 驱动准备完毕
    mmio_write(MMIO_Status, status);

    mmio_write(MMIO_GusetPAGESIZE, PGSIZE);

    mmio_write(MMIO_QueueSel, 0); // 选择[0]队列作为 disk IO队列
    if (mmio_read(MMIO_QueueNumMax) < DNUM)
        panic("mmio : QueueNumMax");
    mmio_write(MMIO_QueueNum, DNUM); // 设置队列大小

    memset(disk.pages, 0, sizeof(disk.pages));
    mmio_write(MMIO_QueuePFN, ((uint32)disk.pages) >> 12);

    disk.desc = (struct virtq_desc *)disk.pages;
    disk.avail = (struct virtq_avail *)(disk.pages + DNUM * sizeof(struct virtq_desc));
    disk.used = (struct virtq_used *)(disk.pages + PGSIZE);

    disk.last_used = 0;

    for (int i = 0; i < DNUM; i++)
        disk.free[i] = 1;

#ifdef DEBUG
    printf("mmio_disk.pages: %x\n", disk.desc);
    printf("mmio_disk.pages: %x\n", disk.avail);
    printf("mmio_disk.pages: %x\n", disk.used);
#endif
}

uint8 alloc_desc()
{
    for (int i = 0; i < DNUM; i++)
        if (disk.free[i])
        {
            disk.free[i] = 0;
            return i;
        }
    return -1;
}

uint8 alloc3_desc(int idx[])
{
    for (int i = 0; i < 3; i++)
    {
        idx[i] = alloc_desc();
        if (idx[i] < 0)
            return -1;
    }
    return 0;
}

void free_desc(int idx)
{
    assert(idx < DNUM);
    assert(disk.free[idx] == 0);
    disk.free[idx] = 1;
    disk.desc[idx].addr = 0;
    disk.desc[idx].len = 0;
    disk.desc[idx].flags = 0;
    disk.desc[idx].next = 0;
}

void free_all_desc(int idx)
{
    int flag;
    int id;
    while (1)
    {
        flag = disk.desc[idx].flags;
        id = disk.desc[idx].next;
        free_desc(idx);
        if (flag & VIRTQ_DESC_F_NEXT)
            idx = id;
        else
            break;
    }
}

void diskrw(struct buf *b, uint8 rw)
{
#define SECSIZE 512
    uint64 sector = b->bno * (BSIZE / SECSIZE);

    if (nowproc() != 0)
        acquirespinlock(&disk.spinlock);

    /**
     * @description: 磁盘 IO 使用三个描述符
     * [0] 一个包含类型、保留和扇区的8字节描述符，
     * [1] 用于数据的描述符，
     * [2] 用于状态的单独的1字节描述符。
     */
    int idx[3];
    alloc3_desc(idx);

#ifdef DEBUG_MMIO
    printf("disk.desc[3]: ");
    for (int i = 0; i < 3; i++)
        printf("%d ", idx[i]);
    printf("\n");
#endif

    struct virtio_blk_req *buf = &disk.req[idx[0]];

    if (rw)
        buf->type = VIRTIO_BLK_T_OUT; // 写磁盘
    else
        buf->type = VIRTIO_BLK_T_IN; // 读磁盘
    buf->reserved = 0;
    buf->sector = sector;

    disk.desc[idx[0]].addr = (uint32)buf;
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    disk.desc[idx[0]].flags = VIRTQ_DESC_F_NEXT;
    disk.desc[idx[0]].next = idx[1];

    disk.desc[idx[1]].addr = (uint32)b->data;
    disk.desc[idx[1]].len = BSIZE;
    if (rw)
        disk.desc[idx[1]].flags = 0;
    else
        disk.desc[idx[1]].flags = VIRTQ_DESC_F_WRITE;
    disk.desc[idx[1]].flags |= VIRTQ_DESC_F_NEXT;
    disk.desc[idx[1]].next = idx[2];

    disk.info[idx[0]].status = 0xff;

    disk.desc[idx[2]].addr = (uint32)&disk.info[idx[0]].status;
    disk.desc[idx[2]].len = 1;
    disk.desc[idx[2]].flags = VIRTQ_DESC_F_WRITE; // device writes the status
    disk.desc[idx[2]].next = 0;

    b->disk = 1;
    disk.info[idx[0]].buf = b;

    // 设置首个描述符索引
    disk.avail->ring[disk.avail->idx % DNUM] = idx[0];

    __sync_synchronize();

    disk.avail->idx += 1; // 更新 idx

    __sync_synchronize();

    mmio_write(MMIO_QueueNotify, 0); // 写入队列索引，通知设备队列处理新的缓冲区

    if (nowproc() == 0)
        while (disk.info[idx[0]].status != 0x0)
            ;
    else
        while (b->disk == 1)
            sleep(b, &disk.spinlock);

    disk.info[idx[0]].buf = 0;

    free_all_desc(idx[0]);

    if (nowproc() != 0)
        releasespinlock(&disk.spinlock);
}

/**
 * @description: 处理 virtio_mmio disk IO 中断处理
 */
void diskintr()
{
    if (nowproc() != 0)
        acquirespinlock(&disk.spinlock);

#define MMIO_INTR_USED_BUF_BIT 0 // MMIO_InterruptStatus 寄存器使用缓冲位
#define MMIO_INTR_CHAN_CON_BIT 1 // MMIO_InterruptStatus 配置更改位
    uint32 intrstatus = mmio_read(MMIO_InterruptStatus);
    // 通知已注意到中断
    mmio_write(MMIO_InterruptACK, intrstatus | ~(1 << MMIO_INTR_USED_BUF_BIT));

    __sync_synchronize();

    while (disk.last_used != disk.used->idx)
    {
        __sync_synchronize();

        int id = disk.used->ring[disk.last_used % DNUM].id;

        __sync_synchronize();

        assert((disk.info[id].status) == 0x0);

        struct buf *b = disk.info[id].buf;
        b->disk = 0;

        wakeup(b);

        disk.last_used++;
    }

    if (nowproc() != 0)
        releasespinlock(&disk.spinlock);
}