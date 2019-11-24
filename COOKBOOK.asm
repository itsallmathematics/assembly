; syscall numbers: /usr/src/linux/include/asm-x86_64/unistd.h
; parameters order:
; r9    ; 6th param
; r8    ; 5th param
; r10   ; 4th param
; rdx   ; 3rd param
; rsi   ; 2nd param
; rdi   ; 1st param
; eax   ; syscall_number
; syscall

Print a char:

	push 21h ; <---- char ascii code
    mov rax, 1h
    mov rdi, 1h
    mov rsi, rsp
    mov rdx, 1h
    syscall


Print a string:

	mov	edx,msg_size	; CPU zero extends 32-bit operation to 64-bit
				; we can use less bytes than in case mov rdx,...
	lea	rsi,[msg] ;<------ String
	mov	edi,1		; STDOUT
	mov	eax,1		; sys_write
	syscall

Exit:

	exit_program:
	xor	edi,edi 	; exit code 0
	mov	eax,60		; sys_exit
	syscall