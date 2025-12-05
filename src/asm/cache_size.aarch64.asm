.global read_32x8

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

read_32x8:
.align 6
    # outer loop couter
    ldr x8, [x2]      
    # inner loop couter
    ldr x9, [x2, 0x8]
outer_loop:
    mov x10, x9
    mov x7, x0
inner_loop:
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    ld1 {v0.16b, v1.16b}, [x7], 0x20
    sub x10, x10, 0x1
    cbnz x10, inner_loop

    sub x8, x8, 0x1
    cbnz x8, outer_loop
    ret
