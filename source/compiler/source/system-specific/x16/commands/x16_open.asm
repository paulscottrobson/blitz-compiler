; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_open.asm
;		Purpose:	OPEN command
;		Created:	2nd May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						OPEN command - first 2 are already on the stack.
;
;		supports 	OPEN #,#
;					OPEN #,#,#
;					OPEN #,#,$
;					OPEN #,#,#,$
;
;		Adds dummies so whatever there are three integers and a string compiled.
;
; ************************************************************************************************

CommandOPEN:
		jsr 	LookNextNonSpace 			; followed by a , ?
		cmp 	#","
		bne 	_COTwoDefaults
		jsr 	GetNext 					; consume comma
		jsr 	CompileExpressionAt0 		; what follows could be text or number.
		and 	#NSSString 					; if a number want a string to follow
		beq 	_COThreeIntegers
		;
		;		n,n,$
		;
		lda 	#0		 					; so we have n,n,$,0 so swap !
		jsr 	PushIntegerA
		.keyword PCD_SWAP
		rts
		;
		;		Two numeric values, add default 0 and empty string.
		;
_COTwoDefaults:
		lda 	#0
		jsr 	PushIntegerA
_COCompileNullString:
		.keyword PCD_CMD_STRING
		lda 	#0
		jsr 	WriteCodeByte
		jsr 	WriteCodeByte
		rts		
		;
		;		Full constants e.g. 1,8,2 possibly no file name
		;
_COThreeIntegers:		
		jsr 	LookNextNonSpace 			; is there a , 
		cmp 	#","
		bne 	_COCompileNullString 		; if not it is n,n,n so default filename.
		jsr 	GetNext
		jsr 	CompileExpressionAt0 		; should be a filename
		and 	#NSSString
		beq 	_COType
		rts
_COType:
		.error_type		
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
