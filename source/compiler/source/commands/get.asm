; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		get.asm
;		Purpose:	Get from input
;		Created:	21st April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;									Get input (also GET#)
;
; ************************************************************************************************

CommandGET:
		jsr 	LookNextNonSpace 			; # follows ?
		cmp 	#"#"
		bne 	CommandGetBody
		;
		jsr 	GetNext 					; consume #
		jsr 	ChannelPrefix 				; do it as GET#
		jsr 	CommandGetBody
		jsr 	ChannelPostfix
		rts

CommandGetBody:
		jsr 	GetNextNonSpace 			; get the first character
		jsr 	GetReferenceTerm 			; identify variable to assign to
		pha
		and 	#NSSTypeMask 				; check if it is a string
		cmp 	#NSSString
		bne 	_CGType

		lda 	#PCD_GET 					; compile GET
		jsr 	WriteCodeByte
		sec
		pla
		jsr		GetSetVariable
		rts

_CGType:
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
