;
;	This file is automatically generated
;
	.section code
VectorTable:
	.word	LinkFloatAdd             ; $80 +
	.word	LinkFloatSubtract        ; $81 -
	.word	LinkFloatMultiply        ; $82 *
	.word	LinkFloatDivide          ; $83 /
	.word	LinkFloatPower           ; $84 ^
	.word	BinaryAnd                ; $85 and
	.word	BinaryOr                 ; $86 or
	.word	LinkCompareGreater       ; $87 >
	.word	LinkCompareEqual         ; $88 =
	.word	LinkCompareLess          ; $89 <
	.word	LinkCompareGreaterEqual  ; $8a >=
	.word	LinkCompareNotEqual      ; $8b <>
	.word	LinkCompareLessEqual     ; $8c <=
	.word	AbsoluteTOS              ; $8d abs
	.word	ArrayConvert             ; $8e array
	.word	UnaryAsc                 ; $8f asc
	.word	CommandAssert            ; $90 assert
	.word	Unary16Bin               ; $91 bin$
	.word	PrintCharacterX          ; $92 print.chr
	.word	UnaryChr                 ; $93 chr$
	.word	CompareStrings           ; $94 s.cmp
	.word	CommandXFor              ; $95 for
	.word	UnaryFre                 ; $96 fre
	.word	CommandXGet              ; $97 get
	.word	CommandReturn            ; $98 return
	.word	Command_PSET             ; $99 pset
	.word	Command_LINE             ; $9a line
	.word	Command_RECT             ; $9b rect
	.word	Command_FRAME            ; $9c frame
	.word	Command_CHAR             ; $9d char
	.word	Unary16Hex               ; $9e hex$
	.word	CommandXInput            ; $9f input
	.word	CommandInputString       ; $a0 input$
	.word	CommandInputReset        ; $a1 input.start
	.word	UnaryLen                 ; $a2 len
	.word	LinkFloatCompare         ; $a3 f.cmp
	.word	LinkDivideInt32          ; $a4 int.div
	.word	NegateTOS                ; $a5 negate
	.word	CommandNewLine           ; $a6 new.line
	.word	CommandXNext             ; $a7 next
	.word	NotTOS                   ; $a8 not
	.word	CommandXOn               ; $a9 on
	.word	CommandMoreOn            ; $aa moreon
	.word	UnaryPeek                ; $ab peek
	.word	UnaryPI                  ; $ac pi
	.word	CommandPOKE              ; $ad poke
	.word	UnaryPos                 ; $ae pos
	.word	GetChannel               ; $af getchannel
	.word	SetChannel               ; $b0 setchannel
	.word	PrintNumber              ; $b1 print.n
	.word	PrintString              ; $b2 print.s
	.word	CommandXRead             ; $b3 read
	.word	CommandReadString        ; $b4 read$
	.word	UnaryRND                 ; $b5 rnd
	.word	StringConcatenate        ; $b6 concat
	.word	SignTOS                  ; $b7 sgn
	.word	PrintTab                 ; $b8 print.tab
	.word	PrintPos                 ; $b9 print.pos
	.word	PrintSpace               ; $ba print.spc
	.word	Unary_Str                ; $bb str$
	.word	Unary_Left               ; $bc left$
	.word	Unary_Right              ; $bd right$
	.word	Unary_Mid                ; $be mid$
	.word	CommandSwap              ; $bf swap
	.word	TimeTOS                  ; $c0 ti
	.word	TimeString               ; $c1 ti$
	.word	UnaryUsr                 ; $c2 usr
	.word	ValUnary                 ; $c3 val
	.word	CommandClose             ; $c4 close
	.word	CommandExit              ; $c5 exit
	.word	CommandDebug             ; $c6 debug
	.word	CommandXOpen             ; $c7 open
	.word	CommandScreen            ; $c8 screen
	.word	CommandVPOKE             ; $c9 vpoke
	.word	CommandVPEEK             ; $ca vpeek
	.word	CommandShift             ; $cb .shift
	.word	PushByteCommand          ; $cc .byte
	.word	PushWordCommand          ; $cd .word
	.word	CommandPushN             ; $ce .float
	.word	CommandPushS             ; $cf .string
	.word	CommandXData             ; $d0 .data
	.word	CommandXGoto             ; $d1 .goto
	.word	CommandXGosub            ; $d2 .gosub
	.word	CommandGotoZ             ; $d3 .goto.z
	.word	CommandGotoNZ            ; $d4 .goto.nz
	.word	CommandVarSpace          ; $d5 .varspace
	.word	CommandRestoreX          ; $d6 .restore


