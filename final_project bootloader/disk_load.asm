disk_load:
	push dx					;PUSH DX REGISTER INTO STACK
	mov ah,0x02				;INT 13/02h FOR READING SECTORS FROM BOOT DRIVE dl AS FUNCTION PARAMETER
	mov al,dh				;STORE HOW MANY SECTORS SHOULD BE READ INTO al HERE IT IS 2
	mov ch,0x00				;DEFINE 1ST CYLINDER CYLINDER 0
	mov dh,0x00				;THE READ HEAD WILL BE AT POSITION ZERO
	mov cl,0x02				;STRAT READING FROM 2ND SECTOR	
	int 0x13				
	jc disk_error1				;UNCONDITIONAL JUMP IF ANY ERROR HAPPENS WHILE READING FROM THE SECTOR
	pop dx					
	cmp al,dh				;COMPARE IT NO OF SECTOR READ==SECTORS TO BE READ
	jne error_msg2				;ERROR UNCONDITIONAL JUMP
	call success				;PRINT SUCCESS STATUS IF READING IS COMPLETED SUCCESSFULLY
	ret					
disk_error1:	
	mov si,error_msg1
	call print_string
disk_error2:
	mov si,error_msg2
	call print_string
error_msg1:
	db "CAN NOT READ THE DISK",0
	dw 0x0d0a	
error_msg2:
	db "READ SECTOR NOT EQUAL",0
	dw 0x0d0a
success:
	mov si,s_msg
	call print_string
	ret
	
s_msg: 
	dw 0x0d0a
	db "HURRAY SUCCESSFULLY READ 2 SECTORS",0
