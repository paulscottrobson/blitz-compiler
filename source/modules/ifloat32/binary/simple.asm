; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		simple.asm
;		Purpose:	Simple binary operations add/subtract
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;									Macro to simplify simple handlers
;
; ************************************************************************************************

simple32 .macro
		lda		NSMantissa0,x
		\1 		NSMantissa0+1,x 	
		sta 	NSMantissa0,x
		lda		NSMantissa1,x
		\1 		NSMantissa1+1,x 	
		sta 	NSMantissa1,x
		lda		NSMantissa2,x
		\1 		NSMantissa2+1,x 	
		sta 	NSMantissa2,x
		lda		NSMantissa3,x
		\1 		NSMantissa3+1,x 	
		sta 	NSMantissa3,x
		.endm

; ************************************************************************************************
;
;								Two's complement math operators
;
; ************************************************************************************************

FloatAddTopTwoStack:		
		clc
		.simple32 adc
		rts

FloatSubTopTwoStack:		
		sec
		.simple32 sbc
		rts

; ************************************************************************************************
;
;					Optimised Binary Operators for add and subtract when integer
;
; ************************************************************************************************

FloatInt32Add:
		lda 	NSStatus,x 					; signs are the same, can just add the mantissae.
		eor 	NSStatus+1,x
		bmi 	_DiffSigns
		jsr		FloatAddTopTwoStack
		rts
		;
_DiffSigns:		
		jsr 	FloatSubTopTwoStack 		; do a physical subtraction
		bit 	NSMantissa3,x 				; result is +ve, okay
		bpl 	_AddExit 	
		lda 	NSStatus+1,x 				; sign is that of 11th value
		sta 	NSStatus,x
		jsr 	FloatNegateMantissa 		; negate the mantissa and exit
_AddExit:
		jsr 	FloatIsZero 				; check for -0
		bne 	_AddNonZero
		stz 	NSStatus,x
_AddNonZero:		
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
