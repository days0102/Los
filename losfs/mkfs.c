/*
 * @Author: Outsider
 * @Date: 2022-06-09 18:34:26
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-22 15:00:39
 * @Description: In User Settings Edit
 * @FilePath: /los/losfs/mkfs.c
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdint.h>
#include <sys/fcntl.h>
#include <sys/stat.h>

void assertfail(const char *__assertion, const char *__file,
                unsigned int __line, const char *__function)
{
    printf("\033[1;31mAssertFail \"%s\" At %s %d Line In Fun %s\n\033[0m",
           __assertion, __file, __line, __function);
    exit(1);
}
#define assert(expr) (expr) ? 0 : assertfail(#expr, __FILE__, __LINE__, __FUNCTION__)
void printferror(const char *__errmsg, const char *__file,
                 unsigned int __line, const char *__function)
{
    printf("\033[1;31m%s At %s %d Line In Fun %s\n\033[0m",
           __errmsg, __file, __line, __function);
    exit(1);
}
#define error(msg) printferror(#msg, __FILE__, __LINE__, __FUNCTION__)

#define BLOCKSIZE 1024
#define NDIRET 11
#define NINDIRET 1
#define NINDEX (NDIRET + NINDIRET)
#define NINODE 200
#define NINODEBLOCK NINODE *(sizeof(struct dinode)) / BLOCKSIZE + 1
#define NBITMAPBLOCK 1
#define BPB BLOCKSIZE *NBITMAPBLOCK * 8
#define IPB (BLOCKSIZE / sizeof(struct dinode))

#define I_TYPE_NULL 0
#define I_TYPE_FILE 1
#define I_TYPE_DIR 2

#define UNAME 6
#define PSLEN 8

#define MOD_RO 1
#define MOD_WO 2
#define MOD_RW 3

#define DIRNAMESIZE 28

struct superblock
{
#define FS_SB_MAGIC 0xEF53
    uint16_t magic;
    uint16_t direntsize;
    uint16_t dinodesize;
    uint16_t bitpreblock;
    uint16_t inodepreblock;
    uint32_t size; // disk-size
    uint32_t nblock;
    uint32_t sbstart;
    uint32_t bitmapstart;
    uint32_t inodestart;
    uint32_t datastart;
    uint32_t nbitmapblock;
    uint32_t ninodeblock;
    uint32_t ndatablock;
};

struct block
{
    uint16_t blockno;
    uint8_t data[BLOCKSIZE]; /* data */
};

struct dinode
{
    /* data */
    uint8_t type; // 类型，文件 - 目录
    uint8_t own;  // 所有者
    uint8_t mod;  // 权限
    uint8_t major;
    uint8_t minor;
    uint32_t size;
    uint32_t addr[NINDEX]; // 一级索引
};

// dir item
struct dirent
{
    uint32_t inum;          // inode-no
    char name[DIRNAMESIZE]; // 目录或文件名
};

int fdfs;
struct superblock *sb; // 超级块
struct block *bitmap;  // 位图
// struct block* inodemap;

void bread(int bno, struct block *block)
{
    block->blockno = bno;
    lseek(fdfs, bno * BLOCKSIZE, 0);
    int cnt = read(fdfs, block->data, BLOCKSIZE);
    assert(cnt == BLOCKSIZE);
}
void bwrite(struct block *block)
{
    lseek(fdfs, block->blockno * BLOCKSIZE, 0);
    int cnt = write(fdfs, block->data, BLOCKSIZE);
    assert(cnt == BLOCKSIZE);
}
void bclear(int bno)
{
    lseek(fdfs, bno * BLOCKSIZE, 0);
    char block[BLOCKSIZE];
    memset(block, 0, BLOCKSIZE);
    int cnt = write(fdfs, block, BLOCKSIZE);
    assert(cnt == BLOCKSIZE);
}

/**
 * @description:    将目录项内容写入内存缓冲
 * @param {uint16_t} bno   块号
 * @param {uint16_t} offset  块内偏移
 * @param {dirent*} drt 目录项结构
 */
