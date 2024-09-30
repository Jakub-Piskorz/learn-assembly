; func3.asm
extern printf
extern c_area
extern c_circum
extern r_area
extern r_circum
section .data
    global pi
    pi      dq  3.141592654
    radius  dq  10.0
    side1   dq  4
    side2   dq  5
    fmtf    db  "%s %f", 10, 0
    fmti    db  "%s %d", 10, 0
    ca      db  "Circle area is ", 0
    cc      db  "Circle circumference is ", 0
    ra      db  "Area of the rectangle is ", 0
    rc      db  "Circumference of the rectangle is ", 0
section .text
global main
main:
    push rbp
    mov rbp, rsp
    
    ; CIRCLE
    
    ; Area
    movsd xmm0, qword [radius]
    call c_area
    
    mov rdi, fmtf
    mov rsi, ca
    mov rax, 1
    call printf
    
    ; Circumference
    movsd xmm0, qword [radius]
    call c_circum
    
    mov rdi, fmtf
    mov rsi, cc
    mov rax, 1
    call printf
    
    ; RECTANGLE
    
    ; Area
    mov rdi, [side1]
    mov rsi, [side2]
    call r_area
    
    mov rdi, fmti
    mov rsi, ra
    mov rdx, rax
    xor rax, rax
    call printf
   
    ; Circumference
    mov rdi, [side1]
    mov rsi, [side2]
    call r_circum
    
    mov rdi, fmti
    mov rsi, rc
    mov rdx, rax
    xor rax, rax
    call printf
    
    mov rsp, rbp
    pop rbp
    ret