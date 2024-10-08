; triangle.asm
section .data
    n       dq  10
    msg     db  "xxxxxxxxxx", 10, 0
    char    db  " "
section .text
global main
main:
push rbp
mov rbp, rsp

    mov rdx, [n]        ; rdx: Length of string
    inc rdx             ;      (+1, because of new line)
    mov rcx, rdx        ; rcx: Counter for printLoop 
    mov r9, -1          ; r9: Pointer to replace character in a string
    mov r10b, [char]    ; r10: Character for string replacement
    
    printLoop:
        ; Set registers for printing
        mov rax, 1     
        mov rdi, 1
        mov rsi, msg
        
        ; Skip the first character replacement
        cmp r9, -1    
        je print
        
        ; Replace the character at string address + r9 pointer
        mov [rsi+r9], r10b
        
        print:
            push rcx    ; syscall sets rcx at unexpected high value for some reason
            syscall
            pop rcx
            inc r9
            loop printLoop
leave
ret