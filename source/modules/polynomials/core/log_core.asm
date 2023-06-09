; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		log_core.asm
;		Purpose:	Core LOG() polynomial
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									calculates LOG()
;
; ************************************************************************************************

CoreLog: 	
		lda 	#LogCoefficients & $FF
		ldy 	#LogCoefficients >> 8
		jmp 	CorePolySquared

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
