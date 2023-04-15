; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		nextline.asm
;		Purpose:	Set up for next line.
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						Set pointers to next line in srcPtr. CS if ok, CC if EOF
;
; ************************************************************************************************


HWINextLine:	
		lda 	(inputPtr) 					; check if reached end of program.
		ldy 	#1
		ora 	(inputPtr),y
		beq 	_HWIGFail

		clc 								; advance following link.
		lda 	(inputPtr)
		adc 	offsetAdjust
		pha
		lda 	(inputPtr),y 	
		adc 	offsetAdjust+1
		sta 	inputPtr+1
		pla
		sta 	inputPtr

		jsr 	HWISetTokenisedCodePtr 		; set srcPtr accordingly.
		sec
		rts

_HWIGFail:
		clc
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
