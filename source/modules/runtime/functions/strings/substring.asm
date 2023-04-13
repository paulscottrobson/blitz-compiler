; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		substring.asm
;		Purpose:	Left$/Mid$/Right$ - put here as Left/Right are same code.
;		Created:	3rd April 2023
;		Reviewed: 	27th November 2022
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								<string> <size> Left$
;
; ************************************************************************************************

Unary_Left: 	;; [left$]
		.entercmd
		phy
		clc 								; only one parameter
		jsr 	GetInteger8Bit 				; push the length of the string.
		pha
		dex
		lda 	#0 							; push the start position.
		pha
		jsr 	UnarySStringToZTemp0
		bra 	SubstringMain 				; stack now points to the string to slice.

; ************************************************************************************************
;
;								<string> <size> Right$
;
; ************************************************************************************************

Unary_Right: 	;; [right$]
		.entercmd
		phy
		lda 	#255 						; push 255, we want all the string.		
		;
		jsr 	GetInteger8Bit 				; push the right length of the string.
		pha
		dex
		jsr 	UnarySStringToZTemp0

		pla 								; this is the right requirement
		sec
		eor 	#$FF
		adc 	(zTemp0)
		bcs 	_URHaveCount
		lda 	#0 							; overflow, start from 0
_URHaveCount:		
		ldy 	#255 						; whole string
		phy		
		pha 								; start position
		bra 	SubstringMain

; ************************************************************************************************
;
;								<string> <start> <size> Mid$
;
; ************************************************************************************************

Unary_Mid: 	;; [mid$]
		.entercmd
		phy
		jsr 	GetInteger8Bit 				; push the length of the string required.
		pha
		dex
		jsr 	GetInteger8Bit 				; put the start position.
		beq 	_UMError
		dec 	a
		pha
		dex
		jsr 	UnarySStringToZTemp0
		bra 	SubstringMain 				; stack now points to the string to slice.
_UMError:		
		.error_range

UnarySStringToZTemp0:
		lda 	NSMantissa0,x
		sta 	zTemp0
		lda 	NSMantissa1,x
		sta 	zTemp0+1
		rts

; ************************************************************************************************
;
;				String address in zTemp0. TOS is the start offset. TOS2 is the count.
;
; ************************************************************************************************

SubstringMain:		
		pla 								; get the start offset
		ply 								; get the count to do.
		cmp 	(zTemp0) 					; if start >= length then return NULL.
		bcs 	_SSReturnNull
		;
		sta 	zTemp1 						; save start position.
		sty 	zTemp1+1 					; save count
		;
		clc 
		adc 	zTemp1+1 					; this is the end position.
		bcs 	_SMTruncateToEnd 			; if overflow, limit to length-start.
		;
		cmp 	(zTemp0) 					; ok if limit is <= length.
		beq 	_SMIsOkay
		bcc 	_SMIsOkay
_SMTruncateToEnd:
		lda 	(zTemp0) 					; end position is length.
_SMIsOkay:									; zTemp1 is start offset, zTemp2 is end.
		sta 	zTemp1+1
		;
		sec		 							; work out size
		lda 	zTemp1+1 					
		sbc 	zTemp1
		beq 	_SSReturnNull 				; if size = 0 then return empty string.
		jsr 	StringAllocTemp 			; zsTemp & mantissa = the new string.
		;
		ldy 	zTemp1 						; start
_SMCopy:
		cpy 	zTemp1+1 					; exit if reached end
		beq 	_SMExit

		iny 								; bump and
		lda 	(zTemp0),y 					; get character (prefix)
		phy
		pha
		lda 	(zsTemp) 					; bump length => Y
		inc 	a
		tay
		sta 	(zsTemp)
		pla 								; write character out
		sta 	(zsTemp),y 				
		ply 								; restore Y
		bra 	_SMCopy
_SMExit:
		ply
		.exitcmd

_SSReturnNull:
		lda 	#SSRNull & $FF 				; set up mantissa
		sta 	NSMantissa0,x
		lda 	#SSRNull >> 8
		sta 	NSMantissa1,x
		stz 	NSMantissa2,x
		stz 	NSMantissa3,x
		lda 	#NSSString
		sta 	NSStatus,x
		bra 	_SMExit

SSRNull:
		.word 	0		



		.send 	code
		
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
