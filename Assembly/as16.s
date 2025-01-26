.intel_syntax noprefix

.global _start
.section .text

_start:
    xor rax, rax
    add rax, qword ptr [rsp + 24]
    add rax, qword ptr [rsp + 16]
    add rax, qword ptr [rsp + 8]
    add rax, qword ptr [rsp]
    mov rbx, 4
    div rbx
    mov qword ptr [rsp - 8], rax

