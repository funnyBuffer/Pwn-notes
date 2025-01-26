.intel_syntax noprefix
.section .text
.global _start
_start:

    mov eax, dword ptr [rdi + 4]
    mov ebx, dword ptr [rdi + 8]
    mov ecx, dword ptr [rdi + 12]
    mov edx, dword ptr [rdi]

    cmp edx, 0x7f454c46
    je add

    cmp edx, 0x00005A4D
    je sub

mul:
    imul eax, ebx 
    imul eax, ecx 
    jmp fine

add:
    add eax, ebx 
    add eax, ecx 
    jmp fine
sub:
    sub eax, ebx 
    sub eax, ecx 
    jmp fine
fine:


