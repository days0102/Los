#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#include <signal.h>

void* producer(void* arg,int num){
    printf("生产者：%d\t%ld\n",num,pthread_self());
}

struct Arg{
    void* arg;
    int num;
};

pthread_t n;
int main(){
    for(int i=0;i<5;i++){
        struct Arg arg={
            NULL,
            i
        };
        pthread_create(&n,NULL,producer,&arg);
    }
}
