/*
 * @Author: Outsider
 * @Date: 2022-09-02 14:52:08
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-17 10:26:33
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/pci.h
 */
#include "types.h"

// 网卡驱动接收描述符
struct receivedesc
{
    uint64 addr;
    uint16 len;
    uint16 checksum;
    uint8 status;
    uint8 errors;
    uint16 special;
};

// 网卡驱动发送描述符
struct transmitdesc
{
    uint64 addr;
    uint16 len;
    uint8 cso;
    uint8 cmd;
    uint8 sta : 4;
    uint8 rsv : 4;
    uint8 css;
    uint16 special;
};
