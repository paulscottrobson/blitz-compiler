; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_open.asm
;		Purpose:	OPEN
;		Created:	2nd May 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;					<logical> <device> <secondary> <filename> OPEN command
;
; ************************************************************************************************

CommandOpen: ;; [open]
		.entercmd
		;
		;		Set up the file name
		;
		lda 	NSMantissa0+3  				; point zTemp0 to string head, also in XY
		sta 	zTemp0
		tax
		lda 	NSMantissa1+3 
		sta 	zTemp0+1
		tay

		inx 								; XY points to first character
		bne 	_CONoCarry
		iny
_CONoCarry:		
		lda 	(zTemp0) 					; get length of filename
		jsr 	X16_SETNAM
		;
		; 		Set up the logical channel.
		;
		lda 	NSMantissa0+0
		ldx 	NSMantissa0+1
		ldy 	NSMantissa0+2
		jsr 	X16_SETLFS
		;
		;		Open
		;
		jsr 	X16_OPEN
		bcs 	_COError
		.exitcmd
_COError:
		.error_channel

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
