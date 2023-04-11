; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		number.asm
;		Purpose:	Number utilities
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;							 					Negate X
;
; ************************************************************************************************

FloatNegateX:							
		lda 	AStatus,x 					; everything is sign/magnitude usually so just
		eor 	#$80 			 			; toggle the negative flag
		sta 	AStatus,x
		rts

; ************************************************************************************************
;
;							  Negate mantissa only 2's complements
;
; ************************************************************************************************

FloatNegateMantissa:								
		sec 								; when we want an actual 32 bit 2's complement value.
		lda 	#0
		sbc 	AMantissa0,x
		sta 	AMantissa0,x
		lda 	#0
		sbc 	AMantissa1,x
		sta 	AMantissa1,x
		lda 	#0
		sbc 	AMantissa2,x
		sta 	AMantissa2,x
		lda 	#0
		sbc 	AMantissa3,x
		sta 	AMantissa3,x
		rts

; ************************************************************************************************
;
;							  Set mantissa to a 1 byte integer, various
;
; ************************************************************************************************

FloatSetZeroMantissaOnlyX: 					; clear *only* the mantissa
		lda 	#0
		bra 	FloatSetMantissaX
FloatSetZeroX: 								; set the whole lot to zero, exponent, type, mantissa
		lda 	#0
FloatSetByteX:
		stz 	AExponent,x 				; zero exponent, as integer.
		stz 	AStatus,x 					; status zero (integer)
FloatSetMantissaX:		
		sta 	AMantissa0,x 				; mantissa
		stz 	AMantissa1,x
		stz 	AMantissa2,x
		stz 	AMantissa3,x
		rts
				
; ************************************************************************************************
;
;									Rotate/Shift the mantissa left
;
; ************************************************************************************************

FloatShiftLeftX:		
		clc
FloatRotateLeftX:
		rol 	AMantissa0,x
		rol		AMantissa1,x
		rol		AMantissa2,x
		rol		AMantissa3,x
		rts

; ************************************************************************************************
;
;									Shift the mantissa right
;
; ************************************************************************************************

FloatShiftRightX:		
		lsr 	AMantissa3,x
		ror		AMantissa2,x
		ror		AMantissa1,x
		ror		AMantissa0,x
		rts

; ************************************************************************************************
;
;									   Check zero mantissa
;
; ************************************************************************************************

FloatIsZeroX:
		lda 	AMantissa3,x
		ora		AMantissa2,x
		ora		AMantissa1,x
		ora		AMantissa0,x
		rts

; ************************************************************************************************
;
;									   		Copy to C
;
; ************************************************************************************************

FloatCopyToCX:
		lda 	AMantissa0,x
		sta 	CMantissa0
		lda 	AMantissa1,x
		sta 	CMantissa1
		lda 	AMantissa2,x
		sta 	CMantissa2
		lda 	AMantissa3,x
		sta 	CMantissa3
		lda 	AExponent,x
		sta 	CExponent,x
		lda 	AStatus,x
		sta 	CStatus,x
		rts

		.send code

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
