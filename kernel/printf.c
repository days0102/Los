/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:42:08
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-21 11:51:25
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/printf.c
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
    uartputs("panic: ");
    uartputs(s);
	uartputs("\n");
    while(1);
}

static char outbuf[1024];
// 简易版 printf
// 未处理异常
int printf(const char* fmt,...){
    va_list vl;			// 保存参数的地址，定义在stdarg.h
	va_start(vl,fmt);	// 将vl指向fmt后面的参数
	char ch;
	const char* s = fmt;
	int tt=0;
	int idx=0;
	while(ch=*(s)){
		if(ch=='%'){
			if(tt==1){
				outbuf[idx++]='%';
				tt=0;
			}else{
				tt=1;
			}
			s++;
		}else{
			if(tt==1){
				switch (ch)
				{
				// case 'l':
				// 	ll=1;
				// 	break;
				case 'd':
				{
					// 获取参数，将指针指向下一个参数
					int x=va_arg(vl,int);
					int len=0;
					for(int n=x;n/=10;len++);
					for(int i=len;i>=0;i--){
						outbuf[idx+i]='0'+(x%10);
						x/=10;
					}
					idx+=(len+1);
					tt=0;
					break;
				}
				case 'p':
				{
					outbuf[idx++]='0';
					outbuf[idx++]='x';
				}	// 接着下面输出16进制数
				case 'x':
				case 'X':	// 大小写一致
				{
					uint x=va_arg(vl,uint);
					int len=0;
					for(unsigned int n=x;n/=16;len++);
					for(int i=len;i>=0;i--){
						char c=(x%16)>=10?'a'+((x%16)-10):'0'+(x%16);
						outbuf[idx+i]=c;
						x/=16;
					}
					idx+=(len+1);
					tt=0;
					break;
				}
				case 'c':
					// 'char' is promoted to 'int' when passed through '...'
					ch=va_arg(vl,int);
					outbuf[idx++]=ch;
					tt=0;
					break;
				case 's':
				{
					char* ss=va_arg(vl,char*);
					while(*ss){
						outbuf[idx++]=*ss++;
					}
					tt=0;
					break;
				}
				default:
					panic("printf not this type!\n");
					break;
				}
				s++;
			}else{
				outbuf[idx++]=ch;
				s++;
			}
		}
	}
	va_end(vl);	// 释法参数
	outbuf[idx]='\0';
	uartputs(outbuf);
}