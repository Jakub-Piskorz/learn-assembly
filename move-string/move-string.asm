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
    other_string resb    length

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
    str_loop1:
    mov byte[rdi], al    ; The simple method
    inc rdi
    inc al
    loop str_loop1
    prnt my_string, length
    
    ; Fill the string with ascii 0's
    prnt str2, 20
    mov rax, 48
    mov rdi, my_string
    mov rcx, length
    str_loop2: stosb           ; No inc rdi needed anymore
    loop str_loop2
    prnt my_string, length
    
    ; Fill the string with ascii 1's
    prnt str3, 19
    mov rax, 49
    mov rdi, my_string
    mov rcx, length
    rep stosb           ; No loop needed anymore
    prnt my_string, length
    
    ; Fill with characters again
    prnt str4, 26
    mov rax, 32
    mov rdi, my_string
    mov rcx, length
    str_loop3: mov byte[rdi], al
    inc rdi
    inc al
    loop str_loop3
    prnt my_string, length
    
    ; Copy my_string to other_string
    prnt str5, 32
    mov rsi, my_string
    mov rdi, other_string
    mov rcx, length
    rep movsb
    prnt other_string, length
    
    ; Reverse copy my_string to other_string
    prnt str6, 40
    mov rax, 48
    mov rdi, other_string
    mov rcx, length
    rep stosb
    lea rsi, [my_string+length-4]
    lea rdi, [other_string+length]
    mov rcx, 27
    std
    rep movsb
    prnt other_string, length
    
    leave
    ret