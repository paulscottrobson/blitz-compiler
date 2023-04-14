; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		compare.asm
;		Purpose:	Compare strings
;		Created:	12th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						  Compare String S[X],S[X+1] - return 255,0,1
;
; ************************************************************************************************

CompareStrings: ;; [s.cmp]
		.entercmd

		dex
		
		lda 	NSMantissa0,x 				; copy strings to zTemp0 and zTemp1
		sta 	zTemp0
		lda 	NSMantissa1,x
		sta 	zTemp0+1

		lda 	NSMantissa0+1,x 			
		sta 	zTemp1
		lda 	NSMantissa1+1,x
		sta 	zTemp1+1

		phx
		phy

		lda 	(zTemp0)					; work out number to compare
		cmp 	(zTemp1)
		bcc 	_CSNIsSmallest 				; as min(len(s1),len(s2))
		lda 	(zTemp1)
_CSNIsSmallest:
		tax 								; count in X
		beq 	_CSNMatches 				; if zero already matches as far as we can go.
		ldy 	#0 							; start from offset 1
_CSNCompareString:
		iny 								; pre increment
		lda 	(zTemp0),y
		cmp 	(zTemp1),y
		bne 	_CSNDifferent 				; numbers are different.
		dex
		bne 	_CSNCompareString 			; compare common characters in two strings.
_CSNMatches:
		sec			
		lda 	(zTemp0)					; compare lengths
		sbc 	(zTemp1)
		beq 	_CSNSExit 					; if zero, then strings match and exit.
_CSNDifferent:
		lda 	#$FF
		bcc 	_CSNSExit
		lda 	#$01
_CSNSExit:
		ply
		plx
		cmp 	#0 							; set the flags.
		jsr 	FloatSetByte 				; output the byte
		.exitcmd

		.send code

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
