[bits  16]
switch_start:
	switch_to_pm:
		cli 			;DISABLE INTERRUPTS,SO THAT CPU CAN EASILY SWITCH FROM 16 BIT TO 32 BIT
		lgdt [gdt_descriptor]   ;LOAD THE GDT (GLOBAL DESCRIPTOR TABLE) IT WILL PROVIDE THE MEMORY ACCESS PRIVILAGES WE CAN INCLUDE IT

;-----------------------------TO SWITCH TO 32 BIT MODE SET THE FIRST BIT OF CPU CONTROL REGISTER(cr0) USING GENERAL PURPOSE REGISTER eax 
		mov eax , cr0          
		or eax , 0x1               
		mov cr0 , eax

;-----------------------AT THIS POINT CPU HAS BEEN SWITCHED TO PROTECTED MODE BUT TO FLUSH THE CPU PIPELINE WE HAVE TO MAKE A FAR JUMP--------

		jmp  CODE_SEG:init_pm    ;HERE FAR JUMP IS DEFINED BY JUMP ADDRESS =>CODE_SEG AND JUMP OFFSET=>init_pm

;--------------------------------------------------------------------------------------------------
		[bits  32]	;DIRECTIVE TO TELL THE ASSEMBLER THAT FROM THIS POINT ONWARDS DECODE IN 32 BIT MODE---------------
		
		init_pm:				;UPDATE  ALL THE REGISTERS TO START OPERATION IN PROTECTED MODE 
			call  start_protectedMode       ;DO THOSE PROTECTED MODE OPERATIONS
