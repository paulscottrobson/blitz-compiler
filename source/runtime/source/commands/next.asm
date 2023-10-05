; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		next.asm
;		Purpose:	NEXT command
;		Created:	20th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										<RefAddr|$FFFF> NEXT
;
; ************************************************************************************************

CommandNext: ;; [next]
		.entercmd
_CNRetry:		
		lda 	#FRAME_FOR 					; find the FOR 
		jsr 	StackFindFrame
		jsr 	FixUpY 						; so we can use Y		
		;
		;		Index variable check ?
		;
		lda 	NSMantissa0,x 				; check no index variable, both are $FF
		and 	NSMantissa1,x
		cmp 	#$FF
		beq 	_CNNoIndexVariable

		lda 	NSMantissa0,x
		ldy 	#5
		cmp 	(runtimeStackPtr),y
		bne 	_CNNIndexFail
		lda 	NSMantissa1,x
		iny
		cmp 	(runtimeStackPtr),y
		beq 	_CNNoIndexVariable
_CNNIndexFail:		
		ldy 	#0 							; so we don't fix up Y again !
		jsr 	StackCloseFrame 			; close this frame
		bra 	_CNRetry


_CNNoIndexVariable:
		dex

		ldy 	#4 							; check for optimised NEXT
		lda 	(runtimeStackPtr),y
		and 	#$40	 					; bit 6
		bne 	_CNOptimisedNext
		;
		;		Increment the index, overwrite index reference with index value
		;		
		ldy 	#5 							; copy address to zTemp0, save for write back
		lda 	(runtimeStackPtr),y
		pha
		sta 	zTemp0
		iny
		lda 	(runtimeStackPtr),y
		clc 
		adc 	#VariableStart >> 8 		; point to variable page.
		pha
		sta 	zTemp0+1
		jsr 	ReadFloatZTemp0Sub 			; read current index onto stack.
		;		
		ldy 	#7  						; read step onto stack +1
		inx 
		jsr 	CopyOffsetYToTOS 			
		;
		jsr 	FloatAdd

		pla 								; restore address
		sta 	zTemp0+1
		pla
		sta 	zTemp0
		jsr 	WriteFloatZTemp0Sub			; write float.
		;
		;		Now check against terminal value
		;
		inx  								; recover written
		inx 								; load offset
		ldy 	#13
		jsr 	CopyOffsetYToTOS
		jsr 	FloatCompare 				; and compare the floats.
		dex 								; throw result (in NSMantissa0+1)

		ldy 	#12 						; get the sign of the step.
		lda 	(runtimeStackPtr),y
		bmi 	_CNDownStep
		;
		lda 	NSMantissa0+1,x 			; get comparator
		cmp 	#1 							; gone higher
		beq 	_CNExitFor 					; if so exit the loop
		bra 	_CNLoopBack
_CNDownStep:
		lda 	NSMantissa0+1,x 			; get comparator
		cmp 	#255 						; gone lower
		beq 	_CNExitFor		
		;
		; 		Here to loop back
		;
_CNLoopBack:
		jsr 	StackLoadCurrentPosition 	; loop back
		ldy 	#0
		.exitcmd
		;
		; 		Here to exit out.
		;
_CNExitFor:						
		jsr 	StackCloseFrame 			; remove the frame and exit
		ldy 	#0
		.exitcmd
;
; 		Optimised next code.
;
_CNOptimisedNext:
		ldy 	#5 							; copy address to zTemp0, save for write back
		lda 	(runtimeStackPtr),y
		sta 	zTemp0
		iny
		lda 	(runtimeStackPtr),y
		clc 
		adc 	#VariableStart >> 8 		; point to variable page.
		sta 	zTemp0+1
		;
		;		Increment it - we don't worry about carry out because the test is unsigned.
		;
		ldy 	#7 							; STEP value
		lda 	(runtimeStackPtr),y
		ldy 	#$FF
		clc		
_CNOIncrement:
		iny
		adc 	(zTemp0),y
		sta 	(zTemp0),y
		beq 	_CNOIncrement
		;
		;		Point zTemp1 to the terminal value, easier access
		;
		clc
		lda 	runtimeStackPtr
		adc 	#13
		sta 	zTemp1
		lda 	runtimeStackPtr+1
		adc 	#0
		sta 	zTemp1+1
		;
		;		Calculate terminal - value, when this goes -ve loop over.
		;
		ldy 	#0
		lda 	(zTemp1),y 					; byte 0
		cmp 	(zTemp0),y
		iny
		lda 	(zTemp1),y 					; byte 1
		sbc 	(zTemp0),y
		iny
		lda 	(zTemp1),y 					; byte 2
		sbc 	(zTemp0),y
		iny
		lda 	(zTemp1),y 					; byte 3
		sbc 	(zTemp0),y
		bcc	 	_CNExitFor
		bra 	_CNLoopBack

; ************************************************************************************************
;
;								Copy Stack frame offset Y to TOS
;
; ************************************************************************************************

CopyOffsetYToTOS:
		lda 	(runtimeStackPtr),y
		sta 	NSMantissa0,x
		iny
		lda 	(runtimeStackPtr),y
		sta 	NSMantissa1,x
		iny
		lda 	(runtimeStackPtr),y
		sta 	NSMantissa2,x
		iny
		lda 	(runtimeStackPtr),y
		sta 	NSMantissa3,x
		iny
		lda 	(runtimeStackPtr),y
		sta 	NSExponent,x
		iny
		lda 	(runtimeStackPtr),y
		sta 	NSStatus,x
		rts

		.exitcmd	

		.send 	code
		
; ************************************************************************************************
;
;									Changes and Updates
;
; ************************************************************************************************
;
;		Date			Notes
;		==== 			=====
;		23/06/23 		Does a search rather than a check. If the index variable match fails,
; 						keeps closing frames until it finds the right one, copying MS Basic standard.
;
; ************************************************************************************************
