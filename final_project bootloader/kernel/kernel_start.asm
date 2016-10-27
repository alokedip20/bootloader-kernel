[bits 16]
load_kernel:
	mov si,status_msg    	
	call  print_string	;PRINT THE STATUS MESSEGE
	mov bx, kernel_pos      ;STORE THE KERNEL POSITION INTO BX REGISTER 
	mov dh,1               	; READ 1 SECTOR FROM 2ND SECTOR THIS MAY VARY ACCORDING TO OUR KERNEL IMAGE SIZE
	mov dl, [boot_drive]    
	call  read_sector		;READ THE 2 SECTORS FROM BOOT-DRIVE AND LOAD THEM TO ES:BX REGISTER
	ret
;----------------------------------------------------------------------------------------------------------------------


