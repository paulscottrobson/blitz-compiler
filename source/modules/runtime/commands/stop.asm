; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		stop.asm
;		Purpose:	Stop command
;		Created:	19th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										STOP command
;
; ************************************************************************************************

CommandStop: ;; [!stop]
		.entercmd
		.error_stop

; ************************************************************************************************

		.send 	code
		
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
