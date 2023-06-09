; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		newline.asm
;		Purpose:	Newline command
;		Created:	13th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									Newline command
;
; ************************************************************************************************

CommandNewLine: ;; [new.line]
		.entercmd
		.resetStringSystem
		ldx 	#$FF
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
