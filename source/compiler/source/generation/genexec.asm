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
		bcs 	_GEHaveCompleted
		jsr 	_GEExecuteNibble 			; LSB second
_GEHaveCompleted:		
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
		.word 	_GEXExecute 				; 3  (run arbitrary code)
		.word 	_GEXChannelExec 			; 4  (run arbitrary code with possible channel redirection)
		.word 	_GEXNop 					; 5
		.word 	_GEXExitNumber 				; 6  exit return ifloat32 type
		.word 	_GEXExitString 				; 7  exit return string type
		.word 	_GEXLParam 					; 8  check ( follows
		.word 	_GEXRParam 					; 9  check ) follows
		.word 	_GEXComma					; A  check , follows
		.word 	_GEXNop 					; B
		.word 	_GEXNop 					; C
		.word 	_GEXNop 					; D  
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

_GEXNumber: 	
		jsr 	GEXCompileExpression 		; compile expression
		and 	#NSSTypeMask
		cmp  	#NSSIFloat
		bne 	_GEXType 	
		clc
		rts

_GEXString: 	
		jsr 	GEXCompileExpression 		; compile expression
		and 	#NSSTypeMask
		cmp  	#NSSString
		bne 	_GEXType 	
		clc
		rts

_GEXType:
		.error_type

; ------------------------------------------------------------------------------------------------
;							Execute 6502 code with Channel Redirect
; ------------------------------------------------------------------------------------------------

_GEXChannelExec:
		jsr 	ChannelPrefix 				; set up default
		jsr 	_GEXExecute
		php
		jsr 	ChannelPostfix 				; replace default.
		plp
		rts
		.debug

; ------------------------------------------------------------------------------------------------
;										Execute 6502 code
; ------------------------------------------------------------------------------------------------

_GEXExecute:
		jsr 	_GEFetchZTemp0 				; get vector		
		sta 	zTemp2 		
		jsr 	_GEFetchZTemp0
		sta 	zTemp2+1 		

		ldx 	zTemp0 						; push generation exec on to stack for reentrancy
		phx
		ldx 	zTemp0+1
		phx

		jsr 	_GECallZTemp2 				; execute code

		plx 								; recover generation exec
		stx 	zTemp0+1
		plx
		stx 	zTemp0
		rts		

_GECallZTemp2:
		jmp 	(zTemp2)		

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

; ------------------------------------------------------------------------------------------------
;								Compile expression preserve state
; ------------------------------------------------------------------------------------------------

GEXCompileExpression:
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

; ************************************************************************************************
;
;									Channel Prefix code.
;
; ************************************************************************************************

ChannelPrefix:
		lda 	#PCD_GETCHANNEL				; set channel onto stack
		jsr 	WriteCodeByte
		jsr 	GEXCompileExpression 		; channel #
		and 	#NSSTypeMask
		cmp 	#NSSIFloat
		bne 	_CPXType
		jsr 	CheckNextComma 				; check , follows.
		lda 	#PCD_SETCHANNEL				; set channel
		jsr 	WriteCodeByte
		rts
_CPXType:
		.error_type

; ************************************************************************************************
;
;									Channel Prefix code.
;
; ************************************************************************************************

ChannelPostfix:
		lda 	#PCD_SETCHANNEL				; set channel from TOS.
		jsr 	WriteCodeByte
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
