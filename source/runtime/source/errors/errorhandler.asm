; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		errorhandler.asm
;		Purpose:	Error handler
;		Created:	12th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

Unimplemented:
		jmp 	ErrorV_unimplemented
		
RuntimeErrorHandler:
		tya
		clc
		adc 	codePtr
		sta 	codePtr
		bcc 	_EHNoCarry
		inc 	codePtr+1
_EHNoCarry:		
		pla
		ply
		sta 	zTemp0
		sty 	zTemp0+1
		ldx 	#0 							; output to channel #0 
		ldy 	#1
_EHDisplayMsg:
		lda 	(zTemp0),y
		jsr 	XPrintCharacterToChannel
		iny
		lda 	(zTemp0),y
		bne 	_EHDisplayMsg
		lda 	#32
		jsr 	XPrintCharacterToChannel
		lda 	#64
		jsr 	XPrintCharacterToChannel
		lda 	#32
		jsr 	XPrintCharacterToChannel
		jsr 	EHDisplayCodePtr
		jmp 	EndRuntime

EHDisplayCodePtr:
		lda 	#'$'
		jsr 	XPrintCharacterToChannel
		sec
		lda 	codePtr+1 					; display the p-code address of the error.
		sbc 	runtimeHigh
		jsr 	_EHDisplayHex
		lda 	codePtr
		jsr 	_EHDisplayHex
		rts

_EHDisplayHex:
		pha
		lsr 	a
		lsr 	a
		lsr 	a
		lsr 	a
		jsr 	_EHDisplayNibble
		pla		
_EHDisplayNibble:
		and 	#15
		cmp 	#10
		bcc 	_EHNotHex
		adc 	#6
_EHNotHex:
		adc 	#48
		jmp 	XPrintCharacterToChannel
						
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
