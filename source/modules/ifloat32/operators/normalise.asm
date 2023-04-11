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
;							Normalise AMantissa,X, return Z set if zero
;
; ************************************************************************************************

FloatNormaliseX:
		jsr 	FloatIsZeroX 				; if zero exit 
		bne 	_NSNormaliseOptimise 		; if so, normalise it.
		asl 	AStatus,x 					; clear the sign bit.
		ror 	AStatus,x 					; (no -0)
		lda 	#0 							; set Z flag
		rts
		;
		;		Normalise by byte if the MSB is zero we can normalise it
		;		(providing bit 7 of 2nd byte is not set)
		;
_NSNormaliseOptimise:						
		lda 	AMantissa3,x 				; upper byte zero ?
		bne 	_NSNormaliseLoop
		lda 	AMantissa2,x 				; byte normalise
		bmi 	_NSNormaliseLoop 			; can't do it if bit 7 set of 2

		sta 	AMantissa3,x
		lda 	AMantissa1,x
		sta 	AMantissa2,x
		lda 	AMantissa0,x
		sta 	AMantissa1,x
		stz 	AMantissa0,x
		;
		lda 	AExponent,x
		sec
		sbc 	#8
		sta 	AExponent,x
		bra 	_NSNormaliseOptimise
		;
		;		Normalise by bit
		;
_NSNormaliseLoop:		
		bit 	AMantissa3,x 				; bit 30 set ?
		bvs 	_NSNExit 					; exit if so with Z flag clear
		jsr 	FloatShiftLeftX 				; shift mantissa left
		dec 	AExponent,x 				; adjust exponent
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
