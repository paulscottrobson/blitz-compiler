# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		stack.py
#		Purpose :	Display the stack
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,math
from usedump import *
from floats import *

dmp = MemoryDump()
lbl = LabelStore()
f = Float()
size = dmp.read(lbl.get("zTemp0"))
if size != 0xFF:
	print("Top of stack is offset {0}".format(size))
	for i in range(0,size+1):
		data = 	dmp.read(lbl.get("NSMantissa0")+i) + \
				(dmp.read(lbl.get("NSMantissa1")+i) << 8) + \
				(dmp.read(lbl.get("NSMantissa2")+i) << 16) + \
				(dmp.read(lbl.get("NSMantissa3")+i) << 24) 
		exp = dmp.read(lbl.get("NSExponent")+i)
		sign = dmp.read(lbl.get("NSStatus")+i)	
		dec = f.toDecimal([data,exp,sign])
		hexa = "${0:x}".format(int(dec)) if dec == int(dec) else ""
		c = '"'+chr(dec)+'"' if dec == int(dec) and dec > 32 and dec < 127 else "   "
		print("\tLevel {0} [${1:08x} ${2:02x} ${3:02x}] {4:<12.4f} {5:<8} {6}".format(i,data,exp,sign,dec,hexa,c))
else:
	print("Stack empty/underflow {0}".format(size))