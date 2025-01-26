.intel_syntax noprefix

.global _start
.section .text

_start:
    mov rax, [rdi]
    mov rbx, [rdi + 8]
    add rax, rbx
    mov [rsi], rax
