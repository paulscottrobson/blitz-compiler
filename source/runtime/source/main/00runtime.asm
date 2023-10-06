; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		00runtime.asm
;		Purpose:	Runtime interpreter main
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;										Execute runtime. 
;
;		AA00		is the runtime p-code.
;
; ************************************************************************************************

StartRuntime:	
		sta 	runtimeHigh 				; save address of code.		
		sta 	codePtr+1 					; set pointer to code.
		stz 	codePtr
		stz 	codePage 					; zero current page.

		jsr 	ClearMemory 				; clear memory.
		jsr 	XRuntimeSetup 				; initialise the runtime stuff.
	 	jsr		SetDefaultChannel			; set default input/output channel.



		jsr 	RestoreCode 				; which we now call
		;
		;		Main Run Loop
		;
		ldy 	#0	
NextCommand:
		lda 	(codePtr),y 				; get next
		bmi 	NXCommand 					; -if -ve command
		iny
		cmp 	#64 						; 64..127 is load and store.
		bcc 	PushByteA 					; 0..63 is short constants.
		;
		;		Load/Store dispatch.
		;
NXLoadStore:
		cmp		#120 						; is it an indirect read/write
		bcs 	NXIndirectLoadStore
		lsr 	a 							; / 4, so $48 => $12,
		lsr 	a 
		and 	#$0E
		phx 								; get ready to jump
		tax
		jmp 	(ReadWriteVectors,x) 		; go via the jump table.

ReadWriteVectors:
		.word 	ReadFloatCommand			; read float
		.word 	WriteFloatCommand 			; write float
		.word 	ReadIntegerCommand 			; read integer
		.word 	WriteIntegerCommand 		; write integer
		.word 	ReadStringCommand 			; read string
		.word 	WriteStringCommand 			; write string
		.word 	Unimplemented 				
		.word 	Unimplemented 		
		;
		;		Indirect Load/store dispatch
		;
NXIndirectLoadStore:
		and 	#7
		asl 	a
		phx
		tax
		jmp 	(IndirectVectors,x)

IndirectVectors:
		.word 	IndFloatRead 				; float read				
		.word 	IndInt16Read 				; int16 read				
		.word 	IndStringRead 				; string read				
		.word 	Unimplemented
		.word 	IndFloatWrite				; float write
		.word 	IndInt16Write 				; int16 write				
		.word 	IndStringWrite 				; string write				
		.word 	Unimplemented
		;		
		;		Push byte on stack
		;
PushByteCommand: ;; [.byte]			
		.entercmd
		lda 	(codePtr),y 				; get byte to write.
		iny
PushByteA:		
		inx 								; push constant on stack
		sta 	NSMantissa0,x 				; save byte
		stz 	NSMantissa1,x 				; clear MSB
ClearRestWord:		
		stz 	NSMantissa2,x 				; zero upper bytes, exponent, make iFloat32
		stz 	NSMantissa3,x
		stz 	NSExponent,x
		stz 	NSStatus,x
		bra 	NextCommand
		;
		;		Push a word on the stack
		;
PushWordCommand: ;; [.word]
		.entercmd
		inx
		lda 	(codePtr),y 				; word to stack
		iny
		sta 	NSMantissa0,x		
		lda 	(codePtr),y
		iny
		sta 	NSMantissa1,x		
		bra 	ClearRestWord 				; handle everything else.
		;
		;		Execute a command
		;
NXCommand:
		iny 								; consume command.
		bpl 	_NXCommandNoFixUp
		jsr 	FixUpY
_NXCommandNoFixUp:		
		asl 	a 							; shift left 
		phx 								; save SP on stack
		tax				 					; and jump indirect
		jmp 	(VectorTable,x)

; ************************************************************************************************
;
;		Called after Y is negative after incrementing in the two main fetches, it resets
;		Y to zero and adds it to the codePtr ; thus we don't do lots of 16 bit increments,
;		nor are we limited to 1/4 k of P-Code per line.
;
; ************************************************************************************************

FixUpY:	
		pha
		tya
		clc 
		adc 	codePtr
		sta 	codePtr
		bcc 	_NoCPCarry
		inc 	codePtr+1
_NoCPCarry:
		ldy 	#0
		pla
		rts

		.send code

		.section storage
runtimeHigh:								; high byte of runtime start.
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
