# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		variables.py
#		Purpose :	Show the variables from memory dump
#		Date :		18th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,re
from usedump import *

if __name__ == "__main__":
	ls = LabelStore()
	md = MemoryDump()

	varBase = ls.get("WorkArea")
	for i in range(0,26):
		p = varBase + i * 10
		s0 = md.readWord(p)
		s1 = md.readString(s0) if s0 != 0 else "NULL"
		s2 = md.readWord(p+2)
		s2 = s2-65536 if (s2 & 0x8000) != 0 else s2
		s3 = md.readFloat(p+4)
		if s0 != 0 or s2 != 0 or s3 != 0:
			print("{0} {3:<20}   {0}% {2:<6}{0}$ {1}".format(chr(i+65),s1,s2,s3))
