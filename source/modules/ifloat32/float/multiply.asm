; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		multiply.asm
;		Purpose:	Multiply Stack[x] by Stack[x+1] floating point
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									Floating point multiplication
;
; ************************************************************************************************

FloatMultiply:	

		dex
		lda 	NSExponent,x 				; can use optimised ?
		ora 	NSExponent+1,x
		ora 	NSMantissa3,x
		ora 	NSMantissa3+1,x		
		bne 	_FMUseFloat
		
		jsr 	FloatMultiplyShort			; use the int32 one.
		clc 								; fix it up if gone out of range
		adc 	NSExponent,x
		sta 	NSExponent,x
		rts

_FMUseFloat:
		jsr 	FloatNormalise		 		; normalise S[X] and exit if zero
		beq 	_FDExit 					; return zero if zero (e.g. zero*something)
		inx 
		jsr 	FloatNormalise		 		; normalise S[x+1] and error if zero.
		dex
		cmp 	#0
		beq 	_FDSetZero 					

		jsr 	FloatMultiplyShort 			; calculate the result.		
		adc 	NSExponent,x 				; calculate exponent including the shift.
		clc
		adc 	NSExponent+1,x
		sta 	NSExponent,x
		bra 	_FDExit

_FDSetZero:
		jsr 	FloatSetZero 				; return 0
_FDExit:
		jsr 	FloatNormalise 				; normalise the result
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
