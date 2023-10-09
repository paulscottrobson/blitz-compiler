; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		start.asm
;		Purpose:	Start actual compilation.
;		Created:	9th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code


CompileCode:

		ldy 	#ObjectFile >> 8
		ldx 	#ObjectFile & $FF		
		jsr 	IOOpenWrite
		lda 	#12
		jsr 	IOWriteByte
		lda 	#13
		jsr 	IOWriteByte
		jsr 	IOWriteClose

		ldy 	#SourceFile >> 8
		ldx 	#SourceFile & $FF		
		jsr 	IOOpenRead
		.debug
		jsr 	IOReadByte
		jsr 	IOReadByte
		jsr 	IOReadClose

		jmp 	$FFFF

ObjectFile:
		.text 	'OBJECT.PRG',0		
SourceFile:
		.text 	'SOURCE.PRG',0

		.send code

		.section storage
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
