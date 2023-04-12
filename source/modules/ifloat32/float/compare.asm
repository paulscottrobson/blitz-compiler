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

FloatCompare:	;; [f.cmp]
		jsr 	FloatSubtract 				; Calculate S[X]-S[X+1]
		;
		;		At this point the mantissae are equal. If we were comparing integers
		; 		then this should be zero - if float we ignore the lowest 13 bits, which gives
		;		an approximation for equality of 1 part in 2^19
		; 		This is about 1 part in 500,000 - so it is "almost equal".
		;			
		lda 	NSMantissa1,x 			 	; so we ignore this - by changing bits checked
		and 	#$F8
		ora 	NSMantissa2,x
		ora 	NSMantissa3,x
		beq 	_FCExit 					; zero, so approximately identical
		;
		;		Not equal, so get result from sign.
		;
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
