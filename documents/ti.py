#
#		TI stuff
#
import random

def decode(t):
	t = t // 60
	s = t % 60
	m = (t // 60) % 60
	h = (t // 3600) % 24
	return "{0:02}{1:02}{2:02}".format(h,m,s)

def encode(s):
	c = 0
	for i in range(0,6):
		c = c * (6 if (i % 2) == 0 else 10)
		c = c + int(s[i])
	return c * 60

for i in range(0,100):
	t = random.randint(0,23)*3600+random.randint(0,59)*60+random.randint(0,59)
	t = t * 60
	n = encode(decode(t))
	assert n == t

print("${0:x} {0}".format(encode("123456")))
print(decode(2717760))