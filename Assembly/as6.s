.intel_syntax noprefix

.global _start
.section .text

_start:
    mov al, dil   #8 bit meno significativi 
    mov bx, si    #16 bit meno significativi
    