; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		config.inc
;		Purpose:	Configuration for runtime
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************
;
;		Build address
;
CodeStart = $801
;
;		Runtime p-code address
;
PCodeStart = $4000
;
;		Work area space and size
;
WorkArea = $8000
WorkAreaSize = $1F00
;
;		Calculate top string address, e.g. stack/string seperation
;
StringTopAddress = WorkArea + WorkAreaSize - (1 + (WorkAreaSize >> 4)) * 256
StackTopAddress = WorkArea + WorkAreaSize

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

