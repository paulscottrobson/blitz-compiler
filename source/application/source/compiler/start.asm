; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		start.asm
;		Purpose:	Start actual compilation.
;		Created:	9th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;									Compile the code from disk
;
; ************************************************************************************************

CompileCode:
		ldx 	#0
_Prompt:lda 	Prompt,x
		jsr 	$FFD2
		inx
		cmp 	#0
		bne 	_Prompt

		ldx 	#APIDesc & $FF
		ldy 	#APIDesc >> 8
		jsr 	StartCompiler
		jsr 	WriteObjectCode
		lda 	#"O"
		jsr 	$FFD2
		lda 	#"K"
		jsr 	$FFD2
		rts

; ************************************************************************************************
;
;									API Setup for the compiler
;
; ************************************************************************************************

APIDesc:
		.word 	CompilerAPI 				; the compiler API Implementeation
		.byte 	$80 						; start of workspace for compiler $8000
		.byte 	$9F							; end of workspace for compiler $9F00

; ************************************************************************************************
;
;									File names for the compiler
;
; ************************************************************************************************

ObjectFile:
		.text 	'OBJECT.PRG',0		
SourceFile:
		.text 	'SOURCE.PRG',0					
Prompt:
		.text 	'*** BLITZ (ALPHA 14-10-23) ***',13,13
		.text 	'BUGS -> HTTPS://GITHUB.COM/PAULSCOTTROBSON/BLITZ-COMPILER',13,13,0								

		.send code

		.section storage
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
