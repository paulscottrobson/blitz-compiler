; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		constant.asm
;		Purpose:	Output integer constants
;		Created:	15th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Output code to push integer YA / A
;
; ************************************************************************************************

PushIntegerYA:
		cpy 	#0 							; 0-255
		beq 	PushIntegerA
		pha
		lda 	#PCD_CMD_WORD 				; send .word
		jsr 	WriteCodeByte 	
		pla 								; then LSB
		jsr 	WriteCodeByte 	
		tya 								; then MSB
		jsr 	WriteCodeByte 	
		rts

PushIntegerA:
		cmp 	#64 						; if > 64 send byte as is
		bcc 	_PIWriteA
		pha 								
		lda 	#PCD_CMD_BYTE 				; send .byte
		jsr 	WriteCodeByte 	
		pla
_PIWriteA:		
		jsr 	WriteCodeByte
		rts

; ************************************************************************************************
;
;										Push TOS Float
;
; ************************************************************************************************

PushFloat:
		lda 	#PCD_CMD_FLOAT 				; write CMD_FLOAT
		jsr 	WriteCodeByte
		lda 	NSExponent,x 				; and the data
		jsr 	WriteCodeByte
		lda 	NSMantissa0,x
		jsr 	WriteCodeByte
		lda 	NSMantissa1,x
		jsr 	WriteCodeByte
		lda 	NSMantissa2,x
		jsr 	WriteCodeByte
		lda 	NSStatus,x 					; with sign packed in byte 3 MSB
		and 	#$80
		ora 	NSMantissa3,x
		jsr 	WriteCodeByte
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
