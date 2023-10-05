; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		gensupport.asm
;		Purpose:	Support functions for generation
;		Created:	16th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;		MID$ has a support function because it has different numbers of parameters.
;		e.g. MID$(a$,b,c) or MID$(a$,b)
;
; ************************************************************************************************

OptionalParameterCompile:
		jsr 	LookNextNonSpace 			; what follows.
		;
		cmp 	#","
		bne 	_MidDefault
		jsr 	GetNext 					; consume ,
		jsr 	CompileExpressionAt0
		and 	#NSSTypeMask
		cmp 	#NSSIFloat
		bne 	MidFailType
		bra 	_MidComplete
_MidDefault:
		lda 	#255 						; default of 255
		jsr 	PushIntegerA
_MidComplete:
		clc
		rts

MidFailType:
		.error_type

; ************************************************************************************************
;
;		NOT has a support function as its single expression parameter is done part way
;		up precedence
;
; ************************************************************************************************

NotUnaryCompile:
											; precedence of comparators
		lda 	PrecedenceTable+C64_EQUAL-C64_PLUS		
		jsr 	CompileExpressionAtA 		; evaluate at that level
		and 	#NSSTypeMask 				; check compile returns number.
		cmp 	#NSSIFloat
		bne 	MidFailType
		lda 	#PCD_NOT 					; and NOT it.
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
