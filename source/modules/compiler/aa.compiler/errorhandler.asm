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
		jsr 	XPrintCharacterToChannel
		iny
		lda 	(zTemp0),y
		bne 	_EHDisplayMsg
		lda 	#32
		jsr 	XPrintCharacterToChannel
		lda 	#64
		jsr 	XPrintCharacterToChannel
		;
		ldx 	#0 							; convert line# to string
		jsr 	FloatSetByte
		jsr 	HWILineNumber
		sta 	NSMantissa0,x
		tya
		sta 	NSMantissa1,x
		jsr 	FloatToString
		ldy 	#0 							; display that string.
		ldx 	#0
_EHDisplayLine:
		lda 	decimalBuffer,y
		jsr 	XPrintCharacterToChannel
		iny
		lda 	decimalBuffer,y
		bne 	_EHDisplayLine

_EHStop:bra 	_EHStop
						
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
