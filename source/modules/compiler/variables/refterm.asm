; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		refterm.asm
;		Purpose:	Get reference term
;		Created:	25th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;		On entry, A contains the first character.  Extract the variable name and locate it
;		creating if necessary, returning offset in YX, type in A.
;
; ************************************************************************************************

		.section code

GetReferenceTerm:
		jsr 	ExtractVariableName 		; get name & type info
		cpx 	#0 							; check for array handler
		bmi 	_GRTArray
		phx 								; save type on stack
		jsr 	FindVariable 				; find it
		bcs 	_GRTNoCreate 				; create if required.
		jsr 	CreateVariableRecord 		; create a variable.
		jsr 	AllocateBytesForType 		; allocate memory for it
_GRTNoCreate:		
		pla 								; get type back, strip out type information.
		and 	#NSSTypeMask+NSSIInt16
		rts		
	
_GRTArray:
		phx 								; save type information 		
		jsr 	FindVariable 				; read its data, the base address in YX
		bcc 	_GRTUndeclared 				; undeclared array.
		phx 								; save base address
		phy
		jsr 	OutputIndexGroup 			; create an index group and generate them
		ply 								; get the array base address into YX
		plx
		lda 	#NSSIFloat+NSSIInt16 		; pretend it is an int16 reference.
		clc
		jsr 	GetSetVariable 				; load the address of the array structure.
		.keyword PCD_ARRAY 					; convert that to an offset.

		pla 								; and the type data into A
		and 	#NSSTypeMask+NSSIInt16
		ora 	#$80 						; with the array flag set.
		rts		

_GRTUndeclared:
		.error_undeclared

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
