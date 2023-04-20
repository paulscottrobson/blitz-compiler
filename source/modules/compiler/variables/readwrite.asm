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
;			On entry YX is the address ($FFFF for an array) and A the type data (bits 7..5)
;								for array, address to use is on TOS
;						CS => generate write code, CC => generate read code
;
; ************************************************************************************************

GetSetVariable:
		php 								; save direction on stack
		cpx 	#6
		beq 	_GSVReadWriteClock
		cpy 	#$FF 						; array ?
		beq 	_GSVArray
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
		;		Handle arrays.
		;
_GSVArray:
		.error_unimplemented		
		;
		;		Handle clock read/write
		;
_GSVReadWriteClock:
		plp
		bcs 	_GSVSyntax		
		lda 	#PCD_TI
		jsr 	WriteCodeByte
		rts

_GSVSyntax:
		.error_syntax

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
