; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		exp.asm
;		Purpose:	Exponent function.
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									calculate EXP(x)
;
; ************************************************************************************************

FloatExponent:
	
		.pushfloat Const_Log2_e			; multiply by log2 e
		jsr 	FloatMultiply 

		jsr 	_UECopy01 				; copy 0 to 1, get integer part to 1
		inx
		jsr 	FloatIntegerPart
		dex

		lda 	NSMantissa1+1,x
		ora 	NSMantissa2+1,x
		ora 	NSMantissa3+1,x
		bne 	_UERangeError

		lda 	NSMantissa0+1,x 		; push integer part on stack.
		cmp 	#64
		bcs 	_UERangeError
		pha

		lda 	NSStatus,x 				; push sign
		pha

		jsr 	FloatFractionalPart		; copy 0 to 1, get fractional part to 0

		pla 
		bpl 	_UEPositive

		inx 							; 1-x
		lda 	#1
		jsr 	FloatSetByte		
		dex
		jsr 	FloatNegate
		inx
		jsr 	FloatAdd

		pla 							; integer part +1 and negated.
		inc 	a
		eor 	#$FF
		inc 	a
		pha

_UEPositive:		
		jsr 	CoreExponent
		jsr 	CompletePolynomial

		pla		
		clc
		adc 	NSExponent,x
		sta 	NSExponent,x
		clc
		rts

_UECopy01:
		txa
		tay
		iny
		jmp 	CopyFloatXY

_UERangeError:
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
