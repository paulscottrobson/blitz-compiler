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
		jsr 	GetNextNonSpace 			; get the first non space character
		jsr 	ExtractVariableName 		; variable name to XY
		phx 								; save name with type bits.
		cpx 	#0 							; check it is an array.
		bpl 	_CDError
		jsr 	FindVariable	 			; see if already exist
		bcs 	_CDRedefine 				; it still exists.
		jsr 	CreateVariableRecord 		; create the basic variable 
		jsr 	AllocateBytesForType 		; allocate memory for it

		pla 								; restore type bits
		phy 								; save the address of the basic storage
		phx
		pha
		jsr 	OutputIndexGroup 			; create an index group and generate them, preserving type data
		pla
		and 	#NSSTypeMask+NSSIInt16 		; 2 bit type data
		jsr 	PushIntegerA 				; push that type data out.

		.keyword PCD_DIM 					; call the keyword to dimension the array with this information.
		
		plx 								; restore address
		ply
		lda 	#NSSIFloat+NSSIInt16 		; pretend it is an int16 reference.
		sec
		jsr 	GetSetVariable 				; store the address in the reference to the array structure.
		;
		jsr 	LookNextNonSpace 			; , follows ?
		cmp 	#","
		bne 	_CDExit
		jsr 	GetNext 					; consume comma
		bra 	CommandDIM 					; do another DIM
_CDExit:		
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
_OIGNext:
		jsr 	CompileExpressionAt0 		; get a dimension
		and 	#NSSTypeMask 				; check it is numeric
		cmp 	#NSSIFloat
		bne 	_OIGType
		inc 	IndexCount 					; bump the counter.
		jsr 	LookNextNonSpace 			; does a , follow ?
		cmp 	#","
		bne 	_OIGCheckEnd
		jsr 	GetNext 					; consume comma
		bra 	_OIGNext 					; get next dimension
_OIGCheckEnd:
		jsr 	CheckNextRParen 			; check and consume )
		lda 	IndexCount
		jsr 	PushIntegerA 				; compile the dimension count.
		rts

_OIGType:
		.error_type
		
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
