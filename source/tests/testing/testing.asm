; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		testing.asm
;		Purpose:	Basic testing for runtime
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
_WBError: 									; stop on error
		bcs 	_WBError
		jmp 	$FFFF

APIDesc:
		.word 	TestAPI 					; the testing API.
		.byte 	StartWorkSpace >> 8 		; start of workspace for compiler
		.byte 	EndWorkspace >> 8 			; end of workspace for compiler
											; this example is 8000-9EFF.
		.send code

		.include "../../compiler/testing/api/api.asm"
		.include "../../compiler/testing/api/line.asm"
		.include "../../compiler/testing/api/save.asm"

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

