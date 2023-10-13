# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		arrays.py
#		Purpose :	Test arrays
#		Date :		7th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

from tests import *
import random,sys

# *******************************************************************************************
#
#								  Array testing class
#
# *******************************************************************************************

class TestArray(object):
	def __init__(self,dimension = 1):
		ext = 12 if dimension == 1 else 4
		self.dim = [random.randint(2,ext) for i in range(0,dimension)]
		self.depth = dimension
		self.elements = {}
		self.name = self.elementFactory().getName()

	def getName(self):
		return self.name 

	def create(self):
		return "dim {0}({1})".format(self.getName(),",".join([str(d) for d in self.dim]))

	def update(self):
		newValue = self.elementFactory()
		newValue.updateValue()
		index = ",".join([str(random.randint(0,self.dim[d])) for d in range(0,self.depth)])
		self.elements[index] = newValue
		return self.getName()+"("+index+") = "+newValue.render()

	def validate(self,out):
		k = [x for x in self.elements.keys()]
		k.sort()
		for x in k:
			out.checkExpression("{0}({1}) <> {2}".format(self.getName(),x,self.elements[x].render()))

class StringArray(TestArray):
	def  elementFactory(self):
		return IString()

class IntegerArray(TestArray):
	def  elementFactory(self):
		return IInteger()

class FloatArray(TestArray):
	def  elementFactory(self):
		return IFloat()

# *******************************************************************************************
#
#										Arrays test
#
# *******************************************************************************************

class TestArrays(TestScript):
	def initialisePhase(self):
		self.charsLeft = 4096
		self.arrays = {}
		for i in range(0,3):
			self.appendArray(FloatArray(self.getDimensions()))
			self.appendArray(IntegerArray(self.getDimensions()))
			self.appendArray(StringArray(self.getDimensions()))

		for v in self.arrays.values():
			self.render(v.create())

	def getDimensions(self):
		return 1 if random.randint(0,3) != 0 else 2

	def appendArray(self,newVar):
		if newVar.getName() not in self.arrays:
			self.arrays[newVar.getName()] = newVar

	def addTest(self):
		for v in self.arrays.values():
			self.render(v.update())
		
	def validatePhase(self):
		for v in self.arrays.values():
			v.validate(self)

TestArrays()		