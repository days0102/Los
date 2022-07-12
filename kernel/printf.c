/*
 * @Author: Outsider
 * @Date: 2022-07-11 10:42:08
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-12 23:02:38
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/printf.c
 */
#include "defs.h"
#include "types.h"
#include "stdarg.h"

void panic(char* s){
    uartputs("panic: ");
    uartputs(s);
    while(1);
}

static char outbuf[1024];
int printf(const char* fmt,...){
	
    va_list vl;
	va_start(vl,fmt);
	char ch;
	const char* s = fmt;
	int tt=0;
	int bb=0;
	int ll=0;
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
			continue;
		}else{
			if(tt==1){
				switch (ch)
				{
				case 'l':
					ll=1;
					break;
				case 'd':
				{
					long x=ll?va_arg(vl,long):va_arg(vl,int);
					int len=0;
					for(long n=x;n/=10;len++);
					for(int i=len;i>=0;i--){
						outbuf[idx+i]='0'+(x%10);
						x/=10;
					}
					idx+=(len+1);
					ll=0;
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
					unsigned long x=ll?va_arg(vl,long):va_arg(vl,int);
					int len=0;
					for(long n=x;n/=16;len++);
					for(int i=len;i>=0;i--){
						char c=(x%16)>10?'a'+(x%16)-10:'0'+(x%16);
						outbuf[idx+i]=c;
						x/=16;
					}
					idx+=(len+1);
					tt=0;
					break;
				}
				case 'c':
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
	va_end(vl);
	uartputs(outbuf);
}