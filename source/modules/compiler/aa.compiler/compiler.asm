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
		jsr 	GetNext

MainCompileLoop:
		jsr 	STRMarkLine 				; remember the position and number of this line.
		lda 	#PCD_NEWCMD_LINE 			; generate new command line
		jsr 	WriteCodeByte

		jsr 	CompileTerm

		;  TODO: Check for implied assignment
		;  TODO: Dispatch appropriately via scanned command handler.
		;  TODO: if not end, then keep trying.
		;  TODO: GetNextLine
		;  Loop if not finished

		;  TODO: Patch up GOTO, GOSUB and (possibly) IF
		;  TODO: Possibly append variable map ?
		;  TODO: Write code out to disk

		lda 	#PCD_EXIT
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
