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
		s1 = VString()
		s1.updateValue()
		s2 = VString()
		s2.updateValue()
		self.checkStringEqual("{0}+{1}".format(s1.render(),s2.render()),'"'+s1.getValue()+s2.getValue()+'"')
TestBinary()		