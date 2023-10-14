# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		detokenise.py
#		Purpose :	PRG to text file
#		Date :		7th October 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,re
from c64tokens import *

# *******************************************************************************************
#
#								Tokeniser Worker
#
# *******************************************************************************************

class DeTokeniser(object):
	def __init__(self):
		self.tokens = C64TokenStore()

	def detokenise(self,filename,handle):
		program = [x for x in open(filename,"rb").read(-1)]
		p = 2
		while program[p] != 0 or program[p+1] != 0:
			handle.write(self.detokeniseLine(program,p)+"\n")
			p = p + 4
			while program[p] != 0:
				p = p + 1
			p = p + 1

	def detokeniseLine(self,program,p):
		space = ""
		lineNo = program[p+2]+program[p+3]*256
		code = "{0:<5} ".format(lineNo)
		p = p + 4
		while program[p] != 0:
			token = program[p]
			p += 1
			if token == 0xCE:
				token = (token << 8) + program[p]
				p += 1
			if token >= 0x80:
				keyword = self.tokens.getToken(token)
				if keyword[0] >= "A" and keyword[0] <= "Z":
					if not code.endswith(" "):
						code += space
					keyword = keyword + space
				code = code + keyword
			else:
				code = code + chr(token)
			if token == 34:
				done = False
				while not done:
					if program[p] == 0:
						done = True 
					else:
						code = code + chr(program[p])
						done = program[p] == 34
						p += 1

		return code

if __name__ == "__main__":
	DeTokeniser().detokenise(sys.argv[1],sys.stdout)