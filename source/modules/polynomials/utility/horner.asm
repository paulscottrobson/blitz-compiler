; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		horner.asm
;		Purpose:	Calculate Horner Polynomial, table at YA
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									Calculates Horner Polynomial
;
; ************************************************************************************************

CalculateHornerPolynomial:
		sta 	zTemp0 						; save poly data from YA
		sty 	zTemp0+1
		stz 	coefficientCount 			; zero the count.
		stx 	xValueSlot 					; save xValue slot.

		inx 								; set the count to zero.
		jsr 	FloatSetZero
		;
		;		Horner evaluation loop (see coremaths.py)
		;
_CHPLoop:	
		txa 								; copy X-1 to X+1
		tay
		dex
		iny
		jsr 	CopyFloatXY 				; e.g. stack is <current> <x>
		inx
		inx
		jsr 	FloatMultiply 				; times current by X
		inx
		jsr 	GetCoefficient 				; coefficient into X+1
		jsr 	FloatAdd 					; and add
		;
		inc 	coefficientCount
		lda 	coefficientCount
		cmp 	(zTemp0)
		bne 	_CHPLoop
		rts

; ************************************************************************************************
;
;									 Completion
;
; ************************************************************************************************

CompletePolynomial:
		jsr 	FloatMultiply
		inx 								; get the last value
		jsr 	GetCoefficient 			
		jsr 	FloatAdd 					; and add it
		rts

; ************************************************************************************************
;
;								Copy entry X to entry Y
;
; ************************************************************************************************

CopyFloatXY:
		lda 	NSExponent,x
		sta 	NSExponent,y
		lda 	NSStatus,x
		sta 	NSStatus,y

		lda 	NSMantissa0,x
		sta 	NSMantissa0,y
		lda 	NSMantissa1,x
		sta 	NSMantissa1,y
		lda 	NSMantissa2,x
		sta 	NSMantissa2,y
		lda 	NSMantissa3,x
		sta 	NSMantissa3,y
		rts

; ************************************************************************************************
;
;						Get current coefficient to stack,X
;
; ************************************************************************************************

GetCoefficient:		
		phy
		lda 	coefficientCount 			; 5 per block
		asl 	a
		asl 	a
		sec 								; +1 for count
		adc 	coefficientCount
		tay

		lda 	(zTemp0),y 					; copy mantissa
		sta 	NSMantissa0,x
		iny
		lda 	(zTemp0),y
		sta 	NSMantissa1,x
		iny
		lda 	(zTemp0),y
		sta 	NSMantissa2,x
		iny
		lda 	(zTemp0),y
		pha
		and 	#$7F 						; clear sign bit.
		sta 	NSMantissa3,x
		iny
		pla
		and 	#$80
		sta 	NSStatus,x 					; put in status 
		;
		lda 	(zTemp0),y
		sta 	NSExponent,x
		ply
		rts

		.send 	code

		.section storage
coefficientCount:
		.fill 	1
xValueSlot:
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
