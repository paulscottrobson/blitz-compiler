; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		testing.asm
;		Purpose:	Basic testing for runtim
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

WrapperBoot:
		lda 	#ObjectCode >> 8 			; address of object code to run.	
		ldx 	#$81 						; first page of allocatable memory
		ldy 	#$9F 						; byte after end of last page.
		jsr 	StartRuntime 				; try to run it
_WBStopOnError: 							; error, halt here.
		bcs 	_WBStopOnError		
		jmp 	$FFFF 						; then exit.

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
