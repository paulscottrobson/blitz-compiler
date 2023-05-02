; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		printchar.asm
;		Purpose:	Character output interface
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code
		
; ************************************************************************************************
;
;						Print character A to Channel X: 13 should be CR, 32 space
;
;										Channel 0 is the screen.
;
; ************************************************************************************************

XPrintCharacterToChannel:
		pha
		phx
		phy

		pha  								; save char
		cpx 	#0 							; check default (0)
		bne 	_XPCNotDefault
		jsr 	X16_CLRCHN					; set default channel
		bra 	_XPCSend
_XPCNotDefault:		
		jsr 	X16_CHKOUT 					; CHKOUT set channel
		jsr 	X16_READST 					; check okay
		bne 	_XPCError
_XPCSend:		
		pla 								; restore character
		jsr 	X16_BSOUT 					; print

		ply
		plx
		pla
		rts
_XPCError:
		.error_channel

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
