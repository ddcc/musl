/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */
.text
.extern __ccfi_syscall
.global __unmapself
.type   __unmapself,@function
__unmapself:
	mov %rdi,%rbx
	mov %rsi,%r12

	movl $1,%edi
	mov %rdi,%gs:0x0
	movl $2,%esi
	mov %rsi,%gs:0x8
	movl $3,%edx
	mov %rdx,%gs:0x10
	call __ccfi_syscall

	mov %rbx,%rdi
	mov %r12,%rsi
	movl $11,%eax   /* SYS_munmap */
	syscall         /* munmap(arg2,arg3) */

	movl $2,%edi
	mov %rdi,%gs:0x0
	movl $3,%esi
	mov %rsi,%gs:0x8
	movl $4,%edx
	mov %rdx,%gs:0x10
	call __ccfi_syscall

	xor %edi,%edi   /* exit() args: always return success */
	movl $60,%eax   /* SYS_exit */
	syscall         /* exit(0) */
