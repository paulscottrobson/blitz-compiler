; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		goto.asm
;		Purpose:	Goto command
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;											GO TO
;
; ************************************************************************************************

CommandGOAlt:
		lda 	#C64_TO 					; GO TO alternative
		jsr 	CheckNextA
		bra 	CommandGOTO

; ************************************************************************************************
;
;											GOTO
;
; ************************************************************************************************

CommandGOTO: 
		lda 	#PCD_CMD_GOTO
		jsr 	CompileBranchCommand
		rts

; ************************************************************************************************
;
;						Compile a branch (GOTO/GOSUB) with following line #
;
; ************************************************************************************************

CompileBranchCommand:
		jsr 	WriteCodeByte 				; write the command out.
		jsr 	GetNextNonSpace
		jsr 	ParseConstant 				; get constant into YA
		bcc 	_CBCSyntax

		pha
		lda 	#$FF 						; no address yet.
		jsr 	WriteCodeByte
		pla 								; and compile the actual line number
		jsr 	WriteCodeByte
		tya
		jsr 	WriteCodeByte
		rts		

_CBCSyntax:
		.error_syntax

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
