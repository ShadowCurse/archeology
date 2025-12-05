.global conditional_nop

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

.align 6
conditional_nop:
    mov x4, 0x0
    # the length of the buffer is given in bytes, divide by 8 to get length in u64s
    lsr x1, x1, 0x3
loop:
    ldr x5, [x0], 0x8
    add x4, x4, 0x1
    cbnz x5, skip
    nop
skip:
    cmp x4, x1
    b.ne loop
    ret
