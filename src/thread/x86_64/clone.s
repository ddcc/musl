.text
.extern __hq_update_pid
.extern __hq_syscall
.global __clone
.hidden __clone
.type   __clone,@function
__clone:
	# Save arguments onto the stack, for __hq_syscall()
	push %rdi
	push %rsi
	push %rdx
	push %rcx
	push %r8
	push %r9

	call __hq_syscall

	# Restore saved arguments, for clone()
	pop %r8
	pop %rdx
	pop %rcx
	pop %rdi
	pop %rsi
	pop %rbx

	xor %eax,%eax
	mov $56,%al
	mov 8(%rsp),%r10
	and $-16,%rsi
	sub $8,%rsi
	mov %rcx,(%rsi)
	syscall

	test %eax,%eax
	jnz end
	xor %ebp,%ebp
	pop %rdi

	# Update PID after system call
	call __hq_update_pid

	call *%rbx
	mov %eax,%edi
	xor %eax,%eax
	mov $60,%al
	syscall
	hlt

end:
	ret
