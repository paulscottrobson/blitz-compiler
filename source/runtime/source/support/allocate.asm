; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		allocate.asm
;		Purpose:	Allocate variable memory
;		Created:	25th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;					Command which receives limit of variable memory
;
; ************************************************************************************************

CommandVarSpace: ;; [.varspace]
		.entercmd
		
		lda 	(codePtr),y					; 3 byte opcode, which is 'free' memory in variable area.
		sta 	availableMemory
		iny 
		lda 	(codePtr),y
		clc 
		adc 	#WorkArea >> 8 				; offset to actual address.
		sta 	availableMemory+1
		iny

		.exitcmd
		.send 	code

		.section zeropage
availableMemory: 							; available memory as offset
		.fill 	2
		.send zeropage

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
