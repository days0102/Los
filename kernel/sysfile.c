/*
 * @Author: Outsider
 * @Date: 2022-08-17 11:04:03
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-19 11:20:59
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

struct inode *create(char *name, int type, int major, int minor)
{
    struct inode *inode = find_inode(-1, name);
    if (inode->type != I_TYPE_DIR)
        return 0;
    uint32 inum = ialloc(type);
    if (inum == (uint32)-1)
        return 0;
    struct inode *ip = rinum_inode(inum);
    ip->major = major;
    ip->minor = minor;
    add_dirent(inode, name, inum);
    winum_inode(inum);
    return ip;
}

// user open(path,mode)
int sys_open()
{
    char name[MAXPATH];
    int mode;

    argstr(0, name, MAXPATH);
    argint(1, &mode);

    struct inode *inode = find_inode(-1, name);
    if (inode == 0 || inode->type == I_TYPE_DIR || inode->type == I_TYPE_NULL)
        return -1;

    struct file *f;
    int fd;
    if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0)
        return -1;
    if (inode->type == I_TYPE_DEVICE)
    {
        f->type = FT_DEVICE;
    }
    else
    {
        f->type = FT_INODE;
        f->offset = 0;
    }
    f->fd = fd;
    f->inode = inode;
    f->ref = 1;
    printf("%s %d\n", name, mode);
    return fd;
}

int sys_mknod()
{
    char path[MAXPATH];
    int major, minor;
    argstr(0, path, MAXPATH);
    argint(1, &major);
    argint(2, &minor);

    struct inode *inode = create(path, I_TYPE_DEVICE, major, minor);
    if (inode == 0)
        return -1;
    return 0;
}

int sys_dup()
{
    int fd;
    argint(0, &fd);
    struct pcb *p = nowproc();
    struct file *f;
    if ((f = p->file[fd]) == 0)
        return -1;
    fd = fdalloc(f);
    return fd;
}

int sys_write()
{
    int fd;
    addr_t addr;
    int size;
    argint(0, &fd);
    argaddr(1, &addr);
    argint(2, &size);

    struct pcb *p = nowproc();
    struct file *f;
    if ((f = p->file[fd]) == 0)
        return -1;

    int cc = filewrite(f, addr, size);
    return cc;
}
