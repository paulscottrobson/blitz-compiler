# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		pdis.py
#		Purpose :	P-Code Decompiler
#		Date :		15th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,math,re
from pcodeconst import *
from floats import *
from compileinfo import *

# *******************************************************************************************
#
#						P-Code decompiler for testing/debugging purposes.
#
# *******************************************************************************************

class PCodeDecompiler(object):
	def __init__(self):
		self.pcode = PCodeConstants()
		self.float = Float()
		self.code = []
		self.info = AppInformation()
	#
	def decompileFile(self,f):
		self.data = [x for x in open(f,"rb").read(-1)][2:]
		p = 0 
		while p < len(self.data):
			pStart = p 
			if self.data[p] < 64:
				s = "constant "+str(self.data[p])
				p = p + 1
			elif self.data[p] < 112:
				opcode = self.data[p]
				dtype = "#%$"[(opcode-64) >> 4]
				action = "!" if (opcode & 8) != 0 else "@"
				address = (((opcode & 7) << 8) | self.data[p+1]) << 1
				name = self.info.getVariableName(address)
				name = "" if self.info is None else "["+name+"]"
				s = "{0}{1}{2} {3}".format(address,dtype,action,name)
				p += 2
			elif self.data[p] >= 120 and self.data[p] < 128:
				n = self.data[p]
				p += 1
				s = ("#%$"[n & 3]+("@" if (n & 4) == 0 else "!")).strip()
			else:
				s = self.pcode.getToken(self.data[p]) 
				if s is not None:
					if s == "new.line":
						lineNumber = self.info.getLineNumber(p)
						if lineNumber is not None:
							s = s + " ["+str(lineNumber)+"]"
					p = p + 1
					if s == ".byte":
						s = ".byte {0}".format(self.data[p])
						p = p + 1
					if s == ".word":
						s = ".word {0}".format(self.data[p]+self.data[p+1]*256)
						p = p + 2
					if s == ".float":
						mantissa = (self.data[p+1] + (self.data[p+2] << 8) + (self.data[p+3] << 16) + (self.data[p+4] << 24)) & 0x7FFFFFFF
						f = self.float.toDecimal([mantissa,self.data[p],self.data[p+4] & 0x80])
						p = p + 5
						s = ".float {0:.5f}".format(f)
					if s == ".shift":
						s = self.pcode.getToken((self.data[p-1] << 8)| self.data[p])+" <shift>"
						p = p + 1
					if s == ".string" or s == ".data":
						s += " {"
						for i in range(0,self.data[p]):
							p = p + 1
							s += chr(self.data[p])
						p += 1
						s += '}'
					if s == ".varspace":
						s = ".varspace ${0:x}".format(self.data[p]+self.data[p+1]*256)
						p = p + 2
					if s.startswith(".goto") or s == ".gosub":
						page = self.data[p]
						offset = self.data[p+1]+(self.data[p+2] << 8)
						addr = (p + offset) & 0xFFFF
						s = "{0} ${1:02x}:{2:04x} [${3:04x}]".format(s,page,addr,offset)
						p += 3
				else:
					s = "data ${0:02x}".format(self.data[p]) if self.data[p] != 0xFF else "<end marker>"
					p = p + 1
			data = " ".join(["{0:02x}".format(n) for n in self.data[pStart:p]])
			print("{0:04x} : {2:24} : {1}".format(pStart,s,data[:24]))
		
pc = PCodeDecompiler()
for f in sys.argv[1:]:
	pc.decompileFile(f)