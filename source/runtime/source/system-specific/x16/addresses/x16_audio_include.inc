; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_audio_include.inc
;		Purpose:	Addresses X16 Kernal (Audio API)
;		Created:	7th May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************
;
;		All these have to be called by JSRFAR.
;
X16A_audio_init=$C09F
X16A_bas_fmchordstring=$C08D
X16A_bas_fmfreq=$C000
X16A_bas_fmnote=$C003
X16A_bas_fmplaystring=$C006
X16A_bas_fmvib=$C009
X16A_bas_playstringvoice=$C00C
X16A_bas_psgchordstring=$C090
X16A_bas_psgfreq=$C00F
X16A_bas_psgnote=$C012
X16A_bas_psgwav=$C015
X16A_bas_psgplaystring=$C018
X16A_notecon_bas2fm=$C01B
X16A_notecon_bas2midi=$C01E
X16A_notecon_bas2psg=$C021
X16A_notecon_fm2bas=$C024
X16A_notecon_fm2midi=$C027
X16A_notecon_fm2psg=$C02A
X16A_notecon_freq2bas=$C02D
X16A_notecon_freq2fm=$C030
X16A_notecon_freq2midi=$C033
X16A_notecon_freq2psg=$C036
X16A_notecon_midi2bas=$C039
X16A_notecon_midi2fm=$C03C
X16A_notecon_midi2psg=$C03F
X16A_notecon_psg2bas=$C042
X16A_notecon_psg2fm=$C045
X16A_notecon_psg2midi=$C048
X16A_psg_getatten=$C093
X16A_psg_getpan=$C096
X16A_psg_init=$C04B
X16A_psg_playfreq=$C04E
X16A_psg_read=$C051
X16A_psg_setatten=$C054
X16A_psg_setfreq=$C057
X16A_psg_setpan=$C05A
X16A_psg_setvol=$C05D
X16A_psg_write=$C060
X16A_psg_write_fast=$C0A2
X16A_ym_getatten=$C099
X16A_ym_getpan=$C09C
X16A_ym_init=$C063
X16A_ym_loaddefpatches=$C066
X16A_ym_loadpatch=$C069
X16A_ym_loadpatchlfn=$C06C
X16A_ym_playdrum=$C06F
X16A_ym_playnote=$C072
X16A_ym_setatten=$C075
X16A_ym_setdrum=$C078
X16A_ym_setnote=$C07B
X16A_ym_setpan=$C07E
X16A_ym_read=$C081
X16A_ym_release=$C084
X16A_ym_trigger=$C087
X16A_ym_write=$C08A
