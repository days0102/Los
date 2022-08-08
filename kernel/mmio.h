/*
 * @Author: Outsider
 * @Date: 2022-08-07 15:03:12
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-08 12:57:03
 * @Description: virtio disk mmio
 * @FilePath: /los/kernel/mmio.h
 */

//* virtio disk mmio
#include "types.h"

#define VIRTIO_BASE 0x10001000

#define MMIO_MagicValue 0x000     // 只读寄存器 0x74726976
#define MMIO_Version 0x004        // 只读寄存器 0x02
#define MMIO_DeviceID 0x008       // 设备ID 块设备为2
#define MMIO_VendorID 0x00c       // 只读
#define MMIO_DeviceFeatures 0x010 // DeviceFeaturesSel ∗ 32 to (DeviceFeaturesSel ∗ 32)+31
#define MMIO_DeviceFeaturesSel 0x014
#define MMIO_DriverFeatures 0x020
#define MMIO_DriverFeaturesSel 0x024
#define MMIO_GusetPAGESIZE 0x028
#define MMIO_QueueSel 0x030        // 写入该寄存器将选择一个虚拟队列 [0]
#define MMIO_QueueNumMax 0x034     /** 从寄存器中读取将返回设备准备处理的队列的最大大小(元素的数量)，  \
                                    *  如果队列不可用则返回0 (0x0)。这适用于通过写入QueueSel而选择的队列。 \
                                    **/
#define MMIO_QueueNum 0x038        // 写入该寄存器将通知设备驱动程序将使用的队列大小
#define MMIO_QueueAlign 0x03c      // used ring alignment, write-only
#define MMIO_QueuePFN 0x040        // physical page number for queue, read/write
#define MMIO_QueueReady 0x044      /** 向这个寄存器写入一个(0x1)，通知设备它可以执行来自这个虚拟队列的请求。 \
                                    *  从这个寄存器读入将返回最后一个写入该寄存器的值。                              \
                                    *  读和写访问都应用于写入QueueSel所选择的队列。                                        \
                                    **/
#define MMIO_QueueNotify 0x050     // 向该寄存器写入值将通知设备队列中有新的缓冲区要处理。
#define MMIO_InterruptStatus 0x060 // read-only
#define MMIO_InterruptACK 0x064    // 将一个在InterruptStatus中定义的位值写入该寄存器，
                                   // 通知设备引起中断的事件已经被处理。
#define MMIO_Status 0x070          // 从这个寄存器读取将返回当前设备状态标志。向该寄存器写入非零值
                                   // 将设置状态标志，指示驱动程序进程。
                                   // 向这个寄存器写入0 (0x0)会触发设备复位。

#define MMIO_REG(reg) ((volatile uint32 *)(VIRTIO_BASE + (reg)))
#define mmio_read(reg) (*(MMIO_REG(reg)))
#define mmio_write(reg, val) ((*(MMIO_REG(reg))) = (val))

// status 寄存器位含义
#define MMIO_STATUS_ACKNOWLEDGE 1         // 表示系统已经找到该设备
#define MMIO_STATUS_DRIVER 2              /** 表示系统已经知道如何驱动设备                           \
                                           *  在设置此位之前，可能有一个显著(或无限)的延迟。 \
                                           *  例如，在Linux下，驱动程序可以是可加载的模块。    \
                                           **/
#define MMIO_STATUS_DRIVER_OK 4           // 指示驱动程序已设置好并准备驱动设备。
#define MMIO_STATUS_FEATURES_OK 8         //表示驱动程序已经承认了它所理解的所有特性，并且特性协商已经完成。
#define MMIO_STATUS_DEVICE_NEEDS_RESET 64 // 表示设备出现了无法修复的错误
#define MMIO_STATUS_FAILED 128            /** 指示客户机中出现了错误，并且它已经放弃了设备。          \
                                           *  这可能是一个内部错误，或者驱动程序因为某些原因          \
                                           *  不喜欢这个设备，甚至是设备操作过程中的一个致命错误。 \
                                           **/

