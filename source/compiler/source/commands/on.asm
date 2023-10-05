; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		on.asm
;		Purpose:	ON compiler
;		Created:	21st April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;											Compile ON
;
; ************************************************************************************************

CommandON:
		jsr 	GetNextNonSpace 			; GOTO / GOSUB must follow
		pha 								; save on stack

		ldx 	#PCD_CMD_GOTO
		cmp 	#C64_GOTO 					; must be GOTO/GOSUB
		beq 	_COCreateLoop
		ldx 	#PCD_CMD_GOSUB
		cmp 	#C64_GOSUB
		beq 	_COCreateLoop
		.error_syntax

_COCreateLoop:
		txa 								; compile a goto/gosub somewhere
		phx
		jsr 	CompileBranchCommand		
		plx
		jsr 	LookNextNonSpace			; ',' follows
		cmp 	#"," 						
		bne 	_COComplete 				; if so, more line numbers
		lda 	#PCD_MOREON 				; ON extends.
		jsr 	WriteCodeByte
		jsr 	GetNext
		bra 	_COCreateLoop

_COComplete:
		pla 								; throw GOTO/GOSUB
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
