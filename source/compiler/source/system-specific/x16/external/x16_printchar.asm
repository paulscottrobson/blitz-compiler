; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		printchar.asm
;		Purpose:	Character output interface
;		Created:	8th May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code
		
; ************************************************************************************************
;
;								Print character A to Screen/Error Stream
;
; ************************************************************************************************

XPrintCharacter
		pha
		phx
		phy
		jsr 	$FFD2
		ply
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