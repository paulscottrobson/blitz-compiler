; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		object.asm
;		Purpose:	Write object code out.
;		Created:	9th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;									Write object code out.
;
; ************************************************************************************************

WriteObjectCode:
		jsr 	PatchOutCompile 			; makes it run the runtime on reload								

		ldy 	#ObjectFile >> 8
		ldx 	#ObjectFile & $FF				
		jsr 	IOOpenWrite 				; open write

		lda 	#1 							; write out the load address $0801
		jsr 	IOWriteByte
		lda 	#8
		jsr 	IOWriteByte

		.set16 	zTemp0,StartBasicProgram 	; now write out the whole lot as far as objPtr
_WOCLoop:
		lda 	(zTemp0) 					; write code
		jsr 	IOWriteByte
		inc 	zTemp0 						; advance pointer
		bne 	_WOCSkip
		inc 	zTemp0+1
_WOCSkip:
		lda 	zTemp0 						; check end
		cmp 	objPtr
		bne 	_WOCLoop
		lda 	zTemp0+1
		cmp 	objPtr+1
		bne 	_WOCLoop
		jsr 	IOWriteClose 				; close the file.
		rts

		.send code

		.section storage
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
