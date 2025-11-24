global loop_nop_3x1
global loop_nop_1x3
global loop_nop_1x4
global loop_nop_1x5
global loop_nop_1x9

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

loop_nop_3x1:
    xor rax, rax
.loop:
    db 0x0f, 0x1f, 0x00
    inc rax
    cmp rax, rsi
    jb .loop
    ret

loop_nop_1x3:
    xor rax, rax
.loop:
    nop
    nop
    nop
    inc rax
    cmp rax, rsi
    jb .loop
    ret

loop_nop_1x4:
    xor rax, rax
.loop:
    nop
    nop
    nop
    nop
    inc rax
    cmp rax, rsi
    jb .loop
    ret

loop_nop_1x5:
    xor rax, rax
.loop:
    nop
    nop
    nop
    nop
    nop
    inc rax
    cmp rax, rsi
    jb .loop
    ret

loop_nop_1x9:
    xor rax, rax
.loop:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc rax
    cmp rax, rsi
    jb .loop
    ret
