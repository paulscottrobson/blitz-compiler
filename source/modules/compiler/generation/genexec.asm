; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		genexec.asm
;		Purpose:	Generation executor
;		Created:	16th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code
	
; ************************************************************************************************
;
;						    Execute command pair at (zTemp0).
;					  	CS completed, A = type, CC = keep going.
;
; ************************************************************************************************

GeneratorExecute:
		jsr 	_GEFetchZTemp0 				; get next.
		pha 								; split into 2 nibbles
		lsr 	a
		lsr 	a
		lsr		a
		lsr 	a
		jsr 	_GEExecuteNibble 			; MSB first
		pla
		jsr 	_GEExecuteNibble 			; LSB second
		rts

; ------------------------------------------------------------------------------------------------
;										 Execute NIBL A
; ------------------------------------------------------------------------------------------------

_GEExecuteNibble:
		and 	#$0F
		asl 	a
		tax 	
		jmp 	(_GEExecuteVectors,x)

_GEExecuteVectors:
		.word 	_GEXNop 					; 0  (no operation)
		.word 	_GEXToken1 					; 1  (compile 1 byte token)
		.word 	_GEXToken2 					; 2  (compile 2 byte token)
		.word 	_GEXNop 					; 3
		.word 	_GEXNop 					; 4
		.word 	_GEXNop 					; 5
		.word 	_GEXExitNumber 				; 6  exit return ifloat32 type
		.word 	_GEXExitString 				; 7  exit return string type
		.word 	_GEXLParam 					; 8  check ( follows
		.word 	_GEXRParam 					; 9  check ) follows
		.word 	_GEXComma					; A  check , follows
		.word 	_GEXNop 					; B
		.word 	_GEXNop 					; C
		.word 	_GEXInteger 				; D  compile get an integer
		.word 	_GEXNumber 					; E  compile get any number
		.word 	_GEXString 					; F  compile get any string

; ------------------------------------------------------------------------------------------------
;									 No Operations / Unused
; ------------------------------------------------------------------------------------------------

_GEXNop:				
		clc
		rts

; ------------------------------------------------------------------------------------------------
;									Compile 1/2 byte tokens
; ------------------------------------------------------------------------------------------------

_GEXToken2:
		jsr 	_GEFetchZTemp0
		jsr 	WriteCodeByte
_GEXToken1:
		jsr 	_GEFetchZTemp0
		jsr 	WriteCodeByte
		rts

; ------------------------------------------------------------------------------------------------
;										Exit with types
; ------------------------------------------------------------------------------------------------

_GEXExitNumber:
		lda 	#NSSIFloat
		sec
		rts

_GEXExitString:
		lda 	#NSSString
		sec
		rts

; ------------------------------------------------------------------------------------------------
;								 Check various characters follow
; ------------------------------------------------------------------------------------------------

_GEXLParam:
		lda 	#"("
		bra 	_GEXCheck
_GEXRParam:
		lda 	#")"
		bra 	_GEXCheck
_GEXComma:
		lda 	#","
_GEXCheck:
		sta 	zTemp2 						; save match
		jsr 	GetNextNonSpace 			; get next skipping spaces
		cmp 	zTemp2 						; check matches.
		bne 	_GEXSyntax
		clc
		rts
_GEXSyntax:
		.error_syntax

; ------------------------------------------------------------------------------------------------
;								 		Fetch, various types.
; ------------------------------------------------------------------------------------------------

_GEXInteger: 	
		jsr 	_GEXCompileExpression 		; compile expression
		cmp  	#NSSIFloat+NSSInteger 		; check integer value.
		bne 	_GEXType 	
		clc
		rts

_GEXNumber: 	
		jsr 	_GEXCompileExpression 		; compile expression
		and 	#NSSTypeMask
		cmp  	#NSSIFloat
		bne 	_GEXType 	
		clc
		rts

_GEXString: 	
		jsr 	_GEXCompileExpression 		; compile expression
		and 	#NSSTypeMask
		cmp  	#NSSString
		bne 	_GEXType 	
		clc
		rts

_GEXType:
		.error_type

_GEXCompileExpression:
		ldx 	zTemp0 						; push generation exec on to stack for reentrancy
		phx
		ldx 	zTemp0+1
		phx
		jsr 	CompileExpressionAt0 		; compile expression.
		plx 								; recover generation exec
		stx 	zTemp0+1
		plx
		stx 	zTemp0
		rts		

; ------------------------------------------------------------------------------------------------
;										Get the next byte.
; ------------------------------------------------------------------------------------------------

_GEFetchZTemp0:
		lda 	(zTemp0)
		inc 	zTemp0
		bne 	_GEFZ0Skip
		inc 	zTemp0+1
_GEFZ0Skip:
		rts		
		.send  code		

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
