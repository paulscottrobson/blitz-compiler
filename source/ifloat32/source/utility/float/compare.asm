; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		compare.asm
;		Purpose:	X[S] to X[S+1]
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										Compare checks
;
; ************************************************************************************************

CompareEqual:
		lda 	NSMantissa0,x
		bne 	ReturnFalse

ReturnTrue:
		lda 	#1
		sta 	NSMantissa0,x
		lda 	#$80
		sta 	NSStatus,x
		rts
ReturnFalse:
		stz 	NSMantissa0,x
		rts				
		
CompareNotEqual:
		lda 	NSMantissa0,x
		bne 	ReturnTrue
		bra 	ReturnFalse

CompareLess:
		lda 	NSMantissa0,x
		cmp 	#$FF
		beq 	ReturnTrue
		bra 	ReturnFalse

CompareGreater:
		lda 	NSMantissa0,x
		cmp 	#$01
		beq 	ReturnTrue
		bra 	ReturnFalse

CompareLessEqual:
		lda 	NSMantissa0,x
		cmp 	#$01
		bne 	ReturnTrue
		bra 	ReturnFalse

CompareGreaterEqual:
		lda 	NSMantissa0,x
		cmp 	#$FF
		bne 	ReturnTrue
		bra 	ReturnFalse
		
; ************************************************************************************************
;
;						Compare Stack vs 11th. Return 255,0 or 1 in A
;
; ************************************************************************************************

FloatCompare:	
		lda 	NSExponent,x 				; float comparison.
		ora 	NSExponent-1,x 				; integer if both integer.
		pha

		jsr 	FloatSubtract 				; Calculate S[X]-S[X+1]
		;
		pla
		bne 	_FCCompareFloat 			
		;
		;		Integer comparison, check for *exactly* 0.
		;
		lda 	NSMantissa0,x
		ora 	NSMantissa1,x
		ora 	NSMantissa2,x
		ora 	NSMantissa3,x
		beq 	_FCExit 					; if zero, return zero
		bra 	_FCSign

_FCCompareFloat:	
		;
		;		At this point the mantissae are equal. If we were comparing integers
		; 		then this should be zero - if float we ignore the lowest 12 bits, which gives
		;		an approximation for equality of 1 part in 2^18
		; 		This is about 1 part in 500,000 - so it is "almost equal".
		;			
		lda 	NSMantissa1,x 			 	; so we ignore this - by changing bits checked
		and 	#$F0
		ora 	NSMantissa2,x
		ora 	NSMantissa3,x
		beq 	_FCExit 					; zero, so approximately identical
		;
		;		Not equal, so get result from sign.
		;
_FCSign:		
		lda 	#1 							; return +1 if result>0
		bit 	NSStatus,x
		bpl 	_FCExit
_FCNegative:		
		lda 	#$FF 						; and return -1 if result<0
_FCExit:
		jsr 	FloatSetByte 				; set the result 255,0,1
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
