; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		write_float.asm
;		Purpose:	Write iFloat32
;		Created:	13th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								Write float (2 byte command)
;
; ************************************************************************************************

WriteFloatCommand:
		.entercmd
		.vaddress
		jsr 	WriteFloatZTemp0Sub
		.exitcmd

WriteFloatZTemp0Sub:
		phy 								; ldart write
		ldy 	#1

		lda 	NSMantissa0,x
		sta 	(zTemp0)
		
		lda 	NSMantissa1,x
		sta 	(zTemp0),y
		iny

		lda 	NSMantissa2,x
		sta 	(zTemp0),y
		iny

		lda 	NSMantissa3,x
		sta 	(zTemp0),y
		iny

		lda 	NSExponent,x
		sta 	(zTemp0),y
		iny

		lda 	NSStatus,x
		sta 	(zTemp0),y

		dex
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
