; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		gosub.asm
;		Purpose:	Gosub/Return commands
;		Created:	19th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								Gosub <Page and Address follows>
;
; ************************************************************************************************

CommandGosub: ;; [.gosub]
		.entercmd
		lda 	#FRAME_GOSUB
		jsr 	StackOpenFrame
		jsr 	StackSaveCurrentPosition
		jmp 	PerformGOTO

CommandReturn: ;; [return]
		.entercmd
		lda 	#FRAME_GOSUB
		jsr 	StackFindFrame
		jsr 	StackLoadCurrentPosition
		iny
		iny
		jsr 	StackCloseFrame
		.exitcmd


		.send 	code
		
; ************************************************************************************************
;
;									Changes and Updates
;
; ************************************************************************************************
;
;		Date			Notes
;		==== 			=====
;		22/06/23 		Uses FindFrame on Return, so will throw any incomplete NEXTs.
;
; ************************************************************************************************
