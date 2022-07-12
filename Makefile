CPUS = 1

QEMU = qemu-system-riscv32 # 32bit
# QEMU = qemu-system-riscv64	#64bit
QFLAGS = -nographic -smp $(CPUS) -machine virt -bios none

CROSS_COMPILE = riscv64-unknown-elf-
CFLAGS = -nostdlib -fno-builtin -march=rv32ima -mabi=ilp32 -g# 32bit -Wall显示警告
# CFLAGS = -nostdlib -fno-builtin -march=rv64ima -mabi=lp64 -g -Wall -mcmodel=medany # 64bit
CFLAGS += -I.# 包含当前目录

GDB = gdb-multiarch
CC = ${CROSS_COMPILE}gcc
OBJCOPY = ${CROSS_COMPILE}objcopy
OBJDUMP = ${CROSS_COMPILE}objdump


SRCS_ASM = \
	init/entry.S \

SRCS_C = \
	init/start.c \
	kernel/uart.c \
	kernel/swtch.c \
	kernel/main.c \
	kernel/trap.c \
	kernel/printf.c \
	kernel/pmm.c \

OBJS = $(SRCS_ASM:.S=.o)
OBJS += $(SRCS_C:.c=.o)

all:kernel.elf
	@echo "	Make OK! "

run:kernel.elf
	@ # echo "Press Ctrl-A and then X to exit QEMU"
	${QEMU} ${QFLAGS} -kernel kernel.elf
	
kernel.elf: ${OBJS}
	@# ${CC} ${CFLAGS} -Ttext=0x80000000 -o kernel.elf $^
	${CC} ${CFLAGS} -T kernel.ld -o kernel.elf $^
	${OBJCOPY} -O binary kernel.elf kernel.bin

# $@  表示目标文件
# $^  表示所有的依赖文件
# $<  表示第一个依赖文件
# $?  表示比目标还要新的依赖文件列表
%.o : %.c
	${CC} ${CFLAGS} -c -o $@ $<

%.o : %.S
	${CC} ${CFLAGS} -c -o $@ $<

debug:kernel.elf
	@echo "Press Ctrl-C and then input 'quit' to exit GDB and QEMU"
	@echo "-------------------------------------------------------"
	@${QEMU} ${QFLAGS} -kernel kernel.elf -s -S 
	@ # ${GDB} kernel.elf -q -x gdbinit

clean:
	rm -rf *.o *.bin *.elf */*.o */*.d

code: kernel.elf
	@ # ${OBJDUMP} -S kernel.elf | less
	@${OBJDUMP} -S kernel.elf > kernel.asm # -M no-aliases,numeric显示原始信息
	