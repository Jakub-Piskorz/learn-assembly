; bits2.asm
extern printf
section .data
    num1    dq  8
    num2    dq  -8
    result  dq  0
    
    num1_s  db  "Number 1 is %d", 10, 0
    num2_s  db  "Number 2 is %d", 10, 0
    shl_s   db  "SHL 2: OK multiply by 4", 10, 0
    shr_s   db  "SHR 2: OK divide by 4", 10, 0
    shr2_s  db  "SHR 2: WRONG divide by 4", 10, 0
    sal_s   db  "SAL 2: correctly multiply by 4", 10, 0
    sar_s   db  "SAR 2: correctly divide by 4", 10, 0
section .bss
section .text
global main
main:
    push rbp
    mov rbp, rsp
        
    ; SHL Positive number
    mov rdi, shl_s
    call printf
    mov rsi, [num1]
    call printNum
    mov rsi, [num1]
    shl rsi, 2
    call printRes
    
    ; SHL Negative number
    mov rdi, shl_s
    call printf
    mov rsi, [num2]
    call printNum
    mov rsi, [num2]
    shl rsi, 2
    call printRes
    
    ; SAL Positive number
    mov rdi, sal_s
    call printf
    mov rsi, [num1]
    call printNum
    mov rsi, [num1]
    sal rsi, 2
    call printRes
    
    ; SAL Negative number
    mov rdi, sal_s
    call printf
    mov rsi, [num2]
    call printNum
    mov rsi, [num2]
    sal rsi, 2
    call printRes
    
    ; SHR Positive number
    mov rdi, shr_s
    call printf
    mov rsi, [num1]
    call printNum
    mov rsi, [num1]
    shr rsi, 2
    call printRes
    
    ; SHR Negative number
    mov rdi, shr2_s
    call printf
    mov rsi, [num2]
    call printNum
    mov rsi, [num2]
    shr rsi, 2
    call printRes
    
    ; SAR Positive number
    mov rdi, sar_s
    call printf
    mov rsi, [num1]
    call printNum
    mov rsi, [num1]
    sar rsi, 2
    call printRes
    
    ; SAR Negative number
    mov rdi, sar_s
    call printf
    mov rsi, [num2]
    call printNum
    mov rsi, [num2]
    sar rsi, 2
    call printRes
        
    leave
    ret
    
printNum:
    section .data
        .fmtstr db  "The original number is %d", 10, 0
    section .text
    sub rsp, 8
        mov rdi, .fmtstr
        xor rax, rax
        call printf
    add rsp, 8
    ret
    
printRes:
    section .data
        .fmtstr db  "The result is: %lld", 10, 0
    section .text
    sub rsp, 8
        mov rdi, .fmtstr
        xor rax, rax
        call printf
    add rsp, 8
    ret