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

import random,re,os,sys,math

# *******************************************************************************************
#
#									Base class
#
# *******************************************************************************************

class CodeTestGenerator(object):
	def __init__(self,sources):
		self.sources = sources.upper()
		self.selectSource()

	def randomInt(self):
		return random.randint(-30000,30000)

	def randomFloat(self):
		return random.randint(-1000000,1000000)/12347	

	def randomString(self):
		return "".join([chr(random.randint(0,25)+97) for x in range(0,random.randint(0,5))])

	def format(self,s):
		if isinstance(s,str):
			return '"'+s+'"'
		if isinstance(s,float):
			return "{0:.4f}".format(s)
		if isinstance(s,int):
			return str(s)
		assert False

	def selectSource(self):
		self.current = self.sources[random.randint(0,len(self.sources)-1)]

	def generate(self):
		if self.current == "I":
			return self.randomInt()
		if self.current == "F":
			return self.randomFloat()
		if self.current == "S":
			return self.randomString()
		assert False

	def create(self):
		assert False

	def getOperation(self):
		return self.operationList[random.randint(0,len(self.operationList)-1)]

	def evaluate(self,s):
		return eval(s) 

	def fudge(self,n,op):
		return n

	def check(self,r = 0.01,ttype = None):
		ttype = self.current if ttype is None else ttype
		if ttype == "I":
			return "f.cmp = "
		if ttype == "F":
			return "- abs {0} f.cmp < ".format(self.format(r))
		assert False 

# *******************************************************************************************
#
# 									Base Unary class
#
# *******************************************************************************************

class UnaryTestGenerator(CodeTestGenerator):
	def __init__(self,sources):
		CodeTestGenerator.__init__(self,sources)
		self.operations = self.getOperations()
		self.operationList = [x for x in self.operations.keys()]

	def create(self):
		op = self.getOperation()
		n = self.fudge(self.generate(),op)
		r = self.evaluate("{0}({1})".format(self.operations[op],self.format(n)))
		return "{0} {1} {2} {3}".format(self.format(n),op,self.format(r),self.check())

# *******************************************************************************************
#
#				Test for the polynomial and associated functions, except power
#
# *******************************************************************************************

class FloatFunctionUnaryTestGenerator(UnaryTestGenerator):
	def __init__(self):
		UnaryTestGenerator.__init__(self,"F")

	def getOperations(self):
		return { "sin":"math.sin","cos":"math.cos","tan":"math.tan","atn":"math.atan",
				 "exp":"math.exp","log":"FloatFunctionUnaryTestGenerator.ln",
				 "sqr":"math.sqrt","int":"math.floor"
			   }

	def fudge(self,n,op):
		if op == "tan":
			return random.randint(10,40) / 100.0
		if op == "atn":
			return random.randint(100,900) / 1000 + random.randint(0,1)
		if op == "exp":
			return random.randint(-200,200)/100
		if op == "log":
			return random.randint(10,10000)/100
		if op == "sqr":
			return math.fabs(n)
		return n

	@staticmethod
	def ln(n):
		return math.log(n,math.e)

# *******************************************************************************************
#
#								Most of the unary functions
#
# *******************************************************************************************

class FunctionUnaryTestGenerator(UnaryTestGenerator):
	def __init__(self):
		UnaryTestGenerator.__init__(self,"IF")

	def getOperations(self):
		return { "abs":"FunctionUnaryTestGenerator.abs",
				 "asc":"ord",
				 "sgn":"FunctionUnaryTestGenerator.sgn",
				 "not":"FunctionUnaryTestGenerator.unot",
				 "val":"float",
				 "len":"len",
				 "str$ val":"FunctionUnaryTestGenerator.valstr",
				 "chr$ asc":"FunctionUnaryTestGenerator.chrasc"
		}

	def fudge(self,n,op):
		if op == "asc":
			self.current = "I"
			return chr(random.randint(64,90))
		if op == "sgn":
			self.current = "I"
		if op == "not":
			self.current = "I"
			return random.randint(-32768,32767)
		if op == "val":
			return self.format(n)
		if op == "len":
			self.current = "I"
			return self.randomString()
		if op == "chr$ asc":
			self.current = "I"
			return random.randint(32,127)
		return n

	@staticmethod
	def abs(n):
		return -n if n < 0 else n
	@staticmethod 
	def sgn(n):
		return 0 if n == 0 else (-1 if n < 0 else 1)
	@staticmethod 
	def unot(n):
		return -n+1
	@staticmethod
	def valstr(s):
		return s
	@staticmethod
	def chrasc(s):
		return s

