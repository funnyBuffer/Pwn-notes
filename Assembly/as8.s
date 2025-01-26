.intel_syntax noprefix

.global _start
.section .text

_start:
    and rdi, rsi
    xor rax, rax
    or rax, rdi
    