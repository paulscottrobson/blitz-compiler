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
		phx 								; save type on stack
		jsr 	FindVariable 				; read its data
		bcs 	_GRTExit 					; found it, exit with type
		cpx 	#0  						; not found, if array then error.
		bmi 	_GRTUndeclared 				
		jsr 	CreateVariable 				; create a variable.
_GRTExit:
		pla 								; get type back, strip out type information.
		and 	#NSSTypeMask+NSSIInt16
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
