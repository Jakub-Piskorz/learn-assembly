; bits1.asm
extern printf
extern printb
section .data
    msgn1   db  "Number 1", 10, 0
    msgn2   db  "Number 2", 10, 0
    msg1    db  "XOR", 10, 0
    msg2    db  "OR", 10, 0
    msg3    db  "AND", 10, 0
    msg4    db  "NOT number 1", 10, 0
    msg5    db  "SHL 2 lower byte of number 1", 10, 0
    msg6    db  "SHR 2 lower byte of number 1", 10, 0
    msg7    db  "SAL 2 lower byte of number 1", 10, 0
    msg8    db  "SAR 2 lower byte of number 1", 10, 0
    msg9    db  "ROL 2 lower byte of number 1", 10, 0
    msg10   db  "ROL 2 lower byte of number 2", 10, 0
    msg11   db  "ROR 2 lower byte of number 1", 10, 0
    msg12   db  "ROR 2 lower byte of number 2", 10, 0
    num1    dq  -72
    num2    dq  1064
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    ; print number1
    mov rsi, msgn1
    call printmsg
    mov rdi, [num1]
    call printb
    ; print number2
    mov rsi, msgn2
    call printmsg
    mov rdi, [num2]
    call printb
    
    mov rsp, rbp
    pop rbp
    ret
    
printmsg:
section .data
    .fmtstr db  "%s", 0
section .text
    push rbp
    mov rbp, rsp
    mov rdi, .fmtstr
    mov rax, 0
    call printf
    leave
    ret