#set auto-load safe-path /home/lwz
#set confirm off
#set architecture riscv:rv64
#target remote 127.0.0.1:26000
#symbol-file /home/lwz/os_c/xv6-labs-2021/kernel/kernel
#set disassemble-next-line auto


set disassemble-next-line on
b _start
target remote : 1234
c
