global loop_align_64
global loop_align_1
global loop_align_15
global loop_align_31
global loop_align_63

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

loop_align_64:
    xor rax, rax
align 64
.loop:
    inc rax
    cmp rax, rsi
    jb .loop
    ret

loop_align_1:
    xor rax, rax
align 64
nop
.loop:
    inc rax
    cmp rax, rsi
    jb .loop
    ret

loop_align_15:
    xor rax, rax
align 64
%rep 15
nop
%endrep
.loop:
    inc rax
    cmp rax, rsi
    jb .loop
    ret

loop_align_31:
    xor rax, rax
align 64
%rep 31
nop
%endrep
.loop:
    inc rax
    cmp rax, rsi
    jb .loop
    ret

loop_align_63:
    xor rax, rax
align 64
%rep 63
nop
%endrep
.loop:
    inc rax
    cmp rax, rsi
    jb .loop
    ret
