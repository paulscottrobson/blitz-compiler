10 for i = 1 to 10
20 print i
25 on i gosub 200,210,220
30 next
40 stop
110 print "Fail":return
200 print "200":return
205 stop
210 print "210":return
220 print "220":return
