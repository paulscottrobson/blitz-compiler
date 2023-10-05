; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		read.asm
;		Purpose:	Compile READ Statements
;		Created:	22nd April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										Compile a READ
;
; ************************************************************************************************

CommandREAD:
		ldx 	#PCD_READ
		ldy 	#PCD_READDOLLAR
;
;		Code shared by READ and INPUT
;
CommandReadInputCommon:
		stx 	numberPCode
		sty 	stringPCode
_CRLoop:				
		jsr 	GetNextNonSpace 			; first char of identifier
		jsr 	CharIsAlpha 				; check A-Z
		bcc 	_CRSyntax
		jsr 	GetReferenceTerm 			; get the variable.
		pha 								; save type.

		and 	#NSSTypeMask 				; is it a string ?
		cmp 	#NSSString
		beq 	_CRString
		lda 	numberPCode 				; output read/input
		bra 	_CRHaveType
_CRString:		
		lda 	stringPCode					; output read$/input$
_CRHaveType:		
		jsr 	WriteCodeByte 				; so we have one typed data item.
		pla 								; restore type
		sec  								; write update code.
		jsr 	GetSetVariable
		jsr 	LookNextNonSpace 			; , follows ?
		cmp 	#","
		bne 	_CRExit 					; if not, end of READ.
		jsr 	GetNext 					; consume comma
		bra 	_CRLoop 					; keep going
_CRExit:		
		rts		
_CRSyntax:
		.error_syntax

		.send code

		.section storage
numberPCode:	
		.fill 	1
stringPCode:
		.fill 	1
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
