; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_vpoke.asm
;		Purpose:	VPoke command
;		Created:	29th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code
		
; ************************************************************************************************
;
;								VPOKE bank,address,data
;
; ************************************************************************************************

CommandVPOKE: ;; [vpoke]
		.entercmd

		jsr 	GetInteger8Bit 				; poke value
		pha
		dex

		.floatinteger 						; address (MED/LO)
		lda 	NSMantissa0,x
		sta 	VRAMLow0
		lda 	NSMantissa1,x
		sta 	VRAMMed0
		dex

		.floatinteger 						; address (HI)
		jsr 	GetInteger8Bit
		sta 	VRAMHigh0
		dex

		pla 								; poke value back
		sta 	VRAMData0					; and write it out.

		.exitcmd

; ************************************************************************************************
;
;								VPOKE bank,address,data
;
; ************************************************************************************************

CommandVPEEK: ;; [vpeek]
		.entercmd

		.floatinteger 						; address (MED/LO)
		lda 	NSMantissa0,x
		sta 	VRAMLow0
		lda 	NSMantissa1,x
		sta 	VRAMMed0
		dex

		.floatinteger 						; address (HI)
		jsr 	GetInteger8Bit
		sta 	VRAMHigh0

		lda 	VRAMData0					; read data
		jsr 	FloatSetByte 				; return as byte
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
