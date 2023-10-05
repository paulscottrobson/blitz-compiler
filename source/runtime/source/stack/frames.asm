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
;									Find frame of type A
;
; ************************************************************************************************

StackFindFrame:
		sta 	requiredFrame
_SFFLoop:
		lda 	(runtimeStackPtr) 			; get TOS
		cmp 	#$FF 						; if found $FF then this is a fail.
		beq 	SCFFail 			
		cmp 	requiredFrame 				; found this type ?
		beq 	_SFFFound
		jsr 	StackCloseFrame 			; close the top frame
		bra 	_SFFLoop 					; and try te next.
_SFFFound:
		rts		

; ************************************************************************************************
;
;										Check a frame
;
; ************************************************************************************************

StackCheckFrame:
		cmp 	(runtimeStackPtr) 			; matches current frame
		bne 	SCFFail
		rts
SCFFail:
		.error_structure

		.send code

		.section storage
requiredFrame:
		.fill 	1
		.send 	storage		
		
; ************************************************************************************************
;
;									Changes and Updates
;
; ************************************************************************************************
;
;		Date			Notes
;		==== 			=====
;		22/06/23 		Added StackFindFrame which looks for a frame of this type and throws
;						non matchers.
;
; ************************************************************************************************
