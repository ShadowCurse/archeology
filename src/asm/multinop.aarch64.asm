.global nop_3x1
.global nop_1x3
.global nop_1x4
.global nop_1x5
.global nop_1x9

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

.align 6
nop_3x1:
    mov x4, 0x0
nop_3x1_loop:
    nop
    add x4, x4, 0x1
    cmp x4, x1
    b.ne nop_3x1_loop
    ret

.align 6
nop_1x3:
    mov x4, 0x0
nop_1x3_loop:
    nop
    nop
    nop
    add x4, x4, 0x1
    cmp x4, x1
    b.ne nop_1x3_loop
    ret

.align 6
nop_1x4:
    mov x4, 0x0
nop_1x4_loop:
    nop
    nop
    nop
    nop
    add x4, x4, 0x1
    cmp x4, x1
    b.ne nop_1x4_loop
    ret

.align 6
nop_1x5:
    mov x4, 0x0
nop_1x5_loop:
    nop
    nop
    nop
    nop
    nop
    add x4, x4, 0x1
    cmp x4, x1
    b.ne nop_1x5_loop
    ret

.align 6
nop_1x9:
    mov x4, 0x0
nop_1x9_loop:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add x4, x4, 0x1
    cmp x4, x1
    b.ne nop_1x9_loop
    ret
