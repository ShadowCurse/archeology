.global read_strided_32x2

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

read_strided_32x2:
.align 6
    # outer loop couter
    ldr x10, [x2]
outer_loop:
    # inner loop couter
    ldr x9, [x2, 0x8]
    # stride
    ldr x8, [x2, 0x10]
    mov x7, x0
inner_loop:
    mov x6, x7
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    add x7, x6, x8
    sub x9, x9, 0x1
    cbnz x9, inner_loop

    sub x10, x10, 0x1
    cbnz x10, outer_loop
    ret
