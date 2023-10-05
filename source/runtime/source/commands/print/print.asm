; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		print.asm
;		Purpose:	Print Indirection Control etc.
;		Created:	19th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;							Get/Set Print Channel from/to stack
;
; ************************************************************************************************

GetChannel: ;; [getchannel]
		.entercmd
		lda 	currentChannel
		inx
		jsr 	FloatSetByte
		.exitcmd

SetChannel: ;; [setchannel]
		.entercmd
		jsr 	FloatIntegerPart
		lda 	NSMantissa0,x
		sta 	currentChannel
		dex
		.exitcmd

SetDefaultChannel:
		stz 	currentChannel
		rts

; ************************************************************************************************
;
;						  				Print Character
;
; ************************************************************************************************

VectorPrintCharacter:
		phx
		ldx 	currentChannel

;
;		Check we're sending it to the correct channel.
;
;		pha
;		txa
;		ora 	#48
;		jsr 	XPrintCharacterToChannel
;		pla

		jsr 	XPrintCharacterToChannel
		plx
		rts

; ************************************************************************************************
;
;						  				Get Character
;
; ************************************************************************************************

VectorGetCharacter:
		phx
		ldx 	currentChannel
		jsr 	XGetCharacterFromChannel
		plx
		rts

		.send code

		.section storage
currentChannel:
		.fill 	1
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
