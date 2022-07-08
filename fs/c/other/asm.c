

int main(){
    int a;
    asm volatile("movl %%eax,%0;" :"=r" (a));
}