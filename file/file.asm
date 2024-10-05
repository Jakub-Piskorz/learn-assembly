; file.asm
section .data
; Expressions used for conditional assembly
    CREATE      equ 1
    OVERWRITE   equ 1
    APPENT      equ 1
    O_WRITE     equ 1
    READ        equ 1
    O_READ      equ 1
    DELETE      equ 1
    
; Syscall symbols
    NR_READ     equ 0
    NR_write    equ 1
    NR_open     equ 2
    NR_close    equ 3
    NR_lseek    equ 8
    NR_create   equ 85
    NR_unlink   equ 87
    
; Creation and status flags
    O_CREAT     equ 00000100q
    O_APPEND    equ 00002000q
    
; Access mode
    O_RDONLY    equ 000000q
    O_WRONLY    equ 000001q
    O_RDWR      equ 000002q
    
; Create mode (permissions)
    S_IRUSR     equ 00400q  ; User read permission
    S_IWUSR     equ 00200q  ; User write permission
    
    NL          equ 0xa
    bufferlen   equ 64
    
    fileName    db  "testfile.txt", 0
    FD          dq  0   ; file descriptor
    
    txt1    db  "1. Hello... to everyone!", NL, 0
    len1    dq  $-txt1-1
    txt2    db  "2. Here I am!", NL, 0
    len2    dq  $-txt2-1
    txt3    db  "3. Alive and kicking!", NL, 0
    len3    dq  $-txt3-1
    txt4    db  "Adios!", NL, 0
    len4    dq  $-txt4-1
    
    errorCreate     db  "Error creating file", NL, 0
    errorClose      db  "Error closing file", NL, 0
    errorWrite      db  "Error writing to file", NL, 0
    errorOpen       db  "Error opening file", NL, 0
    errorAppend     db  "Error appending to file", NL, 0
    errorDelete     db  "Error deleting the file", NL, 0
    errorRead       db  "Error reading file", NL, 0
    errorPrint      db  "Error printing string", NL, 0
    errorPosition   db  "Error positioning in file", NL, 0
    
    successCreate   db  "File created and opened", NL, 0
    successClose    db  "File closed", NL, NL, 0
    successWrite    db  "Written to file", NL, 0
    successOpen     db  "File opened for R/W", NL, 0
    successAppend   db  "File opened for appending", NL, 0
    successDelete   db  "File deleted", NL, 0
    successRead     db  "Reading file", NL, 0
    successPosition db  "Positioned in file", NL, 0
    
section.bss
    buffer  resb    bufferlen
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    
    %IF CREATE
    ; CREATE AND OPEN A FILE, THEN CLOSE -----
    ; Create and open file
    mov rdi, fileName
    call createFile
    mov qword [FD], rax ; Save descriptor
    
    ; write to file #1
    mov rdi, qword [FD]
    mov rsi, txt1
    mov rdx, qword [len1]
    call writeFile
    
    ; close file
    mov rdi, qword [FD]
    call closeFile
    
    %ENDIF
    
    %IF OVERWRITE
    ; OPEN AND OVERWRITE A FILE, THEN CLOSE --
    ; Open file
    mov rdi, fileName
    call openFile
    mov qword [FD], rax
    
    ; Overwrite the file
    mov rdi, qword [FD]
    mov rsi, txt2
    mov rdx, qword [len2]
    call writeFile
    
    ; Close file
    mov rdi, qword [FD]
    call closeFile
    
    %ENDIF
    
    %IF APPEND
    ; Open and append to a file, then close --
    ; Open file to append
    mov rdi, fileName
    call appendFile
    mov qword [FD], rax
    
    ; Write to file APPEND!
    mov rdi, qword [FD]
    mov rsi, txt3
    mov rdx, qword [len3]
    call writeFile
    
    ; Close file
    mov rdi, qword [FD]
    call closeFile
    
    mov rsp, rbp
    pop rbp
    ret