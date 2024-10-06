; cmdline.asm
extern printf
section .data
    msg     db  "The command and arguments: ", 10, 0
    fmt     db  "%s", 10, 0
section .bss
section .text
    global main
main:
push rbp
mov rbp, rsp
    mov r12, rdi    ; number of arguments
    mov r13, rsi    ; address of arguments array
    ; Print the title
    mov rdi, msg
    call printf
    mov r14, 0
    ; Print the command and arguments
    .ploop:         ; loop through the array and print
        mov rdi, fmt
        mov rsi, qword [r13+r14*8]
        call printf
        inc r14
        cmp r14, r12    ; number of arguments reached?
        jl .ploop
leave
ret