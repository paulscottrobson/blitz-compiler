; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		nex.asm
;		Purpose:	NEXT compile
;		Created:	20th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										Compile NEXT command
;
;								   Creates [Reference|$FFFF] NEXT
;
; ************************************************************************************************

CommandNEXT: 
		;
		;		NEXT [variable]
		;
		jsr 	LookNextNonSpace 			; first letter of index variable, should be.
		jsr 	CharIsAlpha 				; if not alpha , error
		bcc 	_CNNoReferenceGiven
		jsr 	GetNext
		jsr 	GetReferenceTerm 			; figure out the reference.
		txa 								; reference in YA
		jsr 	PushIntegerYA 				; write it out.
		bra 	_CNParametersDone
_CNNoReferenceGiven:
		lda 	#255 						; write out -1 no
		tay
		jsr 	PushIntegerYA 				; write it out.
_CNParametersDone:
		lda 	#PCD_NEXT  					; compile FOR word.
		jsr 	WriteCodeByte

		jsr 	LookNextNonSpace 			; look for , 
		cmp 	#","
		bne 	_CNExit
		jsr 	GetNext 					; consume ,
		bra 	CommandNEXT 				; and go round.

_CNExit:
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
