/*
 * @Author       : Outsider
 * @Date         : 2023-03-04 12:49:08
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-05-25 17:57:29
 * @Description  : In User Settings Edit
 * @FilePath     : /los/kernel/eth.c
 */
#include "defs.h"
#include "eth.h"

static uint32 *regs;
static struct transmitdesc tx_ring[TX_RING_SIZE] __attribute__((aligned(16)));
static struct receivedesc rx_ring[RX_RING_SIZE] __attribute__((aligned(16)));

void ethinit(uint32 *addr)
{
    regs = addr;

    // uint32 ctrl = eth_read(E1000_CTRL);
    // printf("%d", ctrl);
    // eth_read(E1000_CTRL);
    eth_write(E1000_IMC, 0);                                      // 关中断
    eth_write(E1000_CTRL, eth_read(E1000_CTRL) | E1000_CTRL_RST); // 设备重置
    eth_write(E1000_IMC, 0);                                      // 关中断

    __sync_synchronize(); // 前面执行才继续执行后面的

    memset(tx_ring, 0, sizeof(struct transmitdesc) * TX_RING_SIZE);
    for (int i = 0; i < TX_RING_SIZE; i++)
    {
        tx_ring[i].sta = TD_STA_DD;
    }
    eth_write(E1000_TDBAL, (uint32)tx_ring);
    eth_write(E1000_TDLEN, sizeof(tx_ring));
    eth_write(E1000_TDH, 0);
    eth_write(E1000_TDT, 0);

    memset(rx_ring, 0, sizeof(struct receivedesc) * RX_RING_SIZE);
}