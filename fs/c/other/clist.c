#include<stdlib.h>
#include<stdio.h>

struct Node
{
    /* data */
    int data;
    struct Node* prev;
    struct Node* next;
};


int main(){
    struct Node* head=(struct Node*)malloc(sizeof(struct Node));
    head->prev=head->next=head;

    for(int i=0;i<10;i++){
        struct Node* n=(struct Node*)malloc(sizeof(struct Node));
        n->data=i;
        n->next=head->next;
        n->prev=head;
        head->next->prev=n;
        head->next=n;

    }

    for(int i=10;i<20;i++){
        struct Node* n=(struct Node*)malloc(sizeof(struct Node));
        n->data=i;
        n->next=head;
        n->prev=head->prev;
        head->prev->next=n;
        head->prev=n;
    }

    struct Node* p=head->next;
    while (head!=p)
    {
        /* code */
        printf("%d ",p->data);
        p=p->next;
    }
    
    printf("\n");
}