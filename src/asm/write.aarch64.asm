.global write_1
.global write_2
.global write_3
.global write_4

.text
# on Linux arguments are passed as
# 1: x0
# 2: x1
# 3: x2
# 4: x3

write_1:
.align 6
write_1_loop:
    str x2, [x0]
    sub x1, x1, 0x1
    cmp x1, 0x0
    b.gt write_1_loop
    ret

write_2:
.align 6
write_2_loop:
    str x2, [x0]
    str x2, [x0]
    sub x1, x1, 0x2
    cmp x1, 0x0
    b.gt write_2_loop
    ret

write_3:
.align 6
write_3_loop:
    str x2, [x0]
    str x2, [x0]
    str x2, [x0]
    sub x1, x1, 0x3
    cmp x1, 0x0
    b.gt write_3_loop
    ret

write_4:
.align 6
write_4_loop:
    str x2, [x0]
    str x2, [x0]
    str x2, [x0]
    str x2, [x0]
    sub x1, x1, 0x4
    cmp x1, 0x0
    b.gt write_4_loop
    ret
