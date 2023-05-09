; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		graphics.asm
;		Purpose:	Graphics commands
;		Created:	9th May 2023
;		Reviewed: 	No
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section 	code

; ************************************************************************************************
;
;										PSET Command
;
; ************************************************************************************************

Command_PSET: ;; [pset]
		.entercmd
		phy
		jsr 	GetInteger8Bit 				; get the colour
		pha
		ldx 	#0 							; copy 0/1 to r0,r1
		ldy 	#X16_r0
		jsr 	GraphicsCopy2
		jsr 	X16_FB_cursor_position 		; set position.
		pla 								; set pixel.
		jsr 	X16_FB_set_pixel
		ply
		ldx 	#$FF
		.exitcmd

; ************************************************************************************************
;
;										LINE Command
;
; ************************************************************************************************

Command_LINE: ;; [line]
		.entercmd
		phy
		jsr 	GraphicsColour
		ldx 	#0 							; copy 0/1/2/3 to r0,1,2,3
		ldy 	#X16_r0
		jsr 	GraphicsCopy4
		jsr 	X16_GRAPH_draw_line
		ply
		ldx 	#$FF
		.exitcmd

; ************************************************************************************************
;
;										RECT Command
;
; ************************************************************************************************

Command_RECT: ;; [rect]
		.entercmd
		phy
		jsr 	GraphicsRectCoords
		sec
		jsr 	X16_GRAPH_draw_rect
		ply
		ldx 	#$FF
		.exitcmd

; ************************************************************************************************
;
;										FRAME Command
;
; ************************************************************************************************

Command_FRAME: ;; [frame]
		.entercmd
		phy
		jsr 	GraphicsRectCoords
		clc
		jsr 	X16_GRAPH_draw_rect
		ply
		ldx 	#$FF
		.exitcmd

; ************************************************************************************************
;
;										CHAR Command
;
; ************************************************************************************************

Command_CHAR: ;; [char]
		.entercmd
		phy
		dex  								; set the draw colour
		jsr 	GraphicsColour
		ldx 	#0 							; copy 0/1 to r0,r1
		ldy 	#X16_r0
		jsr 	GraphicsCopy2
		;
		lda 	NSMantissa0+3 				; copy string address to zTemp0
		sta 	zTemp0
		lda 	NSMantissa1+3
		sta 	zTemp0+1
		lda 	(zTemp0) 					; count of chars to zTemp1
		sta 	zTemp1
_CCLoop:
		lda 	zTemp1 						; done all chars ?
		beq 	_CCExit
		dec 	zTemp1 						; dec counter		
		inc 	zTemp0 						; pre-bump pointer
		bne 	_CCNoCarry
		inc 	zTemp0+1
_CCNoCarry:
		lda 	(zTemp0) 					; get character 
		jsr 	X16_GRAPH_put_char 			; write it
		bra 	_CCLoop						; go round.
_CCExit:		
		ply
		ldx 	#$FF
		.exitcmd

; ************************************************************************************************
;
;								Set colour to stack X
;
; ************************************************************************************************

GraphicsColour:
		jsr 	GetInteger8Bit
		tax
		ldy 	#0
		jsr 	X16_GRAPH_set_colors
		rts

; ************************************************************************************************
;
;								Copy stack X,X+n to rY,Y+n
;
; ************************************************************************************************

GraphicsCopy4:
		jsr 	GraphicsCopy2
GraphicsCopy2:
		jsr 	GraphicsCopy1
GraphicsCopy1:		
		.floatinteger
		lda 	NSMantissa0,x
		sta 	0,y
		lda 	NSMantissa1,x
		sta 	1,y
		inx
		iny
		iny
		rts

; ************************************************************************************************
;
;								Set up Rectangle and colour
;
; ************************************************************************************************

GraphicsRectCoords:
		jsr 	GraphicsColour 				; set colour
		ldx 	#0 							; copy in order.
		ldy 	#X16_r0
		jsr 	GraphicsCopy4 
		ldx 	#X16_r0 					; sort r0/r2
		jsr 	_GRCSortSubtract
		ldx 	#X16_r1 					; sort r1/r3
		jsr 	_GRCSortSubtract
		stz 	8,x 						; zero rounding
		stz 	9,x 
		rts

_GRCSortSubtract:
		lda 	4,x 						; calculate r2-r0
		cmp 	0,x
		lda 	5,x
		sbc 	1,x
		bcs 	_GRCNoSwap 					; >= swap.
		jsr 	_GRCSwapByte 				; swap 0/2
		inx
		jsr 	_GRCSwapByte 				; swap 1/3
		dex
_GRCNoSwap:		
		sec 								; calculate width/height into 4,5
		lda 	4,x
		sbc 	0,x
		sta 	4,x

		lda 	5,x
		sbc 	1,x
		sta 	5,x
		rts

_GRCSwapByte:
		lda 	4,x
		pha
		lda 	0,x
		sta 	4,x
		pla
		sta 	0,x
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
