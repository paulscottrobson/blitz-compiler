; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		getname.asm
;		Purpose:	Get variable name
;		Created:	25th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;				  Extract a reference object name (variable, array, function)
;					  to XY. Error if failed. On entry A contains first
;
; ************************************************************************************************

		.section code

ExtractVariableName:
		jsr 	CharIsAlpha
		bcc 	_IVSyntax
		;
		;		One or two character variable ?
		;
		and 	#31 						; reduce first character to 5 bits
		sta 	zTemp1 						; we'll build it in zTemp1
		stz 	zTemp1+1
		;
		jsr 	LookNext 					; is there a second character ?
		jsr 	CharIsAlpha  				; must be alphanumeric 
		bcs 	_IVHasSecond
		jsr 	CharIsDigit
		bcc 	_IVCheckType
_IVHasSecond:
		and 	#63 						; 6 bit ASCII.
		sta 	zTemp1+1
_IVGetNextCheck:		
		jsr 	GetNext 					; consume it
		;
		;		Check for % $ postfix.
		;
_IVCheckType:
		jsr 	LookNext					; check if string follows.
		jsr 	CharIsAlpha
		bcs 	_IVGetNextCheck
		jsr 	CharIsDigit
		bcs 	_IVGetNextCheck

		ldx 	#NSSString
		cmp 	#"$"
		beq 	_IVHasType
		ldx 	#NSSIInt16 					; check if short int follows e.g. 16 bit
		cmp 	#"%"
		bne 	_IVCheckArray
_IVHasType:
		txa 								; Or X into zTemp1
		ora 	zTemp1
		sta 	zTemp1		
		jsr 	GetNext 					; consume it
		;
		;		Check for ( postfix
		;
_IVCheckArray:
		jsr 	LookNext 					; check if array follows
		cmp 	#"("
		bne 	_IVNotArray
		lda 	zTemp1 						; set array bit
		ora 	#NSSArray
		sta 	zTemp1		
		jsr 	GetNext 					; consume it
_IVNotArray:		
		ldx 	zTemp1
		ldy 	zTemp1+1
		rts

_IVSyntax:
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
