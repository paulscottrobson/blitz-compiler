# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		floatcom.py
#		Purpose :	Floating point compiler
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,math,re

from floats import *

# *******************************************************************************************
#
#			Generates 6502 Code to test floating point and polynomial routines
#
# *******************************************************************************************

class FPCompiler(object):
	def __init__(self):
		self.float = Float()
		self.mapping = { "+":"FloatAdd","-":"FloatSubtract","*":"FloatMultiply","/":"FloatDivide",
						 "=":"CompareEqual",">":"CompareGreater","<":"CompareLess",
						 "<>":"CompareNotEqual",">=":"CompareGreaterEqual","<=":"CompareLessEqual",
						 "f.cmp":"FloatCompare","negate":"FloatNegate","int":"FloatIntegerPart",
						 "sin":"FloatSine","cos":"FloatCosine","tan":"FloatTangent",
						 "atn":"FloatArcTan","exp":"FloatExponent","log":"FloatLogarithm",
						 "sqr":"FloatSquareRoot","^":"FloatPower",
						 "assert":"FPAssertCheck","abs":"FPAbs",
	}
	#
	def compileGroup(self,g):
		for x in g.split():
			if x != "":
				self.compile(x)
	#
	def compile(self,s):
		m = re.match("^\\-?\\d+$",s)
		if m is not None:
			self.compileConst(int(s))
			return
		m = re.match("^\\-?\\d*\\.\\d*$",s)
		if m is not None:
			self.compileConst(float(s))
			return
		if s == "exit":
			print("\t.exitemu")
			return
		if s in self.mapping:
			print("\tjsr\t{0}".format(self.mapping[s]))
			return 

		if s == "repeat":
			print("\tlda #0")
			print("MainLoop:")
			print("\tpha\n\tjsr\tMainBody\n\tpla")
			print("\tdec a\n\tbne MainLoop")
			print("\trts")
			print("MainBody:")
			return

		assert False,"Bad command "+s
	#
	def compileConst(self,n):
		print("\tjsr\tFPPushConstant\t; {0}".format(n))
		x = self.float.toFloat(n,False)
		print("\t.dword\t${0:08x}".format(x[0]))
		print("\t.byte\t${0:02x},${1:02x}".format(x[1],x[2]))
	#
	def compileFile(self,f):
		for l in open(f).readlines():
			self.compileGroup(l.strip())

fc = FPCompiler()
for f in sys.argv[1:]:
	fc.compileFile(f)