; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		write_int.asm
;		Purpose:	WriteInteger
;		Created:	13th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;							  Macro to set up working address
;
; ************************************************************************************************

vaddress .macro
		lda 	(codePtr),y 				; get the LSB of the halved offset.
		sta 	zTemp0 						; save in MSB

		dey 								; get the upper 3 bits
		lda 	(codePtr),y
		and 	#7
		iny
		iny

		asl 	zTemp0 						; shift zTemp0:A left
		rol 	a 							; carry will be clear.
		adc 	#VariableStart >> 8 		; point to variable page.
		sta 	zTemp0+1
		.endm

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