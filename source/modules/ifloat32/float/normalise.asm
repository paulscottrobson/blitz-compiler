; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		normalise.asm
;		Purpose:	Normalise FP value
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									  Normalise Stack[X]
;
; ************************************************************************************************

FloatNormalise:
		jsr 	FloatIsZero 				; if zero exit 
		bne 	_NSNormaliseOptimise 		; if so, normalise it.
		asl 	NSStatus,x 					; clear the sign bit.
		ror 	NSStatus,x 					; (no -0)
		lda 	#0 							; set Z flag
		rts
		;
		;		Normalise by byte if the MSB is zero we can normalise it
		;		(providing bit 7 of 11th byte is not set)
		;
_NSNormaliseOptimise:						
		lda 	NSMantissa3,x 				; upper byte zero ?
		bne 	_NSNormaliseLoop
		lda 	NSMantissa2,x 				; byte normalise
		bmi 	_NSNormaliseLoop 			; can't do it if bit 7 set of 2

		sta 	NSMantissa3,x
		lda 	NSMantissa1,x
		sta 	NSMantissa2,x
		lda 	NSMantissa0,x
		sta 	NSMantissa1,x
		stz 	NSMantissa0,x
		;
		lda 	NSExponent,x
		sec
		sbc 	#8
		sta 	NSExponent,x
		bra 	_NSNormaliseOptimise
		;
		;		Normalise by bit
		;
_NSNormaliseLoop:		
		bit 	NSMantissa3,x 				; bit 30 set ?
		bvs 	_NSNExit 					; exit if so with Z flag clear
		jsr 	FloatShiftLeft 				; shift mantissa left
		dec 	NSExponent,x 				; adjust exponent
		bra 	_NSNormaliseLoop
_NSNExit:
		lda 	#$FF 						; clear Z flag
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
