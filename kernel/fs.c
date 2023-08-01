#include "types.h"
#include "fs.h"
#include "defs.h"
#include "proc.h"

#define NINODE 200
struct inode itable[NINODE]; // todo [concurrenty]

#define IBLOCK(inum, istart) ((inum) / IPB + istart)
struct superblock sb;

// init fs
void fsinit()
{
    struct buf *b;
    b = bget(SUPERBLOCK);
    memmove(&sb, b->data, sizeof(struct superblock)); // init superblock
    brelse(b);
}

/**
 * @description: inode allocation
 * @param {uint8} type inode type
 * @return {*} inode number
 */
int ialloc(uint8 type)
{
    struct dinode *inode;
    struct buf *b;
    for (int i = 0; i < sb.ninodeblock; i++)
    {
        b = bget(IBLOCK(i, sb.inodestart));
        for (int j = 0; j < IPB; j++)
        {
            inode = (struct dinode *)(b->data + sb.dinodesize * j);
            // memmove(&inode, b->data + sizeof(struct dinode) * j, sizeof(struct dinode));
            if (inode->type == I_TYPE_NULL)
            {
                memset(inode, 0, sb.dinodesize);
                inode->type = type;
                b->dirty = 1;
                int inum = i * IPB + j;
                // write_dinode(inum, &inode);
                brelse(b);
                return inum;
            }
        }
        brelse(b);
    }
    return -1;
}

uint32 balloc()
{
    struct buf *b = bget(sb.bitmapstart);
    for (int i = 0; i < BLOCKSIZE * sb.nbitmapblock; i++)
    {
        if (b->data[i] != 0xff)
        {
            for (int j = 0; j < 8; j++)
            {
                if ((b->data[i] & (1 << j)) == 0)
                {
                    b->data[i] |= (1 << j);
                    b->dirty = 1;
                    brelse(b);
                    return i * 8 + j;
                }
            }
        }
    }
    brelse(b);
    return 0;
}

void read_dinode(uint32 inum, struct dinode *inode)
{
    struct buf *b;
    b = bget(IBLOCK(inum, sb.inodestart));
    uint32 off = inum - (inum / IPB) * IPB;
    memmove(inode, b->data + off * sb.dinodesize, sb.dinodesize);
    brelse(b);
}

void write_dinode(uint32 inum, struct dinode *inode)
{
    struct buf *b;
    b = bget(IBLOCK(inum, sb.inodestart));
    uint32 off = inum - (inum / IPB) * IPB;
    memmove(b->data + off * sb.dinodesize, inode, sb.dinodesize);
    b->dirty = 1;
    brelse(b);
}

uint32 write_data(struct inode *inode, char *buffer, uint32 offset, uint32 size)
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
            if ((bno = inode->dinode.addr[index]) == 0)
            {
                bno = inode->dinode.addr[index] = balloc();
            }
            buf = bget(bno);
            uint32 cc = BLOCKSIZE - off < size ? BLOCKSIZE - off : size;
            memmove(buf->data + off, buffer + (offset - cnt), cc);
            offset += cc;
            buf->dirty = 1;
            brelse(buf);
        }
        else
        {
            if ((bno = inode->dinode.addr[NDIRET]) == 0)
                bno = inode->dinode.addr[NDIRET] = balloc();
            buf = bget(bno);
            index -= NDIRET;
            if ((bno = ((uint32 *)buf->data)[index]) == 0)
                bno = ((uint32 *)buf->data)[index] = balloc();
            buf = bget(bno);
            uint32 cc = BLOCKSIZE - off < size ? BLOCKSIZE - off : size;
            memmove(buf->data + off, buffer + (offset - cnt), cc);
            offset += cc;
            buf->dirty = 1;
            brelse(buf);
        }
    }
    inode->dinode.size += size;
    return size;
}

uint32 read_data(struct inode *inode, char *buffer, uint32 offset, uint32 size)
{
    struct buf *buf;
    if (offset > inode->dinode.size || size <= 0)
        return 0;
    size = size > inode->dinode.size - offset ? inode->dinode.size - offset : size;
    uint32 cnt = offset;
    while (offset - cnt < size)
    {
        uint32 bno = offset / BLOCKSIZE;
        uint32 off = offset % BLOCKSIZE;
        if (bno < NDIRET)
        {
            buf = bget(inode->dinode.addr[bno]);
            uint32 cc = (offset - cnt) + BLOCKSIZE - off < size ? BLOCKSIZE - off : (cnt + size - offset);
            memmove(buffer + (offset - cnt), buf->data + off, cc);
            offset += cc;
            brelse(buf);
        }
        else
        {
            buf = bget(inode->dinode.addr[NDIRET]);
            bno -= NDIRET;
            bno = ((uint32 *)buf->data)[bno];
            buf = bget(bno);
            uint32 cc = (offset - cnt) + BLOCKSIZE - off < size ? BLOCKSIZE - off : (cnt + size - offset);
            memmove(buffer + (offset - cnt), buf->data + off, cc);
            offset += cc;
            brelse(buf);
        }
    }
    return size;
}

void read_dirent(struct inode *inode, struct dirent *dirent, uint32 offset)
{
    struct buf *b;
    uint32 bno = offset / BLOCKSIZE;
    uint32 off = offset % BLOCKSIZE;
    if (bno < NDIRET)
    {
        if ((bno = inode->dinode.addr[bno]) == 0)
            return;
        b = bget(bno);
        memmove(dirent, b->data + off, sb.direntsize);
        brelse(b);
        return;
    }
    if (bno < NINDEX)
    {
        bno -= NDIRET;
        if ((bno = inode->dinode.addr[bno]) == 0)
            return;
        b = bget(bno);
        memmove(dirent, b->data + off, sb.direntsize);
        brelse(b);
        return;
    }
}

