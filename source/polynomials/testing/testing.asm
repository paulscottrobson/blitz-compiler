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

WrapperBoot:	
		ldx 	#255
		jsr 	TestScript
		.exitemu

ErrorHandler:
		.debug		

TestScript:		
		.include "generated/testcode.dat"	
		rts
		

; ************************************************************************************************
;
;					Assert checks stack has one value, should be -1
;	
; ************************************************************************************************

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
;										Temp |tos| function
;
; ************************************************************************************************

FPAbs:
		stz 	NSStatus,x
		rts

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
