format ELF64 executable 3

segment readable executable

entry $
	
	mov rax, 1h ; sys_write
    mov rdi, 1h
    lea rsi, [prompt]
    mov rdx, prompt_size
    syscall

    mov rax, 0 ; sys_read
    mov rdi, 0 ; STDIN
    lea rsi, [name]
    mov rdx, 16
    syscall

    lea rax, [msg]
    call get_size

    mov rax, 1h ; sys_write
    mov rdi, 1h
    lea rsi, [msg]
    mov rdx, [msg_size]
    syscall

    mov rax, 1h ; sys_write
    mov rdi, 1h
    lea rsi, [name]
    mov rdx, 16
    syscall

	exit_program:
	xor	edi,edi 	; exit code 0
	mov	eax,60		; sys_exit
	syscall


    get_size:
    mov rcx, qword [counter]
    cmp byte [rax+rcx], 0
    je .left
    inc [counter]
    jmp get_size

    
    .left:
    lea rcx, [counter]
    mov edx, [rcx]
    lea rcx, [msg_size]
    mov dword [rcx], edx ; bug erases name 0x401193 first few bytes....
    ret



segment readable writeable

prompt db 'What is your name? ', 0
whack db 'what the hell'
msg db 'Hello ', 0x0
msg_size dq 0
prompt_size = 19
name rb 16
counter dd 0