# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		binary.py
#		Purpose :	Test binary operators (not comparison)
#		Date :		5th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

from tests import *
import random

class TestBinary(TestScript):
	def addTest(self):
		n1 = random.randint(0,5)
		n2 = random.randint(0,5)
		self.checkExpression(self.areEqual("{0}+{1}".format(n1,n2,),n1+n2))

TestBinary()		