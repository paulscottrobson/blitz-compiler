; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		00compiler.asm
;		Purpose:	Compiler main
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

Boot:	
		jsr 	STRReset 					; reset storage (line#, variable)
		jsr 	INPUTOpen 					; reset data input
		jsr 	OUTPUTOpen 					; reset data output.
		;
		;		Compile _variable.space, filled in on pass 2.
		;
		lda 	#PCD_CMD_VARSPACE
		jsr 	WriteCodeByte
		lda 	#0
		jsr 	WriteCodeByte
		jsr 	WriteCodeByte
		;
		;		Main compilation loop
		;
MainCompileLoop:
		jsr 	ReadNextLine 				; read next line into the buffer.
		bcc 	SaveCodeAndExit 			; end of source.
		;
		jsr 	GetLineNumber 				; get line #
		jsr 	STRMarkLine 				; remember the position and number of this line.
		lda 	#PCD_NEWCMD_LINE 			; generate new command line
		jsr 	WriteCodeByte

_MCLSameLine:
		jsr 	GetNextNonSpace 			; get the first character.
		beq 	MainCompileLoop 			; end of line, get next line.
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
		;
		;		End of compile, fix up GOTO/GOSUB etc., save it and exit.
		;
SaveCodeAndExit:
		jsr 	INPUTClose 					; finish input.
		lda 	#$FF 						; fake line number $FFFF for forward THEN.
		tay
		jsr 	STRMarkLine
		lda 	#PCD_EXIT 					; add an END
		jsr 	WriteCodeByte
		lda 	#$FF 						; add end marker
		jsr 	WriteCodeByte
		jsr 	FixBranches 				; fix up GOTO/GOSUB etc.
		jsr 	OUTPUTClose
ExitCompiler:		
		jmp 	$FFFF
		rts

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
