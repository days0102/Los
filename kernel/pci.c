/*
 * @Author       : Outsider
 * @Date         : 2023-03-03 15:17:15
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-03-04 15:01:39
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/pci.c
 */
#include "types.h"
#include "pci.h"
#include "defs.h"
#include "eth.h"

void pciinit()
{
    // 查找 PCI 总线上的设备
    // ref : https://wiki.osdev.org/PCI#Configuration_Space_Access_Mechanism_.232

    /*  CONFIG_ADDRESS is a 32-bit register
    Bit31	    Bits30-24	Bits23-16	Bits15-11	    Bits10-8	    Bits7-0
    EnableBit	Reserved	BusNumber	DeviceNumber	FunctionNumber	RegisterOffset1
    */
    // 第15到11位选择PCI总线上的特定设备
    struct PCIREG *tt;
    for (int devno = 0; devno < 32; devno++)
    {
        uint32 off = (devno << 11);
        uint32 *base = ((uint32 *)PCIE_ECAN + off);

        struct PCIREG *reg = (struct PCIREG *)base;
        
        if (reg->VendorID == 0x8086 && reg->DeviceID == 0x100e)
        {
            tt = reg;
            // Table 4.3
            reg->Command = 7;
            reg->BaseAddress0 = E1000_BASE;
            ethinit((uint32 *)E1000_BASE);
        }
    }
    printf("%d", tt->Status);
}
