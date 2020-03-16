/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */
.text
.extern __ccfi_syscall
.global __set_thread_area
.hidden __set_thread_area
.type __set_thread_area,@function
__set_thread_area:
	mov %rdi,%rbx

	movl $1,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	mov %rbx,%rsi           /* shift for syscall */
	movl $0x1002,%edi       /* SET_FS register */
	movl $158,%eax          /* set fs segment to */
	syscall                 /* arch_prctl(SET_FS, arg)*/
	ret
