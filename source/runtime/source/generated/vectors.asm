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
	.word	PrintCharacter           ; $92 print.chr
	.word	UnaryChr                 ; $93 chr$
	.word	CompareStrings           ; $94 s.cmp
	.word	CommandFor               ; $95 for
	.word	UnaryFre                 ; $96 fre
	.word	CommandGet               ; $97 get
	.word	CommandReturn            ; $98 return
	.word	Command_PSET             ; $99 pset
	.word	Command_LINE             ; $9a line
	.word	Command_RECT             ; $9b rect
	.word	Command_FRAME            ; $9c frame
	.word	Command_CHAR             ; $9d char
	.word	Unary16Hex               ; $9e hex$
	.word	CommandInput             ; $9f input
	.word	CommandInputString       ; $a0 input$
	.word	CommandInputReset        ; $a1 input.start
	.word	UnaryLen                 ; $a2 len
	.word	LinkFloatCompare         ; $a3 f.cmp
	.word	LinkDivideInt32          ; $a4 int.div
	.word	NegateTOS                ; $a5 negate
	.word	CommandNewLine           ; $a6 new.line
	.word	CommandNext              ; $a7 next
	.word	NotTOS                   ; $a8 not
	.word	CommandOn                ; $a9 on
	.word	CommandMoreOn            ; $aa moreon
	.word	UnaryPeek                ; $ab peek
	.word	CommandPOKE              ; $ac poke
	.word	UnaryPos                 ; $ad pos
	.word	GetChannel               ; $ae getchannel
	.word	SetChannel               ; $af setchannel
	.word	PrintNumber              ; $b0 print.n
	.word	PrintString              ; $b1 print.s
	.word	CommandRead              ; $b2 read
	.word	CommandReadString        ; $b3 read$
	.word	UnaryRND                 ; $b4 rnd
	.word	StringConcatenate        ; $b5 concat
	.word	SignTOS                  ; $b6 sgn
	.word	PrintTab                 ; $b7 print.tab
	.word	PrintPos                 ; $b8 print.pos
	.word	PrintSpace               ; $b9 print.spc
	.word	Unary_Str                ; $ba str$
	.word	Unary_Left               ; $bb left$
	.word	Unary_Right              ; $bc right$
	.word	Unary_Mid                ; $bd mid$
	.word	CommandSwap              ; $be swap
	.word	TimeTOS                  ; $bf ti
	.word	TimeString               ; $c0 ti$
	.word	UnaryUsr                 ; $c1 usr
	.word	ValUnary                 ; $c2 val
	.word	CommandClose             ; $c3 close
	.word	CommandExit              ; $c4 exit
	.word	CommandDebug             ; $c5 debug
	.word	CommandOpen              ; $c6 open
	.word	CommandScreen            ; $c7 screen
	.word	CommandVPOKE             ; $c8 vpoke
	.word	CommandVPEEK             ; $c9 vpeek
	.word	CommandShift             ; $ca .shift
	.word	PushByteCommand          ; $cb .byte
	.word	PushWordCommand          ; $cc .word
	.word	CommandPushN             ; $cd .float
	.word	CommandPushS             ; $ce .string
	.word	CommandData              ; $cf .data
	.word	CommandGoto              ; $d0 .goto
	.word	CommandGosub             ; $d1 .gosub
	.word	CommandGotoZ             ; $d2 .goto.z
	.word	CommandGotoNZ            ; $d3 .goto.nz
	.word	CommandVarSpace          ; $d4 .varspace


ShiftVectorTable:
	.word	CommandClr               ; $ca80 clr
	.word	CommandDIM               ; $ca81 dim
	.word	CommandEnd               ; $ca82 end
	.word	UnaryJoy                 ; $ca83 joy
	.word	LinkFloatIntegerPartDown ; $ca84 int
	.word	LinkFloatSquareRoot      ; $ca85 sqr
	.word	LinkFloatLogarithm       ; $ca86 log
	.word	LinkFloatExponent        ; $ca87 exp
	.word	LinkFloatCosine          ; $ca88 cos
	.word	LinkFloatSine            ; $ca89 sin
	.word	LinkFloatTangent         ; $ca8a tan
	.word	LinkFloatArcTan          ; $ca8b atn
	.word	XCommandMouse            ; $ca8c mouse
	.word	XUnaryMB                 ; $ca8d mb
	.word	XUnaryMX                 ; $ca8e mx
	.word	XUnaryMY                 ; $ca8f my
	.word	CommandRestore           ; $ca90 restore
	.word	CommandStop              ; $ca91 stop
	.word	CommandSYS               ; $ca92 sys
	.word	CommandTIWrite           ; $ca93 ti$.write
	.word	CommandWAIT              ; $ca94 wait
	.word	X16I2CPoke               ; $ca95 i2cpoke
	.word	X16I2CPeek               ; $ca96 i2cpeek
	.word	CommandBank              ; $ca97 bank
	.word	XCommandSleep            ; $ca98 sleep
	.word	X16_Audio_FMINIT         ; $ca99 fminit
	.word	X16_Audio_FMNOTE         ; $ca9a fmnote
	.word	X16_Audio_FMDRUM         ; $ca9b fmdrum
	.word	X16_Audio_FMINST         ; $ca9c fminst
	.word	X16_Audio_FMVIB          ; $ca9d fmvib
	.word	X16_Audio_FMFREQ         ; $ca9e fmfreq
	.word	X16_Audio_FMVOL          ; $ca9f fmvol
	.word	X16_Audio_FMPAN          ; $caa0 fmpan
	.word	X16_Audio_FMPLAY         ; $caa1 fmplay
	.word	X16_Audio_FMCHORD        ; $caa2 fmchord
	.word	X16_Audio_FMPOKE         ; $caa3 fmpoke
	.word	X16_Audio_PSGINIT        ; $caa4 psginit
	.word	X16_Audio_PSGNOTE        ; $caa5 psgnote
	.word	X16_Audio_PSGVOL         ; $caa6 psgvol
	.word	X16_Audio_PSGWAV         ; $caa7 psgwav
	.word	X16_Audio_PSGFREQ        ; $caa8 psgfreq
	.word	X16_Audio_PSGPAN         ; $caa9 psgpan
	.word	X16_Audio_PSGPLAY        ; $caaa psgplay
	.word	X16_Audio_PSGCHORD       ; $caab psgchord
	.word	CommandCls               ; $caac cls
	.word	CommandLocate            ; $caad locate
	.word	CommandColor             ; $caae color
	.send code