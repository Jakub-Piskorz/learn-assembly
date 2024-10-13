section .data
    page_size   equ 4096       ; Page size for mprotect (Linux typically uses 4096 bytes)
    prot_read_write equ 0x7    ; PROT_READ | PROT_WRITE | PROT_EXEC

section .text
global main
extern mprotect   ; Declare mprotect system call

main:
    ; Save RBP and set up stack frame
    push rbp
    mov rbp, rsp
    
    ; Get the address of the current code section and page-align it
    lea rdi, [main]            ; Address of the code section
    and rdi, -page_size        ; Align address to page boundary
    mov rsi, page_size         ; Length to protect (1 page)
    mov rdx, prot_read_write   ; Set permissions to RWX (read, write, execute)
    call mprotect              ; Make the memory writable
    
    ; Modify the instruction (change NOP to JMP)
    mov byte [main + 5], 0xeb  ; Change second nop to 'jmp'
    mov byte [main + 6], 0x05  ; Specify the jump offset (5 bytes forward)
    
    ; Restore stack and return
    xor rax, rax
    leave
    ret