global standard_write
global streaming_write

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

standard_write:
    align 64

    mov r10, [rdx]       ; outer loop counter
.outer_loop:
    mov r9,  [rdx + 8]   ; inner loop counter
    mov r8,  [rdx + 16]  ; source pointer
    mov rax, rdi         ; destination pointer

.inner_loop:
    vmovdqa ymm0, [r8]
    vmovdqa [rax], ymm0
    vmovdqa ymm0, [r8 + 0x20]
    vmovdqa [rax + 0x20], ymm0
    vmovdqa ymm0, [r8 + 0x40]
    vmovdqa [rax + 0x40], ymm0
    vmovdqa ymm0, [r8 + 0x60]
    vmovdqa [rax + 0x60], ymm0
    vmovdqa ymm0, [r8 + 0x80]
    vmovdqa [rax + 0x80], ymm0
    vmovdqa ymm0, [r8 + 0xa0]
    vmovdqa [rax + 0xa0], ymm0
    vmovdqa ymm0, [r8 + 0xc0]
    vmovdqa [rax + 0xc0], ymm0
    vmovdqa ymm0, [r8 + 0xe0]
    vmovdqa [rax + 0xe0], ymm0
    add r8, 0x100
    add rax, 0x100
    dec r9
    jnz .inner_loop

    dec r10
    jnz .outer_loop
    ret


streaming_write:
    align 64

    mov r10, [rdx]       ; outer loop counter
.outer_loop:
    mov r9,  [rdx + 8]   ; inner loop counter
    mov r8,  [rdx + 16]  ; source pointer
    mov rax, rdi         ; destination pointer

.inner_loop:
    vmovdqa ymm0, [r8]
    vmovntdq [rax], ymm0
    vmovdqa ymm0, [r8 + 0x20]
    vmovntdq [rax + 0x20], ymm0
    vmovdqa ymm0, [r8 + 0x40]
    vmovntdq [rax + 0x40], ymm0
    vmovdqa ymm0, [r8 + 0x60]
    vmovntdq [rax + 0x60], ymm0
    vmovdqa ymm0, [r8 + 0x80]
    vmovntdq [rax + 0x80], ymm0
    vmovdqa ymm0, [r8 + 0xa0]
    vmovntdq [rax + 0xa0], ymm0
    vmovdqa ymm0, [r8 + 0xc0]
    vmovntdq [rax + 0xc0], ymm0
    vmovdqa ymm0, [r8 + 0xe0]
    vmovntdq [rax + 0xe0], ymm0
    add r8, 0x100
    add rax, 0x100
    dec r9
    jnz .inner_loop

    dec r10
    jnz .outer_loop
    ret
