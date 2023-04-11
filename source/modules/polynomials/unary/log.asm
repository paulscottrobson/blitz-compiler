; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		log.asm
;		Purpose:	Log function.
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									calculate LOG(x)
;
; ************************************************************************************************

FloatLogarithm: 	
	
		lda 	NSStatus,x 					; check > 0
		bmi 	_ULRange
		jsr 	FloatIsZero
		beq 	_ULRange
		jsr 	FloatNormalise 				; put into FP mode.

		lda 	NSExponent,x 				; get power
		pha

		lda 	#(-31) & $FF 				; force into range 0.5 -> 1
		sta 	NSExponent,x


		.pushfloat Const_sqrt_half 			; add sqrt 0.5
		jsr 	FloatAdd


		txa 								; divide into sqrt 2.0
		tay
		iny
		jsr 	CopyFloatXY
		dex
		.pushfloat Const_sqrt_2
		inx

		jsr 	FloatDivide 				; if zero, error.
		bcs 	_ULRangePla

		jsr 	FloatNegate 				; subtract from 1
		inx
		lda 	#1
		jsr 	FloatSetByte
		jsr 	FloatAdd

		jsr 	CoreLog
		jsr 	CompletePolynomial

		pla 								; add exponent
		clc
		adc 	#31 						; fix up

		pha
		bpl 	_LogNotNeg
		eor 	#$FF
		inc 	a		
_LogNotNeg:		
		inx 								; set byte and sign.
		jsr 	FloatSetByte

		pla
		and 	#$80
		sta 	NSStatus,x
		jsr 	FloatAdd

		.pushfloat Const_ln_e 			; * log2(e)
		jsr 	FloatMultiply
		clc
		rts

_ULRangePla:
		pla
_ULRange:
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
