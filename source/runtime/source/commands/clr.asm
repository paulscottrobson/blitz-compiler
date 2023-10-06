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
		;		Initialise strings
		;
		.set16 	stringHighMemory,StringTopAddress 		; reset string memory alloc pointer
		stz 	stringInitialised 						; string system not initialised
		;
		;		Initialise stack
		;
		.set16 	runtimeStackPtr,StackTopAddress-1 		; current TOS
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
