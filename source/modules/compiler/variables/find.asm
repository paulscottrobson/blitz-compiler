; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		find.asm
;		Purpose:	Find variable.
;		Created:	25th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;		  XY contains a variable name. Find it, returning address in XY and CS if found
;
; ************************************************************************************************

		.section code

FindVariable:
		stx 	zTemp1 						; save name.
		sty 	zTemp1+1
		;
		;		Check for A-Z A-Z% A-Z$
		;
		txa 								; check not array and single character
		and 	#NSSArray 
		ora 	zTemp1+1
		bne 	_IVCheckSpecial 			; if it is check for TI / TI$
		;
		;		Simple object, whose locations are pre-allocated.
		;		
		txa 								; reduce zTemp1 , 1-26 to 0-25
		and 	#31 						; strip off type bits.
		dec 	a 							; now 0-25.
		;
		sta 	zTemp0 						; multiply by 10 (bytes per single character, 2+2+6)
		asl 	a
		asl 	a
		adc 	zTemp0
		asl 	a 							; Now 0-250, base offset.
		tax 								; set up initial YX.
		ldy 	#0
		;
		lda 	zTemp1	 					; check the type bits.
		and 	#NSSTypeMask+NSSIInt16 				
		cmp 	#NSSString 					; if it is a string return this value 
		beq 	_IVExit
		inx 	 							; 2 byte spacing.
		inx 	
		cmp 	#NSSIInt16 					; 16 bit integer, return this value + 2
		beq 	_IVExit
		inx 								; float, return this value + 4 => still maxes out at 256 for Z.
		inx 	
_IVExit:		 							; and return with the type in A, address in YX.
		sec
		rts		

		;
		;		Check for TI $1409 and TI$ $5409 which return 6 and 8 as addresses.
		;
_IVCheckSpecial:		
		cpy 	#$09	 					; both end $09 e.g. I
		bne 	_IVComplex
		cpx 	#$14 						; TI is $14
		beq 	_IVTIFloat
		cpx 	#$54 						; TI$ is $54
		bne 	_IVComplex
		ldx 	#8 							; TI$ returns string at 8
		ldy 	#0
		lda 	#NSSString
		sec
		rts
_IVTIFloat: 								; TI returns ifloat at 6
		ldx 	#6
		ldy 	#0
		lda 	#NSSIFloat
		sec
		rts

_IVComplex:	
		.error_unimplemented

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
