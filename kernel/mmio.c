/*
 * @Author: Outsider
 * @Date: 2022-08-07 15:58:24
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-08 09:33:05
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/mmio.c
 */
#include "types.h"
#include "defs.h"
#include "mmio.h"

void mmioinit()
{
#ifdef DEBUG
    printf("mmio_magicvalue: %x\n", mmio_read(MMIO_MagicValue));
    printf("mmio_version: %x\n", mmio_read(MMIO_Version));
    printf("mmio_vendorID: %x\n", mmio_read(MMIO_VendorID));
    printf("mmio_deviceID: %x\n", mmio_read(MMIO_DeviceID));
#endif

    if (mmio_read(MMIO_MagicValue) != 0x74726976 ||
        mmio_read(MMIO_Version) != 0x01 ||
        mmio_read(MMIO_DeviceID) != 0x02 ||
        mmio_read(MMIO_VendorID) != 0x554d4551)
    {
        panic("virtio mmio disk!");
    }
}