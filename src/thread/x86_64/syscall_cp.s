.text
.extern __ccfi_syscall
.global __cp_begin
.hidden __cp_begin
.global __cp_end
.hidden __cp_end
.global __cp_cancel
.hidden __cp_cancel
.hidden __cancel
.global __syscall_cp_asm
.hidden __syscall_cp_asm
.type   __syscall_cp_asm,@function
__syscall_cp_asm:
	mov (%rdi),%eax
	test %eax,%eax
	jnz __cp_cancel

	# Save arguments onto the stack
	push %rdi
	push %rsi
	push %rdx
	push %rcx
	push %r8
	push %r9

	movl $1004,%edi
	mov %rdi,%gs:0x0
	call __ccfi_syscall

	# Restore saved arguments, for syscall
	pop %r10
	pop %rdx
	pop %rsi
	pop %rdi
	pop %rax
	pop %r11

__cp_begin:
	mov 8(%rsp),%r8
	mov 16(%rsp),%r9
	mov %r11,8(%rsp)
	syscall

__cp_end:
	ret

__cp_cancel:
	jmp __cancel
