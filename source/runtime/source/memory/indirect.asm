; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		indirect.asm
;		Purpose:	Indirect Read/Writes
;		Created:	27th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								<offset> [#%$]@ <data
;
; ************************************************************************************************

rcall 	.macro
		.entercmd
		lda 	NSMantissa0,x 				; copy address
		sta 	zTemp0
		lda 	NSMantissa1,x
		clc
		adc 	variableStartPage
		sta 	zTemp0+1
		dex 								; throw the address
		jsr 	\1 							; call read routine
		.exitcmd
		.endm

IndFloatRead:
		.rcall 	ReadFloatZTemp0Sub
IndInt16Read:
		.rcall 	ReadIntegerZTemp0Sub
IndStringRead:
		.rcall 	ReadStringZTemp0Sub

; ************************************************************************************************
;
;								<offset> <data> [#%$]!
;
; ************************************************************************************************

wcall .macro
		.entercmd
		lda 	NSMantissa0-1,x 			; copy address
		sta 	zTemp0
		lda 	NSMantissa1-1,x
		clc
		adc 	variableStartPage
		sta 	zTemp0+1
		jsr 	\1 							; call write routine
		dex 								; throw the address as well.
		.exitcmd
		.endm

IndFloatWrite:
		.wcall 	WriteFloatZTemp0Sub
IndInt16Write:
		.wcall 	WriteIntegerZTemp0Sub
IndStringWrite:
		.wcall 	WriteStringZTemp0Sub

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
