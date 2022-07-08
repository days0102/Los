#include<stdio.h>
#include<stdlib.h>
#include<sys/wait.h>
#include<unistd.h>

int main(){
    for(int i=0;i<100;i++){
        printf("=");
        fflush(stdout);
        if(i%2){
            printf("\b ");
            printf("\b");
        }
        usleep(100000);
    }
    printf("\n");
}
