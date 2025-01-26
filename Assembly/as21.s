.intel_syntax noprefix
.global _start

_start:
    xor rax, rax
    cmp rdi, 0
    je done

    ciclo:
    xor rcx, rcx
    mov cl, [rdi]
    cmp cl , 0
    je done
    add rax, 1
    add rdi, 1
    jmp ciclo

    done: 
    nop
