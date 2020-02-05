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
	mov %rdi,%rbx
	mov %rsi,%r12
	mov %rdx,%r13
	mov %rcx,%r14
	mov %r8,%r15
	push %r9

	movl $5,%edi
	mov %rdi,%gs:0x0
	movl $6,%esi
	mov %rsi,%gs:0x8
	movl $7,%edx
	mov %rdx,%gs:0x10
	call __ccfi_syscall

__cp_begin:
	mov (%rbx),%eax
	test %eax,%eax
	jnz __cp_cancel
	mov %rbx,%r11
	mov %r12,%rax
	mov %r13,%rdi
	mov %r14,%rsi
	mov %r15,%rdx
	pop %r10
	mov 8(%rsp),%r8
	mov 16(%rsp),%r9
	mov %r11,8(%rsp)
	syscall
__cp_end:
	ret
__cp_cancel:
	jmp __cancel
