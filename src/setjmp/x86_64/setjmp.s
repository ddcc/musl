/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */
.global __setjmp
.global _setjmp
.global setjmp
.extern __cfi_pointer_define
.type __setjmp,@function
.type _setjmp,@function
.type setjmp,@function
__setjmp:
_setjmp:
setjmp:
	mov %rbx,(%rdi)         /* rdi is jmp_buf, move registers onto it */
	mov %rbp,8(%rdi)
	mov %r12,16(%rdi)
	mov %r13,24(%rdi)
	mov %r14,32(%rdi)
	mov %r15,40(%rdi)
	lea 8(%rsp),%rdx        /* this is our rsp WITHOUT current ret addr */
	mov %rdx,48(%rdi)
	mov (%rsp),%rsi         /* save return addr ptr for new rip */
	mov %rsi,56(%rdi)

	lea 56(%rdi),%rdi
	call __cfi_pointer_define

	xor %rax,%rax           /* always return 0 */
	ret
