; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		read_string.asm
;		Purpose:	Read String
;		Created:	17th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								Read string (2 byte command)
;
; ************************************************************************************************

ReadStringCommand:
		.entercmd
		.vaddress
		jsr 	ReadStringZTemp0Sub
		.exitcmd
		
ReadStringZTemp0Sub:
		phy 								; start write
		inx 								; prepare
		stz 	NSMantissa2,x
		stz 	NSMantissa3,x
		stz 	NSExponent,x
		lda 	#NSSString
		stz 	NSStatus,x

		clc
		lda 	(zTemp0)					; read address of block add 2.
		adc 	#2 							; this points to actual data
		sta 	NSMantissa0,x 				; if address 0 the MSB will still be 0

		ldy 	#1
		lda 	(zTemp0),y
		adc 	#0
		sta 	NSMantissa1,x 				; +ve read

		bne 	_RSZNoDefault 				; if read $00 use a default value.

		lda 	#_RSZNull & $FF
		sta 	NSMantissa0,x
		lda 	#_RSZNull >> 8
		sta 	NSMantissa1,x
_RSZNoDefault:		

		ply
		rts

_RSZNull:	 								; dummy empty string
		.byte 	0
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
