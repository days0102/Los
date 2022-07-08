#include<stdio.h>
#include<fcntl.h>
#include<stdlib.h>

int main(int argc,char* argv[]){
    if(argc!=2){    // 执行命令 check_sum 文件名
        printf("Usage check_sum filename\n");
        exit(1);
    }

    // 打开文件
    FILE* fd=fopen(argv[1],"rb");
    if(fd==NULL){
        printf("Open Error\n");
        exit(0);
    }
    char* buf=malloc(2);        // 分配 2 字节空间
    u_int32_t res=0;            // 记录结果
    u_int32_t flag=0xffff0000;  // 用于取高 16 位内容
    u_int32_t sum=0;
    while(fread(buf,1,2,fd)){
        u_int32_t num=buf[0]<<8;// 将buf[0]置于高 8 位
        num+=buf[1];            // 将buf[1]置于低 8 位
        printf("%s : %#x\n",buf,num);
        res+=num;          
        // 处理进位
        while((res&flag)!=0){   // 相与获取高 8 位并将低 8 位置 0
            // 进位
            sum=res;
            sum>>=16;           // 将进位的内容移到低 16 位
            res&=0x0000ffff;    // 将进位的内容清 0
            res+=sum;           // 加上进位
        }
    }
    
    printf("res: %#x\n",~res&0x0000ffff);

    fclose(fd);
    exit(0);
}