# *******************************************************************************************
#
# 							String slice test generator
#
# *******************************************************************************************

class StringSliceTestGenerator(UnaryTestGenerator):
	def __init__(self):
		UnaryTestGenerator.__init__(self,"S")
		self.operations = self.getOperations()
		self.operationList = [x for x in self.operations.keys()]

	def create(self):
		op = self.getOperation()
		s = self.randomString()
		n1 = random.randint(1,len(s)+1)
		l1 = random.randint(0,len(s)+1)
		r = self.evaluate("{0}({1},{2},{3})".format(self.operations[op],self.format(s),n1,l1))
		return "{0} {1} {2} {3} {4} s.cmp = ".format(self.format(s),str(n1) if op == "mid$" else "",l1,op,self.format(r))

	def getOperations(self):
		return { 
			"left$": "StringSliceTestGenerator.left",
			"mid$": "StringSliceTestGenerator.mid",
			"right$": "StringSliceTestGenerator.right"
		}

	@staticmethod
	def left(s1,start,length):
		if length == 0:
			return ""
		return s1[:length]

	@staticmethod
	def right(s1,start,length):
		start = max(0,len(s1)-length)
		return s1[start:]

	@staticmethod
	def mid(s1,start,length):
		start -= 1
		if start >= len(s1):
			return ""
		return s1[start:start+length]

# *******************************************************************************************
#
# 									Base Binary class
#
# *******************************************************************************************

class BinaryTestGenerator(CodeTestGenerator):
	def __init__(self,sources):
		CodeTestGenerator.__init__(self,sources)
		self.operations = self.getOperations()
		self.operationList = [x for x in self.operations.keys()]



# *******************************************************************************************
#
# 									Number Binary class
#
# *******************************************************************************************

class NumberBinaryTestGenerator(BinaryTestGenerator):
	def __init__(self):
		BinaryTestGenerator.__init__(self,	"IF")

	def getOperations(self):
		return { 	"+":"+","-":"-","*":"*","/":"/" ,
					"^":"^",
					"and":"&","or":"|",
					"concat":"+"
		}

	def create(self):
		op = self.getOperation()

		if op == "concat":
			n = [self.randomString(),self.randomString()]
			return "{0} {1} concat {2} s.cmp = ".format(self.format(n[0]),self.format(n[1]),self.format(n[0]+n[1]))

		n = self.fudge([self.generate(),self.generate()],op)
		if op == "and" or op == "or":
			self.current = "I"
			n[0] = random.randint(-32768,32767)
			n[1] = random.randint(-32768,32767)
		if op == "^":
			n[0] = random.randint(1,1000)/300
			n[1] = random.randint(1,20)/10
			r = pow(n[0],n[1])
			self.current = "F"
		else:
			r = self.evaluate("{0} {1} {2}".format(self.format(n[0]),self.operations[op],self.format(n[1])))
		if abs(r) > 32768:
			self.current = "F"
		return "{0} {1} {2} {3} {4}".format(self.format(n[0]),self.format(n[1]),op,self.format(r),self.check())

	def fudge(self,np,op):
		if op == "/":
			self.current = "F"
			if np[1] == 0:
				np[1] = 2		
		return np

sources = [
			FunctionUnaryTestGenerator(),
			StringSliceTestGenerator(),
			FloatFunctionUnaryTestGenerator(),
			NumberBinaryTestGenerator()
]



for i in range(0,200):
	c = sources[random.randint(0,len(sources)-1)]
	c.selectSource()
	print("new.line " + c.create() + " assert")
print("exit")
