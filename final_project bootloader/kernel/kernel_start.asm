[bits 16]
load_kernel:
	mov si,status_msg    	
	call  print_string	;PRINT THE STATUS MESSEGE
	mov bx, kernel_pos      ;STORE THE KERNEL POSITION INTO BX REGISTER 
	mov dh,2               	; READ 2 SECTORS FROM 2ND SECTOR THIS MAY VARY ACCORDING TO OUR KERNEL IMAGE SIZE
	mov dl, [boot_drive]    
	call  read_sector		;READ THE 2 SECTORS FROM BOOT-DRIVE AND LOAD THEM TO ES:BX REGISTER
	ret
;-----------------------------------------------------------------------------------------------------------------------
[bits  32]
start_protectedMode:
	mov ebx,msg_protected 	;STORE THE MESSEGE(EMPTY STRING JUST TO CREATE SPACE) IN ebx REGISTER IN PM MODE
	call  adv_print
	mov eax,0x1000  	
	mov ebx,kernel_pos 
	cmp ebx,eax		;CHECK IF THE KERNEL LOADING POSITION IS 0X1000	
	jne error3		;IF NOT EQUAL THEN IT WILL STUCK TO INFINITE LOOP
	call kernel_pos      	;THIS WILL CALL THE FUNCTION WRITTEN IN C LOADED AT LOCATION kernel_pos=0x1000
	jmp $                   ;INFINITE LOOP
;---------------------------------------------------------------------------------------------------------------------------
	error3:
                jmp start_protectedMode


