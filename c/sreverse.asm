; sreverse.asm

section .text
global sreverse
sreverse:
push  rbp
mov   rbp, rsp
pushing:
      mov rcx, rsi ; String length
      mov rbx, rdi ; String address
      mov r12, 0   ; Length counter
      pushLoop:
            mov rax, qword [rbx+r12]	; Load characters
            push rax
            inc r12
            loop pushLoop
popping:
      mov rcx, rsi
      mov rbx, rdi
      mov r12, 0
      popLoop:
            pop rax
            mov byte [rbx+r12], al  	; Save characters in reverse order
            inc r12
            loop popLoop
mov rax, rdi
leave
ret
