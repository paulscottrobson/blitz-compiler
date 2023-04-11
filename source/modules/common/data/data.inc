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

		.send zeropage

; ************************************************************************************************
;
;											Workspace
;
; ************************************************************************************************

AMantissa0 = $30 							; mantissa/integer A goes here
AMantissa1 = AMantissa0+1 					; standard 32 bit mantissa, bits 31/30 are 01.
AMantissa2 = AMantissa0+2
AMantissa3 = AMantissa0+3
AExponent = AMantissa0+4 					; exponent ; 0 => integer
AStatus = AMantissa0+5 						; status bits
AIntLo = AMantissa0 						; 16 bit integer usage.
AIntHigh = AMantissa1

BMantissa0 = $38 							; mantissa/integer A goes here
BMantissa1 = BMantissa0+1 					; standard 32 bit mantissa, bits 31/30 are 01.
BMantissa2 = BMantissa0+2
BMantissa3 = BMantissa0+3
BExponent = BMantissa0+4 					; exponent ; 0 => integer
BStatus = BMantissa0+5 						; status bits
BIntLo = BMantissa0 						; 16 bit integer usage.
BIntHigh = BMantissa1

UseAMantissa = 0
UseBMantissa = BMantissa0-AMantissa0

; ************************************************************************************************
;
; 	Bit 7 	: Negative flag
; 	Bit 6,5 : 00 = 16 bit Integer 10 = 32 bit Float/Integer 01 = String
; 	Bit 0   : Set if referenece
;
; ************************************************************************************************
;
;										Non Zero Page Data
;
; ************************************************************************************************

		.section storage
CMantissa0:
		.fill 	1
CMantissa1:
		.fill 	1
CMantissa2:
		.fill 	1
CMantissa3:
		.fill 	1
CExponent:
		.fill 	1
CStatus:
		.fill 	1
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

