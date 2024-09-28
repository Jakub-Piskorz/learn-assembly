; area-func.asm
extern printf
section .data
pi      dq  3.1415926
radius  dq  10.0
fmt     db  "The area of the circle is %.2f", 10, 0
section .bss
section .text
global main
    main:
    push rbp
    mov rbp, rsp
    xor rax, rax
    
    call area
    mov rdi, fmt
    mov rax, 1
    call printf
    
    mov rsp, rbp
    pop rbp
    
    area:
    push rbp
    mov rbp, rsp
    
    movsd xmm0, [radius]
    mulsd xmm0, [radius]
    mulsd xmm0, [pi]
    
    leave
    ret