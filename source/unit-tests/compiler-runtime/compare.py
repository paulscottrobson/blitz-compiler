# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		compare.py
#		Purpose :	Test comparison operators
#		Date :		6th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

from tests import *
import random

# *******************************************************************************************
#
#									Basic binary classes
#
# *******************************************************************************************

class TestCompare(TestScript):
	def addTest(self):
		test = [ "=","<",">","<>",">=","<=" ]
		#
		if random.randint(0,2) != 0:
			n1 = self.getNumberClass()
			n2 = self.getNumberClass()
		else:
			n1 = IString()
			n2 = IString()
		n1.updateValue()
		n2.updateValue()	
		if random.randint(0,5) == 0:
			n1.setValue(n2.getValue())	
		operator = test[random.randint(0,5)]
		pyOperator = "==" if operator == "=" else operator.replace("<>","!=")
		result = -1 if eval(n1.render()+pyOperator+n2.render()) else 0
		self.checkEqual("({0}{2}{1})".format(n1.render(),n2.render(),operator),result)

TestCompare()		