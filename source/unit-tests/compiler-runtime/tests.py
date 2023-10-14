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
#									Identifier classes
#
# *******************************************************************************************

class Identifier(object):
	def __init__(self):
		self.name = self.getValidName()+self.getTypeMarker()
		self.value = self.getDefaultValue()

	def getValidName(self):
		name = chr(random.randint(65,90))
		if random.randint(0,2) > 0:
			if random.randint(0,1) == 0:
				name += chr(random.randint(65,90))
			else:
				name += chr(random.randint(48,57))
		if "/TO/IF/MB/MX/MY/ON/FN/OR/GO/".find(name) >= 0:
			return self.getValidName()
		return name 

	def getName(self):
		return self.name 

	def getValue(self):
		return self.value 

	def setValue(self,v):
		self.value = v 
		
	def updateValue(self):
		self.value = self.newValue()
		return self.getValue()

	def assignment(self):
		return self.getName() + "="+self.render()

	def check(self):
		return self.getName() + "<>"+self.render()

class IFloat(Identifier):
	def getTypeMarker(self):
		return ""
	def getDefaultValue(self):
		return 0.0
	def render(self):
		return "{0:.5f}".format(self.getValue())
	def newValue(self):
		return random.randint(-3200000,3200000) / 100.0

class IInteger(Identifier):
	def getTypeMarker(self):
		return "%"
	def getDefaultValue(self):
		return 0
	def render(self):
		return str(self.getValue())
	def newValue(self):
		return random.randint(-32000,32000)

class IString(Identifier):
	def getTypeMarker(self):
		return "$"
	def getDefaultValue(self):
		return ""
	def render(self):
		return '"'+self.getValue()+'"'
	def newValue(self):
		return "".join([chr(random.randint(65,90)) for i in range(0,random.randint(0,8))])

# *******************************************************************************************
#
#									Test Script class
#
# *******************************************************************************************

class TestScript(object):
	def __init__(self,seed = None,maxChars = 8192,maxLines = 100):
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
		print("{0} {1}".format(self.line,s.upper().replace("###",str(self.line))))
		self.line += 10
		self.charsLeft -= len(s)
		self.linesLeft -= 1

	def initialisePhase(self):
		pass

	def mainPhase(self):
		while not self.isComplete():
			self.addTest()

	def addTest(self):
		self.assertExpression(self.areNearlyEqual("10","12",1))

	def terminatePhase(self):
		pass
		
	def validatePhase(self):
		pass

	def isComplete(self):
		return self.charsLeft <= 0 or self.linesLeft <= 0

	def checkExpression(self,expr):
		self.render("if {0} then print ###:stop".format(expr))

	def checkEqual(self,n1,n2):
		self.checkExpression(self.areEqual(n1,n2))

	def checkAreNearlyEqual(self,n1,n2,percent = 0.1):
		self.checkExpression(self.areNearlyEqual(n1,n2))

	def checkStringEqual(self,s1,s2):
		self.checkExpression(s1+" <> "+s2)

	def areEqual(self,n1,n2):
		return "({0} <> {1:.5f})".format(n1,n2)

	def areNearlyEqual(self,n,correct,percent = 0.1):
		if isinstance(correct,str):
			correct = float(correct)
		error = max(0.0001,round(abs(correct) * percent / 100,5))
		return "(abs(({0})-{1:.5f})) >= {2:.6f}".format(n,correct,error)

	def getNumberClass(self):
		return IFloat() if random.randint(0,1) == 0 else IInteger()

	def getNumber(self):
		return self.getNumberClass().updateValue()

if __name__ == "__main__":

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
