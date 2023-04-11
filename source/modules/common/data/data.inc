; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		data.inc
;		Purpose:	Common Data
;		Created:	11th April 2023
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

codePtr:	 								; address of current line (allow for paging)
		.fill 	4
zTemp0: 									; temporary words used in the interpreter.
		.fill 	2
zTemp1:
		.fill 	2
zTemp2:
		.fill 	2


; ************************************************************************************************
;
;										Stack Workspace
;
; ************************************************************************************************
;
; 	bit 7 	: sign of mantissa (if float,0 otherwise)
; 	bit 6 	: reference
;
; ************************************************************************************************
;
;							The number stack (works up from zero)
;
; ************************************************************************************************

NSStatus: 									; Status bits of stack.
		.fill 	MathStackSize
NSMantissa0: 								; Mantissa on stack (address in 0,1 for string)
		.fill 	MathStackSize 				; (this is my integer mantissa system)
NSMantissa1: 								; the order of the mantissa elements is required.
		.fill 	MathStackSize
NSMantissa2:
		.fill 	MathStackSize
NSMantissa3:
		.fill 	MathStackSize
NSExponent: 								; Exponent , 0 = Mantissa is integer
		.fill 	MathStackSize

		.send zeropage


; ************************************************************************************************
;
;										Non Zero Page Data
;
; ************************************************************************************************

		.section storage
numberBuffer:
		.fill 	34
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

