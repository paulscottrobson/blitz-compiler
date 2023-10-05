# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		test_functions.py
#		Purpose :	Generate function test code
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import random,math

def randomFloat():
	return random.randint(-1000000,1000000)/12347	

for n in range(0,40):
	#
	a1 = random.randint(-2000,2000)/100

	if True:
		n1 = randomFloat()
		print("{0:.8f} negate {1:.8f} f.cmp = assert".format(n1,-n1))
		print("{0:.8f} int {1} f.cmp = assert".format(n1,int(n1)))

	if True:
		print("{0:.8f} sin {1:.8f} - abs 0.001 f.cmp < assert".format(a1,math.sin(a1)))
		print("{0:.8f} cos {1:.8f} - abs 0.001 f.cmp < assert".format(a1,math.cos(a1)))

	if True:
		a2 = random.randint(10,40) / 100 			# Test the basic mechanics here as not great
		print("{0:.8f} tan {1:.8f} - abs 0.001 f.cmp assert".format(a2,math.tan(a2)))

	if True:
		a2 = random.randint(100,900) / 1000 		# Test the basic mechanics here as not great
		a2 = a2 if random.randint(0,1) == 0 else a2+1
		print("{0:.8f} atn {1:.8f} - abs 0.001 f.cmp assert".format(a2,math.atan(a2)))

	if True:
		a2 = random.randint(-200,200)/100
		print("{0:.8f} exp {1:.8f} - abs 0.001 f.cmp assert".format(a2,pow(math.e,a2)))

	if True:
		a2 = random.randint(10,10000)/100
		print("{0:.8f} log {1:.8f} - abs 0.001 f.cmp assert".format(a2,math.log(a2,math.e)))

	if True:
		a2 = random.randint(10,10000)/100
		print("{0:.8f} sqr {1:.8f} - abs 0.001 f.cmp assert".format(a2,math.sqrt(a2)))

	if True:
		n1 = random.randint(1,1000)/300
		n2 = random.randint(1,20)/10
		print("{0:.8f} {1:.8f} ^ {2:.8f} - abs 0.01 f.cmp assert".format(n1,n2,pow(n1,n2)))
