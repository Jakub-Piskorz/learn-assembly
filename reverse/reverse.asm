extern printf
section .data
    txt db "abcde", 10, 0
    txt_len equ $ - txt - 2
section .bss
section .text
global main
main:
    push rbp
    mov rbp, rsp
    xor rax, rax
    mov rdi, txt
    call printf
    
    mov rcx, txt_len
    mov r12, 0
pushloop:
    mov al, [txt+r12]
    inc r12
    push rax
    loop pushloop
    mov rcx, txt_len
    mov r12, 0
poploop:
    pop rax
    mov [txt+r12], al
    inc r12
    loop poploop
    
    xor rax, rax
    mov rdi, txt
    call printf
    
    mov rsp, rbp
    pop rbp
    ret