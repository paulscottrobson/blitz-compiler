# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		tests.py
#		Purpose :	Support classes for testing
#		Date :		5th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,re,math,random

# *******************************************************************************************
#
#										Value classes
#
# *******************************************************************************************

class Value(object):
	def getValue(self):
		return self.value

class VFloat(Value):
	def __init__(self):
		self.value = 0.0
	def updateValue(self):
		self.value = random.randint(-100000,100000) / 100.0
		return self.getValue()
	def render(self):
		return str(self.value)

class VInteger(Value):
	def __init__(self):
		self.value = 0.0
	def updateValue(self):
		self.value = random.randint(-100000,100000)
		return self.getValue()
	def render(self):
		return str(self.value)

class VString(Value):
	def __init__(self,maxStringSize = 6):
		self.value = ""
		self.maxStringSize = maxStringSize
	def updateValue(self):
		self.value = "".join([chr(random.randint(65,90)) for i in range(0,random.randint(0,self.maxStringSize))])
		return self.getValue()
	def render(self):
		return '"'+str(self.value)+'"'

# *******************************************************************************************
#
#									Identifier classes
#
# *******************************************************************************************

class Identifier(object):
	def __init__(self):
		self.name = chr(random.randint(65,90))
		if random.randint(0,2) > 0:
			if random.randint(0,1) == 0:
				self.name += chr(random.randint(65,90))
			else:
				self.name += chr(random.randint(48,57))
		self.name += self.getTypeMarker()
		self.value = self.getDefaultValue()

	def getName(self):
		return self.name 

	def getValue(self):
		return self.value 

	def updateValue(self):
		self.value.updateValue()
		return self.getValue()

	def assignment(self):
		return self.getName() + "="+self.getValue().render()

	def check(self):
		return self.getName() + "="+self.getValue().render()

class IFloat(Identifier):
	def getTypeMarker(self):
		return ""
	def getDefaultValue(self):
		return VFloat()

class IInteger(Identifier):
	def getTypeMarker(self):
		return "%"
	def getDefaultValue(self):
		return VInteger()

class IString(Identifier):
	def getTypeMarker(self):
		return "$"
	def getDefaultValue(self):
		return VString()

# *******************************************************************************************
#
#									Test Script class
#
# *******************************************************************************************

class TestScript(object):
	def __init__(self,seed = None,maxChars = 4096,maxLines = 10):
		if seed is None:
			seed = random.randint(0,9999)
		random.seed(seed)
		self.charsLeft = maxChars
		self.linesLeft = maxLines
		self.line = 100
		self.render("REM *** SEED {0} ***".format(seed))
		self.initialisePhase()
		self.mainPhase()
		self.terminatePhase()
		self.validatePhase()
		self.render("END")

	def render(self,s):
		print("{0} {1}".format(self.line,s.upper()))
		self.line += 10
		self.charsLeft -= len(s)
		self.linesLeft -= 1

	def initialisePhase(self):
		pass
	def mainPhase(self):
		while not self.isComplete():
			self.render("REM TEST")
	def terminatePhase(self):
		pass
	def validatePhase(self):
		pass

	def isComplete(self):
		return self.charsLeft <= 0 or self.linesLeft <= 0

if __name__ == "__main__":
	print(VFloat().render())
	print(VInteger().render())	
	print(VString().render())	

	i = IFloat()
	print(i.name,i.value.render())
	i.updateValue()
	print(i.name,i.value.render())
	print(i.assignment())

	i = IString()
	print(i.name,i.value.render())		
	i.updateValue()
	print(i.name,i.value.render())
	print(i.assignment())

	i = IInteger()
	print(i.name,i.value.render())		
	i.updateValue()
	print(i.name,i.value.render())
	print(i.assignment())

	ts = TestScript()
