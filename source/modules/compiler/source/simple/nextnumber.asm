; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		nextnumber.asm
;		Purpose:	Get next line number
;		Created:	19th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;									Get *following* line number
;							   If the last line, should CC, CS if okay.
;
; ************************************************************************************************

HWIGetNextLineNumber:
		clc 								; advance following link into zTemp0
		ldy 	#1
		lda 	(inputPtr)
		adc 	offsetAdjust
		sta 	zTemp0
		lda 	(inputPtr),y 	
		adc 	offsetAdjust+1
		sta 	zTemp0+1

		ldy 	#1 							; check not end of program.
		lda 	(zTemp0),y
		clc
		beq 	_HWIGNLNExit

		iny
		lda 	(zTemp0),y
		pha
		iny
		lda 	(zTemp0),y
		tay
		pla
		sec
_HWIGNLNExit:		
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
