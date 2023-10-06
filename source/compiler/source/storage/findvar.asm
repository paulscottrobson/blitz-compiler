; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		findvar.asm
;		Purpose:	Find variable.
;		Created:	25th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;		  XY contains a variable name. Find it, returning address in YXA and CS if found
;		
;					  Returns $8000 > for special variables TI ($8000) TI$($C001)
;
; ************************************************************************************************

		.section code

FindVariable:
		stx 	zTemp1 						; save name.
		sty 	zTemp1+1
		;
		;		Check for TI $1409 and TI$ $5409 which return 6 and 8 as addresses.
		;
_IVCheckSpecial:		
		cpy 	#$09	 					; both end $09 e.g. I
		bne 	_IVStandard
		cpx 	#$14 						; TI is $14
		beq 	_IVTIFloat
		cpx 	#$54 						; TI$ is $54
		bne 	_IVStandard
		ldy 	#$C0 						; TI$ returns string $C001
		ldx 	#$01
		lda 	#NSSString
		sec
		rts
_IVTIFloat: 								; TI returns ifloat at $8000
		ldy 	#$80
		ldx 	#$00
		lda 	#0
		sec
		rts
		;
		;		Not TI or TI$
		;
_IVStandard:
		lda 	compilerStartHigh			; start scanning from here.
		sta 	zTemp0+1
		stz 	zTemp0

		.storage_access
_IVCheckLoop:
		lda 	(zTemp0) 					; finished ?
		beq  	_IVNotFound 				; if so, return with CC.
		;
		ldy 	#1 							; match ?
		lda 	(zTemp0),y
		cmp 	zTemp1
		bne	 	_IVNext
		iny
		lda 	(zTemp0),y
		cmp 	zTemp1+1
		beq 	_IVFound
_IVNext: 									; go to next
		clc
		lda 	zTemp0
		adc 	(zTemp0)
		sta 	zTemp0
		bcc 	_IVCheckLoop
		inc 	zTemp0+1
		bra 	_IVCheckLoop
		;
_IVFound:		
		ldy 	#3 							; get address into YX
		lda 	(zTemp0),y
		tax
		iny
		lda 	(zTemp0),y
		pha
		iny
		lda 	(zTemp0),y
		ply
		.storage_release
		sec
		rts

_IVNotFound:
		.storage_release
		ldx 	zTemp1 						; get variable name back
		ldy 	zTemp1+1
		clc
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
