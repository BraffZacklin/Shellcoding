	global _start

section .text
	_start: 
	; make null byte in ax register
	xor rax, rax

	; push null byte end to register
	push rax

	; push /bin/sh => 2f 62 69 6e 2f 62 61 73 68
	;mov rbx, 0x68732f2f6e69622f
	;push rbx

	; below is /bin/bash => 2f 62 69 6e 2f 62 61 73 68
	push 0x6e69622f
	mov dword [rsp+4], 0x7361622f
	mov byte [rsp+8], 0x68

	; mov ptr to /bin/bash on stack into ebx register
	mov rdi, rsp

	; push null onto stack and mov new esp to ecx to be the second arg for execve
	push rax
	mov rsi, rsp

	; mov third null arg to edx
	mov rdx, rax 

	; set syscall to 59
	mov al, 59
	syscall

	; exit 0
	;xor edi, edi
	;mov eax, 231
	;syscall