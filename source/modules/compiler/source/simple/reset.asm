; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		reset.asm
;		Purpose:	Reset to scan the BASIC source code.
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Reset the input system
;
; ************************************************************************************************

HWIReset:
		.set16 	inputPtr,EndProgram+2 		; the current read point.		
		sec 
		lda 	inputPtr 					; calculate loaded address - load address
		sbc 	EndProgram 					; when added to a link address => real address 
		sta 	offsetAdjust
		lda 	inputPtr+1
		sbc 	EndProgram+1
		sta 	offsetAdjust+1

; ************************************************************************************************
;
;					Update srcPtr with the start of the tokenised code
;
; ************************************************************************************************

HWISetTokenisedCodePtr:
		clc		
		lda 	inputPtr
		adc 	#4
		sta 	srcPtr
		lda 	inputPtr+1
		adc 	#0
		sta 	srcPtr+1
		rts

		.send code

		.section zeropage
inputPtr: 									; current input line
		.fill 	2
srcPtr:	 									; pointer to source code.
		.fill 	2		
		.send zeropage

		.section storage
offsetAdjust:
		.fill 	2		
		.send storage

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
