; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		api.asm
;		Purpose:	Short version of common API functions
;		Created:	7th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Get line number of current line -> YA
;
; ************************************************************************************************		

GetLineNumber:
		ldy 	currentLineNumber+1
		lda 	currentLineNumber
		rts
		
; ************************************************************************************************
;
;									Write byte A to output
;
; ************************************************************************************************

WriteCodeByte:
		pha 								; save on stack
		phx
		phy
		jsr 	APIOWriteByte
		ply 								; restore from stack
		plx
		pla
		rts

; ************************************************************************************************
;
;								Print character A to Screen/Error Stream
;
; ************************************************************************************************

PrintCharacter
		pha
		phx
		phy
		jsr 	APIOPrintCharacter
		ply
		plx
		pla
		rts

; ************************************************************************************************
;
;					Process new line - set source pointer, extract line number
;
; ************************************************************************************************
 
ProcessNewLine:
		stx 	zTemp0 						; save address in zTemp0
		sty 	zTemp0+1

		clc 								; set the srcPtr to the start of the actual code (e.g. offset 4)
		txa
		adc 	#4
		sta 	srcPtr
		tya
		adc 	#0
		sta 	srcPtr+1

		ldy 	#2							; read and save line number
		lda 	(zTemp0),y
		sta 	currentLineNumber
		iny
		lda 	(zTemp0),y
		sta 	currentLineNumber+1
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

