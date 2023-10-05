; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_config.inc
;		Purpose:	Configuration for compiler
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************
;
;		Runtime p-code goes here. Needs to be on a page boundary.
;
PCodeStart = $4000
;
;		Work area space and size. Upwards is variables, Downwards is line number positions.
;
WorkArea = $8000
WorkAreaSize = $1F00

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
