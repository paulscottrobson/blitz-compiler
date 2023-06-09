; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		swap.asm
;		Purpose:	Swap top two stack elements
;		Created:	28th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									Swap top two elements
;
; ************************************************************************************************

swap 	.macro
		lda 	\1,x
		pha
		lda 	\1-1,x
		sta 	\1,x
		pla
		sta 	\1-1,x
		.endm

CommandSwap: ;; [swap]
		.entercmd
		.swap 	NSMantissa0		  
		.swap 	NSMantissa1
		.swap 	NSMantissa2		  
		.swap 	NSMantissa3		  
		.swap 	NSExponent		  
		.swap 	NSStatus
		.exitcmd
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
