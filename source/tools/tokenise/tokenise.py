# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		tokenise.py
#		Purpose :	Tokenise text file to BASIC
#		Date :		29th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,re
from tokens import *

# *******************************************************************************************
#
#								Tokeniser Worker
#
# *******************************************************************************************

class Tokeniser(object):
	def __init__(self):
		self.tokens = TokenStore()
		self.longest = max([len(s) for s in self.tokens.getAllTokens()])

	def tokeniseBody(self,body):
		body = body.upper().strip()
		self.data = []
		while body != "":
			body = self.tokeniseOne(body)
		return self.data+[0]

	def tokeniseOne(self,s):
		if s[0] == '"':
			m = re.match('^(\\".*?\\")(.*)$',s)
			assert m is not None,"Unbalanced quotes "+s
			self.data += [ord(c) for c in m.group(1)]
			return m.group(2)			

		if s[0] >= "A" and s[0] <= "Z":
			m = re.match("^([A-Z]+[\\(\\$\\#]?)(.*)$",s)
			assert m is not None

			for l in range(7,1,-1):
				token = self.tokens.getID(s[:l])
				if token is not None and len(self.tokens.getToken(token)) == l:
					if token >= 0x100:
						self.data.append(token >> 8)
					self.data.append(token & 0xFF)
					#print(s,"["+s[l:]+"]",l)
					return s[l:]

		token = self.tokens.getID(s[0])
		self.data.append(ord(s[0]) if token is None else token)
		return s[1:]

	def tokeniseLine(self,s):
		m = re.match("^(\\d+)\\s*(.*)$",s)
		assert m is not None,"Bad line format "+s
		line = int(m.group(1))
		return [line & 0xFF,line >> 8] + self.tokeniseBody(m.group(2).strip())

# *******************************************************************************************
#
#									Program converter
#
# *******************************************************************************************

class ProgramTokeniser(object):
	#
	def __init__(self,loadAddress = 0x801):
		self.loadAddress = loadAddress
		self.address = self.loadAddress
		self.binary = [self.address & 0xFF,self.address >> 8]
		self.tokeniser = Tokeniser()
	#
	def add(self,s):
		line = self.tokeniser.tokeniseLine(s)
		startNextLine = self.address + len(line) + 2
		line = [startNextLine & 0xFF,startNextLine >> 8] + line 
		self.binary += line 
		self.address = startNextLine 
		assert len(self.binary) - 2 + self.loadAddress == self.address
	#
	def get(self):
		return self.binary + [ 0,0 ]
	#
	def write(self,fileName):
		open(fileName,"wb").write(bytes(self.get()))

if __name__ == "__main__":
	if len(sys.argv) != 3:
		sys.stderr.write("python tokenise.py <input> <output>\n")
		sys.exit(-1)
	pt = ProgramTokeniser()
	for l in open(sys.argv[1]).readlines():
		l = l.strip()
		if l != "":
			pt.add(l)			
	pt.write(sys.argv[2])