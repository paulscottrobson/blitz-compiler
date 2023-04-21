10 t = ti
20 for i = 1 to 10000
30 gosub 100
60 next
70 print (ti-t)/60
80 stop
100 gosub 200
110 return
200 gosub 300
210 return
300 gosub 400
310 return
400 return