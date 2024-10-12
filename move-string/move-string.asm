; move-string.asm
%macro prnt 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, NL
    mov rdx, 1
    syscall
%endmacro

section .data
    length      equ 95
    NL          db  0xa
    str1        db  "my_string of ASCII:"
    str2        db  10, "my_string of zeros:"
    str3        db  10, "my_string of ones:"
    str4        db  10, "again my_string of ASCII:"
    str5        db  10, "copy my_string to other_string:"
    str6        db  10, "reverse copy my_string to other_string:"
section .bss
    my_string   resb    length
    oter_string resb    length

section .text
global main
main:
    push rbp
    mov rbp, rsp
    
    ; Fill the string with printable ascii characters
    prnt str1, 18
    mov rax, 32
    mov rdi, my_string
    mov rcx, length
    str_loop1: mov byte[rdi], al    ; The simple method
    inc rdi
    inc al
    loop str_loop1
    prnt my_string, length
    
    leave
    ret