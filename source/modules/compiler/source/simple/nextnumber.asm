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
;							   If the last line, should return $FFFF
;
; ************************************************************************************************

HWIGetNextLineNumber:
		clc 								; advance following link into zTemp0
		ldy 	#1
		lda 	(inputPtr)
		beq 	_HWIEndOfProgram 			; no following line ?
		adc 	offsetAdjust
		sta 	zTemp0
		lda 	(inputPtr),y 	
		adc 	offsetAdjust+1
		sta 	zTemp0+1

		iny
		lda 	(zTemp0),y
		pha
		iny
		lda 	(zTemp0),y
		tay
		pla
		rts

_HWIEndOfProgram:
		lda 	#$FF
		tay
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
