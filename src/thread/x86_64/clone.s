.text
.extern __ccfi_syscall
.global __clone
.hidden __clone
.type   __clone,@function
__clone:
	mov %rdi,%rbx
	mov %rsi,%r12
	mov %rdx,%r13
	push %rcx
	mov %r8,%r14
	mov %r9,%r15

	movl $3,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	mov %rbx,%r9
	mov %r12,%rsi
	mov %r13,%rdi
	pop %rcx
	mov %r14,%rdx
	mov %r15,%r8

	xor %eax,%eax
	mov $56,%al
	mov 8(%rsp),%r10
	and $-16,%rsi
	sub $8,%rsi
	mov %rcx,(%rsi)
	syscall

	test %eax,%eax
	jnz 1f
	xor %ebp,%ebp
	pop %rdi
	call *%r9

	mov %eax,%ebx

	movl $4,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	mov %ebx,%edi
	xor %eax,%eax
	mov $60,%al
	syscall
	hlt
1:	ret
