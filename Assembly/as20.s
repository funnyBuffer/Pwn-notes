.intel_syntax noprefix
.global _start

_start:
    xor rbx, rbx
    xor rax, rax

ciclo:
    add rax, qword ptr [rdi + 8 * rbx]
    add rbx, 1
    cmp rbx, rsi
    jbe ciclo

    div rsi
    