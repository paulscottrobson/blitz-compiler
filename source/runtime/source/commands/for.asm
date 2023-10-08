; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		for.asm
;		Purpose:	FOR command
;		Created:	20th April 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;								<RefAddr|Type> <Terminal> <Step> FOR
;
; ************************************************************************************************

CommandXFor: ;; [for]
		.entercmd
		lda 	#FRAME_FOR 					; open frame
		jsr 	StackOpenFrame 			
		jsr 	StackSaveCurrentPosition 	; normalise to Y=0 and save position.

		ldy 	#7 							; copy step out
		jsr 	CopyTOSToOffsetY
		dex
		ldy 	#13 						; copy terminal value.
		jsr 	CopyTOSToOffsetY
		dex

		lda 	NSMantissa1,x 				; bit 15 of reference indicates type int16
		and 	#$80
		ldy 	#4
		sta 	(runtimeStackPtr),y

		lda 	NSMantissa0,x 				; copy the reference address
		ldy 	#5 							; adjusted to be a real address
		sta 	(runtimeStackPtr),y
		sta 	zTemp0 						; also to zTemp0
		iny
		lda 	NSMantissa1,x
		clc
		and 	#$7F 						; throw the type bit.
		sta 	(runtimeStackPtr),y
		adc 	variableStartPage 			; point to variable page.
		sta 	zTemp0+1
		dex 								; throw reference.
		;
		;		We look for optimisation options. Here we have optimisation
		; 		if the index value, step value, and terminal value are all
		; 		positive integers, step is 1 byte - we can do it much more quickly.
		;
		ldy 	#5 							; check the index, step and terminal values
		lda 	(zTemp0),y 					; are all +ve integers, sign bits first.
		ldy 	#12 
		ora 	(runtimeStackPtr),y
		ldy 	#18
		ora 	(runtimeStackPtr),y
		and 	#$80 						; only interested in sign bit.
		;
		dey 								; now the exponents.
		ora 	(zTemp0),y
		ldy 	#11
		ora 	(runtimeStackPtr),y
		ldy 	#17
		ora 	(runtimeStackPtr),y

		ldy 	#8 							; step must be 1 byte.
		ora 	(runtimeStackPtr),y
		iny
		ora 	(runtimeStackPtr),y
		iny
		ora 	(runtimeStackPtr),y

		bne 	_CFNoOptimise 	

		ldy 	#4 							; set the runtime stack pointer optimisation flag.
		lda 	(runtimeStackPtr),y
		ora 	#$40
		sta 	(runtimeStackPtr),y

_CFNoOptimise:
		ldy 	#0
		.exitcmd	

; ************************************************************************************************
;
;								Copy TOS to stack frame offset Y
;
; ************************************************************************************************

CopyTOSToOffsetY:
		lda 	NSMantissa0,x
		sta 	(runtimeStackPtr),y
		iny
		lda 	NSMantissa1,x
		sta 	(runtimeStackPtr),y
		iny
		lda 	NSMantissa2,x
		sta 	(runtimeStackPtr),y
		iny
		lda 	NSMantissa3,x
		sta 	(runtimeStackPtr),y
		iny
		lda 	NSExponent,x
		sta 	(runtimeStackPtr),y
		iny
		lda 	NSStatus,x
		sta 	(runtimeStackPtr),y
		rts

; ************************************************************************************************
;
;		0	FOR Marker 				[1]
;		1 	Page/Position for loop 	[3]
;		4 	Control 				[1] 	Integer/Int16:7 ; optimised:6
;		5 	Index Variable 			[2]  	Offset Address 
;		7 	Step (+1 optimise) 		[6]
;		13	Terminal Value.	 		[6]
;
; ************************************************************************************************

		.send 	code
		
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
