#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<pthread.h>

void* fun(void* arg){
    for(int i=0;i<5;i++){
        sleep(2);
        printf("子线程：%ld\n",pthread_self());
    }
}

pthread_t n;
int main()
{
    pthread_create(&n,NULL,fun,NULL);
    for(int i=0;i<5;i++){
        sleep(2);
        printf("父线程：%ld\n",pthread_self());
    }
    return 0;
}
