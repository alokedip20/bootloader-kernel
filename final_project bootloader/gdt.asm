gdt_start:
	gdt_null: 			; NULL DESCRIPTOR 8 BYTES MUT BE ZERO EACH dd REGISTERS ARE OF SIZE 4 BYTES
		dd 0x0   
		dd 0x0
;------------------------------------------------------------------------------------------------
	gdt_code: 			;CODE SEGMENT
		dw 0xffff   		;LIMIT 0XFFFFF
		dw 0x0        		;BASE 0X0 (LOWER 8 BITS)
		db 0x0         		;BASE 0X0(HIGHER 8 BITS)
		db  10011010b		;PRESENT+PRIVILAGE+DESCRIPTOR_TYPE+TYPE(4 BITS 1_0_1_0)
		db  11001111b 		;FAST 4 BITS =>(1_1_0_0)--GRANULARITY+32-BITDEFAULT+64-BIT CODE SEGMENT+AVL LAST 4 BITS AS ABOVE 
		db 0x0        		;BASE (HIGHEST 8 BITS SET TO ZERO)
;--------------------------------------------------------------------------------------------------
	gdt_data: 			;DATA SEGMENT
		dw 0xffff    		;LIMIT AS CODE SEGMENT
		dw 0x0         		;BASE
		db 0x0         		;BASE
		db  10010010b 		;CODE BIT WILL BE ZERO AS IT IS DATA SEGMENT OTHERS WILL BE AS CODE SEGMENT
		db  11001111b 		;SAME AS CODE SEGMENT
		db 0x0        		;BASE
	gdt_end:         
		gdt_descriptor:
		dw  gdt_end  - gdt_start  - 1   ; TOTAL SIZE IS TRUE SIZE-1
		dd  gdt_start                   ; STARTING ADDRESS OF THE GDT TABLE
CODE_SEG  equ  gdt_code  - gdt_start		;CODE SEGMENT OFFSET 
DATA_SEG  equ  gdt_data  - gdt_start		;DATA SEGMENT OFFSET
