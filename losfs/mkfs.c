/*
 * @Author: Outsider
 * @Date: 2022-06-09 18:34:26
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-11 12:56:11
 * @Description: In User Settings Edit
 * @FilePath: /los/losfs/mkfs.c
 */
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>
#include<stdint.h>
#include<sys/fcntl.h>

#define BLOCKSIZE 512
#define NBLOCK 
#define CMDLEN 16
#define DIRET 8
#define NBUF 8
#define NOF 5
#define NINODE 50
#define NBITMAPBLOCK 1
#define BPB BLOCKSIZE*NBITMAPBLOCK*8
#define IPB (BLOCKSIZE/sizeof(struct dinode))
#define NINODEBLOCK (NINODE/IPB+1)

#define T_FILE 1
#define T_DIR 2

#define UNAME 6
#define PSLEN 8

#define MOD_RO 1
#define MOD_WO 2
#define MOD_RW 3
#define NUSER 5

#define DIRNAMESIZE 14

typedef uint8_t u_int8_t;
typedef uint16_t u_int16_t;
typedef uint32_t u_int32_t;
typedef uint64_t u_int64_t;
typedef u_int8_t u_char;

struct users
{
    /* data */
    int8_t id;          
    u_int8_t inum;      // 用户文件夹 inode
    char name[UNAME]; 
    char password[PSLEN];
};

struct users cuser;

struct superblock
{
    u_int16_t size;         // disk-size
    u_int16_t inodestart;
    u_int16_t bmapstart;
    u_int16_t datastart;
    struct users user[NUSER];
};

struct block
{
    u_int16_t blockno;
    u_char data[BLOCKSIZE]; /* data */
    struct block* prev;
    struct block* next;
};

// 已打开的文件信息
struct ofile{
    u_int16_t inum;     // inode-no
    u_int16_t mode;     // 权限
    char name[DIRNAMESIZE]; 
    int8_t addr[DIRET];
    struct ofile* prev;
    struct ofile* next;
};

struct ofile* fds;
struct block* bcache;

struct dinode
{
    /* data */
    u_int8_t    type;       // 类型，文件 - 目录
    u_int16_t   size;       
    u_int16_t   own;        // 所有者
    u_int16_t   mod;        // 权限
    int16_t   addr[DIRET];  // 一级索引
};

// dir item
struct dirent {
  uint8_t inum;              // inode-no
  char name[DIRNAMESIZE];   // 目录或文件名
};

int fdfs;       // 软盘文件描述符
struct superblock* sb;  // 超级块
struct block* bitmap;   // 位图
// struct block* inodemap; 

int cdir;           // 当前目录inode
char cdirname[14];  // 当前目录名

// 读取输入命令
char* gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}

// 将软盘中的数据调入内存   LRU调度
struct block* bread(u_int16_t blockno){
    struct block* bk=bcache->next;  
    while(bk!=bcache){
        // 在缓冲区中
        if(bk->blockno==blockno){
            // 将块调至链表头
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
            // 直接调入块
            struct block* nb=(struct block*)malloc(sizeof(struct block));
            nb->blockno=blockno;
            nb->next=bcache->next;
            nb->prev=bcache;
            bcache->next->prev=nb;
            bcache->next=nb;
            bcache->blockno++;
            lseek(fdfs,BLOCKSIZE*blockno,SEEK_SET);
            read(fdfs,nb->data,BLOCKSIZE);
            return bcache->next;
        }else{
            // 将块中数据写入软盘
            bk=bcache->prev;
            lseek(fdfs,bcache->prev->blockno*BLOCKSIZE,SEEK_SET);
            write(fdfs,bk->data,BLOCKSIZE);
            // 将新块数据调入
            bcache->prev->prev->next=bcache;
            bcache->prev=bcache->prev->prev;
            lseek(fdfs,BLOCKSIZE*blockno,SEEK_SET);
            read(fdfs,bk->data,BLOCKSIZE);
            bk->blockno=blockno;
            // 调到链表头
            bk->next=bcache->next;
            bk->prev=bcache;
            bcache->next->prev=bk;
            bcache->next=bk;
            return bcache->next;
        }
    }
}

// 将内存中块数据写入软盘
void bwrite(u_int16_t bno){
    struct block* bk=bcache->next;
    // if(bk==NULL){
    //     printf("d");
    // }
    while(bk!=bcache){
        if(bk->blockno==bno){
            lseek(fdfs,BLOCKSIZE*bno,SEEK_SET);
            write(fdfs,bk->data,BLOCKSIZE);
            return;
        }
        bk=bk->next;
    }
}

