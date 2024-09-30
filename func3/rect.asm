; rect.asm

section .data
section .bss
section .text

global r_area
r_area:
    push rbp
    mov rbp, rsp
        mov rax, rsi
        imul rax, rdi
    mov rsp, rbp
    pop rbp
    ret
    
global r_circum
r_circum:
    push rbp
    mov rbp, rsp
        mov rax, rdi           ; rax = side1
        add rax, rsi           ; rax = side1 + side2
        add rax, rax           ; rax = 2(side1 + side2)
    mov rsp, rbp
    pop rbp
    ret