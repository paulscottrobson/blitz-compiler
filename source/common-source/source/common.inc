; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		common.inc
;		Purpose:	Common includes/defines/setups
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;										Configuration options
;
;			  Addresses should be on page boundaries (except for ZeroPageMandatory)
;
; ************************************************************************************************
;
;		Where to assemble the runnable code. Happy now , Dave ?
;
CodeStart = $801
;
;		Variables that have to be in zero page because it's used in (xx),y
;
ZeroPageMandatory = $22 
;
;		Variables that can go anywhere
;
MemoryStorage = $400

; ************************************************************************************************
;
;									Set up code and data sections
;
; ************************************************************************************************

		* = ZeroPageMandatory 				; *must* be in zero page
		.dsection zeropage

		* = MemoryStorage 					; doesn't matter if zero page or not 
		.dsection storage

		* = CodeStart
		.dsection code

; ************************************************************************************************
;
;										Zero Page Common Usage
;
; ************************************************************************************************

		.section zeropage

codePtr:	 								; address of current line.
		.fill 	2

objPtr: 									; address in code. 
		.fill 	2 							

zTemp0: 									; temporary words used in the interpreter.
		.fill 	2
zTemp1:
		.fill 	2
zTemp2:
		.fill 	2

		.endsection

; ************************************************************************************************
;
;							Insert an Emulator Breakpoint
;
; ************************************************************************************************

debug 		.macro
		.byte 	$DB 						; causes a break in the emulator
		.endm

; ************************************************************************************************
;
;								Set a 2 byte value in memory
;
; ************************************************************************************************

set16 		.macro
		lda 	#((\2) & $FF)
		sta 	0+\1
		lda 	#((\2) >> 8) & $FF
		sta 	1+\1
		.endm

; ************************************************************************************************
;
;										Exit emulation
;
; ************************************************************************************************

exitemu .macro
		stx 	zTemp0
		jmp 	$FFFF
		.endm

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
