#include<stdio.h>
#include<sys/stat.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/file.h>

int main(){
    int fd=open(".",0);
    struct stat buf;

    fstat(fd,&buf);

    printf("%ld\n",buf.st_size);
    printf("%ld\n",buf.st_dev);

    close(fd);
}
