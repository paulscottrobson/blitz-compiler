; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		let.asm
;		Purpose:	Assignment statement
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										Assignment statement
;
; ************************************************************************************************

CommandLET:
		jsr 	GetNextNonSpace 			; get the first character
CommandLETHaveFirst:
		jsr 	GetReferenceTerm 			; identify variable to assign to
		phx 								; save target on the stack.
		phy
		pha
		lda 	#C64_EQUAL 					; check next is =
		jsr 	CheckNextA
		jsr 	CompileExpressionAt0 		; evaluate the RHS.

		sta 	zTemp0 						; save type returned
		pla 								; get type of assignment
		pha
		eor 	zTemp0 						; compare using EOR
		and 	#NSSTypeMask 				; so we can mask type as we only need n/s
		bne 	_CLType

		pla 								; restore and compile save code
		ply
		plx

		cpy 	#$C0 						; is it TI$ = "xxxxx"
		beq 	_CLTIString
		sec
		jsr		GetSetVariable
		rts

_CLTIString:
		.keyword PCD_TIDOLLARCMD_WRITE
		rts
		
_CLType:
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
