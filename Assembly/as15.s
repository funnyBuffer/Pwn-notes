.intel_syntax noprefix

.global _start
.section .text

_start:
    push rdi
    push rsi
    pop rdi
    pop rsi
    