void write_dirent(struct inode *inode, struct dirent *dirent, uint32 offset)
{
    struct buf *b;
    uint32 bno = offset / BLOCKSIZE;
    uint32 off = offset % BLOCKSIZE;
    if (bno < NDIRET)
    {
        if ((bno = inode->dinode.addr[bno]) == 0)
            bno = inode->dinode.addr[bno] = balloc();
        b = bget(bno);
        memmove(b->data + off, dirent, sb.direntsize);
        b->dirty = 1;
        brelse(b);
    }
    if (bno < NINDEX)
    {
        bno -= NDIRET;
        if ((bno = inode->dinode.addr[bno]) == 0)
            bno = inode->dinode.addr[bno] = balloc();
        b = bget(bno);
        memmove(b->data + off, dirent, sb.direntsize);
        b->dirty = 1;
        brelse(b);
    }
}

uint32 find_dirent(struct inode *inode, char *name)
{
    if (inode->dinode.type != I_TYPE_DIR)
        return -1;

    struct dirent dirent;
    struct buf *b;
    for (int i = 0; i < NDIRET && inode->dinode.addr[i] != 0; i++)
    {
        b = bget(inode->dinode.addr[i]);
        for (int j = 0; j < BLOCKSIZE; j += sb.direntsize)
        {
            // read_dirent(inode, &find_dirent, i * BLOCKSIZE + j);
            memmove(&dirent, b->data + j, sb.direntsize);
            if (strcmp(dirent.name, name) == 0)
            {
                brelse(b);
                return dirent.inum;
            }
        }
        brelse(b);
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
        if ((bno = inode->dinode.addr[i]) == 0)
        {
            bno = inode->dinode.addr[i] = balloc();
        }
        buf = bget(bno);
        for (int j = 0; j < BLOCKSIZE; j += sb.direntsize)
        {
            memmove(&dirent, buf->data + j, sb.direntsize);
            if (strlen(dirent.name) == 0)
            {
                strcpy(dirent.name, name);
                dirent.inum = dinum;
                inode->dinode.size += sb.direntsize;
                memmove(buf->data + j, &dirent, sb.direntsize);
                buf->dirty = 1;
                brelse(buf);
                return 0;
            }
        }
        brelse(buf);
    }
    for (int i = NDIRET; i < NINDEX; i++)
    {
        if ((bno = inode->dinode.addr[i]) == 0)
        {
            bno = inode->dinode.addr[i] = balloc();
        }
        buf = bget(bno);
        for (int j = 0; j < BLOCKSIZE; j += sizeof(uint32))
        {
            if ((inbno = *(uint32 *)(buf->data + j)) == 0)
            {
                inbno = *(uint32 *)(buf->data + j) = balloc();
                buf->dirty = 1;
            }
            for (int k = 0; k < BLOCKSIZE; k += sb.direntsize)
            {
                read_data(inode, (char *)&dirent, k, sb.direntsize);
                if (strlen(dirent.name) == 0)
                {
                    strcpy(dirent.name, name);
                    dirent.inum = dinum;
                    inode->dinode.size += sb.direntsize;
                    write_data(inode, (char *)&dirent, k, sb.direntsize);
                    return 0;
                }
            }
        }
        brelse(buf);
    }
    return -1;
}

struct inode *iget(uint32 inum)
{
    struct inode *inode;
    inode = &itable[inum];
    if (inode->vaild == 0)
    {
        read_dinode(inum, &inode->dinode);
        inode->vaild = 1;
        inode->ref = 0;
        inode->dirty = 0;
        inode->inum = inum;
    }
    inode->ref++;
    return inode;
}

void irelse(struct inode *inode)
{
    if (inode == 0)
    {
        // null name -> null inode
        // return;
        // todo
        panic("relse null inode");
    }
    if (inode->vaild == 0)
        panic("relse invaild inode");
    inode->ref--;
    if (inode->dirty == 1)
    {
        write_dinode(inode->inum, &inode->dinode);
        inode->dirty = 0;
    }
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
struct inode *read_inode(char *path)
{
    struct inode *inode;
    struct inode *in;
    char name[MAXPATH];

    if (*path == '/')
        inode = find_inode(0, 0);
    else
    {
        inode = iget(nowproc()->cwd->inum);
        // inode = nowproc()->cwd; // bug no ref++
    }
    while (*path != 0 && (path = parse_path(path, name)) != 0)
    {
        if (inode->dinode.type == I_TYPE_DIR)
        {
            if (*name == 0)
                return inode;
            uint32 inum = find_dirent(inode, name);
            if ((int)inum == -1)
                return inode;
            in = iget(inum);
            if (in == 0)
                return 0;
            irelse(inode);
            inode = in;
        }
        if (inode->dinode.type == I_TYPE_FILE || inode->dinode.type == I_TYPE_DEVICE)
            return inode;
    }
    return 0;
}

// inum != -1 , inum->inode
// inum == -1 , path->inode
struct inode *find_inode(uint32 inum, char *path)
{
    if (inum != 0xffffffff)
        return iget(inum);
    else
        return read_inode(path);
}