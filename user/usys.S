.global exec
exec:
    li a7,1
    ecall
    ret

.global fork
fork:
    li a7,2
    ecall
    ret

.global open
open:
    li a7,3
    ecall
    ret

.global mknod
mknod:
    li a7,4
    ecall
    ret

.global dup
dup:
    li a7,5
    ecall
    ret

.global write
write:
    li a7,6
    ecall
    ret

.global read
read:
    li a7,7
    ecall
    ret