; kalkjulejter.asm
extern printf
section .data
    numero_uno  dq  12345678901234567
    numero_dos  dq  100
    neg_numero  dq  -12
    formatto    db  "The numbers are %ld and %ld", 10, 0
    fmt_int     db  "%s %ld", 10, 0
    sum_txt     db  "The sum is", 0
    diff_txt    db  "The difference is", 0
    inc_txt     db  "Numero uno increased by 1:", 0
    dec_txt     db  "Numero uno decreased by 1:", 0
    sal_txt     db  "Numero uno moved left twice (*4):", 0
    sar_txt     db  "Numero uno moved right twice (/4):", 0
    sar_ext_txt db  "Numero uno moved right twice (/4) with "
                db  "an extended character/sign", 0
    mult_txt    db  "The product is", 0
    div_txt     db  "The quotient is", 0
    rem_txt     db  "The remnant is", 0
section .bss
    result      resq    1
    modulo      resq    1
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax
    
; Wyświetlamy liczby
    mov     rdi, formatto
    mov     rsi, [numero_uno]
    mov     rdx, [numero_dos]
    xor     rax, rax
    call    printf
    
; Dodawanie ------------------------------------
    mov     rax, [numero_uno]
    add     rax, [numero_dos]
    mov     [result], rax
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, sum_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    
; Odejmowanie -----------------------------------
    mov     rax, [numero_uno]
    sub     rax, [numero_dos]
    mov     [result], rax
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, diff_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    
; Inkrementacja ----------------------------------
    mov     rax, [numero_uno]
    inc     rax
    mov     [result], rax
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, inc_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    
; Dekrementacja ----------------------------------
    mov     rax, [numero_uno]
    dec     rax
    mov     [result], rax
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, dec_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    
; Arytmetyczne przesunięcie w lewo -----------------------------------
    mov     rax, [numero_uno]
    sal     rax, 2
    mov     [result], rax
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, sal_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    
; Arytmetyczne przesunięcie w prawo ----------------------------------
    mov     rax, [numero_uno]
    sar     rax, 2
    mov     [result], rax
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, sar_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    
; Arytmetyczne przesunięcie w prawo z przesunięciem znakowym ---------
    mov     rax, [neg_numero]
    sar     rax, 2
    mov     [result], rax
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, sar_ext_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    
; Mnożenie -----------------------------------------------------------
    mov     rax, [numero_uno]
    imul    qword [numero_dos]
    mov     [result], rax
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, mult_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    
; Dzielenie ----------------------------------------------------------
    mov     rax, [numero_uno]
    xor     rdx, rdx
    idiv    qword [numero_dos]
    mov     [result], rax
    mov     [modulo], rdx
    ; Wyświetlanie
    mov     rdi, fmt_int
    mov     rsi, div_txt
    mov     rdx, [result]
    xor     rax, rax
    call    printf
    xor     rax, rax
    mov     rdi, fmt_int
    mov     rsi, rem_txt
    mov     rdx, [modulo]
    call    printf


    mov     rsp, rbp
    pop     rbp
    ret
