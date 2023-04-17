; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		integers.asm
;		Purpose:	Integer value read/write
;		Created:	14th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code


GetInteger8Bit:
		.floatinteger
		lda 	NSMantissa0,x
		rts

GetInteger16Bit:
		.floatinteger
		bit 	NSStatus,x
		bmi 	Negate16Bit
		lda 	NSMantissa0,x
		sta 	zTemp0
		lda 	NSMantissa1,x
		sta 	zTemp0+1
		rts
Negate16Bit:
		sec
		lda 	#0
		sbc 	NSMantissa0,x
		sta 	NSMantissa0,x
		sta 	zTemp0
		lda 	#0
		sbc 	NSMantissa1,x
		sta 	NSMantissa1,x
		sta 	zTemp0+1
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
