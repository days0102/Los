/*
 * @Author: Outsider
 * @Date: 2022-07-11 22:29:05
 * @LastEditors: Outsider
 * @LastEditTime: 2022-07-12 09:15:54
 * @Description: 物理内存管理 Physical Memory Management
 * @FilePath: /los/kernel/pmm.c
 */
#include "types.h"

extern uint32 textstart[];
extern uint32 textend[];
extern uint32 rodatastart[];
extern uint32 rodataend[];
extern uint32 datastart[];
extern uint32 dataend[];
extern uint32 bssstart[];
extern uint32 bssend[];
extern uint32 end[];
extern uint32 heapstart[];
extern uint32 heapend[];

void minit(){
    uint32* ts=textstart;
    uint32* te=textend;
    uint32* rs=rodatastart;
    uint32* re=rodataend;
    uint32* ds=datastart;
    uint32* de=dataend;
    uint32* bs=bssstart;
    uint32* be=bssend;
    uint32* e=end;
    uint32* hs=heapstart;
    uint32* he=heapend;
}