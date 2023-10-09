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

; ************************************************************************************************
;
;						On entry YX points to API.  On Exit CC if okay.
;
; ************************************************************************************************

StartCompiler:
		stx 	zTemp0 						; access API
		sty 	zTemp0+1

		ldy 	#CompilerErrorHandler >> 8 	; set error handler to compiler one.
		ldx 	#CompilerErrorHandler & $FF
		jsr 	SetErrorHandler
		;
		ldy 	#1 							; copy API vector		
		lda 	(zTemp0)	
		sta 	APIVector
		lda 	(zTemp0),y
		sta 	APIVector+1

		iny 								; copy data area range.
		lda 	(zTemp0),y 					
		sta 	compilerStartHigh
		iny
		lda 	(zTemp0),y 					
		sta 	compilerEndHigh

		tsx 								; save stack pointer
		stx 	compilerSP

		jsr 	STRReset 					; reset storage (line#, variable)

		lda 	#BLC_OPENIN					; reset data input
		jsr 	CallAPIHandler

		lda 	#BLC_RESETOUT 				; reset data output.
		jsr 	CallAPIHandler
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
		lda 	#BLC_READIN 				; read next line into the buffer.		
		jsr 	CallAPIHandler

		bcc 	SaveCodeAndExit 			; end of source.
		jsr 	ProcessNewLine 				; set up pointer and line number.
		;
		jsr 	GetLineNumber 				; get line #
		jsr 	STRMarkLine 				; remember the code position and number of this line.
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
		lda 	#BLC_CLOSEIN				; finish input.
		jsr 	CallAPIHandler

		lda 	#$FF 						; fake line number $FFFF for forward THEN.
		tay
		jsr 	STRMarkLine
		lda 	#PCD_EXIT 					; add an END
		jsr 	WriteCodeByte
		lda 	#$FF 						; add end marker
		jsr 	WriteCodeByte
		jsr 	FixBranches 				; fix up GOTO/GOSUB etc.

		lda 	#BLC_CLOSEOUT 				; close output store 
		jsr 	CallAPIHandler
		clc 								; CC = success

ExitCompiler:		
		ldx 	compilerSP 					; reload SP and exit.
		txs
		rts

; ************************************************************************************************
;
;										Call API Functions
;
; ************************************************************************************************

CallAPIHandler:
		jmp 	(APIVector)

		.send code

		.section storage
compilerSP:									; stack pointer 6502 on entry.
		.fill 	1
APIVector: 									; call API here
		.fill 	2		
compilerStartHigh:							; MSB of workspace start address
		.fill 	1		
compilerEndHigh:							; MSB of workspace end address
		.fill 	1		
		.send storage

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
