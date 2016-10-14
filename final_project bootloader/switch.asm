[bits  16]
switch_to_pm:
	cli 				;DISABLE INTERRUPTS,SO THAT CPU CAN EASILY SWITCH FROM 16 BIT TO 32 BIT
	lgdt [gdt_descriptor]   	;LOAD THE GDT (GLOBAL DESCRIPTOR TABLE)

;-----------------------------TO SWITCH TO 32 BIT MODE SET THE FIRST BIT OF CPU CONTROL REGISTER(cr0) USING GENERAL PURPOSE REGISTER eax 
	mov eax , cr0          
	or eax , 0x1               
	mov cr0 , eax
;------------------------------------------------------------------------
	jmp  CODE_SEG:init_pm    	;JUMP TO THE GDT CODE SEGEMNT TO INITIALISE THE PROTECTED MODE LIKE FLUSHING OUT THE CPU CATCHES ..
;--------------------------------------------------------------------------------------------------
[bits  32]
init_pm:				;INITIALISE ALL THE REGISTERS TO START OPERATION IN PROTECTED MODE
	mov ax, DATA_SEG		;REPLACE ax WITH DATA SEGMENT OFFSET	
	mov ds, ax                
	mov ss, ax           
	mov es, ax
	mov fs, ax
	mov gs, ax
;--------------------------------------------- DO THE OPERATIONS IN PROTECTED MODE IN OUR CASE JUMP TO HIGH LEVEL LANGUAGE----------------
call  start_protectedMode       
