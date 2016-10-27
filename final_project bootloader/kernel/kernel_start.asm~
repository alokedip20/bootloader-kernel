[bits 16]
load_kernel:
	mov si,status_msg    	
	call  print_string	;PRINT THE STATUS MESSEGE
	mov bx, kernel_pos      ;STORE THE KERNEL POSITION INTO BX REGISTER 
	mov dh,1               	; READ 1 SECTOR FROM 2ND SECTOR THIS MAY VARY ACCORDING TO OUR KERNEL IMAGE SIZE
	mov dl, [boot_drive]    
	call  read_sector		;READ THE 2 SECTORS FROM BOOT-DRIVE AND LOAD THEM TO ES:BX REGISTER
	ret
;-----------------------------------------------------------------------------------------------------------------------
[bits  32]
start_protectedMode:
	mov eax,0x1000  	;JUST A PRECAUTION TO CHECK IF THE KERNEL FUNCTION HAS BEEN LOADED IN THE STANDERD 0X1000 LOCATION
	mov ebx,kernel_pos 
	cmp ebx,eax		;CHECK IF THE KERNEL LOADING POSITION IS 0X1000	
	jne error3		;IF NOT EQUAL THEN IT WILL STUCK TO INFINITE LOOP
	call kernel_pos      	;THIS WILL CALL THE FUNCTION WRITTEN IN C LOADED AT LOCATION kernel_pos=0x1000
	jmp $                   ;INFINITE LOOP
;---------------------------------------------------------------------------------------------------------------------------
	error3:
                jmp start_protectedMode


