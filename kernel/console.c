/*
 * @Author: Outsider
 * @Date: 2022-08-19 10:40:38
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-26 10:18:13
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/console.c
 */
#include "types.h"
#include "defs.h"
#include "uart.h"
#include "proc.h"

#define MAXCONSOLEBUF 256

#define Ctrl_x(x) ((x) - '@') // Control-x

#define BACKSPACE 0x100

struct console
{
    uint r;
    uint w;
    uint e;
    char conbuf[MAXCONSOLEBUF];
} console;

void consoleputc(int c)
{
    if (c == BACKSPACE)
        uartputs("\b \b");
    else
        uartputc(c);
}

void consolewrite(char *vsrc, int size)
{
    char buf[MAXCONSOLEBUF + 1];
    struct pcb *p = nowproc();
    int cnt = 0;
    while (size > 0)
    {
        int cc = size > MAXCONSOLEBUF ? MAXCONSOLEBUF : size;
        copyin(p->pagetable, (addr_t)(vsrc + cnt), buf, cc);
        buf[cc] = 0;
        uartputs(buf);
        size -= cc;
    }
}

void consoleread(char *vdst, int size)
{
    while (console.r == console.w)
        sleep(&console.r, 0);
    int cc = (console.w - console.r) > size ? size : (console.w - console.r);
    copyout(nowproc()->pagetable, (addr_t)vdst, console.conbuf + console.r, cc);
    console.r += cc;
}

int consolechar;
void consoleintr(char c)
{
    switch (c)
    {
    case Ctrl_x('H'):
    case '\x7f':
        if (console.e != console.w)
        {
            console.e--;
            consoleputc(BACKSPACE);
        }
        break;
    default:
        if (c != 0)
        {
            c = ((c == '\r') ? '\n' : c);
            /** 在Linux下，方向键由三字符组成
             * '\033','[','A'   -  UP
             * '\033','[','B'   -  DOWN
             * '\033','[','C'   -  RIGHT
             * '\033','[','D'   -  LEFT
             **/
            consoleputc(c);

            console.conbuf[console.e++ % MAXCONSOLEBUF] = c;
            if (c == '\n' || console.e == console.r + MAXCONSOLEBUF)
            {
                // wake up consoleread() if a whole line (or end-of-file)
                // has arrived.
                console.w = console.e;
                wakeup(&console.r);
            }
        }
        break;
    }
}
