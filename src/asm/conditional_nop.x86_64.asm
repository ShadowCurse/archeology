global conditional_nop

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

conditional_nop:
    xor rax, rax
    ; the length of the buffer is given in bytes, divide by 8 to get length in u64s
    shr rsi, 3
.loop:
    mov r10, [rdi + rax * 8]
    inc rax
    test r10, 1
    jnz .skip
    nop
.skip:
    cmp rax, rsi
    jb .loop
    ret
