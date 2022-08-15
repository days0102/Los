#include "types.h"
#include "fs.h"
#include "defs.h"

#define IBLOCK(inum, istart) ((inum) / IPB + istart)
struct superblock sb;

void fsinit()
{
    struct buf *b;
    b = bufget(SUPERBLOCK);
    memmove(&sb, b->data, sizeof(struct superblock));
    b->ref--;
}

void iread(uint32 inum, struct dinode *inode)
{
    struct buf *b;
    b = bufget(IBLOCK(inum, sb.inodestart));
    uint32 off = inum - (inum / IPB) * IPB;
    memmove(inode, b->data + off * sb.dinodesize, sb.dinodesize);
    b->ref--;
}

void iwrite(uint32 inum, struct dinode *inode)
{
    struct buf *b;
    b = bufget(IBLOCK(inum, sb.inodestart));
    uint32 off = inum - (inum / IPB) * IPB;
    memmove(b->data + off * sb.dinodesize, inode, sb.dinodesize);
    b->ref--;
}

uint32 readi(struct dinode *inode, char *buffer, uint32 offset, uint32 size)
{
    struct buf *buf;
    if (offset > inode->size || size <= 0)
        return 0;
    size = size > inode->size - offset ? inode->size - offset : size;
    uint32 cnt = offset;
    while (offset - cnt < size)
    {
        uint32 bno = offset / BLOCKSIZE;
        uint32 off = offset % BLOCKSIZE;
        if (bno < NDIRET)
        {
            buf = bufget(inode->addr[bno]);
            uint32 cc = (offset - cnt) + BLOCKSIZE - off < size ? BLOCKSIZE - off : (cnt + size - offset);
            memmove(buffer + (offset - cnt), buf->data + off, cc);
            offset += BLOCKSIZE - off;
            buf->ref--;
        }
        else
        {
            buf = bufget(inode->addr[bno]);
            bno -= NDIRET;
            bno = ((uint32 *)buf->data)[bno];
            buf = bufget(bno);
            uint32 cc = (offset - cnt) + BLOCKSIZE - off < size ? BLOCKSIZE - off : (cnt + size - offset);
            memmove(buffer + (offset - cnt), buf->data + off, cc);
            offset += BLOCKSIZE - off;
            buf->ref--;
        }
    }
    return size;
}

uint32 dread(struct dinode *inode, char *name)
{
    struct dirent dirent;
    struct buf *b;
    for (int i = 0; i < NDIRET && inode->addr[i] != 0; i++)
    {
        b = bufget(inode->addr[i]);
        for (int j = 0; j < BLOCKSIZE; j += sb.direntsize)
        {
            if (readi(inode, (char *)&dirent, i * BLOCKSIZE + j, sb.direntsize) != sb.direntsize)
                return 0;
            if (strcmp(dirent.name, name) == 0)
            {
                return dirent.inum;
            }
        }
        b->ref--;
    }
    return 0;
}

char *parse_path(char *path, char *name)
{
    char *s;
    while (*path == '/')
        path++;
    if (*path == 0)
        return path;
    s = path;
    while (*path != '/' && *path != 0)
        path++;
    int len = path - s;
    len = len > DIRNAMESIZE ? DIRNAMESIZE : len;
    memmove(name, s, len);
    return path;
}

uint32 findi(char *path)
{
    char name[DIRNAMESIZE];
    while (*path != 0)
    {
        memset(name, 0, DIRNAMESIZE);
        path = parse_path(path, name);

        // todo
    }
    return 0;
}