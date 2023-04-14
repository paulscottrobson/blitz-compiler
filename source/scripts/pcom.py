# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		pcom.py
#		Purpose :	P-Code compiler
#		Date :		13th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,math,re
from pcode import *

# *******************************************************************************************
#
#					Very simple P-Code compiler for testing purposes.
#
# *******************************************************************************************

class PCodeCompiler(object):
	def __init__(self):
		self.pcode = PCode()
		self.code = []
	#
	def compileString(self,s):
		s = s.upper()
		for w in s.split():
			self.compileWord(w)
	#
	def print(self,s):
		s = s.split(";")
		print("{0:40} ; {1}".format(s[0],s[1].lower()))			
	#
	def compileWord(self,w):
		if re.match("^\\-?\\d+$",w):
			self.compileInteger(int(w))
			return
		#
		if re.match("^\\d+\\%[\\@\\!]$",w):
			self.compileAccess("%",int(w[:w.find("%")]),64 if w.endswith("@") else 72)
			return
		#
		if re.match("^\\d+[\\@\\!]$",w):
			self.compileAccess("#",int(w[:-1]),80 if w.endswith("@") else 88)
			return
		#
		if re.match("^\\d+\\$[\\@\\!]$",w):
			self.compileAccess("$",int(w[:w.find("$")]),96 if w.endswith("@") else 104)
			return
		#
		if re.match("^\\-?\\d+\\.\\d+$",w):
			self.compileData(".float",str(abs(float(w))),w)
			if float(w) < 0:
				self.compileWord("negate")
			return
		#
		if w.startswith('"') and w.endswith('"'):
			self.compileData(".string",w[1:-1].upper().replace("_"," "),w)
			return
		#
		t = self.pcode.getID(w)
		if t is not None:
			self.print("\t.byte\t{0} ; {1}".format(t,w))
			return

		assert False,"Unknown "+w
	#
	def compileInteger(self,n):
		assert abs(n) < 65535
		if n < 0:
			self.compileInteger(-n)
			self.compileWord("negate")
		elif n < 64:
			self.print("\t.byte\t{0} ; {0}".format(n))
		elif n < 256:
			self.print("\t.byte\t{0},{1} ; {1} ".format(self.pcode.getID(".BYTE"),n))
		else:
			self.print("\t.byte\t{0},{1},{2} ; {1} ".format(self.pcode.getID(".WORD"),n & 0xFF,n >> 8))
	#
	def compileAccess(self,type,addr,base):
		assert (addr & 1) == 0
		self.print("\t.byte\t{0},{1} ; {2}{3}{4}".format(base+(addr >> 9),(addr >> 1) & 0xFF,addr,type,"@" if (base & 8) == 0 else "!"))
	#
	def compileData(self,cmd,data,w):
		self.print("\t.text\t{0},{1},\"{2}\" ; {3} ".format(self.pcode.getID(cmd.upper()),len(data),data,w))

pc = PCodeCompiler()
for s in sys.stdin.readlines():
	if not s.strip().startswith("#"):
		pc.compileString(s.strip())