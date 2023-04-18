; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		identify.asm
;		Purpose:	Identify, find, create variables
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;			A is first character of variable ; identify it, creating it if necessary.
;
;	On exit YX contains the address of the variable. If this is $FFFF the address is on the stack
;	(for arrays). The base type are kept in bits 7,6,5 (bit 7 identifying it as an array)
; 	
;	The address is an offset from the data area, not a physical address
;
; ************************************************************************************************

		.section code

IdentifyVariable:
		;
		;		One or two character variable ?
		;
		and 	#31 						; reduce first character to 5 bits
		sta 	zTemp1 						; we'll build it in zTemp1
		stz 	zTemp1+1
		;
		jsr 	LookNext 					; is there a second character ?
		jsr 	CharIsAlpha  				; must be alphanumeric 
		bcs 	_IVHasSecond
		jsr 	CharIsDigit
		bcc 	_IVCheckType
_IVHasSecond:
		and 	#63 						; 6 bit ASCII.
		sta 	zTemp1+1
		jsr 	GetNext 					; consume it
		;
		;		Check for % $ postfix.
		;
_IVCheckType:
		jsr 	LookNext					; check if string follows.
		ldx 	#NSSString
		cmp 	#"$"
		beq 	_IVHasType
		ldx 	#NSSIInt16 					; check if short int follows e.g. 16 bit
		cmp 	#"%"
		bne 	_IVCheckArray
_IVHasType:
		txa 								; Or X into zTemp1
		ora 	zTemp1
		sta 	zTemp1		
		jsr 	GetNext 					; consume it
		;
		;		Check for ( postfix
		;
_IVCheckArray:
		jsr 	LookNext 					; check if array follows
		cmp 	#"("
		bne 	_IVCheckSimple
		lda 	zTemp1 						; set array bit
		ora 	#NSSArray
		sta 	zTemp1		
		jsr 	GetNext 					; consume it
		;
		;		Check for A-Z A-Z% A-Z$
		;
_IVCheckSimple:
		lda 	zTemp1 						; check not array and single character
		and 	#NSSArray 
		ora 	zTemp1+1
		beq 	_IVIsSimple
		.error_unimplemented 				; TODO: Handle complex variables.
		;
		;		Simple object.
		;		
_IVIsSimple:
		lda 	zTemp1 						; reduce zTemp1 , 1-26 to 0-25
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
		rts		

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
