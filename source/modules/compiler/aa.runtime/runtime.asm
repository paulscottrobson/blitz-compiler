; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		runtime.asm
;		Purpose:	Runtime interpreter main
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

Boot:	
		ldx 	#$FF
		txs
		
h1:		bra 	h1

		;  TODO: Clear data area.
		;  TODO: Reset System
MainCompileLoop:
		;  TODO: GetNextLine
		;  Exit if finished
		;  TODO: Check for implied assignment
		;  TODO: Dispatch appropriately via scanned command handler.

MainCompileExit:
		;  TODO: Patch up GOTO, GOSUB and (possibly) IF
		;  TODO: Possibly append variable map ?
		;  TODO: Write code out to disk

ErrorHandler:
		.debug
		bra 	ErrorHandler

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
