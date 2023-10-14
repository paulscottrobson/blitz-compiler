# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		unary.py
#		Purpose :	Test unary operators 
#		Date :		6th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

from tests import *
import random,math

# *******************************************************************************************
#
#									Basic unary classes
#
# *******************************************************************************************

class TestUnary(TestScript):
	def addTest(self):
		n1 = self.getNumber()
		s1 = IString()
		s1.updateValue()
		s1 = s1.getValue()
		i1 = random.randint(-32760,32760)
		a1 = random.randint(-1000,1000)/100
		#
		#		Standard functions
		#
		self.checkEqual("abs({0})".format(n1),-n1 if n1 < 0 else n1)	
		c = random.randint(64,96)
		self.checkEqual("asc(\"{0}\")".format(chr(c)),c)
		self.checkStringEqual("chr$({0})".format(c),'"'+chr(c)+'"')
		self.checkEqual('len("{0}")'.format(s1),len(s1))
		self.checkEqual('not({0})'.format(i1),-i1-1)
		sign1 = 0
		if n1 != 0:
			sign1 = -1 if n1 < 0 else 1
		self.checkEqual('sgn({0})'.format(n1),sign1)
		int1 = math.floor(n1)
		self.checkEqual('int({0})'.format(n1),int1)
		self.checkEqual('val(str$({0}))'.format(n1),n1)
		#
		#		Slicing functions
		#		
		c1 = random.randint(0,len(s1)+2)
		p1 = random.randint(1,len(s1)+2)
		self.checkStringEqual('left$("{0}",{1})'.format(s1,c1),'"'+s1[:c1]+'"')
		self.checkStringEqual('right$("{0}",{1})'.format(s1,c1),'"'+s1[max(0,len(s1)-c1):]+'"')
		self.checkStringEqual('mid$("{0}",{1})'.format(s1,p1),'"'+s1[p1-1:]+'"')
		self.checkStringEqual('mid$("{0}",{1},{2})'.format(s1,p1,c1),'"'+s1[p1-1:][:c1]+'"')
		#
		#		Polynomial functions
		#
		self.checkAreNearlyEqual("sin({0:.5f})".format(a1),math.sin(a1))
		self.checkAreNearlyEqual("cos({0:.5f})".format(a1),math.cos(a1))
		a2 = random.randint(10,40) / 100.0	
		self.checkAreNearlyEqual("tan({0:.5f})".format(a2),math.tan(a2))
		a3 = random.randint(100,900) / 1000 + random.randint(0,1)
		self.checkAreNearlyEqual("atn({0:.5f})".format(a3),math.atan(a3))
		n2 = random.randint(-200,200)/100
		self.checkAreNearlyEqual("exp({0:.5f})".format(n2),math.exp(n2))
		n3 = random.randint(10,10000)/100
		self.checkAreNearlyEqual("log({0:.5f})".format(n3),math.log(n3,math.e))
		n4 = abs(n1)
		self.checkAreNearlyEqual("sqr({0:.5f})".format(n4),math.sqrt(n4))

TestUnary()		

# left$ right$ mid$ 

	# 	if op == "sqr":
	# 		return math.fabs(n)
	# 	return n

	# @staticmethod
	# def ln(n):
	# 	return math.log(n,math.e)
