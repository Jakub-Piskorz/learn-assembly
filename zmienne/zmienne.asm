; zmienne.asm
section .data
    bLiczba     db      123
    wLiczba     dw      12345
    wTablica times 5 dw 0
    dLiczba     dd      12345
    qLiczba1    dq      12345
    qLiczba2    dq      3.141592654
    tekst1      db      "abc", 0
    tekst2      db      "cde", 0
section .bss
    bZmienna    resb    1
    dZmienna    resd    1
    wZmienna    resw    10
    qZmienna    resq    30000
    qqZmienna   resq    20000
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax
    
    lea     rax, bLiczba
    mov     rax, bLiczba
    mov     rax, [bLiczba]
    xor     rax, rax
    mov     al, [bLiczba]
    
    mov     [bZmienna], al
    mov     rax, [bZmienna]
    xor     rax, rax
    mov     dword [dZmienna], 1
    mov     al, [bZmienna]
    mov     rax, [bZmienna]
    mov     dword [dZmienna], 0
    mov     rax, [bZmienna]
    
    lea     rax, wLiczba
    mov     rax, [wLiczba]
    
    lea     rax, tekst1
    mov     rax, tekst1
    mov     rax, tekst1+1
    lea     rax, tekst1+1
    mov     rax, [tekst1]
    mov     rax, tekst1+1
    
    mov     rsp,rbp
    pop     rbp
    ret