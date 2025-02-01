# Pwn-notes
Note su pwn exercise 
# PwnCollege Security Challenges

Benvenuto nella repository dedicata agli esercizi di sicurezza informatica tratti dal sito [PwnCollege](https://pwncollege.laser.di.unimi.it/dojos). Questo progetto raccoglie soluzioni, script e documentazione relativi alle diverse sfide proposte sulla piattaforma, con l'obiettivo di migliorare le competenze nel campo della cybersecurity, in particolare nell'ambito della sicurezza applicativa e dello sfruttamento delle vulnerabilità.

## Struttura della Repository

La repository è organizzata in base alle categorie degli esercizi e alle sfide specifiche affrontate:

```
.
├── SUID
│   ├── challenge1
│   └── challenge2
├── memory_error
│   ├── challenge1
│   └── challenge2
├── shellcode_injection
│   ├── challenge1
│   └── challenge2
└── assembly
    ├── challenge1
    └── challenge2
```

- **SUID/**: Contiene esercizi relativi allo sfruttamento di binari con permessi SUID.
- **memory_error/**: Racchiude sfide relative agli errori di gestione della memoria.
- **shellcode_injection/**: Include esercizi sulla creazione e l'inserimento di shellcode.
- **assembly/**: Sfide che richiedono conoscenze di linguaggio assembly.

## Prerequisiti

Prima di iniziare con gli esercizi, è necessario configurare l'ambiente di lavoro:

**Strumenti**: Installa i seguenti strumenti essenziali:
   - `gdb`, `pwndbg`
   - `python3` con librerie `pwntools`
   - `binwalk`, `radare2`, `ghidra`

**Assembly**
I codice di shellcode e assembly sono scritti in assembly intel x86
Quindi la prima riga di ogni programma sarà:
```
.intel_syntax noprefix
```
Per la compilazione dei programmi invece basterà eseguire:
```
gcc -nostdlib -static -o programma programma.s
objcopy --dump-section .text=programma.txt programma
```
Così facendo si avrà lo shellcode dentro `programma.txt`

## Promemoria
Questa repository non è pensata per il semplice copia-incolla delle soluzioni. L'obiettivo principale è comprendere il funzionamento delle sfide e imparare dagli esercizi, soprattutto per quei casi in cui non si riesce a trovare una soluzione immediata.

---

**Happy Hacking!**

