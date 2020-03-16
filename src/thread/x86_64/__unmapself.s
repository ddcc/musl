/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */
.text
.extern __ccfi_syscall
.global __unmapself
.type   __unmapself,@function
__unmapself:
	mov %rdi,%rbx
	mov %rsi,%r12

	movl $5,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	mov %rbx,%rdi
	mov %r12,%rsi
	movl $11,%eax   /* SYS_munmap */
	syscall         /* munmap(arg2,arg3) */

	movl $6,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	xor %edi,%edi   /* exit() args: always return success */
	movl $60,%eax   /* SYS_exit */
	syscall         /* exit(0) */
