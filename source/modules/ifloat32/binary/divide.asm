; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		divide.asm
;		Purpose:	32x32 bit integer division (2 variants)
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									Integer Division
;
; ************************************************************************************************

DivideInt32:
		jsr 	FloatIntegerPart 			; make both integers	
		dex
		jsr 	FloatIntegerPart
		jsr 	Int32Divide 				; divide
		jsr 	NSMCopyPlusTwoToZero 		; copy result
		jsr 	FloatCalculateSign 			; calculate result sign
		clc
		rts

NSMCopyPlusTwoToZero:		
		lda 	NSMantissa0+2,x 			; copy result down from +2
		sta 	NSMantissa0,x
		lda 	NSMantissa1+2,x
		sta 	NSMantissa1,x
		lda 	NSMantissa2+2,x
		sta 	NSMantissa2,x
		lda 	NSMantissa3+2,x
		sta 	NSMantissa3,x
		rts
		
; ************************************************************************************************
;
;		32 bit unsigned division of FPA Mantissa A by FPA Mantissa B, 32 bit result.
;									(see divide.py)
;
; ************************************************************************************************

Int32Divide:
		pha 								; save AXY
		phy
		jsr 	FloatShiftUpTwo 			; copy S[X] to S[X+2]
		jsr 	FloatSetZeroMantissaOnly 	; set S[X] to zero

		ldy 	#32 						; loop 32 times
_I32DivideLoop:
		inx
		inx
		jsr 	FloatShiftLeft				; shift S[X+2] S[X] left as a 64 bit element
		dex
		dex
		jsr 	FloatRotateLeft
		;		
		jsr 	FloatDivideCheck 			; check if subtract possible
		bcc 	_I32DivideNoCarryIn
		inc 	NSMantissa0+2,x 			; if possible, set Mantissa0[X+2].0
_I32DivideNoCarryIn:
		dey 								; loop round till division completed.
		bne 	_I32DivideLoop

		ply 								; restore AXY and exit
		pla
		clc
		rts

; ************************************************************************************************
;
;		Shifted Division used in Floating Point Divide - does (a << 30) // b
;									(see divide.py)
;
; ************************************************************************************************

Int32ShiftDivide:
		pha 								; save AY
		phy

		inx 								; clear S[X+2]
		inx
		jsr 	FloatSetZero
		dex
		dex

		ldy 	#31 						; loop 31 times.
_I32SDLoop:
		jsr 	FloatDivideCheck 			; check if subtract possible
		inx
		inx
		jsr 	FloatRotateLeft				; shift 64 bit FPA left, rotating carry in
		dex
		dex
		jsr 	FloatRotateLeft
		dey 	 							; do 31 times
		bne 	_I32SDLoop
		ply 								; restore AY and exit
		pla
		rts

; ************************************************************************************************
;
;							Do the division - check subtraction code
;
;			If can subtract FPB from FPA.Upper, do so, return carry set if was subtracted
;			Common code to both divisions.
;
; ************************************************************************************************

FloatDivideCheck:
		jsr 	FloatSubTopTwoStack 		; subtract Stack[X+1] from Stack[X+0]
		bcs 	_DCSExit 					; if carry set, then could do, exit
		jsr 	FloatAddTopTwoStack 		; add it back in
		clc 								; and return False
_DCSExit:
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
