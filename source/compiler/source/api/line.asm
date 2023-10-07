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
		jsr 	INPUTGet 					; check offset is not zero.
		sta 	zTemp0
		jsr 	INPUTGet
		ora 	zTemp0
		bne 	_RNLBody 
		clc 		
		rts						; end of file.
_RNLBody:
		jsr 	INPUTGet 					; read and save line number
		sta 	currentLineNumber
		jsr 	INPUTGet
		sta 	currentLineNumber+1
		ldx 	#0 							; read line into buffer
_RNLRead:
		jsr 	INPUTGet		
		sta 	sourceBuffer,x
		inx
		cmp 	#0
		bne 	_RNLRead
		.set16 	srcPtr,sourceBuffer 		; start reading from the source buffer.
		sec
		rts

; ************************************************************************************************
;
;								Get line number of current line -> YA
;
; ************************************************************************************************		

GetLineNumber:
		ldy 	currentLineNumber+1
		lda 	currentLineNumber
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

