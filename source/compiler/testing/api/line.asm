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
;					Read next line return address of whole line in YX. CC if nothing.
;
; ************************************************************************************************

ReadNextLine:
		lda 	(srcInputPtr) 				; reached the end of the program (address link = $0000)
		ldy 	#1
		ora 	(srcInputPtr),y
		bne 	_RLAHaveData
		clc 		
		rts									; end of file.
_RLAHaveData:
		ldx 	srcInputPtr 				; remember the line start
		ldy 	srcInputPtr+1
		phy
		ldy 	#4 							; must be at least four bytes (address/line#)
_RNLRead:
		lda 	(srcInputPtr),y 			; find the end of the line.
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

		ply 								; address of line now in YX.
		sec
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

