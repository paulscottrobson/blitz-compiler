# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		compileinfo.py
#		Purpose :	Compile information
#		Date :		25th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,math
from usedump import *

dmp = MemoryDump()
lbl = LabelStore()

#
#		Output variable offsets in work area
#
varStart = lbl.get("workarea")
while dmp.read(varStart) != 0:
	c1 = dmp.read(varStart+1)
	c2 = dmp.read(varStart+2)
	name = chr((c1 & 0x1F) + 64)
	if (c2 & 0x3F) != 0:
		name += chr(((c2 & 0x3F)^0x20)+0x20)
	if (c1 & 0x40) != 0:
		name += "$"
	if (c1 & 0x60) == 0x20:
		name += "%"
	if (c2 & 0x80) != 0:
		name = "FN"+name+"()"
	ofst = dmp.read(varStart+3)
	print("{0}:{1}".format(name,ofst))
	varStart += dmp.read(varStart)


#
#		Output line number offsets in p-code
#
lineNumberStart = lbl.get("linenumbertable")
lineNumberStart = dmp.readWord(lineNumberStart)
lineNumberEnd = lbl.get("workarea")+lbl.get("workareasize")

start = dmp.readWord(lineNumberEnd-2)-3
while lineNumberStart != lineNumberEnd:
	l = dmp.readWord(lineNumberStart)
	if l != 0xFFFF:
			print("{0}:{1}".format(l,dmp.readWord(lineNumberStart+3)-start))
	lineNumberStart += 5