// 将缓冲区所有块写入软盘
void bawrite(){
    struct block* bk=bcache->next;
    while(bk!=bcache){
        bwrite(bk->blockno);
        bk=bk->next;
    }
}

// 清空软盘盘块
void bclear(u_int16_t bno){
    struct block* bk=bread(bno);
    memset(bk->data,0,BLOCKSIZE);
    bwrite(bno);    
}

/**
 * @description: 在位图中寻找空闲块
 * @return {*}  0失败 成功返回块号
 */
u_int16_t balloc(){
    bitmap=bread(1);   // 第一个块位位图块
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
    printf("block full!\n");
    return 0;
}

/**
 * @description: 释放块
 * @param {int} bunm    块号
 * @return {*}  成功1 失败0
 */
u_int16_t bfree(int bunm){
    bitmap=bread(1);
    int m=bunm/8;
    int n=bunm%8;
    int j=(1<<n);
    if(bitmap->data[m]&(1<<j)==0){
        return 0;
    }else{
        bitmap->data[m]&=~j;
        bclear(bunm);
        return 1;
    }
}

/**
 * @description: 分配 inode
 * @return {*}  成功 inode号 失败-1
 */
int ialloc(){
    for(int i=0;i<NINODEBLOCK;i++){
        struct block* ibk=bread(2+i);
        struct dinode* dne=(struct dinode*)malloc(sizeof(struct dinode));
        for(int j=0;j<IPB;j++){
            memmove(dne,(ibk->data)+(sizeof(struct dinode))*j,sizeof(struct dinode));
            if(dne->type==0){
                return i*IPB+j;
            }
        }
    }
    printf("\033[1;31minode full! \033[0m\n");
    return -1;
}

/**
 * @description: 查找打开文件项
 * @param {char*} name  文件名
 * @param {int} inum    文件 inode
 * @return {*}  失败NULL，成功返回指向文件表项的指针
 */
struct ofile* fdread(char* name,int inum){
    struct ofile* f=fds->next;
    while(f!=fds){
        if(f->inum==inum&&strcmp(f->name,name)==0){
            f->next->prev=f->prev;
            f->prev->next=f->next;

            f->next=fds->next;
            f->prev=fds;
            fds->next->prev=f;
            fds->next=f;

            return f;
        }
        f=f->next;
    }
    return NULL;
}

/**
 * @description:    读取 inode
 * @param {u_int16_t} inum  inode号
 * @param {dinode*} ide     inode 结构体
 */
void iread(u_int16_t inum,struct dinode* ide){
    struct block* bk=bread(2+inum/IPB);
    int m=inum%IPB;
    memmove(ide,bk->data+m*sizeof(struct dinode),sizeof(struct dinode));
}

/**
 * @description: 将 inode 信息写入软盘
 * @param {u_int16_t} inum  inode号
 * @param {dinode*} ide     inode结构体
 */
void iwrite(u_int16_t inum,struct dinode* ide){
    struct block* bk=bread(2+inum/IPB);
    int m=inum%IPB;
    memmove(bk->data+m*sizeof(struct dinode),ide,sizeof(struct dinode));
}

/**
 * @description: 往目录添加目录项
 * @param {block*} bk   块指针
 * @param {char*} name  目录名称
 * @param {u_int16_t} inum  inode号
 * @return {*}  成功0，同名1，没有空间2
 */
u_int8_t iappent(struct block* bk,char* name,u_int16_t inum){
    struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
    for(int i=0;i<BLOCKSIZE;i+=sizeof(struct dirent)){
        memmove(drt,bk->data+i,sizeof(struct dirent));
        if(strlen(drt->name)==0){ // is empty dirent
            drt->inum=inum;
            strcpy(drt->name,name);
            memmove(bk->data+i,drt,sizeof(struct dirent));
            return 0; // success
        }
        if(strcmp(drt->name,name)==0){
            printf("exist name\n");
            return 1; // exist
        }
    }
    return 2; // full
}

/**
 * @description: 根据名称查找 inode
 * @return {*} 成功 inode 号，失败-1
 */
int find(char* name){
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
    iread(cdir,ide);
    for(int i=0;i<DIRET&&ide->addr[i]!=-1;i++){
        struct block* bk=bread(ide->addr[i]);
        for(int j=0;j<BLOCKSIZE;j+=sizeof(struct dirent)){
            drt=(struct dirent*)(bk->data+j);
            if(strcmp(drt->name,name)==0){
                return drt->inum;
            }
        }
    }
    return -1;
}

