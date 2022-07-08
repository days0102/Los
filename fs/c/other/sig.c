#include<signal.h>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>

void fun(){
    printf("catch");
}
int main(){
    signal(SIGINT,fun);
    sleep(20);
    exit(0);
}
