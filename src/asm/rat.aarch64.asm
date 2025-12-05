.global rat_add
.global rat_mov_add

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

rat_add:
.align 6
rat_add_loop:
    add x0, x0, 0x1
    add x0, x0, 0x1
    sub x1, x1, 0x1
    cbnz x1, rat_add_loop
    ret

rat_mov_add:
.align 6
rat_mov_add_loop:
    mov x0, x1
    add x0, x0, 0x1
    mov x0, x1
    add x0, x0, 0x1
    sub x1, x1, 0x1
    cbnz x1, rat_mov_add_loop
    ret
