; fcalc.asm
extern printf
section .data
    num1        dq  9.0
    num2        dq  73.0
    fmt         db  "Numbers are: %f and %f", 10, 0
    fmtfloat    db  "%s %f", 10, 0
    f_sum        db  "Floating sum of %f and %f is %f", 10, 0
    f_dif        db  "Floating difference of %f and %f is %f", 10, 0
    f_mul        db  "Floating product of %f and %f is %f", 10, 0
    f_div        db  "Floating quotient of %f and %f is %f", 10, 0
    f_sqrt       db  "Floating square root of %f is %f", 10, 0


section .bss
section .text
global main
    main:
    push rbp
    mov rbp, rsp
    xor rax, rax
    
    ; let's print numbers
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    mov rdi, fmt
    mov rax, 2; 2 floating numbers
    call printf
    
    ; sum
    movsd xmm2, [num1]
    addsd xmm2, [num2]
    ; print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    mov rdi, f_sum
    mov rax, 3
    call printf
    
    ; difference
    movsd xmm2, [num1]
    subsd xmm2, [num2]
    ; print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    mov rdi, f_dif
    mov rax, 3
    call printf  
    
    ; product
    movsd xmm2, [num1]
    mulsd xmm2, [num2]
    ; print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    mov rdi, f_mul
    mov rax, 3
    call printf   
    
    ; quotient
    movsd xmm2, [num1]
    divsd xmm2, [num2]
    ; print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    mov rdi, f_div
    mov rax, 3
    call printf 
    
    ; square root
    movsd xmm0, [num1]
    sqrtsd xmm1, [num1]
    ; print result
    mov rdi, f_sqrt
    mov rax, 2
    call printf
    
    mov rsp, rbp
    pop rbp
    ret