global test_mov
global test_nop
global test_cmp
global test_dec

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

test_mov:
    xor rax, rax
.loop:
    mov [rdi + rax], al
    inc rax
    cmp rax, rsi
    jb .loop
    ret

test_nop:
    xor rax, rax
.loop:
    db 0x0f, 0x1f, 0x00
    inc rax
    cmp rax, rsi
    jb .loop
    ret

test_cmp:
    xor rax, rax
.loop:
    inc rax
    cmp rax, rsi
    jb .loop
    ret

test_dec:
.loop:
    dec rsi
    jnz .loop
    ret