// 创建根目录
void creatroot(){
    u_int16_t blockno=balloc();
    u_int16_t inum=ialloc();
    if(inum!=0){
        printf("alloc inode for root error!\n");
    }
    struct block* bk=bread(blockno);
    bclear(blockno);

    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    iread(inum,ide);
    memset(ide,-1,sizeof(struct dinode));
    ide->type=T_DIR;
    ide->mod=MOD_RW;
    ide->own=cuser.id;
    ide->addr[0]=blockno;
    ide->size=0;

    if(iappent(bk,".",inum)==0){
        ide->size+=sizeof(struct dirent);
    }
    if(iappent(bk,"..",inum)==0){
        ide->size+=sizeof(struct dirent);
    }
    iwrite(inum,ide);
    free(ide);
}

/**
 * @description:  从内存缓冲中读取目录项
 * @param {u_int16_t} bno   块号
 * @param {u_int16_t} offset  目录项在块中的偏移
 * @param {dirent*} drt     目录项结构体
 */
void dread(u_int16_t bno,u_int16_t offset,struct dirent* drt){
    struct block* bk=bread(bno);
    memmove(drt,bk->data+offset,sizeof(struct dirent));
}

/**
 * @description:    将目录项内容写入内存缓冲
 * @param {u_int16_t} bno   块号
 * @param {u_int16_t} offset  块内偏移
 * @param {dirent*} drt 目录项结构
 */
void dwrite(u_int16_t bno,u_int16_t offset,struct dirent* drt){
    struct block* bk=bread(bno);
    memmove(bk->data+offset,drt,sizeof(struct dirent));
}

/**
 * @description: 打开文件
 * @param {char*} name  文件名
 * @param {int} mode    读写模式
 */
void u_open(char* name,int mode){
    int inode=find(name);
    if(inode==-1){
        printf("\033[1;32mNot this FILE! \033[0m\n");
        return;
    }
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    iread(inode,ide);
    if(ide->type!=T_FILE){
        printf("\033[1;31mNot A FILE! \033[0m\n");
        free(ide);
        return;
    }
    if(ide->mod==MOD_RW||ide->mod==mode||ide->own==cuser.id){
        struct ofile* f=fds->next;
        // LRU
        while(f!=fds){
            if(f->inum==inode){
                f->mode=mode;
                for(int i=0;i<DIRET;i++){
                    f->addr[i]=ide->addr[i];
                }
                printf("\033[1;32mchange mode success! \033[0m\n");
                free(ide);
                return;
            }
            f=f->next;
        }
        if(f==fds){
            if(fds->inum<NOF){
                struct ofile* n=(struct ofile*)malloc(sizeof(struct ofile));
                n->inum=inode;
                n->mode=mode;
                strcpy(n->name,name);
                for(int i=0;i<DIRET;i++){
                    n->addr[i]=ide->addr[i];
                }
                n->next=fds->next;
                n->prev=fds;
                fds->next->prev=n;
                fds->next=n;
                
                fds->inum++;
                free(ide);
                return ;
            }else{
                f=f->prev;
                fds->prev->prev->next=fds;
                fds->prev=fds->prev->prev;

                f->inum=inode;
                f->mode=mode;
                strcpy(f->name,name);
                for(int i=0;i<DIRET;i++){
                    f->addr[i]=ide->addr[i];
                }
                f->next=fds->next;
                f->prev=fds;
                fds->next->prev=f;
                fds->next=f;
                free(ide);
                return;
            }
        }
    }else{
        printf("\033[1;31mNo permissions! \033[0m\n");
        free(ide);
        return;
    }
}
// * @description: 关闭文件
void u_close(char* name){
    int inode=find(name);
    struct ofile* fd=fds->next;
    while (fd!=fds)
    {
        if((strcmp(fd->name,name)==0)&&fd->inum==inode){
            fd->next->prev=fd->prev;
            fd->prev->next=fd->next;
            fds->inum--;
            free(fd);
            return;
        }
        fd=fd->next;
    }
    printf("\033[1;31mFile Not Open! \033[0m\n");
    return;
}

/**
 * @description:  创建文件夹
 * @param {char*} name  文件夹名
 */
