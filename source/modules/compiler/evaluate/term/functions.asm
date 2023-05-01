; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		functions.asm
;		Purpose:	FNx code
;		Created:	1st May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										FN handler
;
; ************************************************************************************************

FNCompile:
		;
		;		Identify FNxx(
		;
		jsr 	GetNextNonSpace				; get variable name w/type must be array e.g. DEF FNx(a)
		jsr 	ExtractVariableName 
		cpx 	#0
		bpl 	_FNError
		;
		txa 								; convert to a function reference - bit 7:0 clear bit 7:1 set
		and 	#$7F
		tax
		tya
		ora 	#$80
		tay
		;
		;		Check to see if it is defined.
		;
		jsr 	FindVariable				; does it already exist ?
		bcc 	_FNError 					; no.
		jsr 	STRMakeOffset 				; convert to a relative address.

		cmp 	#0 							; fix up.
		bne 	_FNNoBorrow
		dey
_FNNoBorrow:
		dec 	a

		phy 								; save location of routine on stack.
		pha
		phx
		;
		;		Handle <expression>)
		;
		jsr 	CompileExpressionAt0
		jsr 	CheckNextRParen
		;
		;		Compile routine call
		;
		lda 	#PCD_CMD_GOSUB
		jsr 	WriteCodeByte
		pla
		jsr 	WriteCodeByte
		pla
		jsr 	WriteCodeByte
		pla
		jsr 	WriteCodeByte

		clc
		rts

_FNError:
		.error_value
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
