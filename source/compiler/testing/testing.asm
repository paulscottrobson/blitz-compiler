; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		testing.asm
;		Purpose:	Basic testing for runtim
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

StartWorkSpace = $8000
EndWorkspace = $9F00

WrapperBoot:	
		ldx 	#APIDesc & $FF
		ldy 	#APIDesc >> 8
		jsr 	StartCompiler
		jmp 	$FFFF

APIDesc:
		.fill 	2
		.byte 	StartWorkSpace >> 8 		; start of workspace for compiler
		.byte 	EndWorkspace >> 8 			; end of workspace for compiler
											; this example is 8000-9EFF.

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
