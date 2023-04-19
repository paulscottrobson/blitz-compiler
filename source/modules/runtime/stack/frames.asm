; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		frames.asm
;		Purpose:	Stack frame routines
;		Created:	19th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										Open a frame
;
; ************************************************************************************************

StackOpenFrame:
		pha 								; save frame marker
		and 	#$1F 						; bytes required.
		sta 	zTemp0
		;
		sec 								; subtract from runtime stack pointer.
		lda		runtimeStackPtr
		sbc 	zTemp0
		sta 	runtimeStackPtr
		lda		runtimeStackPtr+1
		sbc 	#0
		sta 	runtimeStackPtr+1
		;
		pla 								; put frame marker at +0
		sta 	(runtimeStackPtr)
		rts

; ************************************************************************************************
;
;										Close a frame
;
; ************************************************************************************************

StackCloseFrame:
		lda 	(runtimeStackPtr)			; get frame marker
		and 	#$1F 						; size
		clc
		adc 	runtimeStackPtr
		sta 	runtimeStackPtr
		bcc 	_SCFNoCarry
		inc 	runtimeStackPtr+1
_SCFNoCarry:
		rts

; ************************************************************************************************
;
;										Check a frame
;
; ************************************************************************************************

StackCheckFrame:
		cmp 	(runtimeStackPtr) 			; matches current frame
		bne 	_SCFFail
		rts
_SCFFail:
		.error_structure

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
