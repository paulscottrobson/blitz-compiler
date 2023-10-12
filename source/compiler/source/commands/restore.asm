; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		restore.asm
;		Purpose:	RESTORE command
;		Created:	12th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										    RESTORE
;
; ************************************************************************************************

CommandRESTORE:
		jsr 	LookNextNonSpace 			; what follows ?
		cmp 	#':'						; if : or EOL then default
		beq 	_CRDefault
		cmp 	#0
		beq 	_CRDefault
		; 
		lda 	#PCD_CMD_RESTORE 			; no, we have a parameter like GOTO/GOSUB
		jsr 	CompileBranchCommand
		rts

_CRDefault:
		lda 	#PCD_CMD_RESTORE 			; compile RESTORE
		jsr 	WriteCodeByte
		lda 	#0		 					; with zero "line#"
		jsr 	WriteCodeByte	
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
