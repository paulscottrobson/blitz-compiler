; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		usr.asm
;		Purpose:	USR() function
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;											USR() function
;
; ************************************************************************************************

UnaryUsr:	;; [usr]
		.entercmd
		phy
		jsr 	_UUCallVector
		ply
		.exitcmd

_UUCallVector:
		jmp 	(USRRoutineAddress)
		
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