void dwrite(uint32_t bno, uint32_t offset, struct dirent *drt)
{
    struct block block;
    bread(bno, &block);
    memmove(block.data + offset, drt, sizeof(struct dirent));
    bwrite(&block);
}
/**
 * @description:  从内存缓冲中读取目录项
 * @param {uint16_t} bno   块号
 * @param {uint16_t} offset  目录项在块中的偏移
 * @param {dirent*} drt     目录项结构体
 */
void dread(uint16_t bno, uint16_t offset, struct dirent *drt)
{
    struct block block;
    bread(bno, &block); // 第一个块位位图块
    struct block *bk = &block;
    memmove(drt, bk->data + offset, sizeof(struct dirent));
}
/**
 * @description: 将 inode 信息写入软盘
 * @param {uint16_t} inum  inode号
 * @param {dinode*} ide     inode结构体
 */
void iwrite(uint32_t inum, struct dinode *ide)
{
    struct block block;
    bread(sb->inodestart + inum / IPB, &block); // 第一个块位位图块
    int m = inum % IPB;
    memmove(block.data + m * sizeof(struct dinode), ide, sizeof(struct dinode));
    bwrite(&block);
}

/**
 * @description: 在位图中寻找空闲块
 * @return {*}  0失败 成功返回块号
 */
uint32_t balloc()
{
#define BITMAP 2
    struct block block;
    bread(BITMAP, &block); // 第一个块位位图块
    bitmap = &block;
    for (int i = 0; i < BLOCKSIZE * sb->nbitmapblock; i++)
    {
        if (bitmap->data[i] != 0xff)
        {
            for (int j = 0; j < 8; j++)
            {
                if ((bitmap->data[i] & (1 << j)) == 0)
                {
                    bitmap->data[i] |= (1 << j);
                    bwrite(&block);
                    return i * 8 + j;
                }
            }
        }
    }
    printf("block full!\n");
    return 0;
}

/**
 * @description: 释放块
 * @param {int} bunm    块号
 * @return {*}  成功1 失败0
 */
uint16_t bfree(int bunm)
{
    struct block block;
    bread(BITMAP, &block); // 第一个块位位图块
    bitmap = &block;
    int m = bunm / 8;
    int n = bunm % 8;
    int j = (1 << n);
    if (bitmap->data[m] & (1 << j) == 0)
    {
        return 0;
    }
    else
    {
        bitmap->data[m] &= ~j;
        bclear(bunm);
        return 1;
    }
}

/**
 * @description: 分配 inode
 * @return {*}  成功 inode号 失败-1
 */
int ialloc(uint8_t type)
{
    struct block block;
    struct dinode inode;
    for (int i = 0; i < sb->ninodeblock; i++)
    {
        bread(sb->inodestart + i, &block);
        for (int j = 0; j < IPB; j++)
        {
            memmove(&inode, block.data + sizeof(struct dinode) * j, sizeof(struct dinode));
            if (inode.type == I_TYPE_NULL)
            {
                memset(&inode, 0, sb->dinodesize);
                inode.type = type;
                int inum = i * IPB + j;
                iwrite(inum, &inode);
                return inum;
            }
        }
    }
    printf("\033[1;31minode full! \033[0m\n");
    return -1;
}

/**
 * @description:    读取 inode
 * @param {uint16_t} inum  inode号
 * @param {dinode*} ide     inode 结构体
 */
void iread(uint16_t inum, struct dinode *ide)
{
    struct block block;
    bread(sb->inodestart + inum / IPB, &block); // 第一个块位位图块
    int m = inum % IPB;
    memmove(ide, block.data + m * sizeof(struct dinode), sizeof(struct dinode));
}

