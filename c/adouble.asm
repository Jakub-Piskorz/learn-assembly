; adouble.asm
section .text
global adouble
adouble:
      section .text
; Double the elements
            mov   rcx, rsi     ; Array length
            mov   rbx, rdi     ; Address of array
            mov   r12, 0
      aloop:
            movsd xmm0, qword [rbx+r12*8]      ; take a number
            addsd xmm0,xmm0                    ; double it
            movsd qword [rbx+r12*8], xmm0      ; move it to array
            inc r12
            loop aloop
ret
