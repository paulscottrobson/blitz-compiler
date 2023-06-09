; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		len.asm
;		Purpose:	Length of string.
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;								  End current program
;
; ************************************************************************************************

		.section code

UnaryLen: ;; [len]
		.entercmd

		lda 	NSMantissa0,x 				; string address.
		sta 	zTemp0
		lda 	NSMantissa1,x
		sta 	zTemp0+1
		;
		lda 	(zTemp0) 					; get length
		jsr 	FloatSetByte

		.exitcmd

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
