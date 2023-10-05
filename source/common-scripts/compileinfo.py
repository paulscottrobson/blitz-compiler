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

# *******************************************************************************************
#
#								Information class
#
# *******************************************************************************************

class AppInformation(object):
	#
	def __init__(self,fileName = "testing/code/program.data"):
		self.lines = {}
		self.variables = {}
		self.varToOffset = {}
		for x in open(fileName).readlines():
			if x != "":
				x = x.split(":")
				if re.match("^\\d+$",x[0]) is not None:
					self.lines[int(x[1])] = int(x[0])
				else:
					self.variables[int(x[1])] = x[0].lower()
					self.varToOffset[x[0].lower()] = int(x[1])
	#
	def getLineNumber(self,offset):
		return self.lines[offset] if offset in self.lines else None 
	#
	def getVariableName(self,offset):
		return self.variables[offset] if offset in self.variables else None 
	#
	def getAllVariables(self):
		return [x for x in self.varToOffset.keys()]
	#
	def getVariableOffset(self,name):
		name = name.strip().lower()
		return self.varToOffset[name] if name in self.varToOffset else None 

if __name__ == "__main__":
#	app = AppInformation()
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
		if (c1 & 0x80) != 0:
			name += "("
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
		