CPUS = 1

QEMU = qemu-system-riscv32 # 32bit
# QEMU = qemu-system-riscv64	#64bit
QFLAGS = -nographic -smp $(CPUS) -machine virt -bios none

CROSS_COMPILE = riscv64-unknown-elf-
CFLAGS = -nostdlib -fno-builtin -march=rv32ima -mabi=ilp32 -g -MD# 32bit 
# CFLAGS = -nostdlib -fno-builtin -march=rv64ima -mabi=lp64 -g -Wall -mcmodel=medany # 64bit
CFLAGS += -I.# 包含当前目录
CFLAGS += -Wall -Wno-main# 显示警告

GDB = gdb-multiarch
CC = ${CROSS_COMPILE}gcc
LD = ${CROSS_COMPILE}ld
OBJCOPY = ${CROSS_COMPILE}objcopy
OBJDUMP = ${CROSS_COMPILE}objdump


SRCS_ASM = \
	initos/entry.S \
	kernel/kvec.S \
	kernel/swtch.S \
	kernel/usertrap.S \

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

SRCS_USER = \
	user/zeroproc.S \

OBJS = $(SRCS_ASM:.S=.o)
OBJS += $(SRCS_C:.c=.o)

all:kernel.elf
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

debug:kernel.elf
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
	rm -rf *.o *.bin *.elf */*.o */*.d

code: kernel.elf
	@ # ${OBJDUMP} -S kernel.elf | less
	@${OBJDUMP} -S kernel.elf > kernel.asm # -M no-aliases,numeric显示原始信息
	