; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		read.asm
;		Purpose:	Data extraction functions
;		Created:	22nd April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;						Extracts from Data as a string/number
;
; ************************************************************************************************

CommandXRead: ;; [read]
		.entercmd
		phy 								; save Y
		jsr 	ReadStringToBuffer 			; read element into buffer
		inx									; space on stack
		.set16 	zTemp0,ReadBufferSize		; convert from here
		jsr 	ValEvaluateZTemp0
		bcs 	_CRError 					; failed
		ply 								; restore Y
		.exitcmd

_CRError:
		.error_value

CommandReadString: ;; [read$]
		.entercmd
		phy 								; save Y
		jsr 	ReadStringToBuffer 			; read text
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
;
;									Get string into buffer
;
; ************************************************************************************************

ReadStringToBuffer:
		.set16 	ReadBumpNextVec,ReadBumpNext
		.set16 	ReadLookNextVec,ReadLookNext
GetStringToBuffer:		
		jsr		GetLookNext 				; skip all leading spaces.
		beq 	_RBError 					; end of data
		bcs 	GetStringToBuffer 			; switched to new data line.
		cmp 	#' ' 						; non space got something
		bcs 	_RBNoSpace
		jsr 	GetBumpNext 				; consume space and loop round.
		bra 	GetStringToBuffer
_RBNoSpace:
		stz 	ReadBufferSize 				; empty the buffer.
		cmp 	#'"' 						; is it a '"'
		bne 	_RBCommaSep
		sta 	ReadSep 					; use as a seperator
		jsr 	GetBumpNext 				; consume the '"'
		bra 	_RBGetText
_RBCommaSep:	
		lda 	#","						; get till comma 		
		sta 	ReadSep
		;
		;		Main loop
		;
_RBGetText:		
		jsr 	GetLookNext 				; what follows
		bcs 	_RBEndGet 					; if new DATA line, the end without consumption
		jsr 	GetBumpNext 				; consume it whatever
		cmp 	ReadSep 					; if found the seperator.
		beq 	_RBEndGet 					; exit after consumption
		phx
		ldx 	ReadBufferSize 				; copy into buffer.
		inc 	ReadBufferSize
		sta 	ReadBuffer,x
		stz 	ReadBuffer+1,x 				; make ASCIIZ as well.
		plx
		bra 	_RBGetText
_RBEndGet: 									; value is in the read buffer,	
		cmp 	#'"'
		bne 	_RBNotQuote
		jsr 	GetBumpNext
_RBNotQuote:		
		rts

_RBError:
		.error_data

GetBumpNext:
		jmp 	(ReadBumpNextVec)
GetLookNext:
		jmp 	(ReadLookNextVec)

; ************************************************************************************************
;
;		Look at the next data element - return CS if we have changed lines, forces an end.
;		$00 if end of data.
;
; ************************************************************************************************

ReadLookNext:
		lda 	dataRemaining 				; any data remaining
		beq 	_RLNFindData
		lda 	(objPtr) 					; return that object.
		clc
		rts
_RLNFindData:
		lda 	(objPtr) 					; see where we are
		cmp 	#$FF 						; if at $FF then end, error.
		beq 	_RLNNoData
		cmp 	#PCD_CMD_DATA 				; Found DATA
		beq 	_RLNHaveData
_RLNNext:		
		jsr 	MoveObjectForward			; else scan forward.
		bra 	_RLNFindData
		;
_RLNHaveData:
		ldy 	#1 							; get length
		lda 	(objPtr),y		
		beq 	_RLNNext 					; skip if DATA alone
		jsr 	ReadBumpNext 				; advance by two
		jsr 	ReadBumpNext
		sta 	dataRemaining 				; set data left count.
		sec
		rts
_RLNNoData: 								; out of data.
		lda 	#0
		sec
		rts		

; ************************************************************************************************
;
;								Consume 1 data character
;
; ************************************************************************************************

ReadBumpNext:
		inc 	objPtr
		bne 	_RBNSkip
		inc 	objPtr+1
_RBNSkip:		
		dec 	dataRemaining
		rts		
		.send code
		
		.section storage 				
ReadSep:									; read seperator.
		.fill 	1
ReadBufferSize: 							; buffer for read.
		.fill 	1		
ReadBuffer:
		.fill 	255		
ReadBumpNextVec: 							; data vectors
		.fill 	2		
ReadLookNextVec:
		.fill 	2		
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
