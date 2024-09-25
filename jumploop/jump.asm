; jumploop.asm
extern printf

section .data
    fmt   db  "Suma od 0 do %ld, to %ld", 10, 0
section .bss
section .text
global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rax, 0
    mov     rcx, 5
bloop:
    add     rax, rcx
    loop    bloop
    cmp     rcx, 5
    
    mov     rdi, fmt
    mov     rsi, 5
    mov     rdx, rax
    mov     rax, 0
    call    printf
    mov     rsp, rbp
    pop     rbp
    ret