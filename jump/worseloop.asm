; jumploop.asm
extern printf

section .data
    number dq  5
    fmt   db  "Suma od 0 do %ld, to %ld", 10, 0
section .bss
section .text
global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rax, 0
    mov     rbx, 0
jloop:
    add     rax, rbx
    inc     rbx
    cmp     rbx, 5
    jle     jloop
    
    mov     rdi, fmt
    mov     rsi, 5
    mov     rdx, rax
    mov     rax, 0
    call    printf
    mov     rsp, rbp
    pop     rbp
    ret