void u_mkdir(char* name){
    struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    iread(cdir,ide);
    for(int i=0;i<DIRET&&ide->addr[i]!=-1;i++){
        for(int j=0;j<BLOCKSIZE;j+=sizeof(struct dirent)){
            dread(ide->addr[i],j,drt);
            if(strlen(drt->name)==0){
                int ie=ialloc();
                if(ie==-1){
                    return;
                }
                drt->inum=ie;
                strcpy(drt->name,name);
                struct dinode* inode=(struct dinode*)malloc(sizeof(struct dinode));
                iread(drt->inum,inode);
                memset(inode,-1,sizeof(struct dinode));
                inode->size=0;
                inode->type=T_DIR;
                inode->own=cuser.id;
                inode->mod=MOD_RW;  // 默认所有用户可读写
                inode->addr[0]=balloc();
                ide->size+=sizeof(struct dirent);
                
                if(iappent(bread(inode->addr[0]),".",drt->inum)==0){
                    inode->size+=sizeof(struct dirent);
                }
                if(iappent(bread(inode->addr[0]),"..",cdir)==0){
                    inode->size+=sizeof(struct dirent);
                }

                iwrite(cdir,ide);
                dwrite(ide->addr[i],j,drt);
                iwrite(drt->inum,inode);
                free(inode);
                return;
            }
            if(strcmp(drt->name,name)==0){
                printf("\033[1;31mExist same name! \033[0m\n");
                return;
            }
        }
        // 分配新的块
        if(i+1<DIRET&&ide->addr[i+1]==-1){
            ide->addr[i+1]=balloc();
            if(ide->addr[i+1]==0){
                printf("block full\n");
                return;
            }
        }
    }
}
// * @description: 切换目录
void u_cd(char* name){
    if(strcmp(name,"/")==0){
        cdir=0;
        strcpy(cdirname,"/");
        return;
    }
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    struct dirent* drt;
    struct block* bk;
    iread(cdir,ide);
    for(int i=0;i<=DIRET&&ide->addr[i]!=-1;i++){
        bk=bread(ide->addr[i]);
        for(int j=0;j<BLOCKSIZE;j+=sizeof(struct dirent)){
            drt=(struct dirent*)(bk->data+j);
            if(strcmp(drt->name,name)==0){
                iread(drt->inum,ide);
                if(ide->type!=T_DIR){
                    printf("\033[1;31mIt is not dir! \033[0m\n");
                    free(ide);
                    return ;
                }
                cdir=drt->inum;
                memset(cdirname,0,DIRNAMESIZE);
                if(strcmp(name,"..")==0){
                    strcpy(cdirname,"/");
                }else
                    strcpy(cdirname,drt->name);
                free(ide);
                return;
            }
        }
    }
    free(ide);
    printf("\033[1;31mNo exist dir! \033[0m\n");
}
// 修改文件权限
void u_chmod(char* name,u_int8_t mod){
    int inode=find(name);
    if(inode==-1){
        printf("\033[1;31mNo this file or dire! \033[0m\n");
        return;
    }
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    iread(inode,ide);
    if(ide->own!=cuser.id){ // 只能文件所有者修改
        printf("\033[1;31mYou Not Owner! \033[0m\n");
        free(ide);
        return;
    }
    ide->mod=mod;
    iwrite(inode,ide);
    free(ide);
}
// 列出目录内容
void u_ls(int cdir){
    struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    struct dinode* d=(struct dinode*)malloc(sizeof(struct dinode));
    iread(cdir,ide);
    
    printf("name\tsize\ttype\tinode\taddr\tmod\town\n");
    for(int i=0;i<DIRET&&ide->addr[i]!=-1;i++){
        struct block* bk=bread(ide->addr[i]);

        for(int j=0;j<BLOCKSIZE;j+=sizeof(struct dirent)){
            memmove(drt,bk->data+j,sizeof(struct dirent));
            if(strlen(drt->name)!=0){
                iread(drt->inum,d);
                char type[14];
                memset(type,0,14);
                switch (d->type)
                {
                case T_DIR:
                    strcpy(type,"dir");
                    break;
                case T_FILE:
                    strcpy(type,"file");
                    break;
                default:
                    strcpy(type,"unknow");
                    break;
                }
                char mod[8];
                memset(mod,0,8);
                switch (d->mod)
                {
                case MOD_RW:
                    strcpy(mod,"rw");
                    break;
                case MOD_RO:
                    strcpy(mod,"r-");
                    break;
                case MOD_WO:
                    strcpy(mod,"-w");
                    break;
                default:
                    strcpy(mod,"--");
                    break;
                }
                char username[UNAME];
                memset(username,0,UNAME);
                for(int i=0;i<NUSER;i++){
                    if(sb->user[i].id==d->own){
                        strcpy(username,sb->user[i].name);
                    }
                }
                if(d->type==T_FILE)
                    printf("\033[1;32m%s\t%d\t%s\t%d\t%d\t%s\t%s \033[0m\n",drt->name,d->size,type,drt->inum,d->addr[0],mod,username);
                if(d->type==T_DIR)
                    printf("\033[1;34m%s\t%d\t%s\t%d\t%d\t%s\t%s \033[0m\n",drt->name,d->size,type,drt->inum,d->addr[0],mod,username);
            }
        }
    }
    free(drt);
    free(ide);
    free(d);
}
// 初始化
void init(){
    fdfs=open("../fs.img",O_RDWR); // 读取软盘
    // 初始化 bcache 
    bcache=(struct block*)malloc(sizeof(struct block));
    bcache->next=bcache->prev=bcache;
    
    fds=(struct ofile*)malloc(sizeof(struct ofile));
    fds->next=fds->prev=fds;

    sb=(struct superblock*)malloc(sizeof(struct superblock));

    struct block* block=bread(0);
    memmove(sb,block->data,sizeof(struct superblock));

    cdir=0; //根目录默认为0
    memset(cuser.name,0,sizeof(cuser.name));
    memset(cdirname,0,DIRNAMESIZE);
    strcpy(cdirname,"/");
}

