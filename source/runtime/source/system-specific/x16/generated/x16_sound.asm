;
;	This file is automatically generated.
;
	.section code
X16_Audio_FMINIT: ;; [!FMINIT]
	.entercmd
	phy
	jsr		X16_JSRFAR
	.word	X16A_ym_init
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMNOTE: ;; [!FMNOTE]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_bas_fmnote
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMDRUM: ;; [!FMDRUM]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_ym_playdrum
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMINST: ;; [!FMINST]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	sec
	jsr		X16_JSRFAR
	.word	X16A_ym_loadpatch
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMVIB: ;; [!FMVIB]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_bas_fmvib
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMFREQ: ;; [!FMFREQ]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_16
	jsr		X16_JSRFAR
	.word	X16A_bas_fmfreq
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMVOL: ;; [!FMVOL]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_ym_setatten
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMPAN: ;; [!FMPAN]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_ym_setpan
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMPLAY: ;; [!FMPLAY]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_String
	jsr		X16_JSRFAR
	.word	X16A_bas_fmplaystring
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMCHORD: ;; [!FMCHORD]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_String
	jsr		X16_JSRFAR
	.word	X16A_bas_fmchordstring
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_FMPOKE: ;; [!FMPOKE]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_ym_write
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_PSGINIT: ;; [!PSGINIT]
	.entercmd
	phy
	jsr		X16_JSRFAR
	.word	X16A_psg_init
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_PSGNOTE: ;; [!PSGNOTE]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_bas_psgnote
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_PSGVOL: ;; [!PSGVOL]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_psg_setatten
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_PSGWAV: ;; [!PSGWAV]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_bas_psgwav
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_PSGFREQ: ;; [!PSGFREQ]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_16
	jsr		X16_JSRFAR
	.word	X16A_bas_psgfreq
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_PSGPAN: ;; [!PSGPAN]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_8
	clc
	jsr		X16_JSRFAR
	.word	X16A_psg_setpan
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_PSGPLAY: ;; [!PSGPLAY]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_String
	jsr		X16_JSRFAR
	.word	X16A_bas_psgplaystring
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


X16_Audio_PSGCHORD: ;; [!PSGCHORD]
	.entercmd
	phy
	jsr		X16_Audio_Parameters8_String
	jsr		X16_JSRFAR
	.word	X16A_bas_psgchordstring
	.byte	X16_AudioCodeBank
	ldx	#$FF
	ply
	.exitcmd


	.send code