; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		altbase.asm
;		Purpose:	Handle other bases
;		Created:	16th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						Compile a 16 bit other base constant. Type marker in A
;
; ************************************************************************************************

InlineNonDecimal:
		ldx 	#2 							; get size in X
		cmp 	#"%" 						
		beq 	_INDBinary
		ldx 	#16
_INDBinary:									
		sta 	zTemp1 						; size => zTemp1
		stz 	zTemp1+1 					; count => zTemp1+1, at least 1 !
		stz 	zTemp0 						; zero result
		stz 	zTemp0+1
_INDLoop:
		jsr 	LookNext 					; check next character
		jsr 	ConvertHexStyle		 		; convert into range 0-35 for 0-9A-Z
		bcc		_INDDone 					; didn't convert
		cmp 	zTemp1 						; size too large ?
		bcs 	_INDDone
		;
		jsr 	_INDShift 					; x 2 or x 16
		cpx 	#2
		beq 	_INDNotHex
		jsr 	_INDShift
		jsr 	_INDShift
		jsr 	_INDShift
_INDNotHex:
		ora 	zTemp0 						; or digit into result
		sta 	zTemp0 		
		jsr 	GetNext 					; consume
		inc 	zTemp1+1 					; bump count
		bra 	_INDLoop
		;
_INDDone:
		lda 	zTemp1+1 					; done at least 1 ?
		beq 	_INDError
		ldy 	zTemp0+1 					; push constant
		lda 	zTemp0	
		jsr 	PushIntegerYA
		rts

_INDError:
		.error_syntax
		
_INDShift:
		asl 	zTemp0
		rol 	zTemp0+1
		rts		
		.send code

		.section storage
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
