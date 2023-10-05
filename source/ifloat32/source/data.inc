; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		data.inc
;		Purpose:	iFloat32 data.
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

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

		.section zeropage

;
;		Size of stack
;
MathStackSize = 12

;
;		Constants used.
;
NSSString = $40 							; string vs typemask
NSSIFloat = $00 							; ifloat vs typemask
NSSIInt16 = $20								; when set, a reference is a 16 bit reference (e.g. a%)
NSSTypeMask = $40 					
NSSArray = $80  							; array (in variable code)

;
;		Stack data.
;
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

