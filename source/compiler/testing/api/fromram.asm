; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		fromram.asm
;		Purpose:	Read input data from RAM appended to end of compiler.
;		Created:	8th May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Open/Close the input system
;
; ************************************************************************************************

APIIOpen:
		.set16 	srcInputPtr,EndProgram+2 	; the current read point.		
APIIClose:
		rts
		
; ************************************************************************************************
;
;								Get the next character.
;
; ************************************************************************************************

APIIGet:
		lda 	(srcInputPtr)
		inc 	srcInputPtr
		bne 	_IGSkip
		inc 	srcInputPtr+1
_IGSkip:
		rts

		.send code

		.section zeropage
srcInputPtr: 								; data from here
		.fill 	2
		.send zeropage

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