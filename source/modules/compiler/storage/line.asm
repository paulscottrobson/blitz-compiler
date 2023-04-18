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
;								Store current position, current line
;
; ************************************************************************************************

STRMarkLine:

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

		phy
		jsr 	HWILineNumber 				; get line #
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
		ply
		rts

; ************************************************************************************************
;
;				Line number YA - find in table, return page X offset/address YA
;
; ************************************************************************************************

STRFindLine:
		.storage_access

		sta 	zTemp0 						; zTemp0 line number being searched
		sty 	zTemp0+1
		lda 	lineNumberTable 			; zTemp1 points to table
		sta 	zTemp1
		lda 	lineNumberTable+1
		sta 	zTemp1+1

_STRSearch:
		lda 	zTemp1+1 					; reached the end
		cmp 	#(WorkArea+WorkAreaSize) >> 8
		beq 	_STRError
		;
		lda 	(zTemp1) 					; check match.
		cmp 	zTemp0
		bne 	_STRNext
		ldy 	#1
		lda 	(zTemp1),y
		cmp 	zTemp0+1
		beq 	_STRFound
_STRNext: 									; next table entry.
		clc
		lda 	zTemp1
		adc 	#5
		sta 	zTemp1
		bcc 	_STRSearch
		inc 	zTemp1+1
		bra 	_STRSearch
		rts
_STRError:
		.storage_release
		.error_line

_STRFound:
		iny 								; page into X
		lda 	(zTemp1),y
		tax

		clc 								; borrow 1
		iny 								; address into YA
		lda 	(zTemp1),y
		sbc 	objPtr
		pha
		iny
		lda 	(zTemp1),y
		sbc 	objPtr+1
		tay
		pla	

		.storage_release
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
