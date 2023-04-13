; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		runtime.asm
;		Purpose:	Runtime interpreter main
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

Boot:	
		ldx 	#$FF
		jsr 	ClearMemory 				; clear memory.

		.set16 	codePtr,EndProgram+2
		ldy 	#0	
		;
		;		Main Run Loop
		;
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
		.debug	
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
		asl 	a 							; shift left 
		phx 								; save SP on stack
		tax				 					; and jump indirect
		jmp 	(VectorTable,x)


		.exitemu


GetInteger8Bit:
		.debug
GetInteger16Bit:
		.debug

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
