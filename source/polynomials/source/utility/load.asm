; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		load.asm
;		Purpose:	Load constant offset Y into X+1, preserving X
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;									Load Constant
;
; ************************************************************************************************

LoadConstant:
		phy
		tay
		lda 	Const_Base+0,y
		sta 	NSMantissa0+1,x
		lda 	Const_Base+1,y
		sta 	NSMantissa1+1,x
		lda 	Const_Base+2,y
		sta 	NSMantissa2+1,x
		lda 	Const_Base+3,y
		pha
		and 	#$7F
		sta 	NSMantissa3+1,x
		pla
		and 	#$80
		sta 	NSStatus+1,x
		lda 	Const_Base+4,y
		sta 	NSExponent+1,x
		ply
		rts

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