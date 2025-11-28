global read_32x8

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

read_32x8:
    align 64
    mov r8, [rdx]     ; outer loop couter
    mov r9, [rdx + 8] ; inner loop couter
.outer_loop:
    mov r10, r9
    mov rax, rdi

.inner_loop:
    vmovdqu ymm0, [rax]
    vmovdqu ymm0, [rax + 0x20]
    vmovdqu ymm0, [rax + 0x40]
    vmovdqu ymm0, [rax + 0x60]
    vmovdqu ymm0, [rax + 0x80]
    vmovdqu ymm0, [rax + 0xa0]
    vmovdqu ymm0, [rax + 0xc0]
    vmovdqu ymm0, [rax + 0xe0]
    add rax, 0x100
    dec r10
    jnz .inner_loop

    dec r8
    jnz .outer_loop
    ret
