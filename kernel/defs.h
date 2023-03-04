/*
 * @Author: Outsider
 * @Date: 2022-07-12 09:17:23
 * @LastEditors: Outsider
 * @LastEditTime: 2022-09-17 17:38:39
 * @Description: In User Settings Edit
 * @FilePath: /los/kernel/defs.h
 */

#include "types.h"

// proc.h
struct pcb;
struct trapframe;

// swtch.S
struct context;

// buf.h
struct buf;

// fs.h
struct dinode;
struct dirent;
struct inode;

// lock.h
struct spinlock;

// uart.c
void uartinit();
char uartputc(char c);
void uartputs(char *s);
int uartgetc();
char uartintr();

// kvec.S
void kvec();
void tvec();

// printf.c
void printinit();
void panic(char *str);
int printf(const char *fmt, ...);
char *sprintf(char *str, const char *fmt, ...);
void assertfail(const char *__assertion, const char *__file,
                unsigned int __line, const char *__function);
void printferror(const char *__errmsg, const char *__file,
                 unsigned int __line, const char *__function);

#define assert(expr) (expr) ? 0 : assertfail(#expr, __FILE__, __LINE__, __FUNCTION__)
#define error(msg) printferror(#msg, __FILE__, __LINE__, __FUNCTION__)

// trap.c
void trapvec();
void usertrapret();

// pmm.c
void minit();
void *palloc();
void pfree(void *pa);

// kernel.ld
extern uint8 textstart[];
extern uint8 textend[];
extern uint8 rodatastart[];
extern uint8 rodataend[];
extern uint8 datastart[];
extern uint8 dataend[];
extern uint8 bssstart[];
extern uint8 bssend[];
extern uint8 mstart[];
extern uint8 mend[];
extern uint8 memstart[];
extern uint8 memend[];

// entry.S
extern uint stacks[];

// plic.c
void plicinit();
uint32 r_plicclaim();
void w_pliccomplete(uint32 irq);

// vm.c
void kvminit();
void kvmstart();
addr_t *pgtcreate();
void vmmap(addr_t *pgt, addr_t va, addr_t pa, uint sz, uint mode);
void mkstack(addr_t *pgt);
void printpgt(addr_t *pgt);
void vmunmap(addr_t *pagetable, addr_t va, size_t size, int freepa);
int copyin(addr_t *pagetable, addr_t vaddr, char *buf, int max);
void copyout(addr_t *pagetable, addr_t vaddr, char *buf, int max);
pte_t *acquriepte(addr_t *pgt, addr_t va);

// proc.c
void procinit();
void userinit();
void cpuinit();
struct pcb *nowproc();
struct cpu *nowcpu();
struct pcb *procalloc();
void forkret();
void schedule();
void yield();
void sched();
void sleep(void *chan, struct spinlock *spinlock);
void wakeup(void *chan);
void exit(int status);

// string.c
void *memset(void *, int, uint);
void *memmove(void *dst, const void *src, size_t n);
size_t strlen(const char *s);
int strcmp(char *p, char *q);
int strcpy(char *dst, char *src);

void swtch(struct context *old, struct context *new);

// usertrap.S
void userret(addr_t *tf, addr_t pgt);
extern char usertrap[];
extern char uservec[];

// clint.c
void clintinit();

// time.c
void timerinit();

// syscall.c
void syscall();
uint32 sysreg(int n);
void argint(int n, int *r);
void argaddr(int n, addr_t *r);
void argstr(int n, char *b, int cc);

// mmio.c
void mmioinit();
void diskrw(struct buf *buf, uint8 rw);
void diskintr();

// buf.c
void bufinit(void);
struct buf *bget(int bno);
void brelse(struct buf *b);
uint bufauto();

// fs.c
void fsinit();
int ialloc(uint8 type);
void read_dinode(uint32 inum, struct dinode *inode);
void write_dinode(uint32 inum, struct dinode *inode);
void read_dirent(struct inode *inode, struct dirent *dirent, uint32 offset);
uint32 read_data(struct inode *inode, char *buffer, uint32 offset, uint32 size);
struct inode *iget(uint32 inum);
void irelse(struct inode *inode);
int add_dirent(struct inode *inode, char *name, uint32 dinum);
struct inode *find_inode(uint32 inum, char *path);

// exec.c
int exec(char *path);
// fork.c
int fork();

// file.c
struct file *filealloc();
int filewrite(struct file *file, addr_t addr, int size);
int fileread(struct file *file, addr_t addr, int size);

// console.c
void consolewrite(char *vsrc, int size);
void consoleread(char *vdst, int size);
void consoleintr(char c);
void consoleinit();

// lock.c
void initspinlock(struct spinlock *spinlock, char *name);
void acquirespinlock(struct spinlock *spinlock);
void releasespinlock(struct spinlock *spinlock);
int checkspinlock(struct spinlock *spinlock);

// pci.c
void pciinit();