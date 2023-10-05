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
;							 Negate mantissa/status/exponent value
;
; ************************************************************************************************

FloatNegate:							
		lda 	NSStatus,x 					; everything is sign/magnitude usually so just
		eor 	#$80  						; toggle the negative flag
		sta 	NSStatus,x
		rts

; ************************************************************************************************
;
;							  Negate mantissa only 2's complements
;
; ************************************************************************************************

FloatNegateMantissa:								
		sec 								; when we want an actual 32 bit 2's complement value.
		lda 	#0
		sbc 	NSMantissa0,x
		sta 	NSMantissa0,x
		lda 	#0
		sbc 	NSMantissa1,x
		sta 	NSMantissa1,x
		lda 	#0
		sbc 	NSMantissa2,x
		sta 	NSMantissa2,x
		lda 	#0
		sbc 	NSMantissa3,x
		sta 	NSMantissa3,x
		rts

; ************************************************************************************************
;
;							  Shift entry X to entry X+2
;
; ************************************************************************************************

FloatShiftUpTwo:
		lda 	NSMantissa0,x
		sta 	NSMantissa0+2,x
		lda 	NSMantissa1,x
		sta 	NSMantissa1+2,x
		lda 	NSMantissa2,x
		sta 	NSMantissa2+2,x
		lda 	NSMantissa3,x
		sta 	NSMantissa3+2,x
		lda 	NSExponent,x 				
		sta 	NSExponent+2,x
		lda 	NSStatus,x
		sta 	NSStatus+2,x 	
		rts
		
; ************************************************************************************************
;
;							  Set mantissa to a 1 byte integer, various
;
; ************************************************************************************************

FloatSetZeroMantissaOnly: 					; clear *only* the mantissa
		stz 	NSMantissa0,x
		bra 	FloatZero13
FloatSetZero: 								; set the whole lot to zero, exponent, mantissa
		lda 	#0
FloatSetByte:
		stz 	NSExponent,x 				; zero exponent, as +ve integer value.
FloatSetMantissa:		
		sta 	NSMantissa0,x 				; zero mantissa
		stz 	NSStatus,x
FloatZero13:		
		stz 	NSMantissa1,x
		stz 	NSMantissa2,x
		stz 	NSMantissa3,x
		rts
				
; ************************************************************************************************
;
;									Rotate/Shift the mantissa left
;
; ************************************************************************************************

FloatShiftLeft:		
		clc
FloatRotateLeft:
		rol 	NSMantissa0,x
		rol		NSMantissa1,x
		rol		NSMantissa2,x
		rol		NSMantissa3,x
		rts

; ************************************************************************************************
;
;									Shift the mantissa right
;
; ************************************************************************************************

FloatShiftRight:		
		lsr 	NSMantissa3,x
		ror		NSMantissa2,x
		ror		NSMantissa1,x
		ror		NSMantissa0,x
		rts

; ************************************************************************************************
;
;									   Check zero mantissa
;
; ************************************************************************************************

FloatIsZero:
		lda 	NSMantissa3,x
		ora		NSMantissa2,x
		ora		NSMantissa1,x
		ora		NSMantissa0,x
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
