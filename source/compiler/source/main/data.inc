; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		data.inc
;		Purpose:	Compiler Data
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;									Mandatory Zero page code
;
; ************************************************************************************************

		.section zeropage
srcPtr: 									; pointer in source buffer
		.fill 	2		
		.send zeropage


; ************************************************************************************************
;
;										Non Zero Page Data
;
; ************************************************************************************************

		.section storage
currentLineNumber:							; current line number.
		.fill 	2		
		.send 	storage

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

