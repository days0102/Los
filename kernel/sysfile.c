/*
 * @Author: Outsider
 * @Date: 2022-08-17 11:04:03
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-17 20:00:24
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/sysfile.c
 */
#include "types.h"
#include "defs.h"
#include "file.h"
#include "proc.h"
#include "fs.h"

int fdalloc(struct file *file)
{
    int fd;
    struct pcb *p = nowproc();
    for (fd = 0; fd < NFILE; fd++)
    {
        if (p->file[fd] == 0)
        {
            p->file[fd] = file;
            return fd;
        }
    }
    return -1;
}

// user open(path,mode)
int sys_open()
{
    char name[MAXPATH];
    int mode;

    argstr(0, name, MAXPATH);
    argint(1, &mode);

    struct inode inode;

    struct file *f = filealloc();


    printf("%s %d\n", name, mode);
    return -1;
}