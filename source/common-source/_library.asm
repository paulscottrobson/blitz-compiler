;
;	This file is automatically generated
;
;
;	This file is automatically generated.
;
C64_END                  = $80 ; $80 end
C64_FOR                  = $81 ; $81 for
C64_NEXT                 = $82 ; $82 next
C64_DATA                 = $83 ; $83 data
C64_INPUTHASH            = $84 ; $84 input#
C64_INPUT                = $85 ; $85 input
C64_DIM                  = $86 ; $86 dim
C64_READ                 = $87 ; $87 read
C64_LET                  = $88 ; $88 let
C64_GOTO                 = $89 ; $89 goto
C64_RUN                  = $8a ; $8a run
C64_IF                   = $8b ; $8b if
C64_RESTORE              = $8c ; $8c restore
C64_GOSUB                = $8d ; $8d gosub
C64_RETURN               = $8e ; $8e return
C64_REM                  = $8f ; $8f rem
C64_STOP                 = $90 ; $90 stop
C64_ON                   = $91 ; $91 on
C64_WAIT                 = $92 ; $92 wait
C64_LOAD                 = $93 ; $93 load
C64_SAVE                 = $94 ; $94 save
C64_VERIFY               = $95 ; $95 verify
C64_DEF                  = $96 ; $96 def
C64_POKE                 = $97 ; $97 poke
C64_PRINTHASH            = $98 ; $98 print#
C64_PRINT                = $99 ; $99 print
C64_CONT                 = $9a ; $9a cont
C64_LIST                 = $9b ; $9b list
C64_CLR                  = $9c ; $9c clr
C64_CMD                  = $9d ; $9d cmd
C64_SYS                  = $9e ; $9e sys
C64_OPEN                 = $9f ; $9f open
C64_CLOSE                = $a0 ; $a0 close
C64_GET                  = $a1 ; $a1 get
C64_NEW                  = $a2 ; $a2 new
C64_TABLB                = $a3 ; $a3 tab(
C64_TO                   = $a4 ; $a4 to
C64_FN                   = $a5 ; $a5 fn
C64_SPCLB                = $a6 ; $a6 spc(
C64_THEN                 = $a7 ; $a7 then
C64_NOT                  = $a8 ; $a8 not
C64_STEP                 = $a9 ; $a9 step
C64_PLUS                 = $aa ; $aa +
C64_MINUS                = $ab ; $ab -
C64_TIMES                = $ac ; $ac *
C64_DIVIDE               = $ad ; $ad /
C64_POWER                = $ae ; $ae ^
C64_AND                  = $af ; $af and
C64_OR                   = $b0 ; $b0 or
C64_GREATER              = $b1 ; $b1 >
C64_EQUAL                = $b2 ; $b2 =
C64_LESS                 = $b3 ; $b3 <
C64_SGN                  = $b4 ; $b4 sgn
C64_INT                  = $b5 ; $b5 int
C64_ABS                  = $b6 ; $b6 abs
C64_USR                  = $b7 ; $b7 usr
C64_FRE                  = $b8 ; $b8 fre
C64_POS                  = $b9 ; $b9 pos
C64_SQR                  = $ba ; $ba sqr
C64_RND                  = $bb ; $bb rnd
C64_LOG                  = $bc ; $bc log
C64_EXP                  = $bd ; $bd exp
C64_COS                  = $be ; $be cos
C64_SIN                  = $bf ; $bf sin
C64_TAN                  = $c0 ; $c0 tan
C64_ATN                  = $c1 ; $c1 atn
C64_PEEK                 = $c2 ; $c2 peek
C64_LEN                  = $c3 ; $c3 len
C64_STRDOLLAR            = $c4 ; $c4 str$
C64_VAL                  = $c5 ; $c5 val
C64_ASC                  = $c6 ; $c6 asc
C64_CHRDOLLAR            = $c7 ; $c7 chr$
C64_LEFTDOLLAR           = $c8 ; $c8 left$
C64_RIGHTDOLLAR          = $c9 ; $c9 right$
C64_MIDDOLLAR            = $ca ; $ca mid$
C64_GO                   = $cb ; $cb go
C64_MON                  = $ce80 ; $ce80 mon
C64_DOS                  = $ce81 ; $ce81 dos
C64_OLD                  = $ce82 ; $ce82 old
C64_GEOS                 = $ce83 ; $ce83 geos
C64_VPOKE                = $ce84 ; $ce84 vpoke
C64_VLOAD                = $ce85 ; $ce85 vload
C64_SCREEN               = $ce86 ; $ce86 screen
C64_PSET                 = $ce87 ; $ce87 pset
C64_LINE                 = $ce88 ; $ce88 line
C64_FRAME                = $ce89 ; $ce89 frame
C64_RECT                 = $ce8a ; $ce8a rect
C64_CHAR                 = $ce8b ; $ce8b char
C64_MOUSE                = $ce8c ; $ce8c mouse
C64_COLOR                = $ce8d ; $ce8d color
C64_TEST                 = $ce8e ; $ce8e test
C64_RESET                = $ce8f ; $ce8f reset
C64_CLS                  = $ce90 ; $ce90 cls
C64_CODEX                = $ce91 ; $ce91 codex
C64_LOCATE               = $ce92 ; $ce92 locate
C64_BOOT                 = $ce93 ; $ce93 boot
C64_KEYMAP               = $ce94 ; $ce94 keymap
C64_BLOAD                = $ce95 ; $ce95 bload
C64_BVLOAD               = $ce96 ; $ce96 bvload
C64_BVERIFY              = $ce97 ; $ce97 bverify
C64_BANK                 = $ce98 ; $ce98 bank
C64_FMINIT               = $ce99 ; $ce99 fminit
C64_FMNOTE               = $ce9a ; $ce9a fmnote
C64_FMDRUM               = $ce9b ; $ce9b fmdrum
C64_FMINST               = $ce9c ; $ce9c fminst
C64_FMVIB                = $ce9d ; $ce9d fmvib
C64_FMFREQ               = $ce9e ; $ce9e fmfreq
C64_FMVOL                = $ce9f ; $ce9f fmvol
C64_FMPAN                = $cea0 ; $cea0 fmpan
C64_FMPLAY               = $cea1 ; $cea1 fmplay
C64_FMCHORD              = $cea2 ; $cea2 fmchord
C64_FMPOKE               = $cea3 ; $cea3 fmpoke
C64_PSGINIT              = $cea4 ; $cea4 psginit
C64_PSGNOTE              = $cea5 ; $cea5 psgnote
C64_PSGVOL               = $cea6 ; $cea6 psgvol
C64_PSGWAV               = $cea7 ; $cea7 psgwav
C64_PSGFREQ              = $cea8 ; $cea8 psgfreq
C64_PSGPAN               = $cea9 ; $cea9 psgpan
C64_PSGPLAY              = $ceaa ; $ceaa psgplay
C64_PSGCHORD             = $ceab ; $ceab psgchord
C64_REBOOT               = $ceac ; $ceac reboot
C64_POWEROFF             = $cead ; $cead poweroff
C64_I2CPOKE              = $ceae ; $ceae i2cpoke
C64_SLEEP                = $ceaf ; $ceaf sleep
C64_BSAVE                = $ceb0 ; $ceb0 bsave
C64_MENU                 = $ceb1 ; $ceb1 menu
C64_REN                  = $ceb2 ; $ceb2 ren
C64_LINPUT               = $ceb3 ; $ceb3 linput
C64_LINPUTHASH           = $ceb4 ; $ceb4 linput#
C64_BINPUTHASH           = $ceb5 ; $ceb5 binput#
C64_HELP                 = $ceb6 ; $ceb6 help
C64_VPEEK                = $ced0 ; $ced0 vpeek
C64_MX                   = $ced1 ; $ced1 mx
C64_MY                   = $ced2 ; $ced2 my
C64_MB                   = $ced3 ; $ced3 mb
C64_JOY                  = $ced4 ; $ced4 joy
C64_HEXDOLLAR            = $ced5 ; $ced5 hex$
C64_BINDOLLAR            = $ced6 ; $ced6 bin$
C64_I2CPEEK              = $ced7 ; $ced7 i2cpeek
C64_POINTER              = $ced8 ; $ced8 pointer
C64_STRPTR               = $ced9 ; $ced9 strptr
C64_RPTDOLLAR            = $ceda ; $ceda rpt$
; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		common.inc
;		Purpose:	Common includes/defines/setups
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;										Configuration options
;
;			  Addresses should be on page boundaries (except for ZeroPageMandatory)
;
; ************************************************************************************************
;
;		Where to assemble the runnable code.
;
CodeStart = $1000
;
;		Variables that have to be in zero page because it's used in (xx),y
;
ZeroPageMandatory = $22 
;
;		Variables that can go anywhere
;
MemoryStorage = $400

; ************************************************************************************************
;
;									Set up code and data sections
;
; ************************************************************************************************

		* = ZeroPageMandatory 				; *must* be in zero page
		.dsection zeropage

		* = MemoryStorage 					; doesn't matter if zero page or not 
		.dsection storage

		* = CodeStart
		.dsection code

; ************************************************************************************************
;
;										Zero Page Common Usage
;
; ************************************************************************************************

		.section zeropage

codePtr:	 								; address of current line.
		.fill 	2

objPtr: 									; address in code. 
		.fill 	2 							

zTemp0: 									; temporary words used in the interpreter.
		.fill 	2
zTemp1:
		.fill 	2
zTemp2:
		.fill 	2

		.endsection

; ************************************************************************************************
;
;							Insert an Emulator Breakpoint
;
; ************************************************************************************************

debug 		.macro
		.byte 	$DB 						; causes a break in the emulator
		.endm

; ************************************************************************************************
;
;								Set a 2 byte value in memory
;
; ************************************************************************************************

set16 		.macro
		lda 	#((\2) & $FF)
		sta 	0+\1
		lda 	#((\2) >> 8) & $FF
		sta 	1+\1
		.endm

; ************************************************************************************************
;
;										Exit emulation
;
; ************************************************************************************************

exitemu .macro
		stx 	zTemp0
		jmp 	$FFFF
		.endm

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
;
;	This file is automatically generated.
;
error_range .macro
	jmp	ErrorV_range
	.endm
error_value .macro
	jmp	ErrorV_value
	.endm
error_syntax .macro
	jmp	ErrorV_syntax
	.endm
error_type .macro
	jmp	ErrorV_type
	.endm
error_unimplemented .macro
	jmp	ErrorV_unimplemented
	.endm
error_assert .macro
	jmp	ErrorV_assert
	.endm
error_line .macro
	jmp	ErrorV_line
	.endm
error_internal .macro
	jmp	ErrorV_internal
	.endm
error_divzero .macro
	jmp	ErrorV_divzero
	.endm
error_structure .macro
	jmp	ErrorV_structure
	.endm
error_stop .macro
	jmp	ErrorV_stop
	.endm
error_data .macro
	jmp	ErrorV_data
	.endm
error_undeclared .macro
	jmp	ErrorV_undeclared
	.endm
error_redefine .macro
	jmp	ErrorV_redefine
	.endm
error_index .macro
	jmp	ErrorV_index
	.endm
error_memory .macro
	jmp	ErrorV_memory
	.endm
error_channel .macro
	jmp	ErrorV_channel
	.endm
;
;	This file is automatically generated
;
PCD_STARTBINARY = $80
PCD_ENDBINARY = $8d
PCD_STARTCOMMAND = $8d
PCD_ENDCOMMAND = $ca
PCD_STARTSYSTEM = $ca
PCD_ENDSYSTEM = $d5

PCD_PLUS             = $80 ; +
PCD_MINUS            = $81 ; -
PCD_TIMES            = $82 ; *
PCD_DIVIDE           = $83 ; /
PCD_POWER            = $84 ; ^
PCD_AND              = $85 ; and
PCD_OR               = $86 ; or
PCD_GREATER          = $87 ; >
PCD_EQUAL            = $88 ; =
PCD_LESS             = $89 ; <
PCD_GREATEREQUAL     = $8a ; >=
PCD_LESSGREATER      = $8b ; <>
PCD_LESSEQUAL        = $8c ; <=
PCD_ABS              = $8d ; abs
PCD_ARRAY            = $8e ; array
PCD_ASC              = $8f ; asc
PCD_ASSERT           = $90 ; assert
PCD_BINDOLLAR        = $91 ; bin$
PCD_PRINTCMD_CHR     = $92 ; print.chr
PCD_CHRDOLLAR        = $93 ; chr$
PCD_SCMD_CMP         = $94 ; s.cmp
PCD_FOR              = $95 ; for
PCD_FRE              = $96 ; fre
PCD_GET              = $97 ; get
PCD_RETURN           = $98 ; return
PCD_PSET             = $99 ; pset
PCD_LINE             = $9a ; line
PCD_RECT             = $9b ; rect
PCD_FRAME            = $9c ; frame
PCD_CHAR             = $9d ; char
PCD_HEXDOLLAR        = $9e ; hex$
PCD_INPUT            = $9f ; input
PCD_INPUTDOLLAR      = $a0 ; input$
PCD_INPUTCMD_START   = $a1 ; input.start
PCD_LEN              = $a2 ; len
PCD_FCMD_CMP         = $a3 ; f.cmp
PCD_INTCMD_DIV       = $a4 ; int.div
PCD_NEGATE           = $a5 ; negate
PCD_NEWCMD_LINE      = $a6 ; new.line
PCD_NEXT             = $a7 ; next
PCD_NOT              = $a8 ; not
PCD_ON               = $a9 ; on
PCD_MOREON           = $aa ; moreon
PCD_PEEK             = $ab ; peek
PCD_POKE             = $ac ; poke
PCD_POS              = $ad ; pos
PCD_GETCHANNEL       = $ae ; getchannel
PCD_SETCHANNEL       = $af ; setchannel
PCD_PRINTCMD_N       = $b0 ; print.n
PCD_PRINTCMD_S       = $b1 ; print.s
PCD_READ             = $b2 ; read
PCD_READDOLLAR       = $b3 ; read$
PCD_RND              = $b4 ; rnd
PCD_CONCAT           = $b5 ; concat
PCD_SGN              = $b6 ; sgn
PCD_PRINTCMD_TAB     = $b7 ; print.tab
PCD_PRINTCMD_POS     = $b8 ; print.pos
PCD_PRINTCMD_SPC     = $b9 ; print.spc
PCD_STRDOLLAR        = $ba ; str$
PCD_LEFTDOLLAR       = $bb ; left$
PCD_RIGHTDOLLAR      = $bc ; right$
PCD_MIDDOLLAR        = $bd ; mid$
PCD_SWAP             = $be ; swap
PCD_TI               = $bf ; ti
PCD_TIDOLLAR         = $c0 ; ti$
PCD_USR              = $c1 ; usr
PCD_VAL              = $c2 ; val
PCD_CLOSE            = $c3 ; close
PCD_EXIT             = $c4 ; exit
PCD_DEBUG            = $c5 ; debug
PCD_OPEN             = $c6 ; open
PCD_SCREEN           = $c7 ; screen
PCD_VPOKE            = $c8 ; vpoke
PCD_VPEEK            = $c9 ; vpeek
PCD_CMD_SHIFT        = $ca ; .shift
PCD_CMD_BYTE         = $cb ; .byte
PCD_CMD_WORD         = $cc ; .word
PCD_CMD_FLOAT        = $cd ; .float
PCD_CMD_STRING       = $ce ; .string
PCD_CMD_DATA         = $cf ; .data
PCD_CMD_GOTO         = $d0 ; .goto
PCD_CMD_GOSUB        = $d1 ; .gosub
PCD_CMD_GOTOCMD_Z    = $d2 ; .goto.z
PCD_CMD_GOTOCMD_NZ   = $d3 ; .goto.nz
PCD_CMD_VARSPACE     = $d4 ; .varspace
PCD_CLR              = $ca80 ; clr
PCD_DIM              = $ca81 ; dim
PCD_END              = $ca82 ; end
PCD_JOY              = $ca83 ; joy
PCD_INT              = $ca84 ; int
PCD_SQR              = $ca85 ; sqr
PCD_LOG              = $ca86 ; log
PCD_EXP              = $ca87 ; exp
PCD_COS              = $ca88 ; cos
PCD_SIN              = $ca89 ; sin
PCD_TAN              = $ca8a ; tan
PCD_ATN              = $ca8b ; atn
PCD_MOUSE            = $ca8c ; mouse
PCD_MB               = $ca8d ; mb
PCD_MX               = $ca8e ; mx
PCD_MY               = $ca8f ; my
PCD_RESTORE          = $ca90 ; restore
PCD_STOP             = $ca91 ; stop
PCD_SYS              = $ca92 ; sys
PCD_TIDOLLARCMD_WRITE = $ca93 ; ti$.write
PCD_WAIT             = $ca94 ; wait
PCD_I2CPOKE          = $ca95 ; i2cpoke
PCD_I2CPEEK          = $ca96 ; i2cpeek
PCD_BANK             = $ca97 ; bank
PCD_SLEEP            = $ca98 ; sleep
PCD_FMINIT           = $ca99 ; fminit
PCD_FMNOTE           = $ca9a ; fmnote
PCD_FMDRUM           = $ca9b ; fmdrum
PCD_FMINST           = $ca9c ; fminst
PCD_FMVIB            = $ca9d ; fmvib
PCD_FMFREQ           = $ca9e ; fmfreq
PCD_FMVOL            = $ca9f ; fmvol
PCD_FMPAN            = $caa0 ; fmpan
PCD_FMPLAY           = $caa1 ; fmplay
PCD_FMCHORD          = $caa2 ; fmchord
PCD_FMPOKE           = $caa3 ; fmpoke
PCD_PSGINIT          = $caa4 ; psginit
PCD_PSGNOTE          = $caa5 ; psgnote
PCD_PSGVOL           = $caa6 ; psgvol
PCD_PSGWAV           = $caa7 ; psgwav
PCD_PSGFREQ          = $caa8 ; psgfreq
PCD_PSGPAN           = $caa9 ; psgpan
PCD_PSGPLAY          = $caaa ; psgplay
PCD_PSGCHORD         = $caab ; psgchord
PCD_CLS              = $caac ; cls
PCD_LOCATE           = $caad ; locate
PCD_COLOR            = $caae ; color
;
;	This file is automatically generated.
;
	.section code
ErrorV_range:
	jsr	ErrorHandler
	.text	"OUT OF RANGE",0
ErrorV_value:
	jsr	ErrorHandler
	.text	"BAD VALUE",0
ErrorV_syntax:
	jsr	ErrorHandler
	.text	"SYNTAX ERROR",0
ErrorV_type:
	jsr	ErrorHandler
	.text	"TYPE MISMATCH",0
ErrorV_unimplemented:
	jsr	ErrorHandler
	.text	"NOT IMPLEMENTED",0
ErrorV_assert:
	jsr	ErrorHandler
	.text	"ASSERT FAIL",0
ErrorV_line:
	jsr	ErrorHandler
	.text	"UNKNOWN LINE NUMBER",0
ErrorV_internal:
	jsr	ErrorHandler
	.text	"INTERNAL ERROR",0
ErrorV_divzero:
	jsr	ErrorHandler
	.text	"DIVIDE BY ZERO",0
ErrorV_structure:
	jsr	ErrorHandler
	.text	"STRUCTURE IMBALANCE",0
ErrorV_stop:
	jsr	ErrorHandler
	.text	"PROGRAM STOPPED",0
ErrorV_data:
	jsr	ErrorHandler
	.text	"OUT OF DATA",0
ErrorV_undeclared:
	jsr	ErrorHandler
	.text	"UNKNOWN ARRAY",0
ErrorV_redefine:
	jsr	ErrorHandler
	.text	"ARRAY REDEFINED",0
ErrorV_index:
	jsr	ErrorHandler
	.text	"BAD ARRAY INDEX",0
ErrorV_memory:
	jsr	ErrorHandler
	.text	"OUT OF MEMORY",0
ErrorV_channel:
	jsr	ErrorHandler
	.text	"INPUT/OUTPUT ERROR",0
	.send code
; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		forward.asm
;		Purpose:	Move object pointer forward
;		Created:	18th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								Move objPtr forwards. CS if end
;
; ************************************************************************************************

MoveObjectForward:

		lda 	(objPtr) 					; get next
		
		cmp 	#$FF  						
		beq 	_MOFEnd

		cmp 	#$40 						; 00-3F
		bcc 	_MOFAdvance1 				; forward 1

		ldy 	#2 							; 40-6F
		cmp 	#$70 						; forward 2
		bcc 	_MOFAdvanceY 				

		cmp 	#PCD_STARTSYSTEM 			; 70 - System tokens.
		bcc 	_MOFAdvance1 				; forward 1

		tay 								; read the size.
		lda 	MOFSizeTable-PCD_STARTSYSTEM,y
		tay
		iny 								; add 1 for the system token.
		bne 	_MOFAdvanceY 				; if 0, was $FF thus a string/data skip.

		ldy 	#1 							; get length byte
		lda 	(objPtr),y
		tay 								; into Y.

		clc
		lda 	objPtr						; add 2 to the object pointer
		adc 	#2
		sta 	objPtr
		bcc 	_MOFNoCarry1
		inc 	objPtr+1
_MOFNoCarry1:		
		bra 	_MOFAdvanceY

_MOFAdvance1:
		ldy 	#1
_MOFAdvanceY:				
		tya 								; add Y to objPtr
		clc
		adc 	objPtr
		sta 	objPtr
		bcc 	_MOFNoCarry2
		inc 	objPtr+1
_MOFNoCarry2:		
		clc 								; not completed.
		rts
		;
		;		At the end so advance past $FF end marker and return CS.
		;
_MOFEnd:
		inc 	objPtr
		bne 	_MOFENoCarry
		inc 	objPtr+1
_MOFENoCarry:
		sec
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
;
;	This file is automatically generated
;
.section code
MOFSizeTable:
	.byte	1         	; $ca .shift
	.byte	1         	; $cb .byte
	.byte	2         	; $cc .word
	.byte	5         	; $cd .float
	.byte	255       	; $ce .string
	.byte	255       	; $cf .data
	.byte	2         	; $d0 .goto
	.byte	2         	; $d1 .gosub
	.byte	2         	; $d2 .goto.z
	.byte	2         	; $d3 .goto.nz
	.byte	2         	; $d4 .varspace
.send code
