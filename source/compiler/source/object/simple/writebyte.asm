; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		writebyte.asm
;		Purpose:	Write a single byte to the output.
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Write A to output (raw)
;
; ************************************************************************************************

OUTPUTWriteByte:
		sta 	(objPtr)
		inc 	objPtr
		bne 	_HWOWBNoCarry
		inc 	objPtr+1
_HWOWBNoCarry:		
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
