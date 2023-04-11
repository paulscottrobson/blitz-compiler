# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		fullmaths.py
#		Purpose :	Mathematical functions (Processed Polynomial Evaluations)
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,re,random,math
from coremaths import *

# *******************************************************************************************
#
#							Split into mantissa and exponent
#
# *******************************************************************************************

def convert(decimal):
	exponent = int(math.log(decimal,2))
	mantissa = decimal / pow(2,exponent)
	while mantissa < 0x40000000:
		mantissa *= 2 
		exponent -= 1
	mantissa = int(mantissa+0.5)
	return [mantissa,exponent]

# *******************************************************************************************
#
#									Parent abstract class
#
# *******************************************************************************************

class FullEvaluator(object):
	def __init__(self):
		self.coreObject = self.coreObject()

	def coreEvaluate(self,x):
		return self.coreObject.polyEvaluate(x)

	def test(self,n = 100,showAll = False):
		for c in range(0,n):
			x = self.getX()
			correct = self.correct(x)
			calc = self.calculate(x)
			error = 0 if correct == calc else abs(100*abs(correct-calc)/correct)
			if showAll or error >= 0.00002:
				print("X:{0:.6f} f(X):{1:.6f} c(X):{2:.6f} E:{3:.6f}%".format(x,correct,calc,error))
			
	def getX(self):
		return random.randint(-499,499)/100

# *******************************************************************************************
#
#										SIN() function
#
# *******************************************************************************************

class FullSin(FullEvaluator):
	def coreObject(self):
		return Sin()

	def correct(self,x):
		return math.sin(x)

	def calculate(self,x):
		sign = -1 if x < 0 else 1 									# remove sign
		x = abs(x) 														
		x = x / (2 * math.pi)  										# divide by 2.PI
		f = x - int(x) 												# get fractional part

		f2 = f 														# which to use.
		if f >= 0.25 and f < 0.75: 									# different ranges of f
			f2 = 0.5-f
		if f >= 0.75:
			f2 = f - 1

		return sign * self.coreEvaluate(f2)

# *******************************************************************************************
#
#										COS() function
#
# *******************************************************************************************

class FullCos(FullSin):
	def calculate(self,x):
		return FullSin.calculate(self,x+math.pi/2) 					# Cos just adds PI/2
	def correct(self,x):
		return math.cos(x)

# *******************************************************************************************
#
#										TAN() function
#
# *******************************************************************************************

class FullTan(FullEvaluator):
	def coreObject(self):
		return None

	def __init__(self):
		FullEvaluator.__init__(self)
		self.sinFunc = FullSin()
		self.cosFunc = FullCos()

	def calculate(self,x):
		return self.sinFunc.calculate(x) / self.cosFunc.calculate(x)	# tan is just sin/cos
	def correct(self,x):
		return math.tan(x)

# *******************************************************************************************
#
#										ATN() function
#
# *******************************************************************************************

class FullAtn(FullEvaluator):
	def coreObject(self):
		return Atn()

	def calculate(self,x):
		sign = -1 if x < 0 else 1 									# remove sign
		x = abs(x) 														
		if x > 1.0: 												# if x > 1.0 use this identity.
			r = math.pi/2 - self.coreEvaluate(1.0/x)
		else: 														# x = [0..1]
			r = self.coreEvaluate(x)
		return r * sign

	def correct(self,x):
		return math.atan(x)

# *******************************************************************************************
#
#										EXP() function
#
# *******************************************************************************************

class FullExp(FullEvaluator):
	def coreObject(self):
		return Exp()

	def calculate(self,x):
		t = x  * math.log(math.e,2.0) 								# multiply by log2(e)

		tf = abs(t - int(t))										# fractional part.
		ti = abs(int(t))

		if t < 0:
			tf = 1-tf
			n = -(ti+1)												# integer part
			fracPower = self.coreEvaluate(tf) 						# 2 ^ fractional part
		else:
			fracPower = self.coreEvaluate(tf) 						# 2 ^ fractional part
			n = ti

		return fracPower * pow (2,n) 								# Adjust exponent appropriately.

	def correct(self,x):
		return math.exp(x)

# *******************************************************************************************
#
#										LOG() function
#
# *******************************************************************************************

class FullLog(FullEvaluator):
	def coreObject(self):
		return Log()

	def calculate(self,x):
		parts = convert(x) 											# Split into mantissa/exponent - already is (!)
		mantissa = parts[0] / pow(2,31)						
		exponent = parts[1] + 31
		
		remix = mantissa * pow(2,exponent) 							# check it.
		assert abs(remix-x) < 0.000001 and mantissa >= 0.5 and mantissa < 1.0 and exponent == int(exponent)

		t = 1.0 - math.sqrt(2.0) / (mantissa + math.sqrt(0.5)) 		# do the pre-calc
		l2 = self.coreEvaluate(t) 									# feed to core
		l2 = l2 + exponent 											# add exponent
		print(l2,exponent,math.log(2,math.e))
		return l2 * math.log(2,math.e) 								# and multiply by log2 e

	def correct(self,x):
		return math.log(x,math.e)

	def getX(self):
		return random.randint(0,100000) / 1234.0

if __name__ == "__main__" and False:
		FullSin().test()
		FullCos().test()
		FullTan().test()
		FullAtn().test()
		FullExp().test()
		FullLog().test()

#	for i in range(20,620,50):
#		x = convert(i/100)
#		print("{0:.2f} ${1:08x} ${2:02x} f(x):{3} {4:.3f}".format(i/100,x[0],x[1] & 0xFF,math.sin(i/100),i/100/2/math.pi))	

print(math.log(100))
print(FullLog().calculate(100))