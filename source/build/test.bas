10 a = 0:b = 1:c = 2
20 dim a1$(3),c(6),d%(1,5)
30 c(1) = 22/7:c(0) = 100:c(2) = 42.42
35 a1$(0) = "zero":a1$(3) = "three"+"!"
40 d%(0,0) = 40:d%(1,2) = 12
50 print c(0),c(1),c(2)
60 for i = 0 to 3:print i,a1$(i):next
70 print d%(0,0),d%(1,2)
80 stop
