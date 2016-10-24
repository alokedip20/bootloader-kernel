kernel_pos  equ 0x1000			;THIS IS THE MEMORY OFFSET WHERE THE BIOS LOAD THE KERNEL
mov [boot_drive], dl 			;STORE THE DRIVE WHERE THE BOOTSECTOR PROGRAMME RESIDES
main:
	[org 0x7c00]
	call print_real
	call  print_string      	;PRINT THE STATUS MESSEGE	DEFINED IN "print.asm"
	call wait_input			;TAKE THE KEYBOARD INPUT TO START LOADING THE KERNEL
	call  load_kernel       	;FUNCTION TO LOAD THE KERNEL
	mov ax,13h			;SWITCH TO VIDEO MODE BEFORE ENTERING TO PROTECTED MODE USING 13/10h
	int 10h
	call  switch_to_pm      	;SWITCH FROM REAL MODE TO PROTEDTED MODE DEFINED IN "switch.ams"
	jmp $
;---------------------------------------- PRINT MSG IN REAL MODE ------------------------------------------------------------------	
	print_real:
		mov si,msg_Real
		call print_string
		ret
;---------------------------------------	WAIT FOR A KEY PRESS	------------------------------------------------------------------------
	wait_input:
		mov ah,0
		int 16h
		ret

;--------------------------------------         INCLUDE EXTERNEL FILES TO MAKE THE CODE SMALLER     -----------------------------------------
	%include "print/print.asm"
	%include "disk_access/read_kernel.asm"
	%include "protected_mode/gdt.asm"		;THE GLOBAL DESCRIPTOR TABLE IS DEFINED IN THIS ASSEMBLY FILE
	%include "protected_mode/switch.asm"		;DEFINE THE PROCEDURE HOW TO SWITCH FROM REAL MODE TO PROTECTED MODE

;-------------------------------------------------------;LOAD THE KERNEL AND START EXECUTING THE KERNEL ----------------------------------------
	
	%include "kernel/kernel_start.asm"	

;--------------------------------------------GLOBAL VARIABLES DECLARATIONS----------------------------------------------------------
	boot_drive:	
		db 0
	msg_Real:    
		db "CPU IS IN 16 BIT MODE :) PRESS ANY KEY TO LOAD THE KERNEL .....", 0
		dw 0x0d0a
	status_msg: 
		dw 0x0d0a 
		db "LOADING  KERNEL WRITTEN IN HIGHER LEVEL LANGUAGE (C)....", 0
		dw 0x0d0a
	times  510-($-$$) db 0		;THIS IS THE PADDING OF 510 BYTES RESTS ARE FILLED WITH ZEROS
	dw 0xaa55			;THIS  IS THE LAST TWO BYTES AA 55 AS BOOT-SIGNATURE
