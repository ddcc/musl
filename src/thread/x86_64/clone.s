.text
.extern __ccfi_update_pid
.extern __ccfi_syscall
.global __clone
.hidden __clone
.type   __clone,@function
__clone:
	# Save arguments onto the stack, for __ccfi_syscall()
	push %rdi
	push %rsi
	push %rdx
	push %rcx
	push %r8
	push %r9

	movl $1000,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	# Restore saved arguments, for clone()
	pop %r8
	pop %rdx
	pop %rcx
	pop %rdi
	pop %rsi
	pop %r9

	xor %eax,%eax
	mov $56,%al
	mov 56(%rsp),%r10
	and $-16,%rsi
	sub $8,%rsi
	mov %rcx,(%rsi)
	syscall

	test %eax,%eax
	jnz end
	xor %ebp,%ebp
	pop %rdi

	mov %r9,%rbx
	# Update PID after system call
	call __ccfi_update_pid

	call *%rbx
	# Save return value into callee-preserved register, for __ccfi_syscall()
	mov %eax,%ebx

	movl $1001,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	# Restore saved arguments, for exit()
	mov %ebx,%edi

	xor %eax,%eax
	mov $60,%al
	syscall
	hlt

end:
	ret
