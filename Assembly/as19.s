.intel_syntax noprefix
.global _start
_start:
    cmp rdi, 3
    jbe condizioni
    mov rdi, 4

condizioni:
    lea rax, [rsi + rdi * 8]
    mov rax, [rax]
    jmp rax

