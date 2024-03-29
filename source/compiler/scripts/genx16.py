# *******************************************************************************************
# *******************************************************************************************
#
#       Name :      genx16.py
#       Purpose :   Generation compiler for X16 FM/PSG calls
#       Date :      9th May 2023
#       Author :    Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************

import os,re,sys 

# *******************************************************************************************
#
#		- 	 0 params
#		AX = 2 params, Y = 0, Carry clear
# 		A# = 2 params, XY = 16 bit value, Carry clear
#		A$ = 2 params, XY = string, set voice from param 1
#
# *******************************************************************************************

src = """

FMINIT  		!ym_init 				-
FMNOTE 			!bas_fmnote 			AX
FMDRUM 			!ym_playdrum 			AX
FMINST 			!ym_loadpatch 			AXC
FMVIB 			!bas_fmvib 				AX
FMFREQ 			!bas_fmfreq 			A#
FMVOL 			!ym_setatten 			AX
FMPAN 			!ym_setpan 				AX
FMPLAY 			!bas_fmplaystring 		A$
FMCHORD 		!bas_fmchordstring 		A$
FMPOKE 			!ym_write 				AX

PSGINIT 		!psg_init 				-
PSGNOTE 		!bas_psgnote 			AX
PSGVOL			!psg_setatten 			AX
PSGWAV 			!bas_psgwav				AX
PSGFREQ 		!bas_psgfreq 			A#
PSGPAN 			!psg_setpan 			AX
PSGPLAY 		!bas_psgplaystring 		A$
PSGCHORD		!bas_psgchordstring 	A$

""".replace("!","X16A_").split("\n")

hg = open("source/system-specific/x16/generation/x16_sound.def","w")
hg.write("#\n#\tThis file is automatically generated.\n#\n")

ha = open("../runtime/source/system-specific/x16/generated/x16_sound.asm","w")
ha.write(";\n;\tThis file is automatically generated.\n;\n")
ha.write("\t.section code\n")
for s in [x.strip() for x in src if x.strip() != ""]:
	m = re.match("^(\\w+)\\s+(.*?)\\s+(.*?)$",s)
	assert m is not None,"Bad line "+s
	keyword = m.group(1)
	apicall = m.group(2)
	setup = m.group(3)
	#
	params = "" if setup == "-" else "#,#"
	if setup == "A$":
		params = "#,$"
	hg.write("{0:12}{1} T N\n".format(keyword,params))
	#
	ha.write("X16_Audio_{0}: ;; [!{0}]\n".format(keyword))
	ha.write("\t.entercmd\n")
	ha.write("\tphy\n")

	if setup == "A#":
		ha.write("\tjsr\t\tX16_Audio_Parameters8_16\n")
	if setup == "A$":
		ha.write("\tjsr\t\tX16_Audio_Parameters8_String\n")
	if setup.startswith("AX"):
		ha.write("\tjsr\t\tX16_Audio_Parameters8_8\n")
		ha.write("\t{0}\n".format("sec" if setup.endswith("C") else "clc"))

	ha.write("\tjsr\t\tX16_JSRFAR\n")
	ha.write("\t.word\t{0}\n".format(apicall))
	ha.write("\t.byte\tX16_AudioCodeBank\n")

	ha.write("\tldx\t#$FF\n")
	ha.write("\tply\n")
	ha.write("\t.exitcmd\n\n\n")

ha.write("\t.send code\n")
ha.close()
hg.close()
