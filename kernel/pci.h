/*
 * @Author: Outsider
 * @Date: 2022-09-02 14:52:08
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-02 15:04:32
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/pci.h
 */
#include "types.h"

struct receivedesc
{
    uint64 addr;
    uint16 len;
    uint16 checksum;
    uint8 status;
    uint8 errors;
    uint16 special;
};

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
