; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		write_string.asm
;		Purpose:	Write String
;		Created:	17th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								Write string (2 byte command)
;
; ************************************************************************************************

WriteStringCommand:
		.entercmd
		.vaddress
		jsr 	WriteStringZTemp0Sub
		.exitcmd

WriteStringZTemp0Sub:
		phy

		ldy 	#1 							; if it is zero we must concrete whatever.
		lda 	(zTemp0)
		ora 	(zTemp0),y
		beq 	_WSConcrete

		lda 	(zTemp0) 					; put address of actual string in zTemp1
		sta 	zTemp1
		lda 	(zTemp0),y
		sta 	zTemp1+1

		lda 	NSMantissa0,x 				; copy source to zTemp2
		sta 	zTemp2
		lda 	NSMantissa1,x
		sta 	zTemp2+1

		lda 	(zTemp1) 					; space available
		cmp 	(zTemp2) 					; if >= required length then copy
		bcs 	_WSCopy

		ldy 	#1 							; set the 'available for reclaim' flag
		lda 	(zTemp1),y
		ora 	#$80
		sta 	(zTemp1),y
		;
		;		Otherwise concrete it
		;
_WSConcrete:		
		lda 	NSMantissa1,x 				; string in YA
		tay
		lda 	NSMantissa0,x
		jsr 	StringConcrete
		;
		;		Update the address.
		;
		sta 	(zTemp0) 					; save returned address
		tya
		ldy 	#1
		sta 	(zTemp0),y		
		;
		;		Copy old string to new string space.
		;
_WSCopy		
		clc  								; copy target+2 to zTemp2
		lda 	(zTemp0)
		adc 	#2
		sta 	zTemp2
		ldy 	#1
		lda 	(zTemp0),y
		adc 	#0
		sta 	zTemp2+1
		;
		lda 	NSMantissa0,x 				; copy source to zTemp1
		sta 	zTemp1
		lda 	NSMantissa1,x
		sta 	zTemp1+1
		;
		lda 	(zTemp1) 					; length of string .. 0 inclusive
		tay
_WSCopyLoop:		
		lda 	(zTemp1),y
		sta 	(zTemp2),y
		dey 
		cpy 	#$FF
		bne 	_WSCopyLoop
	
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
