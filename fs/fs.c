/*
 * @Author: Outsider
 * @Date: 2022-06-09 18:34:26
 * @LastEditors: Outsider
 * @LastEditTime: 2022-06-10 23:32:04
 * @Description: In User Settings Edit
 * @FilePath: /OsLab/fs/fs.c
 */
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>
#include<sys/fcntl.h>

#define BLOCKSIZE 512
#define NBLOCK 
#define NADDR 11
#define NBUF 10
#define NINODE 50
#define NBITMAPBLOCK 1
#define BPB BLOCKSIZE*NBITMAPBLOCK*8
#define IPB (BLOCKSIZE/sizeof(struct dinode))
#define NINODEBLOCK (NINODE/IPB+1)

#define T_FILE 1
#define T_DIR 2

#define DIRNAMESIZE 14

struct superblock
{
    u_int16_t size;         // 
    u_int16_t ninodes_used;
    u_int16_t ninodes_free;
    u_int16_t nblocks_used;
    u_int16_t nblocks_free;
    u_int16_t inodestart;
    u_int16_t bmapstart;
    u_int16_t datastart;
};

struct block
{
    /* data */
    u_int16_t blockno;
    u_char data[BLOCKSIZE];
    struct block* prev;
    struct block* next;
};

struct block* bcache;


struct dinode
{
    /* data */
    u_int8_t    type;   
    u_int16_t   size;
    u_int16_t   addr[NADDR];
};

// dir item
struct dirent {
  ushort inum;
  char name[DIRNAMESIZE];
};

int fd;
struct superblock* sb;
struct block* bitmap;
struct block* inodemap;

// read a block
struct block* bread(u_int16_t blockno){
    struct block* bk=bcache->next;
    while(bk!=bcache){
        if(bk->blockno==blockno){
            bk->prev->next=bk->next;
            bk->next->prev=bk->prev;
            bk->next=bcache->next;
            bk->prev=bcache;
            bcache->next->prev=bk;
            bcache->next=bk;
            return bk;
        }
        bk=bk->next;
    }
    if(bk==bcache){
        if(bcache->blockno<NBUF){
            struct block* nb=(struct block*)malloc(sizeof(struct block));
            nb->blockno=blockno;
            nb->next=bcache->next;
            nb->prev=bcache;
            bcache->next->prev=nb;
            bcache->next=nb;
            bcache->blockno++;
            lseek(fd,BLOCKSIZE*blockno,SEEK_SET);
            read(fd,nb->data,BLOCKSIZE);
            return bcache->next;
        }else{
            
        }
    }
}


// write a block
void bwrite(u_int16_t bno){
    struct block* bk=bcache->next;
    while(bk!=bcache){
        if(bk->blockno==bno){
            lseek(fd,BLOCKSIZE*bno,SEEK_SET);
            write(fd,bk->data,sizeof(struct block));
            return;
        }
    }
}

// clear a block
void bclear(u_int16_t bno){
    struct block* bk=bread(bno);
    memset(bk->data,0,BLOCKSIZE);
    bwrite(bno);    
}

// find free block from bitmap
u_int16_t balloc(){
    // #
    bitmap=bread(1);
    for(int i=0;i<BLOCKSIZE*NBITMAPBLOCK;i++){
        if(bitmap->data[i]!=0xff){
            for(int j=0;j<8;j++){
                if((bitmap->data[i]&(1<<j))==0){
                    bitmap->data[i]|=(1<<j);
                    return i*8+j;
                }
            }
        }
    }
}

u_int16_t ialloc(u_int8_t type,u_int16_t bno){
    for(int i=0;i<NINODEBLOCK;i++){
        struct block* ibk=bread(2+i);
        struct dinode* dne=(struct dinode*)malloc(sizeof(struct dinode));
        for(int j=0;j<IPB;j++){
            // read j th dinode at i th block
            memmove(dne,(ibk->data)+(sizeof(struct dinode))*j,sizeof(struct dinode));
            if(dne->type==0){
                dne->type=type;
                dne->size=0;
                dne->addr[0]=bno;
                return i*IPB+j;
            }
        }
    }
}

u_int16_t iwrite(u_int16_t inum,struct dinode* dne){

}

void iappent(){

}



void creatroot(){
    u_int16_t blockno=balloc();
    u_int16_t inum=ialloc(T_DIR,blockno);
    if(inum!=0){
        printf("alloc inode for root error!\n");
    }
    struct block* bk=bread(blockno);
    // init . dir
    struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
    drt->inum=inum;
    strcpy(drt->name,".");

    bwrite(blockno);
}

void init(){
    fd=open("fs.img",O_RDWR);

    // 初始化 bcache ,双向循环链表
    bcache=(struct block*)malloc(sizeof(struct block));
    bcache->next=bcache->prev=bcache;

    sb=(struct superblock*)malloc(sizeof(struct superblock));

    struct block* block=bread(0);
    memmove(sb,block->data,sizeof(struct superblock));

    block=bread(1);
    
    lseek(fd,BLOCKSIZE,SEEK_SET);

}


void mkfs(){
// Disk layout:
// [ sb block | free bit map | inode blocks | data blocks ]
//   1 block  |   1 block    |   m block    |    
    sb->size=BLOCKSIZE*8;
    sb->nblocks_used=0;
    sb->nblocks_free=sb->size;
    sb->ninodes_free=NINODE;
    sb->ninodes_used=0;
    sb->bmapstart=1;
    sb->inodestart=2;
    sb->datastart=2+NINODEBLOCK;
    lseek(fd,0,SEEK_SET);
    write(fd,sb,sizeof(struct superblock));
    // printf("%d\n",s);
    lseek(fd,BLOCKSIZE,SEEK_SET);
    u_char sbi=(1<<sb->datastart)-1;
    write(fd,&sbi,sizeof(sbi));
}

int main(){
    init();
    // mkfs();
    // balloc();
    creatroot();
    printf("sizeof:%ld\n",sizeof(struct dinode));
    printf("NINODE:%ld\n",NINODEBLOCK);
    printf("%d\n",sb->size);
    printf("%d\n",sb->nblocks_free);
    printf("%d\n",sb->nblocks_used);

    close(fd);
}