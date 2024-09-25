; siema.asm


section	.data
	msg1	db	"siema!", 0
	msg2	db 	"Gramy w HoTS-a?", 0
	pi	dq	3.14
	papiesz	dq	2137
	fmtstr	db	"%s", 10, 0
	fmtflt  db	"%lf", 10, 0
	fmtint	db	"%d", 10, 0
	
section	.bss
section	.text
extern	printf
	global main
main:
	push	rbp		;
	mov	rbp, rsp	;

	mov	rax, 0
	mov	rdi, fmtstr
	mov	rsi, msg1
	call printf
	
	mov	rax, 0
	mov	rdi, fmtstr
	mov	rsi, msg2
	call printf	

	mov	rax, 0
	mov	rdi, fmtint
	mov	rsi, [papiesz]
	call printf

	mov	rax, 1
	mov	rdi, fmtflt
	movq	xmm0, [pi]
	call printf
		
	mov	rsp, rbp	
	pop	rbp
	ret
