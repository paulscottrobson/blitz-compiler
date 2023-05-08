; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		fixbranches.asm
;		Purpose:	Fix up GOTO and GOSUB commands
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Fix up GOTO and GOSUB, and VARSPACE
;
; ************************************************************************************************

FixBranches:
		jsr 	OUTPUTRewind 				; back to the start of the *object* code.
_FBLoop:
		lda 	(objPtr) 					; get the next one.
		cmp 	#PCD_CMD_GOTO 				; found GOTO or GOSUB, patch up.
		beq 	_FBFixGotoGosub
		cmp 	#PCD_CMD_GOSUB
		beq 	_FBFixGotoGosub
		cmp 	#PCD_CMD_GOTOCMD_NZ 		; patch the conditional GOTOs for Z/NZ TOS.
		beq 	_FBFixGotoGosub
		cmp 	#PCD_CMD_GOTOCMD_Z 
		beq 	_FBFixGotoGosub
		cmp 	#PCD_CMD_VARSPACE
		beq 	_FBFixVarSpace
_FBNext:		
		jsr 	MoveObjectForward 			; move forward in object code.
		bcc 	_FBLoop 					; not finished
_FBExit:		
		rts
;
;		Found GOTO/GOSUB - look it up in the line# table and fix it up.
;
_FBFixGotoGosub:
		ldy 	#1 							; if page is currently $FF
		lda 	(objPtr),y 					; then patch else leave.
		cmp 	#$FF
		bne 	_FBNext

		ldy 	#2							; line number in YA
		lda 	(objPtr),y
		pha
		iny
		lda 	(objPtr),y
		tay
		pla
		jsr 	STRFindLine			 		; find where it is X:YA
		bcc 	_FBFFound 					; not found, so must be >
		pha
		lda 	(objPtr) 					; which is a fail if not CMD_GOTOCMD_Z
		cmp 	#PCD_CMD_GOTOCMD_Z
		bne 	_FBFFail
		pla

_FBFFound:		
		jsr 	STRMakeOffset 				; make it an offset from X:YA
		
		phy	 								; patch the GOTO/GOSUB
		pha

		ldy 	#1
		txa
		sta 	(objPtr),y

		iny
		pla
		sta 	(objPtr),y

		iny
		pla
		sta 	(objPtr),y
		bra 	_FBNext

_FBFFail:
		ldy 	#2
		lda 	(objPtr),y
		sta 	currentLineNumber
		iny
		lda 	(objPtr),y
		sta 	currentLineNumber+1
		.error_line

;
;		Found VarSpace, fix up with free space after variables
;
_FBFixVarSpace:
		ldy 	#1
		lda 	freeVariableMemory
		sta 	(objPtr),y
		iny
		lda 	freeVariableMemory+1
		sta 	(objPtr),y
		bra 	_FBNext

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
