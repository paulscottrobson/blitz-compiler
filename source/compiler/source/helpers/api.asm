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
