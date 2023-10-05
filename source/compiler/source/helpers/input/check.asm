; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		check.asm
;		Purpose:	Token presence check
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

	
; ************************************************************************************************
;
;									Check Next char various
;
; ************************************************************************************************

CheckNextComma:
		lda	 	#","
		bra 	CheckNextA
CheckNextRParen:
		lda	 	#")"
		bra 	CheckNextA
CheckNextLParen:
		lda 	#"("
CheckNextA:
		sta 	checkCharacter 				; save test character
_CNALoop:		
		jsr 	GetNextNonSpace 			; get next skipping spaces.
		cmp 	checkCharacter 				; matches ?
		beq 	_CNAExit
		.error_syntax
_CNAExit:		
		rts
		.send code

		.section storage
checkCharacter:
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
