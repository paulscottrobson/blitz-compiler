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

# *******************************************************************************************
#
#									Basic binary classes
#
# *******************************************************************************************

class TestBinary(TestScript):
	def addTest(self):
		#
		#		4 Functions for numbers.
		#
		n1 = self.getNumber()
		n2 = self.getNumber()
		self.checkEqual("{0}+{1}".format(n1,n2),n1+n2)
		self.checkEqual("{0}-{1}".format(n1,n2),n1-n2)
		self.checkAreNearlyEqual("{0}*{1}".format(n1,n2),n1*n2)
		if n2 != 0:
			self.checkAreNearlyEqual("{0}/{1}".format(n1,n2),n1/n2)
		#
		#		String concatentation.
		#
		s1 = IString()
		s1.updateValue()
		s2 = IString()
		s2.updateValue()
		self.checkStringEqual("{0}+{1}".format(s1.render(),s2.render()),'"'+s1.getValue()+s2.getValue()+'"')
		#
		#		And / Or
		#
		fnc = "and" if random.randint(0,1) == 0 else "or"
		n1 = random.randint(-0x7FFF,0x7FFF) & 0xFFFF
		n2 = random.randint(-0x7FFF,0x7FFF) & 0xFFFF
		r = (n1 & n2) if fnc == "and" else (n1 | n2)
		if (r & 0x8000) != 0:
			r = r - 0x10000
		self.checkEqual("({0} {2} {1})".format(n1,n2,fnc),r)
		
TestBinary()		