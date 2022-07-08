#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>

int main()
{
    printf("父进程：%d\n",getpid());
    int arr[2];
    char buf[20];

    pipe(arr);
    if(fork()==0){
        char s[]="Hello World!";
        write(arr[1],s,sizeof(s));
        close(arr[0]);
        close(arr[1]);
    }else{
        read(arr[0],buf,sizeof(buf));
        printf("%s\n",buf);
        close(arr[0]);
        close(arr[1]);
    }
    return 0;
}


