; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		spctabprint.asm
;		Purpose:	Print SPC()/TAB()/TABSTOP functionality
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;						  		Print to next TAB stop
;
; ************************************************************************************************

PrintTab: ;; [print.tab]
		.entercmd
		jsr 	XGetHPos
_PTMod10: 									; subtract 10 till borrow
		sec
		sbc 	#10
		bcs 	_PTMod10		
		eor 	#255 						; subtract from 10 effectively. negate it
		inc 	a 							; if modulus is 0, then this will be -10 => 10
		bra 	PrintSpaceLoop

; ************************************************************************************************
;
;						  		Print to TAB() e.g. position
;
; ************************************************************************************************

PrintPos: ;; [print.pos]
		.entercmd
		jsr		XGetHPos 					; get current position
		sta 	zTemp0
		sec 								; calculate spaces required
		lda 	NSMantissa0,x 				
		dex
		sbc 	zTemp0
		bcs 	PrintSpaceLoop 				; if >= 0 then do that many spaces
		.exitcmd

; ************************************************************************************************
;
;						  			Print SPC(S[X])
;
; ************************************************************************************************

PrintSpace: ;; [print.spc]
		.entercmd
		lda 	NSMantissa0,x 	
		dex
PrintSpaceLoop:	
		cmp 	#0
		beq 	_PSExit
		pha
		lda 	#" "
		jsr 	VectorPrintCharacter
		pla
		dec 	a
		bra 	PrintSpaceLoop
_PSExit:
		.exitcmd
		
		.send code

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
