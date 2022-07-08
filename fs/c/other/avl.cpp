#include<iostream>
#include<ctime>
using namespace std;

struct Node
{
    /* data */
    Node* left;
    Node* right;
    int val;
    int balance;
};

Node* root;

void insert(Node* &root,int val){
    if(root==NULL){
        root=(Node*)malloc(sizeof(Node));
        root->left=root->right=NULL;
        root->val=val;
        root->balance=0;
        return;
    }
    if(root->val<val){
        insert(root->right,val);
    }
    if(root->val>val){
        insert(root->left,val);
    }
}

int main(){
    srand(time(NULL));
    for(int i=0;i<10;i++){
        insert(root,rand()%50);
    }
    for(;;);
}