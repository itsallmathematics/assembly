format ELF64 executable 3

segment readable executable

entry $
	
    prompt_user:
    mov rax, 1h ; sys_write
    mov rdi, 1h
    lea rsi, [prompt]
    mov rdx, prompt_size
    syscall
    
    get_input:
    mov rax, 0 ; sys_read
    mov rdi, 0 ; STDIN
    lea rsi, [name]
    mov rdx, 16
    syscall

    encode_bytes:
    lea rsi, [name]
    .encode_loop:
    cmp byte [rsi], 0
    je write_hello
    xor byte [rsi], 5h
    inc rsi
    jmp .encode_loop


    write_hello:
    mov rax, 1h ; sys_write
    mov rdi, 1h
    lea rsi, [msg]
    mov rdx, msg_size
    syscall

    write_name:
    mov rax, 1h ; sys_write
    mov rdi, 1h
    lea rsi, [name]
    mov rdx, 16
    syscall

    print_newline:
    push 0Ah ; <---- char ascii code for newline
    mov rax, 1h ; sys_write
    mov rdi, 1h
    mov rsi, rsp
    mov rdx, 1h
    syscall

	exit_program:
	xor	edi,edi 	; exit code 0
	mov	eax,60		; sys_exit
	syscall



segment readable writeable

prompt db 'What is your name? '
whack db 'what the hell'
msg db 'Hello '
msg_size = 6
prompt_size = 19
name rb 16
counter dd 0