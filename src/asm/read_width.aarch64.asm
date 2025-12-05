.global read_4x2
.global read_8x2
.global read_16x2
.global read_32x2

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

read_4x2:
    mov x4, 0x0
    mov x2, x0
    add x2, x2, 0x4
.align 6
read_4x2_loop:
    ldr w5, [x0]
    ldr w5, [x2]
    add x4, x4, 0x8
    cmp x4, x1
    b.ne read_4x2_loop
    ret

read_8x2:
    mov x4, 0x0
    mov x2, x0
    add x2, x2, 0x8
.align 6
read_8x2_loop:
    ldr x5, [x0]
    ldr x5, [x2]
    add x4, x4, 0x10
    cmp x4, x1
    b.ne read_8x2_loop
    ret

read_16x2:
    mov x4, 0x0
    mov x2, x0
    add x2, x2, 0x10
.align 6
read_16x2_loop:
    ld1 {v0.16b}, [x0]
    ld1 {v0.16b}, [x2]
    add x4, x4, 0x20
    cmp x4, x1
    b.ne read_16x2_loop
    ret

read_32x2:
    mov x4, 0x0
    mov x2, x0
    add x2, x2, 0x20
.align 6
read_32x2_loop:
    ld1 {v0.16b, v1.16b}, [x0]
    ld1 {v0.16b, v1.16b}, [x2]
    add x4, x4, 0x40
    cmp x4, x1
    b.ne read_32x2_loop
    ret
