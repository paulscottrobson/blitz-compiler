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
;										   Status Bits
;
; 	bit 7 	: sign of mantissa (if float,0 otherwise)
; 	bit 6,5 : 00 (float, 5/6 byte if reference) type 01 (integer, 2 byte if reference) 
;			  type 1x (string) 0x (32 bit iFloat)
;
; ************************************************************************************************
;
;							The number stack (works up from zero)
;
; ************************************************************************************************

NSSString = $40 							; string vs typemask
NSSIFloat = $00 							; ifloat vs typemask
NSSIInt16 = $20								; when set, a reference is a 16 bit reference (e.g. a%)
NSSTypeMask = $40 					
NSSArray = $80  							; array (in variable code)

		.align 16
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

