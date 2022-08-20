/*
 * @Author: Outsider
 * @Date: 2022-07-08 15:25:13
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-20 14:01:08
 * @Description: RISC-V vir uart通信
 * @FilePath: /los/kernel/uart.h
 */

#include "types.h"

/*
    RISC-V virt UART0
    Address 0x10000000~0x10000100
*/

#define UART_BASE 0x10000000
#define UART_SIZE 0x100

#define UART_RHR 0 // Receive Holding Register (read mode)
#define UART_THR 0 // Transmit Holding Register (write mode)
#define UART_DLL 0 // LSB of Divisor Latch (write mode)
#define UART_IER 1 // Interrupt Enable Register (write mode)
#define UART_DLM 1 // MSB of Divisor Latch (write mode)
#define UART_FCR 2 // FIFO Control Register (write mode)
#define UART_ISR 2 // Interrupt Status Register (read mode)
#define UART_LCR 3 // Line Control Register
#define UART_MCR 4 // Modem Control Register
#define UART_LSR 5 // Line Status Register
#define UART_MSR 6 // Modem Status Register
#define UART_SPR 7 // ScratchPad Register

#define UART_REG(reg) ((volatile uint8 *)(UART_BASE + reg)) // 一个寄存器8bit

#define uart_read(reg) (*(UART_REG(reg)))
#define uart_write(reg, val) ((*(UART_REG(reg))) = (val))
