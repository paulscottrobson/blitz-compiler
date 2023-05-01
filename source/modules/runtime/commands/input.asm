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
		bcs 	_INError 					; failed, try again.
		ply 								; restore Y
		.exitcmd

CommandInputString: ;; [input$]
		.entercmd
		phy 								; save Y
		.debug
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

CommandInputReset: ;; [inputstart]	
		.entercmd	
		jsr 	InputGetNewLine 			; get new line.
		.exitcmd	

InputStringToBuffer:
		.set16 	ReadBumpNextVec,InputBumpNext
		.set16 	ReadLookNextVec,InputLookNext
		jmp 	GetStringToBuffer


; ************************************************************************************************
;
;		Look at the next input character - return CS if we have new line input, forces an end.
;		$00 if end of data.
;
; ************************************************************************************************

InputLookNext:		
		phx
		ldx 	InputBufferPos 				; get head available character
		lda 	ReadBuffer,x 				
		clc
		bne 	_ILNExit 					; if not EOS return it with CC.
_ILNNextLine:		
		jsr 	InputGetNewLine 			; get a new line skip empty ones.
		lda 	InputBufferPos
		beq 	_ILNNextLine
		sec 								; return CS,Zero
		lda 	#0
		plx
		rts
_ILNExit:	
		plx
		cmp 	#0
		clc
		rts

; ************************************************************************************************
;
;								Consume 1 input character
;
; ************************************************************************************************

InputBumpNext:
		inc 	InputBufferPos
		rts

; ************************************************************************************************
;
;							Get a new line into the ReadBuffer
;
; ************************************************************************************************

InputGetNewLine:
		pha
		phx
		phy
		lda 	#"?"
		jsr 	IGNLEchoIfScreen
		ldy 	#0 							; line position.
_IGNLLoop:
		jsr 	VectorGetCharacter 			; get a character
		cmp 	#0
		beq 	_IGNLLoop
		cmp 	#$14 						; Backspace ?
		beq 	_IGNBackspace
		cmp 	#$0D 						; Return ?
		beq 	_IGNExit
		cpy 	#$FF 						; space ?
		beq 	_IGNLLoop
		sta 	ReadBuffer,y
		iny
		jsr 	IGNLEchoIfScreen
		bra 	_IGNLLoop

_IGNBackspace:
		cpy 	#0
		beq 	_IGNLLoop
		jsr 	IGNLEchoIfScreen
		dey
		bra 	_IGNLLoop
_IGNExit:
		jsr 	IGNLEchoIfScreen
		lda 	#0 							; make ASCIIZ
		sta 	ReadBuffer,y
		stz 	InputBufferPos 				; reset position to start of input buffer.
		ply
		plx
		pla
		rts		

IGNLEchoIfScreen:
		ldx 	currentChannel
		bne 	_IGNLEExit
		jsr 	VectorPrintCharacter
_IGNLEExit:				
		rts

		.send 	code
		
		.section storage
InputBufferPos:
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
