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

    mov rdx, [n]
    inc rdx
    mov rcx, [n]
    inc rcx
    mov r9, -1

    printLoop:
        mov r11b, [char]
        mov rax, 1
        mov rdi, 1
        mov rsi, msg
        
        cmp r9, -1     ; Skip the first
        je print
        mov [rsi+r9], r11b
        
        print:
            push rcx    ; syscall sets rcx at unexpected high value for some reason
            syscall
            pop rcx
            inc r9
            loop printLoop
    done:

leave
ret