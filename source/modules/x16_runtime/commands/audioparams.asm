; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		audioparams.asm
;		Purpose:	Audio Parameter functions for FM_ PSG_
;		Created:	9th May 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								Get parameters either as A:0X or A:YX
;
; ************************************************************************************************

X16_Audio_Parameters8_16:
		jsr 	X16_Audio_Parameters8_8	
		ldy 	NSMantissa1+1
		rts

X16_Audio_Parameters8_8:
		ldx 	#1
		.floatinteger
		dex
		.floatinteger
		jsr 	GetInteger8Bit
		ldx 	NSMantissa0+1
		ldy 	#0
		rts

; ************************************************************************************************
;
;						Get parameters as a string : A:Length YX:String
;
; ************************************************************************************************

X16_Audio_Parameters8_String:
		jsr 	X16_Audio_Parameters8_16 	; get as numbers.
		;
		phx 								; set the voice
		phy
		jsr 	X16_JSRFAR
		jsr 	X16A_bas_playstringvoice
		.byte 	X16_AudioCodeBank
		ply
		plx
		;
		stx 	zTemp0
		sty 	zTemp0+1
		lda 	(zTemp0) 					; read length
		inx 								; point YX to first character.
		bne 	_X16APSSkip
		iny
_X16APSSkip:
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
