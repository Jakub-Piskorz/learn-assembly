; siema.asm
section	.data
	msg	db	"Siema!", 10, 0		;
	msglen	equ	$-msg-1			;
	msg2	db 	"Gramy w HoTS-a?", 10, 0;
	msg2len	equ	$-msg2-1		;
	PI	dq	3.14			;
	papiesz	dq	2137			;
	
section	.bss
section	.text
	global main
main:
	push	rbp		;
	mov	rbp, rsp	;
	mov	rax, 1		;
	mov 	rdi, 1		;
	mov	rsi, msg	;
	mov	rdx, msglen	;
	syscall			;

	mov 	rax, 1		;
	mov	rdi, 1		;
	mov	rsi, msg2	;
	mov	rdx, msg2len	;					
	syscall			;
	
	mov	rsp, rbp	;
	pop	rbp		;
	mov	rax, 60		;
	mov	rdi, 0		;
	syscall			;
