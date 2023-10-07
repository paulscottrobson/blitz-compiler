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
		
		cmp 	#$FF  						
		beq 	_MOFEnd

		cmp 	#$40 						; 00-3F
		bcc 	_MOFAdvance1 				; forward 1

		ldy 	#2 							; 40-6F
		cmp 	#$70 						; forward 2
		bcc 	_MOFAdvanceY 				

		cmp 	#PCD_STARTSYSTEM 			; 70 - System tokens.
		bcc 	_MOFAdvance1 				; forward 1

		tay 								; read the size.
		lda 	MOFSizeTable-PCD_STARTSYSTEM,y
		tay
		iny 								; add 1 for the system token.
		bne 	_MOFAdvanceY 				; if 0, was $FF thus a string/data skip.

		ldy 	#1 							; get length byte
		lda 	(objPtr),y
		tay 								; into Y.

		clc
		lda 	objPtr						; add 2 to the object pointer
		adc 	#2
		sta 	objPtr
		bcc 	_MOFNoCarry1
		inc 	objPtr+1
_MOFNoCarry1:		
		bra 	_MOFAdvanceY

_MOFAdvance1:
		ldy 	#1
_MOFAdvanceY:				
		tya 								; add Y to objPtr
		clc
		adc 	objPtr
		sta 	objPtr
		bcc 	_MOFNoCarry2
		inc 	objPtr+1
_MOFNoCarry2:		
		clc 								; not completed.
		rts
		;
		;		At the end so advance past $FF end marker and return CS.
		;
_MOFEnd:
		inc 	objPtr
		bne 	_MOFENoCarry
		inc 	objPtr+1
_MOFENoCarry:
		sec
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
