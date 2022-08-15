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