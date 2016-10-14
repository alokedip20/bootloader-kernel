kernel_pos  equ 0x1000			;THIS IS THE MEMORY OFFSET WHERE THE BIOS LOAD THE KERNEL
mov [boot_drive], dl 			;STORE THE DRIVE WHERE THE BOOTSECTOR PROGRAMME RESIDES
start:
	[org 0x7c00]
	mov si,msg_Real 		;STATUS MESSEGE THAT INDICATE THE KERNEL POSITION (16 OR 32BIT MODE)
	call  print_string      	;PRINT THE STATUS MESSEGE	DEFINED IN "print.asm"
	call wait_input			;TAKE THE KEYBOARD INPUT TO START LOADING THE KERNEL
	call  load_kernel       	;FUNCTION TO LOAD THE KERNEL
	call  switch_to_pm      	;SWITCH FROM REAL MODE TO PROTEDTED MODE DEFINED IN "switch.ams"
	jmp $
;---------------------------------------------------------------------------------------------------------------
	wait_input:
		mov ah,0
		int 16h

;--------------------------------------INCLUDE EXTERNEL FILES TO MAKE THE CODE SMALLER----------------------------------------------------------
	%include "print.asm"
	%include "disk_load.asm"
	%include "gdt.asm"		;THE GLOBAL DESCRIPTOR TABLE IS DEFINED IN THIS ASSEMBLY FILE
	%include "print_string_pm.asm"	;PRINT THE STRING IN PROTECTED MODE DIRECTLY IN VIDEO BUFFER
	%include "switch.asm"		;DEFINE THE PROCEDURE HOW TO SWITCH FROM REAL MODE TO PROTECTED MODE
; ---------------------------------------------------------------------------------------------------------
	[bits 16]
	load_kernel:
		mov si,status_msg    	
		call  print_string	;PRINT THE STATUS MESSEGE
		mov bx, kernel_pos      ;STORE THE KERNEL POSITION INTO BX REGISTER 
		mov dh,2               ; READ 2 SECTORS FROM 2ND SECTOR THIS MAY VARY ACCORDING TO OUR KERNEL IMAGE SIZE
		mov dl, [boot_drive]    
		call  disk_load		;READ THE 6 SECTORS FROM BOOT-DRIVE AND LOAD THEM TO ES:BX REGISTER
		ret
;------------------------------------------------------------------------------------------------------------
	[bits  32]
	start_protectedMode:
		mov ebx,msg_protected 	;STORE THE MESSEGE IN ebx REGISTER IN PM MODE
		call  print_string_pm   
		call  kernel_pos      	;THIS WILL CALL THE FUNCTION WRITTEN IN C LOADED AT LOCATION kernel_pos=0x1000
		jmp $                   ;INFINITE LOOP

;--------------------------------------------GLOBAL VARIABLES DECLARATIONS------------------------------------------
	boot_drive:	
		db 0
	msg_Real:    
		dw 0x0d0a
		db "CPU IS IN 16 BIT MODE PRESS ANY KEY TO SWITCH TO 32 BIT PROTECTED MODE AND LOAD KERNEL", 0
		dw 0x0d0a
	msg_protected:   
		db "CPU SUCCESSFULLY SWITCHED INTO 32BIT PROTECTED MODE", 0
		dw 0x0d0a
	status_msg: 
		dw 0x0d0a 
		db "Loading  KERNEL WRITTEN IN HIGHER LEVEL LANGUAGE (C).", 0
		dw 0x0d0a
	times  510-($-$$) db 0		;THIS IS THE PADDING OF 510 BYTES RESTS ARE FILLED WITH ZEROS
	dw 0xaa55			;THIS  IS THE LAST TWO BYTES AA 55 AS BOOT-SIGNATURE
