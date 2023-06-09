; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		frames.inc
;		Purpose:	Stack frames
;		Created:	19th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;						Upper 3 bits : identifier, lower 5 : total frame size
;
; ************************************************************************************************

FRAME_GOSUB = $E4 							; Gosub has 4 bytes
FRAME_FOR = $C0+19 							; For has 19 bytes

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