// 创建文件系统
void mkfs(){
// Disk layout:
// [ sb block | free bit map | inode blocks | data blocks ]
//   1 block  |   1 block    |   m block    |    
    for(int i=0;i<BLOCKSIZE*8;i++){
        bclear(i);
    }
    memset(sb,0,sizeof(struct superblock));


    sb->size=BLOCKSIZE*8;
    sb->bmapstart=1;
    sb->inodestart=2;
    sb->datastart=2+NINODEBLOCK;

    printf("Input root password: ");
    char ps[PSLEN];
    memset(ps,0,PSLEN);
    scanf("%s",ps);
    strcpy(sb->user[0].name,"root");
    sb->user[0].inum=0;
    sb->user[0].id=0;
    strcpy(sb->user[0].password,ps);
    for(int i=1;i<5;i++){
        sb->user[i].id=-1;
    }


    lseek(fdfs,0,SEEK_SET);
    write(fdfs,sb,sizeof(struct superblock));
    u_char sbi=(1<<sb->datastart)-1;
    struct block* bk=bread(1);
    memmove(bk->data,&sbi,sizeof(sbi));
    creatroot();
    bawrite();
}
// 创建文件
void u_touch(char* name){
    struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    struct dinode* inode=(struct dinode*)malloc(sizeof(struct dinode));

    iread(cdir,ide);
    for(int i=0;i<DIRET&&ide->addr[i]!=-1;i++){
        for(int j=0;j<BLOCKSIZE;j+=sizeof(struct dirent)){
            dread(ide->addr[i],j,drt);
            if(strlen(drt->name)==0){
                int ie=ialloc();
                if(ie==-1){
                    return;
                }
                drt->inum=ie;
                strcpy(drt->name,name);
                iread(drt->inum,inode);
                memset(inode,-1,sizeof(struct dinode));
                inode->size=0;
                inode->type=T_FILE;
                inode->own=cuser.id;
                inode->mod=MOD_RW;
                inode->addr[0]=balloc();
                ide->size+=sizeof(struct dirent);

                iwrite(cdir,ide);
                dwrite(ide->addr[i],j,drt);
                iwrite(drt->inum,inode);
                free(ide);
                free(drt);
                free(inode);
                return;
            }
            if(strcmp(drt->name,name)==0){
                printf("Exist same name!\n");
                free(ide);
                free(drt);
                free(inode);
                return;
            }
        }
        if(i+1<DIRET&&ide->addr[i+1]==-1){  // 分配新块
            ide->addr[i+1]=balloc();
            if(ide->addr[i+1]==0){
                printf("block full\n");
                free(ide);
                free(drt);
                free(inode);
                return;
            }
        }
    }
    printf("DIR FULL!\n");
    free(ide);
    free(drt);
    free(inode);
    return;
}
//* @description: 获取输入的文本
char* iget(char* buf,int max){
    int i, cc;
    char c;

    int flag=0;
    for(i=0; i+1 < max; ){
        cc = read(0, &c, 1);
        if(cc < 1)
        break;
        buf[i++] = c;
        if((c == '\n' || c == '\r')&&flag==1){
            flag=2;
            buf[i-1]='\0';
        }else
            flag=0;
        if(flag==2){
            break;
        }
        if((c == '\n' || c == '\r'))
            flag=1;
        
    }
    buf[i] = '\0';
    return buf;
}
//* @description: 读取文件内容
void u_read(char* name){
    int inode=find(name);
    struct ofile* fd=fdread(name,inode);
    if(fd==NULL){
        printf("\033[1;31mFile Not Open! \033[0m\n");
        return;
    }
    
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    iread(inode,ide);

    if(fd->mode==MOD_RO||fd->mode==MOD_RW){
        int m=ide->size/BLOCKSIZE;
        int n=ide->size%BLOCKSIZE;
        for(int i=0;i<=m;i++){
            struct block* bk=bread(ide->addr[i]);
            printf("%s",bk->data);
        }
        free(ide);
    }else{
        printf("\033[1;31mNo pressiom read! \033[0m\n");
        free(ide);
        return;
    }
}
//* 写文件
void u_write(char* name,char* buf){
    int inode=find(name);
    struct ofile* fd=fdread(name,inode);
    if(fd==NULL){
        printf("\033[1;31mFILE NOT OPEN! \033[0m\n");
        return;
    }

    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    iread(fd->inum,ide);
    struct block* bk;
    

    if(fd->mode==MOD_WO||fd->mode==MOD_RW){
        if(strlen(buf)==0){
            iget(buf,BLOCKSIZE);
        }
        int m=ide->size/BLOCKSIZE;

        int n=ide->size%BLOCKSIZE;
        int len=strlen(buf);
        if(m>=DIRET){
            printf("\033[1;31mFile Too Big! \033[0m\n");
            return;
        }

        if(len+n>BLOCKSIZE||(m>0&&n==0)){    // 超过一个块
            if(n==0){
                if(m>=DIRET){   // 一级索引已全部使用
                    printf("\033[1;31mFile Too Big! \033[0m\n");
                    free(ide);
                    return;
                }
                if(ide->addr[m]==-1){
                    ide->addr[m]=balloc();
                }
                bk=bread(ide->addr[m]);
                memmove(bk->data,buf,len);
                ide->size+=len;
                iwrite(inode,ide);
                free(ide);
                return;
            }
            int p=BLOCKSIZE-n;
            bk=bread(ide->addr[m]);
            memmove(bk->data+n,buf,p);
            if(m>=DIRET){
                printf("\033[1;31mFile Too Big! \033[0m\n");
                free(ide);
                return;
            }
            if(ide->addr[m+1]==-1){
                ide->addr[m+1]=balloc();
            }
            bk=bread(ide->addr[m+1]);
            memmove(bk->data,buf+p,len-p);
            ide->size+=len;
            iwrite(inode,ide);
            free(ide);
        }else{
            struct block* bk=bread(ide->addr[m]);
            memmove(bk->data+n,buf,len);
            ide->size+=len;
            iwrite(inode,ide);
            free(ide);
        }
    }else{
        printf("\033[1;31mNo permissions write! \033[0m\n");
        free(ide);
        return;
    }
}
//* 删除文件或目录
void u_rm(char* name){
    if(strcmp(name,"/")==0){
        printf("\033[1;31mCan't delete root! \033[0m\n");
        return;
    }
    struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
    struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
    struct block* bk;

    iread(cdir,ide);
    for(int i=0;i<=DIRET&&ide->addr[i]!=-1;i++){
        for(int j=0;j<BLOCKSIZE;j+=sizeof(struct dirent)){
            bk=bread(ide->addr[i]);
            dread(ide->addr[i],j,drt);
            if(strcmp(drt->name,name)==0){
                struct dinode* inode=(struct dinode*)malloc(sizeof(struct dinode));
                iread(drt->inum,inode);
                for(int k=0;k<DIRET&&inode->addr[k]!=-1;k++){
                    bclear(inode->addr[k]);
                    bfree(inode->addr[k]);
                    inode->addr[k]=-1;
                }
                inode->type=0;
                ide->size-=sizeof(struct dirent);
                iwrite(cdir,ide);
                iwrite(drt->inum,inode);
                memset(drt->name,0,sizeof(drt->name));

                dwrite(ide->addr[i],j,drt);
                free(ide);
                free(inode);
                free(drt);
                return;
            }
        }
    }
    free(ide);
    free(drt);
    printf("\033[1;31mNo exist dir! \033[0m\n");
}
void u_exit(){  //退出
    bawrite();
    exit(0);
}
void test_touch(){  // 测试touch
    for(int i=0;i<61;i++){
        char buf[10];
        sprintf(buf,"f%d",i);
        u_touch(buf);
    }
}
void test_mkdir(){  // 测试mkdir
    for(int i=0;i<61;i++){
        char buf[10];
        sprintf(buf,"f%d",i);
        u_mkdir(buf);
    }
}
void test_rm(){    // 测试rm
    for(int i=0;i<61;i++){
        char buf[10];
        sprintf(buf,"f%d",i);
        u_rm(buf);
    }
}
void test_write(){  // 测试写文件
    u_touch("test");
    u_open("test",MOD_RW);
    char buf[513];
    char* p=buf;
    for(int i=0;i<510;i++){
        *(p+i)='a';
    }
    buf[510]='@';
    buf[511]='\n';
    buf[512]='\0';
    u_write("test",buf);
    bawrite();
}
// 添加用户
void useradd(char* name){
    for(int i=0;i<5;i++){
        // printf("user");
        if(sb->user[i].id==-1){
            strcpy(sb->user[i].name,name);
            u_mkdir(name);
        
            struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
            struct dinode* ide=(struct dinode*)malloc(sizeof(struct dinode));
            iread(cdir,ide);
            // int m=ide->size/BLOCKSIZE;
            // struct dirent* drt=(struct dirent*)malloc(sizeof(struct dirent));
            for(int j=0;j<DIRET&&ide->addr[j]!=-1;j++){
                for(int k=0;k<BLOCKSIZE;k+=sizeof(struct dirent)){
                    dread(ide->addr[j],k,drt);
                    if(strcmp(drt->name,name)==0){
                        sb->user[i].inum=drt->inum;
                        sb->user[i].id=i;
                    }
                }
            }
            printf("input password: ");
            scanf("%s",sb->user[i].password);
            //! no write
            struct block* bk=bread(0);
            memmove(bk->data,sb,sizeof(struct superblock));
            return;
        }
    }
}
int argc;
char argv[5][28];
char path[5][28];
void parse_cmd(){
    if(argc<1){
        printf("cmd error");
    }
    if(strlen(argv[1])==0){
        return;
    }
    if(strcmp(argv[1],"ls")==0){
        u_ls(cdir);
    }else if(strcmp(argv[1],"exit")==0){
        u_exit();
    }else if(strcmp(argv[1],"mkdir")==0){
        if(argc!=2){
            printf("\033[1;31mUsage mkdir dirname! \033[0m\n");
            return;
        }
        u_mkdir(argv[2]);
        bawrite();
    }else if(strcmp(argv[1],"touch")==0){
        if(argc!=2){
            printf("\033[1;31mUsage touch filename! \033[0m\n");
            return;
        }
        u_touch(argv[2]);
        bawrite();
    }else if(strcmp(argv[1],"cd")==0){
        if(argc>2){
            printf("\033[1;31mUsage cd or cd dirname! \033[0m\n");
            return;
        }
        if(argc==1){
            return;
        }
        if(strcmp(argv[2],".")==0){
            return;
        }
        u_cd(argv[2]);
    }else if(strcmp(argv[1],"rm")==0){
        if(argc!=2){
            printf("\033[1;31mUsage rm filename or rm dirname! \033[0m\n");
            return;
        }
        u_rm(argv[2]);
        bawrite();
    }else if(strcmp(argv[1],"chmod")==0){
        if(argc!=3){
            printf("\033[1;31mUsage chmod name mod! \033[0m\n");
            return;
        }
        u_int8_t mod=0;
        if(strcmp(argv[3],"r")==0){
            mod=MOD_RO;
        }else if(strcmp(argv[3],"w")==0){
            mod=MOD_WO;
        }else if(strcmp(argv[3],"rw")==0){
            mod=MOD_RW;
        }else{
            printf("\033[1;31mMod Error! \033[0m\n");
            return;
        }
        u_chmod(argv[2],mod);
        bawrite();
    }else if(strcmp(argv[1],"test_touch")==0){
        test_touch();
    }else if(strcmp(argv[1],"test_write")==0){
        test_write();
    }else if(strcmp(argv[1],"test_mkdir")==0){
        test_mkdir();
    }else if(strcmp(argv[1],"test_rm")==0){
        test_rm();
    }else if(strcmp(argv[1],"write")==0){
        if(argc!=2){
            printf("\033[1;31mUsage write filename! \033[0m\n");
            return;
        }
        char buf[BLOCKSIZE];
        memset(buf,0,BLOCKSIZE);
        u_write(argv[2],buf);
        bawrite();
    }else if(strcmp(argv[1],"read")==0){
        if(argc==1){
            printf("\033[1;31mUsage write filename! \033[0m\n");
            return;
        }
        u_read(argv[2]);
    }else if(strcmp(argv[1],"show")==0){
        printf("name\tinode\tmod\taddr\n");
        char mod[8];
        struct ofile* fd=fds->next;
        while(fds!=fd){
            memset(mod,0,8);
            switch (fd->mode)
            {
            case MOD_RW:
                strcpy(mod,"rw");
                break;
            case MOD_RO:
                strcpy(mod,"r-");
                break;
            case MOD_WO:
                strcpy(mod,"-w");
                break;
            default:
                break;
            }
            printf("\033[1;35m%s\t%d\t%s\t\033[0m",fd->name,fd->inum,mod);
            for(int i=0;i<DIRET&&fd->addr[i]!=-1;i++){
                printf("\033[1;35m%d \033[0m",fd->addr[i]);
            }
            printf("\n");
            fd=fd->next;
        }
    }else if(strcmp(argv[1],"close")==0){
        if(argc!=2){
            printf("\033[1;31mUsage close filename! \033[0m\n");
            return;
        }
        u_close(argv[2]);
    }else if(strcmp(argv[1],"open")==0){
        if(argc!=3){
            printf("\033[1;31mUsage open filename mode! \033[0m\n");
            return;
        }
        u_int8_t mod=0;
        if(strcmp(argv[3],"r")==0){
            mod=MOD_RO;
        }else if(strcmp(argv[3],"w")==0){
            mod=MOD_WO;
        }else if((strcmp(argv[3],"rw")==0)||(strcmp(argv[3],"wr")==0)){
            mod=MOD_RW;
        }else{
            printf("\033[1;31mMode Error! \033[0m\n");
            return;
        }
        u_open(argv[2],mod);
    }else if(strcmp(argv[1],"useradd")==0){
        if(argc!=2){
            printf("\033[1;31mUsage useradd username! \033[0m\n");
            return;
        }
        if(strcmp(cuser.name,"root")!=0){
            printf("\033[1;31mare you root? \033[0m\n");
            return;
        }
        useradd(argv[2]);
        bawrite();
    }else if(strcmp(argv[1],"mkfs")==0){
        mkfs();
        printf("\033[1;31mInit fs! \033[0m\n");
        return;
    }else if(strcmp(argv[1],"logout")==0){
        u_exit();
        printf("\033[1;31mInit fs! \033[0m\n");
        return;
    }
    else{
        printf("\033[1;31mNo this command! \033[0m\n");
        return;
    }
}
//* 处理命令字符串
void p_cmd(char* cmd){
    int i=0;
    argc=1;
    for(int i=0;i<5;i++){
        memset(argv[i],0,28);
    }
    int j=0;
    i=0;
    // printf("%s\n",cmd);
    while(1){
        if(i>=CMDLEN){
            break;
        }
        if(cmd[i]=='\n'){
            break;
        }
        if(cmd[i]==' '){
            argc++;
            j=0;
            i++;
            continue;
        }
        argv[argc][j++]=cmd[i++];
    }
}

