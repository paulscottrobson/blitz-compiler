; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		input.asm
;		Purpose:	Input commands
;		Created:	1stMay 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										Input Commands
;
; ************************************************************************************************

CommandInput: ;; [input]
		.entercmd
		phy 								; save Y
		inx									; space on stack
_INError:		
		jsr 	InputStringToBuffer 		; input from keyboard
		.set16 	zTemp0,ReadBufferSize		; convert from here
		jsr 	ValEvaluateZTemp0
		bcs 	_INError 					; failed
		ply 								; restore Y
		.exitcmd

CommandInputString: ;; [input$]
		.entercmd
		phy 								; save Y
		jsr 	InputStringToBuffer 		; input from keyboard
		inx 								; make space on stack
		jsr 	FloatSetZero 				; store as string on stack
		lda 	#ReadBufferSize & $FF
		sta 	NSMantissa0,x
		lda 	#ReadBufferSize >> 8
		sta 	NSMantissa1,x
		lda 	#NSSString
		sta 	NSStatus,x
		ply 								; restore Y
		.exitcmd

; ************************************************************************************************

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
