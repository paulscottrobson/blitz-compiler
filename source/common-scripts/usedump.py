# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		usedump.py
#		Purpose :	Access memory dump
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,re
from floats import *

# *******************************************************************************************
#
#									Access the label store
#
# *******************************************************************************************

class LabelStore(object):
	def __init__(self):
		self.labels = {}
		for s in open("build/code.lbl").readlines():
			m = re.match("^(.*?)\\s*\\=\\s*(.*?)\\s*$",s)
			assert m is not None," ??? "+s
			s = m.group(2).strip()
			self.labels[m.group(1).lower()] = int(s[1:],16) if s.startswith("$") else int(s)
	#
	def get(self,lbl):
		return self.labels[lbl.strip().lower()]

# *******************************************************************************************
#
#									Access dump.bin
#
# *******************************************************************************************

class MemoryDump(object):
	def __init__(self):
		self.mem = [x for x in open("dump.bin","rb").read(-1)]
		self.labels = LabelStore()
		self.f = Float()

	def read(self,addr):
		return self.mem[addr]
	def readWord(self,addr):
		return self.read(addr)+(self.read(addr+1) << 8)
	def readLong(self,addr):
		return self.readWord(addr)+(self.readWord(addr+2) << 16)

	def convert(self,addr):
		return self.labels.get(addr) if isinstance(addr,str) else addr 

	def readFloat(self,addr):
		addr = self.convert(addr)
		d = [self.readLong(addr),self.read(addr+4),self.read(addr+5)]
		return self.f.toDecimal(d)
		
	def readString(self,addr):
		if addr == 0:
			return '""'
		s = "".join([chr(self.read(addr+n+3)) for n in range(0,self.read(addr+2))])
		return "\"{2}\" [@${0:02x} ML:{1}]".format(addr,self.read(addr),s)