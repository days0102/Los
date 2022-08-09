/*
 * @Author: Outsider
 * @Date: 2022-08-07 15:58:24
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-09 14:43:56
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/mmio.c
 */
#include "types.h"
#include "defs.h"
#include "mmio.h"
#include "vm.h"

struct disk
{
    uint8 pages[3 * PGSIZE];

    // 描述符表
    /**
     * @description:
     * 描述一个缓冲区
     */
    struct virtq_desc *desc;

    // 可用环形缓冲区
    struct virtq_avail *avail;
    // 已用环形缓冲区
    struct virtq_used *used;

    struct virtio_blk_req req[DNUM];

    uint8 free[DNUM];
} disk;

void mmioinit()
{
#ifdef DEBUG
    printf("mmio_magicvalue: %x\n", mmio_read(MMIO_MagicValue));
    printf("mmio_version: %x\n", mmio_read(MMIO_Version));
    printf("mmio_vendorID: %x\n", mmio_read(MMIO_VendorID));
    printf("mmio_deviceID: %x\n", mmio_read(MMIO_DeviceID));
    printf("mmio_disk.pages: %x\n", &disk);
#endif

    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
        mmio_read(MMIO_Version) != 0x01 ||
        mmio_read(MMIO_DeviceID) != 0x02 ||
        mmio_read(MMIO_VendorID) != 0x554d4551)
    {
        panic("virtio mmio disk!");
    }

    uint32 status = mmio_read(MMIO_Status);
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

    mmio_write(MMIO_QueueSel, 0);
    if (mmio_read(MMIO_QueueNumMax) < DNUM)
        panic("mmio : QueueNumMax");
    mmio_write(MMIO_QueueNum, DNUM); // 设置队列大小

    memset(disk.pages, 0, sizeof(disk.pages));
    disk.desc = (struct virtq_desc *)&disk.pages[0];
    disk.avail = (struct virtq_avail *)&disk.pages[1];
    disk.used = (struct virtq_used *)&disk.pages[2];

    for (int i = 0; i < DNUM; i++)
        disk.free[i] = 1;
}

uint8 alloc_desc()
{
    for (int i = 0; i < DNUM; i++)
        if (disk.free[i])
            return i;
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

void diskrw(uint32 sector, uint8 rw, char b[])
{
    int idx[3];
    alloc3_desc(idx);
#ifdef DEBUG
    for (int i = 0; i < 3; i++)
        printf("%d ", idx[i]);
    printf("\n");
#endif

    struct virtio_blk_req *buf = &disk.req[idx[0]];

    switch (rw)
    {
    case VIRTIO_BLK_T_IN:
        buf->type = VIRTIO_BLK_T_IN;
        break;
    case VIRTIO_BLK_T_OUT:
        buf->type = VIRTIO_BLK_T_OUT;
        break;
    default:
        break;
    }
    buf->reserved = 0;
    buf->sector = sector;

    disk.desc[idx[0]].addr = (uint32)buf;
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    disk.desc[idx[0]].flags = VIRTQ_DESC_F_NEXT;
    disk.desc[idx[0]].next = idx[1];

    disk.desc[idx[1]].addr = (uint32)b;
    disk.desc[idx[1]].len = 512;
    switch (rw)
    {
    case VIRTIO_BLK_T_IN:
        disk.desc[idx[1]].flags = 0;
        break;
    case VIRTIO_BLK_T_OUT:
        disk.desc[idx[1]].flags = VIRTQ_DESC_F_WRITE;
        break;
    default:
        break;
    }
    disk.desc[idx[1]].flags |= VIRTQ_DESC_F_NEXT;
    disk.desc[idx[1]].next = idx[2];

    buf->status = 0xff;

    disk.desc[idx[2]].addr = (uint32)&buf->status;
    disk.desc[idx[2]].len = 1;
    disk.desc[idx[2]].flags = VIRTQ_DESC_F_WRITE; // device writes the status
    disk.desc[idx[2]].next = 0;

    disk.avail->ring[disk.avail->idx % DNUM] = idx[0];

    // tell the device another avail ring entry is available.
    disk.avail->idx += 1; // not % NUM ...

    mmio_write(MMIO_QueueNotify, 0); // value is queue number
}