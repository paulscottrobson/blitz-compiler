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
		.debug
		jsr 	GetNextNonSpace 			; get first non space character.

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
