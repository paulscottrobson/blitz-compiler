; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		tostring.asm
;		Purpose:	Convert number to string
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						Convert FPA to String in ConversionBuffer
;
; ************************************************************************************************

FloatToString:
		phx
		phy 								; save code position
		sta 	decimalPlaces	 			; save number of DPs.
		stz 	dbOffset 					; offset into decimal buffer = start.

		lda 	NSStatus,x  				; is it -ve.
		bpl 	_CNTSNotNegative
		and 	#$7F 						; make +ve
		sta 	NSStatus,x
		lda 	#"-"
		bra 	_CNTMain
_CNTSNotNegative:
		lda 	#" "
_CNTMain:
		jsr 	WriteDecimalBuffer
		lda 	NSExponent,x 				; check if decimal
		beq 	_CNTSNotFloat

		inx 								; round up so we don't get too many 6.999999
		lda 	#1
		jsr 	FloatSetByte		
		lda		NSExponent-1,x
		sta 	NSExponent,x
		jsr 	FloatAdd
_CNTSNotFloat:

		jsr 	MakePlusTwoString 			; do the integer part.
		jsr 	FloatFractionalPart 		; get the fractional part
		jsr 	FloatNormalise					; normalise , exit if zero
		beq 	_CNTSExit
		lda 	#"."
		jsr 	WriteDecimalBuffer 			; write decimal place
_CNTSDecimal:
		dec 	decimalPlaces 				; done all the decimals
		bmi 	_CNTSExit
		inx 								; x 10.0
		lda 	#10
		jsr 	FloatSetByte
		jsr 	FloatMultiply
		jsr 	MakePlusTwoString 			; put the integer e.g. next digit out.
		jsr 	FloatFractionalPart 		; get the fractional part
		jsr 	FloatNormalise 				; normalise it.
		;
		lda 	NSExponent,x 				; gone to zero, exit.
		cmp 	#$D0 						; very small remainder, so don't bother.
		bcs 	_CNTSDecimal 				; keep going.
_CNTSExit:
		ply
		plx
		rts

; ************************************************************************************************
;
;		Make S[X] and integer, convert it to a string, and copy it to the decimal buffer
;		
; ************************************************************************************************

MakePlusTwoString:
		phx
		jsr 	FloatShiftUpTwo 			; copy S[X] to S[X+2] - we will use S[X+2] for the intege part.		
		inx 								; access it
		inx
		jsr 	FloatIntegerPart 			; make it an integer
		lda 	#10 						; convert it in base 10
		jsr 	ConvertInt32 
		ldx	 	#0 							; write that to the decimal buffer.
_MPTSCopy:
		lda 	numberBuffer,x
		jsr 	WriteDecimalBuffer
		inx		
		lda 	numberBuffer,x
		bne 	_MPTSCopy
		plx
		rts

; ************************************************************************************************
;
;									Write A to Decimal Buffer
;		
; ************************************************************************************************

WriteDecimalBuffer:
		phx
		ldx 	dbOffset
		sta 	decimalBuffer,x
		stz 	decimalBuffer+1,x
		inc 	dbOffset
		plx
		rts

		.send 	code
		
		.section storage

decimalPlaces:
		.fill 	1
dbOffset:
		.fill 	1				
decimalBuffer:
		.fill 	32
		
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