uint8_t iappent(uint32_t inum, char *buf, int size)
{
    struct dinode inode;
    iread(inum, &inode);
    struct block block;
    uint32_t bno;

    char *b = buf;
    while (size > 0)
    {
        uint32_t index = inode.size / BLOCKSIZE;
        uint64_t off = inode.size % BLOCKSIZE;
        // assert(index < NINDEX);
        if (index < NDIRET)
        {
            if ((bno = inode.addr[index]) == 0)
                bno = inode.addr[index] = balloc();
        }
        else
        {
            if (index < NINDEX)
            {
                if ((bno = inode.addr[index]) == 0)
                    bno = inode.addr[index] = balloc();
            }
            else
                bno = inode.addr[NDIRET];
            bread(bno, &block);
            index -= NDIRET;
            if ((bno = ((uint32_t *)block.data)[index]) == 0)
            {
                bno = ((uint32_t *)block.data)[index] = balloc();
                bwrite(&block);
            }
        }
        int n = size > (BLOCKSIZE - off) ? (BLOCKSIZE - off) : size;
        bread(bno, &block);
        memmove(block.data + off, b, n);
        bwrite(&block);
        inode.size += n;
        b += n;
        size -= n;
    }
    iwrite(inum, &inode);
}

int add_dirent(uint32_t inum, char *name, uint32_t dinum)
{
    struct dirent dirent;
    struct dinode inode;
    iread(inum, &inode);
    struct block block;
    uint32_t bno;
    uint32_t inbno;

    for (int i = 0; i < NDIRET; i++)
    {
        if ((bno = inode.addr[i]) == 0)
        {
            bno = inode.addr[i] = balloc();
        }
        for (int j = 0; j < BLOCKSIZE; j += sb->direntsize)
        {
            dread(bno, j, &dirent);
            if (strlen(dirent.name) == 0)
            {
                strcpy(dirent.name, name);
                dirent.inum = dinum;
                inode.size += sb->direntsize;
                dwrite(bno, j, &dirent);
                iwrite(inum, &inode);
                return 0;
            }
        }
    }
    for (int i = NDIRET; i < NINDEX; i++)
    {
        if ((bno = inode.addr[i]) == 0)
        {
            bno = inode.addr[i] = balloc();
        }
        bread(bno, &block);
        for (int j = 0; j < BLOCKSIZE; j += sizeof(uint32_t))
        {
            if ((inbno = *(uint32_t *)(block.data + j)) == 0)
            {
                inbno = *(uint32_t *)(block.data + j) = balloc();
            }
            for (int k = 0; k < BLOCKSIZE; k += sb->direntsize)
            {
                dread(inbno, k, &dirent);
                if (strlen(dirent.name) == 0)
                {
                    strcpy(dirent.name, name);
                    dirent.inum = dinum;
                    inode.size += sb->direntsize;
                    dwrite(bno, j, &dirent);
                    iwrite(inum, &inode);
                    return 0;
                }
            }
        }
    }
    return -1;
}
int add_file(uint32_t inum, char *name)
{
    struct dirent dirent;
    struct dinode inode;
    iread(inum, &inode);
    struct block block;
    uint32_t bno;
    uint32_t inbno;

    for (int i = 0; i < NDIRET; i++)
    {
        if ((bno = inode.addr[i]) == 0)
        {
            bno = inode.addr[i] = balloc();
        }
        for (int j = 0; j < BLOCKSIZE; j += sb->direntsize)
        {
            dread(bno, j, &dirent);
            if (strlen(dirent.name) == 0)
            {
                strcpy(dirent.name, name);
                inode.size += sb->direntsize;
                dwrite(bno, j, &dirent);
                iwrite(inum, &inode);
                return 0;
            }
        }
    }
    for (int i = NDIRET; i < NINDEX; i++)
    {
        if ((bno = inode.addr[i]) == 0)
        {
            bno = inode.addr[i] = balloc();
        }
        bread(bno, &block);
        for (int j = 0; j < BLOCKSIZE; j += sizeof(uint32_t))
        {
            if ((inbno = *(uint32_t *)(block.data + j)) == 0)
            {
                inbno = *(uint32_t *)(block.data + j) = balloc();
            }
            for (int k = 0; k < BLOCKSIZE; k += sb->direntsize)
            {
                dread(inbno, k, &dirent);
                if (strlen(dirent.name) == 0)
                {
                    strcpy(dirent.name, name);
                    inode.size += sb->direntsize;
                    dwrite(bno, j, &dirent);
                    iwrite(inum, &inode);
                    return 0;
                }
            }
        }
    }
    return -1;
}
// 创建根目录
void creatroot()
{
    uint16_t inum = ialloc(I_TYPE_DIR);
    assert(inum == 0);

    add_dirent(inum, ".", inum);
    add_dirent(inum, "..", inum);
}

