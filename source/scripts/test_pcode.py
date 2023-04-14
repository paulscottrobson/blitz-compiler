# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		test_pcode.py
#		Purpose :	Generate pcode generator
#		Date :		14th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import random,re,os,sys

class PCodeTestGenerator(object):
	def __init__(self):
		pass

	def randomInt(self):
		return random.randint(-50000,50000)

	def randomFloat(self):
		return random.randint(-1000000,1000000)/12347	

	def randomString(self):
		return "".join([chr(random.randint(0,25)+97) for x in range(0,random.randint(0,5))])
