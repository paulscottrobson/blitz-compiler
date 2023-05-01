; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		input.asm
;		Purpose:	INPUT command
;		Created:	1st May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;											INPUT
;
; ************************************************************************************************

CommandINPUT:
		jsr 	LookNextNonSpace 			; check for "
		cmp 	#'"'
		bne 	CommandINPUTStream
		jsr 	CompileExpressionAt0
		.keyword PCD_PRINTCMD_S
		lda 	#","
		jsr 	CheckNextComma
CommandINPUTStream:
		.keyword PCD_INPUTSTART 			; new INPUT.
		ldx 	#PCD_INPUT
		ldy 	#PCD_INPUTDOLLAR
		jmp 	CommandReadInputCommon

		.send code

; ************************************************************************************************
;
;		Notes:
;			INPUT has an optional prompt ; INPUT# skips this code <string> print.s
;			Do the actual input.
;			Ignore blank lines.
; 			Behaves like READ in that it will grab data read , store keep going until have
; 			everything, use of , and "" etc.
;
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
