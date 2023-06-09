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
