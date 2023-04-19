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
;									Fix up GOTO and GOSUB
;
; ************************************************************************************************

FixBranches:
		jsr 	HWOReset 					; back to the start of the *object* code.
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
_FBNext:		
		jsr 	MoveObjectForward 			; move forward in object code.
		bcc 	_FBLoop 					; not finished
_FBExit:		
		rts
;
;		Found GOTO/GOSUB - look it up in the line# table and fix it up.
;
_FBFixGotoGosub:

		ldy 	#2							; line number in YA
		lda 	(objPtr),y
		pha
		iny
		lda 	(objPtr),y
		tay
		pla
		jsr 	STRFindLine			 		; find where it is X:YA

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