#define MMIO_FEATURES_RO 5          /* Disk is read-only */
#define MMIO_FEATURES_SCSI 7        /* Supports scsi command passthru */
#define MMIO_FEATURES_CONFIG_WCE 11 /* Writeback mode available in config */
#define MMIO_FEATURES_MQ 12         /* support more than one vq */
#define MMIO_FEATURES_ANY_LAYOUT 27
#define MMIO_RING_F_INDIRECT_DESC 28
#define MMIO_RING_F_EVENT_IDX 29

/*
This file is also available at the link https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/listings/virtio_queue.h.
All definitions in this section are for non-normative reference only.
*/
#ifndef VIRTQUEUE_H
#define VIRTQUEUE_H
/* An interface for efficient virtio implementation.
 *
 * This header is BSD licensed so anyone can use the definitions
 * to implement compatible drivers/servers.
 *
 * Copyright 2007, 2009, IBM Corporation
 * Copyright 2011, Red Hat, Inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 3. Neither the name of IBM nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */
/* This marks a buffer as continuing via the next field. */
#define VIRTQ_DESC_F_NEXT 1
/* This marks a buffer as write-only (otherwise read-only). */
#define VIRTQ_DESC_F_WRITE 2
/* This means the buffer contains a list of buffer descriptors. */
#define VIRTQ_DESC_F_INDIRECT 4
/* The device uses this in used->flags to advise the driver: don't kick me
 * when you add a buffer. It's unreliable, so it's simply an
 * optimization. */
#define VIRTQ_USED_F_NO_NOTIFY 1
/* The driver uses this in avail->flags to advise the device: don't
 * interrupt me when you consume a buffer. It's unreliable, so it's
 * simply an optimization. */
#define VIRTQ_AVAIL_F_NO_INTERRUPT 1
/* Support for indirect descriptors */
#define VIRTIO_F_INDIRECT_DESC 28
/* Support for avail_event and used_event fields */
#define VIRTIO_F_EVENT_IDX 29
/* Arbitrary descriptor layouts. */
#define VIRTIO_F_ANY_LAYOUT 27
/* Virtqueue descriptors: 16 bytes.
 * These can chain together via "next". */
struct virtq_desc
{
    /* Address (guest-physical). */
    uint64 addr;
    /* Length. */
    uint32 len;
    /* The flags as indicated above. */
    uint16 flags;
    /* We chain unused descriptors via this, too */
    uint16 next;
};
struct virtq_avail
{
    uint16 flags;
    uint16 idx;
    uint16 ring[];
    /* Only if VIRTIO_F_EVENT_IDX: uint16 used_event; */
};
/* uint32 is used here for ids for padding reasons. */
struct virtq_used_elem
{
    /* Index of start of used descriptor chain. */
    uint32 id;
    /* Total length of the descriptor chain which was written to. */
    uint32 len;
};
struct virtq_used
{
    uint16 flags;
    uint16 idx;
    struct virtq_used_elem ring[];
    /* Only if VIRTIO_F_EVENT_IDX: uint16 avail_event; */
};
struct virtq
{
    unsigned int num;
    struct virtq_desc *desc;
    struct virtq_avail *avail;
    struct virtq_used *used;
};
static inline int virtq_need_event(uint16 event_idx, uint16 new_idx, uint16 old_idx)
{
    return (uint16)(new_idx - event_idx - 1) < (uint16)(new_idx - old_idx);
}
/* Get location of event indices (only with VIRTIO_F_EVENT_IDX) */
static inline uint16 *virtq_used_event(struct virtq *vq)
{
    /* For backwards compat, used event index is at *end* of avail ring. */
    return &vq->avail->ring[vq->num];
}
static inline uint16 *virtq_avail_event(struct virtq *vq)
{
    /* For backwards compat, avail event index is at *end* of used ring. */
    return (uint16 *)&vq->used->ring[vq->num];
}
#endif /* VIRTQUEUE_H */