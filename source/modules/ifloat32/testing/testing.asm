; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		testing.asm
;		Purpose:	Basic testing for ifloat32 (only built if float is main)
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

		.if ismain_ifloat32 == 1
Boot:	ldx 	#255
		.include "../generated/testcode.dat"	

		.exitemu

FPAssertCheck:
		cpx 	#0
		bne 	_FPACFail
		lda 	NSMantissa0,x
		beq 	_FPACFail
		dex
		rts
_FPACFail:
		.debug
		bra 	_FPACFail

; ************************************************************************************************
;
;								Push following FP constant on stack
;
; ************************************************************************************************

FPPushConstant:
		inx
		pla
		ply
		sta 	zTemp0
		sty 	zTemp0+1
		ldy 	#1
		lda 	(zTemp0),y
		sta 	NSMantissa0,x
		iny
		lda 	(zTemp0),y
		sta 	NSMantissa1,x
		iny
		lda 	(zTemp0),y
		sta 	NSMantissa2,x
		iny
		lda 	(zTemp0),y
		sta 	NSMantissa3,x
		iny
		lda 	(zTemp0),y
		sta 	NSExponent,x
		iny
		lda 	(zTemp0),y
		sta 	NSStatus,x
		;
		lda 	zTemp0
		ldy 	zTemp0+1
		clc
		adc 	#6
		bcc 	_FPPCNoCarry
		iny
_FPPCNoCarry:
		phy
		pha
		rts		

		.endif	
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
