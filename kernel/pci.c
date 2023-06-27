/*
 * @Author       : Outsider
 * @Date         : 2023-03-03 15:17:15
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-05-25 16:57:12
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
    // struct PCIREG *tt;
    for (int devno = 0; devno < 32; devno++)
    {
        uint32 off = (devno << 11);
        uint32 *base = ((uint32 *)PCIE_ECAN + off);

        struct PCIREG *reg = (struct PCIREG *)base;

        if (reg->VendorID == 0x8086 && reg->DeviceID == 0x100e)
        {
            // tt = reg;
            // Table 4.3
            /*Bit(s) InitialValue Description
                0 0b I/O Access Enable.
                1 0b Memory Access Enable.
                2 0b Enable Mastering. Ethernet controller in PCI-X
                     mode is permitted to initiate a split completion
                     transaction regardless of the state of this bit.
                3 0b Special Cycle Monitoring.
                4 0b Memory Write and Invalidate Enable (not
                     applicable to the 82547GI/EI).
                5 0b Palette Snoop Enable.
                6 0b Parity Error Response (not applicable to the
                     82547GI/EI).
                7 0b Wait Cycle Enable.
                8 0b SERR# Enable (not applicable to the 82547GI/EI).
                9 0b Fast Back-to-Back Enable.
                10a 0b Interrupt Disable (INTA# or CSA signaled).
                15:10[15:11] 0b Reserved.
            */
            reg->Command = 7;
            reg->BaseAddress0 = E1000_BASE;
            ethinit((uint32 *)E1000_BASE);
        }
    }
    // printf("--%d\n", eth_read(E1000_EERD));
    // printf("--%d\n", eth_read(E1000_EECD));
    // printf("%d\n", tt->Status);
}
