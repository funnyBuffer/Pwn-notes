.intel_syntax noprefix

.global _start
.section .text

_start:
mov rax, 60
mov rdi, 0x1337
syscall


           
