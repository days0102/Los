.global main
main:
    li a7,1
    la a0,path
    ecall
label:
    j label

path:
    .string "initproc"