; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		integers.asm
;		Purpose:	Integer value read/write
;		Created:	14th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										Faster make-integer
;
; ************************************************************************************************

floatinteger .macro
		jsr 	FloatIntegerPart
		.endm

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
