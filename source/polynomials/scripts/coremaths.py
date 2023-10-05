# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		coremaths.py
#		Purpose :	Mathematical functions (Polynomial Evaluations)
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,re,random,math

# *******************************************************************************************
#
#										Polynomial class
#
# *******************************************************************************************

class Polynomial(object):
	def __init__(self,s):
		self.coefficients = []
		self.additive = 0.0
		for c in [x.strip() for x in s.split("|") if x.strip() != ""]:
			if c.find("^") >= 0:
				self.coefficients.append(float(c.split("^")[0]))
			else:
				self.additive = float(c)

	def hornerMethod(self,x,track = False):
		if track:
			print("X is {0}\n".format(x))
		n = 0 
		step = 1
		for c in self.coefficients:
			if track:
				print("Step {0}".format(step))
				print("\tCoefficient {0:.6f} Input {1:.6f} Output {2:.6f}".format(c,n,n*x+c))
				step += 1
			n = n * x + c
		return n 

# *******************************************************************************************
#
#									Parent abstract class
#
# *******************************************************************************************

class Evaluator(object):
	def test(self):	
		for n in range(0,0):
			if n == 0:
				print()
			x = self.get()
			e1 = abs(self.real(x)-self.eval(x))/self.real(x)*100
			pe = self.polyEvaluate(x)
			e2 = abs(self.real(x)-pe)/self.real(x)*100
			print("{0:.4f} {1:.4f} {2:.4f} {3:.4f}% {4:.4f} {5:.4f}%".format(x,self.real(x),self.eval(x), abs(e1),pe,abs(e2)))
			assert abs(e1)+abs(e2) < 4e-06,str(abs(e1)+abs(e2))
		return self

	def eval(self,x):
		return eval(self.evalString())

	def getCoefficients(self):
		parts = re.split("(\\*\\s*pow\\(x,\\d+\\))",self.evalString())
		for i in range(0,len(parts)):
			if parts[i].startswith("*"):
				m = re.search("\\,(\\d+)",parts[i])
				assert m is not None
				parts[i] = "^{0}|".format(m.group(1))
		s = "".join(parts).replace(" ","").replace("\t","").replace("*x","^1|").replace("+x","+1^1")
		return Polynomial(s)

	def polyEvaluate(self,x,track = False):
		p = self.getCoefficients()
		return p.hornerMethod(x*x,track) * x + p.additive

	def convert(self,decimal):
		if decimal == 0:
			return [0,0]
		exponent = int(math.log(decimal,2))
		mantissa = decimal / pow(2,exponent)
		while mantissa < 0x40000000:
			mantissa *= 2 
			exponent -= 1
		mantissa = int(mantissa+0.5)
		return [mantissa,exponent & 0xFF]

	def dump(self,h,name):
		p = self.getCoefficients()
		h.write("\n{0}Coefficients:\n".format(name))
		h.write("\t.byte\t{0}\n".format(len(p.coefficients)))
		for c in p.coefficients:		
			self.dumpWord(h,c)
		self.dumpWord(h,p.additive)

	def dumpWord(self,h,c):
		n = self.convert(abs(c))
		n[0] = n[0] if c >= 0 else (n[0]|0x80000000)
		h.write("\t.dword\t${0:08x} ; {1}\n".format(n[0],c))
		h.write("\t.byte\t${0:02x}\n".format(n[1]))

# *******************************************************************************************
#
#										Calculate 2^x
#
# *******************************************************************************************

class Exp(Evaluator):
	def evalString(self):
		return "2.1498763701e-5 * pow(x,7) + 1.4352314037e-4 * pow(x,6) + 1.3422634825e-3 * pow(x,5) + 9.6140170135e-3 * pow(x,4) + \
								5.5505126860e-2 * pow(x,3) + 0.24022638460 * pow(x,2) + 0.69314718618 * x + 1.0"
	def get(self):
		return random.randint(1,999) / 1000.0

	def real(self,x):
		return pow(2,x)

	def polyEvaluate(self,x,track = False):
		p = self.getCoefficients()
		return p.hornerMethod(x,track) * x + p.additive

# *******************************************************************************************
#
#										Calculate Sin()
#
# *******************************************************************************************

class Sin(Evaluator):
	def evalString(self):
		return "-14.381390672 * pow(x,11) + 42.007797122 * pow(x,9) - 76.704170257 * pow(x,7) + 81.605223686 * pow(x,5) \
																				- 41.341702104 * pow(x,3) + 6.2831853069 * x"
	def get(self):
		return random.randint(1,999) / 4000.0

	def real(self,x):
		x1 = x * 2 * math.pi
		return math.sin(x1)

# *******************************************************************************************
#
#										Calculate Log(2)
#
# *******************************************************************************************

class Log(Evaluator):
	def evalString(self):
		return "0.43425594189 * pow(x,7) + 0.57658454124 * pow(x,5) + 0.96180075919 * pow(x,3) + 2.8853900731 * x - 0.5"

	def get(self):
		n = random.randint(-1700,1700) / 10000.0
		return n if n != 0 else self.get()

	def real(self,x):
		x1 = math.sqrt(2)/(1 - x) - math.sqrt(0.5)
		return math.log(x1,2)

# *******************************************************************************************
#
#										Calculate Atn()
#
# *******************************************************************************************

class Atn(Evaluator):
	def evalString(self):
		return "-6.8479391189e-4 * pow(x,23) + 4.8509421558e-3 * pow(x,21) - 1.6111701843e-2 * pow(x,19) + 3.4209638048e-2 * pow(x,17) \
								- 5.4279132761e-2 * pow(x,15) + 7.2457196540e-2 * pow(x,13) - 8.9802395378e-2 * pow(x,11) \
								+ 0.11093241343 * pow(x,9)- 0.14283980767 * pow(x,7) + 0.19999912049 * pow(x,5) - 0.33333331568 * pow(x,3) + x"

	def get(self):
		n = random.randint(-999,999) / 1000.0
		return n if n != 0 else self.get()

	def real(self,x):
		return math.atan(x)

if __name__ == "__main__":
	h = open("source/generated/coefficients.asm","w")
	h.write(";\n;\tAutomatically generated.\n;\n")
	h.write("\t.section code\n")
	Exp().test().dump(h,"Exp")
	Sin().test().dump(h,"Sin")
	Log().test().dump(h,"Log")
	Atn().test().dump(h,"Atn")
	h.write("\t.send code\n")
	h.close()