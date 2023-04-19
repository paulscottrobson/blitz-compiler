100 gosub 1000
110 print "back"
120 gosub 1000
130 print 1/0
1000 print "hello world !"
1002 gosub 2000:gosub 2000
1010 return
2000 print ,"level 2",n 
2005 n = n+1
2010 return