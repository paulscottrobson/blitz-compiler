; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		forward.asm
;		Purpose:	Move object pointer forward
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Move objPtr forwards. CS if end
;
; ************************************************************************************************

MoveObjectForward:

		lda 	(objPtr) 					; get next

		sec 								; return CS if complete
		cmp 	#$FF  						
		beq 	_MOFExit

		cmp 	#$40 						; 00-3F
		bcc 	_MOFAdvance1 				; forward 1

		ldx 	#2 							; 40-7F
		cmp 	#$80 						; forward 2
		bcc 	_MOFAdvanceX 				

		cmp 	#PCD_STARTSYSTEM 			; 80 - System tokens.
		bcc 	_MOFAdvance1 				; forward 1

		tax 								; read the size.
		lda 	_MOFSizeTable-PCD_STARTSYSTEM,x
		tax
		inx 								; add 1 for the system token.
		bne 	_MOFAdvanceX 				; if 0, was $FF thus a string/data skip.

		ldy 	#1 							; get length byte
		lda 	(objPtr),y
		tax 								; into X.

		clc
		lda 	objPtr						; add 2 to the object pointer
		adc 	#2
		sta 	objPtr
		bcc 	_MOFNoCarry1
		inc 	objPtr+1
_MOFNoCarry1:		
		bra 	_MOFAdvanceX

_MOFAdvance1:
		ldx 	#1
_MOFAdvanceX:				
		txa 								; add X to objPtr
		clc
		adc 	objPtr
		sta 	objPtr
		bcc 	_MOFNoCarry2
		inc 	objPtr+1
_MOFNoCarry2:		
		clc 								; not completed.
_MOFExit:		
		rts

_MOFSizeTable:
		.include "../../common/generated/pcodesize.dat"

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
