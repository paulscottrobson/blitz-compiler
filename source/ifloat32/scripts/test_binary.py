# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		test_binary.py
#		Purpose :	Generate binary function code
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import random

def randomInt():
	return random.randint(-50000,50000)

def randomFloat():
	return random.randint(-1000000,1000000)/12347	

def randomString():
	return "".join([chr(random.randint(0,25)+97) for x in range(0,random.randint(0,5))])

for n in range(0,20):
	#
	n1 = randomInt()
	n2 = randomInt()
	print("{0}  {1} + {2} f.cmp = assert".format(n1,n2,n1+n2))
	if True:
		print("{0}  {1} - {2} f.cmp = assert".format(n1,n2,n1-n2))
		print("{0}  {1} * {2} f.cmp = assert".format(n1,n2,n1*n2))
		if n2 != 0 and True:
			print("{0}  {1} / {2:.8f} f.cmp = assert".format(n1,n2,n1/n2))

	if True:
		if random.randint(0,4):
			n1 = n2
		print("{0}  {1} f.cmp = {2} f.cmp = assert".format(n1,n2,-1 if n1 == n2 else 0))
		print("{0}  {1} f.cmp <> {2} f.cmp = assert".format(n1,n2,-1 if n1 != n2 else 0))
		print("{0}  {1} f.cmp > {2} f.cmp = assert".format(n1,n2,-1 if n1 > n2 else 0))
		print("{0}  {1} f.cmp >= {2} f.cmp = assert".format(n1,n2,-1 if n1 >= n2 else 0))
		print("{0}  {1} f.cmp < {2} f.cmp = assert".format(n1,n2,-1 if n1 < n2 else 0))
		print("{0}  {1} f.cmp <= {2} f.cmp = assert".format(n1,n2,-1 if n1 <= n2 else 0))


	if True:
		n1 = randomFloat()
		n2 = randomFloat()
		print("{0:.8f}  {1:.8f} + {2:.8f} f.cmp = assert".format(n1,n2,n1+n2))
		print("{0:.8f}  {1:.8f} - {2:.8f} f.cmp = assert".format(n1,n2,n1-n2))
		print("{0:.8f}  {1:.8f} * {2:.8f} f.cmp = assert".format(n1,n2,n1*n2))
		if n2 != 0:
			print("{0:.8f}  {1:.8f} / {2:.8f} f.cmp = assert".format(n1,n2,n1/n2))

	if True:
		n1 = randomFloat()
		n2 = randomFloat()
		if random.randint(0,4):
			n1 = n2
		print("{0:.8f}  {1:.8f} f.cmp > {2} f.cmp = assert".format(n1,n2,-1 if n1 > n2 else 0))
		print("{0:.8f}  {1:.8f} f.cmp >= {2} f.cmp = assert".format(n1,n2,-1 if n1 >= n2 else 0))
		print("{0:.8f}  {1:.8f} f.cmp < {2} f.cmp = assert".format(n1,n2,-1 if n1 < n2 else 0))
		print("{0:.8f}  {1:.8f} f.cmp <= {2} f.cmp = assert".format(n1,n2,-1 if n1 <= n2 else 0))
		print("{0:.8f}  {1:.8f} f.cmp = {2} f.cmp = assert".format(n1,n2,-1 if n1 == n2 else 0))
		print("{0:.8f}  {1:.8f} f.cmp <> {2} f.cmp = assert".format(n1,n2,-1 if n1 != n2 else 0))

