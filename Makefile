CPUS = 1

QEMU = qemu-system-riscv32# 32bit
# QEMU = qemu-system-riscv64	#64bit
QFLAGS = -nographic -smp $(CPUS) -machine virt -bios none
QFLAGS += -drive file=fs.img,if=none,format=raw,id=x0# file system
QFLAGS += -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0#MMIO
# qemu 虚拟网卡 
# https://wiki.qemu.org/Documentation/Networking#How_to_create_a_network_backend?
QFLAGS += -netdev user,id=net
QFLAGS += -device e1000,netdev=net,bus=pcie.0
QFLAGS += -object filter-dump,id=net,netdev=net,file=net.dat

CROSS_COMPILE = riscv64-unknown-elf-
CFLAGS = -nostdlib -fno-builtin -march=rv32ima -mabi=ilp32 -g -MD# 32bit 
# CFLAGS = -nostdlib -fno-builtin -march=rv64ima -mabi=lp64 -g -Wall -mcmodel=medany # 64bit
CFLAGS += -I.# 包含当前目录
CFLAGS += -Wall# 显示警告
CFLAGS += -Werror
# CFLAGS +=  -Wno-main # 关闭 mian 函数警告
CFLAGS += -ffreestanding#按独立环境编译;他隐含声明了`-fno-builtin'选项,而且对 main 函数没有特别要求.

GCCFLAGS = -g -MD
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
	kernel/exec.c \
	kernel/fork.c \
	kernel/file.c \
	kernel/sysfile.c \
	kernel/console.c \
	kernel/lock.c \
	kernel/pci.c \
	kernel/eth.c \

SRCS_USER = \
	user/initproc.c \
	user/sh.c \
	user/sysrecycle.c \

OBJS = $(SRCS_ASM:.S=.o)
OBJS += $(SRCS_C:.c=.o)

# 用户进程的依赖文件
ULIB = user/usyscall.o user/printf.o
UPROC= $(SRCS_USER:%.c=%.elf)

# LDFLAGS = -z max-page-size=4096

# .SECONDARY:  # 保留所有中间文件
.PRECIOUS: %.o # 保留中间过程的 .o 文件
%.elf :%.o $(ULIB)
	$(CC) $(CFLAGS) -N -e main -Ttext 0 -o $@ $^
	@$(OBJDUMP) -S $@ > $*.asm
	@$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $*.sym

user:$(UPROC)
	@# @echo $(UPROC)
	@echo "	Make UProc OK! "

.DEFAULT_GOAL := all
all:kernel.elf $(UPROC) fs.img
	@echo "	Make OK! "

run:kernel.elf $(UPROC) fs.img
	@echo "-------------------------------------------------------"
	@echo "Press Ctrl-A and then X to exit QEMU"
	${QEMU} ${QFLAGS} -kernel kernel.elf
	@# @rm -rf *.o *.bin */*.o */*.d
	
kernel.elf: ${OBJS}
	@# ${CC} ${CFLAGS} -Ttext=0x80000000 -o kernel.elf $^
	${CC} ${CFLAGS} -T kernel.ld -o kernel.elf $^
	@${OBJCOPY} -O binary kernel.elf kernel.bin
	@${OBJDUMP} -S kernel.elf > kernel.asm

-include kernel/*.d user/*.d initos/*.d# 包含依赖文件
# $@  表示目标文件
# $^  表示所有的依赖文件
# $<  表示第一个依赖文件
# $?  表示比目标还要新的依赖文件列表
%.o : %.c
	${CC} ${CFLAGS} -c -o $@ $<

%.o : %.S
	${CC} ${CFLAGS} -c -o $@ $<

initcode : user/initcode.S
	$(CC) $(CFLAGS) -N -e main -Ttext 0 -z max-page-size=4096 -c user/initcode.S -o user/initcode.o
	$(OBJCOPY) -S -O binary user/initcode.o user/initcode.bin
	$(OBJDUMP) -S user/initcode.o > user/initcode.asm

losfs/mkfs.elf: losfs/mkfs.c
	gcc $(GCCFLAGS) losfs/mkfs.c -o losfs/mkfs.elf

.PRECIOUS: fs.img	# 生成失败时不删除fs.img
fs.img : losfs/mkfs.elf $(UPROC)
	losfs/mkfs.elf fs.img Makefile $(UPROC)
	@# dd if=[/dev/sda] of=fs.img bs=8M count=1

debug: CFLAGS += -D DEBUG
debug: kernel.elf $(UPROC) fs.img
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
	rm -rf *.o *.bin *.elf */*.o */*.d */*.elf */_* */*.bin *.asm */*.asm */*.sym

ELF = kernel.elf
ELFCODETARGET = $(ELF:.elf=.asm)
ELFBINTARGET = $(ELF:.elf=.bin)
code: $(ELF)
	@ # ${OBJDUMP} -S kernel.elf | less
	@${OBJDUMP} -S $(ELF) > $(ELFCODETARGET) # -M no-aliases,numeric显示原始信息
	
bin: $(ELF)
	@${OBJCOPY} -O binary $(ELF) $(ELFBINTARGET)