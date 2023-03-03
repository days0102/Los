/*
 * @Author       : Outsider
 * @Date         : 2022-09-02 14:52:08
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-03-03 11:09:47
 * @Description  : 
 * 
 *  e1000
 *  refs : https://pdos.csail.mit.edu/6.828/2021/readings/8254x_GBe_SDM.pdf
 * 
 * @FilePath     : /los/kernel/pci.h
 */
#include "types.h"

// 网卡驱动接收描述符
struct receivedesc
{
    uint64 addr;     // 缓存区地址
    uint16 len;      // 存进缓冲区的数据长度
    uint16 checksum; // 数据检验和
    uint8 status;    // 表明描述符是否被使用，以及引用的缓冲区是否是最后一个
    uint8 errors;    // 坏包
    uint16 special;  // 额外的信息(VLAN)
};

// 网卡驱动发送描述符
struct transmitdesc
{
    uint64 addr;   // 缓冲区地址
    uint16 len;    // 数据长度
    uint8 cso;     // 检验和偏移 chechsum offset
    uint8 cmd;     // command
    uint8 sta : 4; // status
    uint8 rsv : 4; // Reserve
    uint8 css;     // 检验和起点 checksum start
    uint16 special;
};
