/*
 * @Author: Outsider
 * @Date: 2022-07-19 16:25:16
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-19 17:03:39
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/string.c
 */
#include "types.h"

// 初始化内存区域
void* memset(void* addr,int c,uint n){
    char* maddr = (char*)addr;
    for(uint i=0;i<n;i++){
        maddr[i] = (char)c;
    }
    return addr;
}

// 安全的 memcpy 
// 将 src 的内容复制到dst中 (src和dst可能重叠)
// 保证 src 全部复制到 dst , src 内容可能改变
void* memmove(void* dst,const void* src,size_t n){
    const char* s;
    char* d;
    if(n==0){
        return dst;
    }

    s = src;
    d = dst;
    if(s < d && s + n > d){     
        // 有重叠区域,从后往前复制
        s += n;
        d += n;
        while(n-- > 0){
            *--d = *--s;
        }
    }else{              
        // 无重叠区域,从前往后复制
        while(n-- >0){
            *d++ = *s++;
        }
    }
    return dst;
}

// 字符串长度 包含 '\0'
size_t strlen(const char* s){
    size_t n;

    for(n = 0; s[n] ; n++);
    
    return n;
}