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
		bmi 	_CTUnaryFunctions

		jsr 	CharIsDigit 				; found a number
		bcs 	_CTDigit
		cmp 	#"."
		beq 	_CTDigit

		cmp 	#'"' 						; found a string ?
		beq 	_CTString

		cmp 	#"%"						; binary or hexadecimal ?
		beq 	_CTOtherBase
		cmp 	#"$"
		beq 	_CTOtherBase

		cmp 	#"(" 						; check parenthesis
		beq 	_CTBrackets

		cmp 	#"A" 						; check variable/array ?
		bcc 	_CTSyntax
		cmp 	#"Z"+1
		bcs 	_CTSyntax

		jsr 	GetReferenceTerm 			; figure out what it is.
		pha 								; save type on stack
		clc 								; read it
		jsr 	GetSetVariable 			
		pla
		and 	#NSSTypeMask 				; reduce to basic type
		rts	

_CTSyntax:
		.error_syntax
		;
		;		Handle parenthesis
		;
_CTBrackets:
		jsr 	CompileExpressionAt0		
		pha
		jsr 	CheckNextRParen
		pla
		rts
		;
		;		Handle other base
		;
_CTOtherBase:
		jsr 	InlineNonDecimal 			; non decimal constant handler		
		lda 	#NSSIFloat					; return a iFloat32 integer
		rts
		;
		;		Compile a number
		;
_CTDigit:			
		jsr 	ParseConstant 				; parse out an number, first is in A already.
		bcc	 	_CTFloat 					; have a float or long int.
		jsr 	PushIntegerYA 				; code to push on stack
		lda 	#NSSIFloat					; return a iFloat32 integer
		rts
_CTFloat:
		jsr 	PushFloat  					; code to push float
		lda 	#NSSIFloat 					; return a iFloat32
		rts		
		;
		;		Compile a string
		;
_CTString:
		jsr 	BufferClear 				; copy it to the buffer
_CTStringLoop:
		jsr 	LookNext 					; reached EOL/EOS
		beq 	_CTSyntax
		cmp 	#'"'
		beq 	_CTStringDone
		;
		jsr 	BufferWrite 				; write and consume
		jsr 	GetNext
		bra 	_CTStringLoop
_CTStringDone:
		jsr 	GetNext 					; consume closing quote.
		lda 	#PCD_CMD_STRING 			; output command and buffer
		jsr 	WriteCodeByte
		jsr 	BufferOutput
		lda 	#NSSString 					; string type
		rts		
		;
		;		Handle unary functions and negation, as - is a C64 token
		;
_CTUnaryFunctions:		
		cmp 	#C64_MINUS 					; negation of term.
		beq 	_CTNegation

		ldx 	#UnaryTables & $FF 			; check vs unary tables.
		ldy 	#UnaryTables >> 8
		jsr 	GeneratorProcess
		bcc		_CTSyntax 	
		rts
		;
		;		Negate a number
		;	
_CTNegation:
		jsr 	CompileTerm 				; compile a term.
		pha
		and 	#NSSTypeMask 				; if not an ifloat32 of some sort.
		cmp 	#NSSIFloat
		bne 	_CTType 					; error
		lda 	#PCD_NEGATE 				; compile negate
		jsr 	WriteCodeByte		
		pla 								; return original type.
		rts
_CTType:
		.error_type		
		
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
