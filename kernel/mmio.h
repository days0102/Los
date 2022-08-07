/*
 * @Author: Outsider
 * @Date: 2022-08-07 15:03:12
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-07 15:57:31
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
#define MMIO_QueueNumMax 0x034     // 从寄存器中读取将返回设备准备处理的队列的最大大小(元素的数量)，
                                   // 如果队列不可用则返回0 (0x0)。这适用于通过写入QueueSel而选择的队列。
#define MMIO_QueueNum 0x038        // 写入该寄存器将通知设备驱动程序将使用的队列大小
#define MMIO_QueueAlign 0x03c      // used ring alignment, write-only
#define MMIO_QueuePFN 0x040        // physical page number for queue, read/write
#define MMIO_QueueReady 0x044      // 向这个寄存器写入一个(0x1)，通知设备它可以执行来自这个虚拟队列的请求。
                                   // 从这个寄存器读入将返回最后一个写入该寄存器的值。
                                   // 读和写访问都应用于写入QueueSel所选择的队列。
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