extern printf

section .data
  str1      db  "Cheeki breeki i vdamke!"
  str1len   equ $-str1-2
  str2      db  "Cheeki br33ki i vdamke!"
  samestr   db  "Strings are same", 10, 0
  diffstr   db  "Strings are different at index %d", 10, 0
section .text
global main
main:
    push rbp
    mov rbp, rsp
    
    lea rsi, [str1]
    lea rdi, [str2]
    mov rdx, str1len
    call compare
    cmp rax, 0
    je sameret
    lea rdi, [diffstr]
    lea rsi, [rax]
    call printf
    
    lea rsi, [str1]
    lea rdi, [str2]
    mov rdx, str1len
    call compare2
    cmp rax, 0
    je sameret
    lea rdi, [diffstr]
    lea rsi, [rax]
    call printf
    
    jmp done
    
    sameret:
    lea rdi, samestr
    call printf
    
    ; Compare function | rdi, rsi: str
    ; rcx: str length
    ; rax: index of string diff (0 if same)
    compare:
        mov rcx, rdx
        cld
        repe cmpsb
        je equal
        mov rax, rdx
        sub rax, rcx
        ret
    equal:
        xor rax, rax
        ret
        
    ; Compare, but negative first
    compare2:
        mov rcx, rdx
        cld
        repe cmpsb
        jne notequal
        xor rax, rax
        ret
    notequal:
        mov rax, rdx
        sub rax, rcx
        ret
        
    done:
    leave
    ret