int main(){
    init();
    
    #ifdef DEBUG
    printf("sizeof:%ld\n",sizeof(struct dinode));
    printf("NINODE:%ld\n",NINODEBLOCK);
    printf("%d\n",sb->size);
    #endif

    int login=1;
    while(login){
        memset(cuser.name,0,sizeof(cuser.name));
        printf("user: ");
        scanf("%s",cuser.name);
        printf("password: ");
        char ps[PSLEN];
        memset(ps,0,PSLEN);
        scanf("%s",ps);
        for(int i=0;i<NUSER;i++){
            // printf("%s %s\n",sb->user[i].name,cuser.name);
            if(strcmp((sb->user[i]).name,cuser.name)==0){
                if(strcmp(sb->user[i].password,ps)==0){
                    login=0;
                    cuser.id=sb->user[i].id;
                    cdir=sb->user[i].inum;
                    strcpy(cuser.name,sb->user[i].name);
                    strcpy(cdirname,i?cuser.name:"/");
                    break;
                }else{
                    printf("\033[1;31mpassword error! \033[0m\n");
                    break;
                }
            }
            if(i==NUSER-1){
                printf("\033[1;31mNot this user! \033[0m\n");
                break;  
            }
        }
    }

    while(1){
        char cmd[CMDLEN];
        memset(cmd,0,CMDLEN);
        printf("%s: \033[1;34m%s> \033[0m",cuser.name,cdirname);
        // printf("\033[1;34root: %s>\033[0m",cdirname);
        fflush(stdout);
        gets(cmd,CMDLEN);
        // printf("%s",cmd);
        p_cmd(cmd);
        // for(int i=1;i<=argc;i++){
        //     printf("%s ",argv[i]);
        // }
        // printf("\n");
        parse_cmd();
    }

    close(fdfs);
}