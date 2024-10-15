; scan-string.asm
extern printf

section .data
    str1    db  "This is first string.", 10, 0
    str2    db  "This is second string.", 10, 0
    strlen2 equ $-str2-2
    str21   db  "Comparing strings: strings do not differ", 10, 0
    str22   db  "Comparing strings: strings do differ",
            db  "String from position: %d.", 10, 0
    str3    db  "Pchnąć w tę łódź jeża lub ośm skrzyń fig.", 0
    strlen3 equ $-str3-2
    str33   db  "Now look at this string: %s", 10, 0
    str4    db  "z", 0
    str44   db  "Found character '%s' at position: %d.", 10, 0
    str45   db  "Didn't find character '%s'.", 10, 0
    str46   db  "Scanning for character '%s'.", 10, 0

section .text
global main
main:
    push rbp
    mov rbp, rsp
    
    ; Let's print 2 strins
    lea rdi, [str1]
    lea rsi, [str2]
    mov rdx, strlen2
    call compare1
    cmp rax, 0
    jnz not_equal1
    
    mov rsp, rbp
    pop rbp
    ret