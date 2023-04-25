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
		jsr 	GetNextNonSpace 			; first char of identifier
		jsr 	CharIsAlpha 				; check A-Z
		bcc 	_CRSyntax
		jsr 	GetReferenceTerm 			; get the variable.
		pha 								; save type.

		and 	#NSSTypeMask 				; is it a string ?
		cmp 	#NSSString
		beq 	_CRString
		lda 	#PCD_READ 					; output read
		bra 	_CRHaveType
_CRString:		
		lda 	#PCD_READDOLLAR 			; output read$
_CRHaveType:		
		jsr 	WriteCodeByte 				; so we have one typed data item.
		pla 								; restore type
		sec  								; write update code.
		jsr 	GetSetVariable
		jsr 	LookNextNonSpace 			; , follows ?
		cmp 	#","
		bne 	_CRExit 					; if not, end of READ.
		jsr 	GetNext 					; consume comma
		bra 	CommandREAD 				; keep going
_CRExit:		
		rts		
_CRSyntax:
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
