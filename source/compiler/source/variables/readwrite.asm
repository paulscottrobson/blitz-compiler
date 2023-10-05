; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		readwrite.asm
;		Purpose:	Generate code to read/write variables
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;					On entry YX is the address and A the type data (bits 7..5)
;						CS => generate write code, CC => generate read code
;
; ************************************************************************************************

GetSetVariable:
		php 								; save direction on stack
		cpy 	#$00
		bmi 	_GSVReadWriteSpecial
		cmp 	#$00
		bmi 	_GSVArray
		;
		; 		64-79 is float, 80-95 is integer, 96-111 is string. So we multiply the
		;		type bits 5 & 6 byte 16 - but they are already multiplied by 32, so
		;
		and 	#NSSTypeMask+NSSIInt16 		; get type bits
		lsr 	a 							; divide by 2
		ora 	#64 						; and set bit 6.
		;
		plp
		bcc 	_GSVNotWrite
		ora 	#8  						; set bit 3 if it is write.
_GSVNotWrite:
		sta 	zTemp0
		;
		tya 	 							; shift X/Y right as the address stored is halved
		lsr 	a
		tay 	
		txa 
		ror 	a
		tax
		;
		tya 								; lower 3 bits of YX are ORed into the opcode
		ora 	zTemp0 						; which is the first byte of the opcode
		jsr 	WriteCodeByte
		;
		txa 								; and the lower 8 bits of YX are the second byte
		jsr 	WriteCodeByte
		rts
		;
		;		Special read/writes
		;
_GSVReadWriteSpecial:
		;
		;		TODO: TI TI$ code missing		
		;
		plp
		bcs 	_GSVSyntax		
		;
		;		Handle clock read
		;
		cpy 	#$C0 						; TI$ ?
		beq 	_GSVRWString
		.keyword PCD_TI
		rts
_GSVRWString:
		.keyword PCD_TIDOLLAR
		rts		

_GSVSyntax:
		.error_syntax
		;
		;		For arrays use the indirection @ %@ $@ ! %! $!
		;
_GSVArray:
		and 	#NSSTypeMask+NSSIInt16 		; mask out 2 bits of type data
		lsr 	a		 					; shift from 5,6 to 0,1
		lsr 	a		
		lsr 	a		
		lsr 	a		
		lsr 	a				
		plp 								; if writing array then set bit 2.
		bcc 	_GSVANotWrite
		ora 	#4
_GSVANotWrite:		
		ora 	#$78 						; make a valid opcode.
		jsr 	WriteCodeByte 				; and write it out
		rts

		.send code

; ************************************************************************************************
;
;									Changes and Updates
;
; ************************************************************************************************
;
;		Date			Notes
;		==== 			=====
;
; ************************************************************************************************
