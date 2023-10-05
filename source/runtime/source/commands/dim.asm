; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		dim.asm
;		Purpose:	Create new array
;		Created:	26th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;					<dim1> <dim2> <dim.n> <n> <type.data> DIM <base.address>
;
; ************************************************************************************************

CommandDIM: ;; [!dim]
		.entercmd
		phy
		jsr 	GetInteger8Bit 				; get the type we are building for (bits 6 & 5)
		sta 	dimType
		dex 								; this is the number of indices
		jsr 	GetInteger8Bit 
		sta 	zTemp1 						; subtract n from X so X points at the *first*
		txa 								; dimension.
		sec
		sbc 	zTemp1
		tax
		lda 	zTemp1 						; number of indices.
		jsr 	DIMCreateOneLevel 			; create one at this level
		;
		sta 	NSMantissa0,x 				; set it as a return address as an integer
		tya
		sta 	NSMantissa1,x
		stz 	NSMantissa2,x
		stz 	NSMantissa3,x
		stz 	NSStatus,x
		stz 	NSExponent,x
		ply
		.exitcmd

; ************************************************************************************************
;
;		Create one level , at depth A, with the stack,X being the extent of the index
;		returns the offset address in YA.
;
; ************************************************************************************************

DIMCreateOneLevel:
		;
		;		Save the start on the stack
		;
		ldy 	availableMemory 			; push the start of this block on the stack.
		phy
		ldy 	availableMemory+1
		phy
		;
		;		Get dimension and bump it because A(10) is 11 elements.
		;
		tay 			 					; save current level into Y
		jsr		GetInteger16Bit 			; size of dimension to zTemp0
		inc 	zTemp0 						; bump the size of the dimension as we need one more
		bne 	_DCOLNoCarry
		inc 	zTemp0+1
_DCOLNoCarry:
		lda 	zTemp0 						; write out the +1 size of the dimension
		;
		;		Write out the header and the size/type byte
		;
		jsr 	DIMWriteByte
		lda 	zTemp0+1
		jsr 	DIMWriteByte
		lda 	dimType 					; get type information
		and 	#$7F
		cpy 	#1
		beq 	_DCOLNoSubLevel
		ora 	#$80 						; set sublevel bit if there is one.
_DCOLNoSubLevel:		 			
		jsr 	DIMWriteByte
		;
		;		Save start and count 
		;
		lda 	availableMemory
		sta 	zTemp1
		lda 	availableMemory+1
		sta 	zTemp1+1
		;
		lda 	zTemp0
		sta 	zTemp2
		lda 	zTemp0+1
		sta 	zTemp2+1
		;
		;		Erase the level to all zeros.
		;
_DCOLFillArray:
		jsr 	DIMWriteElement 			; write out an element, could be a sub-level or individual data

		lda 	zTemp0 						; decrement one from count.
		bne 	_DCOLNoBorrow
		dec 	zTemp0+1
_DCOLNoBorrow:
		dec 	zTemp0
		;
		lda 	zTemp0 						; until completed.
		ora 	zTemp0+1		
		bne 	_DCOLFillArray
		;
		;		Check if we need to recursively fill.
		;
		cpy 	#1 							
		beq 	_DCOLExit
		;
		;		Need to work though again filling in with lower levels.
		; 		elements go at zTemp1, count in zTemp2, so these must be stacked
		;		when the creator is called recursively.
		;
_DCOLRecursionLoop:
		phx 								; save XY
		phy

		lda 	zTemp1 						; push zTemp1 (position) zTemp2 (count)
		pha
		lda 	zTemp1+1
		pha
		lda 	zTemp2
		pha
		lda 	zTemp2+1
		pha

		dey  								; lower level -> A
		tya
		inx 								; next index size
		jsr 	DIMCreateOneLevel 			; create a level, return in YA

		plx 								; restore zTemp2 (count) and zTemp1 (position)
		stx 	zTemp2+1
		plx
		stx 	zTemp2
		plx
		stx 	zTemp1+1
		plx
		stx 	zTemp1
		;
		sta 	(zTemp1) 					; write out position
		tya
		ldy 	#1
		sta 	(zTemp1),y
		;
		ply 								; restore XY
		plx

		clc
		lda 	zTemp1 						; add 2 to zTemp1
		adc 	#2
		sta 	zTemp1
		bcc 	_DCOLRNoCarry
		inc 	zTemp1+1
_DCOLRNoCarry:
		lda 	zTemp2 						; decrement one from count in zTemp2
		bne 	_DCOLRNoBorrow
		dec 	zTemp2+1
_DCOLRNoBorrow:
		dec 	zTemp2
		;
		lda 	zTemp2 						; until completed.
		ora 	zTemp2+1		
		bne 	_DCOLRecursionLoop
		;
		;		Pop the start off the stack and return.
		;
_DCOLExit:		
		pla 								; get MSB, make offset again
		sec
		sbc 	#WorkArea >> 8
		tay
		pla 								; YA now contains offset address.
		rts

; ************************************************************************************************
;
;					Write out an array element of the appropriate size, empty
;
; ************************************************************************************************

DIMWriteElement:
		phx
		ldx	 	#2 							; work out size is 2 or 6
		cpy 	#1 							; do we have a sub level, if so 2.
		bne 	_DIMWENotFloat
		lda 	dimType 					
		and 	#NSSTypeMask+NSSIInt16
		cmp 	#NSSIFloat
		bne 	_DIMWENotFloat
		ldx 	#6
_DIMWENotFloat:
		lda 	#0
		jsr 	DIMWriteByte
		dex
		bne 	_DIMWENotFloat
		plx 			
		rts

; ************************************************************************************************
;
;							Write a single byte out to free memory
;
; ************************************************************************************************
	
DIMWriteByte:
		sta 	(availableMemory)
		inc 	availableMemory
		bne 	_DIMWBSkip
		inc 	availableMemory+1
		pha
		lda 	availableMemory+1 			; check out of memory
		cmp 	stringHighMemory+1
		bcs 	_DIMWBMemory
		pla
_DIMWBSkip:
		rts
_DIMWBMemory:
		.error_memory
		
		.send 	code

		.section storage
dimType:									; type bits being checked for.
		.fill 	1
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
