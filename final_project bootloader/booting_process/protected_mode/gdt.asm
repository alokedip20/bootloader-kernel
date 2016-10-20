gdt_start:				;EACH SEGMENT(NULL+CODE+DATA) IS OF SIZE 8 BYTES
	gdt_null: 			;NULL DESCRIPTOR 8 BYTES MUT BE ZERO EACH dd REGISTERS ARE OF SIZE 4 BYTES
		dd 0x0   
		dd 0x0
;------------------------------------------------------------------------------------------------
	gdt_code: 			;CODE SEGMENT
		dw 0xffff   		;LIMIT 0XFFFFF
		dw 0x0        		;BASE 0X0 (LOWER 8 BITS =>0-15) 16BIT REGISTER
		db 0x0         		;BASE 0X0(HIGHER 8 BITS=>16-23) 8BIT REGISTER
		db  10011010b		;FLG1(PRSNT_1+PRVLG_00+DSCRPTR-TYPE_1)+TYPE(CODE_1+CNFRMNG_0+RDBL_1+ACCSS_0)
		db  11001111b 		;FLG2(GRANULARITY_1+32_DEFAULT_1+64BIT_0+AVL_0)+{LIMIT BIT(1111)=> SET LIMIT TO 0XFFFFF} 
		db 0x0        		;BASE (HIGHEST 8 BITS SET TO ZERO=>24-31) TOTAL 32BIT BASE ADDRESS 0X0
;--------------------------------------------------------------------------------------------------
	gdt_data: 			;DATA SEGMENT
		dw 0xffff    		;LIMIT AS CODE SEGMENT
		dw 0x0         		;BASE(0-15)
		db 0x0         		;BASE(16-23)
		db  10010010b 		;FLG1(WILL BE SAME AS CODE SEG)+TYPE(CODE_BIT WILL BE ZERO OTHER BITS WILL BE SAME)
		db  11001111b 		;FLG2+TYPE(WILL BE SAME AS CODE SEGMENT)
		db 0x0        		;BASE(24-31)
	gdt_end:         
		gdt_descriptor:
			dw  gdt_end  - gdt_start  - 1   ; TOTAL SIZE IS TRUE SIZE-1
			dd  gdt_start                   ; STARTING ADDRESS OF THE GDT TABLE
			CODE_SEG  equ  gdt_code  - gdt_start		;CODE SEGMENT OFFSET 
			DATA_SEG  equ  gdt_data  - gdt_start		;DATA SEGMENT OFFSET
