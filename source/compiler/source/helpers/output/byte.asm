; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		byte.asm
;		Purpose:	Wrapper for HWOWriteByte
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;									Write A with to output
;
; ************************************************************************************************

WriteCodeByte:
		pha 								; save on stack
		phx
		phy
		jsr 	OUTPUTWriteByte
		ply 								; restore from stack
		plx
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
