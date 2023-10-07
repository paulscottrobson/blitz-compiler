; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		on.asm
;		Purpose:	Handler for On/Goto and On/Gosubj
;		Created:	21st April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;						On <GOTO> xxx <moreon> <GOTO> xxx <moreon> etc.
;
; ************************************************************************************************
;
;		ON a GOSUB 100,200,300 is compiled as
;		
;		<get a> ON GOSUB100 MOREON GOSUB200 MOREON GOSUB300
;

CommandOn: ;; [on]
		.entercmd
		jsr 	GetInteger8Bit 				; get the integer part, the ON x GOTO bit
		sta 	onCount 					; save it.
		jsr 	FixUpY 						; Y = 0
_CONFind:
		dec 	onCount 					; reached zero, do this one
		beq 	_CONFound
		iny 								; skip over the token (GOTO or GOSUB page, and line #)
		iny
		iny
		iny
		lda 	(codePtr),y 				; is there a moreon after it, if so we can keep going.
		iny
		cmp 	#PCD_MOREON
		beq 	_CONFind
		dey 								; point to character after last GOTO/GOSUB
_CONFound:
		.exitcmd

; ************************************************************************************************
;
;		MOREON is executed on return from ON GOSUB and simply skips all the options
;		remaining.
;
; ************************************************************************************************

CommandMoreOn: ;; [moreon] 					
		.entercmd 							; executing MoreOn skips the whole following GOTO
		iny 								; so it goes to the first non-goto/gosub
		iny
		iny
		.exitcmd

		.send 	code
		
		.section storage
onCount:
		.fill 	1		
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
