; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		concrete.asm
;		Purpose:	Concrete string memory
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;									Concrete String YA -> YA
;
; ************************************************************************************************

StringConcrete:	
		stz 	stringInitialised	 		; initialise next usage

		sty 	zTemp2+1 					; save pointer to new string
		sta 	zTemp2
		;
		lda 	(zTemp2) 					; length required
		lsr 	a 							; allow half as much for expansion.
		clc
		adc 	(zTemp2)
		bcc 	_SCNoOverflow
		lda 	#255
_SCNoOverflow:
		cmp 	#10 						; and a minimum of 10
		bcs 	_SCNoMinimum		
		lda 	#10
_SCNoMinimum:
		sta 	zTemp1 						; save max length.
		;
		sec
		lda		stringHighMemory 			; subtract max length from high memory.
		sbc 	zTemp1
		tay
		lda 	stringHighMemory+1 	
		sbc 	#0
		pha
		;
		sec 								; subtract 3 more
		tya 							
		sbc 	#3
		sta 	stringHighMemory 			; to string high memory/zsTemp
		sta 	zsTemp
		;
		pla
		sbc 	#0
		sta 	stringHighMemory+1
		sta 	zsTemp+1
		;
		lda 	zTemp1 						; set max length.
		sta 	(zsTemp)
		ldy 	#1 							; clear control byte.
		lda 	#0
		sta 	(zsTemp),y
		;
		lda 	zsTemp 						; new empty string in YA.
		ldy 	zsTemp+1
		rts

		.send code

; ************************************************************************************************
;
;		Concreted string (total size = MaxLength + 3)
;
;		[Max length] [Control] [Act Length] [Data]
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
