.global test_mov
.global test_nop
.global test_cmp
.global test_dec

.text

# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

test_mov:
    mov x4, 0x0
test_mov_loop:
    add x5, x4, x0
    strb w4, [x5]
    add x4, x4, 0x1
    cmp x4, x1
    b.ne test_mov_loop
    ret

test_nop:
    mov x4, 0x0
test_nop_loop:
    nop
    nop
    add x4, x4, 0x1
    cmp x4, x1
    b.ne test_nop_loop
    ret

test_cmp:
    mov x4, 0x0
test_cmp_loop:
    add x4, x4, 0x1
    cmp x4, x1
    b.ne test_cmp_loop
    ret

test_dec:
    mov x4, x1
test_dec_loop:
    add x4, x4, -0x1
    cbnz x4, test_dec_loop
    ret
