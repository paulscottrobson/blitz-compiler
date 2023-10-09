; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		api.asm
;		Purpose:	Compiler API Interface
;		Created:	9th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;									API Entry point
;
; ************************************************************************************************

		.section code

CompilerAPI:
		cmp 	#BLC_OPENIN
		beq 	_CAOpenIn
		cmp 	#BLC_CLOSEIN
		beq 	_CACloseIn
		cmp 	#BLC_READIN
		beq 	_CARead
		cmp 	#BLC_RESETOUT
		beq 	_CAResetOut
		cmp 	#BLC_CLOSEOUT
		beq 	_CACloseOut
		cmp 	#BLC_WRITEOUT
		beq 	_CAWriteByte
		cmp 	#BLC_PRINTCHAR
		beq 	_CAPrintScreen
		.debug

; ************************************************************************************************
;
;									Open source file for reading
;
; ************************************************************************************************

_CAOpenIn:	
		ldy 	#SourceFile >> 8 			; name of file
		ldx 	#SourceFile & $FF		
		jsr 	IOOpenRead 					; open file
		jsr 	IOReadByte 					; skip the 2 byte load address header
		jsr 	IOReadByte
		rts

; ************************************************************************************************
;
;									Close read source file
;
; ************************************************************************************************

_CACloseIn:
		jmp 	IOReadClose

; ************************************************************************************************
;
;								Code is stored from free memory onwards
;
; ************************************************************************************************

_CAResetOut:
		.set16 	objPtr,FreeMemory
		rts

_CACloseOut:
		rts

; ************************************************************************************************
;
;									Write byte A to free memory
;
; ************************************************************************************************

_CAWriteByte:
		txa
		sta 	(objPtr)
		inc 	objPtr
		bne 	_HWOWBNoCarry
		inc 	objPtr+1
_HWOWBNoCarry:		
		rts

; ************************************************************************************************
;
;								Print character to screen
;
; ************************************************************************************************
		
_CAPrintScreen:
		txa
		jmp 	$FFD2

; ************************************************************************************************
;
;									  Read line
;
; ************************************************************************************************

_CARead:
		jsr 	IOReadByte 				; copy the address of next into the buffer
		sta 	SourceLine+0
		jsr 	IOReadByte
		sta 	SourceLine+1
		;
		ora 	sourceLine				; if both were zero, exit with CC (e.g. fail)
		clc
		beq		_CARExit

		jsr 	IOReadByte 				; read the line # into the buffer.
		sta 	SourceLine+2
		jsr 	IOReadByte
		sta 	SourceLine+3
		;
		ldx 	#4 						; read the body of the line.
_CAReadLine:
		jsr 	IOReadByte 				; now keep copying to EOL
		sta 	SourceLine,x
		inx
		cmp 	#0
		bne 	_CAReadLine
		;		
		sec 							; read a line okay
		ldy 	#SourceLine >> 8
		ldx 	#SourceLine & $FF
_CARExit:		
		rts


;;		ldy 	#ObjectFile >> 8
;		ldx 	#ObjectFile & $FF		
;		jsr 	IOOpenWrite
;		lda 	#12
;		jsr 	IOWriteByte
;		lda 	#13
;		jsr 	IOWriteByte
;		jsr 	IOWriteClose
				
		.send code

		.section storage
SourceLine: 								; line for source code storage
		.fill 	256		
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

