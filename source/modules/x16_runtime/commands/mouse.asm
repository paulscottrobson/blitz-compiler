; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		mouse.asm
;		Purpose:	Mouse commands/functions
;		Created:	9th May 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								MOUSE command
;
; ************************************************************************************************

XCommandMouse: ;; [!mouse]
		.entercmd
		jsr 	GetInteger8Bit 				; mouse control.
		dex
		phx
		phy
		pha
		sec 								; get screen resolution
		jsr 	X16_screen_mode
		pla
		jsr 	X16_mouse_config 			; config the mouse
		ply
		plx
		.exitcmd

; ************************************************************************************************
;
;									Mouse status functions
;
; ************************************************************************************************

XUnaryMB: ;; [!mb]
		.entercmd
		jsr 	XUnaryMouseCommon
		lda 	zTemp2
		inx
		jsr 	FloatSetByte
		.exitcmd

XUnaryMX: ;; [!mx]
		.entercmd
		jsr 	XUnaryMouseCommon
		lda 	zTemp0
		inx
		jsr 	FloatSetByte
		lda 	zTemp0+1
		sta 	NSMantissa1,x
		.exitcmd

XUnaryMY: ;; [!my]
		.entercmd
		jsr 	XUnaryMouseCommon
		lda 	zTemp1
		inx
		jsr 	FloatSetByte
		lda 	zTemp1+1
		sta 	NSMantissa1,x
		.exitcmd

XUnaryMouseCommon:
		phx
		phy
		ldx 	#zTemp0
		jsr 	X16_mouse_get
		sta 	zTemp2
		ply
		plx
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
