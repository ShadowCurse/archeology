global loop_read_4x2
global loop_read_8x2
global loop_read_16x2
global loop_read_32x2

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

loop_read_4x2:
    xor rax, rax
    align 64
.loop:
    mov r8d, [rdi ]
    mov r8d, [rdi + 4]
    add rax, 8
    cmp rax, rsi
    jb .loop
    ret

loop_read_8x2:
    xor rax, rax
    align 64
.loop:
    mov r8, [rdi ]
    mov r8, [rdi + 8]
    add rax, 16
    cmp rax, rsi
    jb .loop
    ret

loop_read_16x2:
    xor rax, rax
    align 64
.loop:
    vmovdqu xmm0, [rdi]
    vmovdqu xmm0, [rdi + 16]
    add rax, 32
    cmp rax, rsi
    jb .loop
    ret

loop_read_32x2:
    xor rax, rax
    align 64
.loop:
    vmovdqu ymm0, [rdi]
    vmovdqu ymm0, [rdi + 32]
    add rax, 64
    cmp rax, rsi
    jb .loop
    ret
