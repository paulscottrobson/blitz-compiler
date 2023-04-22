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
;										ASSERT command
;
; ************************************************************************************************

CommandRestore: ;; [restore]
		.entercmd
		jsr 	RestoreCode
		.exitcmd

RestoreCode:
		.set16 	dataPtr,EndProgram+2 		; reset pointer and page
		stz  	dataPage
		stz 	dataRemaining 				; no data remaining.
		rts

		.send 	code

		.section storage
dataPage: 									; current data pointer
		.fill 	1
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
