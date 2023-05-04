; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		ti.asm
;		Purpose:	Read time in jiffies as integer (ti) or string (ti$)
;		Created:	20th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									     Time to TOS
;
; ************************************************************************************************

TimeTOS:	;; [ti]
		.entercmd
		jsr 	TIPushClock 				; push clock to TOS
		.exitcmd

TimeString: ;; [ti$]
		.entercmd
		jsr 	TIPushClock 				; push clock to TOS
		jsr 	_TSDivMod60 				; result in seconds

		jsr 	_TSDivMod60 				; seconds
		pha
		jsr 	_TSDivMod60 				; minutes
		pha
		lda 	#24 						; hours
		jsr 	_TSDivModA
		pha

		lda 	#6
		jsr 	StringAllocTemp
		pla
		jsr 	_TSWriteDecimal
		pla
		jsr 	_TSWriteDecimal
		pla
		jsr 	_TSWriteDecimal

		.exitcmd

; ************************************************************************************************
;
;								Divide S[X] by A/60, return modulus in A
;
; ************************************************************************************************

_TSDivMod60:
		lda 	#60
_TSDivModA:
		inx
		jsr 	FloatSetByte
		dex
		jsr 	Int32Divide
		lda 	NSMantissa0,x 				; get modulus
		pha
		jsr 	NSMCopyPlusTwoToZero 		
		pla
		rts

; ************************************************************************************************
;
;									Convert A to BCD, Copy to string
;
; ************************************************************************************************

_TSWriteDecimal:
		phx
		ldx 	#'0'
_TSWDLoop:
		cmp 	#10
		bcc 	_TSWDEnd
		sbc 	#10
		inx
		bra 	_TSWDLoop
_TSWDEnd:
		pha
		txa
		jsr 	StringWriteChar
		pla
		ora 	#'0'
		jsr 	StringWriteChar				
		plx	
		rts
		
; ************************************************************************************************
;
;									Push clock (60Hz) to TOS
;	
; ************************************************************************************************

TIPushClock:
		phy
		inx 								; push 0 on the stack
		jsr 	FloatSetZero
		phx
		jsr 	XReadClock 					; read time into YXA
		stx 	zTemp0
		plx
		sta 	NSMantissa0,x
		lda 	zTemp0
		sta 	NSMantissa1,x
		tya
		sta 	NSMantissa2,x
		ply
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
