; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		charprint.asm
;		Purpose:	Print top of stack as character
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						  			Print CHR$(S[X])
;
; ************************************************************************************************

PrintCharacterX: ;; [print.chr]
		.entercmd
		lda 	NSMantissa0,x 	
		dex
		jsr 	VectorPrintCharacter
		.exitcmd
		
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
