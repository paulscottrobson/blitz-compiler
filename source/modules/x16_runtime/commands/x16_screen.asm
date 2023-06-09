; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_screen.asm
;		Purpose:	Screen Command
;		Created:	4th May 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;											Screen Command
;
; ************************************************************************************************

CommandScreen: ;; [screen]
		.entercmd
		phx
		phy
		jsr 	GetInteger8Bit
		clc 
		jsr 	X16_screen_mode
		ply
		plx
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
