
; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		line.asm
;		Purpose:	Read in next line etc.
;		Created:	8th May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						Read next line into buffer. reset PTR. CC if nothing.
;
; ************************************************************************************************

ReadNextLine:
		lda 	(srcInputPtr) 				; reached the end of the program (address link = $0000)
		ldy 	#1
		ora 	(srcInputPtr),y
		bne 	_RNLBody 
		clc 		
		rts									; end of file.

_RNLBody:
		iny 								; read and save line number
		lda 	(srcInputPtr),y
		sta 	currentLineNumber
		iny
		lda 	(srcInputPtr),y
		sta 	currentLineNumber+1
		iny 								; first character of line.

		clc 								; point srcPtr to the start of the line.
		lda 	srcInputPtr
		adc 	#4
		sta 	srcPtr
		lda 	srcInputPtr+1
		adc 	#0
		sta 	srcPtr+1

_RNLRead:
		lda 	(srcInputPtr),y 			; copy into buffer.
		iny
		cmp 	#0
		bne 	_RNLRead

		tya 								; advance src input pointer to next.
		clc
		adc 	srcInputPtr
		sta 	srcInputPtr
		bcc 	_RNLNoCarry
		inc 	srcInputPtr+1
_RNLNoCarry:
		sec
		rts

	.send 	code

	.section storage
;srcBuffer:
;	.fill 	256
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

