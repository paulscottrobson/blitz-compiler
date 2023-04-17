; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		write_int.asm
;		Purpose:	WriteInteger
;		Created:	13th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								Write integer (2 byte command)
;
; ************************************************************************************************

WriteIntegerCommand:
		.entercmd
		.vaddress

WriteIntegerZTemp0:
		.floatinteger
		phy 								; start write
		ldy 	#1
		lda 	NSStatus,x 					; negate 2's comp if -ve
		bmi 	_WIZNegative

		lda 	NSMantissa0,x 				; +ve write
		sta 	(zTemp0)
		lda 	NSMantissa1,x
		sta 	(zTemp0),y
		ply
		dex
		.exitcmd
_WIZNegative:
		sec 								; -ve read
		lda 	#0
		sbc 	NSMantissa0,x
		sta 	(zTemp0)
		lda 	#0
		sbc 	NSMantissa1,x
		sta 	(zTemp0),y
		ply
		dex
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
