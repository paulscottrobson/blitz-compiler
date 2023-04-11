; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		shortmultiply.asm
;		Purpose:	32x32 bit integer multiplication, 32 bit result with rounding and shift
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;		Multiply stack entry A by stack entry B. If necessary right shifts. Returns on 
;		exit the number of left shifts required to fix it up. Calculates sign of result.
;
;		Does not change exponent.
;
; ************************************************************************************************

MultiplyShort:
		phy 								; save Y
		ldx 	#UseAMantissa
		jsr 	FloatCopyToCX 				; copy A to C
		jsr 	FloatSetZeroMantissaOnlyX	; set A to zero
		ldy 	#0 							; Y is the shift count.
		;
		;		Main multiply loop.
		;				
_I32MLoop:
		lda 	CMantissa0 					; check C is zero
		ora 	CMantissa1
		ora 	CMantissa2
		ora 	CMantissa3
		beq 	_I32MExit 					; exit if zero

		lda 	CMantissa0 					; check LSB of n1 
		lsr 	a
		bcc 	_I32MNoAdd
		;
		jsr 	AddBtoA 					; if so add B to A.
		;
		lda 	AMantissa3	 				; has Mantissa overflowed ?
		bpl 	_I32MNoAdd
		;
		;		Overflow. Shift result right, increment the shift count, keeping the
		; 		result in 31 bits - now we lose some precision though.
		;
_I32ShiftRight:		
		ldx 	#UseAMantissa
		jsr 	FloatShiftRight 			; shift S[X] right
		iny 								; increment shift count
		bra 	_I32MShiftUpper 			; n2 is doubled by default.
		;
_I32MNoAdd:
		bit 	NSMantissa3+1,x				; if we can't shift S[X+1] left, shift everything right
		bvs 	_I32ShiftRight 				; instead.

		inx
		jsr 	NSMShiftLeft 				; shift additive S[X+1] left
		dex

_I32MShiftUpper:
		inx 								; shift S[X+2] right
		inx
		jsr 	NSMShiftRight
		dex
		dex

		bra 	_I32MLoop 					; try again.

_I32MExit:
		jsr 	CalculateSign
		tya 								; shift in A
		ply 								; restore Y and exit
		rts

; ************************************************************************************************
;
;								Calculate sign from the two signs
;
; ************************************************************************************************

CalculateSign:
		lda 	NSStatus,x 					; sign of result is 0 if same, 1 if different.
		asl 	NSStatus,x 					; shift result left
		eor 	NSStatus+1,x
		asl 	a 							; shift bit 7 into carry
		ror 	NSStatus,x 					; shift right into status byte.
		rts

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
