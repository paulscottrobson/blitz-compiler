; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		dim.asm
;		Purpose:	DIM command
;		Created:	26th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;											DIM command
;
; ************************************************************************************************

CommandDIM:
		.debug
		jsr 	GetNextNonSpace 			; get the first non space character
		jsr 	ExtractVariableName 		; variable name to XY
		cpx 	#0 							; check it is an array.
		bpl 	_CDError
		jsr 	FindVariable	 			; see if already exist
		bcs 	_CDRedefine 				; it still exists.
		jsr 	CreateVariable 				; create the basic variable 
		phy 								; save the address of the basic storage
		phx
		jsr 	OutputIndexGroup 			; create an index group and generate them
		.keyword PCD_DIM 					; call the keyword to dimension the array with this information.
		
		plx 								; restore address
		ply
		lda 	#NSSIFloat+NSSIInt16 		; pretend it is an int16 reference.
		sec
		jsr 	GetSetVariable 				; store the address in the reference to the array structure.
		rts		

_CDError:
		.error_syntax
_CDRedefine:
		.error_redefine

; ************************************************************************************************
;
;									Consume an index group
;
; ************************************************************************************************

OutputIndexGroup:
		stz 	IndexCount 					; count of number of indices.
		rts


		.send code

		.section storage
IndexCount:
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
