; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		write.asm
;		Purpose:	Write file code
;		Created:	9th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Open sequential file for Write.
; 									   YX = ASCIIZ name
;
; ************************************************************************************************

IOOpenWrite:
		lda 	#'W'			 			; write
		jsr 	IOSetFileName 				; set up name/LFS
		ldx	 	#3 							; use file 3 for writing
		jsr 	$FFC9 						; CHKOUT
		rts

; ************************************************************************************************
;
;									Write A to output file
;
; ************************************************************************************************

IOWriteByte:		
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