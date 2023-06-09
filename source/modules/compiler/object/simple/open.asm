; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		open.asm
;		Purpose:	Open/Reopen the output
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Reset the output system
;						(note this is all gone throught TWICE)
;
; ************************************************************************************************

OUTPUTOpen:
OUTPUTRewind:
		stz 	objPage
		.set16 	objPtr,PCodeStart
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
