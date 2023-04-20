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

		lda 	#PCD_CMD_GOTOCMD_Z
		jsr 	WriteCodeByte
		lda 	#0
		jsr 	WriteCodeByte

		jsr 	HWIGetNextLineNumber 		; Get the *next* line number => YA
		bcs 	_CINotLastLine 				; if last line, write $FFFF out , illegal line#
		lda 	#$FF
		tay
_CINotLastLine:		
		jsr 	WriteCodeByte
		tya
		jsr 	WriteCodeByte
		rts

_CIGoto:	
		jsr 	GetNext
_CIGoto2:		
		lda 	#PCD_CMD_GOTOCMD_NZ
		jsr 	CompileBranchCommand
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
