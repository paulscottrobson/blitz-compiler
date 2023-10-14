# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		variables.py
#		Purpose :	Test variables
#		Date :		7th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

from tests import *
import random,sys

# *******************************************************************************************
#
#							Simple variable assignment test
#
# *******************************************************************************************

class TestVariables(TestScript):
	def initialisePhase(self):
		self.variables = {}
		for i in range(0,15):
			self.appendVariable(IFloat())
			self.appendVariable(IInteger())
			self.appendVariable(IString())

	def appendVariable(self,newVar):
		if newVar.getName() not in self.variables:
			self.variables[newVar.getName()] = newVar

	def addTest(self):
		for v in self.variables.values():
			v.updateValue()
			self.render(("let " if random.randint(0,1) == 0 else "")+v.assignment())
		
	def validatePhase(self):
		for v in self.variables.values():
			self.checkExpression(v.check())
TestVariables()		