// 初始化
int init(char *name)
{
    fdfs = open(name, O_RDWR); // 读取软盘
    if (fdfs < 0)
        error("Open IMG Error");
    struct stat stat;
    if (fstat(fdfs, &stat) != 0)
        error("Read stat Error");

    printf("%s size %ldbit [%ldM]\n", name, stat.st_size, stat.st_size / 1024 / 1024);

    for (int i = 0; i < stat.st_size / 1024; i++)
    {
        bclear(i);
    }

    sb = (struct superblock *)malloc(sizeof(struct superblock));

#define BOOTBLOCK 0
#define SUPERBLOCK 1
#define BITMAP 2
    sb->magic = FS_SB_MAGIC;
    sb->direntsize = sizeof(struct dirent);
    sb->dinodesize = sizeof(struct dinode);
    sb->bitpreblock = BPB;
    sb->inodepreblock = IPB;
    sb->size = stat.st_size;
    sb->nblock = stat.st_size / 1024;
    sb->sbstart = SUPERBLOCK;
    sb->bitmapstart = BITMAP;
    sb->nbitmapblock = stat.st_size / BLOCKSIZE / 8 / BLOCKSIZE;
    sb->inodestart = sb->bitmapstart + sb->nbitmapblock;
#define NINODE 200
    sb->ninodeblock = NINODE * sizeof(struct dinode) / BLOCKSIZE + 1;
    sb->datastart = sb->inodestart + sb->ninodeblock;
    sb->ndatablock = sb->nblock - sb->datastart;
    struct block block;
    memset(block.data, 0, BLOCKSIZE);
    memmove(block.data, sb, sizeof(struct superblock));
    block.blockno = SUPERBLOCK;
    bwrite(&block);

    for (int i = 0; i < (sb->datastart - 1); i++)
        balloc();
#ifdef DEBUG
    printf("bitmapstart: %d, nbitmapblock: %d\n", sb->bitmapstart, sb->nbitmapblock);
    printf("inodestart: %d, ninodeblock: %d\n", sb->inodestart, sb->ninodeblock);
    printf("datastart: %d, ndatablock: %d\n", sb->datastart, sb->ndatablock);
    printf("direntsize: %d, dinodesize: %d\n", sb->direntsize, sb->dinodesize);
#endif
}

// 创建文件系统
void mkfs()
{
    // Disk layout:
    // [ boot | sb block | free bit map | inode blocks | data blocks ]
    // 1 block| 1 block  |   n block    |   m block    |
    printf("total %d blocks (bitmap %d blocks,inode %d blocks,data %d blocks)\n",
           sb->nblock, sb->nbitmapblock, sb->ninodeblock, sb->ndatablock);

    creatroot();
}

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("Usage mkfs fs.img file...\n");
        return -1;
    }
    if (init(argv[1]) < 0)
        return -1;

    mkfs();

    char buf[BLOCKSIZE];
    int cc;
    char *name;
    for (int i = 2; i < argc; i++)
    {
        int fd = open(argv[i], O_RDWR);
        if (fd < 0)
            error("Open File Error");
        uint32_t inum = ialloc(I_TYPE_FILE);
        if (strncmp(argv[i], "user/", 5) == 0)
        {
            name = argv[i] + 5;
            while (*argv[i] != '.')
                argv[i]++;
            *argv[i] = '\0';
        }
        else
            name = argv[i];
        add_dirent(0, name, inum);
        memset(buf, 0, BLOCKSIZE);

        while ((cc = read(fd, buf, BLOCKSIZE)) > 0)
            iappent(inum, buf, cc);
    }

    close(fdfs);
}