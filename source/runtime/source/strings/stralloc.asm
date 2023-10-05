; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		stralloc.asm
;		Purpose:	Allocate string memory
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;				Temporary string allocation reset (call if cmd manipulates strings)
;
; ************************************************************************************************

resetStringSystem .macro
		stz 	stringInitialised
		.endm

; ************************************************************************************************
;
;							Initialise string system if required
;
; ************************************************************************************************

StringInitialise:
		pha
		lda 	stringInitialised 			; already done
		bne 	_SIExit

		lda 	stringHighMemory 			; copy high memory - 512 => stringTempPointer
		sta 	stringTempPointer
		lda 	stringHighMemory+1
		dec 	a
		dec 	a
		sta 	stringTempPointer+1

		dec 	stringInitialised 			; set the initialised flag.
_SIExit:
		lda 	availableMemory+1 			; check out of memory
		inc 	a
		inc 	a
		cmp 	stringHighMemory+1
		bcs 	_SIMemory
		pla
		rts
_SIMemory:
		.error_memory

; ************************************************************************************************
;
;								Allocate space for a string of length A.
;
; ************************************************************************************************

StringAllocTemp:
		jsr 	StringInitialise 			; check it is initialised.

		eor 	#$FF 						; subtract A+1 from temp pointer.
		clc
		adc 	stringTempPointer 			; subtract 32 from temp pointer and
		sta 	stringTempPointer 			; save in zsTemp and stackas well.
		sta 	zsTemp
		sta 	NSMantissa0,x

		lda 	stringTempPointer+1
		adc 	#$FF
		sta 	stringTempPointer+1
		sta 	zsTemp+1
		sta 	NSMantissa1,x
		stz 	NSMantissa2,x
		stz 	NSMantissa3,x

		lda 	#0 							; clear string.
		sta 	(zsTemp)
		lda 	#NSSString 			 		; mark as string
		sta 	NSStatus,x
		rts

; ************************************************************************************************
;		
; 										Write A to String
;
; ************************************************************************************************

StringWriteChar:
		phy
		pha
		lda 	(zsTemp)
		inc 	a
		sta 	(zsTemp)
		tay
		pla
		sta 	(zsTemp),y
		ply
		rts

		.send code
		
		.section storage
stringInitialised:							; non zero if string system not set up
		.fill 	1		
stringTempPointer: 							; allocated temporary pointer
		.fill 	2
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
