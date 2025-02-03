_start:
    addi x1, x0, 3
    addi x2, x0, 4
    addi x3, x0, 0

loop:
    add x3, x1, x3
    addi x2, x2, -1
    bne x2, x0, loop

    j .