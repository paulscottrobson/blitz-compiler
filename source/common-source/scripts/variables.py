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
	print("{0}{1:<16} @ ${2:04x} \t{3}".format("\t"*tabStop,name.lower().replace("(",""),pos,s))

def decodeArray(tabStop,name,dmp,arrayPtr,varBase):
	arrayData = dmp.readWord(arrayPtr)+varBase
	arrayExt = dmp.readWord(arrayData)
	arrayType = dmp.read(arrayData+2)
	arrayElementSize = 2 if (arrayType & 0xE0) != 0 else 6
	print("{0}{1:<16} @ ${2:04x} \t${3:02x}".format("\t"*tabStop,name.lower().replace("(",""),arrayData,arrayType))
	for e in range(0,arrayExt):
		p = arrayData + 3 + e * arrayElementSize
		if (arrayType & 0x80) != 0:
			decodeArray(tabStop+1,name+"["+str(e)+"]",dmp,p,varBase)
		else:
			decode(tabStop+1,name+"["+str(e)+"]",dmp,p)

if __name__ == "__main__":
	ls = LabelStore()
	md = MemoryDump()
	info = AppInformation()
	varBase = ls.get("WorkArea")


	variables = info.getAllVariables()
	variables.sort(key = lambda x:info.getVariableOffset(x))

	for v in variables:
		if v.endswith("("):
			decodeArray(1,v,md,varBase+info.getVariableOffset(v),varBase)
		else:
			decode(1,v,md,varBase+info.getVariableOffset(v))
