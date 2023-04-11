; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		system.inc
;		Purpose:	Information for Runtime/Compiler (copied from Runtime->Compiler)
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

;
;		Storage size of integer in bytes (2 or 4 normally)
;
SYSIntSize = 2
;
;		Storage size for float (sign backed in Mantissa3 MSB)
;
SYSFloatSize = 6
;
; 		Storage size for string (these pointers can be zero)
;
SYSStringSize = 2
;
;		Size of destinations for GOTO, GOSUB and RETURN
;
SYSCodeAddressSize = 2

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
