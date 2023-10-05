; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		pos.asm
;		Purpose:	Get screen horizontal position
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;								POS(0) horizontal position
;
; ************************************************************************************************

		.section code

UnaryPos: ;; [pos]
		.entercmd
		jsr 	XGetHPos
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
