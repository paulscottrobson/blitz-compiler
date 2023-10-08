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

CommandXInput: ;; [input]
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

CommandInputReset: ;; [input.start]	
		.entercmd	
		stz 	InputBuffer
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
_ILNRetry:		
		lda 	InputBuffer 				; do we need to read more (e.g. the buffer is empty)
		bne 	_ILNNotEmpty
		jsr 	InputGetNewLine 			; get a new line 
		stz 	InputBufferPos 				; reset read position.
		bra 	_ILNRetry

_ILNNotEmpty:		
		ldx 	InputBufferPos 				; get head available character
		lda 	InputBuffer,x 				
		bne 	_ILNExit 					; if not EOS return it with CC.
_ILNNextLine:		
		stz 	InputBuffer 				; clear the buffer, indicating new line next time.
		sec 								; return CS,Zero
		plx
		lda 	#13 						
		rts
_ILNExit:	
		plx
		cmp 	#0 							; return CC, Z Flag set.
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
		cpy 	#80 						; buffer full ?
		beq 	_IGNLLoop
		sta 	InputBuffer,y
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
		sta 	InputBuffer,y
		stz 	InputBufferPos 				; reset position to start of input buffer.
		ply
		plx
		pla
		rts		

; ************************************************************************************************
;
;								Print A if output channel is screen.
;
; ************************************************************************************************

IGNLEchoIfScreen:
		ldx 	currentChannel
		bne 	_IGNLEExit
		jsr 	VectorPrintCharacter
_IGNLEExit:				
		rts

		.send 	code
		
		.section storage
InputBuffer:
		.fill 	81		
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
