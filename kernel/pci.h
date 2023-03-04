/*
 * @Author       : Outsider
 * @Date         : 2022-09-02 14:52:08
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-03-04 15:00:30
 * @Description  :
 *
 *  e1000
 *  refs : https://pdos.csail.mit.edu/6.828/2021/readings/8254x_GBe_SDM.pdf
 *
 * @FilePath     : /los/kernel/pci.h
 */
#include "types.h"

#define PCIE_ECAN 0x30000000

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
