; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		array.asm
;		Purpose:	Convert an array index reference to a physical address
;		Created:	27th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;						<i1> <i2> <i3> <icount> ARRAY <address>
;
; ************************************************************************************************

ArrayConvert: ;; [array]
		.entercmd
		phy
		;
		;		Convert to a real address in zTemp1
		;
		lda 	NSMantissa0,x
		sta 	zTemp1
		lda 	NSMantissa1,x
		clc
		adc 	variableStartPage		
		sta 	zTemp1+1
		;
		;		Set up for following, firstly get the number of levels to zTemp2, and point the 
		;		stack to the first level.
		;
		dex 								; count of indices to follow -> zTemp2
		jsr 	GetInteger8Bit 
		sta 	zTemp2 						; subtract from stack.

		txa
		sec
		sbc 	zTemp2
		tax 
		phx 								; stack points at the first index, which will be replaced.		
		;
		;		The loop for following down the indices
		;
_ACIndexLoop:		
		jsr 	FloatIntegerPart 			; integer array index
		jsr 	GetInteger16Bit 			; get the index => zTemp0
		ldy 	#1 							; compare against the index count.
		lda 	zTemp0
		cmp 	(zTemp1)
		lda 	zTemp0+1
		sbc 	(zTemp1),y
		bcs 	_ACBadIndex 				; index error.
		dec 	zTemp2 						; decrement count, if zero, then innermost level
		beq 	_ACInnerLevel
		;
		;		Follow down a level
		;
		ldy 	#2 							; check sub index.
		lda 	(zTemp1),y
		bpl 	_ACBadIndex

		asl 	zTemp0 						; double the index and add it to the base address
		rol 	zTemp0+1 					
		clc
		lda		zTemp0
		adc 	zTemp1
		sta 	zTemp0	
		lda		zTemp0+1
		adc 	zTemp1+1
		sta 	zTemp0+1
		;
		;		Follow the link address and set up zTemp1 one level down.
		;
		ldy 	#3 							; we offset by 3 because 3 at entry, now get the address
		lda 	(zTemp0),y 					; into zTemp1 as a real address, not offset
		sta 	zTemp1
		iny
		lda 	(zTemp0),y
		clc
		adc 	variableStartPage
		sta 	zTemp1+1
		inx 								; next index
		bra 	_ACIndexLoop
		;
		;		Reached the innermost level.
		;
_ACInnerLevel:
		;
		;		Check it is an inner level, and get the type
		;
		ldy 	#2
		lda 	(zTemp1),y
		bmi 	_ACBadIndex 				; it has sub arrays, so bad index.
		and 	#NSSTypeMask+NSSIInt16 		; check if it is an iFloat
		cmp 	#NSSIFloat
		bne 	_ACNotFloat
		;
		;		x2 or x6 depending on type.
		;
		lda 	zTemp0+1 					; double and add zTemp0 (x3)
		pha
		lda 	zTemp0

		asl 	zTemp0 						; x 2
		rol 	zTemp0+1

		clc 								; add back x 3
		adc 	zTemp0
		sta 	zTemp0
		pla
		adc 	zTemp0+1
		sta 	zTemp0+1
_ACNotFloat:
		asl 	zTemp0 						; x 2 or x 6 depending. 
		rol 	zTemp0+1
		;
		;		Add 3 , the prefix of the array structure
		;
		clc
		lda 	zTemp0
		adc 	#3
		sta 	zTemp0
		bcc 	_ACNoCarry
		inc 	zTemp0+1
_ACNoCarry:		
		;
		;		Add the base address of the array, making it back into an offset.
		;	
		plx 								; X points to first slot of array parameters
		clc
		lda 	zTemp0
		adc 	zTemp1
		sta 	NSMantissa0,x
		lda 	zTemp0+1
		adc 	zTemp1+1
		sec 	
		sbc 	variableStartPage
		sta 	NSMantissa1,x
		stz 	NSMantissa2,x
		stz 	NSMantissa3,x
		stz 	NSStatus,x
		stz 	NSExponent,x
		ply 	 							; restore code pointer

		.exitcmd

_ACBadIndex:
		.error_index

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
