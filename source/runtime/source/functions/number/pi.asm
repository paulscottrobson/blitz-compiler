; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		pi.asm
;		Purpose:	Return value of PI
;		Created:	11th October 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										PI function
;
; ************************************************************************************************

UnaryPI: ;; [pi]
		.entercmd
		.debug
		inx
		lda 	#Const_pi-Const_base
		jsr 	LoadConstant
;		lda 	#42
;		jsr 	FloatSetByte
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