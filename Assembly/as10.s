.intel_syntax noprefix

.global _start
.section .text

_start:
    mov rax, [0x404000]
    add qword ptr [0x404000], 0x1337 
    #il compilatore non sa su quanti byte sarà effettuata l'operazione
    #dword indica un operazione su un dato di 4 byte
    #mentre qword indica un operazione su un dato di 8 byte
    