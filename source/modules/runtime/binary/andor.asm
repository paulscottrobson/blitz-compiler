; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		andor.asm
;		Purpose:	And/Or operators
;		Created:	14th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									AND/OR code
;
; ************************************************************************************************

BinaryAnd: ;; [and]
		.entercmd
		sec
		bra 	AndOrCommon
BinaryOr: ;; [or]
		.entercmd
		clc

AndOrCommon:
		php 								; save AND/OR flag
			 								; convert both to 16 bit format.
		jsr 	GetInteger16Bit
		dex		
		jsr 	GetInteger16Bit

		plp
		bcc 	_AOCOrCode
	
		lda 	NSMantissa0,x 				; AND code
		and		NSMantissa0+1,x
		sta 	NSMantissa0,x
		lda 	NSMantissa1,x
		and		NSMantissa1+1,x
		sta 	NSMantissa1,x
		bra 	_AOCComplete
_AOCOrCode:
		lda 	NSMantissa0,x 				; OR code
		ora		NSMantissa0+1,x
		sta 	NSMantissa0,x
		lda 	NSMantissa1,x
		ora		NSMantissa1+1,x
		sta 	NSMantissa1,x
_AOCComplete:		
		stz 	NSStatus,x 					; make integer ?
		bit 	NSMantissa1,x 				; result is -ve
		bpl 	_AOCExit

		jsr 	Negate16Bit 				; 2's complement
		lda 	#$80 						; make it -ve
		sta 	NSStatus,x
_AOCExit:		
		.exitcmd

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
