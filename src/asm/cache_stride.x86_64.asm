global read_strided_32x2

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

read_strided_32x2:
    align 64

    mov r10, [rdx]      ; outer loop counter
.outer_loop:
    mov r9,  [rdx + 8]  ; inner loop counter
    mov r8,  [rdx + 16] ; stride
    mov rax, rdi

.inner_loop:
    vmovdqu ymm0, [rax]
    vmovdqu ymm0, [rax + 0x20]
    add rax, r8
    dec r9
    jnz .inner_loop

    dec r10
    jnz .outer_loop
    ret
