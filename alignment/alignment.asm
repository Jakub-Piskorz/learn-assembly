extern printf

section .data
    fmt     db  "2 times pi equals %.14f", 10, 0
    pi      dq  3.1415926585358979
section .bss
section .text

func3:
    push rbp
        movsd xmm0, [pi]
        addsd xmm0, [pi]
        mov rdi, fmt
        mov rax, 1
        call printf
    pop rbp
    ret
    
func2:
    push rbp
    call func3
    pop rbp
    ret
    
func1:
    push rbp
    call func2
    pop rbp
    ret

global main
main:
    mov rbp, rsp; for correct debugging
    push rbp
    call func1
    pop rbp
    ret