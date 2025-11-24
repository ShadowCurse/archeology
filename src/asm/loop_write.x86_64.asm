global loop_write_1
global loop_write_2
global loop_write_3
global loop_write_4

section .text
; on Linux arguments are passed as
; 1: rdi
; 2: rsi
; 3: rdx
; 4: rcx

loop_write_1:
    align 64
.loop:
    mov [rdi], rax
    sub rsi, 1
    jnle .loop
    ret

loop_write_2:
    align 64
.loop:
    mov [rdi], rax
    mov [rdi], rax
    sub rsi, 2
    jnle .loop
    ret

loop_write_3:
    align 64
.loop:
    mov [rdi], rax
    mov [rdi], rax
    mov [rdi], rax
    sub rsi, 3
    jnle .loop
    ret

loop_write_4:
	align 64
.loop:
    mov [rdi], rax
    mov [rdi], rax
    mov [rdi], rax
    mov [rdi], rax
    sub rsi, 4
    jnle .loop
    ret
