; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		print.asm
;		Purpose:	Print compilation
;		Created:	19th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						  					Print Command
;
; ************************************************************************************************

CommandPRINT:
		jsr 	LookNextNonSpace			; what follows ?
		cmp 	#";" 						; semicolon, check end of command
		beq 	_CPCheckEnd
		cmp 	#"," 						; , TAB and check end of command
		beq 	_CPTabCheckEnd	
		jsr 	_CPAtEnd 					; check for : and EOL
		bcs 	_CPExitCR 					; exit with CR
		;
		;		TODO check TAB( and SPC(
		;
		jsr 	CompileExpressionAt0 		; so it is something to print
		ldx 	#PCD_PRINTCMD_S
		and 	#NSSString 					; if string
		bne 	_CPOut
		ldx 	#PCD_PRINTCMD_N
_CPOut:
		txa 								; print that thing
		jsr 	WriteCodeByte		
		bra 	CommandPRINT 				; and loop round/
		;
		;		, comes here
		;
_CPTabCheckEnd:
		lda 	#PCD_PRINTCMD_TAB 			; , next tab stop
		jsr 	WriteCodeByte
		;
		;		; comes here and ,  - if end command after no CR.
		;
_CPCheckEnd:
		jsr 	GetNext 					; consume it.
		jsr 	LookNextNonSpace 			; what follows ?
		jsr 	_CPAtEnd 					; reached end
		bcc 	CommandPRINT 				; no, loop back
		rts
		;
		;		: and EOL come here.
		;
_CPExitCR:
		lda 	#13 						; code to print CR
		jsr 	PushIntegerA		
		lda 	#PCD_PRINTCMD_CHR
		jsr 	WriteCodeByte
		rts

;
;		Check ending character, is it EOS or :
;
_CPAtEnd:
		cmp 	#0
		beq 	_CPIsEnd
		cmp 	#":"
		beq 	_CPIsEnd
		clc
		rts
_CPIsEnd:
		sec
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
