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

format ELF64 executable 3

segment readable executable

entry $
	
	push 21h
    mov rax, 1h
    mov rdi, 1h
    mov rsi, rsp
    mov rdx, 1h
    syscall

	exit_program:
	xor	edi,edi 	; exit code 0
	mov	eax,60		; sys_exit
	syscall

segment readable writeable

msg db 'Hello 64-bit world!',0xA
msg_size = $-msg
num db 0x6
