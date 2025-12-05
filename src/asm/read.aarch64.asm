.global read_1
.global read_2
.global read_3
.global read_4

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

read_1:
.align 6
read_1_loop:
    ldr x2, [x0]
    sub x1, x1, 0x1
    cmp x1, 0x0
    b.gt read_1_loop
    ret

read_2:
.align 6
read_2_loop:
    ldr x2, [x0]
    ldr x2, [x0]
    sub x1, x1, 0x2
    cmp x1, 0x0
    b.gt read_2_loop
    ret

read_3:
.align 6
read_3_loop:
    ldr x2, [x0]
    ldr x2, [x0]
    ldr x2, [x0]
    sub x1, x1, 0x3
    cmp x1, 0x0
    b.gt read_3_loop
    ret

read_4:
.align 6
read_4_loop:
    ldr x2, [x0]
    ldr x2, [x0]
    ldr x2, [x0]
    ldr x2, [x0]
    sub x1, x1, 0x4
    cmp x1, 0x0
    b.gt read_4_loop
    ret
