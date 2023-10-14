; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		tiwrite.asm
;		Purpose:	Set TI from string
;		Created:	4th May 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										TI = functionality
;
; ************************************************************************************************

CommandTIWriteN: ;; [!ti.write]
		.entercmd
		bra 	WriteTOSToClock

; ************************************************************************************************
;
;										TI$ = functionality
;
; ************************************************************************************************

CommandTIWriteS: ;; [!ti$.write]
		.entercmd
		lda 	NSMantissa0,x 				; copy string address to ZSTemp
		sta 	zsTemp
		lda 	NSMantissa1,x
		sta 	zsTemp+1
		lda 	(zsTemp) 					; check if it is six
		cmp 	#6
		bne 	CTIWError
		jsr 	FloatSetZero
		jsr 	CTIWDigitPair 				; do a digit pair 3 times
		jsr 	CTIWDigitPair
		jsr 	CTIWDigitPair
		lda 	#60 						; multiply the result by 60.
		jsr 	CTIWMultiply

WriteTOSToClock:
		phx
		phy

		lda 	NSMantissa1,x 				; get time into YXA
		pha
		lda 	NSMantissa2,x
		tay
		lda 	NSMantissa0,x
		plx

		jsr 	XWriteClock 				; update the clock.

		ply
		plx
		dex 								; throw result.
		.exitcmd
;
;		Add a pair of digits x 60
;
CTIWDigitPair:
		lda 	#6 							; x 6 
		jsr 	CTIWMultiply
		jsr 	CTIWAddDigit 				; add digit
		lda 	#10 						; x 10
		jsr 	CTIWMultiply
		jsr 	CTIWAddDigit 				; add digit
		rts
;
;		Add the next digit, validating.
;		
CTIWAddDigit:
		inc 	zsTemp 						; pre-increment
		bne 	CTIWASkip
		inc 	zsTemp+1
CTIWASkip:
		lda 	(zsTemp) 					; read and validate it
		sec
		sbc 	#"0"
		bcc 	CTIWError
		cmp 	#9+1
		bcs 	CTIWError
		inx 								; store at +1
		jsr 	FloatSetByte
		dex
		jsr 	FloatAddTopTwoStack
		rts

;
;		Multiply by A
;
CTIWMultiply: 								
		inx
		jsr 	FloatSetByte
		dex
		jsr 	FloatMultiplyShort
		rts

CTIWError:
		.error_value

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
