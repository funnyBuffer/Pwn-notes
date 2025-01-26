.intel_syntax noprefix

.global _start
.section .text

_start:
    jmp here
    .rept 0x51
        nop
    .endr
here:
    pop rdi    
    mov rax, 0x403000                 
    jmp rax
