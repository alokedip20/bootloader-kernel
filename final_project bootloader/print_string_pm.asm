[bits 32]
video_space equ 0xb8000			;IN VGA PROTECTED MODE THE VIDEO MEMORY IS STARTING FROM 0XB8000
blue equ 0x01				;BLUE IS DEFINED BY 0X01
print_string_pm:
	mov edx,video_space		;MOVE VIDEO MEMORY SPACE TO edx
	.repeat:
		mov al,[ebx]		;ebx POINTS TO THE 1ST CHARECTER IN THE MESSEGE AND MOVE THAT INTO al(LOWER 8BITS OF ax REGISTER)
		mov ah,blue		;PUT BLUE COLOR CODE INTO THE HIGHER 8BITS OF ax REGISTER
		cmp al,0		
		je .done
		mov [edx],ax		;PUT THAT ASCII CHARECTER WITH THE COLOR BYTE IN TO THE VIDEO SPACE
		inc ebx			;INCREMENT ebx 
		add edx,2		;ADD 2 TO edx AS EACH CHARECTER IS OF SIZE 2 BYTES
		jmp .repeat
	.done:
		ret
