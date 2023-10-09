; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		read.asm
;		Purpose:	Read file code.
;		Created:	9th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								 Open sequential file for Read
; 									   YX = ASCIIZ name
;
; ************************************************************************************************

IOOpenRead:
		lda 	#'R' 						; read.
		jsr 	IOSetFileName 				; set up name/LFS
		ldx	 	#3 							; use file 3 for reading
		jsr 	$FFC6 						; CHKIN
		rts

; ************************************************************************************************
;
;									Read A from input file
;
;			    If read,  A=Byte and Carry Clear, else A = Error and Carry Set
;
; ************************************************************************************************

IOReadByte:
		phx 					
		phy
		jsr 	$FFB7 						; read ST
		sec
		bne 	_IORExit
		jsr 	$FFCF 						; read a byte
		clc 								; status OK.
_IORExit:		
		ply
		plx
		rts

; ************************************************************************************************
;
;							    Close files (use the same code)
;
; ************************************************************************************************

IOReadClose:
IOWriteClose:
		lda 	#3 							; CLOSE# 3
		jsr 	$FFC3
		jsr 	$FFCC 						; CLRCHN
		rts

; ************************************************************************************************
;
;				 Set LFS, Name and Open File. YX = Filename (ASCIIZ) A = R/W
;
; ************************************************************************************************

IOSetFileName:
		pha 								; save R/W
		stx 	zTemp0
		sty 	zTemp0+1
		ldy 	#$FF 						; copy name given
_IOSCopy:
		iny 								; pre-increment copy
		lda 	(zTemp0),y
		sta 	IONameBuffer,y
		bne 	_IOSCopy
		;
		sta 	IONameBuffer+4,y
		lda 	#',' 						; append ,S,[R|W]
		sta 	IONameBuffer+0,y
		sta 	IONameBuffer+2,y
		lda 	#'S'
		sta 	IONameBuffer+1,y
		pla 								; write R/W out
		sta 	IONameBuffer+3,y

		tya 								; length of name to A
		clc
		adc 	#4 							; we added 4 characters.
 								
		ldx 	#IONameBuffer & $FF			; name address to YX
		ldy 	#IONameBuffer >> 8

	    jsr 	$FFBD          				; call SETNAM

    	lda 	#3 							; set LFS to 3,8,3
		ldx 	#8
		ldy 	#3
		jsr 	$FFBA		

		jsr 	$FFC0 						; OPEN
		rts

		.send code

		.section storage
IONameBuffer:
		.fill 	64		
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
