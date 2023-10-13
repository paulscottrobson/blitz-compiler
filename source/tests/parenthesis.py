# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		parenthesis.py
#		Purpose :	Test parenthesis expressions
#		Date :		7th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

from tests import *
import random

# *******************************************************************************************
#
#								 Expression creator
#
# *******************************************************************************************

def CreateExpression(level):
	if level == 0:
		return str(random.randint(1,5))
	else:
		expr = ""
		for i in range(0,random.randint(2,4)):
			if i > 0:
				expr += ("+" if random.randint(0,1) == 0 else "*")
			expr += CreateExpression(level-1)
		return expr if random.randint(0,1) == 0 else "("+expr+")"

# *******************************************************************************************
#
#								Simple parenthesis test
#
# *******************************************************************************************

class TestParenthesis(TestScript):
	def addTest(self):
		expr = CreateExpression(3)
		r = eval(expr)
		if r < 0x1FFFFFF:
			self.checkEqual("({0})".format(expr),r)
		
TestParenthesis()		