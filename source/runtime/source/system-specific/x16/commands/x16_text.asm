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

; ************************************************************************************************
;
;										Locate X[,Y] command
;
; ************************************************************************************************

CommandLocate: ;; [!locate]
		.entercmd
		.floatinteger 						; make everything integer
		dex
		.floatinteger
		dex
		lda 	#$13 						; home.
		jsr 	XPrintCharacterToChannel
		lda 	#$1D 						; do cursor rights
		ldx 	NSMantissa0+1
		jsr 	_CLOutputXA
		lda 	#$11 						; do cursor downs.
		ldx 	NSMantissa0
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

; ************************************************************************************************
;
;										Color F[,B]
;
; ************************************************************************************************

CommandColor: ;; [!color]
		.entercmd
		.floatinteger 						; make everything integer
		dex
		.floatinteger
		dex
		lda 	NSMantissa0+1 				; bgr specified
		cmp 	#$FF  				
		beq 	_CCNoBGR 					; if so, change background
		jsr 	_CCSetColour
		lda 	#$01 						; swap FGR/BGR
		jsr 	XPrintCharacterToChannel
_CCNoBGR:
		lda 	NSMantissa0
		jsr 	_CCSetColour		
		.exitcmd

_CCSetColour:
		and 	#15 						; look up in control codes table.
		tax
		lda 	_CCCommandTable,x
		jsr 	XPrintCharacterToChannel
		rts

_CCCommandTable:
		.byte	 $90,$05,$1c,$9f,$9c,$1e,$1f,$9e
		.byte	 $81,$95,$96,$97,$98,$99,$9a,$9b

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
