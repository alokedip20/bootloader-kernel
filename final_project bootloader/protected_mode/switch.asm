[bits  16]
switch_start:
	switch_to_pm:
		cli 			;DISABLE INTERRUPTS,SO THAT CPU CAN EASILY SWITCH FROM 16 BIT TO 32 BIT
		lgdt [gdt_descriptor]   ;LOAD THE GDT (GLOBAL DESCRIPTOR TABLE) IT WILL PROVIDE THE MEMORY ACCESS PRIVILAGES WE CAN INCLUDE IT

;-----------------------------TO SWITCH TO 32 BIT MODE SET THE FIRST BIT OF CPU CONTROL REGISTER(cr0) USING GENERAL PURPOSE REGISTER eax 
		mov eax , cr0          
		or eax , 0x1               
		mov cr0 , eax

;----------------------- AT THIS POINT CPU HAS BEEN SWITCHED TO PROTECTED MODE BUT TO FLUSH THE CPU PIPELINE WE HAVE TO MAKE A FAR JUMP--------

		jmp  CODE_SEG:init_pm    ;HERE FAR JUMP IS DEFINED BY JUMP ADDRESS =>CODE_SEG AND JUMP OFFSET=>init_pm

;----------------------	;DIRECTIVE TO TELL THE ASSEMBLER THAT FROM THIS POINT ONWARDS DECODE IN 32 BIT MODE---------------

		[bits  32]		
		init_pm:				;UPDATE  ALL THE REGISTERS TO START OPERATION IN PROTECTED MODE 
			call  start_protectedMode       ;DO THOSE PROTECTED MODE OPERATIONS

;----------------------------------------------------------------------------------------------------------------

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
