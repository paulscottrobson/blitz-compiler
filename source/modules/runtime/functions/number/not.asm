; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		not.asm
;		Purpose:	NOT of TOS
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									     Not TOS
;
; ************************************************************************************************

NotTOS:	;; [not]
		.entercmd
		.floatinteger
		stz 	NSMantissa2,x 				; chop down to 16 bit.
		stz 	NSMantissa3,x

		jsr 	FloatNegate		 			; negate

		inx 								; and subtract 1.
		lda 	#1
		jsr 	FloatSetByte
		jsr 	FloatSubtract

_NotTOSSkip:
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
