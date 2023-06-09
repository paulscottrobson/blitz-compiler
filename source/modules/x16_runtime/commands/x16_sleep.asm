; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_sleep.asm
;		Purpose:	Sleep for n ticks
;		Created:	9th May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;									Sleep for N ticks.
;
; ************************************************************************************************

XCommandSleep: ;; [!sleep]
		.entercmd
		phy
		.floatinteger 						; make everything integer
		dex
		jsr 	XReadClock 					; read clock to YXA
		;
		clc 								; calculate end time in zTemp0
		adc 	NSMantissa0
		sta 	zTemp0
		txa
		adc 	NSMantissa1
		sta 	zTemp0+1

_XCWait:
		jsr 	XReadClock 					; and wait for it.
		cmp 	zTemp0
		bne 	_XCWait
		cpx 	zTemp0+1
		bne 	_XCWait

		ldx 	#$FF
		ply
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
