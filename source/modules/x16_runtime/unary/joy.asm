; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		joy.asm
;		Purpose:	Joystick function
;		Created:	9th May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code
		
; ************************************************************************************************
;
;								JOY(n) read joystick
;
; ************************************************************************************************

UnaryJoy: ;; [!joy]
		.entercmd
		jsr 	GetInteger8Bit 				; port #
		pha 								; zero the result.
		jsr 	FloatSetZero
		pla
		phy
		phx
		jsr 	X16_joystick_get 			; read joystick.
		cpy 	#0 							; check no hardware
		bne 	_UJNoHardware

		tay 								; move XA -> AY
		txa
		plx 								; we can update it now.
		eor 	#$FF
		sta 	NSMantissa1,x
		tya
		eor 	#$FF
		sta 	NSMantissa0,x
		ply 								; restore Y
		.exitcmd

_UJNoHardware:
		plx
		ply
		lda 	#1 							; set result to -1
		jsr 	FloatSetByte
		jsr 	FloatNegate
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
