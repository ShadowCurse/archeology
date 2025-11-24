global loop_read_1
global loop_read_2
global loop_read_3
global loop_read_4

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

loop_read_1:
    align 64
.loop:
    mov rax, [rdi]
    sub rsi, 1
    jnle .loop
    ret

loop_read_2:
    align 64
.loop:
    mov rax, [rdi]
    mov rax, [rdi]
    sub rsi, 2
    jnle .loop
    ret

loop_read_3:
    align 64
.loop:
    mov rax, [rdi]
    mov rax, [rdi]
    mov rax, [rdi]
    sub rsi, 3
    jnle .loop
    ret

loop_read_4:
	align 64
.loop:
    mov rax, [rdi]
    mov rax, [rdi]
    mov rax, [rdi]
    mov rax, [rdi]
    sub rsi, 4
    jnle .loop
    ret
