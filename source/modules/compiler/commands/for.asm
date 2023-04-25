; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		for.asm
;		Purpose:	FOR compile
;		Created:	20th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										Compile FOR command
;
;				Creates [Initial] Index! [Reference|Type] [Terminal] [Step] FOR
;
; ************************************************************************************************

CommandFOR: 
		;
		;		FOR [variable]
		;
		jsr 	GetNextNonSpace 			; first letter of index variable, should be.
		jsr 	CharIsAlpha 				; if not alpha , error
		bcc 	_CFFail
		jsr 	GetReferenceTerm 			; figure out the reference.

		pha 								; save type
		and 	#NSSTypeMask 				; check it is numeric
		cmp 	#NSSIFloat 					
		bne 	_CFFail
		;
		; 		= [Start]
		;
		phy 								; save reference on the stack
		phx
		lda 	#C64_EQUAL 					; check for equal.
		jsr 	CheckNextA
		jsr 	CompileExpressionAt0 		; initial value
		plx 								; get reference back.
		ply
		phy
		phx
		sec 								; set initial value.
		jsr 	GetSetVariable
		;
		;		Push reference on the stack, Int16 flag in Bit15
		;
		plx
		ply
		pla
		and 	#NSSIInt16 	
		beq 	_CFNotInt16
		tya
		ora 	#$80
		tay
_CFNotInt16:
		txa 								; reference in YA
		jsr 	PushIntegerYA
		;
		;		TO [End]
		;
		lda 	#C64_TO
		jsr 	CheckNextA
		jsr 	CompileExpressionAt0 		; terminal value
		and 	#NSSTypeMask 				; check it is numeric
		cmp 	#NSSIFloat 					
		bne 	_CFFail
		;
		;		Optional STEP [n]
		;
		jsr 	LookNextNonSpace 			; followed by STEP
		cmp 	#C64_STEP
		bne 	_CFNoStep
		;
		jsr 	GetNext 					; consume it.
		jsr 	CompileExpressionAt0 		; terminal value
		and 	#NSSTypeMask 				; check it is numeric
		cmp 	#NSSIFloat 					
		bne 	_CFFail
		bra 	_CFParametersDone
		;
_CFNoStep:
		lda 	#1 							; default STEP e.g. 1
		jsr 	PushIntegerA
_CFParametersDone:		
		lda 	#PCD_FOR  					; compile FOR word.
		jsr 	WriteCodeByte
		rts



_CFFail:
		.error_syntax

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
