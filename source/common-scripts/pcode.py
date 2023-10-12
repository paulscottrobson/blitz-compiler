# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		pcode.py
#		Purpose :	Runtime P-Code definition
#		Date :		12th April 2023
#		Author : 	Paul Robson .paul@robsons.org.uk
#
# *******************************************************************************************
# *******************************************************************************************

import os,re,sys
from c64tokens import *
from build import *

class PCode(object):
	def __init__(self,tokenList = [C64TokenStore()]):
		self.tokenList = tokenList
		self.currentID = 0x80
		self.defines = []
		self.idToToken = {}
		self.tokenToID = {}
		self.shiftedKeywords = []
		self.doBinary(tokenList)
		self.doCommands()
		self.doExtras()
		self.currentID = (self.tokenToID[".shift"] << 8) | 0x80
		self.addShiftedTokens()

	def doCommands(self):
		self.define("PCD_STARTCOMMAND")		
		for f in Builder("../runtime").getASMFiles():
			for s in open(f).readlines():
				if s.find(";;") >= 0:
					m = re.match("^(.*?)\\:\\s*\\;\\;\\s*\\[(.*)\\]\\s*$",s)
					assert m is not None,"Bad line "+s
					t = m.group(2)
					if t[0] != ".":
						if t.startswith("!"):
							self.shiftedKeywords.append(t[1:])
						else:
							self.token(t)
		self.define("PCD_ENDCOMMAND")		

	def doExtras(self):
		self.commandSize = {}
		self.startCommands = self.currentID
		self.define("PCD_STARTSYSTEM")		
		self.extra(".shift",1)
		self.extra(".byte",1)
		self.extra(".word",2)
		self.extra(".float",5)
		self.extra(".string",0xFF)
		self.extra(".data",0xFF)
		self.extra(".goto",2)
		self.extra(".gosub",2)
		self.extra(".goto.z",2)
		self.extra(".goto.nz",2)
		self.extra(".varspace",2)
		self.extra(".restore",2)
		self.define("PCD_ENDSYSTEM")	
		self.endCommands = self.currentID	

	def doBinary(self,tokenList):
		self.define("PCD_STARTBINARY")		
		self.addTokens(tokenList[0].getBinary()+",>=,<>,<=")
		self.define("PCD_ENDBINARY")		

	def addTokens(self,csList):
		for w in csList.split(","):
			self.token(w)

	def addShiftedTokens(self):
		for t in self.shiftedKeywords:
			self.addTokens(t)

	def extra(self,cmd,size):
		self.commandSize[self.currentID] = size
		self.token(cmd)

	def define(self,name,pos = None):
		pos = self.currentID if pos is None else pos
		#print(name,pos)
		self.defines.append([name,pos])

	def token(self,name):
		name = name.strip().lower()
		if name not in self.tokenToID:
			self.tokenToID[name] = self.currentID
			self.idToToken[self.currentID] = name
			#print(self.currentID,name)	
			self.currentID += 1

	def getToken(self,i):
		return self.idToToken[i] if i in self.idToToken else None
	def getID(self,t):
		t = t.strip().lower()
		return self.tokenToID[t] if t in self.tokenToID else None

	def dump(self):
		print(";\n;\tThis file is automatically generated\n;")
		for d in self.defines:
			print("{0} = ${1:02x}".format(d[0],d[1]))
		print()
		ids = [x for x in self.idToToken.keys()]
		ids.sort()
		for i in ids:
			s = self.tokenList[0].tidy(self.idToToken[i])
			print("{0:20} = ${1:02x} ; {2}".format("PCD_"+s.upper().replace(".","CMD_"),i,self.idToToken[i].lower()))

	def dumpSizeTable(self,f):
		h = open(f,"w")
		h.write(";\n;\tThis file is automatically generated\n;\n")
		h.write(".section code\n")
		h.write("MOFSizeTable:\n")
		for i in range(self.startCommands,self.endCommands):
			h.write("\t.byte\t{0:<10}\t; ${1:02x} {2}\n".format(self.commandSize[i],i,self.idToToken[i].lower()))
		h.write(".send code\n")
		h.close()

	def createClass(self,f):
		h = open(f,"w")
		h.write("#\n#\tThis file is automatically generated\n#\n")
		h.write("class PCodeConstantsRaw(object):\n")
		h.write("\tdef get(self):\n")
		ids = [x for x in self.idToToken.keys()]
		ids.sort()
		d = "|".join(["{0}:{1}".format(id,self.idToToken[id]) for id in ids])
		h.write("\t\treturn \"{0}\"\n".format(d))
		h.close()

if __name__ == "__main__":
	pc = PCode()
	pc.dump()
	pc.createClass("scripts/pcodeconstraw.py")
	pc.dumpSizeTable("source/generated/pcodesize.asm")

# ***********************************************************************************************************************************************
#
#		0-63 			0-63	Constants 0-63, pushed on stack
# 		64-71 ll  		nn@	Loads the 12 bit value .lower 3 bits of opcode, 11 bits of second byte, shifted left once as a 32 bit iFloat
# 		72-79 ll  		nn!	Saves the 12 bit value .lower 3 bits of opcode, 11 bits of second byte, shifted left once as a 32 bit iFloat
#		80-87 ll 		nn%@		As above but for a 16 bit int16
# 		88-95 ll 		nn%! 	As above but for a 16 bit int16
# 		96-103 ll 		nn$@	As above but for a 16 bit string address
# 		104-111 ll 		nn$!	As above but for a 16 bit string address
# 		112-119 		.not used
#		120-122 		#@ %@ $@  Address <op> Data readers
# 		124-126 		#! %! $!  Address <op> Data writers
#		128+ 			Binary operators in the same order as in the C64, ending with the aditional >= <> <= tokens
#		+ 				Command words / Unary operators
#		+				Data words ; these have associated data, the size of which is in a table
#
#							.SHIFT nn   		1		Shifted action word
#							.BYTE nn 			1 		Load unsigned int
#							.WORD ll hh 		2 		Load 16 bit integer
#							.FLOAT ex mtp 		$FF		Float as exponent,mantissa with sign in mantissa[3].7
#							.STRING ll ss 		$FF		ASCIIZ string
#							.DATA ll ss 		$FF		Packed data statements
#							.GOTO ll hh			2 		Go to offset from the current page beginning.
#							.GOSUB ll hh 		2 		Same but GOSUB. also .GOTO.NZ and .GOTO.Z
#
# ***********************************************************************************************************************************************

