/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */
.text
.extern __ccfi_syscall
.global __unmapself
.type   __unmapself,@function
__unmapself:
	# Save arguments into callee-preserved registers, for __ccfi_syscall()
	mov %rdi,%rbx
	mov %rsi,%r12

	movl $1002,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	# Restore saved arguments, for munmap()
	mov %rbx,%rdi
	mov %r12,%rsi
	movl $11,%eax   /* SYS_munmap */
	syscall         /* munmap(arg2,arg3) */

	movl $1003,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	xor %edi,%edi   /* exit() args: always return success */
	movl $60,%eax   /* SYS_exit */
	syscall         /* exit(0) */
