/*
 * @Author: Outsider
 * @Date: 2022-07-08 18:04:42
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-06 15:22:51
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/uart.c
 */
#include "types.h"
#include "uart.h"
#include "lock.h"
#include "defs.h"

struct spinlock uartlock;

void uartinit()
{
    // 关闭中断
    uart_write(UART_IER, 0x00);

    // 设置传输波特率
    uint8 lcr = uart_read(UART_LCR);      // 读取LCR寄存器值
    uart_write(UART_LCR, lcr | (1 << 7)); // LCR 寄存器第7位置1，控制 DLL 和 DLM 寄存器作用
    // 设置0x0003,38.4K频
    uart_write(UART_DLL, 0x03); // 设置低位
    uart_write(UART_DLM, 0x00); // 设置高位

    // 设置校验位
    lcr = 0;
    uart_write(UART_LCR, lcr | (3 << 0));

    // 开中断
    uart_write(UART_IER, uart_read(UART_IER) | (1 << 0));

    initspinlock(&uartlock, "uart");
}

// 轮询处理数据
char uartputc(char c)
{
    // LSR 寄存器第5位标记 THR 寄存器状态，1空闲，0忙
    while (((uart_read(UART_LSR)) & (1 << 5)) == 0)
        ; // 轮询
    return uart_write(UART_THR, c);
}

// 发送字符串
void uartputs(char *s)
{
    acquirespinlock(&uartlock);
    while (*s)
        uartputc(*s++);
    releasespinlock(&uartlock);
}

// 接收输入
int uartgetc()
{
    if (uart_read(UART_LSR) & (1 << 0))
        return uart_read(UART_RHR);
    else
        return -1;
}

// 键盘输入中断
char uartintr()
{
    return uartgetc();
}