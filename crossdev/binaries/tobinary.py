# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		tobinary.py
#		Purpose :	Convert file to binary
#		Date :		28th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys

for f in sys.argv[1:]:
	code = [x for x in open(f,"rb").read(-1)]
	name = f.replace(".prg","_code.h")
	s = ",".join([str(x) for x in code])
	h = open(name,"w")
	h.write("#define {0} {1}\n".format(f.replace(".prg","_SIZE").upper(),len(code)))
	h.write("static const BYTE8 {0}[] = {{ {1} }};\n\n".format(f.replace(".prg","_code"),s))
	h.close()