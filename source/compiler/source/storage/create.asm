; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		create.asm
;		Purpose:	Create variable.
;		Created:	25th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;		  		   XYmake  contains a variable name. Allocate space for it and create it. 
;										Return variable address in YX
;
; ************************************************************************************************

		.section code

CreateVariableRecord:
		pha

		.storage_access

		lda 	freeVariableMemory 		; push current free address on stack.
		pha
		lda 	freeVariableMemory+1
		pha

		lda 	variableListEnd  		; copy end of list to zTemp0
		sta 	zTemp0	
		lda 	variableListEnd+1
		sta 	zTemp0+1

		lda 	#6 						; default size if 6 (offset link 3 bytes)
		sta 	(zTemp0)

		tya
		ldy 	#2 						; write out the name.
		sta 	(zTemp0),y
		dey
		txa
		sta 	(zTemp0),y

		ldy 	#3 						; write out the address.
		lda 	freeVariableMemory
		sta 	(zTemp0),y
		iny
		lda 	freeVariableMemory+1
		sta 	(zTemp0),y

		ldy 	#6 						; write EOL marker next record.
		lda 	#0
		sta 	(zTemp0),y

		clc
		lda 	(zTemp0) 				; add offset to variableListEnd
		adc  	variableListEnd
		sta 	variableListEnd
		bcc 	_CVNoCarry2
		inc 	variableListEnd+1
_CVNoCarry2:		
		.storage_release
		ply 							
		plx
		pla
		rts

; ************************************************************************************************
;
;			Set the last defined variable record to the current code position.
;
; ************************************************************************************************

SetVariableRecordToCodePosition:
		.storage_access
		pha
		phy
		ldy 	#3
		lda 	objPtr+1
		sta 	(zTemp0),y
		iny 	
		lda 	objPtr
		sta 	(zTemp0),y
		ply
		pla
		.storage_release
		rts

; ************************************************************************************************
;
;									Allocate bytes for type A
;
; ************************************************************************************************

AllocateBytesForType:
		pha
		phx
		ldx 	#2 						; bytes to allocate
		and 	#NSSTypeMask+NSSIInt16
		cmp 	#NSSIFloat
		bne 	_CVNotFloat
		ldx 	#6
_CVNotFloat:
		txa 							; add 6 or 2 to the free memory pointer.
		clc
		adc 	freeVariableMemory
		sta 	freeVariableMemory
		bcc 	_CVNoCarry1
		inc 	freeVariableMemory+1
_CVNoCarry1:				
		plx
		pla
		rts

		.send code

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
