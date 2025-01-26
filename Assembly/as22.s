.intel_syntax noprefix
.global _start

_start:
    
str_lower:
    xor rax, rax
    
    cmp rdi, 0
    je end

    loop:
    xor rbx, rbx
    mov bl, [rdi]
    cmp bl, 0
    je end

    cmp bl, 90
    jg end_if
    
    push rdi
    push rax
    mov dil, bl
    mov r10, 0x403000
    call r10
    mov bl, al
    pop rax
    pop rdi
    mov [rdi], bl
    inc rax

    end_if:
    inc rdi
    jne loop

end:
    ret
