; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		integerdown.asm
;		Purpose:	Make FPA Denormalised integer, rounded down.
;		Created:	14th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;							Make FPA into an integer, rounded down
;
; ************************************************************************************************

FloatIntegerPartDown:
		pha
		phy
		;
		lda 	NSExponent,x 				; is it integer already ?
		beq 	_FIPExit 					; if so do nothing
		jsr 	FloatIsZero 				; is it zero ?
		beq 	_FIPZero 					; if so return zero.
		;
		jsr 	FloatNormalise 				; normalise
		beq 	_FIPZero 					; normalised to zero, exit zero
		ldy 	#0 							; reset the count of bits.
		;
_FIPShift:
		lda 	NSExponent,x 				; if Exponent >= 0 exit.
		bpl 	_FIPCheckDown

		jsr 	FloatShiftRight 			; shift mantissa right
		bcc 	_FIPNoFrac 					; shifted a zero out ?
		iny
_FIPNoFrac:		
		inc 	NSExponent,x 				; bump exponent 
		bra 	_FIPShift

_FIPCheckDown:
		cpy 	#0 							; were there any fractional bits.
		beq 	_FIPCheckZero
		bit 	NSStatus,x 					; +ve
		bpl 	_FIPCheckZero 
		inx 								; -ve so round *down*.
		lda 	#1
		jsr 	FloatSetByte
		jsr 	FloatNegate
		jsr 	FloatAdd
_FIPCheckZero:
		jsr 	FloatIsZero 				; avoid -0 problem
		bne 	_FIPExit 					; set to zero if mantissa zero.		
_FIPZero:
		jsr 	FloatSetZero
_FIPExit:
		ply
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
