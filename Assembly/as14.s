.intel_syntax noprefix

.global _start
.section .text

_start:
    mov rax, qword ptr [rsp]    
    sub rax, rdi               
    mov qword ptr [rsp], rax
