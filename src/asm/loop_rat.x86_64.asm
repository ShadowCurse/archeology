global loop_rat_add
global loop_rat_mov_add

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

loop_rat_add:
align 64
.loop:
    add rcx, 1
    add rcx, 1
    dec rsi
    jnz .loop
    ret

loop_rat_mov_add:
align 64
.loop:
    mov rcx, rsi
    add rcx, 1
    mov rcx, rsi
    add rcx, 1
    dec rsi
    jnz .loop
    ret
