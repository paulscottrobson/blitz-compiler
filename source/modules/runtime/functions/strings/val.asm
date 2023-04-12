; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		val.asm
;		Purpose:	String to Integer/Float#
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section	code

; ************************************************************************************************
;
; 											Val(String)
;
; ************************************************************************************************

ValUnary: ;; [val]	
		.entercmd 							; restore stack pos
		lda 	NSMantissa0,x
		sta 	zTemp0
		lda 	NSMantissa1,x
		sta 	zTemp0+1
		jsr 	ValEvaluateZTemp0
		bcs 	_VUError 					; couldn't convert
		.exitcmd
_VUError:
		.error_value



; ************************************************************************************************
;
;								Evaluate value at zTemp0 into X.
;
; ************************************************************************************************

ValEvaluateZTemp0:
		phy
		lda 	(zTemp0) 					; check not empty string
		beq 	_VMCFail2 		
		ldy 	#0 							; start position		
_VMCSpaces:
		iny 								; skip leading spaces
		lda 	(zTemp0),y		
		cmp 	#" "		
		beq 	_VMCSpaces
		pha 								; save first character
		cmp 	#"-"		 				; is it - ?
		bne 	_VMCStart
		iny 								; skip over - if so.
		;
		;		Evaluation loop
		;
_VMCStart:		
		sec 								; initialise first time round.
_VMCNext:
		tya 								; reached end of string
		dec 	a
		eor 	(zTemp0) 					; compare length preserve carry.
		beq 	_VMCSuccess 				; successful.

		lda 	(zTemp0),y 					; encode a number.
		iny
		jsr 	FloatEncode 				; send it to the number-builder
		bcc 	_VMCFail 					; if failed, give up.
		clc 								; next time round, countinue
		bra 	_VMCNext

_VMCFail:
		pla
_VMCFail2:		
		ply
		sec
		rts

_VMCSuccess:
		lda 	#0 							; construct final
		jsr 	FloatEncode 				; by sending a duff value.
		pla 								; if it was -ve
		cmp 	#"-"
		bne 	_VMCNotNegative
		jsr		FloatNegate 				; negate it.
_VMCNotNegative:		
		ply
		clc
		rts		

		.send	code

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
