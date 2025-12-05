.global align_64
.global align_1
.global align_15
.global align_31
.global align_63

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

align_64:
    mov x4, 0x0
.align 6
align_64_loop:
    add x4, x4, 0x1
    cmp x4, x1
    b.ne align_64_loop
    ret

align_1:
    mov x4, 0x0
.align 6
.rep 1
nop
.endr
align_1_loop:
    add x4, x4, 0x1
    cmp x4, x1
    b.ne align_1_loop
    ret

align_15:
    mov x4, 0x0
.align 6
.rep 15
nop
.endr
align_15_loop:
    add x4, x4, 0x1
    cmp x4, x1
    b.ne align_15_loop
    ret

align_31:
    mov x4, 0x0
.align 6
.rep 31
nop
.endr
align_31_loop:
    add x4, x4, 0x1
    cmp x4, x1
    b.ne align_31_loop
    ret

align_63:
    mov x4, 0x0
.align 6
.rep 63
nop
.endr
align_63_loop:
    add x4, x4, 0x1
    cmp x4, x1
    b.ne align_63_loop
    ret
