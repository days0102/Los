/*
 * @Author: Outsider
 * @Date: 2022-08-17 10:27:13
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-19 14:02:01
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/file.c
 */
#include "types.h"
#include "defs.h"
#include "file.h"

struct file ftable[NFILE];

struct file *filealloc()
{
    struct file *f;
    for (f = ftable; f < &ftable[NFILE]; f++)
    {
        if (f->ref == 0)
        {
            f->ref++;
            return f;
        }
    }
    return 0;
}

int filewrite(struct file *file, addr_t addr, int size)
{
    if (file == 0)
        return 0;
    if (file->type == FT_DEVICE)
    {
        consolewrite((char *)addr, size);
        return size; //!
    }
    return 0;
}

int fileread(struct file *file, addr_t addr, int size)
{
    if (file == 0)
        return 0;
    if (file->type == FT_DEVICE)
    {
        consoleread((char *)addr, size);
        return size;
    }
    return 0;
}