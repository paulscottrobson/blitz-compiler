; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		integer.asm
;		Purpose:	Make FPA Denormalised integer
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									Make FPA into an integer
;
; ************************************************************************************************

FloatIntegerPart:
		pha
		;
		lda 	NSExponent,x 				; is it integer already ?
		beq 	_FIPExit 					; if so do nothing
		jsr 	FloatIsZero 				; is it zero ?
		beq 	_FIPZero 					; if so return zero.
		;
		jsr 	FloatNormalise 				; normalise
		beq 	_FIPZero 					; normalised to zero, exit zero
		;
_FIPShift:
		lda 	NSExponent,x 				; if Exponent >= 0 exit.
		bpl 	_FIPCheckZero		 		

		jsr 	FloatShiftRight 			; shift mantissa right
		inc 	NSExponent,x 				; bump exponent 
		bra 	_FIPShift

_FIPCheckZero:
		jsr 	FloatIsZero 				; avoid -0 problem
		bne 	_FIPExit 					; set to zero if mantissa zero.		
_FIPZero:
		jsr 	FloatSetZero
_FIPExit:
		pla
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
