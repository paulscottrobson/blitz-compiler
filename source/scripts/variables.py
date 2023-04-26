# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		variables.py
#		Purpose :	Show the variables from memory dump
#		Date :		26th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,re
from usedump import *
from compileinfo import *

def decode(tabStop,name,dmp,pos):
	s = ""
	if name.find("%") >= 0:
		s = str(dmp.readWord(pos))
	elif name.find("$") >= 0:
		sAddr = dmp.readWord(pos)
		s = "NULL" if sAddr == 0 else dmp.readString(sAddr)
	else:
		s = "{0:.5f}".format(dmp.readFloat(pos))
	print("{0}{1:<8} @ ${2:04x}    {3}".format("\t"*tabStop,name.lower(),pos,s))

if __name__ == "__main__":
	ls = LabelStore()
	md = MemoryDump()
	info = AppInformation()
	varBase = ls.get("WorkArea")


	variables = info.getAllVariables()
	variables.sort(key = lambda x:info.getVariableOffset(x))

	for v in variables:
		if v.endswith("("):
			assert False
		else:
			decode(1,v,md,varBase+info.getVariableOffset(v))
