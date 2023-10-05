; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		mult8x8.asm
;		Purpose:	8x8 integer multiplication
;		Created:	20th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;							S[X] * S[X+1] where 8x8 unsigned
;
; ************************************************************************************************

FloatInt8Multiply:	
		phy
		lda 	NSMantissa0,x 				; right shifted multiplier in Y
		tay
		stz 	NSMantissa0,x 				; zero the result (already 8 bit constant)
_FI8MLoop:
		tya 								; shift right shifter right into carry
		lsr 	a
		tay		
		bcc 	_FI8MNoAdd

		clc
		lda 	NSMantissa0,x
		adc 	NSMantissa0+1,x
		sta 	NSMantissa0,x
		lda 	NSMantissa1,x
		adc 	NSMantissa1+1,x
		sta 	NSMantissa1,x
_FI8MNoAdd:
		asl 	NSMantissa0+1,x 			; shift adder left
		rol 	NSMantissa1+1,x
		cpy 	#0
		bne 	_FI8MLoop 					; until right shifter zero.
		ply
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
