; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		compiler.asm
;		Purpose:	Compiler main
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

Boot:	
		
		jsr 	HWIReset
		jsr 	HWOReset
MainCompileLoop:
		;  TODO: Check for implied assignment
		;  TODO: Dispatch appropriately via scanned command handler.
		;  TODO: GetNextLine
		;  Loop if not finished

		;  TODO: Patch up GOTO, GOSUB and (possibly) IF
		;  TODO: Possibly append variable map ?
		;  TODO: Write code out to disk

		lda 	#42
		jsr 	WriteCodeByte
		jsr 	HWOSave
		jmp 	$FFFF
		rts

ErrorHandler:
		.debug
		bra 	ErrorHandler

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
