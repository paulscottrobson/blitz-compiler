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

class FPCompiler(object):
	def __init__(self):
		self.float = Float()
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

		assert "Bad command "+s
	#
	def compileConst(self,n):
		print("\tjsr\tFPPushConstant\t; {0}".format(n))
		x = self.float.toFloat(n,False)
		print("\t.dword\t${0:08x}".format(x[0]))
		print("\t.byte\t${0:02x},${1:02x}".format(x[1],x[2]))





fc = FPCompiler()
fc.compile("24.358")
fc.compile("42")
fc.compile("-3.1415926")