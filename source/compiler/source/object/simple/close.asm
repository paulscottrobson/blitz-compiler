; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		close.asm
;		Purpose:	Close, perhaps Save the object code out
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Save the object code out
;
; ************************************************************************************************

OUTPUTClose:
		lda 	#(PCodeStart >> 8)
		ldx 	objPtr
		ldy 	objPtr+1
		jsr 	XSaveMemory
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