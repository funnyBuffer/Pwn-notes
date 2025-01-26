.intel_syntax noprefix

.global _start
.section .text

_start:
    and rdi, 1
    xor rax, rax
    xor rax, 1
    xor rax, rdi
