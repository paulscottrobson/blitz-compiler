; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		read_int.asm
;		Purpose:	ReadInteger
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

ReadIntegerCommand:
		.entercmd
		.vaddress
		jsr 	ReadIntegerZTemp0Sub
		.exitcmd

ReadIntegerZTemp0Sub:
		phy 								; start write
		ldy 	#1
		inx 								; prepare
		stz 	NSMantissa2,x
		stz 	NSMantissa3,x
		stz 	NSExponent,x
		stz 	NSStatus,x

		lda 	(zTemp0),y 					; get MSB, do -ve code.
		bmi 	_RIZNegative

		sta 	NSMantissa1,x 				; +ve read
		lda 	(zTemp0)
		sta 	NSMantissa0,x
		ply
		rts

_RIZNegative:
		sec 								; -ve read
		lda 	#0
		sbc 	(zTemp0)
		sta 	NSMantissa0,x
		lda 	#0
		sbc 	(zTemp0),y
		sta 	NSMantissa1,x
		lda 	#$80
		sta 	NSStatus,x
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
