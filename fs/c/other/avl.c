#include<stdio.h>
#include<stdlib.h>
#include<time.h>


typedef struct Node
{
    /* data */
    struct Node* left;
    struct Node* right;
    int val;
    int balance;
}Node;
struct Node* root;

int max(int a,int b){
    return a>b?a:b;
}

void init(){
    root=(Node*)malloc(sizeof(Node));
    root->left=root->right=NULL;
    root->val=root->balance=0;
}

int hight(Node* root){
    if(root==NULL){
        return 0;
    }
    int left=hight(root->left);
    int right=hight(root->right);
    return max(left,right)+1;
}

void insert(Node** root,int val){
    if(*root==NULL){
        *root=(Node*)malloc(sizeof(Node));
        (*root)->left=(*root)->right=NULL;
        (*root)->val=val;
        (*root)->balance=0;
        return;
    }
    if((*root)->val<val){
        insert(&(*root)->right,val);
    }
    if((*root)->val>val){
        insert(&(*root)->left,val);
    }
    (*root)->balance=hight((*root)->left)-hight((*root)->right);
}

// RR左旋
void left_r(Node** root){
    Node* temp=(*root)->right;
    temp->left=(*root);
    (*root)=temp;
}

int main(){
    srand(time(NULL));
    // init();
    for(int i=0;i<5;i++){
        insert(&root,rand()%50);
    }
    for(;;);
}