extern		printf					
section .data
        msg     db  "Hey guys!", 0		
        fmtstr  db  "Ill say something: %s", 10, 0
        fmt_len db  "msg takes %d bits", 10, 0	
        str_len equ $ - msg - 1     
section	.bss
section	.text
        global  main
main:
        push    rbp					
        mov     rbp, rsp	
							
        xor     rax, rax					
        mov     rdi, fmtstr
        mov     rsi, msg	   	
        call    printf	
	
        
        mov     rdi, fmt_len
        mov     rsi, str_len
        call    printf	
							
        mov     rsp, rbp				
        pop     rbp					
        ret				
	
	
