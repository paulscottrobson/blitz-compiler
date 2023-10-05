; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		sin.asm
;		Purpose:	Sine function.
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									calculate SIN(x)
;
; ************************************************************************************************

FloatSine:
		lda 	NSStatus,x 					; save sign
		pha
		stz 	NSStatus,x 					; make +ve

		.pushfloat Const_1Div2Pi 			; divide by 2*Pi

		jsr 	FloatMultiply 
		jsr 	FloatFractionalPart 		; take the fractional part

		lda 	NSExponent,x 				; check exponent
		cmp 	#$E0 						; < $E0 exponent : 0-0.25
		bcc 	_USProcessExit
		beq 	_USSubtractFromHalf 		; = $E0 exponent : 0.25-0.5
		lda 	NSMantissa3,x 				; if > 0.75 which is $60000000:$E1
		cmp 	#$60
		bcs 	_USSubtractOne 				
_USSubtractFromHalf:						; 0.25 - 0.75 calculate 0.5-x
		.pushfloat Const_half 				; so calculate x-0.5
		jsr 	FloatSubtract
		jsr 	FloatNegate 				; then negate it
		bra 	_USProcessExit 				; and exit

_USSubtractOne:								; 0.75 - 1.0 calculate x - 1
		inx
		lda 	#1
		jsr 	FloatSetByte
		jsr 	FloatSubtract

_USProcessExit:
		jsr 	CoreSine
		jsr 	CompletePolynomial
		pla 								; restore sign and apply
		eor 	NSStatus,x
		sta 	NSStatus,x
		clc
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
