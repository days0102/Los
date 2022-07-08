QEMU = qemu-system-riscv32
QFLAGS = -nographic -smp 1 -machine virt -bios none

CROSS_COMPILE = riscv64-unknown-elf-
CFLAGS = -nostdlib -fno-builtin -march=rv32ima -mabi=ilp32 -g -Wall

GDB = gdb-multiarch
CC = ${CROSS_COMPILE}gcc
OBJCOPY = ${CROSS_COMPILE}objcopy
OBJDUMP = ${CROSS_COMPILE}objdump


SRCS_ASM = \
	init/entry.S \

SRCS_C = \
	init/start.c \

OBJS = $(SRCS_ASM:.S=.o)
OBJS += $(SRCS_C:.c=.o)

run:kernel.elf
	@echo "Press Ctrl-A and then X to exit QEMU"
	@${QEMU} ${QFLAGS} -kernel kernel.elf
	
kernel.elf: ${OBJS}
	${CC} ${CFLAGS} -Ttext=0x80000000 -o kernel.elf $^
	${OBJCOPY} -O binary kernel.elf kernel.bin

%.o : %.c
	${CC} ${CFLAGS} -c -o $@ $<

%.o : %.S
	${CC} ${CFLAGS} -c -o $@ $<

debug:kernel.elf
	@echo "Press Ctrl-C and then input 'quit' to exit GDB and QEMU"
	@echo "-------------------------------------------------------"
	@${QEMU} ${QFLAGS} -kernel kernel.elf -s -S &
	@${GDB} kernel.elf -q -x gdbinit

clean:
	rm -rf *.o *.bin *.elf

code: kernel.elf
	@${OBJDUMP} -S kernel.elf | less