; file.asm
section .data
; Expressions used for conditional assembly
    CREATE      equ 1
    OVERWRITE   equ 1
    APPEND      equ 1
    O_WRITE     equ 1
    READ        equ 1
    O_READ      equ 1
    DELETE      equ 1
    
; Syscall symbols
    NR_read     equ 0
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
    
section .bss
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
    
    %ENDIF
    
    %IF O_WRITE
    ; OPEN AND OVERWRITE AT AN OFFSET IN A FILE, THEN CLOSE ----
    ; Open file to write
    mov rdi, fileName
    call openFile
    mov qword [FD], rax
    
    ; Position file at offset
    mov rdi, qword [FD]
    mov rsi, qword [len2] ; offset at this location
    mov rdx, 0
    call positionFile
    
    ; write to file
    mov rdi, qword [FD]
    mov rsi, txt4
    mov rdx, qword [len4]
    call writeFile
    
    ; close file
    mov rdi, qword [FD]
    call closeFile
    
    %ENDIF
    %IF READ
    ; OPEN AND READ FROM A FILE, THEN CLOSE ------------
    ; Open file to read
    mov rdi, fileName
    call openFile
    mov qword [FD], rax
    
    ; Read from file
    mov rdi, qword [FD]
    mov rsi, buffer
    mov rdx, bufferlen
    call readFile
    mov rdi, rax
    call printString
    
    ; Close file
    mov rdi, qword [FD]
    call closeFile
    
    %ENDIF
    %IF O_READ
    ; OPEN AND READ AT AN OFFSET FROM A FILE, THEN CLOSE ----
    ; open file to read
    mov rdi, fileName
    call openFile
    mov qword [FD], rax
    
    ; position file at offeset
    mov rdi, qword [FD]
    mov rsi, qword [len2] ; Skip the first line
    mov rdx, 0
    call positionFile
    
    ; Read from file
    mov rdi, qword [FD]
    mov rsi, buffer
    mov rdx, 10 ; Number of characters to read
    call readFile
    mov rdi, rax
    call printString
    
    ; Close file
    mov rdi, qword [FD]
    call closeFile
    
    %ENDIF
    
    %IF DELETE
    ; DELETE A FILE ----------------------------------------
    ; Delete file UNCOMMENT NEXT LINES TO USE
        mov rdi, fileName
        call deleteFile
    %ENDIF
    
    leave
    ret
    
    ; FILE MANIPULATION FUNCTIONS --------------------------
    
    ; ------------------------------------------------------
    global readFile
    ; Arguments:
    ; rdi: file descriptor
    ; rsi: buffer
    ; rdx: number of characters to read
    readFile:
        mov rax, NR_read
        syscall ; rax contains # of characters read
        cmp rax, 0
        jl readError
        mov byte [rsi+rax], 0 ; Add a terminating zero
        mov rax, rsi
        
        mov rdi, successRead
        push rax ; Save rax
        call printString
        pop rax  ; Return previous rax
        ret
    readError:
        mov rdi, errorRead
        call printString
        ret
    ; Return arguments:
    ; rdi: text from file
    
    ; ------------------------------------------------------
    global deleteFile
    ; Arguments:
    ; rdi, file descriptor
    deleteFile:
        mov rax, NR_unlink
        syscall
        cmp rax, 0
        jl deleteError
        mov rdi, successDelete
        call printString
        ret
    deleteError:
        mov rdi, errorDelete
        call printString
        ret
    ; Return arguments
    ; rdi: success or error msg
        
    ; ------------------------------------------------------
    global appendFile
    ; Arguments:
    ; rdi: name of file
    appendFile:
        mov rax, NR_open
        mov rsi, O_RDWR|O_APPEND
        syscall
        cmp rax, 0
        jl appendError
        mov rdi, successAppend
        push rax
        call printString
        pop rax
        ret
    appendError:
        mov rdi, errorAppend
        call printString
        ret
        
    ; ------------------------------------------------------
    global openFile
    ; Arguments:
    ; rdi: name of file
    openFile:
        mov rax, NR_open
        mov rsi, O_RDWR
        syscall
        cmp rax, 0
        jl openError
        mov rdi, successOpen
        push rax
        call printString
        pop rax
        ret
    openError:
        mov rdi, errorOpen
        call printString
        ret
    ; Return arguments:
    ; rax: file descriptor
        
    ; -------------------------------------------------------
    global writeFile
    ; Arguments:
    ; rdi: file descriptor
    ; rsi: text to write
    ; rdx: length of string to write
    writeFile:
        mov rax, NR_write
        syscall
        cmp rax, 0
        jl writeError
        mov rdi, successWrite
        call printString
        ret
    writeError:
        mov rdi, errorWrite
        call printString
        ret
        
    ; -------------------------------------------------------
    global positionFile
    ; Arguments:
    ; rdi: file descriptor
    ; rsi: offet length
    ; rdx: ???    
    positionFile:
        mov rax, NR_lseek
        syscall
        cmp rax, 0
        jl positionError
        mov rdi, successPosition
        call printString
        ret
    positionError:
        mov rdi, errorPosition
        call printString
        ret
        
    ; -------------------------------------------------------
    global closeFile
    ; Arguments:
    ; rdi: file descriptor
    closeFile: 
        mov rax, NR_close
        syscall
        cmp rax, 0
        jl closeError
        mov rdi, successClose
        call printString
        ret
    closeError:
        mov rdi, errorClose
        call printString
        ret
        
    ; -------------------------------------------------------
    global createFile
    ; Arguments:
    ; rdi: file name
    createFile: 
        mov rax, NR_create
        mov rsi, S_IRUSR | S_IWUSR
        syscall
        cmp rax, 0
        jl createError
        mov rdi, successCreate
        push rax
        call printString
        pop rax
        ret
    createError:
        mov rdi, errorCreate
        call printString
        ret
        
    ; PRINT -------------------------------------------------
    global printString
    printString:
    ; count characters
        mov r12, rdi
        mov rdx, 0
    strLoop:
        cmp byte [r12], 0
        je strDone
        inc rdx
        inc r12
        jmp strLoop
    strDone:
        cmp rdx, 0
        je prtDone
        mov rsi, rdi
        mov rdi, 1
        syscall
    prtDone:
        ret