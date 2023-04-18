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
		;
		;		Main compilation loop
		;
MainCompileLoop:
		jsr 	STRMarkLine 				; remember the position and number of this line.
		lda 	#PCD_NEWCMD_LINE 			; generate new command line
		jsr 	WriteCodeByte

_MCLSameLine:
		jsr 	GetNextNonSpace 			; get the first character.
		beq 	_MCLNextLine 				; end of line.
		cmp 	#":"						; if : then loop back.
		beq 	_MCLSameLine

		cmp 	#0 							; if ASCII then check for implied LET.		
		bpl 	_MCLCheckAssignment 

		ldx 	#CommandTables & $FF 		; do command tables.
		ldy 	#CommandTables >> 8
		jsr 	GeneratorProcess
		bcs 	_MCLSameLine 				; keep trying to compile the line.

_MCLSyntax: 								; syntax error.
		.error_syntax
		;
		;		Implied assignment ?
		;
_MCLCheckAssignment:
		jsr 	CharIsAlpha 				; if not alpha then syntax error
		bcc 	_MCLSyntax
		jsr 	CommandLETHaveFirst  		; LET first character, do assign
		bra		_MCLSameLine 				; loop back.

_MCLNextLine:		
		jsr 	HWINextLine 				; go to the next line.
		bcs 	MainCompileLoop 			; found one, keep compile.
		;
		;		End of compile, fix up GOTO/GOSUB etc., save it and exit.
		;
SaveCodeAndExit:
		lda 	#PCD_EXIT 					; add an END
		jsr 	WriteCodeByte
		lda 	#$FF 						; add end marker
		jsr 	WriteCodeByte
		jsr 	FixBranches 				; fix up GOTO/GOSUB etc.
		;
		;  TODO: Possibly append variable map ?
		;
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
