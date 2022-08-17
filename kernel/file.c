/*
 * @Author: Outsider
 * @Date: 2022-08-17 10:27:13
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-17 16:41:25
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/file.c
 */
#include "types.h"
#include "defs.h"
#include "file.h"

struct file ftable[NFILE];

struct file* filealloc()
{
    struct file *f;
    for (f = ftable; f < &ftable[NFILE]; f++)
    {
        if(f->ref==0){
            f->ref++;
            return f;
        }
    }
    return 0;
}