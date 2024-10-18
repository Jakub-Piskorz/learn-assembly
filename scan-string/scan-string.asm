; strings.asm
extern printf
section .data
      string1       db "This is the 1st string.",10,0
      string2       db "This is the 2nd string.",10,0
      strlen2       equ $-string2-2
      same_str      db "Comparing strings: The strings do not differ.",10,0
      different_str db "Comparing strings: The strings differ, "
                    db "starting at position: %d.",10,0
      string3       db "The quick brown fox jumps over the lazy dog.",0
      strlen3       equ $-string3-2
      string33      db "Now look at this string: %s",10,0
      string4       db "z",0
      string44      db "The character '%s' was found at position: %d.",10,0
      string45      db "The character '%s' was not found.",10,0
      string46      db "Scanning for the character '%s'.",10,0
section .bss
section .text
      global main
main:
      push   rbp
      mov    rbp,rsp
; Print the 2 strings
      xor    rax,rax
      mov    rdi, string1
      call   printf
      mov    rdi, string2
      call   printf
; Compare 2 strings -----------------------------------------------
      lea    rdi, [string1]
      lea    rsi, [string2]
      mov    rdx, strlen2
      call   compare1
      cmp    rax, 0
      jnz    not_equal1
; Strings are equal, print
      mov    rdi, same_str
      call   printf
      jmp    otherversion
; Strings are not equal, print
not_equal1:
      mov    rdi, different_str
      mov    rsi, rax
      xor    rax, rax
      call   printf
; Compare 2 strings, other verstion ------------------------------
otherversion:
      lea    rdi, [string1]
      lea    rsi, [string2]
      mov    rdx, strlen2
      call   compare2
      cmp    rax, 0
      jnz    not_equal2
; Strings are equal, print
      mov    rdi, same_str
      call   printf
      jmp    scanning
; Strings are not equal, print
not_equal2:
      mov    rdi, different_str
      mov    rsi, rax
      xor    rax, rax
      call   printf
; Scan for a character in a string -------------------------------
; First print the string
      mov    rdi, string33
      mov    rsi, string3
      xor    rax, rax
      call   printf
; Then print the search argument, can only be 1 character
      mov    rdi, string46
      mov    rsi, string4
      xor    rax, rax
      call   printf
scanning:
      lea    rdi, [string3]     ;      string
      lea    rsi, [string4]     ;      search argument
      mov    rdx, strlen3
      call   cscan
      cmp    rax, 0
      jz     char_not_found
; Character found, print
      mov    rdi, string44
      mov    rsi, string4
      mov    rdx, rax
      xor    rax, rax
      call   printf
      jmp    exit
; Character not found, print
char_not_found:
      mov    rdi, string45
      mov    rsi, string4
      xor    rax, rax
      call   printf
exit:
leave
ret
; FUNCTIONS ===============================================================
; Function compare 2 strings. rdi: str1, rsi: str2, rdx: length
compare1:    mov    rcx, rdx
             cld
cmpr:        cmpsb
             jne    notequal
             loop   cmpr
             xor    rax, rax
             ret
notequal:    mov    rax, strlen2
             dec    rcx            ; Compute position
             sub    rax, rcx       ; Compute position
             ret
             xor    rax, rax
             ret
;----------------------------------------------------------------
; Function compare 2 strings ------------------------------------
compare2:    mov    rcx, rdx
             cld
             repe   cmpsb
             je     equal2
             mov    rax, strlen2
             sub    rax, rcx       ; Compute position
             ret
equal2:      xor    rax, rax
             ret
;----------------------------------------------------------------
; Function scan a string for a character
cscan:       mov    rcx, rdx
             lodsb
             cld
             repne  scasb
             jne    char_notfound
             mov    rax, strlen3
             sub    rax, rcx       ; Compute position
             ret
char_notfound:      xor rax, rax
             ret