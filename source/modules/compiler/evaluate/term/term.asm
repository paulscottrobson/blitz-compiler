; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		term.asm
;		Purpose:	Compile Code to Evaluate a term
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;			Compile code to evaluate a term. Will return in A, bits 6,5 the type of that
;			term which will either be 00 (float/int16) or 10 (string).
;
;			Terms can be :
; 				[A-Z][A-Z0-9]* 	variable/array - a reference is obtained, and the code to push this generated.
;				[0-9.]* 		numeric decimal constant
;				$[0-9A-F]* 		hexadecimal integer constant
;				%[0-1]* 		binary integer constant
;				".*?"			string constant
;				- <Term> 		A negated term (must be integer/float)
;				<Unary Token>	A unary function
;				(<expression>)	An expression.
;
; ************************************************************************************************

CompileTerm:
		jsr 	GetNextNonSpace 			; get first non space character.
		jsr 	CharIsDigit 				; found a number
		bcs 	_CTDigit
		cmp 	#"."
		beq 	_CTDigit

		.error_syntax
		;
		;		Compile a number
		;
_CTDigit:			
		jsr 	ParseConstant 				; parse out an number, first is in A already.
		bcc	 	_CTFloat 					; have a float or long int.
		jsr 	PushIntegerYA 				; code to push on stack
		lda 	#NSSIFloat 					; return a iFloat32
		rts
_CTFloat:
		jsr 	PushFloat  					; code to push float
		lda 	#NSSIFloat 					; return a iFloat32
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
