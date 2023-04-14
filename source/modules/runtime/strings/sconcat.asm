; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		sconcat.asm
;		Purpose:	Concatenate strings
;		Created:	14th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						  Concatenate Strings S[X],S[X+1]
;
; ************************************************************************************************

StringConcatenate: ;; [concat]
		.entercmd

		dex

		lda 	NSMantissa0,x 				; copy strings to zTemp1 and zTemp2
		sta 	zTemp1
		lda 	NSMantissa1,x
		sta 	zTemp1+1

		lda 	NSMantissa0+1,x 			
		sta 	zTemp2
		lda 	NSMantissa1+1,x
		sta 	zTemp2+1

		clc 								; work out total length
		lda 	(zTemp1) 					
		adc 	(zTemp2) 
		bcs 	_BCLength 					; more than 255 characters. 			

		pha 								; save total
		jsr 	StringAllocTemp 			; space for result.
		pla 								; write total as first.
		sta 	(zsTemp)

		jsr 	_BCCopyZTemp1 				; copy zTemp1 to target
		lda 	zTemp2 						; copy address zTemp2->1
		sta 	zTemp1
		lda 	zTemp2+1
		sta 	zTemp1+1
		jsr 	_BCCopyZTemp1 				; and copy it, e.g. zTemp2
		.exitcmd
		
_BCLength:
		.error_range

_BCCopyZTemp1:
		lda 	(zTemp1) 					; bytes to copy
		beq 	_BCCExit 					; none.
		phx 								; save XY
		phy
		tax 								; count in X.
		ldy 	#1
_BCCLoop:
		inc 	zsTemp 						; bump pointer, pre-increment
		bne 	_BCCNoCarry
		inc 	zsTemp+1
_BCCNoCarry:		
		lda 	(zTemp1),y				 	; copy bytes
		sta 	(zsTemp)
		iny
		dex 								; X times
		bne 	_BCCLoop
		ply 								; restore YX
		plx
_BCCExit:
		rts		

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
