; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		clr.asm
;		Purpose:	Clear memory down
;		Created:	13th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										CLR command
;
; ************************************************************************************************

CommandClr: ;; [!CLR]
		.entercmd
		jsr 	ClearMemory
		.exitcmd

; ************************************************************************************************
;
;					Clear workspace, reset string system, reset BASIC stack
;
; ************************************************************************************************

ClearMemory:		
		;
		;		Zero workspace
		;
		lda 	storeStartHigh 							; erase the work area
		sta 	zTemp0+1
		stz 	zTemp0
		phy
		ldy 	#0
_ClearLoop1:	
		lda 	#0
		sta 	(zTemp0),y
		iny
		bne 	_ClearLoop1	
		inc 	zTemp0+1
		lda 	zTemp0+1
		cmp 	storeEndHigh
		bne 	_ClearLoop1
		;
		;		Initialise string storage space.
		;
		sec 											; stack space = number of pages in total / 4
		lda 	storeEndHigh
		sbc		storeStartHigh
		lsr 	a 	
		lsr 	a
		bne 	_NotEmpty 								; at least 1 !
		lda 	#1
_NotEmpty:
		sec 											; subtract from high to give string high memory
		eor 	#$FF
		adc 	storeEndHigh
		sta 	stringHighMemory+1
		stz 	stringHighMemory

		stz 	stringInitialised 						; string system not initialised
		;
		;		Initialise stack space.
		;
		lda 	storeStartHigh 							; stack at end of start memory.
		dec 	a
		sta 	runtimeStackPtr+1
		lda 	#$FF
		sta 	runtimeStackPtr

		lda 	#$FF 									; duff marker in case we try to remove it.
		sta 	(runtimeStackPtr)
		ply
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
