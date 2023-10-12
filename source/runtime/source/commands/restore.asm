; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		restore.asm
;		Purpose:	Restore Data Pointer
;		Created:	21st April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										RESTORE command
;
; ************************************************************************************************

CommandRestoreX: ;; [.restore]
		.entercmd
		jsr 	RestoreCodeOffset
		.exitcmd

; ************************************************************************************************
;
;										Restore to offset,
;
; ************************************************************************************************

RestoreCodeOffset:
		jsr 	FixUpY  					; make Y = 0 adjusting code Ptr.

		clc 								; add LSB
		lda 	(codePtr),y
		adc 	codePtr
		sta 	objPtr

		iny 								; add MSB
		lda 	(codePtr),y
		adc 	codePtr+1
		sta 	objPtr+1	
		iny 								; next command.
		stz 	dataRemaining 				; no data remaining.
		rts

; ************************************************************************************************
;
;							This is the classic RESTORE, to the start.
;
; ************************************************************************************************

RestoreCode:
		lda 	runtimeHigh 				; reset pointer
		sta 	objPtr+1
		stz 	objPtr
		stz 	dataRemaining 				; no data remaining.
		rts

		.send 	code

		.section storage
dataRemaining: 								; number of bytes remaining in current data statement
		.fill 	1		 					; 0 if not in data statement
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
