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
    struct dinode inode;
    iread(2, &inode);
    b=bufget(inode.addr[0]);
}

void iread(uint32 inum, struct dinode *inode)
{
    struct buf *b;
    b = bufget(IBLOCK(inum, sb.inodestart));
    uint32 off = inum - (inum / IPB) * IPB;
    memmove(inode, b->data + off * sb.dinodesize, sb.dinodesize);
    b->ref--;
}