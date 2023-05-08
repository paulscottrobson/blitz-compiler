; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_text.asm
;		Purpose:	Text I/O Commands
;		Created:	8th May 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										Clear Screen Command
;
; ************************************************************************************************

CommandCls: ;; [!cls]
		.entercmd
		lda 	#147
		jsr 	XPrintCharacterToChannel
		.exitcmd

CommandLocate: ;; [!locate]
		.entercmd
		lda 	#$13 						; home.
		jsr 	XPrintCharacterToChannel
		lda 	#$1D 						; do cursor rights
		ldx 	NSMantissa0
		jsr 	_CLOutputXA
		lda 	#$11 						; do cursor downs.
		ldx 	NSMantissa0+1
		jsr 	_CLOutputXA
		.exitcmd

_CLOutputXA: 								; output X A's, 1 based.
		dex
		beq 	_CLOExit
		bmi 	_CLOExit
		jsr 	XPrintCharacterToChannel
		bra 	_CLOutputXA
_CLOExit:
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
