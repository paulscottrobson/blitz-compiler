; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		line.asm
;		Purpose:	Line Number Tracking
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Store current position, line YA
;
; ************************************************************************************************

STRMarkLine:
		pha
		sec 								; allocate 5 bytes (line #, page+address)
		lda 	lineNumberTable 			; and copy to zTemp0
		sbc 	#5
		sta 	lineNumberTable
		sta 	zTemp0
		lda 	lineNumberTable+1
		sbc 	#0
		sta 	lineNumberTable+1
		sta 	zTemp0+1

		.storage_access
		pla
		sta 	(zTemp0) 					; save it in +0,+1
		tya
		ldy 	#1
		sta 	(zTemp0),y
		;
		lda 	objPage 					; and page# in +2
		iny
		sta 	(zTemp0),y

		lda 	objPtr 						; save current address in +3,+4
		iny
		sta 	(zTemp0),y
		lda 	objPtr+1
		iny
		sta 	(zTemp0),y

		.storage_release
		rts

; ************************************************************************************************
;
;				Line number YA - find in table, return page X address YA 
;				
;				If FOUND: of the matching line, with Carry Clear.
;				If NOT FOUND : of the previous line (e.g. next code line), with Carry Set.
;
; ************************************************************************************************

STRFindLine:
		.storage_access

		sta 	zTemp0 						; zTemp0 line number being searched
		sty 	zTemp0+1
		
		lda 	compilerEndHigh 			; work backwards through table
		sta 	zTemp1+1
		stz 	zTemp1

_STRSearch:
		jsr 	_STRPrevLine 				; look at previous record.

		ldy 	#1
		lda 	(zTemp1) 					; check table line # >= target
		cmp 	zTemp0
		lda 	(zTemp1),y
		sbc 	zTemp0+1
		bcs 	_STRFound 					; >=
_STRNext: 									; next table entry.
		ldy 	#1 							; should not be required !
		lda 	(zTemp1),y
		cmp 	#$FF
		bne 	_STRSearch
		.error_internal

_STRFound:
		lda 	(zTemp1) 					; set A = 0 if the same, 0 if different.
		eor 	zTemp0
		bne 	_STRDifferent
		lda 	(zTemp1)
		eor 	zTemp0
		beq 	_STROut 					; if zero, exit with A = 0 and correct line.
_STRDifferent:
		lda 	#$FF 						
_STROut:
		clc  								; set carry if different, e.g. > rather than >=
		adc 	#255 				
		php
		iny 								; page into X
		lda 	(zTemp1),y
		tax
		iny 								; address into YA
		lda 	(zTemp1),y
		pha
		iny
		lda 	(zTemp1),y
		tay
		pla	
		.storage_release
		plp	
		rts

_STRPrevLine:
		sec 								; move backwards one entry.
		lda 	zTemp1
		sbc 	#5
		sta 	zTemp1
		lda 	zTemp1+1
		sbc 	#0
		sta 	zTemp1+1
		rts
; ************************************************************************************************
;
;								Make position X:YA to Offset X:YA
;
; ************************************************************************************************

STRMakeOffset:
		clc 								; borrow 1
		sbc 	objPtr
		pha
		tya
		sbc 	objPtr+1
		tay
		pla
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
