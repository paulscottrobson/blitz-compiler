; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		multiply.asm
;		Purpose:	Multiply BMantissa by AMantissa
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsoFloat.org.uk)
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
		ldx 	#UseAMantissa
		jsr 	FloatNormaliseX				; normalise A and exit if zero
		beq 	_FDExit 					; return zero if zero (e.g. zero*something)
		ldx 	#UseBMantissa
		jsr 	FloatNormaliseX				; normalise B and error if zero.
		beq 	_FDSetZero 					

		jsr 	MultiplyShort 				; calculate the result.		
		adc 	AExponent 					; calculate exponent including the shift.
		clc
		adc 	BExponent
		sta 	AExponent
		bra 	_FDExit

_FDSetZero:
		jsr 	FloatSetZeroX 				; return 0
_FDExit:
		jsr 	FloatNormaliseX 			; normalise the result
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
