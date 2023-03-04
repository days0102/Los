/*
 * @Author       : Outsider
 * @Date         : 2023-03-03 15:17:15
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-03-04 12:41:15
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/pci.c
 */
#include "types.h"
#include "pci.h"
#include "defs.h"

// E1000 : https://pdos.csail.mit.edu/6.828/2021/readings/8254x_GBe_SDM.pdf
struct PCIREG
{
    // 8254x_GBe_SDM (Table 4-1. Mandatory PCI Registers)
    uint32 VendorID : 16;
    uint32 DeviceID : 16;
    uint32 Command : 16;
    uint32 Status : 16;
    uint32 RevisionID : 8;
    uint32 ClassCode : 24; // 020000h
    uint32 CacheLineSize : 8;
    uint32 LatencyTimer : 8;
    uint32 HeaderType : 8; // (00h)
    uint32 BIST : 8;       // (00h)
    uint32 BaseAddress0;
    uint32 BaseAddress1;
    uint32 BaseAddress2;
    uint32 BaseAddress3;      //(unused)
    uint32 BaseAddress4;      //(unused)
    uint32 BaseAddress5;      //(unused)
    uint32 CardbusCISPointer; // (not used)
    uint32 SubsystemVendorID : 16;
    uint32 SubsystemID : 16;
    uint32 ExpansionROMBaseAddress;
    uint32 Cap_Ptr : 16;
    uint32 Reserved0 : 16;
    uint32 Reserved1;
    uint32 InterruptLine : 8;
    uint32 InterruptPin : 8; //(01h)
    uint32 Min_Grant : 8;    //(FFh)
    uint32 Max_Latency : 8;  //(00h)
};

void pciinit()
{
    // 查找 PCI 总线上的设备
    // ref : https://wiki.osdev.org/PCI#Configuration_Space_Access_Mechanism_.232

    /*  CONFIG_ADDRESS is a 32-bit register
    Bit31	    Bits30-24	Bits23-16	Bits15-11	    Bits10-8	    Bits7-0
    EnableBit	Reserved	BusNumber	DeviceNumber	FunctionNumber	RegisterOffset1
    */
    // 第15到11位选择PCI总线上的特定设备
    for (int devno = 0; devno < 32; devno++)
    {
        uint32 off = (devno << 11);
        uint32 *base = ((uint32 *)PCIE_ECAN + off);

        struct PCIREG *reg = (struct PCIREG *)base;
        if (reg->VendorID == 0x8086 && reg->DeviceID == 0x100e)
        {
            // Table 4.3
            reg->Command = 7;
            reg->BaseAddress0 = E1000_BASE;
            netinit((uint32 *)E1000_BASE);
        }
    }
}

void netinit(uint32 *addr)
{
    
}