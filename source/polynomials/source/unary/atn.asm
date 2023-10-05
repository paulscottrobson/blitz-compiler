; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		atn.asm
;		Purpose:	ATN function.
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									calculate ATN(x)
;
; ************************************************************************************************

FloatArcTan:
		jsr 	FloatNormalise 					; normalise x

		lda 	NSStatus,x 						; save sign, make absolute
		pha
		stz 	NSStatus,x

		lda 	NSExponent,x 					; $40000000 ^ $E2 is 1.0
		cmp 	#$E2
		bcc 	_UANoFixup

		txa 									; value in +1
		tay
		iny
		jsr 	CopyFloatXY
		lda 	#1 								; 1.0 in +0
		jsr 	FloatSetByte
		inx
		jsr 	FloatDivide
		bcs 	_FATError

		jsr 	CoreAtn 						; calculate the root
		jsr 	CompletePolynomial
		jsr 	FloatNegate 					; make -ve

		.pushfloat Const_PiDiv2 				; add Pi/2
		jsr 	FloatAdd
		bra 	_UAComplete

_UANoFixup:		
		jsr 	CoreAtn
		jsr 	CompletePolynomial
_UAComplete:

		pla 									; apply the result.
		eor 	NSStatus,x
		sta 	NSStatus,x
		clc
		rts

_FATError:
		pla
		sec
		rts

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
