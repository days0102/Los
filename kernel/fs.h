/*
 * @Author: Outsider
 * @Date: 2022-08-13 08:39:08
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-23 15:14:41
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/fs.h
 */
#include "types.h"
#include "buf.h"

#define BLOCKSIZE 1024
#define IPB (BLOCKSIZE / sizeof(struct dinode))

#define I_TYPE_NULL 0
#define I_TYPE_FILE 1
#define I_TYPE_DIR 2
#define I_TYPE_DEVICE 3

#define MAXPATH 64

struct superblock
{
#define FS_SB_MAGIC 0xEF53
#define SUPERBLOCK 1
    uint16 magic;
    uint16 direntsize;
    uint16 dinodesize;
    uint16 bitpreblock;
    uint16 inodepreblock;
    uint32 size; // disk-size
    uint32 nblock;
    uint32 sbstart;
    uint32 bitmapstart;
    uint32 inodestart;
    uint32 datastart;
    uint32 nbitmapblock;
    uint32 ninodeblock;
    uint32 ndatablock;
};

struct dinode
{
    /* data */
    uint8 type;  // disk-inode type
    uint8 own;   // disk-inode owner
    uint8 mod;   // disk-inode mode
    uint8 major; // disk-inode device major num
    uint8 minor; // disk-inode device minor num
    uint32 size; // size
#define NDIRET 11
#define NINDIRET 1
#define NINDEX (NDIRET + NINDIRET)
    uint32 addr[NINDEX]; // block index
};

struct dirent
{
    uint32 inum; // inode-no
#define DIRNAMESIZE 28
    char name[DIRNAMESIZE]; // 目录或文件名
};

struct inode
{
    uint8 vaild;
    uint8 dirty;
    uint32 ref;
    uint32 inum;

    struct dinode dinode;
};
#define MAXFILE (NDIRET * BLOCKSIZE + NINDIRET * (BLOCKSIZE / 4) * BLOCKSIZE)