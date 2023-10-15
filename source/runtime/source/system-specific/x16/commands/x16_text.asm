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
		pha 								; save registers
		phx
		phy
		clc
		ldy 	NSMantissa0+1 				; get coords
		ldx 	NSMantissa0
		dey 								; fix up
		dex
		jsr 	$FFF0 						; PLOT
		ply 								; restore registers
		plx
		pla
		.exitcmd

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
		phx 								; peserve X
		and 	#15 						; look up in control codes table.
		tax
		lda 	_CCCommandTable,x
		jsr 	XPrintCharacterToChannel
		plx
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
