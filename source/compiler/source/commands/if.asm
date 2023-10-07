; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		if.asm
;		Purpose:	If command
;		Created:	19th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;											IF
;
; ************************************************************************************************

CommandIF: 		
		jsr 	LookNextNonSpace 			; what follows the tests ?
		cmp 	#C64_GOTO 					; IF .. GOTO
		beq 	_CIGoto
		;
		lda 	#C64_THEN 					; should be THEN
		jsr 	CheckNextA
		;
		jsr 	LookNextNonSpace 			; THEN <number>
		jsr 	CharIsDigit
		bcs 	_CIGoto2
		bra 	CompileGotoEOL

_CIGoto:	
		jsr 	GetNext 					
_CIGoto2:		
		lda 	#PCD_CMD_GOTOCMD_NZ
		jsr 	CompileBranchCommand
		rts
		
CompileGotoEOL: 							; compile GOTOZ <next line>
		lda 	#PCD_CMD_GOTOCMD_Z
		jsr 	WriteCodeByte
		jsr 	GetLineNumber 				; Get the current line number => YA
		inc 	a 							; and branch to +1
		bne 	_CGENoCarry
		iny
_CGENoCarry:		
		jsr 	WriteCodeByte
		tya
		jsr 	WriteCodeByte
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
