; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		generator.asm
;		Purpose:	Generation processor
;		Created:	16th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code
	
; ************************************************************************************************
;
;						Generator for data at YX, first token in A
;					  		CS succeed, A = type, CC = Fail.
;
; ************************************************************************************************

GeneratorProcess:
		stx 	zTemp0 						; save generation pointer in zTemp0
		sty 	zTemp0+1
		;
		sta 	zTemp1 						; first match token
		stz 	zTemp1+1
		;
		;		X16 shift of $CE
		;
		.if module_x16_compiler == 1
		cmp 	#$CE 						; check if shift
		bne 	_GPNotShifted
		jsr 	GetNext 					; get the shifted token
		sta 	zTemp1+1 					; match CE xx
_GPNotShifted:
		.endif
		;
		;		Find the generator entry.
		;		
_GPSearch:		
		lda 	(zTemp0) 					; reached end ?
		clc
		beq 	_GPExit
		;
		ldy 	#1 							; tokens match
		lda 	(zTemp0),y
		cmp 	zTemp1
		bne 	_GPNext

		lda 	zTemp1+1 					; 2nd token ?
		beq 	_GPFound

		iny 								; check match.
		cmp 	(zTemp0),y
		beq 	_GPFound
		;
_GPNext:	
		clc 								; follow to next
		lda 	zTemp0		
		adc 	(zTemp0)
		sta 	zTemp0
		bcc 	_GPSearch
		inc 	zTemp0+1
		bra 	_GPSearch
		;
_GPFound:	
		clc 								; skip to action bytes		
		lda 	zTemp0 						; <offset> <token lo> <token hi> first
		adc 	#3
		sta 	zTemp0
		bcc 	_GPNoCarry
		inc 	zTemp0+1
_GPNoCarry:
		;
		;		Main execution loop.
		;		
_GPLoop:
		jsr 	GeneratorExecute 			; execute one command
		bcc 	_GPLoop 					; go back if not completed.
		sec 								; return with CS.
_GPExit:
		rts

		.send  code		

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
