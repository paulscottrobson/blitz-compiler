; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		testing.asm
;		Purpose:	Basic testing for ifloat32 (only built if float is main)
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

		.if ismain_ifloat32 == 1
Boot:	
		ldx 	#5
_CopyNumbers:
		lda 	TestConstants,x
		sta 	AMantissa0,x		
		lda 	TestConstants+6,x
		sta 	BMantissa0,x		
		dex 
		bpl 	_CopyNumbers

		ldx 	#UseAMantissa
		jsr 	FloatNormaliseX
		ldx 	#UseBMantissa
		jsr 	FloatNormaliseX

		jmp 	$FFFF


TestConstants:
		.include "../generated/testnumbers.dat"

		.endif		
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
