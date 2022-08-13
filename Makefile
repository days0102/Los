CPUS = 1

QEMU = qemu-system-riscv32 # 32bit
# QEMU = qemu-system-riscv64	#64bit
QFLAGS = -nographic -smp $(CPUS) -machine virt -bios none
QFLAGS += -drive file=fs.img,if=none,format=raw,id=x0 # file system
QFLAGS += -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 #MMIO

CROSS_COMPILE = riscv64-unknown-elf-
CFLAGS = -nostdlib -fno-builtin -march=rv32ima -mabi=ilp32 -g -MD# 32bit 
# CFLAGS = -nostdlib -fno-builtin -march=rv64ima -mabi=lp64 -g -Wall -mcmodel=medany # 64bit
CFLAGS += -I.# 包含当前目录
CFLAGS += -Wall -Wno-main# 显示警告

GCCFLAGS = -g
# debug
CDEBUG = 0
ifeq ($(CDEBUG),1)
	# CFLAGS += -DDEBUG
endif
# debug
D = 
ifdef D
	CFLAGS += -DDEBUG
	GCCFLAGS += -DDEBUG
endif

GDB = gdb-multiarch
CC = ${CROSS_COMPILE}gcc
LD = ${CROSS_COMPILE}ld
OBJCOPY = ${CROSS_COMPILE}objcopy
OBJDUMP = ${CROSS_COMPILE}objdump


SRCS_ASM = \
	initos/entry.S \
	kernel/kvec.S \
	kernel/swtch.S \
	kernel/uvec.S \

SRCS_C = \
	initos/start.c \
	kernel/uart.c \
	kernel/main.c \
	kernel/trap.c \
	kernel/printf.c \
	kernel/pmm.c \
	kernel/plic.c \
	kernel/vm.c \
	kernel/proc.c \
	kernel/string.c \
	kernel/clint.c \
	kernel/timer.c \
	kernel/syscall.c \
	kernel/mmio.c \
	kernel/buf.c \
	kernel/fs.c \

SRCS_USER = \
	user/initproc.c \

OBJS = $(SRCS_ASM:.S=.o)
OBJS += $(SRCS_C:.c=.o)

# 用户进程的依赖文件
ULIB = user/usyscall.o
UPROC= $(SRCS_USER:%.c=%.elf)

# LDFLAGS = -z max-page-size=4096

# .SECONDARY:  # 保留所有中间文件
.PRECIOUS: %.o # 保留中间过程的 .o 文件
%.elf :%.o $(ULIB)
	$(CC) $(CFLAGS) -N -e main -Ttext 0 -o $@ $^

user:$(UPROC)
	@# @echo $(UPROC)
	@echo "	Make UProc OK! "

all:kernel.elf $(UPROC) fs.img
	@echo "	Make OK! "

run:kernel.elf
	@echo "Press Ctrl-A and then X to exit QEMU"
	${QEMU} ${QFLAGS} -kernel kernel.elf
	@# @rm -rf *.o *.bin */*.o */*.d
	
kernel.elf: ${OBJS}
	@# ${CC} ${CFLAGS} -Ttext=0x80000000 -o kernel.elf $^
	${CC} ${CFLAGS} -T kernel.ld -o kernel.elf $^
	@${OBJCOPY} -O binary kernel.elf kernel.bin
	@${OBJDUMP} -S kernel.elf > kernel.asm

# $@  表示目标文件
# $^  表示所有的依赖文件
# $<  表示第一个依赖文件
# $?  表示比目标还要新的依赖文件列表
%.o : %.c
	${CC} ${CFLAGS} -c -o $@ $<

%.o : %.S
	${CC} ${CFLAGS} -c -o $@ $<

zeroproc : user/zeroproc.S
	$(CC) $(CFLAGS) -c user/zeroproc.S -o user/zeroproc.o
	$(OBJCOPY) -S -O binary user/zeroproc.o user/zeroproc.bin
	$(OBJDUMP) -S user/zeroproc.o > user/zeroproc.asm

losfs/mkfs.elf: losfs/mkfs.c
	gcc $(GCCFLAGS) losfs/mkfs.c -o losfs/mkfs.elf

fs.img : losfs/mkfs.elf
	losfs/mkfs.elf fs.img Makefile $(UPROC)
	@# dd if=[/dev/sda] of=fs.img bs=8M count=1

debug: CFLAGS += -D DEBUG
debug: kernel.elf
	@echo "Press Ctrl-C and then input 'quit' to exit GDB and QEMU"
	@echo "-------------------------------------------------------"
	@${QEMU} ${QFLAGS} -kernel kernel.elf -s -S 
	@ # ${GDB} kernel.elf -q -x gdbinit

local:
	@echo "Press Ctrl-C and then input 'quit' to exit GDB and QEMU"
	@echo "-------------------------------------------------------"
	@${QEMU} ${QFLAGS} -kernel kernel.elf -s -S &
	@${GDB} kernel.elf -q -x other/localgdbinit

clean:
	rm -rf *.o *.bin *.elf */*.o */*.d */*.elf */_* */*.bin *.asm */*.asm

code: kernel.elf
	@ # ${OBJDUMP} -S kernel.elf | less
	@${OBJDUMP} -S kernel.elf > kernel.asm # -M no-aliases,numeric显示原始信息
	