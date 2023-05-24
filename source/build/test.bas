10 screen 128
20 for i = 0 to 100
25 frame 160-i,100-i,160+i,100+i,rnd(1)*256
28 next
29 for i = 1 to 50 step3 
30 char 100+i*2,100+i,2,"Hi !"
32 next
40 stop