#include<stdio.h>
#include<stdlib.h>

void func(int y){
    int x=y;
    if(y==2){
        return;
    }
    func(y-1);
    printf("%p %d\n",&x,x);
}

int main(){
    func(5);
}