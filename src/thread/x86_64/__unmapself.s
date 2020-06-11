/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */
.text
.extern __cfi_syscall
.global __unmapself
.type   __unmapself,@function
__unmapself:
	# Save arguments into callee-preserved registers, for __cfi_syscall()
	mov %rdi,%r15
	mov %rsi,%r14

	call __cfi_syscall

	# Restore saved arguments, for munmap()
	mov %r14,%rsi
	mov %r15,%rdi
	movl $11,%eax   /* SYS_munmap */
	syscall         /* munmap(arg2,arg3) */

	call __cfi_syscall

	xor %edi,%edi   /* exit() args: always return success */
	movl $60,%eax   /* SYS_exit */
	syscall         /* exit(0) */
