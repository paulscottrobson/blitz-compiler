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
		
ErrorHandler:
		pla
		ply
		sta 	zTemp0
		sty 	zTemp0+1
		ldy 	#1
_EHDisplayMsg:
		lda 	(zTemp0),y
		jsr 	XPrintCharacter
		iny
		lda 	(zTemp0),y
		bne 	_EHDisplayMsg
		lda 	#32
		jsr 	XPrintCharacter
		lda 	#64
		jsr 	XPrintCharacter
		lda 	#32
		jsr 	XPrintCharacter

		lda 	codePtr+1
		jsr 	_EHDisplayHex
		lda 	codePtr
		jsr 	_EHDisplayHex
_EHStop:bra 	_EHStop

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
		jmp 	XPrintCharacter
						
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
