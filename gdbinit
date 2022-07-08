#set auto-load safe-path /home/lwz
set confirm off
set architecture riscv:rv64
#target remote 127.0.0.1:26000
symbol-file /home/lwz/los/kernel.elf


set disassemble-next-line on
b _start
#target remote : 1234
#c
