; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		divide.asm
;		Purpose:	Divide Stack[x] by Stack[x+1] floating point
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;							Floating point division (CS if Div Zero)
;
; ************************************************************************************************

FloatDivide:	
		pha
		jsr 	FloatNormalise		 		; normalise S[x+1] and error if zero.
		dex
		cmp 	#0
		beq 	_FDZero 					

		jsr 	FloatNormalise		 		; normalise S[X] and exit if zero
		beq 	_FDExit 					; return zero if zero (e.g. zero/something)

		jsr 	Int32ShiftDivide 			; do the shift division for dividing.
		jsr 	NSMCopyPlusTwoToZero 		; copy the mantissa down
		jsr		FloatNormalise 				; renormalise
		jsr 	FloatCalculateSign 			; calculate result sign

		lda 	NSExponent,x 				; calculate exponent
		sec
		sbc 	NSExponent+1,x
		sec
		sbc 	#30
		sta 	NSExponent,x
_FDExit:
		pla
		clc
		rts
_FDZero:
		pla
		sec
		rts

		.send 	code

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
