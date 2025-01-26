.intel_syntax noprefix

.global _start
.section .text

_start:
    imul rdi, rsi
    add rdi, rdx
    mov rax, rdi
    