ShiftVectorTable:
	.word	CommandClr               ; $cb80 clr
	.word	CommandXDIM              ; $cb81 dim
	.word	CommandEnd               ; $cb82 end
	.word	UnaryJoy                 ; $cb83 joy
	.word	LinkFloatIntegerPartDown ; $cb84 int
	.word	LinkFloatSquareRoot      ; $cb85 sqr
	.word	LinkFloatLogarithm       ; $cb86 log
	.word	LinkFloatExponent        ; $cb87 exp
	.word	LinkFloatCosine          ; $cb88 cos
	.word	LinkFloatSine            ; $cb89 sin
	.word	LinkFloatTangent         ; $cb8a tan
	.word	LinkFloatArcTan          ; $cb8b atn
	.word	XCommandMouse            ; $cb8c mouse
	.word	XUnaryMB                 ; $cb8d mb
	.word	XUnaryMX                 ; $cb8e mx
	.word	XUnaryMY                 ; $cb8f my
	.word	XUnaryMWheel             ; $cb90 mwheel
	.word	CommandStop              ; $cb91 stop
	.word	CommandSYS               ; $cb92 sys
	.word	CommandTIWriteN          ; $cb93 ti.write
	.word	CommandTIWriteS          ; $cb94 ti$.write
	.word	CommandXWAIT             ; $cb95 wait
	.word	X16I2CPoke               ; $cb96 i2cpoke
	.word	X16I2CPeek               ; $cb97 i2cpeek
	.word	CommandBank              ; $cb98 bank
	.word	XCommandSleep            ; $cb99 sleep
	.word	X16_Audio_FMINIT         ; $cb9a fminit
	.word	X16_Audio_FMNOTE         ; $cb9b fmnote
	.word	X16_Audio_FMDRUM         ; $cb9c fmdrum
	.word	X16_Audio_FMINST         ; $cb9d fminst
	.word	X16_Audio_FMVIB          ; $cb9e fmvib
	.word	X16_Audio_FMFREQ         ; $cb9f fmfreq
	.word	X16_Audio_FMVOL          ; $cba0 fmvol
	.word	X16_Audio_FMPAN          ; $cba1 fmpan
	.word	X16_Audio_FMPLAY         ; $cba2 fmplay
	.word	X16_Audio_FMCHORD        ; $cba3 fmchord
	.word	X16_Audio_FMPOKE         ; $cba4 fmpoke
	.word	X16_Audio_PSGINIT        ; $cba5 psginit
	.word	X16_Audio_PSGNOTE        ; $cba6 psgnote
	.word	X16_Audio_PSGVOL         ; $cba7 psgvol
	.word	X16_Audio_PSGWAV         ; $cba8 psgwav
	.word	X16_Audio_PSGFREQ        ; $cba9 psgfreq
	.word	X16_Audio_PSGPAN         ; $cbaa psgpan
	.word	X16_Audio_PSGPLAY        ; $cbab psgplay
	.word	X16_Audio_PSGCHORD       ; $cbac psgchord
	.word	CommandCls               ; $cbad cls
	.word	CommandLocate            ; $cbae locate
	.word	CommandColor             ; $cbaf color
	.send code
