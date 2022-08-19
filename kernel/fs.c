#include "types.h"
#include "fs.h"
#include "defs.h"
#include "proc.h"

#define NINODE 200
struct inode itable[NINODE];

#define IBLOCK(inum, istart) ((inum) / IPB + istart)
struct superblock sb;

void fsinit()
{
    struct buf *b;
    b = bufget(SUPERBLOCK);
    memmove(&sb, b->data, sizeof(struct superblock));
    b->ref--;
}
uint32 balloc()
{
    struct buf *b = bufget(sb.bitmapstart);
    for (int i = 0; i < BLOCKSIZE * sb.nbitmapblock; i++)
    {
        if (b->data[i] != 0xff)
        {
            for (int j = 0; j < 8; j++)
            {
                if ((b->data[i] & (1 << j)) == 0)
                {
                    b->data[i] |= (1 << j);
                    return i * 8 + j;
                }
            }
        }
    }
    return 0;
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

int ialloc(uint8 type)
{
    struct dinode inode;
    for (int i = 0; i < sb.ninodeblock; i++)
    {
        struct buf *b = bufget(IBLOCK(i, sb.inodestart));
        for (int j = 0; j < IPB; j++)
        {
            memmove(&inode, b->data + sizeof(struct dinode) * j, sizeof(struct dinode));
            if (inode.type == I_TYPE_NULL)
            {
                memset(&inode, 0, sb.dinodesize);
                inode.type = type;
                int inum = i * IPB + j;
                iwrite(inum, &inode);
                return inum;
            }
        }
    }
    return -1;
}

struct inode *rinum_inode(uint32 inum)
{
    struct inode *inode;
    struct dinode dinode;
    inode = &itable[inum];
    if (inode->vaild == 0)
    {
        iread(inum, &dinode);
        inode->vaild = 1;
        inode->ref = 0;
        inode->type = dinode.type;
        inode->mod = dinode.mod;
        inode->own = dinode.own;
        inode->major = dinode.major;
        inode->minor = dinode.minor;
        inode->size = dinode.size;
        memmove(inode->addr, dinode.addr, sizeof(inode->addr));
    }
    inode->ref++;
    return inode;
}

void winum_inode(uint32 inum)
{
    struct inode *inode;
    struct dinode dinode;
    inode = &itable[inum];
    if (inode->vaild == 0)
        return;
    dinode.type = inode->type;
    dinode.mod = inode->mod;
    dinode.own = inode->own;
    dinode.major = inode->major;
    dinode.minor = inode->minor;
    dinode.size = inode->size;
    memmove(dinode.addr, inode->addr, sizeof(inode->addr));
    iwrite(inum, &dinode);
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

uint32 writei(struct inode *inode, char *buffer, uint32 offset, uint32 size)
{
    struct buf *buf;
    if (size <= 0)
        return 0;
    size = size + offset > MAXFILE ? MAXFILE - offset : size;
    uint32 cnt = offset;
    uint32 bno, off, index;
    while (offset - cnt < size)
    {
        index = offset / BLOCKSIZE;
        off = offset % BLOCKSIZE;
        if (bno < NDIRET)
        {
            if ((bno = inode->addr[index]) == 0)
            {
                bno = inode->addr[index] = balloc();
            }
            buf = bufget(bno);
            uint32 cc = BLOCKSIZE - off < size ? BLOCKSIZE - off : size;
            memmove(buf->data + off, buffer + (offset - cnt), cc);
            offset += cc;
            buf->ref--;
        }
        else
        {
            if ((bno = inode->addr[NDIRET]) == 0)
                bno = inode->addr[NDIRET] = balloc();
            buf = bufget(bno);
            index -= NDIRET;
            if ((bno = ((uint32 *)buf->data)[index]) == 0)
                bno = ((uint32 *)buf->data)[index] = balloc();
            buf = bufget(bno);
            uint32 cc = BLOCKSIZE - off < size ? BLOCKSIZE - off : size;
            memmove(buf->data + off, buffer + (offset - cnt), cc);
            offset += cc;
            buf->ref--;
        }
    }
    inode->size += size;
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

uint32 read_data(struct inode *inode, char *buffer, uint32 offset, uint32 size)
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

uint32 read_dirent(struct inode *inode, char *name)
{
    struct dirent dirent;
    struct buf *b;
    for (int i = 0; i < NDIRET && inode->addr[i] != 0; i++)
    {
        b = bufget(inode->addr[i]);
        for (int j = 0; j < BLOCKSIZE; j += sb.direntsize)
        {
            memmove(&dirent, b->data + j, sb.direntsize);
            if (strcmp(dirent.name, name) == 0)
            {
                return dirent.inum;
            }
        }
        b->ref--;
    }
    return -1;
}

int add_dirent(struct inode *inode, char *name, uint32 dinum)
{
    struct dirent dirent;
    struct buf *buf;
    uint32 bno;
    uint32 inbno;

    for (int i = 0; i < NDIRET; i++)
    {
        if ((bno = inode->addr[i]) == 0)
        {
            bno = inode->addr[i] = balloc();
        }
        buf = bufget(bno);
        for (int j = 0; j < BLOCKSIZE; j += sb.direntsize)
        {
            memmove(&dirent, buf->data + j, sb.direntsize);
            if (strlen(dirent.name) == 0)
            {
                strcpy(dirent.name, name);
                dirent.inum = dinum;
                inode->size += sb.direntsize;
                memmove(buf->data + j, &dirent, sb.direntsize);
                return 0;
            }
        }
    }
    for (int i = NDIRET; i < NINDEX; i++)
    {
        if ((bno = inode->addr[i]) == 0)
        {
            bno = inode->addr[i] = balloc();
        }
        buf = bufget(bno);
        for (int j = 0; j < BLOCKSIZE; j += sizeof(uint32))
        {
            if ((inbno = *(uint32 *)(buf->data + j)) == 0)
            {
                inbno = *(uint32 *)(buf->data + j) = balloc();
            }
            for (int k = 0; k < BLOCKSIZE; k += sb.direntsize)
            {
                read_data(inode, (char *)&dirent, k, sb.direntsize);
                if (strlen(dirent.name) == 0)
                {
                    strcpy(dirent.name, name);
                    dirent.inum = dinum;
                    inode->size += sb.direntsize;
                    writei(inode, (char *)&dirent, k, sb.direntsize);
                    winum_inode(dirent.inum);
                    return 0;
                }
            }
        }
    }
    return -1;
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
    name[len] = 0;
    while (*path == '/')
        path++;
    return path;
}

struct inode *rname_inode(char *path)
{
    struct inode *inode;
    char name[MAXPATH];

    if (*path == '/')
        inode = find_inode(0, 0);
    else
        inode = nowproc()->cwd; //#
    while (*path != 0 && (path = parse_path(path, name)) != 0)
    {
        if (inode->type == I_TYPE_DIR)
        {
            if (*name == 0)
                return inode;
            uint32 inum = read_dirent(inode, name);
            if ((int)inum == -1)
                return inode;
            inode = rinum_inode(inum);
        }
        if (inode->type == I_TYPE_FILE || inode->type == I_TYPE_DEVICE)
            return inode;
        memset(name, 0, MAXPATH);
    }
    return 0;
}

// inum != -1 , inum->inode
// inum == -1 , path->inode
struct inode *find_inode(uint32 inum, char *path)
{
    if (inum != 0xffffffff)
        return rinum_inode(inum);
    else
        return rname_inode(path);
}