; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		errorhandler.asm
;		Purpose:	Error handler
;		Created:	1st May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code
	
ErrorHandler:
		pla
		ply
		sta 	zTemp0
		sty 	zTemp0+1
		ldx 	#0 							; output msg to channel #0 
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
		;
		ldx 	#0 							; convert line# to string
		jsr 	FloatSetByte
		jsr 	GetLineNumber
		sta 	NSMantissa0,x
		tya
		sta 	NSMantissa1,x
		jsr 	FloatToString
		ldy 	#0 							; display that string.
		ldx 	#0
_EHDisplayLine:
		lda 	decimalBuffer,y
		jsr 	XPrintCharacter
		iny
		lda 	decimalBuffer,y
		bne 	_EHDisplayLine
		lda 	#13
		jsr 	XPrintCharacter
		jmp 	ExitCompiler
						
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
