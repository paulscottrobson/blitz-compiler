; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		pushnumber.asm
;		Purpose:	Push number onto stack 
;		Created:	14th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								Push Number <LEN> <ASCIIZCount>
;
; ************************************************************************************************

CommandPushN: ;; [.float]
		.entercmd
		inx 								; next slot on stack		
		lda 	(codePtr),y 				; get count
		sta 	numCharCount
		iny

		lda 	(codePtr),y 				; do first.
		jsr 	FloatEncodeStart
		iny

_PushNLoop:	
		dec 	numCharCount 				; done all ?
		beq 	_PushNExit
		lda 	(codePtr),y 				; get next.
		iny
		jsr 	FloatEncodeContinue 		; encode it
		bra 	_PushNLoop 					; go round again.

_PushNExit:		
		lda 	#0 							; forces completion
		jsr 	FloatEncodeContinue
		.exitcmd

		.send 	code
		
		.section storage
numCharCount:
		.fill 	1
		.send storage

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
