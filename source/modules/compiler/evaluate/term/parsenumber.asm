; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		parsenumber.asm
;		Purpose:	Parse numeric constant
;		Created:	16th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;				Parse numeric constant into stack level 0, first char is in A
;				   Return CS if legitimate 16 bit +ve int with value in YA
;
; ************************************************************************************************

ParseConstant:
		ldx 	#0 
		jsr 	FloatEncodeStart 			; send first
_ParseLoop:
		jsr 	LookNext 					; send subsequent
		jsr 	FloatEncodeContinue
		bcc 	_ParseDone
		jsr 	GetNext 					; consume it
		bra 	_ParseLoop

_ParseDone:
		lda 	NSStatus,x 					; shouldn't be -ve ....
		and 	#$80
		ora 	NSExponent,x 				; 16 bit int check
		ora 	NSMantissa2,x
		ora 	NSMantissa3,x
		clc
		bne 	_ParseExit 					; exit with CC if need float to compile

		lda 	NSMantissa0,x 				; read into YA.
		ldy		NSMantissa1,x
		sec
_ParseExit:		
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
