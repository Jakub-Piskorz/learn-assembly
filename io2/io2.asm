; io2.asm
section .data
    msg1    db  "Hello world!", 10, 0
    msg2    db  "Your turn (only a-z): ", 0
    msg3    db  "You ansered: ", 0
    inputlen    equ 10
    NL  db  0xa
section .bss
    input   resb    inputlen+1
section .text
    global main
main:
push rbp
mov rbp, rsp
    mov rdi, msg1
    call prints
    mov rdi, msg2
    call prints
    mov rdi, input
    mov rsi, inputlen
    call reads
    mov rdi, msg3
    call prints
    mov rdi, input
    call prints
    mov rdi, NL
    call prints
leave
ret

prints:
push rbp
mov rbp, rsp
    push r12    ; Callee saved
    ; Count characters
    xor rdx, rdx    ; Length here
    mov r12, rdi    ; Char address here
    .stringIterate:
        cmp byte [r12], 0
        je .lengthfound
        inc rdx
        inc r12
        jmp .stringIterate
    .lengthfound:       ; Print the string, length in rdx
        cmp rdx, 0      ; In case of empty string
        je .done
        mov rsi, rdi    ; rdi: address of string
        mov rax, 1      ; write
        mov rdi, 1      ; stdout
        syscall
    .done:
        pop r12
leave
ret

reads:
section .data
section .bss
    .inputchar  resb    1
section .text
push rbp
mov rbp, rsp
    push r12
    push r13
    push r14
    mov r12, rdi    ; Address of inputbuffer
    mov r13, rsi    ; Max length
    xor r14, r14    ; Character counter
    .readc:
        mov rax, 0      ; read
        mov rdi, 1      ; stdin
        lea rsi, [.inputchar]
        mov rdx, 1      ; # of characters to read
        syscall
        mov al, [.inputchar]    ; Char is NL?
        cmp al, byte[NL]
        je  .done               ; NL end
        cmp al, 97              ; Lower than a?
        jl  .readc              ; Ignore
        cmp al, 122             ; Higher than z?
        jg  .readc              ; Ignore
        inc r14
        cmp r14, r13
        ja  .readc              ; Buffer max reached, ignore
        mov byte [r12], al      ; Save the chat in the buffer
        inc r12                 ; Next char address
        jmp .readc
    .done:
        inc r12 ; Manually adding 0 to end the string.
        mov byte [r12], 0
        pop r14
        pop r13
        pop r12
leave
ret