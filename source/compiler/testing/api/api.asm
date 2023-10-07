; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		api.asm
;		Purpose:	Compiler API Interface
;		Created:	7th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;									API Entry point
;
; ************************************************************************************************

PCodeMemory = $A000

		.section code

TestAPI:
		cmp 	#BLC_OPENIN
		beq 	_TAOpenIn
		cmp 	#BLC_CLOSEIN
		beq 	_TACloseIn
		cmp 	#BLC_READIN
		beq 	_TARead
		cmp 	#BLC_RESETOUT
		beq 	_TAResetOut
		cmp 	#BLC_WRITEOUT
		beq 	_TAWriteByte
		.debug

_TAOpenIn:		
		.set16 	srcInputPtr,EndProgram+2 	
_TACloseIn:
		rts		
_TARead:
		jmp 	ReadNextLine

_TAResetOut:
		.set16 	objPtr,PCodeMemory
		rts

_TAWriteByte:
APIOWriteByte:		
		txa
		sta 	(objPtr)
		inc 	objPtr
		bne 	_HWOWBNoCarry
		inc 	objPtr+1
_HWOWBNoCarry:		
		rts
		
		.send code

		.section zeropage
srcInputPtr: 								; data from here
		.fill 	2
		.send zeropage

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

