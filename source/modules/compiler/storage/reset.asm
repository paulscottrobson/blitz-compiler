; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		reset.asm
;		Purpose:	Reset information storage
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Reset the storage (variables,line#)
;
; ************************************************************************************************

STRReset:
		.set16  variableListEnd,WorkArea 	; set up the two table pointers
		.set16 	lineNumberTable,WorkArea+WorkAreaSize
		.storage_access 					; clear the head of the work area list.
		stz 	WorkArea
		.storage_release
		.set16 freeVariableMemory,0 		; clear the free variable memory record.
		rts
		.send code


		.section storage
lineNumberTable:							; line number table, works down.
		.fill 	2		
variableListEnd:							; known variables, works up.
		.fill 	2	
freeVariableMemory: 						; next free memory slot
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
