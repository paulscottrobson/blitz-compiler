# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		floats.py
#		Purpose :	Float conversion/display classe
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,math
#from usedump import *

# *******************************************************************************************
#
#									Float conversion class
#
# *******************************************************************************************

class Float(object):
	#
	#		Convert decimal to a 3 part 
	#
	def toFloat(self,decimal,normalise = True):
		if decimal == 0:
			return [0,0,0]
		sign = 0x80 if decimal < 0 else 0x00
		decimal = abs(decimal)

		if normalise or decimal != int(decimal) or abs(decimal) >= 0x7FFFFFFF:
			exponent = int(math.log(decimal,2))
			mantissa = decimal / pow(2,exponent)
			while mantissa < 0x40000000:
				mantissa *= 2 
				exponent -= 1
			mantissa = int(mantissa+0.5)
		else:
			exponent = 0
			mantissa = int(decimal)

		return [mantissa,exponent & 0xFF,sign]
	#
	#		Convert a 3 part to a decimal
	#
	def toDecimal(self,f):
		n = f[0] * pow(2,f[1] if f[1] < 128 else f[1]-256)
		return n if (f[2] & 0x80) == 0 else -n

if __name__ == "__main__":
	f = Float()
	#
	#		Basic conversion checking
	#
	for c in [3.14159,42,42000,0.000001234,123456789.987]:
		x = f.toFloat(c,False)
		n = f.toDecimal(x)
		print("{0:<16} {1:16} {2}".format(c,str(x),n))

