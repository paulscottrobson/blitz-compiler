; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		rnd.asm
;		Purpose:	Random number function
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;											RND function
;
; ************************************************************************************************

UnaryRND:	;; [rnd]
		.entercmd

		bit 	NSStatus,x 					; -ve then set seed from operand
		bpl 	_URNoSeed

		jsr 	FloatNormalise 				; some float value
		lda 	NSMantissa0,x 				; copy to Mantissa
		sta 	randomSeed+0
		lda 	NSMantissa1,x
		sta 	randomSeed+1
		lda 	NSMantissa2,x
		sta 	randomSeed+2
		lda 	NSMantissa3,x
		sta 	randomSeed+3
_URNoSeed:
		jsr 	RandomNumberGenerator 		; create a number and copy to mantissa

		lda 	randomSeed+0
		sta 	NSMantissa0,x		
		lda 	randomSeed+1
		sta 	NSMantissa1,x		
		lda 	randomSeed+2
		sta 	NSMantissa2,x		
		lda 	randomSeed+3
		and 	#$7F
		sta 	NSMantissa3,x		
		lda 	#(-31 & $FF)
		sta 	NSExponent,x
		stz 	NSStatus,x
		
		.exitcmd

; ************************************************************************************************
;
;						Random number generator, originally by Brad Smith
;
; ************************************************************************************************

RandomNumberGenerator:
		phy
		lda 	randomSeed+0 				; check if zero
		ora 	randomSeed+1
		ora 	randomSeed+2
		ora 	randomSeed+3
		bne 	_RNGNoSeed

		dec 	randomSeed+3 				; if so tweak and flog
		ldy 	#100
		bra 	_RNGLoop

_RNGNoSeed:									; do 8 times.
		ldy 	#8
		lda 	randomSeed+0
_RNGLoop:
		asl		a
		rol 	randomSeed+1
		rol 	randomSeed+2
		rol 	randomSeed+3
		bcc		_RNGSkip
		eor 	#$C5
_RNGSkip:	
		dey
		bne		_RNGLoop
		sta 	randomSeed+0
		ply
		rts

		.send code

		.section storage
randomSeed:
		.fill 	4
		.send 	storage

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
