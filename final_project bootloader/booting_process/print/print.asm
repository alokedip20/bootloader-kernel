print_16bit_mode:
	print_string:                   
        	mov ah, 0Eh             ;INT 10/0EH INTERRUPT HAS BEEN USED
		.repeat:
        		lodsb                   ;LOAD STRINGBYTES AND STORES IT INTO al
        		cmp al, 0		;IF THERE IS NO BYTES TO READ
        		je .done                ;EXIT FROM THE LOOP AND RETURN
        		int 10h                 ;ELSE PRINT NEXT CHARECTER
        		jmp .repeat

		.done:
        		ret			;RETURN TO THE CALLER

