; bits3.asm
extern printf
extern printb
section .data
    msgNoBits   db  "No bits are set: ", 10, 0
    msgBit4     db  "Set bit #4, that is 5th bit: ", 10, 0
    msgBit7     db  "Set bit #7, that is 8th bit: ", 10, 0
    msgBit8     db  "Set bit #8, that is 9th bit: ", 10, 0
    msgBit61    db  "Set bit #61, that is 62nd bit: ", 10, 0
    msgClr8     db  "Clear bit #8, that is 9th bit: ", 10, 0
    msgTest61   db  "Test bit #61, and display rdi: ", 10, 0
    binary      dq  0
section .text
global main
main:
    push rbp
    mov rbp, rsp
    
    ; Print title
    mov rdi, msgNoBits
    xor rax, rax
    call printf
    
    ; Print bitflags
    mov rdi, [binary]
    call printb
    
    
    ; Set bit 4
    bts qword [binary], 4
    
    ; Print title
    mov rdi, msgBit4
    xor rax, rax
    call printf
    
    ; Print bitflags
    mov rdi, [binary]
    call printb
    
    ; Set bit 8
    bts qword [binary], 8
    
    ; Print title
    mov rdi, msgBit8
    xor rax, rax
    call printf
    
    ; Print bitflags
    mov rdi, [binary]
    call printb
    
    
    ; Set bit 61
    bts qword [binary], 61
    
    ; Print title
    mov rdi, msgBit61
    xor rax, rax
    call printf
    
    ; Print bitflags
    mov rdi, [binary]
    call printb
    
    
    ; Clear bit 8
    btr qword [binary], 8
    
    ; Print title
    mov rdi, msgClr8
    xor rax, rax
    call printf
    
    ; Print bitflags
    mov rdi, [binary]
    call printb
    
    
    ; Test bit 61 (will set carry flag CF if 1)
    
    ; Print title
    mov rdi, msgTest61
    xor rax, rax
    call printf
    
    ; Print binary
    mov rdi, [binary]
    call printb
    
    ; Do the operations
    mov rax, 61         ; Bit 61 to be tested
    xor rdi, rdi        ; Set result to 0 (for now)
    bt [binary], rax    ; Bit test 61
    setc dil            ; Set dil (=low rdi) to 1 if CF is set
    
    ; Print bitflags
    call printb
    
    leave
    ret