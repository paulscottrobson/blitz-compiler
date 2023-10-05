; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		deffn.asm
;		Purpose:	Def Fn command
;		Created:	29th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										DEF FN
;
; ************************************************************************************************

CommandDEF: 		
		;
		;		Skip to EOL.
		;
		lda 	#0 							; constant 0 (for GOTOZ)
		jsr 	PushIntegerA
		jsr 	CompileGotoEOL 				; compile skip over DEF
		;
		;	 	Check FN keyword
		;
		lda 	#C64_FN
		jsr 	CheckNextA
		;
		;		Identify FNxx(
		;
		jsr 	GetNextNonSpace				; get variable name w/type must be array e.g. DEF FNx(a)
		jsr 	ExtractVariableName 
		txa
		bpl 	_CDError
		;
		txa 								; convert to a function reference - bit 7:0 clear bit 7:1 set
		and 	#$7F
		tax
		tya
		ora 	#$80
		tay
		;
		;		Create the FNxx( record and give it the address.
		;
		jsr 	FindVariable				; does it already exist ?
		bcs 	_CDError 					; if so, that's an error.
		jsr 	CreateVariableRecord 		; create the record for it & put the data in it.
		jsr 	SetVariableRecordToCodePosition
		;
		;		Get the address to update.
		;
		jsr 	GetNextNonSpace
		jsr 	GetReferenceTerm 			; get var ref, not array
		cmp 	#0
		bmi 	_CDError 	
		sta 	defType 					; save type		
		stx 	defVariable 				; save var ref 
		sty 	defVariable+1
		and 	#NSSString 					; only numbers.
		bne 	_CDError
		jsr 	CheckNextRParen 			; check )
		lda 	#C64_EQUAL
		jsr 	CheckNextA 					; check =
		;	
		;		Now generate the code.
		;
		clc 								; if this is DEF FNxx(A), read A
		jsr 	CDReadWriteVariable
		.keyword PCD_SWAP 					; old A 2nd, new A 1st
		sec
		jsr 	CDReadWriteVariable 		; A is now updated
		jsr 	CompileExpressionAt0 		; the actual body of the function.
		.keyword PCD_SWAP 					; result 2nd, old A 1st
		sec
		jsr 	CDReadWriteVariable 		; A is now reset to its old value
		.keyword PCD_RETURN 				; return as we'll call it from a subroutine
		rts


_CDError:
		.error_syntax

CDReadWriteVariable:
		ldy 	defVariable+1 				; set up YX
		ldx 	defVariable
		lda 	defType
		jsr 	GetSetVariable
		rts
		.send code

		.section storage
defType:
		.fill 	1
defVariable:
		.fill 	2
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
