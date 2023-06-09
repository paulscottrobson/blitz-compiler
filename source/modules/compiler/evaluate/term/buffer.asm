; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		buffer.asm
;		Purpose:	Buffer for inline data, strings etc.
;		Created:	16th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										Clear the buffer
;
; ************************************************************************************************

BufferClear:
		stz 	bufferSize
		rts		

; ************************************************************************************************
;
;									 Write A to the buffer
;
; ************************************************************************************************

BufferWrite:
		phx
		ldx 	bufferSize
		sta 	dataBuffer,x
		inc 	bufferSize
		plx
		rts

; ************************************************************************************************
;
;								Output buffer as data block
;
; ************************************************************************************************

BufferOutput:
		lda 	bufferSize
		jsr 	WriteCodeByte
		ldx 	#0
_BOLoop:
		cpx 	bufferSize
		beq 	_BOExit
		lda 	dataBuffer,x
		jsr 	WriteCodeByte
		inx
		bra 	_BOLoop
_BOExit:
		rts		
		.send code

		.section storage
bufferSize:
		.fill 	1
dataBuffer:
		.fill 	256
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
